Imports System.Data
Imports System.Data.SqlClient

Partial Class Unconsolidation_AddRequest
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            lblSubmittedBy.Text = HttpContext.Current.User.Identity.Name

            ddlQA_Analyst.DataSource = Roles.GetUsersInRole("Forgiveness")
            ddlQA_Analyst.DataBind()

            ddlUserID.DataSource = Roles.GetUsersInRole("Forgiveness")
            ddlUserID.DataBind()

            'Dim Decision_Date As Date = Date.Now.ToShortDateString()    ' Current date and time.
            txtDecision_Date.Text = Date.Now.ToShortDateString()

        End If
    End Sub

    Protected Sub btnAddClaim_Click(sender As Object, e As EventArgs)

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ForgivenessConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertNewClaim", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@SubmittedBy", lblSubmittedBy.Text)
        cmd.Parameters.AddWithValue("@Borrower_Name", txtBorrower_Name.Text)
        cmd.Parameters.AddWithValue("@Account", txtAccount.Text)

        If txtAwardID.Text <> "" Then
            cmd.Parameters.AddWithValue("@AwardID", SqlDbType.VarChar).Value = txtAwardID.Text
        Else
            cmd.Parameters.Add("@AwardID", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtSequenceNumber.Text <> "" Then
            cmd.Parameters.AddWithValue("@SequenceNumber", SqlDbType.VarChar).Value = txtSequenceNumber.Text
        Else
            cmd.Parameters.Add("@SequenceNumber", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@ServicerID", ddlServicerID.SelectedValue)
        cmd.Parameters.AddWithValue("@Date_Received", txtDate_Received.Text)

        If ddlFSA_Approved.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@FSA_Approved", SqlDbType.VarChar).Value = ddlFSA_Approved.SelectedValue
        Else
            cmd.Parameters.Add("@FSA_Approved", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtDecision_Date.Text <> "" Then
            cmd.Parameters.Add("@Decision_Date", SqlDbType.SmallDateTime).Value = txtDecision_Date.Text
        Else
            cmd.Parameters.Add("@Decision_Date", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtQualifying_Payments.Text <> "" Then
            cmd.Parameters.Add("@Qualifying_Payments", SqlDbType.Int).Value = txtQualifying_Payments.Text
        Else
            cmd.Parameters.Add("@Qualifying_Payments", SqlDbType.Int).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@Claim_Type", ddlClaim_Type.SelectedValue)

        If ddlApproval_Type.SelectedValue <> "" Then
            cmd.Parameters.Add("@Approval_Type", SqlDbType.VarChar).Value = ddlApproval_Type.SelectedValue
        Else
            cmd.Parameters.Add("@Approval_Type", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlCategory_Program_Type_IDR.SelectedValue <> "" Then
            cmd.Parameters.Add("@Category_Program_Type_IDR", SqlDbType.VarChar).Value = ddlCategory_Program_Type_IDR.SelectedValue
        Else
            cmd.Parameters.Add("@Category_Program_Type_IDR", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtOutstanding_Principal.Text <> "" Then
            cmd.Parameters.Add("@Outstanding_Principal", SqlDbType.SmallMoney).Value = txtOutstanding_Principal.Text
        Else
            cmd.Parameters.Add("@Outstanding_Principal", SqlDbType.SmallMoney).Value = DBNull.Value
        End If
       
        If txtOutstanding_Interest.Text <> "" Then
            cmd.Parameters.Add("@Outstanding_Interest", SqlDbType.SmallMoney).Value = txtOutstanding_Interest.Text
        Else
            cmd.Parameters.Add("@Outstanding_Interest", SqlDbType.SmallMoney).Value = DBNull.Value
        End If

        cmd.Parameters.Add("@QA_Account", SqlDbType.Bit).Value = chkQA_Account.Checked

        If ddlQA_Analyst.SelectedValue <> "" Then
            cmd.Parameters.Add("@QA_Analyst", SqlDbType.VarChar).Value = ddlQA_Analyst.SelectedValue
        Else
            cmd.Parameters.Add("@QA_Analyst", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Assigned To/UserID
        If ddlUserID.SelectedValue <> "" Then
            cmd.Parameters.Add("UserID", SqlDbType.VarChar).Value = ddlUserID.SelectedValue
        Else
            cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.Add("@Escalated", SqlDbType.Bit).Value = chkEscalated.Checked

        If txtIDR_Forgiveness_Date.Text <> "" Then
            cmd.Parameters.Add("@IDR_Forgiveness_Date", SqlDbType.SmallDateTime).Value = txtIDR_Forgiveness_Date.Text
        Else
            cmd.Parameters.Add("@IDR_Forgiveness_Date", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If txtResolution.Text <> "" Then
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = txtResolution.Text
        Else
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtComments.Text <> "" Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If


        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your claim was successfully submitted."

            btnAddClaim.Visible = False
            btnAddAnotherClaim.Visible = True

        Finally
            strSQLConn.Close()
        End Try
    End Sub


    Protected Sub btnAddAnotherClaim_Click(sender As Object, e As EventArgs)
        Response.Redirect("AddClaim.aspx")
    End Sub
End Class
