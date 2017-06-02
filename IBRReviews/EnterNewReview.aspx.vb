Imports System.Data
Imports System.Data.SqlClient

Partial Class IBRReviews_EnterNewReview
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            If Not Request.QueryString("NewAssignmentID") Is Nothing Then
                Dim strNewAssignmentID As String = Request.QueryString("NewAssignmentID")
                lblNewAssignmentID.Text = strNewAssignmentID
            End If

            If Not Request.QueryString("PCAID") Is Nothing Then
                Dim strPCAID As String = Request.QueryString("PCAID")
                ddlPCAID.SelectedValue = strPCAID
            End If
           
            If Not Request.QueryString("ReportQuarter") Is Nothing Then
                Dim strReportQuarter As String = Request.QueryString("ReportQuarter")
                ddlReportQuarter.SelectedValue = strReportQuarter
            End If

            If Not Request.QueryString("ReportYear") Is Nothing Then
                Dim strReportYear As String = Request.QueryString("ReportYear")
                ddlReportYear.SelectedValue = strReportYear
            End If
        End If
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertNewReview", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@NewAssignmentID", lblNewAssignmentID.Text)
        cmd.Parameters.AddWithValue("@UserID", HttpContext.Current.User.Identity.Name)
        cmd.Parameters.AddWithValue("@DateSubmitted", Date.Now())
        cmd.Parameters.AddWithValue("@BorrowerNumber", txtBorrowerNumber.Text)
        cmd.Parameters.AddWithValue("@PCAID", ddlPCAID.SelectedValue)
        cmd.Parameters.AddWithValue("@ReportQuarter", ddlReportQuarter.SelectedValue)
        cmd.Parameters.AddWithValue("@ReportYear", ddlReportYear.SelectedValue)

        cmd.Parameters.AddWithValue("@Agreement_Letter_Signed", ddlAgreement_Letter_Signed.SelectedValue)

        If txtAgreement_Letter_Signed_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@Agreement_Letter_Signed_Date", txtAgreement_Letter_Signed_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@Agreement_Letter_Signed_Date", DBNull.Value)
        End If

        cmd.Parameters.AddWithValue("@Financial_Documentation", ddlFinancial_Documentation.SelectedValue)
        cmd.Parameters.AddWithValue("@Dependents", ddlDependents.SelectedValue)
        cmd.Parameters.AddWithValue("@Income", txtIncome.Text)

        cmd.Parameters.AddWithValue("@Repayment_Amount", ddlRepayment_Amount.SelectedValue)
        cmd.Parameters.AddWithValue("@Tag", ddlTag.SelectedValue)

        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        Else
            cmd.Parameters.AddWithValue("@Comments", DBNull.Value)
        End If

        If txtPCA_Comments.Text <> "" Then
            cmd.Parameters.AddWithValue("@PCA_Comments", txtPCA_Comments.Text)
        Else
            cmd.Parameters.AddWithValue("@PCA_Comments", DBNull.Value)
        End If

        If txtFSA_Conclusions.Text <> "" Then
            cmd.Parameters.AddWithValue("@FSA_Conclusions", txtPCA_Comments.Text)
        Else
            cmd.Parameters.AddWithValue("@FSA_Conclusions", DBNull.Value)
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblUpdateConfirm.Text = "Your review was successfully submitted"
            btnSubmit.Visible = False
            btnUpdateAgain.Visible = True

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnUpdateAgain_Click(sender As Object, e As EventArgs)
        Response.Redirect("EnterNewReview.aspx?PCAID=" & ddlPCAID.SelectedValue & "&ReportQuarter=" & ddlReportQuarter.SelectedValue & "&ReportYear=" & ddlReportYear.SelectedValue & "&NewAssignmentID=" & lblNewAssignmentID.Text)
    End Sub
End Class
