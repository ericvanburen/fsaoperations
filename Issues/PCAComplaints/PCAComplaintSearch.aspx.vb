Imports System.Data
Imports System.Data.SqlClient

Partial Class Issues_PCAComplaintSearch
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            ddlUserID.DataSource = Roles.GetUsersInRole("Issues_PCAComplaints")
            ddlUserID.DataBind()
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCAComplaintsSearch", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_PCAComplaintsSearch uses dynamic SQL so we pass a value to it only when there is one
        If txtDateReceivedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateReceivedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateReceivedGreaterThan.Text
        End If

        If txtDateReceivedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateReceivedLessThan", SqlDbType.SmallDateTime).Value = txtDateReceivedLessThan.Text
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

        'ReceivedBy
        If ddlReceivedBy.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ReceivedBy", SqlDbType.VarChar).Value = ddlReceivedBy.SelectedValue
        End If

        'BorrowerNumber
        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.AddWithValue("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        End If

        'BorrowerName
        If txtBorrowerName.Text <> "" Then
            cmd.Parameters.AddWithValue("@BorrowerName", SqlDbType.VarChar).Value = txtBorrowerName.Text
        End If

        'ComplaintSource
        If ddlComplaintSource.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ComplaintSource", SqlDbType.VarChar).Value = ddlComplaintSource.SelectedValue
        End If

        'Source
        If ddlSource.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Source", SqlDbType.VarChar).Value = ddlSource.SelectedValue
        End If

        'Severity
        If ddlSeverity.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Severity", SqlDbType.VarChar).Value = ddlSeverity.SelectedValue
        End If

        'Validity
        If ddlValidity.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Validity", SqlDbType.VarChar).Value = ddlValidity.SelectedValue
        End If

        'DateResolved
        If txtDateResolvedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateResolvedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateResolvedGreaterThan.Text
        End If

        If txtDateResolvedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateResolvedLessThan", SqlDbType.SmallDateTime).Value = txtDateResolvedLessThan.Text
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
        Response.Redirect("PCAComplaintSearch.aspx")
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCAComplaints_Search_Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
