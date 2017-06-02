Imports System.Data
Imports System.Data.SqlClient

Partial Class IBRReviews_MakeAssignments
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("IBRReviews_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            ddlUserID.DataSource = Roles.GetUsersInRole("IBRReviews")
            ddlUserID.DataBind()
        End If
    End Sub

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IBRReviews_Assignments_Insert", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = ddlUserID.SelectedValue
        cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = txtRecordingDeliveryDate.Text

        If txtReviewDate.Text <> "" Then
            cmd.Parameters.Add("@ReviewDate", SqlDbType.SmallDateTime).Value = txtReviewDate.Text
        Else
            cmd.Parameters.Add("@ReviewDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If ddlReportQuarter.SelectedValue <> "" Then
            cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = ddlReportQuarter.SelectedValue
        Else
            cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlReportYear.SelectedValue <> "" Then
            cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = ddlReportYear.SelectedValue
        Else
            cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblUpdateConfirm.Text = "Your assignments were successfully submitted"
            btnSubmit.Visible = False
            btnUpdateAgain.Visible = True

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnSubmitAgain_Click(sender As Object, e As System.EventArgs)
        Response.Redirect("MakeAssignments.aspx")
    End Sub


End Class
