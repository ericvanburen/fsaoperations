
Partial Class Issues_MyPCAComplaints
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            dsMyPCAComplaints.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name
            dsMyPCAComplaints.SelectParameters("DateResolved").DefaultValue = 0
        End If

    End Sub

    Protected Sub ddlDateResolved_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlDateResolved.SelectedIndexChanged
        dsMyPCAComplaints.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name
        dsMyPCAComplaints.SelectParameters("DateResolved").DefaultValue = ddlDateResolved.SelectedValue
    End Sub
End Class
