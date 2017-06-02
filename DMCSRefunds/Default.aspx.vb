Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.IO
Imports Telerik.Web.UI

Partial Class DMCSRefunds_Default
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString

    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            'lblUserID.Text = "eric.vanburen"

            RadMenu1.LoadContentFile("~/DMCSRefunds/Menu.xml")
        End If
    End Sub


    Private Sub FindCheckedRows()
        Dim checkedRowsList As ArrayList
        If ViewState("checkedRowsList") IsNot Nothing Then
            checkedRowsList = DirectCast(ViewState("checkedRowsList"), ArrayList)
        Else
            checkedRowsList = New ArrayList()
        End If

        For Each gvRow As GridViewRow In grdRefundQueue.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(grdRefundQueue.DataKeys(gvRow.RowIndex)("RefundID"))
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

    Protected Sub grdRefundQueue_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdRefundQueue.PageIndex = e.NewPageIndex
        FindCheckedRows()
    End Sub

    Protected Sub grdRefundQueue_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)
            Dim gvRow As GridViewRow = e.Row
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)
                Dim rowIndex As String = Convert.ToString(grdRefundQueue.DataKeys(gvRow.RowIndex)("RefundID"))

                If checkedRowsList.Contains(rowIndex) Then
                    chkSelect.Checked = True
                End If
            End If
        End If
    End Sub

    Sub btnAssignRefunds_Click(ByVal sender As Object, ByVal e As EventArgs)
        FindCheckedRows()
        grdRefundQueue.AllowPaging = False
        grdRefundQueue.AllowSorting = False
        grdRefundQueue.DataBind()
        grdRefundQueue.AllowPaging = True
        grdRefundQueue.AllowSorting = True
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In grdRefundQueue.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(grdRefundQueue.DataKeys(gvRow.RowIndex)("RefundID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        dsRefunds.UpdateParameters("RefundID").DefaultValue = rowIndex
                        dsRefunds.UpdateParameters("UserID").DefaultValue = lblUserID.Text
                        dsRefunds.Update()
                    End If
                End If
            Next
        End If

        'Show the GridView with the next set of unassigned refunds
        grdRefundQueue.DataBind()

        'Put the Check All/Uncheck All button back to a Check All status
        btnMasterCheck.CommandName = "Check"
        btnMasterCheck.CommandArgument = "Check"
        btnMasterCheck.Text = "Check All Refunds"

    End Sub

    Protected Sub MasterCheck_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        'Enumerate each GridViewRow
        For Each gvr As GridViewRow In grdRefundQueue.Rows
            'Programmatically access the CheckBox from the TemplateField
            Dim cb As CheckBox = CType(gvr.FindControl("chkSelect"), CheckBox)

            Select Case e.CommandName

                Case "Check"
                    'Check all of the checkboxes
                    cb.Checked = True
                    'Change the CommandName, CommandArgument and Text of the button
                    btnMasterCheck.CommandName = "Uncheck"
                    btnMasterCheck.CommandArgument = "Uncheck"
                    btnMasterCheck.Text = "Uncheck All Refunds"
                Case "Uncheck"
                    'Uncheck all of the checkboxes
                    cb.Checked = False
                    'Change the CommandName, CommandArgument and Text of the button
                    btnMasterCheck.CommandName = "Check"
                    btnMasterCheck.CommandArgument = "Check"
                    btnMasterCheck.Text = "Check All Refunds"
                Case Else

            End Select
        Next
    End Sub

End Class
