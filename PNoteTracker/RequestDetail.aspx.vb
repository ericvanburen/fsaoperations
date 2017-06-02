Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data.OleDb

Partial Class PNoteTracker_RequestDetail
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("PNoteTrackerConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim intRequestID = Request.QueryString("RequestID")
            lblRequestIDHolder.Text = intRequestID.ToString()

            BindForm(intRequestID)
        End If
    End Sub

    Sub GetStatusValue()
        Dim Status As String = ""

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
            Status = CType(dataItem.FindControl("ddlStatus"), DropDownList).SelectedValue
            lblPreviousStatusValue.Text = Status
        Next
    End Sub

    Sub BindForm(ByVal RequestID As Integer)
        Dim cmd As SqlCommand
        Dim da As SqlDataAdapter
        Dim ds As DataSet

        Dim strSQLConn As SqlConnection = New SqlConnection(connStr)
        cmd = New SqlCommand("p_BindRequestDetail", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@RequestID", RequestID)
        da = New SqlDataAdapter(cmd)
        strSQLConn.Open()
        ds = New DataSet()
        da.Fill(ds)

        Repeater1.DataSource = ds
        Repeater1.DataBind()

        'We need to get the Status value when the page loads to determine whether it has changed
        'when the user updates the form
        GetStatusValue()
    End Sub


    Sub ImageUpload_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim strInsert As String
        Dim cmdInsert As SqlCommand
        Dim UploadFileControl As Object
        Dim UploadMessage As Label
        If sender Is btnImage1Upload Then
            UploadFileControl = Image1Upload
            UploadMessage = lblUploadMessage1
        ElseIf sender Is btnImage2Upload Then
            UploadFileControl = Image2Upload
            UploadMessage = lblUploadMessage2
        ElseIf sender Is btnImage3Upload Then
            UploadFileControl = Image3Upload
            UploadMessage = lblUploadMessage3
        End If

        Dim con As SqlConnection = New SqlConnection(connStr)
        strInsert = "p_UploadImage"
        cmdInsert = New SqlCommand(strInsert)
        cmdInsert.CommandType = CommandType.StoredProcedure
        cmdInsert.Connection = con

        cmdInsert.Parameters.AddWithValue("@RequestID", SqlDbType.VarChar).Value = lblRequestIDHolder.Text

        Dim strFileNamePath As String = UploadFileControl.PostedFile.FileName

        If strFileNamePath.Length > 0 Then

            Dim strFileNameOnly As String
            Dim strSaveLocation As String

            'Append the agency value before the file name
            strFileNameOnly = System.IO.Path.GetFileName(UploadFileControl.PostedFile.FileName)

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(png|tiff|jpg|gif|pdf)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("invalid.filetype.aspx")
            End If

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\PNoteTracker\FileUploads\" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PNoteTracker\ImageUploads\" & strFileNameOnly
            UploadFileControl.PostedFile.SaveAs(strSaveLocation)
            cmdInsert.Parameters.Add("@FileName", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            cmdInsert.Parameters.Add("@FileName", SqlDbType.VarChar).Value = DBNull.Value
        End If
        Try
            con.Open()
            cmdInsert.ExecuteNonQuery()
            If strFileNamePath.Length > 0 Then
                UploadMessage.Text = "Your image was successfully uploaded"
            End If

            gvImages.DataBind()

            'We need to update the status to Prom Note Uploaded when an image is uploaded
            UpdateStatus()

        Finally
            con.Close()
        End Try

    End Sub

    Sub btnUpdateRequest_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim RequestID As Integer
        Dim FileHolder As String = ""
        Dim Request_Type As String = ""
        Dim Status As String = ""
        Dim Date_Request_Sent As String = ""
        Dim Comments As String = ""

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
            RequestID = CType(dataItem.FindControl("lblRequestID"), Label).Text
            FileHolder = CType(dataItem.FindControl("ddlFileHolder"), DropDownList).SelectedValue
            Request_Type = CType(dataItem.FindControl("ddlRequest_Type"), DropDownList).SelectedValue
            Status = CType(dataItem.FindControl("ddlStatus"), DropDownList).SelectedValue
            Date_Request_Sent = CType(dataItem.FindControl("txtDate_Request_Sent"), TextBox).Text
            Comments = CType(dataItem.FindControl("txtComments"), TextBox).Text
        Next
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PNoteTrackerConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateRequest", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@RequestID", RequestID)
        If FileHolder.Length > 0 Then
            'cmd.Parameters.Add("@FileHolderID", FileHolder)
            cmd.Parameters.Add("@FileHolder", SqlDbType.VarChar).Value = FileHolder
        Else
            'cmd.Parameters.AddWithValue("@FileHolderID", FileHolder)
            cmd.Parameters.Add("@FileHolder", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@Request_Type", Request_Type)
        cmd.Parameters.AddWithValue("@Status", Status)

        'We need to compare the Status from when the page was loaded with the Status value
        'as being updated. If different, we need to insert a value into the Pnote request history table
        If Status <> lblPreviousStatusValue.Text Then
            dsRequestHistory.InsertParameters("RequestID").DefaultValue = RequestID
            dsRequestHistory.InsertParameters("Status").DefaultValue = Status
            dsRequestHistory.InsertParameters("StatusChangeDate").DefaultValue = Date.Today
            dsRequestHistory.Insert()
        End If

        If Date_Request_Sent.Length > 0 Then
            cmd.Parameters.Add("@Date_Request_Sent", SqlDbType.DateTime).Value = Date_Request_Sent
        ElseIf ddlStatus.SelectedValue = "Requested Docs" AndAlso Date_Request_Sent.Length = 0 Then
            cmd.Parameters.Add("@Date_Request_Sent", SqlDbType.DateTime).Value = Now.Date
        Else
            cmd.Parameters.Add("@Date_Request_Sent", SqlDbType.DateTime).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@Comments", Comments)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.ForeColor = Drawing.Color.Green
            lblRecordStatus.Text = "Your record was successfully updated"

            'Update the history table
            grdRequestHistory.DataBind()

        Catch ex As Exception
            lblRecordStatus.Text = ex.ToString()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub UpdateStatus()
        dsPNoteRequests.UpdateParameters("RequestID").DefaultValue = lblRequestIDHolder.Text
        dsPNoteRequests.UpdateParameters("Status").DefaultValue = "Prom Note Uploaded"
        dsPNoteRequests.Update()
    End Sub



End Class
