
Partial Class PCAReviews_PCAPerformanceDetail
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim PCAID As Integer
        If Not Request.QueryString("PCAID") Is Nothing Then
            PCAID = Request.QueryString("PCAID")
        Else
            PCAID = 0
        End If

        dsPCAPerformanceDetail.SelectParameters("PCAID").DefaultValue = PCAID
    End Sub

End Class
