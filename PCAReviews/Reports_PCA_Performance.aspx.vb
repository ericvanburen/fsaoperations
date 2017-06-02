
Partial Class PCAReviews_Reports_PCA_Performance
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub
   

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView2.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCA_Performance_Summary.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView2.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
