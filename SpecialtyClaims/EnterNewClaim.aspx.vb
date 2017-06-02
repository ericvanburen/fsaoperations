Imports System.Data
Imports System.Data.SqlClient

Partial Class SpecialtyClaims_UpdateSSN
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            btnUpdateAgain.Visible = False
            txtAccountNumber.Focus()
        End If
    End Sub

    Protected Sub btnUpdate_Click(sender As Object, e As System.EventArgs)

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim strLoanAnalyst As String = HttpContext.Current.User.Identity.Name

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertNewClaim", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@AccountNumber", txtAccountNumber.Text)
        cmd.Parameters.AddWithValue("@Servicer", ddlServicer.SelectedValue)
        cmd.Parameters.AddWithValue("@BorrowerName", txtBorrowerName.Text)
        cmd.Parameters.AddWithValue("@DischargeType", ddlDischargeType.SelectedValue)

        If txtDateReceived.Text <> "" Then
            cmd.Parameters.AddWithValue("@DateReceived", txtDateReceived.Text)
        Else
            cmd.Parameters.Add("@DateReceived", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtDateCompleted.Text <> "" Then
            cmd.Parameters.AddWithValue("@DateCompleted", txtDateCompleted.Text)
        Else
            cmd.Parameters.Add("@DateCompleted", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@Approve", chkApprove.Checked)
        cmd.Parameters.AddWithValue("@LoanAnalyst", strLoanAnalyst)
        cmd.Parameters.AddWithValue("@DateLoaded", Now.Date())
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblUpdateConfirm.Text = "Your claim was successfully submitted"
            btnUpdate.Visible = False
            btnUpdateAgain.Visible = True

        Finally
            strSQLConn.Close()
        End Try

    End Sub

    Protected Sub btnUpdateAgain_Click(sender As Object, e As System.EventArgs)
        Response.Redirect("EnterNewClaim.aspx")
    End Sub

    Protected Sub btnFindSSN_Click(sender As Object, e As EventArgs)

    End Sub
End Class
