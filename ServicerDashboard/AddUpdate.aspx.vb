Imports System.Data
Imports System.Data.SqlClient

Partial Class ServicerDashboard_AddUpdate
    Inherits System.Web.UI.Page

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
       
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ServicerDashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ServicerUpdateInsertNew", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ServicerID", ddlServicer.SelectedValue)
        cmd.Parameters.AddWithValue("@StatusID", ddlStatus.SelectedValue)
        If txtComments.Text <> "" Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@SubmittedBy", HttpContext.Current.User.Identity.Name)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblUpdateStatus.Text = "Your servicer update was successfully submitted"
            ddlServicer.SelectedValue = ""
            ddlStatus.SelectedValue = ""
            txtComments.Text = ""

        Finally
            strSQLConn.Close()
        End Try

    End Sub

    Protected Sub ddlServicer_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlServicer.SelectedIndexChanged
        lblUpdateStatus.Text = ""
    End Sub
End Class
