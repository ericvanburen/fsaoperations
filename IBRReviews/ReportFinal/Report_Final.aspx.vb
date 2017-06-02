Imports System.Data.SqlClient
Imports System.Data
Imports System.IO
Imports SelectPdf

Partial Class PCAReviews_Report_Final
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Request.QueryString("ReportQuarter") Is Nothing Then
            Dim strReportQuarter As String = Request.QueryString("ReportQuarter")
            Dim strReportYear As String = Request.QueryString("ReportYear")
            Dim strPCA As String = Server.UrlDecode(Request.QueryString("PCA"))
            Dim strPCAID As String = Server.UrlDecode(Request.QueryString("PCAID"))
            Dim strQuarter As String = ""

            lblTodayDate.Text = Date.Today
            lblPCAName.Text = strPCA

            Select Case strReportQuarter
                Case "1"
                    strQuarter = "1st Qtr (Oct, Nov, Dec)"
                Case "2"
                    strQuarter = "2nd Qtr (Jan, Feb, Mar)"
                Case "3"
                    strQuarter = "3rd Qtr (Apr, May, Jun)"
                Case "4"
                    strQuarter = "4th Qtr (Jul, Aug, Sep)"
            End Select

            lblReviewPeriod.Text = strQuarter & ", " & "FY" & strReportYear

            lblPDFUrl.Text = "http://localhost:49542/IBRReviews/ReportFinal/Report_Final.aspx?ReportQuarter=" & strReportQuarter & "&ReportYear=" & strReportYear & "&PCA=" & strPCA & "&PCAID=" & strPCAID
            LoadData(strPCAID, strReportQuarter, strReportYear)
        End If
    End Sub

    

    Sub LoadData(PCAID As String, ReportQuarter As String, ReportYear As String)

        'Clear the Observations section of any old values
        lblAgreementLetterResults.Text = ""
        lblRehabDocsResults.Text = ""
        lblRepaymentAmountResults.Text = ""
        lblIDRTagResults.Text = ""

        'First we need to clear the form of any previous search results
        lblTotal_AnyErrors.Text = "0"
        lblTotal_AnyErrors_Percent.Text = "0%"

        lblScore_Agreement_Letter_Signed_Errors.Text = "0"
        lblScore_Agreement_Letter_Signed_Errors_Percent.Text = "0%"

        lblScore_Financial_Documentation_Errors.Text = "0"
        lblScore_Financial_Documentation_Errors_Percent.Text = "0%"

        lblScore_Repayment_Amount_Errors.Text = "0"
        lblScore_Repayment_Amount_Errors_Percent.Text = "0%"

        lblScore_Tag_Errors.Text = "0"
        lblScore_Tag_Errors_Percent.Text = "0%"

        lblPopulationSize.Text = ""

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReportSummary", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = PCAID
        cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = ReportQuarter
        cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = ReportYear

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    If Not dr("Total_AnyErrors") Is DBNull.Value Then
                        lblTotal_AnyErrors.Text = dr("Total_AnyErrors").ToString()
                    End If

                    If Not dr("Total_AnyErrors_Percent") Is DBNull.Value Then
                        lblTotal_AnyErrors_Percent.Text = dr("Total_AnyErrors_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Agreement_Letter_Signed_Errors") Is DBNull.Value And dr("Score_Agreement_Letter_Signed_Errors") <> "0" Then
                        lblScore_Agreement_Letter_Signed_Errors.Text = dr("Score_Agreement_Letter_Signed_Errors").ToString()
                        lblAgreementLetterResults.Text = lblTotal_AnyErrors.Text & " accounts were reviewed and " & lblScore_Agreement_Letter_Signed_Errors.Text & " (" & dr("Score_Agreement_Letter_Signed_Percent") & "%)" & " did not have the Rehabilitation Agreement Letter in DMCS."
                    Else
                        lblAgreementLetterResults.Text = "No observable issues were found."
                    End If

                    If Not dr("Score_Agreement_Letter_Signed_Percent") Is DBNull.Value Then
                        lblScore_Agreement_Letter_Signed_Errors_Percent.Text = dr("Score_Agreement_Letter_Signed_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Financial_Documentation_Errors") Is DBNull.Value And dr("Score_Financial_Documentation_Errors") <> "0" Then
                        lblScore_Financial_Documentation_Errors.Text = dr("Score_Financial_Documentation_Errors").ToString()
                        lblRehabDocsResults.Text = lblTotal_AnyErrors.Text & " accounts were reviewed and " & lblScore_Financial_Documentation_Errors.Text & " (" & dr("Score_Financial_Documentation_Percent") & "%)" & " did not have the Rehabilitation Agreement Letter in DMCS."
                    Else
                        lblRehabDocsResults.Text = "No observable issues were found."
                    End If

                    If Not dr("Score_Financial_Documentation_Percent") Is DBNull.Value Then
                        lblScore_Financial_Documentation_Errors_Percent.Text = dr("Score_Financial_Documentation_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Repayment_Amount_Errors") Is DBNull.Value And dr("Score_Repayment_Amount_Errors") <> "0" Then
                        lblScore_Repayment_Amount_Errors.Text = dr("Score_Repayment_Amount_Errors").ToString()
                        lblRepaymentAmountResults.Text = lblTotal_AnyErrors.Text & " accounts were reviewed and " & lblScore_Repayment_Amount_Errors.Text & " (" & dr("Score_Repayment_Amount_Percent") & "%)" & " did not have the Rehabilitation Agreement Letter in DMCS."
                    Else
                        lblRepaymentAmountResults.Text = "No observable issues were found."
                    End If

                    If Not dr("Score_Repayment_Amount_Percent") Is DBNull.Value Then
                        lblScore_Repayment_Amount_Errors_Percent.Text = dr("Score_Repayment_Amount_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Tag_Errors") Is DBNull.Value And dr("Score_Tag_Errors") <> "0" Then
                        lblScore_Tag_Errors.Text = dr("Score_Tag_Errors").ToString()
                        lblIDRTagResults.Text = lblTotal_AnyErrors.Text & " accounts were reviewed and " & lblScore_Tag_Errors.Text & " (" & dr("Score_Tag_Percent") & "%)" & " did not have the Rehabilitation Agreement Letter in DMCS."
                    Else
                        lblIDRTagResults.Text = "No observable issues were found."
                    End If

                    If Not dr("Score_Tag_Percent") Is DBNull.Value Then
                        lblScore_Tag_Errors_Percent.Text = dr("Score_Tag_Percent").ToString() & "%"
                    End If

                    If Not dr("PopulationSize") Is DBNull.Value Then
                        lblPopulationSize.Text = dr("PopulationSize").ToString()
                        lblPopulationSize2.Text = dr("PopulationSize").ToString()
                        lblPopulationSize3.Text = dr("PopulationSize").ToString()
                    End If
                End While
            End Using

            Page.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub btnExportPDF_Click(sender As Object, e As ImageClickEventArgs)

        ' instantiate a html to pdf converter object
        Dim converter As New HtmlToPdf()

        ' create a new pdf document converting an url
        Dim doc As PdfDocument = converter.ConvertUrl(lblPDFUrl.Text)

        ' save pdf document
        doc.Save(Response, False, lblPCAName.Text & ".pdf")
        'doc.Save(Response, False, "FinalReport.pdf")

        ' close pdf document
        doc.Close()
    End Sub
End Class
