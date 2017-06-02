
Partial Class CCM_New_admin_Concerns
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
        End If
    End Sub

    Protected Sub grdConcerns_OnRowCommand1(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandArgument = "Insert" Then
            Dim txtConcern As TextBox = grdConcerns.FooterRow.FindControl("txtConcern")
            dsConcernID.InsertParameters("Concern").DefaultValue = txtConcern.Text
            dsConcernID.Insert()
        End If
    End Sub
End Class
