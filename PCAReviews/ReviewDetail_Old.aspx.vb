Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_ReviewDetail
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
            'Only admins can see and update the metric accuracy boxes

            If Roles.IsUserInRole("PCAReviews_Admins") = True Then
                ddlReviewPeriodMonth.Enabled = True
                ddlReviewPeriodYear.Enabled = True
                btnDelete.Visible = True
                txtFSASupervisor_Comments.Enabled = True
                txtRecordingDeliveryDate.Enabled = True
                pnlLAAccuracy.Visible = True
                'Show the Rehab Errors section
                BindRehabErrors()
            Else
                btnDelete.Visible = False
                ddlReviewPeriodMonth.Enabled = False
                ddlReviewPeriodYear.Enabled = False
                txtFSASupervisor_Comments.Enabled = False
                txtRecordingDeliveryDate.Enabled = False
                ddlScore_CorrectID_Accuracy.Visible = False
                ddlScore_Accuracy_Accuracy.Visible = False
                ddlScore_Tone_Accuracy.Visible = False
                ddlScore_MiniMiranda_Accuracy.Visible = False
                ddlScore_Notepad_Accuracy.Visible = False
                ddlScore_PCAResponsive_Accuracy.Visible = False
                ddlComplaint_Accuracy.Visible = False
                pnlLAAccuracy.Visible = False
            End If

            'Load data in the form
            LoadForm(ReviewID)
        End If
    End Sub

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

                    If Not dr("DateSubmitted") Is DBNull.Value Then
                        txtCallDate.Text = dr("CallDate").ToString()
                    End If

                    If Not dr("PCAID") Is DBNull.Value Then
                        ddlPCAID.SelectedValue = dr("PCAID")
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

                    If Not dr("RehabTalkOff") Is DBNull.Value Then
                        ddlRehabTalkOff.SelectedValue = dr("RehabTalkOff").ToString()
                    End If

                    If Not dr("Score_CorrectID") Is DBNull.Value Then
                        ddlScore_CorrectID.SelectedValue = dr("Score_CorrectID")
                    End If

                    If Not dr("Score_CorrectID_Accuracy") Is DBNull.Value Then
                        ddlScore_CorrectID_Accuracy.SelectedValue = dr("Score_CorrectID_Accuracy")
                    End If

                    If Not dr("Score_MiniMiranda") Is DBNull.Value Then
                        ddlScore_MiniMiranda.SelectedValue = dr("Score_MiniMiranda")
                    End If

                    If Not dr("Score_MiniMiranda_Accuracy") Is DBNull.Value Then
                        ddlScore_MiniMiranda_Accuracy.SelectedValue = dr("Score_MiniMiranda_Accuracy")
                    End If

                    If Not dr("Score_Accuracy") Is DBNull.Value Then
                        ddlScore_Accuracy.SelectedValue = dr("Score_Accuracy")
                    End If

                    If Not dr("Score_Accuracy_Accuracy") Is DBNull.Value Then
                        ddlScore_Accuracy_Accuracy.SelectedValue = dr("Score_Accuracy_Accuracy")
                    End If

                    If Not dr("Score_Notepad") Is DBNull.Value Then
                        ddlScore_Notepad.SelectedValue = dr("Score_Notepad")
                    End If

                    If Not dr("Score_Notepad_Accuracy") Is DBNull.Value Then
                        ddlScore_Notepad_Accuracy.SelectedValue = dr("Score_Notepad_Accuracy")
                    End If

                    If Not dr("Score_Tone") Is DBNull.Value Then
                        ddlScore_Tone.SelectedValue = dr("Score_Tone")
                    End If

                    If Not dr("Score_Tone_Accuracy") Is DBNull.Value Then
                        ddlScore_Tone_Accuracy.SelectedValue = dr("Score_Tone_Accuracy")
                    End If

                    If Not dr("Score_PCAResponsive") Is DBNull.Value Then
                        ddlScore_PCAResponsive.SelectedValue = dr("Score_PCAResponsive")
                    End If

                    If Not dr("Score_PCAResponsive_Accuracy") Is DBNull.Value Then
                        ddlScore_PCAResponsive_Accuracy.SelectedValue = dr("Score_PCAResponsive_Accuracy")
                    End If

                    If Not dr("Score_AWGInfo") Is DBNull.Value Then
                        ddlScore_AWGInfo.SelectedValue = dr("Score_AWGInfo")
                    End If

                    If Not dr("Score_AWGInfo_Accuracy") Is DBNull.Value Then
                        ddlScore_AWGInfo_Accuracy.SelectedValue = dr("Score_AWGInfo_Accuracy")
                    End If

                    If Not dr("Complaint") Is DBNull.Value Then
                        ddlComplaint.SelectedValue = dr("Complaint").ToString()
                    End If

                    If Not dr("Complaint_Accuracy") Is DBNull.Value Then
                        ddlComplaint_Accuracy.SelectedValue = dr("Complaint_Accuracy").ToString()
                    End If

                    If Not dr("IMF_Submission_Date") Is DBNull.Value Then
                        txtIMF_Submission_Date.Text = dr("IMF_Submission_Date").ToString()
                    End If

                    If Not dr("IMF_Timely") Is DBNull.Value Then
                        ddlIMF_Timely.SelectedValue = dr("IMF_Timely").ToString()
                    End If

                    'Rehab Fields
                    If Not dr("Score_Rehab_Program") Is DBNull.Value Then
                        ddlScore_Rehab_Program.SelectedValue = dr("Score_Rehab_Program").ToString()
                    End If

                    If Not dr("Score_Rehab_Once") Is DBNull.Value Then
                        ddlScore_Rehab_Once.SelectedValue = dr("Score_Rehab_Once")
                    End If

                    If Not dr("Score_Nine_Payments") Is DBNull.Value Then
                        ddlScore_Nine_Payments.SelectedValue = dr("Score_Nine_Payments")
                    End If

                    If Not dr("Score_Loans_Transferred_After_60_Days") Is DBNull.Value Then
                        ddlScore_Loans_Transferred_After_60_Days.SelectedValue = dr("Score_Loans_Transferred_After_60_Days")
                    End If

                    If Not dr("Score_Reversed_Payments") Is DBNull.Value Then
                        ddlScore_Reversed_Payments.SelectedValue = dr("Score_Reversed_Payments")
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

                    If Not dr("Score_New_Payment_Schedule") Is DBNull.Value Then
                        ddlScore_New_Payment_Schedule.SelectedValue = dr("Score_New_Payment_Schedule")
                    End If

                    If Not dr("Score_TPD") Is DBNull.Value Then
                        ddlScore_TPD.SelectedValue = dr("Score_TPD")
                    End If

                    If Not dr("Score_Eligible_Payment_Plans") Is DBNull.Value Then
                        ddlScore_Eligible_Payment_Plans.SelectedValue = dr("Score_Eligible_Payment_Plans")
                    End If

                    If Not dr("Score_Deferment_Forb") Is DBNull.Value Then
                        ddlScore_Deferment_Forb.SelectedValue = dr("Score_Deferment_Forb")
                    End If

                    If Not dr("Score_TitleIV") Is DBNull.Value Then
                        ddlScore_TitleIV.SelectedValue = dr("Score_TitleIV")
                    End If

                    If Not dr("Score_Collection_Charges_Waived") Is DBNull.Value Then
                        ddlScore_Collection_Charges_Waived.SelectedValue = dr("Score_Collection_Charges_Waived")
                    End If

                    If Not dr("Score_TOP_Payment_PIFs_Account") Is DBNull.Value Then
                        ddlScore_TOP_Payment_PIFs_Account.SelectedValue = dr("Score_TOP_Payment_PIFs_Account")
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

                    If Not dr("Score_Not_Factual") Is DBNull.Value Then
                        ddlScore_Not_Factual.SelectedValue = dr("Score_Not_Factual")
                    End If

                    If Not dr("Score_Unaffordable_Payments") Is DBNull.Value Then
                        ddlScore_Unaffordable_Payments.SelectedValue = dr("Score_Unaffordable_Payments")
                    End If

                    If Not dr("Score_Avoid_PIF") Is DBNull.Value Then
                        ddlScore_Avoid_PIF.SelectedValue = dr("Score_Avoid_PIF")
                    End If

                    If Not dr("Score_Rehab_Then_TPD") Is DBNull.Value Then
                        ddlScore_Rehab_Then_TPD.SelectedValue = dr("Score_Rehab_Then_TPD")
                    End If

                    If Not dr("Score_Ineligible_Borrower") Is DBNull.Value Then
                        ddlScore_Ineligible_Borrower.SelectedValue = dr("Score_Ineligible_Borrower")
                    End If

                    If Not dr("Score_Payments_Are_Final") Is DBNull.Value Then
                        ddlScore_Payments_Are_Final.SelectedValue = dr("Score_Payments_Are_Final")
                    End If

                    If Not dr("Score_Credit_All_Negative_Data_Removed") Is DBNull.Value Then
                        ddlScore_Credit_All_Negative_Data_Removed.SelectedValue = dr("Score_Credit_All_Negative_Data_Removed")
                    End If

                    If Not dr("Score_Credit_Never_Defaulted") Is DBNull.Value Then
                        ddlScore_Credit_Never_Defaulted.SelectedValue = dr("Score_Credit_Never_Defaulted")
                    End If

                    If Not dr("Score_Credit_Score_Will_Improve") Is DBNull.Value Then
                        ddlScore_Credit_Score_Will_Improve.SelectedValue = dr("Score_Credit_Score_Will_Improve")
                    End If
                    'End Rehab Fields                   

                    If Not dr("RecordingDeliveryDate") Is DBNull.Value Then
                        txtRecordingDeliveryDate.Text = dr("RecordingDeliveryDate").ToString()
                    End If

                    If Not dr("ReviewPeriodMonth") Is DBNull.Value Then
                        ddlReviewPeriodMonth.SelectedValue = dr("ReviewPeriodMonth").ToString()
                    End If

                    If Not dr("ReviewPeriodYear") Is DBNull.Value Then
                        ddlReviewPeriodYear.SelectedValue = dr("ReviewPeriodYear").ToString()
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

        If ddlRehabTalkOff.SelectedValue <> "" Then
            cmd.Parameters.Add("@RehabTalkOff", SqlDbType.VarChar).Value = ddlRehabTalkOff.SelectedValue
        Else
            cmd.Parameters.Add("@RehabTalkOff", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_CorrectID.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_CorrectID", ddlScore_CorrectID.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_CorrectID", DBNull.Value)
        End If

        If ddlScore_MiniMiranda.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_MiniMiranda", ddlScore_MiniMiranda.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_MiniMiranda", DBNull.Value)
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

        If ddlScore_Tone.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Score_Tone", ddlScore_Tone.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Score_Tone", DBNull.Value)
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

        cmd.Parameters.Add("@Score_CorrectID_Accuracy", SqlDbType.VarChar).Value = ddlScore_CorrectID_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_MiniMiranda_Accuracy", SqlDbType.VarChar).Value = ddlScore_MiniMiranda_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Accuracy_Accuracy", SqlDbType.VarChar).Value = ddlScore_Accuracy_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Notepad_Accuracy", SqlDbType.VarChar).Value = ddlScore_Notepad_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Tone_Accuracy", SqlDbType.VarChar).Value = ddlScore_Tone_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_PCAResponsive_Accuracy", SqlDbType.VarChar).Value = ddlScore_PCAResponsive_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_AWGInfo_Accuracy", SqlDbType.VarChar).Value = ddlScore_AWGInfo_Accuracy.SelectedValue
        cmd.Parameters.Add("@Complaint_Accuracy", SqlDbType.VarChar).Value = ddlComplaint_Accuracy.SelectedValue

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

        'These are the rehab fields
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
        'End rehab fields

        If txtRecordingDeliveryDate.Text <> "" Then
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = txtRecordingDeliveryDate.Text
        Else
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = DBNull.Value
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

        If txtFSA_Comments.Text <> "" Then
            cmd.Parameters.Add("@FSA_Comments", SqlDbType.VarChar).Value = txtFSA_Comments.Text
        Else
            cmd.Parameters.Add("@FSA_Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtFSASupervisor_Comments.Text <> "" Then
            cmd.Parameters.Add("@FSASupervisor_Comments", SqlDbType.VarChar).Value = txtFSASupervisor_Comments.Text
        Else
            cmd.Parameters.Add("@FSASupervisor_Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtPCA_Comments.Text <> "" Then
            cmd.Parameters.Add("@PCA_Comments", SqlDbType.VarChar).Value = txtPCA_Comments.Text
        Else
            cmd.Parameters.Add("@PCA_Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtFSA_Conclusions.Text <> "" Then
            cmd.Parameters.Add("@FSA_Conclusions", SqlDbType.VarChar).Value = txtFSA_Conclusions.Text
        Else
            cmd.Parameters.Add("@FSA_Conclusions", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your review was successfully updated"

            'Now save the rehab errors if the user is an admin
            If Roles.IsUserInRole("PCAReviews_Admins") = True Then
                SaveRehabErrors()
            End If

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

    'This first populates the RehabErrors checkboxlist control with a list of all records 
    'then loops back through the control and checks the checkboxes which have been saved to the database

    Public Sub BindRehabErrors()

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim objReader As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("SELECT ' ' + [RehabMetric] AS RehabMetric, [RehabMetricID] FROM RehabMetrics ORDER BY RehabMetric", con)

        con.Open()
        cblRehabErrors.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        cblRehabErrors.DataTextField = "RehabMetric"
        cblRehabErrors.DataValueField = "RehabMetricID"
        cblRehabErrors.DataBind()

        'Now update the checkboxlist with the saved values from the table RehabMetricsCalls
        cmd = New SqlCommand("SELECT * FROM RehabMetricsCalls WHERE ReviewID=" & lblReviewID.Text, con)
        con.Open()
        objReader = cmd.ExecuteReader()
        While objReader.Read()
            Dim currentCheckBox As ListItem = cblRehabErrors.Items.FindByValue(objReader("RehabMetricID").ToString())
            If Not (currentCheckBox Is Nothing) Then
                currentCheckBox.Selected = True
            End If
        End While
        con.Close()
    End Sub

    'This saves the checked rehab errors in the database 

    Sub SaveRehabErrors()
        'The first step is to delete all of the saved rehab errors from the table RehabMetricsCalls 
        DeleteRehabErrors()
    End Sub

    Sub DeleteRehabErrors()
        'The first step is to delete all of the saved rehab errors from the table RehabMetricsCalls
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        SqlText = "p_DeleteRehabMetricReviewID"
        cmd = New SqlCommand(SqlText)
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure
        'input parameters for the sproc
        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = lblReviewID.Text
        Try
            con.Open()
            cmd.Connection = con
            cmd.ExecuteNonQuery()
        Finally
            con.Close()
        End Try
        'Now that the existing ReviewIDs are deleted, we can add the new ones
        AddNewRehabErrors()
    End Sub

    Sub AddNewRehabErrors()
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        SqlText = "p_InsertNewRehabMetricErrors"
        Try
            con.Open()
            For Each Item As ListItem In cblRehabErrors.Items
                If (Item.Selected) Then
                    cmd = New SqlCommand(SqlText)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Connection = con
                    'input parameters for the sproc
                    cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = lblReviewID.Text
                    cmd.Parameters.Add("@RehabMetricID", SqlDbType.Int).Value = Item.Value
                    cmd.ExecuteNonQuery()
                End If
            Next
        Finally
            con.Close()
        End Try
    End Sub

End Class
