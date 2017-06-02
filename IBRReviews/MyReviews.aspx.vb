Imports System.Data
Imports System.Data.SqlClient

Partial Class IBRReviews_MyReviews
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'We are using this page to list both all reviews and for listing reviews only for a given NewAssignmentID
            'If we have a PCAID and NewAssignmentID passed to this page, then we want only those records for a specific NewAssignmentID

            If Not Request.QueryString("PCAID") Is Nothing Then
                Dim strPCAID As String = Request.QueryString("PCAID")
                Dim intNewAssignmentID As Integer = Request.QueryString("NewAssignmentID")
                ddlPCAID.SelectedValue = strPCAID
                ViewState("Filter") = strPCAID
                BindGridFilterd(intNewAssignmentID)
            Else
                'We want all IBR Reviews for this Loan Analyst
                ViewState("Filter") = "All"
                BindGridAll()

            End If


           
        End If
    End Sub

    Protected Sub ddlPCAID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlPCAID As DropDownList = DirectCast(sender, DropDownList)
        ViewState("Filter") = ddlPCAID.SelectedValue
        Me.BindGridAll()
    End Sub

    Private Sub BindGridFilterd(ByVal NewAssignmentID As Integer)
        GridView1.DataSourceID = "dsMyReviewsFiltered"
        dsMyReviewsFiltered.SelectParameters("NewAssignmentID").DefaultValue = NewAssignmentID
    End Sub

    Private Sub BindGridAll()
        GridView1.DataSourceID = "dsMyReviews"
        dsMyReviews.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name
        dsMyReviews.SelectParameters("PCAID").DefaultValue = ViewState("Filter")
    End Sub

    Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        If recordCount = 0 Then
            lblReviewCount.Text = "This PCA does not have any IBR reviews"
            btnExportExcel.Visible = False
        ElseIf recordCount = 1 Then
            lblReviewCount.Text = "There is 1 review for this PCA"
            btnExportExcel.Visible = True
        Else
            lblReviewCount.Text = "There are " & recordCount & " reviews for this PCA"
            btnExportExcel.Visible = True
        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        dsMyReviews.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name
        dsMyReviews.SelectParameters("PCAID").DefaultValue = ViewState("Filter")
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        'Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        'ddlUserID.Visible = False

        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=My_IBR_Reviews.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
