Imports System.Data
Imports System.Data.SqlClient

Partial Class ATB_New_admin_AddNewSchool
    Inherits System.Web.UI.Page

    Sub btnAddRecord_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim strRecordStatus As Boolean

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddNewSchool", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        cmd.Parameters.Add("@SchoolName", SqlDbType.VarChar).Value = txtSchoolName.Text
        cmd.Parameters.Add("@RecordStatus", SqlDbType.Bit).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            strRecordStatus = cmd.Parameters("@RecordStatus").Value

            If strRecordStatus = True Then
                lblUpdateStatus.Text = "Your school was successfully added to the database"
            Else
                lblUpdateStatus.Text = "Your school was not added because this school already exists in the database"
            End If
        Finally
            strSQLConn.Close()
        End Try
    End Sub

End Class
