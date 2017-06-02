Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_NewRehabReview
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            If Not Request.QueryString("PCAID") Is Nothing Then
                Dim strPCAID As String = Request.QueryString("PCAID")
                ddlPCAID.SelectedValue = strPCAID
                'Response.Write("PCA ID:" & strPCAID)
            End If

            'This value may be passed to this page from MyNewAssignments.aspx
            If Not Request.QueryString("RecordingDeliveryDate") Is Nothing And Request.QueryString("RecordingDeliveryDate") <> "&nbsp;" Then
                Dim strRecordingDeliveryDate = Server.UrlDecode(Request.QueryString("RecordingDeliveryDate"))
                txtRecordingDeliveryDate.Text = strRecordingDeliveryDate
            End If

            'This value may be passed to this page from MyNewAssignments.aspx
            If Not Request.QueryString("ReviewDate") Is Nothing And Request.QueryString("ReviewDate") <> "&nbsp;" Then
                Dim strReviewDate = Server.UrlDecode(Request.QueryString("ReviewDate"))
                txtReviewDate.Text = strReviewDate
            End If

            If Not Request.QueryString("ReportQuarter") Is Nothing Then
                Dim strReportQuarter As String = Request.QueryString("ReportQuarter")
                ddlReportQuarter.SelectedValue = strReportQuarter
            End If
            If Not Request.QueryString("ReportYear") Is Nothing Then
                Dim strReportYear As String = Request.QueryString("ReportYear")
                ddlReportYear.SelectedValue = strReportYear
            End If

            Dim NewAssignmentID As Integer = 0
            If Not Request.QueryString("NewAssignmentID") Is Nothing Then
                NewAssignmentID = Request.QueryString("NewAssignmentID")
                lblNewAssignmentID.Text = NewAssignmentID
            End If

            'Only admins can see the enter comments in the FSA Supervisor Comments, recording delivery date, review date, report quarter, report year boxes
            If Roles.IsUserInRole("PCACalls_Admins") = True Then
                txtFSASupervisor_Comments.Enabled = True
                txtRecordingDeliveryDate.Enabled = True
                txtReviewDate.Enabled = True
                ddlReportQuarter.Enabled = True
                ddlReportYear.Enabled = True
            Else
                txtFSASupervisor_Comments.Enabled = False
                txtRecordingDeliveryDate.Enabled = False
                txtReviewDate.Enabled = False
                ddlReportQuarter.Enabled = False
                ddlReportYear.Enabled = False
            End If

            btnUpdateAgain.Visible = False
        End If
    End Sub

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertNewRehabReview", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@NewAssignmentID", lblNewAssignmentID.Text)
        cmd.Parameters.AddWithValue("@DateSubmitted", Date.Now())
        cmd.Parameters.AddWithValue("@CallDate", txtCallDate.Text)
        cmd.Parameters.AddWithValue("@PCAID", ddlPCAID.SelectedValue)
        cmd.Parameters.AddWithValue("@UserID", HttpContext.Current.User.Identity.Name)
        cmd.Parameters.AddWithValue("@BorrowerNumber", txtBorrowerNumber.Text)

        If ddlScore_Rehab_Program.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Rehab_Program", ddlScore_Rehab_Program.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Rehab_Program", DBNull.Value)
        End If
        If ddlScore_Rehab_Once.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Rehab_Once", ddlScore_Rehab_Once.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Rehab_Once", DBNull.Value)
        End If
        If ddlScore_Nine_Payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Nine_Payments", ddlScore_Nine_Payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Nine_Payments", DBNull.Value)
        End If
        If ddlScore_Loans_Transferred_After_60_Days.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Loans_Transferred_After_60_Days", ddlScore_Loans_Transferred_After_60_Days.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Loans_Transferred_After_60_Days", DBNull.Value)
        End If
        If ddlScore_Reversed_Payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Reversed_Payments", ddlScore_Reversed_Payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Reversed_Payments", DBNull.Value)
        End If
        If ddlScore_TOP.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_TOP", ddlScore_TOP.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_TOP", DBNull.Value)
        End If
        If ddlScore_AWG.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_AWG", ddlScore_AWG.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_AWG", DBNull.Value)
        End If
        If ddlScore_Continue_Payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Continue_Payments", ddlScore_Continue_Payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Continue_Payments", DBNull.Value)
        End If
        If ddlScore_New_Payment_Schedule.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_New_Payment_Schedule", ddlScore_New_Payment_Schedule.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_New_Payment_Schedule", DBNull.Value)
        End If
        If ddlScore_TPD.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_TPD", ddlScore_TPD.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_TPD", DBNull.Value)
        End If
        If ddlScore_Eligible_Payment_Plans.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Eligible_Payment_Plans", ddlScore_Eligible_Payment_Plans.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Eligible_Payment_Plans", DBNull.Value)
        End If
        If ddlScore_Deferment_Forb.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Deferment_Forb", ddlScore_Deferment_Forb.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Deferment_Forb", DBNull.Value)
        End If
        If ddlScore_TitleIV.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_TitleIV", ddlScore_TitleIV.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_TitleIV", DBNull.Value)
        End If
        If ddlScore_Collection_Charges_Waived.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Collection_Charges_Waived", ddlScore_Collection_Charges_Waived.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Collection_Charges_Waived", DBNull.Value)
        End If
        If ddlScore_TOP_Payment_PIFs_Account.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_TOP_Payment_PIFs_Account", ddlScore_TOP_Payment_PIFs_Account.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_TOP_Payment_PIFs_Account", DBNull.Value)
        End If
        If ddlScore_Delay_Tax_Reform.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Delay_Tax_Reform", ddlScore_Delay_Tax_Reform.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Delay_Tax_Reform", DBNull.Value)
        End If
        If ddlScore_More_Aid.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_More_Aid", ddlScore_More_Aid.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_More_Aid", DBNull.Value)
        End If
        If ddlScore_Collection_Costs_Waived.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Collection_Costs_Waived", ddlScore_Collection_Costs_Waived.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Collection_Costs_Waived", DBNull.Value)
        End If
        If ddlScore_False_Requirements.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_False_Requirements", ddlScore_False_Requirements.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_False_Requirements", DBNull.Value)
        End If
        If ddlScore_Not_Factual.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Not_Factual", ddlScore_Not_Factual.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Not_Factual", DBNull.Value)
        End If
        If ddlScore_Unaffordable_Payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Unaffordable_Payments", ddlScore_Unaffordable_Payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Unaffordable_Payments", DBNull.Value)
        End If
        If ddlScore_Avoid_PIF.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Avoid_PIF", ddlScore_Avoid_PIF.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Avoid_PIF", DBNull.Value)
        End If
        If ddlScore_Rehab_Then_TPD.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Rehab_Then_TPD", ddlScore_Rehab_Then_TPD.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Rehab_Then_TPD", DBNull.Value)
        End If
        If ddlScore_Ineligible_Borrower.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Ineligible_Borrower", ddlScore_Ineligible_Borrower.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Ineligible_Borrower", DBNull.Value)
        End If
        If ddlScore_Payments_Are_Final.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Payments_Are_Final", ddlScore_Payments_Are_Final.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Payments_Are_Final", DBNull.Value)
        End If

        If ddlScore_Credit_All_Negative_Data_Removed.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Credit_All_Negative_Data_Removed", ddlScore_Credit_All_Negative_Data_Removed.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Credit_All_Negative_Data_Removed", DBNull.Value)
        End If

        If ddlScore_Credit_Never_Defaulted.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Credit_Never_Defaulted", ddlScore_Credit_Never_Defaulted.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Credit_Never_Defaulted", DBNull.Value)
        End If

        If ddlScore_Credit_Score_Will_Improve.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Credit_Score_Will_Improve", ddlScore_Credit_Score_Will_Improve.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Credit_Score_Will_Improve", DBNull.Value)
        End If


        If ddlReportQuarter.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ReportQuarter", ddlReportQuarter.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@ReportQuarter", DBNull.Value)
        End If

        If ddlReportYear.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ReportYear", ddlReportYear.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@ReportYear", DBNull.Value)
        End If

        If txtFSA_Comments.Text <> "" Then
            cmd.Parameters.AddWithValue("@FSA_Comments", txtFSA_Comments.Text)
        Else
            cmd.Parameters.AddWithValue("@FSA_Comments", DBNull.Value)
        End If

        If txtFSASupervisor_Comments.Text <> "" Then
            cmd.Parameters.AddWithValue("@FSASupervisor_Comments", txtFSASupervisor_Comments.Text)
        Else
            cmd.Parameters.AddWithValue("@FSASupervisor_Comments", DBNull.Value)
        End If

        If txtPCA_Comments.Text <> "" Then
            cmd.Parameters.AddWithValue("@PCA_Comments", txtPCA_Comments.Text)
        Else
            cmd.Parameters.AddWithValue("@PCA_Comments", DBNull.Value)
        End If

        If txtFSA_Conclusions.Text <> "" Then
            cmd.Parameters.AddWithValue("@FSA_Conclusions", txtFSA_Conclusions.Text)
        Else
            cmd.Parameters.AddWithValue("@FSA_Conclusions", DBNull.Value)
        End If

        If txtRecordingDeliveryDate.Text <> "" Then
            cmd.Parameters.AddWithValue("@RecordingDeliveryDate", txtRecordingDeliveryDate.Text)
        Else
            cmd.Parameters.AddWithValue("@RecordingDeliveryDate", DBNull.Value)
        End If

        If txtReviewDate.Text <> "" Then
            cmd.Parameters.AddWithValue("@ReviewDate", txtReviewDate.Text)
        Else
            cmd.Parameters.AddWithValue("@ReviewDate", DBNull.Value)
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

    Sub btnSubmitAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim RecordingDeliveryDate As String = Server.UrlEncode(txtRecordingDeliveryDate.Text)
        Dim ReviewDate As String = Server.UrlEncode(txtReviewDate.Text)
        Response.Redirect("NewRehabReview.aspx?PCAID=" & ddlPCAID.SelectedValue & "&ReportQuarter=" & ddlReportQuarter.SelectedValue & "&ReportYear=" & ddlReportYear.SelectedValue & "&RecordingDeliveryDate=" & RecordingDeliveryDate & "&ReviewDate=" & ReviewDate & "&NewAssignmentID=" & lblNewAssignmentID.Text)
    End Sub

End Class
