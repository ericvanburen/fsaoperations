
Partial Class PCACalls_ReportsRehabCallErrors
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCACalls_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            Dim strUserID As String
            If Not Request.QueryString("UserID") Is Nothing Then
                strUserID = Request.QueryString("UserID")
                dsRehabLAErrorReportList.SelectParameters("UserID").DefaultValue = strUserID

                'set the label value with the selected user ID name for display purposes only
                lblUserIDName.Text = strUserID.ToString()

                'Make the export to Excel button visible in the second gridview
                btnExportExcel2.Visible = True
            End If
        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=RehabCalls_Loan_Analyst_Errors.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

    Sub btnExportExcel2_Click(sender As Object, e As EventArgs)
        ExportExcel2()
    End Sub

    Protected Sub ExportExcel2()
        GridView2.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=RehabCalls_Loan_Analyst_Errors_List.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView2.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
