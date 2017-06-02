Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports FormatParagraph

Partial Class CCM_New_ReportAccuracy
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            txtDateofReviewEnd.Text = Now.ToShortDateString()
        End If

    End Sub

    Sub btnAccuracyReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        CallCount()
    End Sub


    Sub CallCount()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim da As SqlDataAdapter
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReportCallCount", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = ddlCallCenterID.SelectedValue
        cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
        cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text
        da = New SqlDataAdapter(cmd)
        Try
            strSQLConn.Open()
            ds = New DataSet()
            da.Fill(ds)

            rptCenterProfile.DataSource = ds
            rptCenterProfile.DataBind()

            'Create all centers accuracy report
            BindGridView()
        Finally
            strSQLConn.Close()
        End Try
    End Sub


    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AccuracyReport_Scores", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        cmd.Parameters.AddWithValue("@BeginDateofReview", txtDateofReviewBegin.Text)
        cmd.Parameters.AddWithValue("@EndDateofReview", txtDateofReviewEnd.Text)

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")

            grdVariablePeriod.DataSource = ds.Tables("Requests").DefaultView
            grdVariablePeriod.DataBind()

            grdVariablePeriod.Visible = True

            BindGridView_FailedCalls()
        Finally
            strSQLConn.Close()
        End Try
    End Sub


    'Sub BindGridView_FailedCalls()
    '    Dim strSQLConn As SqlConnection
    '    Dim cmd As SqlCommand
    '    Dim ds As DataSet

    '    strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
    '    cmd = New SqlCommand("p_Report_NotesErrors", strSQLConn)
    '    cmd.CommandType = CommandType.StoredProcedure
    '    cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
    '    cmd.Parameters.Add("@DateofReviewBegin", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
    '    cmd.Parameters.Add("@DateofReviewEnd", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text

    '    Try
    '        strSQLConn.Open()
    '        Dim MyAdapter As New SqlDataAdapter(cmd)

    '        ds = New DataSet()
    '        MyAdapter.Fill(ds, "Requests")

    '        'Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
    '        'lblRowCount.Text = "Your search returned " & intRecordCount & " records"

    '        grdFailedCalls.DataSource = ds.Tables("Requests").DefaultView
    '        ds.Tables(0).DefaultView.Sort = lblSortExpression.Text
    '        grdFailedCalls.DataBind()
    '        rptFailedCalls.DataBind()

    '        'grdFailedCalls.Visible = True

    '        'Make the Excel export button visible
    '        btnExportWordAccuracy.Visible = True
    '        btnExportWordNotes.Visible = True
    '    Finally
    '        strSQLConn.Close()
    '    End Try
    'End Sub

    Sub BindGridView_FailedCalls()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Report_NotesErrors", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        cmd.Parameters.Add("@DateofReviewBegin", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
        cmd.Parameters.Add("@DateofReviewEnd", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
            rptFailedCalls.DataSource = ds
            rptFailedCalls.DataBind()

            'Make the Excel export button visible
            btnExportWordAccuracy.Visible = True
            btnExportWordNotes.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnExportWordAccuracy_Click(ByVal sender As Object, ByVal e As EventArgs)

        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition",
        "attachment;filename=NotesAccuracy.doc")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-word "
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        grdVariablePeriod.AllowPaging = False
        grdVariablePeriod.RenderControl(hw)
        Response.Output.Write(sw.ToString())
        Response.Flush()
        Response.End()
    End Sub


    Protected Sub btnExportWordNotes_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Response.Clear()
        'Response.Buffer = True
        'Response.AddHeader("content-disposition", "attachment;filename=NotesObservations.doc")
        'Response.Charset = ""
        'Response.ContentType = "application/vnd.ms-word "
        'Response.Write("<html>")
        'Response.Write("<head>")
        'Response.Write("<META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>")
        'Response.Write("<meta name=ProgId content=Word.Document>")
        'Response.Write("<meta name=Generator content='Microsoft Word 9'>")
        'Response.Write("<meta name=Originator content='Microsoft Word 9'>")
        'Response.Write("<style>")
        'Response.Write("@page Section1 {size:595.45pt 841.7pt; margin:1.0in 1.25in 1.0in 1.25in;mso-header-margin:.5in;mso-footer-margin:.5in;mso-paper-source:0;}")
        'Response.Write("div.Section1 {page:Section1;}")
        'Response.Write("@page Section2 {size:841.7pt 595.45pt;mso-page-orientation:landscape;margin:1.25in 1.0in 1.25in 1.0in;mso-header-margin:.5in;mso-footer-margin:.5in;mso-paper-source:0;}")
        'Response.Write("div.Section2 {page:Section2;}")
        'Response.Write("</style>")
        'Response.Write("</head>")
        'Response.Write("<body>")
        'Response.Write("<div class=Section2>")
        'Dim sw As New StringWriter()
        'Dim hw As New HtmlTextWriter(sw)
        'grdFailedCalls.AllowPaging = False
        ''grdFailedCalls.DataBind()
        'grdFailedCalls.RenderControl(hw)
        'Response.Write(sw.ToString())
        'Response.Write("</div>")
        'Response.Write("</body>")
        'Response.Write("</html>")
        'Response.Flush()
        'Response.End()

        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=NotesObservations.doc")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-word "
        Response.Write("<html>")
        Response.Write("<head>")
        Response.Write("<META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>")
        Response.Write("<meta name=ProgId content=Word.Document>")
        Response.Write("<meta name=Generator content='Microsoft Word 9'>")
        Response.Write("<meta name=Originator content='Microsoft Word 9'>")
        Response.Write("<style>")
        Response.Write("@page Section1 {size:595.45pt 841.7pt; margin:1.0in 1.25in 1.0in 1.25in;mso-header-margin:.5in;mso-footer-margin:.5in;mso-paper-source:0;}")
        Response.Write("div.Section1 {page:Section1;}")
        Response.Write("@page Section2 {size:841.7pt 595.45pt;mso-page-orientation:landscape;margin:1.25in 1.0in 1.25in 1.0in;mso-header-margin:.5in;mso-footer-margin:.5in;mso-paper-source:0;}")
        Response.Write("div.Section2 {page:Section2;}")
        Response.Write("</style>")
        Response.Write("</head>")
        Response.Write("<body>")
        Response.Write("<div class=Section2>")
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        rptFailedCalls.RenderControl(hw)
        Response.Write(sw.ToString())
        Response.Write("</div>")
        Response.Write("</body>")
        Response.Write("</html>")
        Response.Flush()
        Response.End()
    End Sub
   
End Class
