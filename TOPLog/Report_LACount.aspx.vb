
Partial Class TOPLog_Report_LACount
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("TOPLog_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If
        End If
    End Sub

End Class
