Imports System.Data

Partial Class PCACalls_MyRehabCallReviews
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            Dim NewAssignmentID As Integer = 0
            If Not Request.QueryString("NewAssignmentID") Is Nothing Then
                NewAssignmentID = Request.QueryString("NewAssignmentID")
            End If

            Dim strPCA As String
            If Not Request.QueryString("PCA") Is Nothing Then
                strPCA = Server.UrlDecode(Request.QueryString("PCA"))
                lblPCA.Text = strPCA
            End If

            Dim PCAID As Integer = 0
            If Not Request.QueryString("PCAID") Is Nothing Then
                PCAID = Request.QueryString("PCAID")
            End If

            Dim strRecordingDeliveryDate As String = ""
            If Not Request.QueryString("RecordingDeliveryDate") Is Nothing Then
                strRecordingDeliveryDate = Server.UrlDecode(Request.QueryString("RecordingDeliveryDate"))
                lblRecordingDeliveryDate.Text = strRecordingDeliveryDate
            End If

            'dsMyRehabReviews.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name
            'dsMyRehabReviews.SelectParameters("PCAID").DefaultValue = PCAID
            'dsMyRehabReviews.SelectParameters("RecordingDeliveryDate").DefaultValue = strRecordingDeliveryDate
            dsMyRehabReviews.SelectParameters("NewAssignmentID").DefaultValue = NewAssignmentID

        End If
    End Sub

    Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblCallCount.Text = "You have reviewed " & recordCount & " calls"
    End Sub

End Class
