Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_QCTierReport
    Inherits System.Web.UI.Page

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        ' Verifies that the control is rendered 
    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            'If Roles.IsUserInRole("PCAReviews_Admins") = False Then
            '    Response.Redirect("/Account/Login.aspx")
            'End If
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_QCTiersReport", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtBeginDate.Text <> "" Then
            cmd.Parameters.Add("@BeginDate", SqlDbType.SmallDateTime).Value = txtBeginDate.Text
        End If

        If txtEndDate.Text <> "" Then
            cmd.Parameters.Add("@EndDate", SqlDbType.SmallDateTime).Value = txtEndDate.Text
        End If

        If ddlReviewPeriodMonth.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ReviewPeriodMonth", SqlDbType.VarChar).Value = ddlReviewPeriodMonth.SelectedValue
        End If

        If ddlReviewPeriodYear.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ReviewPeriodYear", SqlDbType.VarChar).Value = ddlReviewPeriodYear.SelectedValue
        End If


        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Reviews")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            GridView1.DataSource = ds.Tables("Reviews").DefaultView
            GridView1.DataBind()

            If Roles.IsUserInRole("PCAReviews_QCTier2") = False And Roles.IsUserInRole("PCAReviews_QCTier3") = False Then
                GridView1.Columns(8).Visible = False
                GridView1.Columns(9).Visible = False
                GridView1.Columns(10).Visible = False
            End If


            'Make search again button visible
            btnSearchAgain.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, e As EventArgs)
        Response.Redirect("QCTierReport.aspx")
        btnExportExcel.Visible = False
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=QCTier_Report.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
