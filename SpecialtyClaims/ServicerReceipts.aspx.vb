
Partial Class SpecialtyClaims_ServicerReceipts
    Inherits System.Web.UI.Page

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        dsServicerReceiptReport.SelectParameters("DateReceivedBegin").DefaultValue = txtDateReceivedBegin.Text
        dsServicerReceiptReport.SelectParameters("DateReceivedEnd").DefaultValue = txtDateReceivedEnd.Text
        btnExportExcel.Visible = True
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        dsServicerReceiptReport.SelectParameters("DateReceivedBegin").DefaultValue = txtDateReceivedBegin.Text
        dsServicerReceiptReport.SelectParameters("DateReceivedEnd").DefaultValue = txtDateReceivedEnd.Text
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Servicer_Receipt_Report.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(1).Text = "TOTAL" AndAlso e.Row.Cells(0).Text <> "TOTAL" Then
                'e.Row.BackColor = System.Drawing.Color.Tan
                e.Row.Cells(0).BackColor = System.Drawing.Color.Tan
                e.Row.Cells(1).BackColor = System.Drawing.Color.Tan
                e.Row.Cells(2).BackColor = System.Drawing.Color.Tan
                e.Row.Cells(3).BackColor = System.Drawing.Color.Tan
                e.Row.Cells(4).BackColor = System.Drawing.Color.Tan
                e.Row.Cells(5).BackColor = System.Drawing.Color.Tan
                Dim preRow As GridViewRow = GridView1.Rows(e.Row.DataItemIndex - 1)
                e.Row.Cells(0).Text = preRow.Cells(0).Text & " SUBTOTAL"
                e.Row.Cells(1).Text = ""
            ElseIf e.Row.Cells(0).Text = "TOTAL" Then
                e.Row.Cells(0).Text = "GRAND TOTAL"
                e.Row.Cells(0).BackColor = System.Drawing.Color.Crimson
                e.Row.Cells(1).BackColor = System.Drawing.Color.Crimson
                e.Row.Cells(2).BackColor = System.Drawing.Color.Crimson
                e.Row.Cells(3).BackColor = System.Drawing.Color.Crimson
                e.Row.Cells(4).BackColor = System.Drawing.Color.Crimson
                e.Row.Cells(5).BackColor = System.Drawing.Color.Crimson
            End If
        End If
    End Sub
End Class
