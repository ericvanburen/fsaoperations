Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_ReportQCTier1Errors
    Inherits System.Web.UI.Page

    Protected Function GetRoleUsers() As String()
        Return Roles.GetUsersInRole("PCAReviews")
    End Function

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCAReviews_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            Dim strUserID As String = ""

            'Populate the Loan Analyst dropdown box 
            'ddlUserID.DataSource = Roles.GetUsersInRole("PCAReviews")
            'ddlUserID.DataBind()

            If Not Request.QueryString("UserID") Is Nothing Then
                strUserID = Server.UrlDecode(Request.QueryString("UserID"))
                'lblUserID.Text = strUserID & " on "
                ViewState("Filter") = strUserID
            Else
                ViewState("Filter") = "ALL"
            End If


        End If

    End Sub

    Protected Sub ddlUserID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlUserID As DropDownList = DirectCast(sender, DropDownList)
        ViewState("Filter") = ddlUserID.SelectedValue
        Me.BindGrid()
    End Sub

    Private Sub BindGrid()
        dsIncorrectActions.SelectParameters("UserID").DefaultValue = ViewState("Filter")
        Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        'Me.BindUserIDList(ddlUserID)
    End Sub

    Private Sub BindUserIDList(ByVal ddlUserID As DropDownList)
        'Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        ddlUserID.Items.FindByValue(ViewState("Filter").ToString()).Selected = True
    End Sub

    Sub OnSelectedHandlerPCAReviews(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        'lblCallCountPCAReviews.Text = "This Analyst has reviewed " & recordCount & " PCA calls"
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        'dsLAAssignments.SelectParameters("UserID").DefaultValue = ViewState("Filter")
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        ddlUserID.Visible = False

        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Loan_Analyst_Assignments.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
End Class
