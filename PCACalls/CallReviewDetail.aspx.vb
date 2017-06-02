Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_CallReviewDetail
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim CallID As Integer
            If Not Request.QueryString("CallID") Is Nothing Then
                CallID = Request.QueryString("CallID")
            Else
                CallID = 0
            End If

            'Only admins can see the enter comments in the FSA Supervisor Comments box and delete call button
            'Only admins can see and update the metric accuracy boxes

            If Roles.IsUserInRole("PCACalls_Admins") = True Then
                btnDelete.Visible = True
                txtFSASupervisor_Comments.Enabled = True
                txtRecordingDeliveryDate.Enabled = True
                txtReviewDate.Enabled = True
                ddlReportQuarter.Enabled = True
                ddlReportYear.Enabled = True
                pnlLAAccuracy.Visible = True
            Else
                btnDelete.Visible = False
                txtFSASupervisor_Comments.Enabled = False
                txtRecordingDeliveryDate.Enabled = False
                txtReviewDate.Enabled = False
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
            LoadForm(CallID)

        End If
    End Sub

    Sub LoadForm(ByVal CallID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CallID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@CallID", SqlDbType.Int).Value = CallID

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    If Not dr("CallID") Is DBNull.Value Then
                        lblCallID.Text = dr("CallID").ToString()
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

                    If Not dr("ReportQuarter") Is DBNull.Value Then
                        ddlReportQuarter.SelectedValue = dr("ReportQuarter").ToString()
                    End If

                    If Not dr("ReportYear") Is DBNull.Value Then
                        ddlReportYear.SelectedValue = dr("ReportYear").ToString()
                    End If

                    If Not dr("RecordingDeliveryDate") Is DBNull.Value Then
                        txtRecordingDeliveryDate.Text = dr("RecordingDeliveryDate").ToString()
                    End If

                    If Not dr("ReviewDate") Is DBNull.Value Then
                        txtReviewDate.Text = dr("ReviewDate").ToString()
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

            Page.DataBind()

        Finally
            con.Close()
        End Try

    End Sub

    Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateCallID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@CallID", SqlDbType.Int).Value = lblCallID.Text
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

        cmd.Parameters.Add("@Score_CorrectID", SqlDbType.Bit).Value = ddlScore_CorrectID.SelectedValue
        cmd.Parameters.Add("@Score_MiniMiranda", SqlDbType.Bit).Value = ddlScore_MiniMiranda.SelectedValue
        cmd.Parameters.Add("@Score_Accuracy", SqlDbType.Bit).Value = ddlScore_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Notepad", SqlDbType.Bit).Value = ddlScore_Notepad.SelectedValue
        cmd.Parameters.Add("@Score_Tone", SqlDbType.Bit).Value = ddlScore_Tone.SelectedValue
        cmd.Parameters.Add("@Score_PCAResponsive", SqlDbType.Bit).Value = ddlScore_PCAResponsive.SelectedValue
        cmd.Parameters.Add("@Complaint", SqlDbType.Bit).Value = ddlComplaint.SelectedValue

        cmd.Parameters.Add("@Score_CorrectID_Accuracy", SqlDbType.VarChar).Value = ddlScore_CorrectID_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_MiniMiranda_Accuracy", SqlDbType.VarChar).Value = ddlScore_MiniMiranda_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Accuracy_Accuracy", SqlDbType.VarChar).Value = ddlScore_Accuracy_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Notepad_Accuracy", SqlDbType.VarChar).Value = ddlScore_Notepad_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_Tone_Accuracy", SqlDbType.VarChar).Value = ddlScore_Tone_Accuracy.SelectedValue
        cmd.Parameters.Add("@Score_PCAResponsive_Accuracy", SqlDbType.VarChar).Value = ddlScore_PCAResponsive_Accuracy.SelectedValue
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

        If txtRecordingDeliveryDate.Text <> "" Then
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = txtRecordingDeliveryDate.Text
        Else
            cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtReviewDate.Text <> "" Then
            cmd.Parameters.Add("@ReviewDate", SqlDbType.SmallDateTime).Value = txtReviewDate.Text
        Else
            cmd.Parameters.Add("@ReviewDate", SqlDbType.SmallDateTime).Value = DBNull.Value
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
        Finally
            con.Close()
        End Try
    End Sub

    Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteCallID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@CallID", SqlDbType.Int).Value = lblCallID.Text

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
