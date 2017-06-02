Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.IO

Partial Class SpecialtyClaims_Upload
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

        End If
    End Sub

    Sub UploadFile_Click(ByVal sender As Object, ByVal e As EventArgs)
        DeleteOldRecords()
    End Sub

    Sub DeleteOldRecords()
        'Deletes old records from table Claims_Upload
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Delete_Claims_Upload"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()

            'Upload the new file
            UploadNewFile()
        Catch ex As Exception
            lblMessage.Text = ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        Finally
            strConnection.Close()
        End Try
    End Sub

    Sub UploadNewFile()

        Dim strFileNamePath As String = fileuploadExcel.PostedFile.FileName

        If strFileNamePath.Length > 0 Then

            Dim strFileNameOnly As String
            Dim strSaveLocation As String

            strFileNameOnly = System.IO.Path.GetFileName(fileuploadExcel.PostedFile.FileName)

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(.*?)\.(xls|xlsx)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "d:\DCS\fsaoperations\internal\SpecialtyClaims\FileUploads\" & strFileNameOnly
            'strSaveLocation = "C:\Users\Eric\Dropbox\fsaoperations\SpecialtyClaims\FileUploads\" & strFileNameOnly
            Try
                fileuploadExcel.PostedFile.SaveAs(strSaveLocation)
                ImportFile(strFileNameOnly)

                'Rename the file so we can be sure to find it in ImportFile()
                'My.Computer.FileSystem.RenameFile(strFileNameOnly, "refunds.xlsx")
                'Catch ex As Exception
                'lblMessage.Text = "Your file import failed with error message" & ex.Message
            Finally

            End Try
        End If
    End Sub

    Sub ImportFile(ByVal FileName As String)
        If fileuploadExcel.FileName <> "" Then
            Dim path = fileuploadExcel.PostedFile.FileName
            Dim tableName As String = "Claims_Upload"
            Dim extension As String = System.IO.Path.GetExtension(fileuploadExcel.PostedFile.FileName)
            Dim excelConnectionString As String
            Dim conn As SqlConnection = New SqlConnection(connStr)

            excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=d:\DCS\fsaoperations\internal\SpecialtyClaims\FileUploads\" & FileName & ";Extended Properties=Excel 8.0;Persist Security Info=False"
            'excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\Users\Eric\Dropbox\fsaoperations\SpecialtyClaims\FileUploads\" & FileName & ";Extended Properties=Excel 8.0;Persist Security Info=False"

            Dim excelConnection As OleDbConnection = New OleDbConnection(excelConnectionString)
            conn.Open()

            Dim comm As SqlCommand = New SqlCommand("truncate table " & tableName, conn)

            Dim cmd As OleDbCommand = New OleDbCommand("SELECT AccountNumber, BorrowerName, DischargeType, Servicer, DateReceived FROM [Sheet1$]", excelConnection)
            excelConnection.Open()

            Dim dr As OleDbDataReader
            dr = cmd.ExecuteReader()
            'identityChange.ExecuteNonQuery()

            Dim sqlBulk As SqlBulkCopy = New SqlBulkCopy(connStr)

            'Set the destination table name
            sqlBulk.DestinationTableName = tableName
            sqlBulk.WriteToServer(dr)
            excelConnection.Close()
            conn.Close()
            lblMessage.ForeColor = Drawing.Color.Green
            lblMessage.Text = "Import was successful!<br />"

            'Delete the records with missing account numbers
            DeleteNullRecords()
        Else
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Text = "Please select Excel file to upload"
        End If
    End Sub

    Sub DeleteNullRecords()
        'Deletes NULL records from table Claims_Upload 
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Delete_NULL_Claims_New"
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

            'Now copy the records from table Refunds_Upload to Refunds
            CopyNewRecords()
        End Try
    End Sub

    Sub CopyNewRecords()
        'Copies records from table Claims_Upload to Claims
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Insert_Claims_New"
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
        End Try
    End Sub
End Class
