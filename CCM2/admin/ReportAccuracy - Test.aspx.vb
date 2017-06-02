Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Csv
Imports SelectPdf

Partial Class CCM_New_ReportAccuracy
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Protected Sub btnExportPDF_Click(sender As Object, e As ImageClickEventArgs)

        ' instantiate a html to pdf converter object
        Dim converter As New HtmlToPdf()

        ' create a new pdf document converting an url
        Dim doc As PdfDocument = converter.ConvertUrl("http://localhost:49542/CCM2/admin/ReportAccuracy - Test.aspx")

        ' save pdf document
        doc.Save(Response, False, "Accuracy_Report.pdf")
        'doc.Save(Response, False, "FinalReport.pdf")

        ' close pdf document
        doc.Close()
    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            txtDateofReviewEnd.Text = Now.ToShortDateString()

            CallCount()
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
        cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = 1
        cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = "1/1/2000"
        cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = "5/1/2017"
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


        Finally
            strSQLConn.Close()
        End Try
    End Sub

    
   

   
End Class
