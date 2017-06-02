Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_ReportsRehab_MultiPCA
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            dsReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
            dsReviews.SelectParameters("ReportQuarter").DefaultValue = ddlReportQuarter.SelectedValue
            dsReviews.SelectParameters("ReportYear").DefaultValue = ddlReportYear.SelectedValue
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        If ddlPCAID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlPCAID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            dsReviews.SelectParameters("PCAID").DefaultValue = strSearchValue
        End If
        If ddlReportQuarter.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReportQuarter.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            dsReviews.SelectParameters("ReportQuarter").DefaultValue = strSearchValue
        End If

        If ddlReportYear.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReportYear.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            dsReviews.SelectParameters("ReportYear").DefaultValue = strSearchValue
        End If

        GridView1.DataBind()
        btnExportExcel.Visible = True
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=RehabReviews_Search_Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
End Class
