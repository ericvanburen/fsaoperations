﻿Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_LAAssignments
    Inherits System.Web.UI.Page

    Protected Function GetRoleUsers() As String()
        Return Roles.GetUsersInRole("PCACalls")
    End Function

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCACalls_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            Dim strReviewType As String = ""
            Dim strUserID As String = ""
            Dim strPCA As String = ""
            Dim intPCAID As Integer = 0
            Dim strRecordingDeliverydate As String = ""
            Dim intNewAssignmentID As Integer = 0

            If Not Request.QueryString("NewAssignmentID") Is Nothing Then
                intNewAssignmentID = Request.QueryString("NewAssignmentID")
            End If

            If Not Request.QueryString("ReviewType") Is Nothing Then
                strReviewType = Server.UrlDecode(Request.QueryString("ReviewType"))
                lblReviewType.Text = strReviewType & " for "
            End If

            If Not Request.QueryString("UserID") Is Nothing Then
                strUserID = Server.UrlDecode(Request.QueryString("UserID"))
                lblUserID.Text = strUserID & " on "
            End If

            If Not Request.QueryString("PCA") Is Nothing Then
                strPCA = Server.UrlDecode(Request.QueryString("PCA"))
                lblPCA.Text = strPCA & "  for "
            End If

            If Not Request.QueryString("PCAID") Is Nothing Then
                intPCAID = Request.QueryString("PCAID")
            Else
                intPCAID = 0
            End If

            If Not Request.QueryString("RecordingDeliveryDate") Is Nothing Then
                strRecordingDeliverydate = Server.UrlDecode(Request.QueryString("RecordingDeliveryDate"))
                lblRecordingDeliveryDate.Text = strRecordingDeliverydate
            End If

            If strReviewType = "PCA Phone Review" Then
                'dsPCAReviews.SelectParameters("UserID").DefaultValue = strUserID
                'dsPCAReviews.SelectParameters("PCAID").DefaultValue = intPCAID
                'dsPCAReviews.SelectParameters("RecordingDeliveryDate").DefaultValue = strRecordingDeliverydate
                dsPCAReviews.SelectParameters("NewAssignmentID").DefaultValue = intNewAssignmentID
                grdPCAReviews.Visible = True
                grdRehabReviews.Visible = False
                ViewState("Filter") = strUserID
                Me.BindGrid()
            ElseIf strReviewType = "Rehab Review" Then
                dsRehabReviews.SelectParameters("UserID").DefaultValue = strUserID
                dsRehabReviews.SelectParameters("PCAID").DefaultValue = intPCAID
                dsRehabReviews.SelectParameters("RecordingDeliveryDate").DefaultValue = strRecordingDeliverydate
                grdPCAReviews.Visible = False
                grdRehabReviews.Visible = True
                ViewState("Filter") = strUserID
                Me.BindGrid()
            Else
                ViewState("Filter") = "ALL"
                BindGrid()
            End If

            'Populate the Loan Analyst dropdown box in the modal
            ddlUserIDModal.DataSource = Roles.GetUsersInRole("PCACalls")
            ddlUserIDModal.DataBind()

            'ViewState("Filter") = "ALL"
            'BindGrid()
        End If

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            'This is for the Review Calls link - Hyperlink1
            Dim link = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
            Dim strNewAssignmentID As String = e.Row.Cells(10).Text
            Dim strUserID As String = e.Row.Cells(2).Text
            Dim strReviewType As String = e.Row.Cells(3).Text
            Dim strPCA As String = e.Row.Cells(5).Text
            Dim strPCAID As String = e.Row.Cells(6).Text
            Dim strRecordingDeliveryDate As String = e.Row.Cells(9).Text
            link.Text = "Review Calls"
            link.NavigateUrl = "LAAssignments.aspx?ReviewType=" & Server.UrlEncode(strReviewType) & "&UserID=" & Server.UrlEncode(strUserID) & "&PCA=" & Server.UrlEncode(strPCA) & " &PCAID=" & strPCAID & " &RecordingDeliveryDate=" & Server.UrlEncode(strRecordingDeliveryDate) & "&NewAssignmentID=" & Server.UrlEncode(strNewAssignmentID)
        End If
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim intNewAssignmentID As Integer = GridView1.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(intNewAssignmentID)

        End If
    End Sub

    Protected Sub LoadModal(NewAssignmentID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim isPCAAdmin As String = lblPCAAdmin.Text.ToString()

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCAAssignment", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@NewAssignmentID", SqlDbType.Int).Value = NewAssignmentID
        lblNewAssignmentID.Text = NewAssignmentID

        'Clear the form values from any previous calls
        ddlUserIDModal.SelectedValue = ""
        txtReviewDate.Text = ""
        ddlReportQuarter.SelectedValue = ""
        ddlReportYear.SelectedValue = ""
        lblReviewType2.Text = ""
        lblPCA2.Text = ""
        txtRecordingDeliveryDate.Text = ""
        txtWorksheetPCADate.Text = ""
        txtQCWorksheetDate.Text = ""
        txtFinalPCADate.Text = ""
        txtQCFinalDate.Text = ""
        txtComments.Text = ""

        'Clear the update confirm label
        lblUpdateConfirm.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    ddlUserIDModal.SelectedValue = dr("UserID").ToString().ToLower()

                    'ReviewDate is ordinal 9 in p_PCAAssignment
                    If Not dr.IsDBNull(9) Then
                        txtReviewDate.Text = dr("ReviewDate")
                    End If

                    'ReportQuarter is ordinal 10 in p_PCAAssignment
                    If Not dr.IsDBNull(10) Then
                        ddlReportQuarter.SelectedValue = dr("ReportQuarter")
                    End If

                    'ReportYear is ordinal 11 in p_PCAAssignment
                    If Not dr.IsDBNull(11) Then
                        ddlReportYear.SelectedValue = dr("ReportYear")
                    End If

                    'ReviewType is ordinal 1 in p_PCAAssignment
                    If Not dr.IsDBNull(1) Then
                        lblReviewType2.Text = dr("ReviewType").ToString()
                    End If

                    'PCA is ordinal 2 in p_PCAAssignment
                    If Not dr.IsDBNull(2) Then
                        lblPCA2.Text = dr("PCA").ToString()
                    End If

                    'RecordingDeliveryDate is ordinal 4 in p_PCAAssignment
                    If Not dr.IsDBNull(4) Then
                        txtRecordingDeliveryDate.Text = dr("RecordingDeliveryDate").ToString()
                    End If

                    'WorksheetPCADate is ordinal 5 in p_PCAAssignment
                    If Not dr.IsDBNull(5) Then
                        txtWorksheetPCADate.Text = dr("WorksheetPCADate").ToString()
                    End If

                    'QCWorksheetDate is ordinal 7 in p_PCAAssignment
                    If Not dr.IsDBNull(7) Then
                        txtQCWorksheetDate.Text = dr("QCWorksheetDate").ToString()
                    End If

                    'FinalPCADate is ordinal 6 in p_PCAAssignment
                    If Not dr.IsDBNull(6) Then
                        txtFinalPCADate.Text = dr("FinalPCADate").ToString()
                    End If

                    'QCFinalDate is ordinal 8 in p_PCAAssignment
                    If Not dr.IsDBNull(8) Then
                        txtQCFinalDate.Text = dr("QCFinalDate").ToString()
                    End If

                    'Comments is ordinal 12 in p_PCAAssignment
                    If Not dr.IsDBNull(12) Then
                        txtComments.Text = dr("Comments").ToString()
                    End If

                End While
            End Using
        Finally
            con.Close()
        End Try
    End Sub


    Protected Sub btnSaveChanges_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCAAssignment_Update", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@NewAssignmentID", SqlDbType.Int).Value = lblNewAssignmentID.Text
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = ddlUserIDModal.SelectedValue

        If Len(txtReviewDate.Text) > 0 Then
            cmd.Parameters.Add("@ReviewDate", SqlDbType.SmallDateTime).Value = txtReviewDate.Text
        Else
            cmd.Parameters.Add("@ReviewDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtRecordingDeliveryDate.Text) > 0 Then
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = txtRecordingDeliveryDate.Text
        Else
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If ddlReportQuarter.SelectedValue <> "" Then
            cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = ddlReportQuarter.SelectedValue
        Else
            cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlReportYear.SelectedValue <> "" Then
            cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = ddlReportYear.SelectedValue
        Else
            cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(txtWorksheetPCADate.Text) > 0 Then
            cmd.Parameters.Add("@WorksheetPCADate", SqlDbType.SmallDateTime).Value = txtWorksheetPCADate.Text
        Else
            cmd.Parameters.Add("@WorksheetPCADate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtQCWorksheetDate.Text) > 0 Then
            cmd.Parameters.Add("@QCWorksheetDate", SqlDbType.SmallDateTime).Value = txtQCWorksheetDate.Text
        Else
            cmd.Parameters.Add("@QCWorksheetDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtFinalPCADate.Text) > 0 Then
            cmd.Parameters.Add("@FinalPCADate", SqlDbType.SmallDateTime).Value = txtFinalPCADate.Text
        Else
            cmd.Parameters.Add("@FinalPCADate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtQCFinalDate.Text) > 0 Then
            cmd.Parameters.Add("@QCFinalDate", SqlDbType.SmallDateTime).Value = txtQCFinalDate.Text
        Else
            cmd.Parameters.Add("@QCFinalDate", SqlDbType.SmallDateTime).Value = DBNull.Value
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
            lblUpdateConfirm.Text = "Your review was updated"
            lblUpdateConfirm.Visible = True
            GridView1.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub



    Protected Sub ddlUserID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlUserID As DropDownList = DirectCast(sender, DropDownList)
        ViewState("Filter") = ddlUserID.SelectedValue
        Me.BindGrid()
    End Sub

    Private Sub BindGrid()
        dsLAAssignments.SelectParameters("UserID").DefaultValue = ViewState("Filter")
        Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        'Me.BindUserIDList(ddlUserID)
    End Sub

    Private Sub BindUserIDList(ByVal ddlUserID As DropDownList)
        'Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        ddlUserID.Items.FindByValue(ViewState("Filter").ToString()).Selected = True
    End Sub

    Sub OnSelectedHandlerPCAReviews(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblCallCountPCAReviews.Text = "This Analyst has reviewed " & recordCount & " PCA calls"
    End Sub

    Sub OnSelectedHandlerRehabReviews(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblCallCountRehabReviews.Text = "This Analyst has reviewed " & recordCount & " rehab calls"
    End Sub

    Protected Sub btnDeleteAssignment_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCAAssignment_Delete", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@NewAssignmentID", SqlDbType.Int).Value = lblNewAssignmentID.Text
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "This review was deleted"
            lblUpdateConfirm.Visible = True
            GridView1.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        dsLAAssignments.SelectParameters("UserID").DefaultValue = ViewState("Filter")
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        ddlUserID.Visible = False

        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Loan_Analyst_Assignments.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
End Class