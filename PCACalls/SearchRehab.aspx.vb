Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class PCACalls_SearchRehab
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            ddlUserID.DataSource = Roles.GetUsersInRole("PCACalls")
            ddlUserID.DataBind()

            If Roles.IsUserInRole("PCACalls_Admins") = False Then
                'GridView1.Columns.RemoveAt(22)
                GridView1.Columns(37).Visible = False
            End If

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

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_RehabSearch", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtRehabCallID.Text <> "" Then
            cmd.Parameters.Add("@RehabCallID", SqlDbType.Int).Value = Convert.ToInt32(txtRehabCallID.Text)
        End If

        If txtCallDate.Text <> "" Then
            cmd.Parameters.Add("@CallDate", SqlDbType.SmallDateTime).Value = txtCallDate.Text
        End If

        If txtCallDateGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@CallDateGreaterThan", SqlDbType.SmallDateTime).Value = txtCallDateGreaterThan.Text
        End If

        If txtCallDateLessThan.Text <> "" Then
            cmd.Parameters.Add("@CallDateLessThan", SqlDbType.SmallDateTime).Value = txtCallDateLessThan.Text
        End If

        'This one passes a comma-delimited string for @PCAID which is used in the split function
        If ddlPCAID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlPCAID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@PCAID", SqlDbType.VarChar).Value = strSearchValue
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

        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.AddWithValue("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        End If

        'This one passes a comma-delimited string for @ReportQuarter which is used in the split function
        If ddlReportQuarter.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReportQuarter.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ReportQuarter", SqlDbType.VarChar).Value = strSearchValue
        End If

        'This one passes a comma-delimited string for @ReportYear which is used in the split function
        If ddlReportYear.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReportYear.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ReportYear", SqlDbType.VarChar).Value = strSearchValue
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Reviews")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            GridView1.DataSource = ds.Tables("Reviews").DefaultView
            GridView1.DataBind()

            'Make search again button visible
            btnSearchAgain.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, e As EventArgs)
        Response.Redirect("SearchRehab.aspx")
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=RehabReviews_Search_Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
