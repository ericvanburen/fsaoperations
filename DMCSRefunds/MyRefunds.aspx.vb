Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI

Partial Class DMCSRefunds_MyRefunds
    Inherits System.Web.UI.Page
    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name

            RadMenu1.LoadContentFile("~/DMCSRefunds/Menu.xml")

            'Bind the UserID dropdownlist with users in the DCMS Refunds role
            ddlUserID.DataSource = Roles.GetUsersInRole("DMCSRefunds")
            ddlUserID.DataBind()

            'The main grid for all of the refunds
            dsMyRefunds.SelectParameters("UserID").DefaultValue = lblUserID.Text
            dsMyRefunds.SelectParameters("FirstLineApprovalStatus").DefaultValue = ddlFirstLineApprovalStatus.SelectedValue

            'The My Totals grid
            dsMyRefundsTotals.SelectParameters("UserID").DefaultValue = lblUserID.Text

        End If
    End Sub

    Protected Sub ddlFirstLineApprovalStatus_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlFirstLineApprovalStatus.SelectedIndexChanged
        dsMyRefunds.SelectParameters("UserID").DefaultValue = lblUserID.Text
        dsMyRefunds.SelectParameters("FirstLineApprovalStatus").DefaultValue = ddlFirstLineApprovalStatus.SelectedValue
        dsMyRefunds.DataBind()
    End Sub

    Protected Sub grdMyRefundQueue_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdMyRefundQueue.PageIndex = e.NewPageIndex
        FindCheckedRows()
    End Sub

    Protected Sub btnExportToExcel_Click(sender As Object, e As EventArgs)
        FindCheckedRows()
        grdMyRefundQueue.ShowHeader = True
        grdMyRefundQueue.GridLines = GridLines.Both
        grdMyRefundQueue.AllowPaging = False
        grdMyRefundQueue.AllowSorting = False
        grdMyRefundQueue.DataBind()
        grdMyRefundQueue.HeaderRow.Cells.RemoveAt(0)
        'grdMyRefundQueue.HeaderRow.Cells.RemoveAt(1)
        'grdMyRefundQueue.Columns.RemoveAt(0)
        'grdMyRefundQueue.Columns.RemoveAt(1)

        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In grdMyRefundQueue.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(grdMyRefundQueue.DataKeys(gvRow.RowIndex)("RefundID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        gvRow.Visible = True
                        gvRow.Cells(0).Visible = False
                    End If
                End If
            Next
        End If
        'ChangeControlsToValue(gvdetails)
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=Refund_Requests_" & Today() & ".xls")
        Response.ContentType = "application/excel"
        Dim sWriter As New StringWriter()
        Dim hTextWriter As New HtmlTextWriter(sWriter)
        Dim hForm As New HtmlForm()
        grdMyRefundQueue.Parent.Controls.Add(hForm)
        hForm.Attributes("runat") = "server"
        hForm.Controls.Add(grdMyRefundQueue)
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

        For Each gvRow As GridViewRow In grdMyRefundQueue.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(grdMyRefundQueue.DataKeys(gvRow.RowIndex)("RefundID"))
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

    Protected Sub grdMyRefundQueue_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)
            Dim gvRow As GridViewRow = e.Row
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)
                Dim rowIndex As String = Convert.ToString(grdMyRefundQueue.DataKeys(gvRow.RowIndex)("RefundID"))

                If checkedRowsList.Contains(rowIndex) Then
                    chkSelect.Checked = True
                End If
            End If
        End If
    End Sub

    Protected Sub imgbtn_Click(sender As Object, e As ImageClickEventArgs)
        Dim btndetails As ImageButton = TryCast(sender, ImageButton)
        Dim gvrow As GridViewRow = DirectCast(btndetails.NamingContainer, GridViewRow)
        lblRefundID.Text = grdMyRefundQueue.DataKeys(gvrow.RowIndex).Value.ToString()
       
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_RefundID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@RefundID", SqlDbType.VarChar).Value = lblRefundID.Text
        'cmd.Parameters.Add("@RefundID", SqlDbType.VarChar).Value = gvrow.Cells(3).Text

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    lblBorrowerNumber.Text = dr("BorrowerNumber").ToString()
                    ddlUserID.SelectedValue = dr("UserID").ToString().ToLower()
                    lblTagDate.Text = dr("TagDate").ToString()
                    lblDateAssigned.Text = dr("DateAssigned").ToString()
                    txtRefundAmount.Text = dr("RefundAmount").ToString()
                    txtNoOfPayments.Text = dr("NoOfPayments").ToString()
                    ddlFirstLineApprovalStatusForm.SelectedValue = dr("FirstLineApprovalStatus").ToString()
                    lblFirstLineDateApproved.Text = dr("FirstLineDateApproved").ToString()
                    ddlSecondLineApprovalStatus.SelectedValue = dr("SecondLineApprovalStatus").ToString()
                    ddlSecondLineApprovedBy.SelectedValue = dr("SecondLineApprovedBy").ToString()
                    lblSecondLineDateApproved.Text = dr("SecondLineDateApproved").ToString()
                    txtComments.Text = dr("Comments").ToString()
                End While
            End Using
        Finally
            con.Close()
        End Try
        Me.ModalPopupExtender1.Show()

        'Clear the update status label of any old values
        lblUpdateStatus.Text = ""
    End Sub

    Sub btnUpdate_Click(ByVal Sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_RefundID_Update", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@RefundID", lblRefundID.Text)
        cmd.Parameters.AddWithValue("@UserID", ddlUserID.SelectedValue.ToLower())
        cmd.Parameters.AddWithValue("@NoOfPayments", txtNoOfPayments.Text)
        cmd.Parameters.AddWithValue("@RefundAmount", txtRefundAmount.Text)
        cmd.Parameters.AddWithValue("@FirstLineApprovalStatus", ddlFirstLineApprovalStatusForm.SelectedValue)
        If ddlFirstLineApprovalStatusForm.SelectedValue = "Approved" OrElse ddlFirstLineApprovalStatusForm.SelectedValue = "Denied" Then
            cmd.Parameters.AddWithValue("@FirstLineDateApproved", Date.Now())
        Else
            cmd.Parameters.AddWithValue("@FirstLineDateApproved", DBNull.Value)
        End If
        cmd.Parameters.AddWithValue("@SecondLineApprovalStatus", ddlSecondLineApprovalStatus.SelectedValue)
        cmd.Parameters.AddWithValue("@SecondLineApprovedBy", ddlSecondLineApprovedBy.SelectedValue)
        If ddlSecondLineApprovalStatus.SelectedValue = "Approved" OrElse ddlSecondLineApprovalStatus.SelectedValue = "Denied" Then
            cmd.Parameters.AddWithValue("@SecondLineDateApproved", Date.Now())
        Else
            cmd.Parameters.AddWithValue("@SecondLineDateApproved", DBNull.Value)
        End If
        cmd.Parameters.AddWithValue("@Comments", txtComments.Text)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateStatus.Text = "Your refund was successfully updated"

            'Catch ex As Exception
            'lblUpdateStatus.Text = ex.Message.ToString()

            grdMyRefundQueue.DataBind()
            grdMyTotals.DataBind()


        Finally
            strSQLConn.Close()
        End Try

    End Sub

   

End Class
