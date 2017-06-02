Imports System.Data

Partial Class TOPLog_Report_PICLogErrors
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("TOPLog_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        dsPICLogErrors.SelectParameters("DateApprovedFrom").DefaultValue = txtDateApprovedFrom.Text
        dsPICLogErrors.SelectParameters("DateApprovedTo").DefaultValue = txtDateApprovedTo.Text
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("Report_PICLogErrors.aspx")
    End Sub

    Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRowCount.Text = "There are " & recordCount & " TOP errors"
        If recordCount > 0 Then
            btnExportExcel.Visible = True
        Else
            btnExportExcel.Visible = False
        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        grdPICLogErrors.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PICLogReport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        grdPICLogErrors.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
End Class
