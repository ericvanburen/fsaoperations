
Partial Class PCAReviews_ReportCount
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim thisDate As Date
            Dim thisMonth As String
            Dim thisYear As String
            thisDate = Date.Today()
            thisMonth = Month(thisDate)
            thisYear = Year(thisDate)

            dsReviewCompletionCount.SelectParameters("ReviewPeriodMonth").DefaultValue = thisMonth
            dsReviewCompletionCount.SelectParameters("ReviewPeriodYear").DefaultValue = thisYear

            ddlReviewPeriodMonth.SelectedValue = thisMonth.ToString
            ddlReviewPeriodYear.SelectedValue = thisYear.ToString
        End If
    End Sub

    Protected Sub ddlReviewPeriodMonth_SelectedIndexChanged(sender As Object, e As EventArgs)
        dsReviewCompletionCount.SelectParameters("ReviewPeriodMonth").DefaultValue = ddlReviewPeriodMonth.SelectedValue
        dsReviewCompletionCount.SelectParameters("ReviewPeriodYear").DefaultValue = ddlReviewPeriodYear.SelectedValue
    End Sub
End Class
