Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_RehabCallReviewDetail
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim RehabCallID As Integer
            If Not Request.QueryString("RehabCallID") Is Nothing Then
                RehabCallID = Request.QueryString("RehabCallID")
            Else
                RehabCallID = 0
            End If
            lblRehabCallID.Text = RehabCallID.ToString()
            LoadForm(RehabCallID)

            'Only admins can see the enter comments in the FSA Supervisor Comments, recording delivery date, review date, report quarter, report year boxes
            If Roles.IsUserInRole("PCACalls_Admins") = True Then
                btnDelete.Visible = True
                txtFSASupervisor_Comments.Enabled = True
                txtRecordingDeliveryDate.Enabled = True
                txtReviewDate.Enabled = True
                ddlReportQuarter.Enabled = True
                ddlReportYear.Enabled = True
                'Show the Rehab Errors section
                BindRehabErrors()

            Else
                btnDelete.Visible = False
                txtFSASupervisor_Comments.Enabled = False
                txtRecordingDeliveryDate.Enabled = False
                txtReviewDate.Enabled = False
                ddlReportQuarter.Enabled = False
                ddlReportYear.Enabled = False
            End If
        End If
    End Sub

    Sub LoadForm(ByVal RehabCallID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_RehabCallID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@RehabCallID", SqlDbType.Int).Value = RehabCallID

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    If Not dr("DateSubmitted") Is DBNull.Value Then
                        txtCallDate.Text = Left(dr("CallDate"), 10).ToString()
                    End If

                    If Not dr("PCAID") Is DBNull.Value Then
                        ddlPCAID.SelectedValue = dr("PCAID")
                    End If

                    If Not dr("BorrowerNumber") Is DBNull.Value Then
                        txtBorrowerNumber.Text = dr("BorrowerNumber").ToString()
                    End If

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

                    If Not dr("ReportQuarter") Is DBNull.Value Then
                        ddlReportQuarter.SelectedValue = dr("ReportQuarter").ToString()
                    End If

                    If Not dr("ReportYear") Is DBNull.Value Then
                        ddlReportYear.SelectedValue = dr("ReportYear").ToString()
                    End If

                    If Not dr("FSA_Comments") Is DBNull.Value Then
                        txtFSA_Comments.Text = dr("FSA_Comments").ToString()
                    End If

                    If Not dr("FSASupervisor_Comments") Is DBNull.Value Then
                        txtFSA_Comments.Text = dr("FSASupervisor_Comments").ToString()
                    End If

                    If Not dr("PCA_Comments") Is DBNull.Value Then
                        txtPCA_Comments.Text = dr("PCA_Comments").ToString()
                    End If

                    If Not dr("FSA_Conclusions") Is DBNull.Value Then
                        txtFSA_Conclusions.Text = dr("FSA_Conclusions").ToString()
                    End If

                    If Not dr("RecordingDeliveryDate") Is DBNull.Value Then
                        txtRecordingDeliveryDate.Text = dr("RecordingDeliveryDate").ToString()
                    End If

                    If Not dr("ReviewDate") Is DBNull.Value Then
                        txtReviewDate.Text = dr("ReviewDate").ToString()
                    End If

                End While
            End Using

            Page.DataBind()

        Finally
            con.Close()
        End Try

    End Sub

    Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateRehabCallID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@RehabCallID", SqlDbType.Int).Value = lblRehabCallID.Text
        cmd.Parameters.Add("@CallDate", SqlDbType.SmallDateTime).Value = txtCallDate.Text

        If ddlPCAID.SelectedValue <> "" Then
            cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        Else
            cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = DBNull.Value
        End If

        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        Else
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Rehab_Program.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Rehab_Program", SqlDbType.VarChar).Value = ddlScore_Rehab_Program.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Rehab_Program", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Rehab_Once.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Rehab_Once", SqlDbType.NChar).Value = ddlScore_Rehab_Once.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Rehab_Once", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Nine_Payments.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Nine_Payments", SqlDbType.NChar).Value = ddlScore_Nine_Payments.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Nine_Payments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Loans_Transferred_After_60_Days.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days", SqlDbType.NChar).Value = ddlScore_Loans_Transferred_After_60_Days.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Reversed_Payments.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Reversed_Payments", SqlDbType.NChar).Value = ddlScore_Reversed_Payments.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Reversed_Payments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_TOP.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_TOP", SqlDbType.NChar).Value = ddlScore_TOP.SelectedValue
        Else
            cmd.Parameters.Add("@Score_TOP", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_AWG.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_AWG", SqlDbType.NChar).Value = ddlScore_AWG.SelectedValue
        Else
            cmd.Parameters.Add("@Score_AWG", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Continue_Payments.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Continue_Payments", SqlDbType.NChar).Value = ddlScore_Continue_Payments.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Continue_Payments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_New_Payment_Schedule.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_New_Payment_Schedule", SqlDbType.NChar).Value = ddlScore_New_Payment_Schedule.SelectedValue
        Else
            cmd.Parameters.Add("@Score_New_Payment_Schedule", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_TPD.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_TPD", SqlDbType.NChar).Value = ddlScore_TPD.SelectedValue
        Else
            cmd.Parameters.Add("@Score_TPD", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Eligible_Payment_Plans.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Eligible_Payment_Plans", SqlDbType.NChar).Value = ddlScore_Eligible_Payment_Plans.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Eligible_Payment_Plans", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Deferment_Forb.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Deferment_Forb", SqlDbType.NChar).Value = ddlScore_Deferment_Forb.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Deferment_Forb", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_TitleIV.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_TitleIV", SqlDbType.NChar).Value = ddlScore_TitleIV.SelectedValue
        Else
            cmd.Parameters.Add("@Score_TitleIV", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Collection_Charges_Waived.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Collection_Charges_Waived", SqlDbType.NChar).Value = ddlScore_Collection_Charges_Waived.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Collection_Charges_Waived", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_TOP_Payment_PIFs_Account.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_TOP_Payment_PIFs_Account", SqlDbType.NChar).Value = ddlScore_TOP_Payment_PIFs_Account.SelectedValue
        Else
            cmd.Parameters.Add("@Score_TOP_Payment_PIFs_Account", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Delay_Tax_Reform.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Delay_Tax_Reform", SqlDbType.NChar).Value = ddlScore_Delay_Tax_Reform.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Delay_Tax_Reform", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        If ddlScore_More_Aid.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_More_Aid", SqlDbType.VarChar).Value = ddlScore_More_Aid.SelectedValue
        Else
            cmd.Parameters.Add("@Score_More_Aid", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Collection_Costs_Waived.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Collection_Costs_Waived", SqlDbType.VarChar).Value = ddlScore_Collection_Costs_Waived.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Collection_Costs_Waived", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_False_Requirements.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_False_Requirements", SqlDbType.VarChar).Value = ddlScore_False_Requirements.SelectedValue
        Else
            cmd.Parameters.Add("@Score_False_Requirements", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Not_Factual.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Not_Factual", SqlDbType.VarChar).Value = ddlScore_Not_Factual.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Not_Factual", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Unaffordable_Payments.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Unaffordable_Payments", SqlDbType.VarChar).Value = ddlScore_Unaffordable_Payments.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Unaffordable_Payments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Avoid_PIF.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Avoid_PIF", SqlDbType.VarChar).Value = ddlScore_Avoid_PIF.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Avoid_PIF", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Rehab_Then_TPD.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Rehab_Then_TPD", SqlDbType.VarChar).Value = ddlScore_Rehab_Then_TPD.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Rehab_Then_TPD", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Ineligible_Borrower.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Ineligible_Borrower", SqlDbType.VarChar).Value = ddlScore_Ineligible_Borrower.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Ineligible_Borrower", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Payments_Are_Final.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Payments_Are_Final", SqlDbType.VarChar).Value = ddlScore_Payments_Are_Final.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Payments_Are_Final", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Credit_All_Negative_Data_Removed.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Credit_All_Negative_Data_Removed", SqlDbType.VarChar).Value = ddlScore_Credit_All_Negative_Data_Removed.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Credit_All_Negative_Data_Removed", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Credit_Never_Defaulted.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Credit_Never_Defaulted", SqlDbType.VarChar).Value = ddlScore_Credit_Never_Defaulted.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Credit_Never_Defaulted", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlScore_Credit_Score_Will_Improve.SelectedValue <> "" Then
            cmd.Parameters.Add("@Score_Credit_Score_Will_Improve", SqlDbType.VarChar).Value = ddlScore_Credit_Score_Will_Improve.SelectedValue
        Else
            cmd.Parameters.Add("@Score_Credit_Score_Will_Improve", SqlDbType.VarChar).Value = DBNull.Value
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

        If txtRecordingDeliveryDate.Text <> "" Then
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = txtRecordingDeliveryDate.Text
        Else
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your review was successfully updated"

            'Now save the rehab errors if the user is an admin
            If Roles.IsUserInRole("PCACalls_Admins") = True Then
                SaveRehabErrors()
            End If
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

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("SELECT ' ' + [RehabMetric] AS RehabMetric, [RehabMetricID] FROM RehabMetrics ORDER BY RehabMetric", con)

        con.Open()
        cblRehabErrors.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        cblRehabErrors.DataTextField = "RehabMetric"
        cblRehabErrors.DataValueField = "RehabMetricID"
        cblRehabErrors.DataBind()

        'Now update the checkboxlist with the saved values from the table RehabMetricsCalls
        cmd = New SqlCommand("SELECT * FROM RehabMetricsCalls WHERE RehabCallID=" & lblRehabCallID.Text, con)
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

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        SqlText = "p_DeleteRehabMetricCallID"
        cmd = New SqlCommand(SqlText)
        cmd.Connection = con
        cmd.CommandType = CommandType.StoredProcedure
        'input parameters for the sproc
        cmd.Parameters.Add("@RehabCallID", SqlDbType.Int).Value = lblRehabCallID.Text
        Try
            con.Open()
            cmd.Connection = con
            cmd.ExecuteNonQuery()
        Finally
            con.Close()
        End Try
        'Now that the existing RehabCallIDs, we can add the new ones
        AddNewRehabErrors()
    End Sub

    Sub AddNewRehabErrors()
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        SqlText = "p_InsertNewRehabMetricErrors"
        Try
            con.Open()
            For Each Item As ListItem In cblRehabErrors.Items
                If (Item.Selected) Then
                    cmd = New SqlCommand(SqlText)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Connection = con
                    'input parameters for the sproc
                    cmd.Parameters.Add("@RehabCallID", SqlDbType.Int).Value = lblRehabCallID.Text
                    cmd.Parameters.Add("@RehabMetricID", SqlDbType.Int).Value = Item.Value
                    cmd.ExecuteNonQuery()
                End If
            Next
        Finally
            con.Close()
        End Try
    End Sub

    Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteRehabCallID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@RehabCallID", SqlDbType.Int).Value = lblRehabCallID.Text

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your call was successfully deleted"
        Finally
            con.Close()
        End Try
    End Sub

End Class
