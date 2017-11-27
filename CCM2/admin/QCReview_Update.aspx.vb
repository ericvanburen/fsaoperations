Imports System.Data
Imports System.Data.SqlClient

Partial Class CCM2_admin_QCReview
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim intReviewID As String
            If Not Request.QueryString("ReviewID") Is Nothing Then
                intReviewID = Request.QueryString("ReviewID")
                txtReviewID.Text = intReviewID
                ReviewIDLookup(intReviewID)
            End If
        End If
    End Sub

    Protected Sub btnReviewIDLookup_Click(sender As Object, e As EventArgs)

        'Clear the form of any old values
        lblQCID.Text = ""
        lblSpecialtyLine.Text = ""
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
        lblRecordStatus.Text = ""

        ReviewIDLookup()
    End Sub

    Sub ReviewIDLookup(Optional ByVal ReviewID As Integer = 0)
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
                    lblQCID.Text = dr("QCID").ToString
                    lblUserID.Text = dr("UserID").ToString
                    lblCallCenter.Text = dr("CallCenter").ToString
                    lblDateofReview.Text = dr("DateOfReview").ToString
                    lblSpecialtyLine.Text = dr("SpecialtyLine").ToString
                    lblInboundOutbound.Text = dr("InboundOutbound").ToString
                    lblQCScore.Text = dr("QCScore").ToString
                    lblSpecialtyLine.Text = dr("SpecialtyLine").ToString
                    hiddenQCScore.Value = dr("QCScore").ToString
                    txtScore_Accuracy.Text = dr("Score_Accuracy").ToString
                    txtScore_Accuracy_Comments.Text = dr("Score_Accuracy_Comments").ToString
                    txtScore_Evaluate2.Text = dr("Score_Evaluate2").ToString
                    txtScore_Evaluate2_Comments.Text = dr("Score_Evaluate2_Comments").ToString
                    txtScore_Evaluate3.Text = dr("Score_Evaluate3").ToString
                    txtScore_Evaluate3_Comments.Text = dr("Score_Evaluate3_Comments").ToString
                    txtScore_Evaluate4.Text = dr("Score_Evaluate4").ToString
                    txtScore_Evaluate4_Comments.Text = dr("Score_Evaluate4_Comments").ToString
                    txtScore_MethodResolution.Text = dr("Score_MethodResolution").ToString
                    txtScore_MethodResolution_Comments.Text = dr("Score_MethodResolution_Comments").ToString
                    txtScore_Escalated.Text = dr("Score_Escalated").ToString
                    txtScore_Escalated_Comments.Text = dr("Score_Escalated_Comments").ToString
                    txtScore_Grammar.Text = dr("Score_Grammar").ToString
                    txtScore_Grammar_Comments.Text = dr("Score_Grammar_Comments").ToString
                    txtComments.Text = dr("Comments").ToString
                End While
            End Using

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub btnSaveReview_Click(sender As Object, e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_QCScore_Update", con)
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

        'This is used to fix a display issue glitch where the score displayed isn't being refreshed
        lblQCScore.Text = hiddenQCScore.Value

        Try
            cmd.Connection = con
            Using con
                con.Open()
                cmd.Connection = con
                cmd.ExecuteNonQuery()
            End Using
            lblRecordStatus.Text = "Your QC Review Was Updated"
        Finally
            con.Close()
        End Try

    End Sub

    Protected Sub btnDeleteReview_Click(sender As Object, e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_QCScore_Delete", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@QCID", SqlDbType.Int).Value = lblQCID.Text

        Try
            cmd.Connection = con
            Using con
                con.Open()
                cmd.Connection = con
                cmd.ExecuteNonQuery()
            End Using
            lblRecordStatus.Text = "Your QC Review Was Deleted"
        Finally
            con.Close()
        End Try
    End Sub
End Class
