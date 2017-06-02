
Partial Class Reg4Reports_LACompletions
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        dsProductivityReport.SelectParameters("BeginDate").DefaultValue = txtBeginDate.Text
        dsProductivityReport.SelectParameters("EndDate").DefaultValue = txtEndDate.Text
        'Make Excel button visible
        btnExportExcel.Visible = True
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
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

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            'This is for the Review Calls link - Hyperlink1
            Dim link = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
            Dim strUserID As String = link.Text
            Dim strBeginDate As String = txtBeginDate.Text
            Dim strEndDate As String = txtEndDate.Text
            link.NavigateUrl = "LAProductivityDetail.aspx?BeginDate=" & Server.UrlEncode(strBeginDate) & "&EndDate=" & Server.UrlEncode(strEndDate) & "&UserID=" & strUserID
        End If
    End Sub

    Protected Sub GridView1_DataBound(sender As Object, e As GridViewRowEventArgs)
        
    End Sub
End Class
