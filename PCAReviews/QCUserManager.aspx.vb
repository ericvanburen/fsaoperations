Imports Telerik.Web.UI

Partial Class PCAReviews_admin_AddRefund
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString

    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCAReviews_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If
        End If
    End Sub



End Class
