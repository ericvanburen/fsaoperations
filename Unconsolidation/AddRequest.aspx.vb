Imports System.Data
Imports System.Data.SqlClient

Partial Class Unconsolidation_AddRequest
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            'Assign the issue to the person logged in by default
            'If User.Identity.IsAuthenticated Then
            'ddlUserID.SelectedValue = User.Identity.Name
            'End If

            'Set the Date Received field to current date + 1
            'Dim DateReceived As Date = Date.Now.ToShortDateString()    ' Current date and time.
            ''txtDateReceived.Text = DateReceived.AddDays(1)  ' Increment by 1 days.
            'txtDateReceived.Text = Date.Now.ToShortDateString()

        End If
    End Sub

    Protected Sub btnAddRequest_Click(sender As Object, e As EventArgs)

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("UnconsolidationConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertNewRequest", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@Borrower_Name", txtBorrower_Name.Text)
        cmd.Parameters.AddWithValue("@Account", txtAccount.Text)
        cmd.Parameters.AddWithValue("@Underlying_Servicer", txtUnderlying_Servicer.Text)
        cmd.Parameters.AddWithValue("@Current_ServicerID", ddlCurrent_ServicerID.SelectedValue)
        cmd.Parameters.AddWithValue("@Consolidation_Date", txtConsolidation_Date.Text)
        cmd.Parameters.AddWithValue("@Underlying_Loan_Type", txtUnderlying_Loan_Type.Text)
        cmd.Parameters.AddWithValue("@Underlying_Loan_ID", txtUnderlying_Loan_ID.Text)
        cmd.Parameters.AddWithValue("@Reason_For_Unconsolidation_Request", txtReason_For_Unconsolidation_Request.Text)

        If ddlRequestor.SelectedValue <> "" Then
            cmd.Parameters.Add("@Requestor", SqlDbType.VarChar).Value = ddlRequestor.SelectedValue
        Else
            cmd.Parameters.Add("@Requestor", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtFSA_Response.Text <> "" Then
            cmd.Parameters.Add("@FSA_Response", SqlDbType.VarChar).Value = txtFSA_Response.Text
        Else
            cmd.Parameters.Add("@FSA_Response", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtServicer_Response.Text <> "" Then
            cmd.Parameters.Add("@Servicer_Response", SqlDbType.VarChar).Value = txtServicer_Response.Text
        Else
            cmd.Parameters.Add("@Servicer_Response", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@FSA_Approved", ddlFSA_Approved.SelectedValue)

        If txtFSA_Decision_Criteria.Text <> "" Then
            cmd.Parameters.Add("@FSA_Decision_Criteria", SqlDbType.VarChar).Value = txtFSA_Decision_Criteria.Text
        Else
            cmd.Parameters.Add("@FSA_Decision_Criteria", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtDecision_Date.Text <> "" Then
            cmd.Parameters.Add("@Decision_Date", SqlDbType.SmallDateTime).Value = txtDecision_Date.Text
        Else
            cmd.Parameters.Add("@Decision_Date", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@UserID", User.Identity.Name.ToString())
       
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your request was successfully submitted."

            btnAddRequest.Visible = False
            btnAddAnotherRequest.Visible = True

        Finally
            strSQLConn.Close()
        End Try
    End Sub


    Protected Sub btnAddAnotherRequest_Click(sender As Object, e As EventArgs)
        Response.Redirect("AddRequest.aspx")
    End Sub
End Class
