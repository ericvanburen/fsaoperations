Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.IO

Partial Class Issues_Issue_Import_Liaison
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If FileUpload1.HasFile Then
            Dim FileName As String = Path.GetFileName(FileUpload1.PostedFile.FileName)
            Dim Extension As String = Path.GetExtension(FileUpload1.PostedFile.FileName)
            Dim FolderPath As String = ConfigurationManager.AppSettings("FolderPath")
            Dim FilePath As String = Server.MapPath(FolderPath + FileName)
            FileUpload1.SaveAs(FilePath)
            lblFileName.Text = Path.GetFileName(FilePath)
            lblMessage.Text = "You are uploading a file named <b>" & lblFileName.Text & "</b>.  Click the Save button to continue."
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        'First delete any old records in the IssueImport table
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Delete_IssueImport"
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

            'Now import the new issue into table IssueImport
            ImportIssue()
        End Try
    End Sub

    Protected Sub ImportIssue()
        Dim excelConnectionString As String
        Dim tableName As String = "IssueImport"
        Dim conn As SqlConnection = New SqlConnection(connStr)

        'excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=d:\DCS\fsaoperations\internal\Issues\Imports\" & lblFileName.Text & ";Extended Properties=Excel 8.0;Persist Security Info=False"
        excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\Acer\Dropbox\fsaoperations\Issues\Imports\" & lblFileName.Text & ";Extended Properties=Excel 8.0;Persist Security Info=False"

        Dim excelConnection As OleDbConnection = New OleDbConnection(excelConnectionString)
        Try
            conn.Open()
            Dim cmd As OleDbCommand = New OleDbCommand("SELECT * FROM [Import$]", excelConnection)
            excelConnection.Open()

            Dim dr As OleDbDataReader
            dr = cmd.ExecuteReader()

            Dim sqlBulk As SqlBulkCopy = New SqlBulkCopy(connStr)

            'Set the destination table name
            sqlBulk.DestinationTableName = tableName
            sqlBulk.WriteToServer(dr)
            
            'Now we need to copy the issue from table IssueImport into table Issues
            CopyIssue()
        Catch ex As Exception
            lblMessage.ForeColor = System.Drawing.Color.Red
            lblMessage.Text = ex.Message
        Finally
            excelConnection.Close()
            conn.Close()
        End Try
    End Sub

    Sub CopyIssue()
        'Now we need to copy the issue from table IssueImport into table Issues
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_IssueImport_Copy"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@EnteredBy", SqlDbType.VarChar).Value = User.Identity.Name
        cmd.Parameters.Add("@IssueID", SqlDbType.Int).Direction = ParameterDirection.Output
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            lblMessage.ForeColor = Drawing.Color.Green

            Dim IssueID As String = cmd.Parameters("@IssueID").Value.ToString()
            lblMessage.Text = "Import was successful!.  Your Issue number is " & IssueID
        Catch ex As Exception
            lblMessage.Text = ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        Finally
            strConnection.Close()
        End Try

    End Sub

End Class
