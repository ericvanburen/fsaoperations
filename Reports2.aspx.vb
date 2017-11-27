Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class PCAReviews_Report_Summary
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            dsPreviousReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue

            'Only admins can see the delete saved report button
            If Roles.IsUserInRole("PCAReviews_Admins") = True Then
                btnDeleteSavedReport.Visible = True
            Else
                btnDeleteSavedReport.Visible = False
            End If

        End If
    End Sub

    Sub btnSearch_Click(sender As Object, e As EventArgs)

        'First we need to clear the form of any previous search results
        'lblTotal_AnyErrors.Text = "0"
        'lblTotal_AnyErrors_Percent.Text = "0%"
        lblScore_CorrectID_Total.Text = "0"
        lblScore_CorrectID_Incorrect.Text = "0"
        lblScore_CorrectID_Percent.Text = "0"

        lblScore_ProperlyIdentified_Total.Text = "0"
        lblScore_ProperlyIdentified_Incorrect.Text = "0"
        lblScore_ProperlyIdentified_Percent.Text = "0"

        lblScore_MiniMiranda_Total.Text = "0"
        lblScore_MiniMiranda_Incorrect.Text = "0"
        lblScore_MiniMiranda_Percent.Text = "0"

        lblScore_CallRecording_Total.Text = "0"
        lblScore_CallRecording_Incorrect.Text = "0"
        lblScore_CallRecording_Percent.Text = "0"

        lblScore_Tone_Total.Text = "0"
        lblScore_Tone_Incorrect.Text = "0"
        lblScore_Tone_Percent.Text = "0"

        lblScore_Accuracy_Total.Text = "0"
        lblScore_Accuracy_Incorrect.Text = "0"
        lblScore_Accuracy_Percent.Text = "0"

        lblScore_Notepad_Total.Text = "0"
        lblScore_Notepad_Incorrect.Text = "0"
        lblScore_Notepad_Percent.Text = "0"

        lblScore_PCAResponsive_Total.Text = "0"
        lblScore_PCAResponsive_Incorrect.Text = "0"
        lblScore_PCAResponsive_Percent.Text = "0"

        lblScore_AWGInfo_Total.Text = "0"
        lblScore_AWGInfo_Incorrect.Text = "0"
        lblScore_AWGInfo_Percent.Text = "0"

        lblScore_Complaint_Total.Text = "0"
        lblScore_Complaint_Incorrect.Text = "0"
        lblScore_Complaint_Percent.Text = "0"

        lblScore_ExceededHoldTime_Total.Text = "0"
        lblScore_ExceededHoldTime_Incorrect.Text = "0"
        lblScore_ExceededHoldTime_Percent.Text = "0"

        lblScore_Disconnect_Borrower_Incorrect.Text = "0"
        lblScore_Disconnect_Borrower_Percent.Text = "N/A"

        'Rehab - Must Say      

        lblScore_Rehab_Once_Total.Text = "0"
        lblScore_Rehab_Once_Incorrect.Text = "0"
        lblScore_Rehab_Once_Percent.Text = "0"

        lblScore_Nine_Payments_Total.Text = "0"
        lblScore_Nine_Payments_Incorrect.Text = "0"
        lblScore_Nine_Payments_Percent.Text = "0"

        lblScore_TitleIV_Total.Text = "0"
        lblScore_TitleIV_Incorrect.Text = "0"
        lblScore_TitleIV_Percent.Text = "0"

        lblScore_Credit_Reporting_Total.Text = "0"
        lblScore_Credit_Reporting_Incorrect.Text = "0"
        lblScore_Credit_Reporting_Percent.Text = "0"

        lblScore_TOP_Total.Text = "0"
        lblScore_TOP_Incorrect.Text = "0"
        lblScore_TOP_Percent.Text = "0"

        lblScore_AWG_Total.Text = "0"
        lblScore_AWG_Incorrect.Text = "0"
        lblScore_AWG_Percent.Text = "0"

        lblScore_Continue_Payments_Total.Text = "0"
        lblScore_Continue_Payments_Incorrect.Text = "0"
        lblScore_Continue_Payments_Percent.Text = "0"

        lblScore_Collection_Charges_Waived_Total.Text = "0"
        lblScore_Collection_Charges_Waived_Incorrect.Text = "0"
        lblScore_Collection_Charges_Waived_Percent.Text = "0"

        lblScore_Financial_Documents_Total.Text = "0"
        lblScore_Financial_Documents_Incorrect.Text = "0"
        lblScore_Financial_Documents_Percent.Text = "0"

        lblScore_Rehab_Agreement_Letter_Total.Text = "0"
        lblScore_Rehab_Agreement_Letter_Incorrect.Text = "0"
        lblScore_Rehab_Agreement_Letter_Percent.Text = "0"

        lblScore_Contact_Us_Total.Text = "0"
        lblScore_Contact_Us_Incorrect.Text = "0"
        lblScore_Contact_Us_Percent.Text = "0"

        'Rehab May Say
        lblScore_Eligible_Payment_Plans_Total.Text = "0"
        lblScore_Eligible_Payment_Plans_Incorrect.Text = "0"
        lblScore_Eligible_Payment_Plans_Percent.Text = "0"

        lblScore_Deferment_Forb_Total.Text = "0"
        lblScore_Deferment_Forb_Incorrect.Text = "0"
        lblScore_Deferment_Forb_Percent.Text = "0"

        lblScore_New_Payment_Schedule_Total.Text = "0"
        lblScore_New_Payment_Schedule_Incorrect.Text = "0"
        lblScore_New_Payment_Schedule_Percent.Text = "0"

        lblScore_Reversed_Payments_Total.Text = "0"
        lblScore_Reversed_Payments_Incorrect.Text = "0"
        lblScore_Reversed_Payments_Percent.Text = "0"

        lblScore_Loans_Transferred_After_60_Days_Total.Text = "0"
        lblScore_Loans_Transferred_After_60_Days_Incorrect.Text = "0"
        lblScore_Loans_Transferred_After_60_Days_Percent.Text = "0"

        lblScore_Electronic_Payments_Total.Text = "0"
        lblScore_Electronic_Payments_Incorrect.Text = "0"
        lblScore_Electronic_Payments_Percent.Text = "0"

        lblScore_Consol_New_Loan_Total.Text = "0"
        lblScore_Consol_New_Loan_Incorrect.Text = "0"
        lblScore_Consol_New_Loan_Percent.Text = "0"

        lblScore_Consol_Credit_Reporting_Total.Text = "0"
        lblScore_Consol_Credit_Reporting_Incorrect.Text = "0"
        lblScore_Consol_Credit_Reporting_Percent.Text = "0"

        lblScore_Consol_Interest_Rates_Total.Text = "0"
        lblScore_Consol_Interest_Rates_Incorrect.Text = "0"
        lblScore_Consol_Interest_Rates_Percent.Text = "0"

        lblScore_Consol_Capitalization_Total.Text = "0"
        lblScore_Consol_Capitalization_Incorrect.Text = "0"
        lblScore_Consol_Capitalization_Percent.Text = "0"

        lblScore_Consol_TitleIV_Total.Text = "0"
        lblScore_Consol_TitleIV_Incorrect.Text = "0"
        lblScore_Consol_TitleIV_Percent.Text = "0"

        lblScore_Consol_Repayment_Options_Total.Text = "0"
        lblScore_Consol_Repayment_Options_Incorrect.Text = "0"
        lblScore_Consol_Repayment_Options_Percent.Text = "0"

        lblScore_Consol_Default_Total.Text = "0"
        lblScore_Consol_Default_Incorrect.Text = "0"
        lblScore_Consol_Default_Percent.Text = "0"

        lblPopulationSize.Text = ""

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReportSummaryForPCA", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@ReviewPeriodMonth", SqlDbType.VarChar).Value = ddlReviewPeriodMonth.SelectedValue
        cmd.Parameters.Add("@ReviewPeriodYear", SqlDbType.VarChar).Value = ddlReviewPeriodYear.SelectedValue

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    'Number of Reviews
                    If Not dr("PopulationSize") Is DBNull.Value Then
                        lblPopulationSize.Text = dr("PopulationSize").ToString()
                    End If

                    'Correct ID
                    If Not dr("Score_CorrectID_Total") Is DBNull.Value Then
                        lblScore_CorrectID_Total.Text = dr("Score_CorrectID_Total").ToString()
                    End If
                    If Not dr("Score_CorrectID_Incorrect") Is DBNull.Value Then
                        lblScore_CorrectID_Incorrect.Text = dr("Score_CorrectID_Incorrect").ToString()
                    End If
                    If Not dr("Score_CorrectID_Percent") Is DBNull.Value Then
                        lblScore_CorrectID_Percent.Text = dr("Score_CorrectID_Percent").ToString() & "%"
                    End If

                    'Properly Identified
                    If Not dr("Score_ProperlyIdentified_Total") Is DBNull.Value Then
                        lblScore_ProperlyIdentified_Total.Text = dr("Score_ProperlyIdentified_Total").ToString()
                    End If
                    If Not dr("Score_ProperlyIdentified_Incorrect") Is DBNull.Value Then
                        lblScore_ProperlyIdentified_Incorrect.Text = dr("Score_ProperlyIdentified_Incorrect").ToString()
                    End If
                    If Not dr("Score_ProperlyIdentified_Percent") Is DBNull.Value Then
                        lblScore_ProperlyIdentified_Percent.Text = dr("Score_ProperlyIdentified_Percent").ToString() & "%"
                    End If

                    'MiniMiranda
                    If Not dr("Score_MiniMiranda_Total") Is DBNull.Value Then
                        lblScore_MiniMiranda_Total.Text = dr("Score_MiniMiranda_Total").ToString()
                    End If
                    If Not dr("Score_MiniMiranda_Incorrect") Is DBNull.Value Then
                        lblScore_MiniMiranda_Incorrect.Text = dr("Score_MiniMiranda_Incorrect").ToString()
                    End If
                    If Not dr("Score_MiniMiranda_Percent") Is DBNull.Value Then
                        lblScore_MiniMiranda_Percent.Text = dr("Score_MiniMiranda_Percent").ToString() & "%"
                    End If

                    'CallRecording
                    If Not dr("Score_CallRecording_Total") Is DBNull.Value Then
                        lblScore_CallRecording_Total.Text = dr("Score_CallRecording_Total").ToString()
                    End If
                    If Not dr("Score_CallRecording_Incorrect") Is DBNull.Value Then
                        lblScore_CallRecording_Incorrect.Text = dr("Score_CallRecording_Incorrect").ToString()
                    End If
                    If Not dr("Score_CallRecording_Percent") Is DBNull.Value Then
                        lblScore_CallRecording_Percent.Text = dr("Score_CallRecording_Percent").ToString() & "%"
                    End If

                    'Score_Tone
                    If Not dr("Score_Tone_Total") Is DBNull.Value Then
                        lblScore_Tone_Total.Text = dr("Score_Tone_Total").ToString()
                    End If
                    If Not dr("Score_Tone_Incorrect") Is DBNull.Value Then
                        lblScore_Tone_Incorrect.Text = dr("Score_Tone_Incorrect").ToString()
                    End If
                    If Not dr("Score_Tone_Percent") Is DBNull.Value Then
                        lblScore_Tone_Percent.Text = dr("Score_Tone_Percent").ToString() & "%"
                    End If

                    'Score_Accuracy
                    If Not dr("Score_Accuracy_Total") Is DBNull.Value Then
                        lblScore_Accuracy_Total.Text = dr("Score_Accuracy_Total").ToString()
                    End If
                    If Not dr("Score_Accuracy_Incorrect") Is DBNull.Value Then
                        lblScore_Accuracy_Incorrect.Text = dr("Score_Accuracy_Incorrect").ToString()
                    End If
                    If Not dr("Score_Accuracy_Percent") Is DBNull.Value Then
                        lblScore_Accuracy_Percent.Text = dr("Score_Accuracy_Percent").ToString() & "%"
                    End If

                    'Score_Notepad
                    If Not dr("Score_Notepad_Total") Is DBNull.Value Then
                        lblScore_Notepad_Total.Text = dr("Score_Notepad_Total").ToString()
                    End If
                    If Not dr("Score_Notepad_Incorrect") Is DBNull.Value Then
                        lblScore_Notepad_Incorrect.Text = dr("Score_Notepad_Incorrect").ToString()
                    End If
                    If Not dr("Score_Notepad_Percent") Is DBNull.Value Then
                        lblScore_Notepad_Percent.Text = dr("Score_Notepad_Percent").ToString() & "%"
                    End If

                    'Score_PCAResponsive
                    If Not dr("Score_PCAResponsive_Total") Is DBNull.Value Then
                        lblScore_PCAResponsive_Total.Text = dr("Score_PCAResponsive_Total").ToString()
                    End If
                    If Not dr("Score_PCAResponsive_Incorrect") Is DBNull.Value Then
                        lblScore_PCAResponsive_Incorrect.Text = dr("Score_PCAResponsive_Incorrect").ToString()
                    End If
                    If Not dr("Score_PCAResponsive_Percent") Is DBNull.Value Then
                        lblScore_PCAResponsive_Percent.Text = dr("Score_PCAResponsive_Percent").ToString() & "%"
                    End If

                    'Score_AWGInfo
                    If Not dr("Score_AWGInfo_Total") Is DBNull.Value Then
                        lblScore_AWGInfo_Total.Text = dr("Score_AWGInfo_Total").ToString()
                    End If
                    If Not dr("Score_AWGInfo_Incorrect") Is DBNull.Value Then
                        lblScore_AWGInfo_Incorrect.Text = dr("Score_AWGInfo_Incorrect").ToString()
                    End If
                    If Not dr("Score_AWGInfo_Percent") Is DBNull.Value Then
                        lblScore_AWGInfo_Percent.Text = dr("Score_AWGInfo_Percent").ToString() & "%"
                    End If

                    'Score_Complaint
                    If Not dr("Score_Complaint_Total") Is DBNull.Value Then
                        lblScore_Complaint_Total.Text = dr("Score_Complaint_Total").ToString()
                    End If
                    If Not dr("Score_Complaint_Incorrect") Is DBNull.Value Then
                        lblScore_Complaint_Incorrect.Text = dr("Score_Complaint_Incorrect").ToString()
                    End If
                    If Not dr("Score_Complaint_Percent") Is DBNull.Value Then
                        lblScore_Complaint_Percent.Text = dr("Score_Complaint_Percent").ToString() & "%"
                    End If

                    'Score_ExceededHoldTime
                    If Not dr("Score_ExceededHoldTime_Total") Is DBNull.Value Then
                        lblScore_ExceededHoldTime_Total.Text = dr("Score_ExceededHoldTime_Total").ToString()
                    End If
                    If Not dr("Score_ExceededHoldTime_Incorrect") Is DBNull.Value Then
                        lblScore_ExceededHoldTime_Incorrect.Text = dr("Score_ExceededHoldTime_Incorrect").ToString()
                    End If
                    If Not dr("Score_ExceededHoldTime_Percent") Is DBNull.Value Then
                        lblScore_ExceededHoldTime_Percent.Text = dr("Score_ExceededHoldTime_Percent").ToString() & "%"
                    End If

                    'Score_Disconnect_Borrower
                    'We aren't counting correct actions for PCA Disconnected Borrower
                    'If Not dr("Score_Disconnect_Borrower_Total") Is DBNull.Value Then
                    'lblScore_Disconnect_Borrower_Total.Text = dr("Score_Disconnect_Borrower_Total").ToString()
                    'End If
                    If Not dr("Score_Disconnect_Borrower_Incorrect") Is DBNull.Value Then
                        lblScore_Disconnect_Borrower_Incorrect.Text = dr("Score_Disconnect_Borrower_Incorrect").ToString()
                    End If
                    'If Not dr("Score_Disconnect_Borrower_Percent") Is DBNull.Value Then
                    'lblScore_Disconnect_Borrower_Percent.Text = dr("Score_Disconnect_Borrower_Percent").ToString() & "%"
                    'End If                    

                    'Score_Rehab_Once
                    If Not dr("Score_Rehab_Once_Total") Is DBNull.Value Then
                        lblScore_Rehab_Once_Total.Text = dr("Score_Rehab_Once_Total").ToString()
                    End If
                    If Not dr("Score_Rehab_Once_Incorrect") Is DBNull.Value Then
                        lblScore_Rehab_Once_Incorrect.Text = dr("Score_Rehab_Once_Incorrect").ToString()
                    End If
                    If Not dr("Score_Rehab_Once_Percent") Is DBNull.Value Then
                        lblScore_Rehab_Once_Percent.Text = dr("Score_Rehab_Once_Percent").ToString() & "%"
                    End If

                    'Score_Nine_Payments
                    If Not dr("Score_Nine_Payments_Total") Is DBNull.Value Then
                        lblScore_Nine_Payments_Total.Text = dr("Score_Nine_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Nine_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Nine_Payments_Incorrect.Text = dr("Score_Nine_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Nine_Payments_Percent") Is DBNull.Value Then
                        lblScore_Nine_Payments_Percent.Text = dr("Score_Nine_Payments_Percent").ToString() & "%"
                    End If

                    'Score_TitleIV
                    If Not dr("Score_TitleIV_Total") Is DBNull.Value Then
                        lblScore_TitleIV_Total.Text = dr("Score_TitleIV_Total").ToString()
                    End If
                    If Not dr("Score_TitleIV_Incorrect") Is DBNull.Value Then
                        lblScore_TitleIV_Incorrect.Text = dr("Score_TitleIV_Incorrect").ToString()
                    End If
                    If Not dr("Score_TitleIV_Percent") Is DBNull.Value Then
                        lblScore_TitleIV_Percent.Text = dr("Score_TitleIV_Percent").ToString() & "%"
                    End If

                    'Score_Credit_Reporting
                    If Not dr("Score_Credit_Reporting_Total") Is DBNull.Value Then
                        lblScore_Credit_Reporting_Total.Text = dr("Score_Credit_Reporting_Total").ToString()
                    End If
                    If Not dr("Score_Credit_Reporting_Incorrect") Is DBNull.Value Then
                        lblScore_Credit_Reporting_Incorrect.Text = dr("Score_Credit_Reporting_Incorrect").ToString()
                    End If
                    If Not dr("Score_Credit_Reporting_Percent") Is DBNull.Value Then
                        lblScore_Credit_Reporting_Percent.Text = dr("Score_Credit_Reporting_Percent").ToString() & "%"
                    End If

                    'Score_TOP
                    If Not dr("Score_TOP_Total") Is DBNull.Value Then
                        lblScore_TOP_Total.Text = dr("Score_TOP_Total").ToString()
                    End If
                    If Not dr("Score_TOP_Incorrect") Is DBNull.Value Then
                        lblScore_TOP_Incorrect.Text = dr("Score_TOP_Incorrect").ToString()
                    End If
                    If Not dr("Score_TOP_Percent") Is DBNull.Value Then
                        lblScore_TOP_Percent.Text = dr("Score_TOP_Percent").ToString() & "%"
                    End If

                    'Score_AWG
                    If Not dr("Score_AWG_Total") Is DBNull.Value Then
                        lblScore_AWG_Total.Text = dr("Score_AWG_Total").ToString()
                    End If
                    If Not dr("Score_AWG_Incorrect") Is DBNull.Value Then
                        lblScore_AWG_Incorrect.Text = dr("Score_AWG_Incorrect").ToString()
                    End If
                    If Not dr("Score_AWG_Percent") Is DBNull.Value Then
                        lblScore_AWG_Percent.Text = dr("Score_AWG_Percent").ToString() & "%"
                    End If

                    'Score_Continue_Payments
                    If Not dr("Score_Continue_Payments_Total") Is DBNull.Value Then
                        lblScore_Continue_Payments_Total.Text = dr("Score_Continue_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Continue_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Continue_Payments_Incorrect.Text = dr("Score_Continue_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Continue_Payments_Percent") Is DBNull.Value Then
                        lblScore_Continue_Payments_Percent.Text = dr("Score_Continue_Payments_Percent").ToString() & "%"
                    End If

                    'Score_Collection_Charges_Waived
                    If Not dr("Score_Collection_Charges_Waived_Total") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived_Total.Text = dr("Score_Collection_Charges_Waived_Total").ToString()
                    End If
                    If Not dr("Score_Collection_Charges_Waived_Incorrect") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived_Incorrect.Text = dr("Score_Collection_Charges_Waived_Incorrect").ToString()
                    End If
                    If Not dr("Score_Collection_Charges_Waived_Percent") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived_Percent.Text = dr("Score_Collection_Charges_Waived_Percent").ToString() & "%"
                    End If

                    'Score_Financial_Documents
                    If Not dr("Score_Financial_Documents_Total") Is DBNull.Value Then
                        lblScore_Financial_Documents_Total.Text = dr("Score_Financial_Documents_Total").ToString()
                    End If
                    If Not dr("Score_Financial_Documents_Incorrect") Is DBNull.Value Then
                        lblScore_Financial_Documents_Incorrect.Text = dr("Score_Financial_Documents_Incorrect").ToString()
                    End If
                    If Not dr("Score_Financial_Documents_Percent") Is DBNull.Value Then
                        lblScore_Financial_Documents_Percent.Text = dr("Score_Financial_Documents_Percent").ToString() & "%"
                    End If

                    'Score_Rehab_Agreement_Letter
                    If Not dr("Score_Rehab_Agreement_Letter_Total") Is DBNull.Value Then
                        lblScore_Rehab_Agreement_Letter_Total.Text = dr("Score_Rehab_Agreement_Letter_Total").ToString()
                    End If
                    If Not dr("Score_Rehab_Agreement_Letter_Incorrect") Is DBNull.Value Then
                        lblScore_Rehab_Agreement_Letter_Incorrect.Text = dr("Score_Rehab_Agreement_Letter_Incorrect").ToString()
                    End If
                    If Not dr("Score_Rehab_Agreement_Letter_Percent") Is DBNull.Value Then
                        lblScore_Rehab_Agreement_Letter_Percent.Text = dr("Score_Rehab_Agreement_Letter_Percent").ToString() & "%"
                    End If

                    'Score_Contact_Us
                    If Not dr("Score_Contact_Us_Total") Is DBNull.Value Then
                        lblScore_Contact_Us_Total.Text = dr("Score_Contact_Us_Total").ToString()
                    End If
                    If Not dr("Score_Contact_Us_Incorrect") Is DBNull.Value Then
                        lblScore_Contact_Us_Incorrect.Text = dr("Score_Contact_Us_Incorrect").ToString()
                    End If
                    If Not dr("Score_Contact_Us_Percent") Is DBNull.Value Then
                        lblScore_Contact_Us_Percent.Text = dr("Score_Contact_Us_Percent").ToString() & "%"
                    End If

                    'Score_Eligible_Payment_Plans
                    If Not dr("Score_Eligible_Payment_Plans_Total") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans_Total.Text = dr("Score_Eligible_Payment_Plans_Total").ToString()
                    End If
                    If Not dr("Score_Eligible_Payment_Plans_Incorrect") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans_Incorrect.Text = dr("Score_Eligible_Payment_Plans_Incorrect").ToString()
                    End If
                    If Not dr("Score_Eligible_Payment_Plans_Percent") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans_Percent.Text = dr("Score_Eligible_Payment_Plans_Percent").ToString() & "%"
                    End If

                    'Score_Deferment_Forb
                    If Not dr("Score_Deferment_Forb_Total") Is DBNull.Value Then
                        lblScore_Deferment_Forb_Total.Text = dr("Score_Deferment_Forb_Total").ToString()
                    End If
                    If Not dr("Score_Deferment_Forb_Incorrect") Is DBNull.Value Then
                        lblScore_Deferment_Forb_Incorrect.Text = dr("Score_Deferment_Forb_Incorrect").ToString()
                    End If
                    If Not dr("Score_Deferment_Forb_Percent") Is DBNull.Value Then
                        lblScore_Deferment_Forb_Percent.Text = dr("Score_Deferment_Forb_Percent").ToString() & "%"
                    End If

                    'Score_New_Payment_Schedule
                    If Not dr("Score_New_Payment_Schedule_Total") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule_Total.Text = dr("Score_New_Payment_Schedule_Total").ToString()
                    End If
                    If Not dr("Score_New_Payment_Schedule_Incorrect") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule_Incorrect.Text = dr("Score_New_Payment_Schedule_Incorrect").ToString()
                    End If
                    If Not dr("Score_New_Payment_Schedule_Percent") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule_Percent.Text = dr("Score_New_Payment_Schedule_Percent").ToString() & "%"
                    End If

                    'Score_Reversed_Payments
                    If Not dr("Score_Reversed_Payments_Total") Is DBNull.Value Then
                        lblScore_Reversed_Payments_Total.Text = dr("Score_Reversed_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Reversed_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Reversed_Payments_Incorrect.Text = dr("Score_Reversed_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Reversed_Payments_Percent") Is DBNull.Value Then
                        lblScore_Reversed_Payments_Percent.Text = dr("Score_Reversed_Payments_Percent").ToString() & "%"
                    End If

                    'Score_Loans_Transferred_After_60_Days
                    If Not dr("Score_Loans_Transferred_After_60_Days_Total") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days_Total.Text = dr("Score_Loans_Transferred_After_60_Days_Total").ToString()
                    End If
                    If Not dr("Score_Loans_Transferred_After_60_Days_Incorrect") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days_Incorrect.Text = dr("Score_Loans_Transferred_After_60_Days_Incorrect").ToString()
                    End If
                    If Not dr("Score_Loans_Transferred_After_60_Days_Percent") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days_Percent.Text = dr("Score_Loans_Transferred_After_60_Days_Percent").ToString() & "%"
                    End If

                    'Score_Electronic_Payments
                    If Not dr("Score_Electronic_Payments_Total") Is DBNull.Value Then
                        lblScore_Electronic_Payments_Total.Text = dr("Score_Electronic_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Electronic_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Electronic_Payments_Incorrect.Text = dr("Score_Electronic_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Electronic_Payments_Percent") Is DBNull.Value Then
                        lblScore_Electronic_Payments_Percent.Text = dr("Score_Electronic_Payments_Percent").ToString() & "%"
                    End If

                    'Score_Consol_New_Loan
                    If Not dr("Score_Consol_New_Loan_Total") Is DBNull.Value Then
                        lblScore_Consol_New_Loan_Total.Text = dr("Score_Consol_New_Loan_Total").ToString()
                    End If
                    If Not dr("Score_Consol_New_Loan_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_New_Loan_Incorrect.Text = dr("Score_Consol_New_Loan_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_New_Loan_Percent") Is DBNull.Value Then
                        lblScore_Consol_New_Loan_Percent.Text = dr("Score_Consol_New_Loan_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Credit_Reporting
                    If Not dr("Score_Consol_Credit_Reporting_Total") Is DBNull.Value Then
                        lblScore_Consol_Credit_Reporting_Total.Text = dr("Score_Consol_Credit_Reporting_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Credit_Reporting_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Credit_Reporting_Incorrect.Text = dr("Score_Consol_Credit_Reporting_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Credit_Reporting_Percent") Is DBNull.Value Then
                        lblScore_Consol_Credit_Reporting_Percent.Text = dr("Score_Consol_Credit_Reporting_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Interest_Rates
                    If Not dr("Score_Consol_Interest_Rates_Total") Is DBNull.Value Then
                        lblScore_Consol_Interest_Rates_Total.Text = dr("Score_Consol_Interest_Rates_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Interest_Rates_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Interest_Rates_Incorrect.Text = dr("Score_Consol_Interest_Rates_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Interest_Rates_Percent") Is DBNull.Value Then
                        lblScore_Consol_Interest_Rates_Percent.Text = dr("Score_Consol_Interest_Rates_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Capitalization
                    If Not dr("Score_Consol_Capitalization_Total") Is DBNull.Value Then
                        lblScore_Consol_Capitalization_Total.Text = dr("Score_Consol_Capitalization_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Capitalization_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Capitalization_Incorrect.Text = dr("Score_Consol_Capitalization_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Capitalization_Percent") Is DBNull.Value Then
                        lblScore_Consol_Capitalization_Percent.Text = dr("Score_Consol_Capitalization_Percent").ToString() & "%"
                    End If

                    'Score_Consol_TitleIV
                    If Not dr("Score_Consol_TitleIV_Total") Is DBNull.Value Then
                        lblScore_Consol_TitleIV_Total.Text = dr("Score_Consol_TitleIV_Total").ToString()
                    End If
                    If Not dr("Score_Consol_TitleIV_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_TitleIV_Incorrect.Text = dr("Score_Consol_TitleIV_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_TitleIV_Percent") Is DBNull.Value Then
                        lblScore_Consol_TitleIV_Percent.Text = dr("Score_Consol_TitleIV_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Repayment_Options
                    If Not dr("Score_Consol_Repayment_Options_Total") Is DBNull.Value Then
                        lblScore_Consol_Repayment_Options_Total.Text = dr("Score_Consol_Repayment_Options_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Repayment_Options_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Repayment_Options_Incorrect.Text = dr("Score_Consol_Repayment_Options_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Repayment_Options_Percent") Is DBNull.Value Then
                        lblScore_Consol_Repayment_Options_Percent.Text = dr("Score_Consol_Repayment_Options_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Default
                    If Not dr("Score_Consol_Default_Total") Is DBNull.Value Then
                        lblScore_Consol_Default_Total.Text = dr("Score_Consol_Default_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Default_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Default_Incorrect.Text = dr("Score_Consol_Default_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Default_Percent") Is DBNull.Value Then
                        lblScore_Consol_Default_Percent.Text = dr("Score_Consol_Default_Percent").ToString() & "%"
                    End If


                End While
            End Using

            Page.DataBind()
            'btnSaveReview.Visible = True
            btnExportExcel.Visible = True
            btnFinalReport.Visible = True
            lblUpdateConfirm.Text = ""

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnSaveReview_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertSavedReview2", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@DateEntered", SqlDbType.SmallDateTime).Value = Date.Now()
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name
        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@ReviewPeriod", SqlDbType.VarChar).Value = ddlReviewPeriodMonth.SelectedValue & "/" & ddlReviewPeriodYear.SelectedValue

        cmd.Parameters.Add("@Score_CorrectID_Total", SqlDbType.VarChar).Value = lblScore_CorrectID_Total.Text
        cmd.Parameters.Add("@Score_CorrectID_Incorrect", SqlDbType.VarChar).Value = lblScore_CorrectID_Incorrect.Text
        cmd.Parameters.Add("@Score_CorrectID_Percent", SqlDbType.VarChar).Value = lblScore_CorrectID_Percent.Text

        cmd.Parameters.Add("@Score_ProperlyIdentified_Total", SqlDbType.VarChar).Value = lblScore_ProperlyIdentified_Total.Text
        cmd.Parameters.Add("@Score_ProperlyIdentified_Incorrect", SqlDbType.VarChar).Value = lblScore_ProperlyIdentified_Incorrect.Text
        cmd.Parameters.Add("@Score_ProperlyIdentified_Percent", SqlDbType.VarChar).Value = lblScore_ProperlyIdentified_Percent.Text

        cmd.Parameters.Add("@Score_MiniMiranda_Total", SqlDbType.VarChar).Value = lblScore_MiniMiranda_Total.Text
        cmd.Parameters.Add("@Score_MiniMiranda_Incorrect", SqlDbType.VarChar).Value = lblScore_MiniMiranda_Incorrect.Text
        cmd.Parameters.Add("@Score_MiniMiranda_Percent", SqlDbType.VarChar).Value = lblScore_MiniMiranda_Percent.Text

        cmd.Parameters.Add("@Score_Tone_Total", SqlDbType.VarChar).Value = lblScore_Tone_Total.Text
        cmd.Parameters.Add("@Score_Tone_Incorrect", SqlDbType.VarChar).Value = lblScore_Tone_Incorrect.Text
        cmd.Parameters.Add("@Score_Tone_Percent", SqlDbType.VarChar).Value = lblScore_Tone_Percent.Text

        cmd.Parameters.Add("@Score_Accuracy_Total", SqlDbType.VarChar).Value = lblScore_Accuracy_Total.Text
        cmd.Parameters.Add("@Score_Accuracy_Incorrect", SqlDbType.VarChar).Value = lblScore_Accuracy_Incorrect.Text
        cmd.Parameters.Add("@Score_Accuracy_Percent", SqlDbType.VarChar).Value = lblScore_Accuracy_Percent.Text

        cmd.Parameters.Add("@Score_Notepad_Total", SqlDbType.VarChar).Value = lblScore_Notepad_Total.Text
        cmd.Parameters.Add("@Score_Notepad_Incorrect", SqlDbType.VarChar).Value = lblScore_Notepad_Incorrect.Text
        cmd.Parameters.Add("@Score_Notepad_Percent", SqlDbType.VarChar).Value = lblScore_Notepad_Percent.Text

        cmd.Parameters.Add("@Score_PCAResponsive_Total", SqlDbType.VarChar).Value = lblScore_PCAResponsive_Total.Text
        cmd.Parameters.Add("@Score_PCAResponsive_Incorrect", SqlDbType.VarChar).Value = lblScore_PCAResponsive_Incorrect.Text
        cmd.Parameters.Add("@Score_PCAResponsive_Percent", SqlDbType.VarChar).Value = lblScore_PCAResponsive_Percent.Text

        cmd.Parameters.Add("@Score_AWGInfo_Total", SqlDbType.VarChar).Value = lblScore_AWGInfo_Total.Text
        cmd.Parameters.Add("@Score_AWGInfo_Incorrect", SqlDbType.VarChar).Value = lblScore_AWGInfo_Incorrect.Text
        cmd.Parameters.Add("@Score_AWGInfo_Percent", SqlDbType.VarChar).Value = lblScore_AWGInfo_Percent.Text

        cmd.Parameters.Add("@Score_Complaint_Total", SqlDbType.VarChar).Value = lblScore_Complaint_Total.Text
        cmd.Parameters.Add("@Score_Complaint_Incorrect", SqlDbType.VarChar).Value = lblScore_Complaint_Incorrect.Text
        cmd.Parameters.Add("@Score_Complaint_Percent", SqlDbType.VarChar).Value = lblScore_Complaint_Percent.Text

        cmd.Parameters.Add("@Score_ExceededHoldTime_Total", SqlDbType.VarChar).Value = lblScore_ExceededHoldTime_Total.Text
        cmd.Parameters.Add("@Score_ExceededHoldTime_Incorrect", SqlDbType.VarChar).Value = lblScore_ExceededHoldTime_Incorrect.Text
        cmd.Parameters.Add("@Score_ExceededHoldTime_Percent", SqlDbType.VarChar).Value = lblScore_ExceededHoldTime_Percent.Text

        cmd.Parameters.Add("@Score_Disconnect_Borrower_Incorrect", SqlDbType.VarChar).Value = 0
        'cmd.Parameters.Add("@Score_Disconnect_Borrower_Percent", SqlDbType.VarChar).Value = 0

        cmd.Parameters.Add("@Score_Rehab_Once_Total", SqlDbType.VarChar).Value = lblScore_Rehab_Once_Total.Text
        cmd.Parameters.Add("@Score_Rehab_Once_Incorrect", SqlDbType.VarChar).Value = lblScore_Rehab_Once_Incorrect.Text
        cmd.Parameters.Add("@Score_Rehab_Once_Percent", SqlDbType.VarChar).Value = lblScore_Rehab_Once_Percent.Text

        cmd.Parameters.Add("@Score_Nine_Payments_Total", SqlDbType.VarChar).Value = lblScore_Nine_Payments_Total.Text
        cmd.Parameters.Add("@Score_Nine_Payments_Incorrect", SqlDbType.VarChar).Value = lblScore_Nine_Payments_Incorrect.Text
        cmd.Parameters.Add("@Score_Nine_Payments_Percent", SqlDbType.VarChar).Value = lblScore_Nine_Payments_Percent.Text

        cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days_Total", SqlDbType.VarChar).Value = lblScore_Loans_Transferred_After_60_Days_Total.Text
        cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days_Incorrect", SqlDbType.VarChar).Value = lblScore_Loans_Transferred_After_60_Days_Incorrect.Text
        cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days_Percent", SqlDbType.VarChar).Value = lblScore_Loans_Transferred_After_60_Days_Percent.Text

        cmd.Parameters.Add("@Score_Reversed_Payments_Total", SqlDbType.VarChar).Value = lblScore_Reversed_Payments_Total.Text
        cmd.Parameters.Add("@Score_Reversed_Payments_Incorrect", SqlDbType.VarChar).Value = lblScore_Reversed_Payments_Incorrect.Text
        cmd.Parameters.Add("@Score_Reversed_Payments_Percent", SqlDbType.VarChar).Value = lblScore_Reversed_Payments_Percent.Text

        cmd.Parameters.Add("@Score_TOP_Total", SqlDbType.VarChar).Value = lblScore_TOP_Total.Text
        cmd.Parameters.Add("@Score_TOP_Incorrect", SqlDbType.VarChar).Value = lblScore_TOP_Incorrect.Text
        cmd.Parameters.Add("@Score_TOP_Percent", SqlDbType.VarChar).Value = lblScore_TOP_Percent.Text

        cmd.Parameters.Add("@Score_AWG_Total", SqlDbType.VarChar).Value = lblScore_AWG_Total.Text
        cmd.Parameters.Add("@Score_AWG_Incorrect", SqlDbType.VarChar).Value = lblScore_AWG_Incorrect.Text
        cmd.Parameters.Add("@Score_AWG_Percent", SqlDbType.VarChar).Value = lblScore_AWG_Percent.Text

        cmd.Parameters.Add("@Score_Continue_Payments_Total", SqlDbType.VarChar).Value = lblScore_Continue_Payments_Total.Text
        cmd.Parameters.Add("@Score_Continue_Payments_Incorrect", SqlDbType.VarChar).Value = lblScore_Continue_Payments_Incorrect.Text
        cmd.Parameters.Add("@Score_Continue_Payments_Percent", SqlDbType.VarChar).Value = lblScore_Continue_Payments_Percent.Text

        cmd.Parameters.Add("@Score_New_Payment_Schedule_Total", SqlDbType.VarChar).Value = lblScore_New_Payment_Schedule_Total.Text
        cmd.Parameters.Add("@Score_New_Payment_Schedule_Incorrect", SqlDbType.VarChar).Value = lblScore_New_Payment_Schedule_Incorrect.Text
        cmd.Parameters.Add("@Score_New_Payment_Schedule_Percent", SqlDbType.VarChar).Value = lblScore_New_Payment_Schedule_Percent.Text

        cmd.Parameters.Add("@Score_Eligible_Payment_Plans_Total", SqlDbType.VarChar).Value = lblScore_Eligible_Payment_Plans_Total.Text
        cmd.Parameters.Add("@Score_Eligible_Payment_Plans_Incorrect", SqlDbType.VarChar).Value = lblScore_Eligible_Payment_Plans_Incorrect.Text
        cmd.Parameters.Add("@Score_Eligible_Payment_Plans_Percent", SqlDbType.VarChar).Value = lblScore_Eligible_Payment_Plans_Percent.Text

        cmd.Parameters.Add("@Score_Deferment_Forb_Total", SqlDbType.VarChar).Value = lblScore_Deferment_Forb_Total.Text
        cmd.Parameters.Add("@Score_Deferment_Forb_Incorrect", SqlDbType.VarChar).Value = lblScore_Deferment_Forb_Incorrect.Text
        cmd.Parameters.Add("@Score_Deferment_Forb_Percent", SqlDbType.VarChar).Value = lblScore_Deferment_Forb_Percent.Text

        cmd.Parameters.Add("@Score_TitleIV_Total", SqlDbType.VarChar).Value = lblScore_TitleIV_Total.Text
        cmd.Parameters.Add("@Score_TitleIV_Incorrect", SqlDbType.VarChar).Value = lblScore_TitleIV_Incorrect.Text
        cmd.Parameters.Add("@Score_TitleIV_Percent", SqlDbType.VarChar).Value = lblScore_TitleIV_Percent.Text

        cmd.Parameters.Add("@Score_Collection_Charges_Waived_Total", SqlDbType.VarChar).Value = lblScore_Collection_Charges_Waived_Total.Text
        cmd.Parameters.Add("@Score_Collection_Charges_Waived_Incorrect", SqlDbType.VarChar).Value = lblScore_Collection_Charges_Waived_Incorrect.Text
        cmd.Parameters.Add("@Score_Collection_Charges_Waived_Percent", SqlDbType.VarChar).Value = lblScore_Collection_Charges_Waived_Percent.Text

        'cmd.Parameters.Add("@Score_TOP_Payment_PIFs_Account_Total", SqlDbType.VarChar).Value = lblScore_TOP_Payment_PIFs_Account_Total.Text
        'cmd.Parameters.Add("@Score_TOP_Payment_PIFs_Account_Incorrect", SqlDbType.VarChar).Value = lblScore_TOP_Payment_PIFs_Account_Incorrect.Text
        'cmd.Parameters.Add("@Score_TOP_Payment_PIFs_Account_Percent", SqlDbType.VarChar).Value = lblScore_TOP_Payment_PIFs_Account_Percent.Text

        cmd.Parameters.Add("@Score_Credit_Reporting_Total", SqlDbType.VarChar).Value = lblScore_Credit_Reporting_Total.Text
        cmd.Parameters.Add("@Score_Credit_Reporting_Incorrect", SqlDbType.VarChar).Value = lblScore_Credit_Reporting_Incorrect.Text
        cmd.Parameters.Add("@Score_Credit_Reporting_Percent", SqlDbType.VarChar).Value = lblScore_Credit_Reporting_Percent.Text

        cmd.Parameters.Add("@Score_Electronic_Payments_Total", SqlDbType.VarChar).Value = lblScore_Electronic_Payments_Total.Text
        cmd.Parameters.Add("@Score_Electronic_Payments_Incorrect", SqlDbType.VarChar).Value = lblScore_Electronic_Payments_Incorrect.Text
        cmd.Parameters.Add("@Score_Electronic_Payments_Percent", SqlDbType.VarChar).Value = lblScore_Electronic_Payments_Percent.Text

        cmd.Parameters.Add("@Score_Consol_New_Loan_Total", SqlDbType.VarChar).Value = lblScore_Consol_New_Loan_Total.Text
        cmd.Parameters.Add("@Score_Consol_New_Loan_Incorrect", SqlDbType.VarChar).Value = lblScore_Consol_New_Loan_Incorrect.Text
        cmd.Parameters.Add("@Score_Consol_New_Loan_Percent", SqlDbType.VarChar).Value = lblScore_Consol_New_Loan_Percent.Text

        cmd.Parameters.Add("@Score_Consol_Credit_Reporting_Total", SqlDbType.VarChar).Value = lblScore_Consol_Credit_Reporting_Total.Text
        cmd.Parameters.Add("@Score_Consol_Credit_Reporting_Incorrect", SqlDbType.VarChar).Value = lblScore_Consol_Credit_Reporting_Incorrect.Text
        cmd.Parameters.Add("@Score_Consol_Credit_Reporting_Percent", SqlDbType.VarChar).Value = lblScore_Consol_Credit_Reporting_Percent.Text

        cmd.Parameters.Add("@Score_Consol_Interest_Rates_Total", SqlDbType.VarChar).Value = lblScore_Consol_Interest_Rates_Total.Text
        cmd.Parameters.Add("@Score_Consol_Interest_Rates_Incorrect", SqlDbType.VarChar).Value = lblScore_Consol_Interest_Rates_Incorrect.Text
        cmd.Parameters.Add("@Score_Consol_Interest_Rates_Percent", SqlDbType.VarChar).Value = lblScore_Consol_Interest_Rates_Percent.Text

        cmd.Parameters.Add("@Score_Consol_Capitalization_Total", SqlDbType.VarChar).Value = lblScore_Consol_Capitalization_Total.Text
        cmd.Parameters.Add("@Score_Consol_Capitalization_Incorrect", SqlDbType.VarChar).Value = lblScore_Consol_Capitalization_Incorrect.Text
        cmd.Parameters.Add("@Score_Consol_Capitalization_Percent", SqlDbType.VarChar).Value = lblScore_Consol_Capitalization_Percent.Text

        cmd.Parameters.Add("@Score_Consol_TitleIV_Total", SqlDbType.VarChar).Value = lblScore_Consol_TitleIV_Total.Text
        cmd.Parameters.Add("@Score_Consol_TitleIV_Incorrect", SqlDbType.VarChar).Value = lblScore_Consol_TitleIV_Incorrect.Text
        cmd.Parameters.Add("@Score_Consol_TitleIV_Percent", SqlDbType.VarChar).Value = lblScore_Consol_TitleIV_Percent.Text

        cmd.Parameters.Add("@Score_Consol_Repayment_Options_Total", SqlDbType.VarChar).Value = lblScore_Consol_Repayment_Options_Total.Text
        cmd.Parameters.Add("@Score_Consol_Repayment_Options_Incorrect", SqlDbType.VarChar).Value = lblScore_Consol_Repayment_Options_Incorrect.Text
        cmd.Parameters.Add("@Score_Consol_Repayment_Options_Percent", SqlDbType.VarChar).Value = lblScore_Consol_Repayment_Options_Percent.Text

        cmd.Parameters.Add("@Score_Consol_Default_Total", SqlDbType.VarChar).Value = lblScore_Consol_Default_Total.Text
        cmd.Parameters.Add("@Score_Consol_Default_Incorrect", SqlDbType.VarChar).Value = lblScore_Consol_Default_Incorrect.Text
        cmd.Parameters.Add("@Score_Consol_Default_Percent", SqlDbType.VarChar).Value = lblScore_Consol_Default_Percent.Text

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your report was successfully saved"

            'Refresh the Previous Reviews Gridview
            GridView1.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub ddlPCAID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlPCAID.SelectedIndexChanged
        dsPreviousReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
        dsPreviousReviews.DataBind()
    End Sub

    Sub btnExcelExport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("p_Report_AllAccounts2", MyConnection)
        'Dim cmd As New SqlCommand("p_ReportSummaryForPCA", MyConnection)
        With cmd
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add("@ReviewPeriodMonth", SqlDbType.VarChar)
            .Parameters("@ReviewPeriodMonth").Value = ddlReviewPeriodMonth.SelectedValue

            .Parameters.Add("@ReviewPeriodYear", SqlDbType.VarChar)
            .Parameters("@ReviewPeriodYear").Value = ddlReviewPeriodYear.SelectedValue

            .Parameters.Add("@PCAID", SqlDbType.Int)
            .Parameters("@PCAID").Value = ddlPCAID.SelectedValue
        End With

        Dim da As New SqlDataAdapter(cmd)
        Dim myDataTable As DataTable = New DataTable()
        da.Fill(myDataTable)

        Try

            MyConnection.Open()
            Response.Clear()
            Response.ClearHeaders()
            Dim writer As New CsvWriter(Response.OutputStream, ","c, Encoding.Default)
            writer.WriteAll(myDataTable, True)
            writer.Close()

            Dim FileDate As String = Replace(FormatDateTime(Now(), DateFormat.ShortDate), "/", "")
            Response.Clear()
            Response.ClearContent()
            Response.ContentType = "application/octet-stream"
            'Response.AddHeader("Content-Disposition", "attachment; filename=PCA_Call_Review_" & FileDate & ".xls")
            Response.AddHeader("Content-Disposition", "attachment; filename=" & ddlPCAID.SelectedItem.Text & ".xls")

            Dim excel As New GridView()
            excel.DataSource = myDataTable
            excel.DataBind()
            excel.RenderControl(New HtmlTextWriter(Response.Output))

            Response.Flush()
            Response.End()

        Finally
            If MyConnection.State <> ConnectionState.Closed Then MyConnection.Close()
            MyConnection.Dispose()
            MyConnection = Nothing
            myDataTable.Dispose()
            myDataTable = Nothing
        End Try

    End Sub

    Protected Sub GridView1_OnRowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            'This section hides or shows the View link next to each saved review record
            'An empty Url value contains 18 characters "ReviewAttachments/" so any value greater than 18 has an associated
            'attachment so we need to display it

            'View Attachment Link
            Dim hypView As HyperLink = e.Row.FindControl("hypViewAttachment")
            If hypView.NavigateUrl.Length > 18 Then
                hypView.Visible = True
            Else
                hypView.Visible = False
            End If

            'Delete Attachment Link
            'Only members of the PCACalls_Admins group have access to the delete function
            Dim hypDelete As HyperLink = e.Row.FindControl("hypDeleteAttachment")
            If Roles.IsUserInRole("PCACalls_Admins") = True Then
                hypDelete.Visible = True
            Else
                hypDelete.Visible = False
            End If

        End If
    End Sub

    Sub btnDeleteSavedReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        For Each row As GridViewRow In GridView1.Rows
            Dim checkbox As CheckBox = CType(row.FindControl("cbRows"), CheckBox)

            'Check if the checkbox is checked. 
            If checkbox.Checked Then
                'Retreive the SavedReviewID
                Dim SavedReviewID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected Review ID to the Delete command.
                dsPreviousReviews.DeleteParameters("SavedReviewID").DefaultValue = SavedReviewID.ToString()
                dsPreviousReviews.Delete()
            End If
        Next row

        GridView1.DataBind()

    End Sub

    Protected Sub btnErrorType_Click(sender As Object, e As EventArgs)
        Dim btn As Button = sender
        Dim arg = btn.CommandArgument.ToString().Split(",")
        Dim strErrorType = arg(0)
        Dim strErrorDataType = arg(1)
        Dim strReviewPeriodMonth = ddlReviewPeriodMonth.SelectedValue
        Dim strReviewPeriodYear = ddlReviewPeriodYear.SelectedValue
        Dim strPCAID = ddlPCAID.SelectedValue

        Response.Redirect("Report_Errors.aspx?ErrorType=" & strErrorType & "&ErrorDataType=" & strErrorDataType & "&ReviewPeriodMonth=" & strReviewPeriodMonth & "&ReviewPeriodYear=" & strReviewPeriodYear & "&PCAID=" & strPCAID)
    End Sub

    Protected Sub btnFinalReport_Click(sener As Object, e As EventArgs)
        Dim strPCA As String = Server.UrlEncode(ddlPCAID.SelectedItem.Text)
        Dim strReviewPeriodMonth = ddlReviewPeriodMonth.SelectedValue
        Dim strReviewPeriodYear = ddlReviewPeriodYear.SelectedValue
        Dim strLoanAnalyst = Server.UrlEncode(HttpContext.Current.User.Identity.Name)
        Dim strPCAID = ddlPCAID.SelectedValue

        Response.Redirect("ReportFinal/Report_Final.aspx?ReviewPeriodMonth=" & strReviewPeriodMonth & "&ReviewPeriodYear=" & strReviewPeriodYear & "&PCA=" & strPCA & "&LoanAnalyst=" & strLoanAnalyst & "&PCAID=" & strPCAID)

    End Sub

End Class
