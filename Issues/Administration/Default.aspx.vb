Imports System.Data
Imports System.Data.SqlClient

Partial Class Issues_Administration_Default
    Inherits System.Web.UI.Page

    Sub btnAddCategory_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim InsertConfirm As Integer

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddCategory", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@Category", txtCategory.Text)
        cmd.Parameters.Add("@AddCategory", SqlDbType.Int).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            InsertConfirm = cmd.Parameters("@AddCategory").Value
            If InsertConfirm = 1 Then
                lblInsertConfirmCategory.Text = "Your category was successfully added"
            Else
                lblInsertConfirmCategory.Text = "Your category already exists"
            End If

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnAddSourceOrg_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim InsertConfirm As Integer

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddSourceOrg", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@SourceOrg", txtSourceOrg.Text)
        cmd.Parameters.Add("@AddSourceOrg", SqlDbType.Int).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            InsertConfirm = cmd.Parameters("@AddSourceOrg").Value
            If InsertConfirm = 1 Then
                lblInsertConfirmSourceOrg.Text = "Your Source Org was successfully added"
            Else
                lblInsertConfirmSourceOrg.Text = "Your Source Org already exists"
            End If

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnAddAffectedOrg_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim InsertConfirm As Integer

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddAffectedOrg", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@AffectedOrg", txtAffectedOrg.Text)
        cmd.Parameters.Add("@AddAffectedOrg", SqlDbType.Int).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            InsertConfirm = cmd.Parameters("@AddAffectedOrg").Value
            If InsertConfirm = 1 Then
                lblInsertConfirmAffectedOrg.Text = "Your Affected Org was successfully added"
            Else
                lblInsertConfirmAffectedOrg.Text = "Your Affected Org already exists"
            End If

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnDeleteIssue_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteIssue", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IssueID", ddlIssueID.SelectedValue)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblDeleteIssueConfirm.Text = "Your issue was successfully deleted"

            'Add the call to the IssueHistory table
            Dim newIssueHistory As New IssueHistory
            newIssueHistory.IssueID = ddlIssueID.SelectedValue

            'Add new record to IssueHistory table
            newIssueHistory.InsertIssueHistory(ddlIssueID.SelectedValue, txtDeleteReason.Text, "Issue Deleted")

            'Rebind IssueID list
            ddlIssueID.DataBind()

        Finally
            strSQLConn.Close()
        End Try
    End Sub
End Class
