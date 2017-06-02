Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_NewReview
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            If Not Request.QueryString("PCAID") Is Nothing Then
                Dim strPCAID As String = Request.QueryString("PCAID")
                ddlPCAID.SelectedValue = strPCAID
            End If
            'This value may be passed to this page from MyNewAssignments.aspx
            If Not Request.QueryString("RecordingDeliveryDate") Is Nothing And Request.QueryString("RecordingDeliveryDate") <> "&nbsp;" Then
                Dim strRecordingDeliveryDate As String = Server.UrlDecode(Request.QueryString("RecordingDeliveryDate"))
                txtRecordingDeliveryDate.Text = strRecordingDeliveryDate
            End If

            'This value may be passed to this page from MyNewAssignments.aspx
            If Not Request.QueryString("ReviewPeriodMonth") Is Nothing And Request.QueryString("ReviewPeriodMonth") <> "&nbsp;" Then
                Dim strReviewPeriodMonth As String = Server.UrlDecode(Request.QueryString("ReviewPeriodMonth"))
                ddlReviewPeriodMonth.SelectedValue = strReviewPeriodMonth
            End If

            If Not Request.QueryString("ReviewPeriodYear") Is Nothing Then
                Dim strReviewPeriodYear As String = Request.QueryString("ReviewPeriodYear")
                ddlReviewPeriodYear.SelectedValue = strReviewPeriodYear
            End If

            If Not Request.QueryString("CallDate") Is Nothing Then
                Dim dteCallDate As DateTime = Request.QueryString("CallDate")
                txtCallDate.Text = dteCallDate
            End If

            Dim NewAssignmentID As Integer = 0
            If Not Request.QueryString("NewAssignmentID") Is Nothing Then
                NewAssignmentID = Request.QueryString("NewAssignmentID")
                lblNewAssignmentID.Text = NewAssignmentID
            End If

            'Only admins can see the enter comments in the FSA Supervisor Comments, recording delivery date, month, year boxes
            If Roles.IsUserInRole("PCAReviews_Admins") = True Then
                ddlPCAID.Enabled = True
                ddlReviewPeriodMonth.Enabled = True
                ddlReviewPeriodYear.Enabled = True
                txtFSASupervisor_Comments.Enabled = True
                txtRecordingDeliveryDate.Enabled = True
            Else
                ddlPCAID.Enabled = False
                ddlReviewPeriodMonth.Enabled = False
                ddlReviewPeriodYear.Enabled = False
                txtFSASupervisor_Comments.Enabled = False
                txtRecordingDeliveryDate.Enabled = False
            End If

            btnUpdateAgain.Visible = False
        End If
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertNewReview", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@NewAssignmentID", lblNewAssignmentID.Text)
        cmd.Parameters.AddWithValue("@ReviewAgency", "FSA")
        cmd.Parameters.AddWithValue("@DateSubmitted", Date.Now())
        cmd.Parameters.AddWithValue("@CallDate", txtCallDate.Text)
        cmd.Parameters.AddWithValue("@PCAID", ddlPCAID.SelectedValue)
        If ddlReviewPeriodMonth.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ReviewPeriodMonth", ddlReviewPeriodMonth.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@ReviewPeriodMonth", DBNull.Value)
        End If

        If ddlReviewPeriodYear.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ReviewPeriodYear", ddlReviewPeriodYear.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@ReviewPeriodYear", DBNull.Value)
        End If

        If txtRecordingDeliveryDate.Text <> "" Then
            cmd.Parameters.AddWithValue("@RecordingDeliveryDate", txtRecordingDeliveryDate.Text)
        Else
            cmd.Parameters.AddWithValue("@RecordingDeliveryDate", DBNull.Value)
        End If
        cmd.Parameters.AddWithValue("@UserID", HttpContext.Current.User.Identity.Name)
        cmd.Parameters.AddWithValue("@BorrowerLastName", txtBorrowerLastName.Text)
        cmd.Parameters.AddWithValue("@BorrowerNumber", txtBorrowerNumber.Text)
        cmd.Parameters.AddWithValue("@InOutBound", ddlInOutBound.SelectedValue)
        cmd.Parameters.AddWithValue("@CallType", ddlCallType.SelectedValue)
        cmd.Parameters.AddWithValue("@CallLength", txtCallLength.Text)
        cmd.Parameters.AddWithValue("@CallLengthActual", txtCallLengthActual.Text)
        cmd.Parameters.AddWithValue("@RehabTalkOff", ddlRehabTalkOff.SelectedValue)
        cmd.Parameters.AddWithValue("@ConsolTalkOff", ddlConsolTalkOff.SelectedValue) 'Added

        If ddlScore_CorrectID.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_CorrectID", ddlScore_CorrectID.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_CorrectID", DBNull.Value)
        End If

        If ddlScore_ProperlyIdentified.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_ProperlyIdentified", ddlScore_ProperlyIdentified.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_ProperlyIdentified", DBNull.Value)
        End If

        If ddlScore_MiniMiranda.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_MiniMiranda", ddlScore_MiniMiranda.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_MiniMiranda", DBNull.Value)
        End If

        If ddlScore_Tone.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Tone", ddlScore_Tone.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Tone", DBNull.Value)
        End If

        If ddlScore_Accuracy.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Accuracy", ddlScore_Accuracy.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Accuracy", DBNull.Value)
        End If

        If ddlScore_Notepad.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Notepad", ddlScore_Notepad.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Notepad", DBNull.Value)
        End If

        If ddlScore_PCAResponsive.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_PCAResponsive", ddlScore_PCAResponsive.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_PCAResponsive", DBNull.Value)
        End If

        If ddlScore_AWGInfo.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_AWGInfo", ddlScore_AWGInfo.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_AWGInfo", DBNull.Value)
        End If

        If ddlComplaint.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Complaint", ddlComplaint.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Complaint", DBNull.Value)
        End If

        'Added
        If ddlScore_Disconnect_Borrower.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Disconnect_Borrower", ddlScore_Disconnect_Borrower.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Disconnect_Borrower", DBNull.Value)
        End If

        If txtIMF_Submission_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@IMF_Submission_Date", txtIMF_Submission_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@IMF_Submission_Date", DBNull.Value)
        End If

        If ddlIMF_Timely.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@IMF_Timely", ddlIMF_Timely.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@IMF_Timely", DBNull.Value)
        End If

        If ddlScore_ExceededHoldTime.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_ExceededHoldTime", ddlScore_ExceededHoldTime.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_ExceededHoldTime", DBNull.Value)
        End If

        'These are the rehab fields      

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

        If ddlScore_TitleIV.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_TitleIV", ddlScore_TitleIV.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_TitleIV", DBNull.Value)
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

        If ddlScore_Collection_Charges_Waived.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Collection_Charges_Waived", ddlScore_Collection_Charges_Waived.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Collection_Charges_Waived", DBNull.Value)
        End If

        If ddlScore_Credit_Reporting.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Credit_Reporting", ddlScore_Credit_Reporting.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Credit_Reporting", DBNull.Value)
        End If

        'Added
        If ddlScore_Electronic_Payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Electronic_Payments", ddlScore_Electronic_Payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Electronic_Payments", DBNull.Value)
        End If

        'Supposed to be "Delay Tax Return"
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

        If ddlScore_Payments_Are_Final.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Payments_Are_Final", ddlScore_Payments_Are_Final.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Payments_Are_Final", DBNull.Value)
        End If

        If ddlScore_Not_Factual.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Not_Factual", ddlScore_Not_Factual.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Not_Factual", DBNull.Value)
        End If

        If ddlScore_Financial_Documents.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Financial_Documents", ddlScore_Financial_Documents.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Financial_Documents", DBNull.Value)
        End If

        If ddlScore_Rehab_Agreement_Letter.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Rehab_Agreement_Letter", ddlScore_Rehab_Agreement_Letter.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Rehab_Agreement_Letter", DBNull.Value)
        End If

        If ddlScore_Contact_Us.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Contact_Us", ddlScore_Contact_Us.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Contact_Us", DBNull.Value)
        End If


        'Added
        If ddlScore_Consol_New_Loan.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Consol_New_Loan", ddlScore_Consol_New_Loan.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Consol_New_Loan", DBNull.Value)
        End If

        'Added
        If ddlScore_Consol_Credit_Reporting.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Consol_Credit_Reporting", ddlScore_Consol_Credit_Reporting.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Consol_Credit_Reporting", DBNull.Value)
        End If

        'Added
        If ddlScore_Consol_Interest_Rates.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Consol_Interest_Rates", ddlScore_Consol_Interest_Rates.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Consol_Interest_Rates", DBNull.Value)
        End If

        'Added
        If ddlScore_Consol_Capitalization.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Consol_Capitalization", ddlScore_Consol_Capitalization.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Consol_Capitalization", DBNull.Value)
        End If

        'Added
        If ddlScore_Consol_TitleIV.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Consol_TitleIV", ddlScore_Consol_TitleIV.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Consol_TitleIV", DBNull.Value)
        End If

        'Added
        If ddlScore_Consol_Repayment_Options.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Consol_Repayment_Options", ddlScore_Consol_Repayment_Options.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Consol_Repayment_Options", DBNull.Value)
        End If

        'Added
        If ddlScore_Consol_Default.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Consol_Default", ddlScore_Consol_Default.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Consol_Default", DBNull.Value)
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

    Protected Sub btnSubmitAgain_Click(sender As Object, e As System.EventArgs)
        Dim RecordingDeliveryDate As String = Server.UrlEncode(txtRecordingDeliveryDate.Text)
        Dim ReviewPeriodMonth As String = Server.UrlEncode(ddlReviewPeriodMonth.SelectedValue)
        Dim ReviewPeriodYear As String = Server.UrlEncode(ddlReviewPeriodYear.SelectedValue)
        Response.Redirect("NewReview.aspx?PCAID=" & ddlPCAID.SelectedValue & "&CallDate=" & txtCallDate.Text & "&RecordingDeliveryDate=" & RecordingDeliveryDate & "&ReviewPeriodMonth=" & ReviewPeriodMonth & "&ReviewPeriodYear=" & ReviewPeriodYear & "&NewAssignmentID=" & lblNewAssignmentID.Text)
    End Sub

End Class
