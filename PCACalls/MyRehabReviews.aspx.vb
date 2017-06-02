Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_MyRehabReviews
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            dsMyRehabReviews.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name
        End If
    End Sub

End Class
