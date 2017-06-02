Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.IO

Partial Class PNoteTracker_Default
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("PNoteTrackerConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            DeleteOldRecords()
            'BindData()
        End If
    End Sub


    Sub UploadFile_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim strFileNamePath As String = fileuploadExcel.PostedFile.FileName

        If strFileNamePath.Length > 0 Then

            Dim strFileNameOnly As String
            Dim strSaveLocation As String

            strFileNameOnly = System.IO.Path.GetFileName(fileuploadExcel.PostedFile.FileName)

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(.*?)\.(xls|xlsx)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("invalid.filetype.aspx")
            End If

            'strSaveLocation = "d:\DCS\fsaoperations\internal\PNoteTracker\FileUploads\" & strFileNameOnly
            strSaveLocation = "C:\Users\Acer\Dropbox\fsaoperations\PNoteTracker\FileUploads\" & strFileNameOnly
            Try
                fileuploadExcel.PostedFile.SaveAs(strSaveLocation)
                ImportFile()
                'Catch ex As Exception
                'lblMessage.Text = "Your file import failed with error message" & ex.Message
            Finally

            End Try
        End If
    End Sub

    Sub ImportFile()
        If fileuploadExcel.FileName <> "" Then
            Dim path = fileuploadExcel.PostedFile.FileName
            Dim tableName As String = "Pnote_Requests_Upload"
            Dim extension As String = System.IO.Path.GetExtension(fileuploadExcel.PostedFile.FileName)
            Dim excelConnectionString As String
            Dim conn As SqlConnection = New SqlConnection(connStr)

            'If extension = ".xls" Then
            'excelConnectionString = "Provider=ACE.OLEDB.12.0.OLEDB.4.0;Data Source=d:\DCS\fsaoperations\internal\PNoteTracker\FileUploads\pnote_requests.xls;Extended Properties=Excel 8.0;Persist Security Info=False"
            excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Acer\Dropbox\fsaoperations\PNoteTracker\FileUploads\pnote_requests.xls;Extended Properties=Excel 8.0;Persist Security Info=False"
            'ElseIf extension = ".xlsx" Then
            'excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath(path) & ";Extended Properties=Excel 12.0;Persist Security Info=False"
            'End If

            Dim excelConnection As OleDbConnection = New OleDbConnection(excelConnectionString)
            conn.Open()

            Dim comm As SqlCommand = New SqlCommand("truncate table " & tableName, conn)

            'Dim identityChange As SqlCommand = conn.CreateCommand()
            'identityChange.CommandText = "SET IDENTITY_INSERT " & tableName & " ON"

            Dim cmd As OleDbCommand = New OleDbCommand("SELECT BorrowerNumber, AccountID, FileHolder, Tag_Date, Tag FROM [Sheet1$]", excelConnection)
            excelConnection.Open()

            Dim dr As OleDbDataReader
            dr = cmd.ExecuteReader()
            'identityChange.ExecuteNonQuery()

            Dim sqlBulk As SqlBulkCopy = New SqlBulkCopy(connStr)

            'Set the destination table name
            sqlBulk.DestinationTableName = tableName
            sqlBulk.WriteToServer(dr)
            excelConnection.Close()
            excelConnection.Dispose()
            conn.Close()
            lblMessage.ForeColor = Drawing.Color.Green
            lblMessage.Text = "Import was successful!<br />"

            'Now copy the records from table Pnote_Requests_Upload to Pnote_Requests
            CopyNewRecords()

            'Show the new records in the GridView
            gvdetails.DataBind()

        Else
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Text = "Please select Excel file to upload"
        End If
    End Sub

    Sub btnUpdateStatus_Click(ByVal sender As Object, ByVal e As EventArgs)
        FindCheckedRows()
        gvdetails.AllowPaging = False
        gvdetails.AllowSorting = False
        gvdetails.DataBind()
        gvdetails.AllowPaging = True
        gvdetails.AllowSorting = True
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In gvdetails.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        dsPNoteRequests.UpdateParameters("RequestID").DefaultValue = rowIndex
                        dsPNoteRequests.Update()

                        dsPNoteRequestsHistory.InsertParameters("RequestID").DefaultValue = rowIndex
                        dsPNoteRequestsHistory.InsertParameters("Status").DefaultValue = ddlStatus.SelectedValue
                        dsPNoteRequestsHistory.InsertParameters("StatusChangeDate").DefaultValue = Date.Today
                        dsPNoteRequestsHistory.Insert()
                    End If
                End If
            Next
        End If

        'Show the updated status values in the GridView
        gvdetails.DataBind()
       
    End Sub

    Sub btnDeleteRequest_Click(ByVal sender As Object, ByVal e As EventArgs)
        FindCheckedRows()
        gvdetails.AllowPaging = False
        gvdetails.AllowSorting = False
        gvdetails.DataBind()
        gvdetails.AllowPaging = True
        gvdetails.AllowSorting = True
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In gvdetails.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        dsPNoteRequests.DeleteParameters("RequestID").DefaultValue = rowIndex
                        dsPNoteRequests.Delete()

                        dsPNoteRequestsHistory.InsertParameters("RequestID").DefaultValue = rowIndex
                        dsPNoteRequestsHistory.InsertParameters("Status").DefaultValue = "Deleted"
                        dsPNoteRequestsHistory.InsertParameters("StatusChangeDate").DefaultValue = Date.Today
                        dsPNoteRequestsHistory.Insert()
                    End If
                End If
            Next
        End If

        'Show the updated status values in the GridView
        gvdetails.DataBind()

    End Sub

    Protected Sub gvDetails_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        gvdetails.PageIndex = e.NewPageIndex
        FindCheckedRows()
        'BindData()
    End Sub

    Sub DeleteOldRecords()
        'Deletes old records from table Pnote_Requests_Upload
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Delete_PNote_Requests_Upload"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            lblMessage.Text = ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        Finally
            strConnection.Close()
        End Try
    End Sub

    Sub CopyNewRecords()
        'Copies records from table Pnote_Requests_Upload to Pnote_Requests
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Insert_PNote_Requests"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            lblMessage.Text = ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        Finally
            strConnection.Close()
        End Try
    End Sub

    Protected Sub btnExportToExcel_Click(sender As Object, e As EventArgs)
        FindCheckedRows()
        gvdetails.ShowHeader = True
        gvdetails.GridLines = GridLines.Both
        gvdetails.AllowPaging = False
        gvdetails.AllowSorting = False
        gvdetails.DataBind()
        gvdetails.HeaderRow.Cells.RemoveAt(0)
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In gvdetails.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        gvRow.Visible = True
                        gvRow.Cells(0).Visible = False
                    End If
                End If
            Next
        End If
        'ChangeControlsToValue(gvdetails)
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=PNote_Requests_" & Today() & ".xls")
        Response.ContentType = "application/excel"
        Dim sWriter As New StringWriter()
        Dim hTextWriter As New HtmlTextWriter(sWriter)
        Dim hForm As New HtmlForm()
        gvdetails.Parent.Controls.Add(hForm)
        hForm.Attributes("runat") = "server"
        hForm.Controls.Add(gvdetails)
        hForm.RenderControl(hTextWriter)
        Response.Write(sWriter.ToString())
        Response.End()
    End Sub

    Private Sub FindCheckedRows()
        Dim checkedRowsList As ArrayList
        If ViewState("checkedRowsList") IsNot Nothing Then
            checkedRowsList = DirectCast(ViewState("checkedRowsList"), ArrayList)
        Else
            checkedRowsList = New ArrayList()
        End If

        For Each gvRow As GridViewRow In gvdetails.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)

                If (chkSelect.Checked) AndAlso (Not checkedRowsList.Contains(rowIndex)) Then
                    checkedRowsList.Add(rowIndex)
                ElseIf (Not chkSelect.Checked) AndAlso (checkedRowsList.Contains(rowIndex)) Then
                    checkedRowsList.Remove(rowIndex)
                End If
            End If
        Next

        ViewState("checkedRowsList") = checkedRowsList
    End Sub

    Protected Sub gvDetails_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)
            Dim gvRow As GridViewRow = e.Row
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)
                Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))

                If checkedRowsList.Contains(rowIndex) Then
                    chkSelect.Checked = True
                End If
            End If
        End If
    End Sub

End Class
