
Partial Class Issues_Report_PCAQCReport_PCAs
    Inherits System.Web.UI.Page

    Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            txtDateReceivedEnd.Value = DateTime.Now.Date
        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnSearch_Click(sender As Object, e As EventArgs)
        dsQCReport1.SelectParameters(0).DefaultValue = txtDateReceivedBegin.Value
        dsQCReport1.SelectParameters(1).DefaultValue = txtDateReceivedEnd.Value
        GridView1.DataBind()
        GridView1.Visible = True
        btnExportExcel1.Visible = True

        dsQCReport2.SelectParameters(0).DefaultValue = txtDateReceivedBegin.Value
        dsQCReport2.SelectParameters(1).DefaultValue = txtDateReceivedEnd.Value
        GridView2.DataBind()
        GridView2.Visible = True
        btnExportExcel2.Visible = True
    End Sub

    Sub btnExportExcel1_Click(sender As Object, e As EventArgs)
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        ExportExcel1()
    End Sub

    Protected Sub ExportExcel1()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCAComplaintQCReport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

    Sub btnExportExcel2_Click(sender As Object, e As EventArgs)
        GridView2.AllowPaging = False
        GridView2.AllowSorting = False
        ExportExcel2()
    End Sub

    Protected Sub ExportExcel2()
        GridView2.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCAComplaintQCReport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView2.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
