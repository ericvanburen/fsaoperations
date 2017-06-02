Imports System.Data.SqlClient
Imports System.Data.OleDb.OleDbCommand
Imports System.Data.OleDb.OleDbConnection

Partial Class TOPLog_Upload
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("TOPLog_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            'Deletes old records from table TOPLogUpload
            DeleteOldRecords()
        End If
    End Sub

    Sub UploadFile_Click(ByVal sender As Object, ByVal e As EventArgs)

        'Deletes old records from table TOPLogUpload
        DeleteOldRecords()

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

            'Upload location for production
            'strSaveLocation = "d:\DCS\fsaoperations\internal\TOPLog\FileUploads\" & strFileNameOnly

            'Upload location for development
            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\TOPLog\FileUploads\" & strFileNameOnly
            Try
                fileuploadExcel.PostedFile.SaveAs(strSaveLocation)
                ImportFile(strFileNameOnly)
            Finally

            End Try
        End If
    End Sub

    Sub ImportFile(ByVal FileName As String)
        If fileuploadExcel.FileName <> "" Then
            Dim path = fileuploadExcel.PostedFile.FileName
            Dim tableName As String = "TOPLogUpload"
            Dim extension As String = System.IO.Path.GetExtension(fileuploadExcel.PostedFile.FileName)
            Dim excelConnectionString As String
            Dim conn As SqlConnection = New SqlConnection(connStr)

            'Connection Sting For Production
            'excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=d:\DCS\fsaoperations\internal\TOPLog\FileUploads\" & FileName & ";Extended Properties=Excel 8.0;Persist Security Info=False"

            'Connection String for Development
            excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\ericv_000\Dropbox\fsaoperations\TOPLog\FileUploads\" & FileName & ";Extended Properties=Excel 8.0;Persist Security Info=False"

            Dim excelConnection As OleDbConnection = New OleDbConnection(excelConnectionString)
            conn.Open()

            Dim comm As SqlCommand = New SqlCommand("truncate table " & tableName, conn)

            Dim cmd As OleDbCommand = New OleDbCommand("SELECT LogDate, RowID, BorrowerNumber, Action, NewOffsetAmount FROM [Sheet1$]", excelConnection)
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

            'Now copy the records from table TOPLogUpload to TOPLog
            CopyNewRecords()

        Else
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Text = "Please select Excel file to upload"
        End If
    End Sub

    Sub DeleteOldRecords()
        'Deletes old records from table TOPLogUpload
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Delete_TOPLog_Upload"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = sqlCommandType.StoredProcedure
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

    Sub CopyNewRecords()
        'Copies records from table TOPLogUpload to TOPLog
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Insert_TOPLog"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            'Sometimes junk records are imported with missing borrower numbers.  These need to be deleted
            DeleteBadBorrowerNumbers()
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

            'Now show the new records in the Gridview
            BindGridView()

        Catch ex As Exception
            lblMessage.Text = ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        Finally
            strConnection.Close()
        End Try
    End Sub

    Protected Sub grdTOPLog_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdTOPLog.PageIndex = e.NewPageIndex
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        cmd = New SqlCommand("p_TOPLogUpload_AllRecords", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "TOPLog")

            lblRowCount.ForeColor = Drawing.Color.Green
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "The import was successul!  You imported " & intRecordCount & " new TOP records today."

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            grdTOPLog.DataSource = ds.Tables("TOPLog").DefaultView
            grdTOPLog.DataBind()

        Finally
            strSQLConn.Close()
        End Try
    End Sub



End Class
