
Partial Class ATB_UpdateRecommendation
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        If Not Request.QueryString("OPEID") Is Nothing Then
            txtOPEID.Text = Request.QueryString("OPEID").ToString()
            hypOPEID.NavigateUrl = "AllSchoolsOPEID.aspx?OPEID=" & txtOPEID.Text
            BindGridView()
        End If

    End Sub

End Class
