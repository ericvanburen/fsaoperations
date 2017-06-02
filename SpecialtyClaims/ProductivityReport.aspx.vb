
Partial Class SpecialtyClaims_ProductivityReport
    Inherits System.Web.UI.Page

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        dsProductivityReport.SelectParameters("DateCompletedBegin").DefaultValue = txtDateCompletedBegin.Text
        dsProductivityReport.SelectParameters("DateCompletedEnd").DefaultValue = txtDateCompletedEnd.Text
        btnExportExcel.Visible = True
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        dsProductivityReport.SelectParameters("DateCompletedBegin").DefaultValue = txtDateCompletedBegin.Text
        dsProductivityReport.SelectParameters("DateCompletedEnd").DefaultValue = txtDateCompletedEnd.Text
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=LA_Productivity_Report.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
End Class
