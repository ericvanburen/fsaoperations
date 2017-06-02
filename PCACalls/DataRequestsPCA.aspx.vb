
Partial Class PCACalls_DataRequestsPCA
    Inherits System.Web.UI.Page

    Protected Function GetRoleUsers() As String()
        Return Roles.GetUsersInRole("PCACalls")
    End Function

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCACalls_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            Dim strPCA As String = ""

            If Not Request.QueryString("PCA") Is Nothing Then
                strPCA = Server.UrlDecode(Request.QueryString("PCA"))
                ViewState("Filter") = strPCA
                BindGrid()
            End If
        Else
            'ViewState("Filter") = "All"
            'BindGrid()
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If GridView1.HeaderRow IsNot Nothing Then
            Dim ddlPCA As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlPCA"), DropDownList)
            ddlPCA.Items.FindByValue(ViewState("Filter").ToString()).Selected = True
        End If
    End Sub

    Protected Sub ddlPCA_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlPCA As DropDownList = DirectCast(sender, DropDownList)
        ViewState("Filter") = ddlPCA.SelectedValue
        Me.BindGrid()
    End Sub

    Private Sub BindGrid()
        dsDataRequests.SelectParameters("PCA").DefaultValue = ViewState("Filter")
        dsDataRequests.DataBind()
        lblPCALabel.Text = ViewState("Filter")
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        dsDataRequests.SelectParameters("PCA").DefaultValue = ViewState("Filter")
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCA_Data_Requests.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
End Class
