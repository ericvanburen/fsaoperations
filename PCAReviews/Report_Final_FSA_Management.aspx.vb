Imports System.Data.SqlClient
Imports System.Data
Imports System.IO
Imports SelectPdf

Partial Class PCAReviews_Report_Final
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim strReviewPeriodMonth As String = ddlReviewPeriodMonth.SelectedValue
            Dim strReviewPeriodYear As String = ddlReviewPeriodYear.SelectedValue
            lblTodayDate.Text = Date.Today
            lblPDFUrl.Text = "http://localhost:49542/PCAReviews/Report_Final.aspx?ReviewPeriodMonth=" & strReviewPeriodMonth & "&ReviewPeriodYear=" & strReviewPeriodYear
        End If

    End Sub

    Protected Sub btnExportPDF_Click(sender As Object, e As ImageClickEventArgs)

        ' instantiate a html to pdf converter object
        Dim converter As New HtmlToPdf()

        ' create a new pdf document converting an url
        Dim doc As PdfDocument = converter.ConvertUrl(lblPDFUrl.Text)

        ' save pdf document
        doc.Save(Response, False, "Sample.pdf")

        ' close pdf document
        doc.Close()
    End Sub

    Protected Sub ddlReviewPeriod_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim strReviewPeriodMonth As String = ddlReviewPeriodMonth.SelectedValue
        Dim strReviewPeriodYear As String = ddlReviewPeriodYear.SelectedValue
        lblReviewPeriod.Text = strReviewPeriodMonth & "/" & strReviewPeriodYear

        dsTotalErrors.SelectParameters("ReportPeriodMonth").DefaultValue = strReviewPeriodMonth
        dsTotalErrors.SelectParameters("ReportPeriodYear").DefaultValue = strReviewPeriodYear
        lblPDFUrl.Text = "http://localhost:49542/PCAReviews/Report_Final_FSA_Management.aspx?ReviewPeriodMonth=" & strReviewPeriodMonth & "&ReviewPeriodYear=" & strReviewPeriodYear

    End Sub

   
    Protected Sub ddlPCAID_SelectedIndexChanged(sender As Object, e As EventArgs)
        dsIncorrectPerPCA.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
    End Sub
End Class
