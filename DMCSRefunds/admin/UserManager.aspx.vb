Imports Telerik.Web.UI

Partial Class DMCSRefunds_admin_AddRefund
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString

    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("DMCSRefunds_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If
        End If
    End Sub



End Class
