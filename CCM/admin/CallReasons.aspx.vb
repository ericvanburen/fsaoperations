
Partial Class CCM_New_admin_CallReasons
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
        End If
    End Sub

    Protected Sub grdCallReasons_OnRowCommand1(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandArgument = "Insert" Then
            Dim txtReasonForCall As TextBox = grdCallReasons.FooterRow.FindControl("txtReasonForCall")
            Dim ddlReasonGroup As DropDownList = grdCallReasons.FooterRow.FindControl("ddlReasonGroup")
            dsReasonCode.InsertParameters("ReasonForCall").DefaultValue = txtReasonForCall.Text
            dsReasonCode.InsertParameters("ReasonGroup").DefaultValue = ddlReasonGroup.SelectedValue
            dsReasonCode.Insert()
        End If
    End Sub
End Class
