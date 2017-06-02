
Partial Class toast_Default
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal Src As Object, ByVal E As EventArgs)
        If Not Page.IsPostBack Then
            Button1.Attributes.Add("onClick", "showSuccessToast();")
        End If
    End Sub

End Class
