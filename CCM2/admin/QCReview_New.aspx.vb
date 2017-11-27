Imports System.Data
Imports System.Data.SqlClient

Partial Class CCM2_admin_QCReview
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            txtReviewID.Text = ""
            lblUserID.Text = ""
            lblCallCenter.Text = ""
            lblDateofReview.Text = ""
            txtScore_Accuracy.Text = ""
            txtScore_Accuracy_Comments.Text = ""
            txtScore_Evaluate2.Text = ""
            txtScore_Evaluate2_Comments.Text = ""
            txtScore_Evaluate3.Text = ""
            txtScore_Evaluate3_Comments.Text = ""
            txtScore_Evaluate4.Text = ""
            txtScore_Evaluate4_Comments.Text = ""
            txtScore_MethodResolution.Text = ""
            txtScore_Escalated.Text = ""
            txtScore_Escalated_Comments.Text = ""
            txtScore_Grammar.Text = ""
            txtScore_Grammar_Comments.Text = ""
            txtComments.Text = ""
            lblRecordStatus.Text = ""
            lblQCScore.Text = ""
            hiddenQCScore.Value = ""
            lblSpecialtyLine.Text = ""
            lblInboundOutbound.Text = ""
        End If
    End Sub

    Protected Sub btnReviewIDLookup_Click(sender As Object, e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_QCIDLookup", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = txtReviewID.Text

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    lblUserID.Text = dr("UserID").ToString
                    lblCallCenter.Text = dr("CallCenter").ToString
                    lblDateofReview.Text = dr("DateOfReview").ToString
                    lblSpecialtyLine.Text = dr("SpecialtyLine").ToString
                    lblInboundOutbound.Text = dr("InboundOutbound").ToString
                End While
            End Using

            'Clear the form of any old values
            txtScore_Accuracy.Text = ""
            txtScore_Accuracy_Comments.Text = ""
            txtScore_Evaluate2.Text = ""
            txtScore_Evaluate2_Comments.Text = ""
            txtScore_Evaluate3.Text = ""
            txtScore_Evaluate3_Comments.Text = ""
            txtScore_Evaluate4.Text = ""
            txtScore_Evaluate4_Comments.Text = ""
            txtScore_MethodResolution.Text = ""
            txtScore_MethodResolution_Comments.Text = ""
            txtScore_Escalated.Text = ""
            txtScore_Escalated_Comments.Text = ""
            txtScore_Grammar.Text = ""
            txtScore_Grammar_Comments.Text = ""
            txtComments.Text = ""
            lblRecordStatus.Text = ""
            lblQCScore.Text = ""
            hiddenQCScore.Value = ""
        Finally
            con.Close()
        End Try
    End Sub


    Protected Sub btnInsertNewReview_Click(sender As Object, e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_QCScore_Insert", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = txtReviewID.Text
        cmd.Parameters.Add("@QCScore", SqlDbType.Int).Value = hiddenQCScore.Value
        cmd.Parameters.Add("@Score_Accuracy", SqlDbType.Int).Value = txtScore_Accuracy.Text
        cmd.Parameters.Add("@Score_Accuracy_Comments", SqlDbType.VarChar).Value = txtScore_Accuracy_Comments.Text
        cmd.Parameters.Add("@Score_Evaluate2", SqlDbType.Int).Value = txtScore_Evaluate2.Text
        cmd.Parameters.Add("@Score_Evaluate2_Comments", SqlDbType.VarChar).Value = txtScore_Evaluate2_Comments.Text
        cmd.Parameters.Add("@Score_Evaluate3", SqlDbType.Int).Value = txtScore_Evaluate3.Text
        cmd.Parameters.Add("@Score_Evaluate3_Comments", SqlDbType.VarChar).Value = txtScore_Evaluate3_Comments.Text
        cmd.Parameters.Add("@Score_Evaluate4", SqlDbType.Int).Value = txtScore_Evaluate4.Text
        cmd.Parameters.Add("@Score_Evaluate4_Comments", SqlDbType.VarChar).Value = txtScore_Evaluate4_Comments.Text
        cmd.Parameters.Add("@Score_MethodResolution", SqlDbType.Int).Value = txtScore_MethodResolution.Text
        cmd.Parameters.Add("@Score_MethodResolution_Comments", SqlDbType.VarChar).Value = txtScore_MethodResolution_Comments.Text
        cmd.Parameters.Add("@Score_Escalated", SqlDbType.Int).Value = txtScore_Escalated.Text
        cmd.Parameters.Add("@Score_Escalated_Comments", SqlDbType.VarChar).Value = txtScore_Escalated_Comments.Text
        cmd.Parameters.Add("@Score_Grammar", SqlDbType.Int).Value = txtScore_Grammar.Text
        cmd.Parameters.Add("@Score_Grammar_Comments", SqlDbType.VarChar).Value = txtScore_Grammar_Comments.Text
        cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        cmd.Parameters.Add("@SubmittedBy", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name

        Try
            cmd.Connection = con
            Using con
                con.Open()
                cmd.Connection = con
                cmd.ExecuteNonQuery()
                lblRecordStatus.Text = "Your QC Review Was Saved"

                'Clear the form
                txtReviewID.Text = ""
                lblCallCenter.Text = ""
                lblUserID.Text = ""
                lblDateofReview.Text = ""
                lblSpecialtyLine.Text = ""
                lblInboundOutbound.Text = ""
                txtScore_Accuracy.Text = ""
                txtScore_Accuracy_Comments.Text = ""
                txtScore_Evaluate2.Text = ""
                txtScore_Evaluate2_Comments.Text = ""
                txtScore_Evaluate3.Text = ""
                txtScore_Evaluate3_Comments.Text = ""
                txtScore_Evaluate4.Text = ""
                txtScore_Evaluate4_Comments.Text = ""
                txtScore_MethodResolution.Text = ""
                txtScore_MethodResolution_Comments.Text = ""
                txtScore_Escalated.Text = ""
                txtScore_Escalated_Comments.Text = ""
                txtScore_Grammar.Text = ""
                txtScore_Grammar_Comments.Text = ""
                txtComments.Text = ""
                lblQCScore.Text = ""
                hiddenQCScore.Value = ""
            End Using
        Finally
            con.Close()
        End Try
    End Sub

End Class
