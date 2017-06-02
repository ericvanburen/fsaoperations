Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_NewReview
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
            If Not Request.QueryString("ReviewDate") Is Nothing And Request.QueryString("ReviewDate") <> "&nbsp;" Then
                Dim strReviewDate As String = Server.UrlDecode(Request.QueryString("ReviewDate"))
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

            If Not Request.QueryString("CallDate") Is Nothing Then
                Dim dteCallDate As DateTime = Request.QueryString("CallDate")
                txtCallDate.Text = dteCallDate
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
                'ddlReportQuarter.Enabled = False
                'ddlReportYear.Enabled = False
            End If

            btnUpdateAgain.Visible = False
        End If
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertNewCall", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@NewAssignmentID", lblNewAssignmentID.Text)
        cmd.Parameters.AddWithValue("@DateSubmitted", Date.Now())
        cmd.Parameters.AddWithValue("@CallDate", txtCallDate.Text)
        cmd.Parameters.AddWithValue("@PCAID", ddlPCAID.SelectedValue)
        cmd.Parameters.AddWithValue("@UserID", HttpContext.Current.User.Identity.Name)
        cmd.Parameters.AddWithValue("@BorrowerLastName", txtBorrowerLastName.Text)
        cmd.Parameters.AddWithValue("@BorrowerNumber", txtBorrowerNumber.Text)
        cmd.Parameters.AddWithValue("@InOutBound", ddlInOutBound.SelectedValue)
        cmd.Parameters.AddWithValue("@CallType", ddlCallType.SelectedValue)
        cmd.Parameters.AddWithValue("@CallLength", txtCallLength.Text)
        cmd.Parameters.AddWithValue("@Score_CorrectID", ddlScore_CorrectID.SelectedValue)
        cmd.Parameters.AddWithValue("@Score_MiniMiranda", ddlScore_MiniMiranda.SelectedValue)
        cmd.Parameters.AddWithValue("@Score_Accuracy", ddlScore_Accuracy.SelectedValue)
        cmd.Parameters.AddWithValue("@Score_Notepad", ddlScore_Notepad.SelectedValue)
        cmd.Parameters.AddWithValue("@Score_Tone", ddlScore_Tone.SelectedValue)
        cmd.Parameters.AddWithValue("@Score_PCAResponsive", ddlScore_PCAResponsive.SelectedValue)
        cmd.Parameters.AddWithValue("@Complaint", ddlComplaint.SelectedValue)

        'These values are all set to OK by default because the Loan Analyst cannot update them.
        cmd.Parameters.Add("@Score_CorrectID_Accuracy", SqlDbType.VarChar).Value = "OK"
        cmd.Parameters.Add("@Score_MiniMiranda_Accuracy", SqlDbType.VarChar).Value = "OK"
        cmd.Parameters.Add("@Score_Accuracy_Accuracy", SqlDbType.VarChar).Value = "OK"
        cmd.Parameters.Add("@Score_Notepad_Accuracy", SqlDbType.VarChar).Value = "OK"
        cmd.Parameters.Add("@Score_Tone_Accuracy", SqlDbType.VarChar).Value = "OK"
        cmd.Parameters.Add("@Score_PCAResponsive_Accuracy", SqlDbType.VarChar).Value = "OK"
        cmd.Parameters.Add("@Complaint_Accuracy", SqlDbType.VarChar).Value = "OK"

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
            cmd.Parameters.AddWithValue("@RecordingDeliveryDate", txtRecordingDeliveryDate.Text)
        Else
            cmd.Parameters.AddWithValue("@RecordingDeliveryDate", DBNull.Value)
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

        If txtReviewDate.Text <> "" Then
            cmd.Parameters.AddWithValue("@ReviewDate", txtReviewDate.Text)
        Else
            cmd.Parameters.AddWithValue("@ReviewDate", DBNull.Value)
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblUpdateConfirm.Text = "Your call was successfully submitted"
            btnSubmit.Visible = False
            btnUpdateAgain.Visible = True

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnSubmitAgain_Click(sender As Object, e As System.EventArgs)
        Dim RecordingDeliveryDate As String = Server.UrlEncode(txtRecordingDeliveryDate.Text)
        Dim ReviewDate As String = Server.UrlEncode(txtReviewDate.Text)
        Response.Redirect("NewReview.aspx?PCAID=" & ddlPCAID.SelectedValue & "&CallDate=" & txtCallDate.Text & "&RecordingDeliveryDate=" & RecordingDeliveryDate & "&ReviewDate=" & ReviewDate & "&NewAssignmentID=" & lblNewAssignmentID.Text)
    End Sub
End Class
