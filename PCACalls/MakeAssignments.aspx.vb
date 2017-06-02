Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_Assignments_PCACalls
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCACalls_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            ddlUserID.DataSource = Roles.GetUsersInRole("PCACalls")
            ddlUserID.DataBind()
        End If
    End Sub

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCACalls_Assignments_Insert", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewType", SqlDbType.VarChar).Value = ddlReviewType.SelectedValue
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

    'Protected Sub ddlReviewDate_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    ddlPCAID.Items.Clear()
    '    dsPCAs.SelectParameters("ReviewDate").DefaultValue = ddlReviewDate.SelectedValue
    'End Sub
End Class
