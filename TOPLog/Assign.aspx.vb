Imports System.Data

Partial Class TOPLog_Assign
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString

    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            'lblUserID.Text = "eric.vanburen"
        End If
    End Sub


    Private Sub FindCheckedRows()
        Dim checkedRowsList As ArrayList
        If ViewState("checkedRowsList") IsNot Nothing Then
            checkedRowsList = DirectCast(ViewState("checkedRowsList"), ArrayList)
        Else
            checkedRowsList = New ArrayList()
        End If

        For Each gvRow As GridViewRow In grdTOPLogQueue.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(grdTOPLogQueue.DataKeys(gvRow.RowIndex)("TOPLogID"))
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

    Protected Sub grdTOPLogQueue_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdTOPLogQueue.PageIndex = e.NewPageIndex
        FindCheckedRows()
    End Sub

    Protected Sub grdTOPLogQueue_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)
            Dim gvRow As GridViewRow = e.Row
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)
                Dim rowIndex As String = Convert.ToString(grdTOPLogQueue.DataKeys(gvRow.RowIndex)("TOPLogID"))

                If checkedRowsList.Contains(rowIndex) Then
                    chkSelect.Checked = True
                End If
            End If
        End If
    End Sub

    Sub btnAssignTOPLogs_Click(ByVal sender As Object, ByVal e As EventArgs)
        FindCheckedRows()
        grdTOPLogQueue.AllowPaging = False
        grdTOPLogQueue.AllowSorting = False
        grdTOPLogQueue.DataBind()
        grdTOPLogQueue.AllowPaging = True
        grdTOPLogQueue.AllowSorting = True
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In grdTOPLogQueue.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(grdTOPLogQueue.DataKeys(gvRow.RowIndex)("TOPLogID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        dsAssignments.UpdateParameters("TOPLogID").DefaultValue = rowIndex
                        dsAssignments.UpdateParameters("UserID").DefaultValue = lblUserID.Text
                        dsAssignments.Update()
                    End If
                End If
            Next
        End If

        lblAssignStatus.Text = "You successfully assigned the TOP records to yourself.  FSA thanks you for your efforts."

        'Show the GridView with the next set of unassigned TOP records
        grdTOPLogQueue.DataBind()

        'Put the Check All/Uncheck All button back to a Check All status
        btnMasterCheck.CommandName = "Check"
        btnMasterCheck.CommandArgument = "Check"
        btnMasterCheck.Text = "Check All TOP Records"

    End Sub

    Protected Sub MasterCheck_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        'Enumerate each GridViewRow
        For Each gvr As GridViewRow In grdTOPLogQueue.Rows
            'Programmatically access the CheckBox from the TemplateField
            Dim cb As CheckBox = CType(gvr.FindControl("chkSelect"), CheckBox)

            Select Case e.CommandName

                Case "Check"
                    'Check all of the checkboxes
                    cb.Checked = True
                    'Change the CommandName, CommandArgument and Text of the button
                    btnMasterCheck.CommandName = "Uncheck"
                    btnMasterCheck.CommandArgument = "Uncheck"
                    btnMasterCheck.Text = "Uncheck All Top records"
                    'Enable the 'Assign Checked TOP records to Me' button
                    btnAssignTopLogs.Enabled = True
                Case "Uncheck"
                    'Uncheck all of the checkboxes
                    cb.Checked = False
                    'Change the CommandName, CommandArgument and Text of the button
                    btnMasterCheck.CommandName = "Check"
                    btnMasterCheck.CommandArgument = "Check"
                    btnMasterCheck.Text = "Check All TOP Records"
                    'Disnable the 'Assign Checked TOP records to Me' button
                    btnAssignTopLogs.Enabled = False
                Case Else

            End Select
        Next
    End Sub

    Protected Sub chkSelect_CheckedChanged(sender As Object, e As EventArgs)
        btnAssignTopLogs.Enabled = True
    End Sub

    Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRowCount.Text = "There are " & recordCount & " TOP records available for assignment"
    End Sub
End Class
