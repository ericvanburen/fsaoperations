Imports System.Data
Imports System.Data.SqlClient

Partial Class Unconsolidation_AddRequest
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            Dim ClaimID As Integer
            If Not Request.QueryString("CLaimID") Is Nothing Then
                ClaimID = Request.QueryString("ClaimID")
            Else
                ClaimID = 0
            End If

            lblUserID.Text = HttpContext.Current.User.Identity.Name

            ddlQA_Analyst.DataSource = Roles.GetUsersInRole("Forgiveness")
            ddlQA_Analyst.DataBind()

            ddlUserID.DataSource = Roles.GetUsersInRole("Forgiveness")
            ddlUserID.DataBind()

            'Load data in the form
            LoadForm(ClaimID)

        End If
    End Sub

    Sub LoadForm(ByVal ClaimID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ForgivenessConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ClaimID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ClaimID", SqlDbType.Int).Value = ClaimID

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    If Not dr("ClaimID") Is DBNull.Value Then
                        lblClaimID.Text = dr("ClaimID").ToString()
                    End If

                    If Not dr("Borrower_Name") Is DBNull.Value Then
                        txtBorrower_Name.Text = dr("Borrower_Name").ToString()
                    End If

                    If Not dr("Account") Is DBNull.Value Then
                        txtAccount.Text = dr("Account").ToString()
                    End If

                    If Not dr("AwardID") Is DBNull.Value Then
                        txtAwardID.Text = dr("AwardID").ToString()
                    End If

                    If Not dr("SequenceNumber") Is DBNull.Value Then
                        txtSequenceNumber.Text = dr("SequenceNumber").ToString()
                    End If

                    If Not dr("ServicerID") Is DBNull.Value Then
                        ddlServicerID.SelectedValue = dr("ServicerID").ToString()
                    End If

                    If Not dr("Date_Received") Is DBNull.Value Then
                        txtDate_Received.Text = dr("Date_Received").ToString()
                    End If

                    If Not dr("FSA_Approved") Is DBNull.Value Then
                        ddlFSA_Approved.SelectedValue = dr("FSA_Approved").ToString()
                    End If

                    If Not dr("Decision_Date") Is DBNull.Value Then
                        txtDecision_Date.Text = dr("Decision_Date").ToString()
                    End If

                    If Not dr("Qualifying_Payments") Is DBNull.Value Then
                        txtQualifying_Payments.Text = dr("Qualifying_Payments").ToString()
                    End If

                    If Not dr("Claim_Type") Is DBNull.Value Then
                        ddlClaim_Type.SelectedValue = dr("Claim_Type").ToString()
                    End If
                    
                    If Not dr("Approval_Type") Is DBNull.Value Then
                        ddlApproval_Type.SelectedValue = dr("Approval_Type").ToString()
                    End If

                    If Not dr("Category_Program_Type_IDR") Is DBNull.Value Then
                        ddlCategory_Program_Type_IDR.SelectedValue = dr("Category_Program_Type_IDR").ToString()
                    End If

                    If Not dr("Outstanding_Principal") Is DBNull.Value Then
                        txtOutstanding_Principal.Text = dr("Outstanding_Principal").ToString()
                    End If

                    If Not dr("Outstanding_Interest") Is DBNull.Value Then
                        txtOutstanding_Interest.Text = dr("Outstanding_Interest").ToString()
                    End If

                    If Not dr("QA_Account") Is DBNull.Value Then
                        chkQA_Account.Checked = dr("QA_Account").ToString()
                    End If

                    If Not dr("QA_Analyst") Is DBNull.Value Then
                        ddlQA_Analyst.SelectedValue = dr("QA_Analyst").ToString()
                    End If

                    If Not dr("UserID") Is DBNull.Value Then
                        ddlUserID.SelectedValue = dr("UserID").ToString()
                    End If

                    If Not dr("Escalated") Is DBNull.Value Then
                        chkEscalated.Checked = dr("Escalated").ToString()
                    End If

                    If Not dr("IDR_Forgiveness_Date") Is DBNull.Value Then
                        txtIDR_Forgiveness_Date.Text = dr("IDR_Forgiveness_Date").ToString()
                    End If

                    If Not dr("Comments") Is DBNull.Value Then
                        txtComments.Text = dr("Comments").ToString()
                    End If

                    If Not dr("Resolution") Is DBNull.Value Then
                        txtResolution.Text = dr("Resolution").ToString()
                    End If

                    If Not dr("Comments") Is DBNull.Value Then
                        txtComments.Text = dr("Comments").ToString()
                    End If

                End While
            End Using

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub btnUpdateClaim_Click(sender As Object, e As EventArgs)

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ForgivenessConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateClaim", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ClaimID", lblClaimID.Text)
        cmd.Parameters.AddWithValue("@Borrower_Name", txtBorrower_Name.Text)
        cmd.Parameters.AddWithValue("@Account", txtAccount.Text)

        'If txtAwardID.Text <> "" Then
        '    cmd.Parameters.AddWithValue("@AwardID", SqlDbType.VarChar).Value = txtAwardID.Text
        'Else
        '    cmd.Parameters.Add("@AwardID", SqlDbType.VarChar).Value = DBNull.Value
        'End If

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
            lblRecordStatus.Text = "Your claim was successfully updated"

        Finally
            strSQLConn.Close()
        End Try
    End Sub


End Class
