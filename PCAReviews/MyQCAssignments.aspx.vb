Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_LAAssignments
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim strUserID As String = HttpContext.Current.User.Identity.Name
            dsMyQCAssignments.SelectParameters("UserID").DefaultValue = strUserID
            ddlUserID.SelectedValue = strUserID

            If Roles.IsUserInRole("PCAReviews_Admins") = True Then
                'User is an admin
                ddlUserID.Enabled = True
                pnlReassignmentSection.Visible = True
            Else
                'User is not an admin
                ddlUserID.Enabled = False
                pnlReassignmentSection.Visible = False
            End If
        End If
    End Sub

    Sub OnSelectedHandlerQCReviews(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblQCCount.Text = "You have " & recordCount & " QC reviews for this period"
    End Sub

    Protected Sub btnsearch_Click(sender As Object, e As EventArgs)
        dsMyQCAssignments.SelectParameters("UserID").DefaultValue = ddlUserID.SelectedValue
        dsMyQCAssignments.SelectParameters("ReviewPeriodMonth").DefaultValue = ddlReviewPeriodMonth.SelectedValue
        dsMyQCAssignments.SelectParameters("ReviewPeriodYear").DefaultValue = ddlReviewPeriodYear.SelectedValue
        GridView1.DataBind()
    End Sub

    Private Sub FindCheckedRows()
        Dim checkedRowsList As ArrayList
        If ViewState("checkedRowsList") IsNot Nothing Then
            checkedRowsList = DirectCast(ViewState("checkedRowsList"), ArrayList)
        Else
            checkedRowsList = New ArrayList()
        End If

        For Each gvRow As GridViewRow In GridView1.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("ReviewID"))
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

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)
            Dim gvRow As GridViewRow = e.Row
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)
                Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("ReviewID"))

                If checkedRowsList.Contains(rowIndex) Then
                    chkSelect.Checked = True
                End If
            End If
        End If
    End Sub

    Sub btnReassignQC_Click(ByVal sender As Object, ByVal e As EventArgs)
        FindCheckedRows()
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        'BindGridView()
        GridView1.AllowPaging = True
        GridView1.AllowSorting = True
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In GridView1.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("ReviewID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        'Pass the ReviewID and UserID values to update the reassignment value
                        UpdateQCAssignment(rowIndex, ddlUserIDAssign.SelectedValue)
                    End If
                End If
            Next
        End If

        'Show the GridView with the next set of refunds in Received status
        'BindGridView()

    End Sub

    Sub UpdateQCAssignment(ByVal ReviewID As Integer, ByVal UserID As String)

        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        strSql = "p_QCReAssign"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ReviewID", SqlDbType.Int).Value = ReviewID
        cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = UserID

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
    End Sub
End Class
