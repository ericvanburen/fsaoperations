
Partial Class Reg4Reports_LAProductivityDetail
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            Dim strUserID As String = ""
            Dim strBeginDate As String = ""
            Dim strEndDate As String = ""

            If Not Request.QueryString("UserID") Is Nothing Then
                strUserID = Request.QueryString("UserID")
                lblUserID.Text = strUserID
            End If

            If Not Request.QueryString("BeginDate") Is Nothing Then
                strBeginDate = Server.UrlDecode(Request.QueryString("BeginDate"))
                lblBeginDate.Text = strBeginDate.ToString()
            End If

            If Not Request.QueryString("EndDate") Is Nothing Then
                strEndDate = Server.UrlDecode(Request.QueryString("EndDate"))
                lblEndDate.Text = strEndDate.ToString()
            End If

            BindGridViews(strUserID, strBeginDate, strEndDate)

        End If
    End Sub

    Sub BindGridViews(ByVal strUserID As String, ByVal strBeginDate As String, ByVal strEndDate As String)

        'LA Productivity Summary
        dsProductivityReportDetail.SelectParameters("UserID").DefaultValue = strUSerID
        dsProductivityReportDetail.SelectParameters("BeginDate").DefaultValue = strBeginDate
        dsProductivityReportDetail.SelectParameters("EndDate").DefaultValue = strEndDate
        GridView1.DataBind()

        'Completions
        dsCompletions.SelectParameters("UserID").DefaultValue = strUserID
        dsCompletions.SelectParameters("BeginDate").DefaultValue = strBeginDate
        dsCompletions.SelectParameters("EndDate").DefaultValue = strEndDate

    End Sub


    Protected Sub dsCompletions_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        lblCompletionRowCount.Text = e.AffectedRows.ToString()
    End Sub

    Protected Sub btnExportCompletions_Click(sender As Object, e As ImageClickEventArgs)
        ExportExcelCompletions()
    End Sub

    Protected Sub ExportExcelCompletions()
        GridView_Completions.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=LA_Completions.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView_Completions.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

   
End Class
