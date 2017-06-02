Imports ExpertPdf.HtmlToPdf
Imports System.Drawing

Partial Class _SSU
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' Convert the HTML code from the specified URL to a PDF document and send the 
    ''' document as an attachment to the browser
    ''' </summary>
    ''' <remarks></remarks>
    ''' 
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim strAG As String = Request.QueryString("AG")
            Dim dteBeginDate As String = Server.UrlEncode(Request.QueryString("BeginDate"))
            Dim dteEndDate As String = Server.UrlEncode(Request.QueryString("EndDate"))
            Dim strSSU_Type As String = Server.UrlEncode(Request.QueryString("SSU_Type"))

            Dim urlToConvert As String = ""
            urlToConvert = "http://10.59.110.59/secure/imf_ed/pdf/SSU.Search.aspx?AG=" & strAG & "&BeginDate=" & dteBeginDate & "&EndDate=" & dteEndDate & "&SSU_Type=" & strSSU_Type

        'Now we have URL to convert, call the ConvertUrlToPDF function
            ConvertURLToPDF(urlToConvert)
            'Response.Write(urlToConvert)

        End If

    End Sub

    Sub ConvertURLToPDF(ByVal urlToConvert As String)

        'selectablePDF As Boolean
        Dim selectablePDF As Boolean = True

        ' Create the PDF converter. Optionally you can specify the virtual browser 
        ' width as parameter. 1024 pixels is default, 0 means autodetect
        Dim pdfConverter As PdfConverter = New PdfConverter()
        ' set the license key
        pdfConverter.LicenseKey = "MBsCEAgQBQIQBh4AEAMBHgECHgkJCQk="
        ' set the converter options

        'Added by Eric
        pdfConverter.ConversionDelay = 0

        'Added by Eric
        pdfConverter.PdfDocumentOptions.AutoSizePdfPage = True
        'pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.Letter

        'pdfConverter.PdfDocumentOptions.PdfPageSize = PdfPageSize.A4
        pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal
        pdfConverter.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait

        'Set header and footer - optional - default is false 
        pdfConverter.PdfDocumentOptions.ShowHeader = False
        pdfConverter.PdfDocumentOptions.ShowFooter = False

        ' set to generate a pdf with selectable text or a pdf with embedded image - optional - default is true
        pdfConverter.PdfDocumentOptions.GenerateSelectablePdf = True

        ' set if the HTML content is resized if necessary to fit the PDF page width - optional - default is true
        pdfConverter.PdfDocumentOptions.FitWidth = True

        ' set the embedded fonts option - optional - default is false
        pdfConverter.PdfDocumentOptions.EmbedFonts = True

        ' set the live HTTP links option - optional - default is true
        pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = True

        ' set if the JavaScript is enabled during conversion to a PDF with selectable text 
        ' - optional - default is false
        pdfConverter.ScriptsEnabled = False

        ' set if the ActiveX controls (like Flash player) are enabled during conversion 
        ' to a PDF with selectable text - optional - default is false
        pdfConverter.ActiveXEnabled = False

        ' set if the JavaScript is enabled during conversion to a PDF with embedded image 
        ' - optional - default is true
        pdfConverter.ScriptsEnabledInImage = True

        ' set if the images in PDF are compressed with JPEG to reduce the PDF document size - optional - default is true
        pdfConverter.PdfDocumentOptions.JpegCompressionEnabled = True
        pdfConverter.PdfDocumentOptions.JpegCompressionLevel = 0

        ' set PDF security options - optional
        'pdfConverter.PdfSecurityOptions.CanPrint = True
        'pdfConverter.PdfSecurityOptions.CanEditContent = True
        'pdfConverter.PdfSecurityOptions.UserPassword = ""

        ' set PDF document description - optional
        pdfConverter.PdfDocumentInfo.AuthorName = "U.S. Department of Education"

        ' add HTML header
        'AddHeader(pdfConverter)

        ' add HTML footer
        'AddFooter(pdfConverter)

        ' Performs the conversion and get the pdf document bytes that you can further 
        ' save to a file or send as a browser response
        Dim pdfBytes As Byte() = pdfConverter.GetPdfBytesFromUrl(urlToConvert)

        ' send the PDF document as a response to the browser for download
        Dim Response As System.Web.HttpResponse = System.Web.HttpContext.Current.Response
        Response.Clear()
        Response.AddHeader("Content-Type", "binary/octet-stream")
        'Response.AddHeader("Content-Disposition", "attachment; filename=Tearsheet.Conversion.Result.pdf; size=" & pdfBytes.Length.ToString())
        Response.AddHeader("Content-Disposition", "attachment; filename=SSU.pdf; size=" & pdfBytes.Length.ToString())
        Response.Flush()
        Response.BinaryWrite(pdfBytes)
        Response.Flush()
        Response.End()
    End Sub


    Private Sub AddHeader(ByRef pdfConverter As PdfConverter)
        Dim thisPageURL As String = HttpContext.Current.Request.Url.AbsoluteUri
        'Dim headerAndFooterHtmlUrl As String = thisPageURL.Substring(0, thisPageURL.LastIndexOf("/")) + "/Header.ed.aspx"
        Dim headerAndFooterHtmlUrl As String = "http://10.59.110.59/secure/imf_ed/pdf/Header.aspx"

        'enable header
        pdfConverter.PdfDocumentOptions.ShowHeader = True
        ' set the header height in points
        pdfConverter.PdfHeaderOptions.HeaderHeight = 60
        ' set the header HTML area
        pdfConverter.PdfHeaderOptions.HtmlToPdfArea = New HtmlToPdfArea(0, 0, -1, pdfConverter.PdfHeaderOptions.HeaderHeight, headerAndFooterHtmlUrl, 1024, -1)
        pdfConverter.PdfHeaderOptions.HtmlToPdfArea.FitHeight = False
        pdfConverter.PdfHeaderOptions.HtmlToPdfArea.EmbedFonts = False
    End Sub

    Private Sub AddFooter(ByRef pdfConverter As PdfConverter)
        Dim thisPageURL As String = HttpContext.Current.Request.Url.AbsoluteUri
        'Dim headerAndFooterHtmlUrl As String = thisPageURL.Substring(0, thisPageURL.LastIndexOf("/")) + "/Footer.aspx"
        Dim headerAndFooterHtmlUrl As String = "http://10.59.110.59/secure/imf_ed/pdf/Footer.aspx"

        'enable footer
        pdfConverter.PdfDocumentOptions.ShowFooter = True

        'footer text
        'pdfConverter.PdfFooterOptions.FooterText = "This report is for information purposes and should not be considered a solicitation to buy or sell any security."

        ' set the footer height in points
        pdfConverter.PdfFooterOptions.FooterHeight = 60
        'write the page number
        'pdfConverter.PdfFooterOptions.TextArea = New TextArea(0, 30, "Page &p; of &P;  ", New System.Drawing.Font(New System.Drawing.FontFamily("Verdana"), 8, System.Drawing.GraphicsUnit.Point))
        'pdfConverter.PdfFooterOptions.TextArea.EmbedTextFont = True
        'pdfConverter.PdfFooterOptions.TextArea.TextAlign = HorizontalTextAlign.Right
        'set the footer HTML area
        pdfConverter.PdfFooterOptions.HtmlToPdfArea = New HtmlToPdfArea(0, 0, -1, pdfConverter.PdfFooterOptions.FooterHeight, headerAndFooterHtmlUrl, 1024, -1)
        pdfConverter.PdfFooterOptions.HtmlToPdfArea.FitHeight = True
        pdfConverter.PdfFooterOptions.HtmlToPdfArea.EmbedFonts = False
    End Sub


End Class
