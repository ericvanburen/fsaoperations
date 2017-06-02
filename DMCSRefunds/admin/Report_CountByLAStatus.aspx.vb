Imports Telerik.Web.UI

Partial Class DMCSRefunds_Report_CountByLAStatus
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            RadMenu1.LoadContentFile("~/DMCSRefunds/Menu.xml")
        End If
    End Sub

End Class
