Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports Telerik.Web.UI

Partial Class DMCSRefunds_admin_upload
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
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

            strSaveLocation = "d:\DCS\fsaoperations\internal\DMCSRefunds\FileUploads\" & strFileNameOnly
            'strSaveLocation = "C:\Users\Acer\Dropbox\fsaoperations\DMCSRefunds\FileUploads\" & strFileNameOnly
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
            excelConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=d:\DCS\fsaoperations\internal\DMCSRefunds\FileUploads\" & FileName & ";Extended Properties=Excel 12.0;Persist Security Info=False"
            'excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Eric\Dropbox\fsaoperations\DMCSRefunds\FileUploads\refunds.xls;Extended Properties=Excel 8.0;Persist Security Info=False"
            'excelConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Users\Acer\Dropbox\fsaoperations\DMCSRefunds\FileUploads\" & FileName & ";Extended Properties=Excel 8.0;Persist Security Info=False"
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

            'Now copy the records from table Refunds_Upload to Refunds
            CopyNewRecords()

            'Show the new records in the GridView
            'grdRefunds.DataBind()

        Else
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Text = "Please select Excel file to upload"
        End If
    End Sub

    Sub DeleteOldRecords()
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

    Sub CopyNewRecords()
        'Copies records from table Refunds_Upload to Refunds
        Dim strSql As String
        Dim cmd As SqlCommand

        Dim strConnection As SqlConnection = New SqlConnection(connStr)
        strSql = "p_Insert_Refunds"
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
        Catch ex As Exception
            lblMessage.Text = ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        Finally
            strConnection.Close()
        End Try
    End Sub

    Private Sub FindCheckedRows()
        Dim checkedRowsList As ArrayList
        If ViewState("checkedRowsList") IsNot Nothing Then
            checkedRowsList = DirectCast(ViewState("checkedRowsList"), ArrayList)
        Else
            checkedRowsList = New ArrayList()
        End If

        For Each gvRow As GridViewRow In grdRefunds.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(grdRefunds.DataKeys(gvRow.RowIndex)("RefundID"))
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

    Protected Sub grdRefunds_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdRefunds.PageIndex = e.NewPageIndex
        FindCheckedRows()
    End Sub

    Protected Sub grdRefunds_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)
            Dim gvRow As GridViewRow = e.Row
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)
                Dim rowIndex As String = Convert.ToString(grdRefunds.DataKeys(gvRow.RowIndex)("RefundID"))

                If checkedRowsList.Contains(rowIndex) Then
                    chkSelect.Checked = True
                End If
            End If
        End If
    End Sub

    Sub btnRefundsMenu_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        Select Case e.CommandArgument
            Case "Unassigned"
                'Call the BindGridView method with the correct argument
                'BindGridView(CType(e.CommandArgument, String))
                BindGridView("p_Refunds_Unassigned")
            Case ""
            Case ""
        End Select
    End Sub

    Sub BindGridView(ByVal procName As String)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString)
        cmd = New SqlCommand(procName, strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Refunds")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your list contains " & intRecordCount & " refunds"

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            grdRefunds.DataSource = ds.Tables("Refunds").DefaultView
            grdRefunds.DataBind()

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub GridView1_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim strSortString = Convert.ToString(e.SortExpression) & " " & GetSortDirection(e.SortDirection)
        lblSortExpression.Text = strSortString.ToString
        'Now bind the gridview with the results
        'BindGridView()
    End Sub

    Private Function GetSortDirection(ByVal column As String) As String
        ' By default, set the sort direction to ascending. 
        Dim sortDirection = "ASC"
        ' Retrieve the last column that was sorted. 
        Dim sortExpression = TryCast(ViewState("SortExpression"), String)
        If sortExpression IsNot Nothing Then
            ' Check if the same column is being sorted. 
            ' Otherwise, the default value can be returned. 
            If sortExpression = column Then
                Dim lastDirection = TryCast(ViewState("SortDirection"), String)
                If lastDirection IsNot Nothing _
                AndAlso lastDirection = "ASC" Then
                    sortDirection = "DESC"
                End If
            End If
        End If
        ' Save new values in ViewState. 
        ViewState("SortDirection") = sortDirection
        ViewState("SortExpression") = column
        Return sortDirection
    End Function


    Protected Sub btnDeleteDuplicates_Click(sender As Object, e As EventArgs)
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
            lblMessage.Text = "Duplicates were deleted"
        End Try
    End Sub
End Class
