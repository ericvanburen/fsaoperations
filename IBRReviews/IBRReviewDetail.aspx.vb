Imports System.Data
Imports System.Data.SqlClient

Partial Class IBRReviews_IBRReviewDetail
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim IBRReviewID As Integer
            If Not Request.QueryString("IBRReviewID") Is Nothing Then
                IBRReviewID = Request.QueryString("IBRReviewID")
            Else
                IBRReviewID = 0
            End If
            lblIBRReviewID2.Text = IBRReviewID.ToString()
            LoadForm(IBRReviewID)

            If Roles.IsUserInRole("IBRReviews_Admins") = True Then
                btnDelete.Visible = True
            Else
                btnDelete.Visible = False
            End If
        End If
    End Sub

    Sub LoadForm(ByVal IBRReviewID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IBRReviewID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@IBRReviewID", SqlDbType.Int).Value = IBRReviewID
        
        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    If Not dr("IBRReviewID") Is DBNull.Value Then
                        lblIBRReviewID.Text = dr("IBRReviewID").ToString()
                    End If

                    If Not dr("DateSubmitted") Is DBNull.Value Then
                        lblDateSubmitted.Text = Left(dr("DateSubmitted"), 10).ToString()
                    End If

                    If Not dr("UserID") Is DBNull.Value Then
                        lblUserID.Text = dr("UserID")
                    End If

                    If Not dr("BorrowerNumber") Is DBNull.Value Then
                        txtBorrowerNumber.Text = dr("BorrowerNumber").ToString()
                    End If

                    If Not dr("PCAID") Is DBNull.Value Then
                        ddlPCAID.SelectedValue = dr("PCAID")
                    End If

                    If Not dr("ReportQuarter") Is DBNull.Value Then
                        ddlReportQuarter.SelectedValue = dr("ReportQuarter").ToString()
                    End If

                    If Not dr("ReportYear") Is DBNull.Value Then
                        ddlReportYear.SelectedValue = dr("ReportYear").ToString()
                    End If

                    If Not dr("Agreement_Letter_Signed") Is DBNull.Value Then
                        ddlAgreement_Letter_Signed.SelectedValue = dr("Agreement_Letter_Signed").ToString()
                    End If

                    If Not dr("Agreement_Letter_Signed_Date") Is DBNull.Value Then
                        txtAgreement_Letter_Signed_Date.Text = dr("Agreement_Letter_Signed_Date").ToString()
                    End If

                    If Not dr("Financial_Documentation") Is DBNull.Value Then
                        ddlFinancial_Documentation.SelectedValue = dr("Financial_Documentation").ToString()
                    End If

                    If Not dr("Dependents") Is DBNull.Value Then
                        ddlDependents.SelectedValue = dr("Dependents").ToString()
                    End If

                    If Not dr("Income") Is DBNull.Value Then
                        txtIncome.Text = dr("Income").ToString()
                    End If

                    If Not dr("Repayment_Amount") Is DBNull.Value Then
                        ddlRepayment_Amount.SelectedValue = dr("Repayment_Amount")
                    End If

                    If Not dr("Tag") Is DBNull.Value Then
                        ddlTag.SelectedValue = dr("Tag")
                    End If

                    If Not dr("Comments") Is DBNull.Value Then
                        txtComments.Text = dr("Comments").ToString()
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

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateReview", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IBRReviewID", lblIBRReviewID.Text)
        cmd.Parameters.AddWithValue("@BorrowerNumber", txtBorrowerNumber.Text)
        cmd.Parameters.AddWithValue("@PCAID", ddlPCAID.SelectedValue)
        cmd.Parameters.AddWithValue("@ReportQuarter", ddlReportQuarter.SelectedValue)
        cmd.Parameters.AddWithValue("@ReportYear", ddlReportYear.SelectedValue)

        cmd.Parameters.AddWithValue("@Agreement_Letter_Signed", ddlAgreement_Letter_Signed.SelectedValue)
        cmd.Parameters.AddWithValue("@Agreement_Letter_Signed_Date", txtAgreement_Letter_Signed_Date.Text)
        cmd.Parameters.AddWithValue("@Financial_Documentation", ddlFinancial_Documentation.SelectedValue)
        cmd.Parameters.AddWithValue("@Dependents", ddlDependents.SelectedValue)
        cmd.Parameters.AddWithValue("@Income", txtIncome.Text)

        cmd.Parameters.AddWithValue("@Repayment_Amount", ddlRepayment_Amount.SelectedValue)
        cmd.Parameters.AddWithValue("@Tag", ddlTag.SelectedValue)

        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        Else
            cmd.Parameters.AddWithValue("@Comments", DBNull.Value)
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

            lblUpdateConfirm.Text = "Your review was successfully updated"

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteIBRReviewID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@IBRReviewID", SqlDbType.Int).Value = lblIBRReviewID.Text

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
