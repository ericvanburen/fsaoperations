Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_DataRequests
    Inherits System.Web.UI.Page

    Protected Function GetRoleUsers() As String()
        Return Roles.GetUsersInRole("PCAReviews")
    End Function

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only authorized users can access this page
            If Roles.IsUserInRole("PCAReviews_Admins") = False And Roles.IsUserInRole("PCAReviews_DataRequests") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            Dim intPCAID As Integer = 0
            Dim strReviewPeriod As String = ""

            If Not Request.QueryString("PCAID") Is Nothing Then
                intPCAID = Request.QueryString("PCAID")
            Else
                intPCAID = 0
            End If

            If Not Request.QueryString("ReviewPeriod") Is Nothing Then
                strReviewPeriod = Server.UrlDecode(Request.QueryString("ReviewPeriod"))
            End If

            ViewState("Filter") = "All"
            BindGrid()
        End If

    End Sub


    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'We want to disable a row if there is no value for DataRequestID (column 0)
            Dim strDataRequestID As String = e.Row.Cells(0).Text
            If String.IsNullOrEmpty(strDataRequestID) OrElse strDataRequestID = "&nbsp;" Then
                e.Row.Enabled = False
            End If
        End If

        If GridView1.HeaderRow IsNot Nothing Then
            Dim ddlReviewPeriod As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlReviewPeriod"), DropDownList)
            ddlReviewPeriod.Items.FindByValue(ViewState("Filter").ToString()).Selected = True
        End If

    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim intDataRequestID As Integer = GridView1.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(intDataRequestID)

        End If
    End Sub

    Protected Sub GridView2_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As String = e.CommandArgument
            Dim strPCA As String = GridView2.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#newRecordModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the new record modal
            LoadNewRequestModal(strPCA)
        End If
    End Sub

    Protected Sub LoadModal(DataRequestID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim isPCAAdmin As String = lblPCAAdmin.Text.ToString()

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DataRequestAssignment", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@DataRequestID", SqlDbType.Int).Value = DataRequestID
        lblDataRequestID.Text = DataRequestID

        'Clear the form values from any previous calls
        ddlPCAIDModal.SelectedValue = ""
        ddlReviewPeriodModal.SelectedValue = ""
        txtDataReceiptDate.Text = ""
        txtSampleReceiptDate.Text = ""
        txtCDReceiptDate.Text = ""
        ddlc_CallLength.SelectedValue = ""
        ddlc_AccountType.SelectedValue = ""
        ddlc_MissingCalls.SelectedValue = ""
        ddlc_CallDueDate.SelectedValue = ""
        ddlc_NotepadMatch.SelectedValue = ""
        ddlc_BadRecording.SelectedValue = ""
        ddlCompleted.SelectedValue = ""
        txtComments.Text = ""

        'Clear the update confirm label
        lblUpdateConfirm.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    'PCAID is ordinal 0 in p_DataRequestAssignment
                    If Not dr.IsDBNull(0) Then
                        ddlPCAIDModal.SelectedValue = dr("PCA")
                    End If

                    'ReviewPeriod is ordinal 1 in p_DataRequestAssignment
                    If Not dr.IsDBNull(1) Then
                        ddlReviewPeriodModal.SelectedValue = dr("ReviewPeriod")
                    End If

                    'DataReceiptDate is ordinal 2 in p_DataRequestAssignment
                    If Not dr.IsDBNull(2) Then
                        txtDataReceiptDate.Text = dr("DataReceiptDate")
                    End If

                    'SampleReceiptDate is ordinal 3 in p_DataRequestAssignment
                    If Not dr.IsDBNull(3) Then
                        txtSampleReceiptDate.Text = dr("SampleReceiptDate")
                    End If

                    'CDReceiptDate is ordinal 4 in p_DataRequestAssignment
                    If Not dr.IsDBNull(4) Then
                        txtCDReceiptDate.Text = dr("CDReceiptDate")
                    End If

                    'c_CallLength is ordinal 5 in p_DataRequestAssignment
                    If Not dr.IsDBNull(5) Then
                        ddlc_CallLength.SelectedValue = dr("c_CallLength")
                    End If

                    'c_AccountType is ordinal 6 in p_DataRequestAssignment
                    If Not dr.IsDBNull(6) Then
                        ddlc_AccountType.SelectedValue = dr("c_AccountType")
                    End If

                    'c_MissingCalls is ordinal 7 in p_DataRequestAssignment
                    If Not dr.IsDBNull(7) Then
                        ddlc_MissingCalls.SelectedValue = dr("c_MissingCalls")
                    End If

                    'c_CallDueDate is ordinal 8 in p_DataRequestAssignment
                    If Not dr.IsDBNull(8) Then
                        ddlc_CallDueDate.SelectedValue = dr("c_CallDueDate")
                    End If

                    'c_NotepadMatch is ordinal 9 in p_DataRequestAssignment
                    If Not dr.IsDBNull(9) Then
                        ddlc_NotepadMatch.SelectedValue = dr("c_NotepadMatch")
                    End If

                    'c_BadRecording is ordinal 10 in p_DataRequestAssignment
                    If Not dr.IsDBNull(10) Then
                        ddlc_BadRecording.SelectedValue = dr("c_BadRecording")
                    End If

                    'Completed is ordinal 11 in p_DataRequestAssignment
                    If Not dr.IsDBNull(11) Then
                        ddlCompleted.SelectedValue = dr("Completed")
                    End If

                    'Comments is ordinal 12 in p_DataRequestAssignment
                    If Not dr.IsDBNull(12) Then
                        txtComments.Text = dr("Comments").ToString()
                    End If

                End While
            End Using
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub LoadNewRequestModal(ByVal PCA As String)
        'Clear the form values from any previous calls
        ddlPCAIDModal2.SelectedValue = ""
        ddlReviewPeriodModal2.SelectedValue = ""
        txtDataReceiptDate2.Text = ""
        txtSampleReceiptDate2.Text = ""
        txtCDReceiptDate2.Text = ""
        ddlc_CallLength2.SelectedValue = ""
        ddlc_AccountType2.SelectedValue = ""
        ddlc_MissingCalls2.SelectedValue = ""
        ddlc_CallDueDate2.SelectedValue = ""
        ddlc_NotepadMatch2.SelectedValue = ""
        ddlc_BadRecording2.SelectedValue = ""
        ddlCompleted.SelectedValue = ""
        txtComments2.Text = ""

        'Clear the update confirm label
        lblUpdateConfirm2.Text = ""

        ddlPCAIDModal2.SelectedValue = PCA

        'If Not (ViewState("Filter") Is Nothing) Then
        '    ddlReviewPeriodModal2.SelectedValue = ViewState("Filter")
        'End If
    End Sub


    Protected Sub btnSaveChanges_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DataRequest_Update", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@DataRequestID", SqlDbType.Int).Value = lblDataRequestID.Text
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name

        If ddlPCAIDModal.SelectedValue <> "" Then
            cmd.Parameters.Add("@PCA", SqlDbType.VarChar).Value = ddlPCAIDModal.SelectedValue
        Else
            cmd.Parameters.Add("@PCA", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlReviewPeriodModal.SelectedValue <> "" Then
            cmd.Parameters.Add("@ReviewPeriod", SqlDbType.VarChar).Value = ddlReviewPeriodModal.SelectedValue
        Else
            cmd.Parameters.Add("@ReviewPeriod", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtDataReceiptDate.Text <> "" Then
            cmd.Parameters.Add("@DataReceiptDate", SqlDbType.SmallDateTime).Value = txtDataReceiptDate.Text
        Else
            cmd.Parameters.Add("@DataReceiptDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtSampleReceiptDate.Text <> "" Then
            cmd.Parameters.Add("@SampleReceiptDate", SqlDbType.SmallDateTime).Value = txtSampleReceiptDate.Text
        Else
            cmd.Parameters.Add("@SampleReceiptDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtCDReceiptDate.Text <> "" Then
            cmd.Parameters.Add("@CDReceiptDate", SqlDbType.SmallDateTime).Value = txtCDReceiptDate.Text
        Else
            cmd.Parameters.Add("@CDReceiptDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If ddlc_CallLength.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_CallLength", SqlDbType.Int).Value = ddlc_CallLength.SelectedValue
        Else
            cmd.Parameters.Add("@c_CallLength", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_AccountType.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_AccountType", SqlDbType.Int).Value = ddlc_AccountType.SelectedValue
        Else
            cmd.Parameters.Add("@c_AccountType", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_MissingCalls.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_MissingCalls", SqlDbType.Int).Value = ddlc_MissingCalls.SelectedValue
        Else
            cmd.Parameters.Add("@c_MissingCalls", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_CallDueDate.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_CallDueDate", SqlDbType.Int).Value = ddlc_CallDueDate.SelectedValue
        Else
            cmd.Parameters.Add("@c_CallDueDate", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_NotepadMatch.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_NotepadMatch", SqlDbType.Int).Value = ddlc_NotepadMatch.SelectedValue
        Else
            cmd.Parameters.Add("@c_NotepadMatch", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_BadRecording.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_BadRecording", SqlDbType.Int).Value = ddlc_BadRecording.SelectedValue
        Else
            cmd.Parameters.Add("@c_BadRecording", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlCompleted.SelectedValue <> "" Then
            cmd.Parameters.Add("@Completed", SqlDbType.VarChar).Value = ddlCompleted.SelectedValue
        Else
            cmd.Parameters.Add("@Completed", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txtComments.Text) > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "Your data request was updated"
            lblUpdateConfirm.Visible = True
            GridView1.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnAddRequest_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DataRequest_Insert", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name

        If ddlPCAIDModal2.SelectedValue <> "" Then
            cmd.Parameters.Add("@PCA", SqlDbType.VarChar).Value = ddlPCAIDModal2.SelectedValue
        Else
            cmd.Parameters.Add("@PCA", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtReviewPeriodOther.Text <> "" Then
            cmd.Parameters.Add("@ReviewPeriod", SqlDbType.VarChar).Value = txtReviewPeriodOther.Text
        Else
            If ddlReviewPeriodModal2.SelectedValue <> "" AndAlso ddlReviewPeriodModal2.SelectedValue <> "Other" Then
                cmd.Parameters.Add("@ReviewPeriod", SqlDbType.VarChar).Value = ddlReviewPeriodModal2.SelectedValue
            Else
                cmd.Parameters.Add("@ReviewPeriod", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If

        If txtDataReceiptDate2.Text <> "" Then
            cmd.Parameters.Add("@DataReceiptDate", SqlDbType.SmallDateTime).Value = txtDataReceiptDate2.Text
        Else
            cmd.Parameters.Add("@DataReceiptDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtSampleReceiptDate2.Text <> "" Then
            cmd.Parameters.Add("@SampleReceiptDate", SqlDbType.SmallDateTime).Value = txtSampleReceiptDate2.Text
        Else
            cmd.Parameters.Add("@SampleReceiptDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtCDReceiptDate2.Text <> "" Then
            cmd.Parameters.Add("@CDReceiptDate", SqlDbType.SmallDateTime).Value = txtCDReceiptDate2.Text
        Else
            cmd.Parameters.Add("@CDReceiptDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If ddlc_CallLength2.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_CallLength", SqlDbType.Int).Value = ddlc_CallLength2.SelectedValue
        Else
            cmd.Parameters.Add("@c_CallLength", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_AccountType2.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_AccountType", SqlDbType.Int).Value = ddlc_AccountType2.SelectedValue
        Else
            cmd.Parameters.Add("@c_AccountType", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_MissingCalls2.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_MissingCalls", SqlDbType.Int).Value = ddlc_MissingCalls2.SelectedValue
        Else
            cmd.Parameters.Add("@c_MissingCalls", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_CallDueDate2.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_CallDueDate", SqlDbType.Int).Value = ddlc_CallDueDate2.SelectedValue
        Else
            cmd.Parameters.Add("@c_CallDueDate", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_NotepadMatch2.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_NotepadMatch", SqlDbType.Int).Value = ddlc_NotepadMatch2.SelectedValue
        Else
            cmd.Parameters.Add("@c_NotepadMatch", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlc_BadRecording2.SelectedValue <> "" Then
            cmd.Parameters.Add("@c_BadRecording", SqlDbType.Int).Value = ddlc_BadRecording2.SelectedValue
        Else
            cmd.Parameters.Add("@c_BadRecording", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlCompleted2.SelectedValue <> "" Then
            cmd.Parameters.Add("@Completed", SqlDbType.VarChar).Value = ddlCompleted2.SelectedValue
        Else
            cmd.Parameters.Add("@Completed", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txtComments2.Text) > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments2.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm2.Text = "Your data request was added"
            lblUpdateConfirm2.Visible = True

            GridView1.DataBind()
            GridView2.DataBind()

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub ddlReviewPeriod_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlReviewPeriod As DropDownList = DirectCast(sender, DropDownList)
        ViewState("Filter") = ddlReviewPeriod.SelectedValue
        Me.BindGrid()
    End Sub

    Private Sub BindGrid()
        dsDataRequests.SelectParameters("ReviewPeriod").DefaultValue = ViewState("Filter")
        dsDataRequestsPending.SelectParameters("ReviewPeriod").DefaultValue = ViewState("Filter")
    End Sub

    'Sub OnSelectedHandlerPCAReviews(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
    '    Dim cmd As IDbCommand
    '    cmd = e.Command
    '    Dim recordCount As Integer = e.AffectedRows()
    '    lblCallCountPCAReviews.Text = "This Analyst has reviewed " & recordCount & " PCA calls"
    'End Sub

    Protected Sub btnDeleteAssignment_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DataRequest_Delete", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@DataRequestID", SqlDbType.Int).Value = lblDataRequestID.Text
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "This data request was deleted"
            lblUpdateConfirm.Visible = True
            ViewState("Filter") = "All"
            'dsReviewPeriods.DataBind()
            'UpdatePanel2.DataBind()

            BindGrid()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        dsDataRequests.SelectParameters("ReviewPeriod").DefaultValue = ViewState("Filter")
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCA_Data_Requests.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
