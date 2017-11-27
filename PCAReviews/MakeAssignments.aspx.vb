Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_Assignments_PCAReviews
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCAReviews_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            ddlUserID.DataSource = Roles.GetUsersInRole("PCAReviews")
            ddlUserID.DataBind()
        End If
    End Sub

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCAReviews_Assignments_Insert", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = ddlUserID.SelectedValue
        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@RecordingDeliveryDate", SqlDbType.SmallDateTime).Value = txtRecordingDeliveryDate.Text
        cmd.Parameters.Add("@CallReviewDueDate", SqlDbType.SmallDateTime).Value = txtCallReviewDueDate.Text

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

        cmd.Parameters.Add("@Assignor", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblUpdateConfirm.Text = "Your assignment was successfully submitted"
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
