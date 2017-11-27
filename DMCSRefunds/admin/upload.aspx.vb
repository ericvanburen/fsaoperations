Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports Telerik.Web.UI

Partial Class DMCSRefunds_admin_upload
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("DMCSRefunds_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            RadMenu1.LoadContentFile("~/DMCSRefunds/Menu.xml")

            'Deletes old records from table Refunds_Upload
            DeleteOldRecords()
        End If
    End Sub

    Sub UploadFile_Click(ByVal sender As Object, ByVal e As EventArgs)

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

            'strSaveLocation = "d:\DCS\fsaoperations\internal\DMCSRefunds\FileUploads\" & strFileNameOnly
            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\fsaoperations\DMCSRefunds\FileUploads\" & strFileNameOnly
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
            Dim tableName As String = "Refunds_Upload"
            Dim extension As String = System.IO.Path.GetExtension(fileuploadExcel.PostedFile.FileName)
            Dim excelConnectionString As String
            Dim conn As SqlConnection = New SqlConnection(connStr)

            'If extension = ".xls" Then
            'excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=d:\DCS\fsaoperations\internal\DMCSRefunds\FileUploads\" & FileName & ";Extended Properties=Excel 12.0;Persist Security Info=False"
            'excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Eric\Dropbox\fsaoperations\DMCSRefunds\FileUploads\refunds.xls;Extended Properties=Excel 8.0;Persist Security Info=False"
            excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\ericv_000\Dropbox\fsaoperations\fsaoperations\DMCSRefunds\FileUploads\" & FileName & ";Extended Properties=Excel 8.0;Persist Security Info=False"
            'ElseIf extension = ".xlsx" Then
            'excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & Server.MapPath(path) & ";Extended Properties=Excel 12.0;Persist Security Info=False"
            'End If

            Dim excelConnection As OleDbConnection = New OleDbConnection(excelConnectionString)
            conn.Open()

            Dim comm As SqlCommand = New SqlCommand("truncate table " & tableName, conn)

            Dim cmd As OleDbCommand = New OleDbCommand("SELECT BorrowerNumber, TagDate FROM [Sheet1$]", excelConnection)
            excelConnection.Open()

            Dim dr As OleDbDataReader
            dr = cmd.ExecuteReader()
            'identityChange.ExecuteNonQuery()

            Dim sqlBulk As SqlBulkCopy = New SqlBulkCopy(connStr)

            'Set the destination table name
            sqlBulk.DestinationTableName = tableName
            sqlBulk.WriteToServer(dr)
            excelConnection.Close()
            excelConnection.Dispose()
            conn.Close()
            lblMessage.ForeColor = Drawing.Color.Green
            lblMessage.Text = "Import was successful!<br />"

            'Sometimes junk records are imported with missing borrower numbers.  These need to be deleted
            DeleteBadBorrowerNumbers()

            'Now copy the records from table Refunds_Upload to Refunds
            SelectNewRefunds()

        Else
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Text = "Please select Excel file to upload"
        End If
    End Sub

    Sub DeleteOldRecords() 'Runs on page_load
        'Deletes old records from table Refunds_Upload
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Delete_Refunds_Upload"
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

    Sub DeleteBadBorrowerNumbers()
        'Sometimes junk records are imported with missing borrower numbers.  These need to be deleted
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Delete_Null_Rows"
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

    Sub SelectNewRefunds()

        'For i As Integer = 0 To userArray.Count - 1
        'Response.Write(userArray(i).ToString() + "<br/>")
        'Dim Rand As New Random()
        'Dim Index As Integer = Rand.Next(0, userArray.Count - 1)
        'Dim randomUser = userArray(Index)
        'Next

        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim UserID As String

        Dim con As SqlConnection = New SqlConnection(connStr)
        cmd = New SqlCommand("p_SelectNewRefunds", con)
        cmd.CommandType = CommandType.StoredProcedure

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    UserID = GetRandomUser()
                    InsertNewRefunds(UserID, dr("BorrowerNumber"), dr("TagDate"))
                    'Response.Write(randomUser)
                End While
            End Using

            'Delete the duplicates in the Refunds table
            DeleteDuplicates()

        Catch ex As Exception
            lblMessage.Text = ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        Finally
            con.Close()
        End Try
    End Sub

    Private Function GetRandomUser() As String
        Dim UserID As String = ""
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        Dim con As SqlConnection = New SqlConnection(connStr)
        cmd = New SqlCommand("p_ActiveUsers", con)
        cmd.CommandType = CommandType.StoredProcedure

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    UserID = dr("UserID")
                End While
            End Using

        Finally
            con.Close()
        End Try
        Return UserID
    End Function

    Sub InsertNewRefunds(ByVal UserID As String, ByVal BorrowerNumber As String, ByVal TagDate As Date)
        'Copies records from table Refunds_Upload to Refunds
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Insert_NewRefunds"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = UserID
        cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = BorrowerNumber
        cmd.Parameters.Add("@TagDate", SqlDbType.SmallDateTime).Value = TagDate

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

    'Sub CopyNewRecords()
    '    'Copies records from table Refunds_Upload to Refunds
    '    Dim strSql As String
    '    Dim cmd As SqlCommand

    '    Dim strConnection As SqlConnection = New SqlConnection(connStr)
    '    strSql = "p_Insert_Refunds"
    '    cmd = New SqlCommand(strSql)
    '    cmd.CommandType = CommandType.StoredProcedure
    '    Try
    '        strConnection.Open()
    '        cmd.Connection = strConnection
    '        cmd.ExecuteNonQuery()
    '        'Sometimes junk records are imported with missing borrower numbers.  These need to be deleted
    '        DeleteBadBorrowerNumbers()
    '    Catch ex As Exception
    '        lblMessage.Text = ex.Message
    '        lblMessage.ForeColor = Drawing.Color.Red
    '    Finally
    '        strConnection.Close()
    '    End Try
    'End Sub


    Protected Sub DeleteDuplicates()
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_DeleteDuplicateRefunds"
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
