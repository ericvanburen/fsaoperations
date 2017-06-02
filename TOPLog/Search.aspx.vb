Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class TOPLog_Search
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            ddlUserID.DataSource = Roles.GetUsersInRole("TOPLog")
            ddlUserID.DataBind()
        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        'Include Errors
        If ddlIncludeErrors.SelectedValue <> "" Then
            cmd.Parameters.Add("@IncludeErrors", SqlDbType.VarChar).Value = ddlIncludeErrors.SelectedValue
        End If

        'TOPLogID
        If txtTOPLogID.Text <> "" Then
            cmd.Parameters.Add("@TOPLogID", SqlDbType.Int).Value = Convert.ToInt32(txtTOPLogID.Text)
        End If

        'This one passes a comma-delimited string for @UserID which is used in the split function
        If ddlUserID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlUserID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
        End If

        'ApprovalStatus
        If ddlApprovalStatus.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlApprovalStatus.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ApprovalStatus", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Action
        If ddlAction.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlAction.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Action", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Borrower Number
        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        End If

        'DateAddedGreaterThan
        If txtDateAddedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateAddedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateAddedGreaterThan.Text
        End If

        'DateAddedLessThan
        If txtDateAddedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateAddedLessThan", SqlDbType.SmallDateTime).Value = txtDateAddedLessThan.Text
        End If

        'DateAssignedGreaterThan
        If txtDateAssignedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateAssignedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateAssignedGreaterThan.Text
        End If

        'DateAssignedLessThan
        If txtDateAssignedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateAssignedLessThan", SqlDbType.SmallDateTime).Value = txtDateAssignedLessThan.Text
        End If

        'DateApprovedGreaterThan
        If txtDateApprovedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateApprovedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateApprovedGreaterThan.Text
        End If

        'DateApprovedLessThan
        If txtDateApprovedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateApprovedLessThan", SqlDbType.SmallDateTime).Value = txtDateApprovedLessThan.Text
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "TOPLog")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            GridView1.DataSource = ds.Tables("TOPLog").DefaultView
            GridView1.DataBind()

            'Make search again button visible
            btnSearchAgain.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, e As EventArgs)
        Response.Redirect("Search.aspx")
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=TOPLog_Search_Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
