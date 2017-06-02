Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_ReviewDetail2
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim ReviewID As Integer
            If Not Request.QueryString("ReviewID") Is Nothing Then
                ReviewID = Request.QueryString("ReviewID")
            Else
                ReviewID = 0
            End If

            lblReviewID.Text = ReviewID

            'Only admins can see the enter comments in the FSA Supervisor Comments box and delete call button
            If Roles.IsUserInRole("PCAReviews_Admins") = True Then
                ddlReviewPeriodMonth.Enabled = True
                ddlReviewPeriodYear.Enabled = True
                btnDelete.Visible = True
                txtFSASupervisor_Comments.Enabled = True
                txtRecordingDeliveryDate.Enabled = True
            Else
                btnDelete.Visible = False
                ddlReviewPeriodMonth.Enabled = False
                ddlReviewPeriodYear.Enabled = False
                txtFSASupervisor_Comments.Enabled = False
                txtRecordingDeliveryDate.Enabled = False
            End If

            'Tier1 and Tier2 can view the QC Tier1 section
            If Roles.IsUserInRole("PCAReviews_QCTier1") = True OrElse Roles.IsUserInRole("PCAReviews_QCTier2") = True Then
                pnlQCTier1.Visible = True
                LoadQCTier1(ReviewID)
            Else
                pnlQCTier1.Visible = False
            End If

            'Only Tier2 can view the QC Tier2 section
            If Roles.IsUserInRole("PCAReviews_QCTier2") = True Then
                pnlQCTier1.Visible = True
                LoadQCTier1(ReviewID)

                pnlQCTier2.Visible = True
                LoadQCTier2(ReviewID)
            Else
                pnlQCTier2.Visible = False
            End If

            'Load data in the form
            LoadForm(ReviewID)
        End If
    End Sub

    'Sub UserIDLookUp(ByVal ReviewID As Integer)
    '    Dim con As SqlConnection
    '    Dim cmd As SqlCommand
    '    Dim dr As SqlDataReader

    '    con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
    '    cmd = New SqlCommand("p_UserIDQCLookup", con)
    '    cmd.CommandType = CommandType.StoredProcedure

    '    cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = ReviewID

    '    Try
    '        cmd.Connection = con
    '        Using con
    '            con.Open()
    '            dr = cmd.ExecuteReader()
    '            While dr.Read()
    '                lblUserID.Text = dr("UserID").ToString()
    '            End While
    '        End Using

    '    Finally
    '        con.Close()
    '    End Try
    'End Sub

    Sub LoadForm(ByVal ReviewID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReviewID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = ReviewID

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    If Not dr("ReviewID") Is DBNull.Value Then
                        lblReviewID.Text = dr("ReviewID").ToString()
                    End If

                    If Not dr("ReviewAgency") Is DBNull.Value Then
                        lblReviewAgency.Text = dr("ReviewAgency").ToString()
                    End If

                    If Not dr("CallDate") Is DBNull.Value Then
                        txtCallDate.Text = dr("CallDate").ToString()
                    End If

                    If Not dr("PCAID") Is DBNull.Value Then
                        ddlPCAID.SelectedValue = dr("PCAID")
                    End If

                    If Not dr("RecordingDeliveryDate") Is DBNull.Value Then
                        txtRecordingDeliveryDate.Text = dr("RecordingDeliveryDate").ToString()
                    End If

                    If Not dr("ReviewPeriodMonth") Is DBNull.Value Then
                        ddlReviewPeriodMonth.SelectedValue = dr("ReviewPeriodMonth").ToString()
                    End If

                    If Not dr("ReviewPeriodYear") Is DBNull.Value Then
                        ddlReviewPeriodYear.SelectedValue = dr("ReviewPeriodYear").ToString()
                    End If

                    If Not dr("BorrowerLastName") Is DBNull.Value Then
                        txtBorrowerLastName.Text = dr("BorrowerLastName").ToString()
                    End If

                    If Not dr("UserID") Is DBNull.Value Then
                        lblUserID.Text = dr("UserID").ToString()
                    End If

                    If Not dr("BorrowerNumber") Is DBNull.Value Then
                        txtBorrowerNumber.Text = dr("BorrowerNumber").ToString()
                    End If

                    If Not dr("InOutBound") Is DBNull.Value Then
                        ddlInOutBound.SelectedValue = dr("InOutBound").ToString()
                    End If

                    If Not dr("CallType") Is DBNull.Value Then
                        ddlCallType.SelectedValue = dr("CallType").ToString()
                    End If

                    If Not dr("CallLength") Is DBNull.Value Then
                        txtCallLength.Text = dr("CallLength").ToString()
                    End If

                    If Not dr("CallLengthActual") Is DBNull.Value Then
                        txtCallLengthActual.Text = dr("CallLengthActual").ToString()
                    End If

                    If Not dr("RehabTalkOff") Is DBNull.Value Then
                        ddlRehabTalkOff.SelectedValue = dr("RehabTalkOff").ToString()
                    End If

                    If Not dr("ConsolTalkOff") Is DBNull.Value Then
                        ddlConsolTalkOff.SelectedValue = dr("ConsolTalkOff").ToString()
                    End If

                    If Not dr("Score_CorrectID") Is DBNull.Value Then
                        ddlScore_CorrectID.SelectedValue = dr("Score_CorrectID")
                    End If

                    If Not dr("Score_ProperlyIdentified") Is DBNull.Value Then
                        ddlScore_ProperlyIdentified.SelectedValue = dr("Score_ProperlyIdentified")
                    End If

                    If Not dr("Score_MiniMiranda") Is DBNull.Value Then
                        ddlScore_MiniMiranda.SelectedValue = dr("Score_MiniMiranda")
                    End If

                    If Not dr("Score_Tone") Is DBNull.Value Then
                        ddlScore_Tone.SelectedValue = dr("Score_Tone")
                    End If

                    If Not dr("Score_Accuracy") Is DBNull.Value Then
                        ddlScore_Accuracy.SelectedValue = dr("Score_Accuracy")
                    End If

                    If Not dr("Score_Notepad") Is DBNull.Value Then
                        ddlScore_Notepad.SelectedValue = dr("Score_Notepad")
                    End If

                    If Not dr("Score_PCAResponsive") Is DBNull.Value Then
                        ddlScore_PCAResponsive.SelectedValue = dr("Score_PCAResponsive")
                    End If

                    If Not dr("Score_AWGInfo") Is DBNull.Value Then
                        ddlScore_AWGInfo.SelectedValue = dr("Score_AWGInfo")
                    End If

                    If Not dr("Complaint") Is DBNull.Value Then
                        ddlComplaint.SelectedValue = dr("Complaint").ToString()
                    End If

                    If Not dr("Score_Disconnect_Borrower") Is DBNull.Value Then
                        ddlScore_Disconnect_Borrower.SelectedValue = dr("Score_Disconnect_Borrower")
                    End If

                    If Not dr("IMF_Submission_Date") Is DBNull.Value Then
                        txtIMF_Submission_Date.Text = dr("IMF_Submission_Date").ToString()
                    End If

                    If Not dr("IMF_Timely") Is DBNull.Value Then
                        ddlIMF_Timely.SelectedValue = dr("IMF_Timely").ToString()
                    End If

                    If Not dr("Score_ExceededHoldTime") Is DBNull.Value Then
                        ddlScore_ExceededHoldTime.SelectedValue = dr("Score_ExceededHoldTime").ToString()
                    End If

                    'Rehab Fields

                    If Not dr("Score_Rehab_Once") Is DBNull.Value Then
                        ddlScore_Rehab_Once.SelectedValue = dr("Score_Rehab_Once")
                    End If

                    If Not dr("Score_Nine_Payments") Is DBNull.Value Then
                        ddlScore_Nine_Payments.SelectedValue = dr("Score_Nine_Payments")
                    End If

                    If Not dr("Score_TitleIV") Is DBNull.Value Then
                        ddlScore_TitleIV.SelectedValue = dr("Score_TitleIV")
                    End If

                    If Not dr("Score_Credit_Reporting") Is DBNull.Value Then
                        ddlScore_Credit_Reporting.SelectedValue = dr("Score_Credit_Reporting")
                    End If

                    If Not dr("Score_TOP") Is DBNull.Value Then
                        ddlScore_TOP.SelectedValue = dr("Score_TOP")
                    End If

                    If Not dr("Score_AWG") Is DBNull.Value Then
                        ddlScore_AWG.SelectedValue = dr("Score_AWG")
                    End If

                    If Not dr("Score_Continue_Payments") Is DBNull.Value Then
                        ddlScore_Continue_Payments.SelectedValue = dr("Score_Continue_Payments")
                    End If

                    If Not dr("Score_Collection_Charges_Waived") Is DBNull.Value Then
                        ddlScore_Collection_Charges_Waived.SelectedValue = dr("Score_Collection_Charges_Waived")
                    End If

                    If Not dr("Score_Financial_Documents") Is DBNull.Value Then
                        ddlScore_Financial_Documents.SelectedValue = dr("Score_Financial_Documents")
                    End If

                    If Not dr("Score_Rehab_Agreement_Letter") Is DBNull.Value Then
                        ddlScore_Rehab_Agreement_Letter.SelectedValue = dr("Score_Rehab_Agreement_Letter")
                    End If

                    If Not dr("Score_Contact_Us") Is DBNull.Value Then
                        ddlScore_Contact_Us.SelectedValue = dr("Score_Contact_Us")
                    End If

                    If Not dr("Score_Eligible_Payment_Plans") Is DBNull.Value Then
                        ddlScore_Eligible_Payment_Plans.SelectedValue = dr("Score_Eligible_Payment_Plans")
                    End If

                    If Not dr("Score_Deferment_Forb") Is DBNull.Value Then
                        ddlScore_Deferment_Forb.SelectedValue = dr("Score_Deferment_Forb")
                    End If

                    If Not dr("Score_New_Payment_Schedule") Is DBNull.Value Then
                        ddlScore_New_Payment_Schedule.SelectedValue = dr("Score_New_Payment_Schedule")
                    End If

                    If Not dr("Score_Reversed_Payments") Is DBNull.Value Then
                        ddlScore_Reversed_Payments.SelectedValue = dr("Score_Reversed_Payments")
                    End If

                    If Not dr("Score_Loans_Transferred_After_60_Days") Is DBNull.Value Then
                        ddlScore_Loans_Transferred_After_60_Days.SelectedValue = dr("Score_Loans_Transferred_After_60_Days")
                    End If

                    If Not dr("Score_Electronic_Payments") Is DBNull.Value Then
                        ddlScore_Electronic_Payments.SelectedValue = dr("Score_Electronic_Payments")
                    End If

                    If Not dr("Score_Delay_Tax_Reform") Is DBNull.Value Then
                        ddlScore_Delay_Tax_Reform.SelectedValue = dr("Score_Delay_Tax_Reform")
                    End If

                    If Not dr("Score_More_Aid") Is DBNull.Value Then
                        ddlScore_More_Aid.SelectedValue = dr("Score_More_Aid")
                    End If

                    If Not dr("Score_Collection_Costs_Waived") Is DBNull.Value Then
                        ddlScore_Collection_Costs_Waived.SelectedValue = dr("Score_Collection_Costs_Waived")
                    End If

                    If Not dr("Score_False_Requirements") Is DBNull.Value Then
                        ddlScore_False_Requirements.SelectedValue = dr("Score_False_Requirements")
                    End If

                    If Not dr("Score_Avoid_PIF") Is DBNull.Value Then
                        ddlScore_Avoid_PIF.SelectedValue = dr("Score_Avoid_PIF")
                    End If

                    If Not dr("Score_Rehab_Then_TPD") Is DBNull.Value Then
                        ddlScore_Rehab_Then_TPD.SelectedValue = dr("Score_Rehab_Then_TPD")
                    End If

                    If Not dr("Score_Payments_Are_Final") Is DBNull.Value Then
                        ddlScore_Payments_Are_Final.SelectedValue = dr("Score_Payments_Are_Final")
                    End If

                    If Not dr("Score_Not_Factual") Is DBNull.Value Then
                        ddlScore_Not_Factual.SelectedValue = dr("Score_Not_Factual")
                    End If
                    'End Rehab Fields   

                    'Added
                    If Not dr("Score_Consol_New_Loan") Is DBNull.Value Then
                        ddlScore_Consol_New_Loan.SelectedValue = dr("Score_Consol_New_Loan")
                    End If
                    'Added
                    If Not dr("Score_Consol_Credit_Reporting") Is DBNull.Value Then
                        ddlScore_Consol_Credit_Reporting.SelectedValue = dr("Score_Consol_Credit_Reporting")
                    End If
                    'Added
                    If Not dr("Score_Consol_Interest_Rates") Is DBNull.Value Then
                        ddlScore_Consol_Interest_Rates.SelectedValue = dr("Score_Consol_Interest_Rates")
                    End If
                    'Added
                    If Not dr("Score_Consol_Capitalization") Is DBNull.Value Then
                        ddlScore_Consol_Capitalization.SelectedValue = dr("Score_Consol_Capitalization")
                    End If
                    'Added
                    If Not dr("Score_Consol_TitleIV") Is DBNull.Value Then
                        ddlScore_Consol_TitleIV.SelectedValue = dr("Score_Consol_TitleIV")
                    End If
                    'Added
                    If Not dr("Score_Consol_Repayment_Options") Is DBNull.Value Then
                        ddlScore_Consol_Repayment_Options.SelectedValue = dr("Score_Consol_Repayment_Options")
                    End If
                    'Added
                    If Not dr("Score_Consol_Default") Is DBNull.Value Then
                        ddlScore_Consol_Default.SelectedValue = dr("Score_Consol_Default")
                    End If

                    If Not dr("FSA_Comments") Is DBNull.Value Then
                        txtFSA_Comments.Text = dr("FSA_Comments").ToString()
                    End If

                    If Not dr("FSASupervisor_Comments") Is DBNull.Value Then
                        txtFSASupervisor_Comments.Text = dr("FSASupervisor_Comments").ToString()
                    End If

                    If Not dr("PCA_Comments") Is DBNull.Value Then
                        txtPCA_Comments.Text = dr("PCA_Comments").ToString()
                    End If

                    If Not dr("FSA_Conclusions") Is DBNull.Value Then
                        txtFSA_Conclusions.Text = dr("FSA_Conclusions").ToString()
                    End If

                    If Not dr("Correct_Actions") Is DBNull.Value Then
                        lblCorrect_Actions.Text = dr("Correct_Actions").ToString()
                    End If

                    If Not dr("Incorrect_Actions") Is DBNull.Value Then
                        lblIncorrect_Actions.Text = dr("Incorrect_Actions").ToString()
                    End If

                    If Not dr("Total_Actions") Is DBNull.Value Then
                        lblTotal_Actions.Text = dr("Total_Actions").ToString()
                    End If

                    If Not dr("Percent_Actions") Is DBNull.Value Then
                        lblPercent_Actions.Text = dr("Percent_Actions").ToString()
                    End If

                End While
            End Using

            'Page.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Sub LoadQCTier1(ByVal ReviewID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReviewIDQCTier1", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = ReviewID

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    If Not dr("DateSubmitted") Is DBNull.Value Then
                        lblQCTier1DateSubmitted.Text = dr("DateSubmitted")
                    End If

                    If Not dr("Score_CorrectID_Accuracy") Is DBNull.Value Then
                        ddlScore_CorrectID_Accuracy.SelectedValue = dr("Score_CorrectID_Accuracy")
                    End If

                    If Not dr("Score_ProperlyIdentified_Accuracy") Is DBNull.Value Then
                        ddlScore_ProperlyIdentified_Accuracy.SelectedValue = dr("Score_ProperlyIdentified_Accuracy")
                    End If

                    If Not dr("Score_MiniMiranda_Accuracy") Is DBNull.Value Then
                        ddlScore_MiniMiranda_Accuracy.SelectedValue = dr("Score_MiniMiranda_Accuracy")
                    End If

                    If Not dr("Score_Tone_Accuracy") Is DBNull.Value Then
                        ddlScore_Tone_Accuracy.SelectedValue = dr("Score_Tone_Accuracy")
                    End If

                    If Not dr("Score_Accuracy_Accuracy") Is DBNull.Value Then
                        ddlScore_Accuracy_Accuracy.SelectedValue = dr("Score_Accuracy_Accuracy")
                    End If

                    If Not dr("Score_Notepad_Accuracy") Is DBNull.Value Then
                        ddlScore_Notepad_Accuracy.SelectedValue = dr("Score_Notepad_Accuracy")
                    End If

                    If Not dr("Score_PCAResponsive_Accuracy") Is DBNull.Value Then
                        ddlScore_PCAResponsive_Accuracy.SelectedValue = dr("Score_PCAResponsive_Accuracy")
                    End If

                    If Not dr("Score_AWGInfo_Accuracy") Is DBNull.Value Then
                        ddlScore_AWGInfo_Accuracy.SelectedValue = dr("Score_AWGInfo_Accuracy")
                    End If

                    If Not dr("Complaint_Accuracy") Is DBNull.Value Then
                        ddlComplaint_Accuracy.SelectedValue = dr("Complaint_Accuracy").ToString()
                    End If

                    If Not dr("Score_ExceededHoldTime_Accuracy") Is DBNull.Value Then
                        ddlScore_ExceededHoldTime_Accuracy.SelectedValue = dr("Score_ExceededHoldTime_Accuracy").ToString()
                    End If

                    If Not dr("Score_Rehab_Once_Accuracy") Is DBNull.Value Then
                        ddlScore_Rehab_Once_Accuracy.SelectedValue = dr("Score_Rehab_Once_Accuracy").ToString()
                    End If

                    If Not dr("Score_Nine_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Nine_Payments_Accuracy.SelectedValue = dr("Score_Nine_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_TitleIV_Accuracy") Is DBNull.Value Then
                        ddlScore_TitleIV_Accuracy.SelectedValue = dr("Score_TitleIV_Accuracy").ToString()
                    End If

                    If Not dr("Score_Credit_Reporting_Accuracy") Is DBNull.Value Then
                        ddlScore_Credit_Reporting_Accuracy.SelectedValue = dr("Score_Credit_Reporting_Accuracy").ToString()
                    End If

                    If Not dr("Score_TOP_Accuracy") Is DBNull.Value Then
                        ddlScore_TOP_Accuracy.SelectedValue = dr("Score_TOP_Accuracy").ToString()
                    End If

                    If Not dr("Score_AWG_Accuracy") Is DBNull.Value Then
                        ddlScore_AWG_Accuracy.SelectedValue = dr("Score_AWG_Accuracy").ToString()
                    End If

                    If Not dr("Score_Continue_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Continue_Payments_Accuracy.SelectedValue = dr("Score_Continue_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_Collection_Charges_Waived_Accuracy") Is DBNull.Value Then
                        ddlScore_Collection_Charges_Waived_Accuracy.SelectedValue = dr("Score_Collection_Charges_Waived_Accuracy").ToString()
                    End If

                    If Not dr("Score_Financial_Documents_Accuracy") Is DBNull.Value Then
                        ddlScore_Financial_Documents_Accuracy.SelectedValue = dr("Score_Financial_Documents_Accuracy").ToString()
                    End If

                    If Not dr("Score_Rehab_Agreement_Letter_Accuracy") Is DBNull.Value Then
                        ddlScore_Rehab_Agreement_Letter_Accuracy.SelectedValue = dr("Score_Rehab_Agreement_Letter_Accuracy").ToString()
                    End If

                    If Not dr("Score_Contact_Us_Accuracy") Is DBNull.Value Then
                        ddlScore_Contact_Us_Accuracy.SelectedValue = dr("Score_Contact_Us_Accuracy").ToString()
                    End If

                    If Not dr("Score_Eligible_Payment_Plans_Accuracy") Is DBNull.Value Then
                        ddlScore_Eligible_Payment_Plans_Accuracy.SelectedValue = dr("Score_Eligible_Payment_Plans_Accuracy").ToString()
                    End If

                    If Not dr("Score_Deferment_Forb_Accuracy") Is DBNull.Value Then
                        ddlScore_Deferment_Forb_Accuracy.SelectedValue = dr("Score_Deferment_Forb_Accuracy").ToString()
                    End If

                    If Not dr("Score_New_Payment_Schedule_Accuracy") Is DBNull.Value Then
                        ddlScore_New_Payment_Schedule_Accuracy.SelectedValue = dr("Score_New_Payment_Schedule_Accuracy").ToString()
                    End If

                    If Not dr("Score_Reversed_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Reversed_Payments_Accuracy.SelectedValue = dr("Score_Reversed_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_Loans_Transferred_After_60_Days_Accuracy") Is DBNull.Value Then
                        ddlScore_Loans_Transferred_After_60_Days_Accuracy.SelectedValue = dr("Score_Loans_Transferred_After_60_Days_Accuracy").ToString()
                    End If

                    If Not dr("Score_Electronic_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Electronic_Payments_Accuracy.SelectedValue = dr("Score_Electronic_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_Delay_Tax_Reform_Accuracy") Is DBNull.Value Then
                        ddlScore_Delay_Tax_Reform_Accuracy.SelectedValue = dr("Score_Delay_Tax_Reform_Accuracy").ToString()
                    End If

                    If Not dr("Score_More_Aid_Accuracy") Is DBNull.Value Then
                        ddlScore_More_Aid_Accuracy.SelectedValue = dr("Score_More_Aid_Accuracy").ToString()
                    End If

                    If Not dr("Score_Collection_Costs_Waived_Accuracy") Is DBNull.Value Then
                        ddlScore_Collection_Costs_Waived_Accuracy.SelectedValue = dr("Score_Collection_Costs_Waived_Accuracy").ToString()
                    End If

                    If Not dr("Score_False_Requirements_Accuracy") Is DBNull.Value Then
                        ddlScore_False_Requirements_Accuracy.SelectedValue = dr("Score_False_Requirements_Accuracy").ToString()
                    End If

                    If Not dr("Score_Avoid_PIF_Accuracy") Is DBNull.Value Then
                        ddlScore_Avoid_PIF_Accuracy.SelectedValue = dr("Score_Avoid_PIF_Accuracy").ToString()
                    End If

                    If Not dr("Score_Avoid_PIF_Accuracy") Is DBNull.Value Then
                        ddlScore_Avoid_PIF_Accuracy.SelectedValue = dr("Score_Avoid_PIF_Accuracy").ToString()
                    End If

                    If Not dr("Score_Rehab_Then_TPD_Accuracy") Is DBNull.Value Then
                        ddlScore_Rehab_Then_TPD_Accuracy.SelectedValue = dr("Score_Rehab_Then_TPD_Accuracy").ToString()
                    End If

                    If Not dr("Score_Payments_Are_Final_Accuracy") Is DBNull.Value Then
                        ddlScore_Payments_Are_Final_Accuracy.SelectedValue = dr("Score_Payments_Are_Final_Accuracy").ToString()
                    End If

                    If Not dr("Score_Not_Factual_Accuracy") Is DBNull.Value Then
                        ddlScore_Not_Factual_Accuracy.SelectedValue = dr("Score_Not_Factual_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_New_Loan_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_New_Loan_Accuracy.SelectedValue = dr("Score_Consol_New_Loan_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Credit_Reporting_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Credit_Reporting_Accuracy.SelectedValue = dr("Score_Consol_Credit_Reporting_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Interest_Rates_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Interest_Rates_Accuracy.SelectedValue = dr("Score_Consol_Interest_Rates_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Capitalization_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Capitalization_Accuracy.SelectedValue = dr("Score_Consol_Capitalization_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_TitleIV_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_TitleIV_Accuracy.SelectedValue = dr("Score_Consol_TitleIV_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Repayment_Options_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Repayment_Options_Accuracy.SelectedValue = dr("Score_Consol_Repayment_Options_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Default_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Default_Accuracy.SelectedValue = dr("Score_Consol_Default_Accuracy").ToString()
                    End If

                    If Not dr("Comments") Is DBNull.Value Then
                        txtComments.Text = dr("Comments").ToString()
                    End If

                End While
            End Using

            'Page.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Sub LoadQCTier2(ByVal ReviewID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReviewIDQCTier2", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = ReviewID

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    If Not dr("Score_CorrectID_Accuracy") Is DBNull.Value Then
                        ddlScore_CorrectID_Accuracy2.SelectedValue = dr("Score_CorrectID_Accuracy")
                    End If

                    If Not dr("Score_ProperlyIdentified_Accuracy") Is DBNull.Value Then
                        ddlScore_ProperlyIdentified_Accuracy2.SelectedValue = dr("Score_ProperlyIdentified_Accuracy")
                    End If

                    If Not dr("Score_MiniMiranda_Accuracy") Is DBNull.Value Then
                        ddlScore_MiniMiranda_Accuracy2.SelectedValue = dr("Score_MiniMiranda_Accuracy")
                    End If

                    If Not dr("Score_Tone_Accuracy") Is DBNull.Value Then
                        ddlScore_Tone_Accuracy2.SelectedValue = dr("Score_Tone_Accuracy")
                    End If

                    If Not dr("Score_Accuracy_Accuracy") Is DBNull.Value Then
                        ddlScore_Accuracy_Accuracy2.SelectedValue = dr("Score_Accuracy_Accuracy")
                    End If

                    If Not dr("Score_Notepad_Accuracy") Is DBNull.Value Then
                        ddlScore_Notepad_Accuracy2.SelectedValue = dr("Score_Notepad_Accuracy")
                    End If

                    If Not dr("Score_PCAResponsive_Accuracy") Is DBNull.Value Then
                        ddlScore_PCAResponsive_Accuracy2.SelectedValue = dr("Score_PCAResponsive_Accuracy")
                    End If

                    If Not dr("Score_AWGInfo_Accuracy") Is DBNull.Value Then
                        ddlScore_AWGInfo_Accuracy2.SelectedValue = dr("Score_AWGInfo_Accuracy")
                    End If

                    If Not dr("Complaint_Accuracy") Is DBNull.Value Then
                        ddlComplaint_Accuracy2.SelectedValue = dr("Complaint_Accuracy").ToString()
                    End If

                    If Not dr("Score_ExceededHoldTime_Accuracy") Is DBNull.Value Then
                        ddlScore_ExceededHoldTime_Accuracy2.SelectedValue = dr("Score_ExceededHoldTime_Accuracy").ToString()
                    End If

                    If Not dr("Score_Rehab_Once_Accuracy") Is DBNull.Value Then
                        ddlScore_Rehab_Once_Accuracy2.SelectedValue = dr("Score_Rehab_Once_Accuracy").ToString()
                    End If

                    If Not dr("Score_Nine_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Nine_Payments_Accuracy2.SelectedValue = dr("Score_Nine_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_TitleIV_Accuracy") Is DBNull.Value Then
                        ddlScore_TitleIV_Accuracy2.SelectedValue = dr("Score_TitleIV_Accuracy").ToString()
                    End If

                    If Not dr("Score_Credit_Reporting_Accuracy") Is DBNull.Value Then
                        ddlScore_Credit_Reporting_Accuracy2.SelectedValue = dr("Score_Credit_Reporting_Accuracy").ToString()
                    End If

                    If Not dr("Score_TOP_Accuracy") Is DBNull.Value Then
                        ddlScore_TOP_Accuracy2.SelectedValue = dr("Score_TOP_Accuracy").ToString()
                    End If

                    If Not dr("Score_AWG_Accuracy") Is DBNull.Value Then
                        ddlScore_AWG_Accuracy2.SelectedValue = dr("Score_AWG_Accuracy").ToString()
                    End If

                    If Not dr("Score_Continue_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Continue_Payments_Accuracy2.SelectedValue = dr("Score_Continue_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_Collection_Charges_Waived_Accuracy") Is DBNull.Value Then
                        ddlScore_Collection_Charges_Waived_Accuracy2.SelectedValue = dr("Score_Collection_Charges_Waived_Accuracy").ToString()
                    End If

                    If Not dr("Score_Financial_Documents_Accuracy") Is DBNull.Value Then
                        ddlScore_Financial_Documents_Accuracy2.SelectedValue = dr("Score_Financial_Documents_Accuracy").ToString()
                    End If

                    If Not dr("Score_Rehab_Agreement_Letter_Accuracy") Is DBNull.Value Then
                        ddlScore_Rehab_Agreement_Letter_Accuracy2.SelectedValue = dr("Score_Rehab_Agreement_Letter_Accuracy").ToString()
                    End If

                    If Not dr("Score_Contact_Us_Accuracy") Is DBNull.Value Then
                        ddlScore_Contact_Us_Accuracy2.SelectedValue = dr("Score_Contact_Us_Accuracy").ToString()
                    End If

                    If Not dr("Score_Eligible_Payment_Plans_Accuracy") Is DBNull.Value Then
                        ddlScore_Eligible_Payment_Plans_Accuracy2.SelectedValue = dr("Score_Eligible_Payment_Plans_Accuracy").ToString()
                    End If

                    If Not dr("Score_Deferment_Forb_Accuracy") Is DBNull.Value Then
                        ddlScore_Deferment_Forb_Accuracy2.SelectedValue = dr("Score_Deferment_Forb_Accuracy").ToString()
                    End If

                    If Not dr("Score_New_Payment_Schedule_Accuracy") Is DBNull.Value Then
                        ddlScore_New_Payment_Schedule_Accuracy2.SelectedValue = dr("Score_New_Payment_Schedule_Accuracy").ToString()
                    End If

                    If Not dr("Score_Reversed_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Reversed_Payments_Accuracy2.SelectedValue = dr("Score_Reversed_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_Loans_Transferred_After_60_Days_Accuracy") Is DBNull.Value Then
                        ddlScore_Loans_Transferred_After_60_Days_Accuracy2.SelectedValue = dr("Score_Loans_Transferred_After_60_Days_Accuracy").ToString()
                    End If

                    If Not dr("Score_Electronic_Payments_Accuracy") Is DBNull.Value Then
                        ddlScore_Electronic_Payments_Accuracy2.SelectedValue = dr("Score_Electronic_Payments_Accuracy").ToString()
                    End If

                    If Not dr("Score_Delay_Tax_Reform_Accuracy") Is DBNull.Value Then
                        ddlScore_Delay_Tax_Reform_Accuracy2.SelectedValue = dr("Score_Delay_Tax_Reform_Accuracy").ToString()
                    End If

                    If Not dr("Score_More_Aid_Accuracy") Is DBNull.Value Then
                        ddlScore_More_Aid_Accuracy2.SelectedValue = dr("Score_More_Aid_Accuracy").ToString()
                    End If

                    If Not dr("Score_Collection_Costs_Waived_Accuracy") Is DBNull.Value Then
                        ddlScore_Collection_Costs_Waived_Accuracy2.SelectedValue = dr("Score_Collection_Costs_Waived_Accuracy").ToString()
                    End If

                    If Not dr("Score_False_Requirements_Accuracy") Is DBNull.Value Then
                        ddlScore_False_Requirements_Accuracy2.SelectedValue = dr("Score_False_Requirements_Accuracy").ToString()
                    End If

                    If Not dr("Score_Avoid_PIF_Accuracy") Is DBNull.Value Then
                        ddlScore_Avoid_PIF_Accuracy2.SelectedValue = dr("Score_Avoid_PIF_Accuracy").ToString()
                    End If

                    If Not dr("Score_Avoid_PIF_Accuracy") Is DBNull.Value Then
                        ddlScore_Avoid_PIF_Accuracy2.SelectedValue = dr("Score_Avoid_PIF_Accuracy").ToString()
                    End If

                    If Not dr("Score_Rehab_Then_TPD_Accuracy") Is DBNull.Value Then
                        ddlScore_Rehab_Then_TPD_Accuracy2.SelectedValue = dr("Score_Rehab_Then_TPD_Accuracy").ToString()
                    End If

                    If Not dr("Score_Payments_Are_Final_Accuracy") Is DBNull.Value Then
                        ddlScore_Payments_Are_Final_Accuracy2.SelectedValue = dr("Score_Payments_Are_Final_Accuracy").ToString()
                    End If

                    If Not dr("Score_Not_Factual_Accuracy") Is DBNull.Value Then
                        ddlScore_Not_Factual_Accuracy2.SelectedValue = dr("Score_Not_Factual_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_New_Loan_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_New_Loan_Accuracy2.SelectedValue = dr("Score_Consol_New_Loan_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Credit_Reporting_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Credit_Reporting_Accuracy2.SelectedValue = dr("Score_Consol_Credit_Reporting_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Interest_Rates_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Interest_Rates_Accuracy2.SelectedValue = dr("Score_Consol_Interest_Rates_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Capitalization_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Capitalization_Accuracy2.SelectedValue = dr("Score_Consol_Capitalization_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_TitleIV_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_TitleIV_Accuracy2.SelectedValue = dr("Score_Consol_TitleIV_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Repayment_Options_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Repayment_Options_Accuracy2.SelectedValue = dr("Score_Consol_Repayment_Options_Accuracy").ToString()
                    End If

                    If Not dr("Score_Consol_Default_Accuracy") Is DBNull.Value Then
                        ddlScore_Consol_Default_Accuracy2.SelectedValue = dr("Score_Consol_Default_Accuracy").ToString()
                    End If

                    If Not dr("Returned_Worksheet_Entire") Is DBNull.Value Then
                        ddlReturned_Worksheet_Entire.SelectedValue = dr("Returned_Worksheet_Entire").ToString()
                    End If

                    If Not dr("Returned_Worksheet_Once") Is DBNull.Value Then
                        ddlReturned_Worksheet_Once.SelectedValue = dr("Returned_Worksheet_Once").ToString()
                    End If

                    If Not dr("Returned_Worksheet_Twice") Is DBNull.Value Then
                        ddlReturned_Worksheet_Twice.SelectedValue = dr("Returned_Worksheet_Twice").ToString()
                    End If

                    If Not dr("Comments") Is DBNull.Value Then
                        txtComments2.Text = dr("Comments").ToString()
                    End If

                End While
            End Using

            'Page.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateReviewID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = lblReviewID.Text
        cmd.Parameters.Add("@CallDate", SqlDbType.SmallDateTime).Value = txtCallDate.Text

        If ddlPCAID.SelectedValue <> "" Then
            cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        Else
            cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = DBNull.Value
        End If

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
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = txtRecordingDeliveryDate.Text
        Else
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtBorrowerLastName.Text <> "" Then
            cmd.Parameters.Add("@BorrowerLastName", SqlDbType.VarChar).Value = txtBorrowerLastName.Text
        Else
            cmd.Parameters.Add("@BorrowerLastName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        Else
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlInOutBound.SelectedValue <> "" Then
            cmd.Parameters.Add("@InOutBound", SqlDbType.VarChar).Value = ddlInOutBound.SelectedValue
        Else
            cmd.Parameters.Add("@InOutBound", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlCallType.SelectedValue <> "" Then
            cmd.Parameters.Add("@CallType", SqlDbType.VarChar).Value = ddlCallType.SelectedValue
        Else
            cmd.Parameters.Add("@CallType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtCallLength.Text <> "" Then
            cmd.Parameters.Add("@CallLength", SqlDbType.VarChar).Value = txtCallLength.Text
        Else
            cmd.Parameters.Add("@CallLength", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtCallLengthActual.Text <> "" Then
            cmd.Parameters.Add("@CallLengthActual", SqlDbType.VarChar).Value = txtCallLengthActual.Text
        Else
            cmd.Parameters.Add("@CallLengthActual", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlRehabTalkOff.SelectedValue <> "" Then
            cmd.Parameters.Add("@RehabTalkOff", SqlDbType.VarChar).Value = ddlRehabTalkOff.SelectedValue
        Else
            cmd.Parameters.Add("@RehabTalkOff", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlConsolTalkOff.SelectedValue <> "" Then
            cmd.Parameters.Add("@ConsolTalkOff", SqlDbType.VarChar).Value = ddlConsolTalkOff.SelectedValue
        Else
            cmd.Parameters.Add("@ConsolTalkOff", SqlDbType.VarChar).Value = DBNull.Value
        End If

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

        If ddlScore_Disconnect_Borrower.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Disconnect_Borrower", ddlScore_Disconnect_Borrower.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Disconnect_Borrower", DBNull.Value)
        End If

        'cmd.Parameters.Add("@Score_CorrectID_Accuracy", SqlDbType.VarChar).Value = ddlScore_CorrectID_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Score_ProperlyIdentified_Accuracy", SqlDbType.VarChar).Value = ddlScore_ProperlyIdentified_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Score_MiniMiranda_Accuracy", SqlDbType.VarChar).Value = ddlScore_MiniMiranda_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Score_Tone_Accuracy", SqlDbType.VarChar).Value = ddlScore_Tone_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Score_Accuracy_Accuracy", SqlDbType.VarChar).Value = ddlScore_Accuracy_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Score_Notepad_Accuracy", SqlDbType.VarChar).Value = ddlScore_Notepad_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Score_PCAResponsive_Accuracy", SqlDbType.VarChar).Value = ddlScore_PCAResponsive_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Score_AWGInfo_Accuracy", SqlDbType.VarChar).Value = ddlScore_AWGInfo_Accuracy.SelectedValue
        'cmd.Parameters.Add("@Complaint_Accuracy", SqlDbType.VarChar).Value = ddlComplaint_Accuracy.SelectedValue

        If txtIMF_Submission_Date.Text <> "" Then
            cmd.Parameters.Add("@IMF_Submission_Date", SqlDbType.SmallDateTime).Value = txtIMF_Submission_Date.Text
        Else
            cmd.Parameters.Add("@IMF_Submission_Date", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If ddlIMF_Timely.SelectedValue <> "" Then
            cmd.Parameters.Add("@IMF_Timely", SqlDbType.VarChar).Value = ddlIMF_Timely.SelectedValue
        Else
            cmd.Parameters.Add("@IMF_Timely", SqlDbType.VarChar).Value = DBNull.Value
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

        If ddlScore_Credit_Reporting.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Credit_Reporting", ddlScore_Credit_Reporting.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Credit_Reporting", DBNull.Value)
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

        If ddlScore_Collection_Charges_Waived.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Collection_Charges_Waived", ddlScore_Collection_Charges_Waived.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Collection_Charges_Waived", DBNull.Value)
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

        If ddlScore_New_Payment_Schedule.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_New_Payment_Schedule", ddlScore_New_Payment_Schedule.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_New_Payment_Schedule", DBNull.Value)
        End If

        If ddlScore_Reversed_Payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Reversed_Payments", ddlScore_Reversed_Payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Reversed_Payments", DBNull.Value)
        End If

        If ddlScore_Loans_Transferred_After_60_Days.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Loans_Transferred_After_60_Days", ddlScore_Loans_Transferred_After_60_Days.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Loans_Transferred_After_60_Days", DBNull.Value)
        End If

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
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your review was successfully updated"

            'Now save the QC Tier1 section if the user is in Tiers 1 or 2
            'If Roles.IsUserInRole("PCAReviews_QCTier1") = True OrElse Roles.IsUserInRole("PCAReviews_QCTier2") = True Then
            '    UpdateQCTier1(lblReviewID.Text)
            'End If

            ''Now save the QC Tier2 section if the user is in Tier2
            'If Roles.IsUserInRole("PCAReviews_QCTier2") = True Then
            '    UpdateQCTier2(lblReviewID.Text)
            'End If

        Finally
            con.Close()
        End Try
    End Sub

    Sub UpdateQCTier1_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateReviewIDQCTier1", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = lblReviewID.Text
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name
        cmd.Parameters.Add("@Score_CorrectID_Accuracy", SqlDbType.VarChar).Value = ddlScore_CorrectID_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_ProperlyIdentified_Accuracy", SqlDbType.VarChar).Value = ddlScore_ProperlyIdentified_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_MiniMiranda_Accuracy", SqlDbType.VarChar).Value = ddlScore_MiniMiranda_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Tone_Accuracy", SqlDbType.VarChar).Value = ddlScore_Tone_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Accuracy_Accuracy", SqlDbType.VarChar).Value = ddlScore_Accuracy_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Notepad_Accuracy", SqlDbType.VarChar).Value = ddlScore_Notepad_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_PCAResponsive_Accuracy", SqlDbType.VarChar).Value = ddlScore_PCAResponsive_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_AWGInfo_Accuracy", SqlDbType.VarChar).Value = ddlScore_AWGInfo_Accuracy.SelectedValue
        cmd.Parameters.Add("@Complaint_Accuracy", SqlDbType.VarChar).Value = ddlComplaint_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_ExceededHoldTime_Accuracy", SqlDbType.VarChar).Value = ddlScore_ExceededHoldTime_Accuracy.SelectedValue

        cmd.Parameters.Add("@Score_Rehab_Once_Accuracy", SqlDbType.VarChar).Value = ddlScore_Rehab_Once_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Nine_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Nine_Payments_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_TitleIV_Accuracy", SqlDbType.VarChar).Value = ddlScore_TitleIV_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Credit_Reporting_Accuracy", SqlDbType.VarChar).Value = ddlScore_Credit_Reporting_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_TOP_Accuracy", SqlDbType.VarChar).Value = ddlScore_TOP_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_AWG_Accuracy", SqlDbType.VarChar).Value = ddlScore_AWG_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Continue_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Continue_Payments_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Collection_Charges_Waived_Accuracy", SqlDbType.VarChar).Value = ddlScore_Collection_Charges_Waived_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Financial_Documents_Accuracy", SqlDbType.VarChar).Value = ddlScore_Financial_Documents_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Rehab_Agreement_Letter_Accuracy", SqlDbType.VarChar).Value = ddlScore_Rehab_Agreement_Letter_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Contact_Us_Accuracy", SqlDbType.VarChar).Value = ddlScore_Contact_Us_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Eligible_Payment_Plans_Accuracy", SqlDbType.VarChar).Value = ddlScore_Eligible_Payment_Plans_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Deferment_Forb_Accuracy", SqlDbType.VarChar).Value = ddlScore_Deferment_Forb_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_New_Payment_Schedule_Accuracy", SqlDbType.VarChar).Value = ddlScore_New_Payment_Schedule_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Reversed_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Reversed_Payments_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days_Accuracy", SqlDbType.VarChar).Value = ddlScore_Loans_Transferred_After_60_Days_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Electronic_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Electronic_Payments_Accuracy.SelectedValue

        cmd.Parameters.Add("@Score_Delay_Tax_Reform_Accuracy", SqlDbType.VarChar).Value = ddlScore_Delay_Tax_Reform_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_More_Aid_Accuracy", SqlDbType.VarChar).Value = ddlScore_More_Aid_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Collection_Costs_Waived_Accuracy", SqlDbType.VarChar).Value = ddlScore_Collection_Costs_Waived_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_False_Requirements_Accuracy", SqlDbType.VarChar).Value = ddlScore_False_Requirements_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Avoid_PIF_Accuracy", SqlDbType.VarChar).Value = ddlScore_Avoid_PIF_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Rehab_Then_TPD_Accuracy", SqlDbType.VarChar).Value = ddlScore_Rehab_Then_TPD_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Payments_Are_Final_Accuracy", SqlDbType.VarChar).Value = ddlScore_Payments_Are_Final_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Not_Factual_Accuracy", SqlDbType.VarChar).Value = ddlScore_Not_Factual_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Consol_New_Loan_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_New_Loan_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Credit_Reporting_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Credit_Reporting_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Interest_Rates_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Interest_Rates_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Capitalization_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Capitalization_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Consol_TitleIV_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_TitleIV_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Repayment_Options_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Repayment_Options_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Default_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Default_Accuracy.SelectedValue
        cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirmQCTier1.Text = "Your review was successfully QC'd In Tier1"
        Finally
            con.Close()
        End Try
    End Sub

    Sub UpdateQCTier2_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateReviewIDQCTier2", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = lblReviewID.Text
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name
        cmd.Parameters.Add("@Score_CorrectID_Accuracy", SqlDbType.VarChar).Value = ddlScore_CorrectID_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_ProperlyIdentified_Accuracy", SqlDbType.VarChar).Value = ddlScore_ProperlyIdentified_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_MiniMiranda_Accuracy", SqlDbType.VarChar).Value = ddlScore_MiniMiranda_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Tone_Accuracy", SqlDbType.VarChar).Value = ddlScore_Tone_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Accuracy_Accuracy", SqlDbType.VarChar).Value = ddlScore_Accuracy_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Notepad_Accuracy", SqlDbType.VarChar).Value = ddlScore_Notepad_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_PCAResponsive_Accuracy", SqlDbType.VarChar).Value = ddlScore_PCAResponsive_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_AWGInfo_Accuracy", SqlDbType.VarChar).Value = ddlScore_AWGInfo_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Complaint_Accuracy", SqlDbType.VarChar).Value = ddlComplaint_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_ExceededHoldTime_Accuracy", SqlDbType.VarChar).Value = ddlScore_ExceededHoldTime_Accuracy2.SelectedValue

        cmd.Parameters.Add("@Score_Rehab_Once_Accuracy", SqlDbType.VarChar).Value = ddlScore_Rehab_Once_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Nine_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Nine_Payments_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_TitleIV_Accuracy", SqlDbType.VarChar).Value = ddlScore_TitleIV_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Credit_Reporting_Accuracy", SqlDbType.VarChar).Value = ddlScore_Credit_Reporting_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_TOP_Accuracy", SqlDbType.VarChar).Value = ddlScore_TOP_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_AWG_Accuracy", SqlDbType.VarChar).Value = ddlScore_AWG_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Continue_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Continue_Payments_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Collection_Charges_Waived_Accuracy", SqlDbType.VarChar).Value = ddlScore_Collection_Charges_Waived_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Financial_Documents_Accuracy", SqlDbType.VarChar).Value = ddlScore_Financial_Documents_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Rehab_Agreement_Letter_Accuracy", SqlDbType.VarChar).Value = ddlScore_Rehab_Agreement_Letter_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Contact_Us_Accuracy", SqlDbType.VarChar).Value = ddlScore_Contact_Us_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Eligible_Payment_Plans_Accuracy", SqlDbType.VarChar).Value = ddlScore_Eligible_Payment_Plans_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Deferment_Forb_Accuracy", SqlDbType.VarChar).Value = ddlScore_Deferment_Forb_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_New_Payment_Schedule_Accuracy", SqlDbType.VarChar).Value = ddlScore_New_Payment_Schedule_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Reversed_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Reversed_Payments_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days_Accuracy", SqlDbType.VarChar).Value = ddlScore_Loans_Transferred_After_60_Days_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Electronic_Payments_Accuracy", SqlDbType.VarChar).Value = ddlScore_Electronic_Payments_Accuracy2.SelectedValue

        cmd.Parameters.Add("@Score_Delay_Tax_Reform_Accuracy", SqlDbType.VarChar).Value = ddlScore_Delay_Tax_Reform_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_More_Aid_Accuracy", SqlDbType.VarChar).Value = ddlScore_More_Aid_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Collection_Costs_Waived_Accuracy", SqlDbType.VarChar).Value = ddlScore_Collection_Costs_Waived_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_False_Requirements_Accuracy", SqlDbType.VarChar).Value = ddlScore_False_Requirements_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Avoid_PIF_Accuracy", SqlDbType.VarChar).Value = ddlScore_Avoid_PIF_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Rehab_Then_TPD_Accuracy", SqlDbType.VarChar).Value = ddlScore_Rehab_Then_TPD_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Payments_Are_Final_Accuracy", SqlDbType.VarChar).Value = ddlScore_Payments_Are_Final_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Not_Factual_Accuracy", SqlDbType.VarChar).Value = ddlScore_Not_Factual_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Consol_New_Loan_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_New_Loan_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Credit_Reporting_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Credit_Reporting_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Interest_Rates_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Interest_Rates_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Capitalization_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Capitalization_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Consol_TitleIV_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_TitleIV_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Repayment_Options_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Repayment_Options_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Score_Consol_Default_Accuracy", SqlDbType.VarChar).Value = ddlScore_Consol_Default_Accuracy2.SelectedValue
        cmd.Parameters.Add("@Returned_Worksheet_Entire", SqlDbType.VarChar).Value = ddlReturned_Worksheet_Entire.SelectedValue
        cmd.Parameters.Add("@Returned_Worksheet_Once", SqlDbType.VarChar).Value = ddlReturned_Worksheet_Once.SelectedValue
        cmd.Parameters.Add("@Returned_Worksheet_Twice", SqlDbType.VarChar).Value = ddlReturned_Worksheet_Twice.SelectedValue
        cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments2.Text

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirmQCTier2.Text = "Your review was successfully QC'd In Tier2"
        Finally
            con.Close()
        End Try
    End Sub

    Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteReviewID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = lblReviewID.Text

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your review was successfully deleted"
        Finally
            con.Close()
        End Try
    End Sub
    

End Class
