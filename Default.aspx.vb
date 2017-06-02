
Partial Class _Default
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Get the browser type - anything but IE is allowed
            Dim strBrowserType As String
            strBrowserType = Request.Browser.Browser
            If strBrowserType = "InternetExplorer" Then
                Response.Redirect("InvalidBrowser.aspx")
            End If
        End If
    End Sub
End Class
