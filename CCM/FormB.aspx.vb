Imports System.Data
Imports System.Data.SqlClient
Imports CallHistory

Partial Class CCM_New_FormB
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            lblUserID.Text = HttpContext.Current.User.Identity.Name

            txtDateofReview.Text = Today()
            lblRecordStatus.Text = ""

            'Grab the previously submitted CallCenterID, if any
            If Not Request.QueryString("CallCenterID") Is Nothing Then
                Dim strCallCenterID As String = Request.QueryString("CallCenterID")
                ddlCallCenterID.SelectedValue = strCallCenterID.ToString()
                ddlIssue1.Items.Clear()
                ddlIssue2.Items.Clear()
                ddlIssue3.Items.Clear()
                CallCenterFunction_Lookup(CInt(strCallCenterID))
            End If

            'Set the form focus to Call Center Location to get ready for the first call
            ddlCallCenterID.Focus()
        End If

    End Sub

    Protected Sub btnTimeofReview_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        txtTimeofReview.Text = Now.ToShortTimeString()
        txtTimeofReview.Focus()
    End Sub

    'Protected Sub btnEndTimeofReview_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
    '    txtEndTimeofReview.Text = Now.ToShortTimeString
    '    txtEndTimeofReview.Focus()
    'End Sub

    Sub btnAddCall_Click(ByVal sender As Object, ByVal e As EventArgs)

        lblPassFailServerSide.Text = lblPassFailHidden.Value
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddCall_FormB", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        cmd.Parameters.AddWithValue("@AgentID", txtAgentID.Text)
        cmd.Parameters.AddWithValue("@CallID", txtCallID.Text)
        cmd.Parameters.AddWithValue("@DateofReview", txtDateofReview.Text)
        cmd.Parameters.AddWithValue("@TimeofReview", txtTimeofReview.Text)
        cmd.Parameters.AddWithValue("@EndTimeofReview", Now.ToShortTimeString)
        cmd.Parameters.AddWithValue("@BorrowerAccountNumber", txtBorrowerAccountNumber.Text)
        cmd.Parameters.AddWithValue("@InboundOutbound", ddlInboundOutbound.SelectedValue)
        cmd.Parameters.AddWithValue("@Issue1", ddlIssue1.SelectedValue)
        cmd.Parameters.AddWithValue("@Issue2", ddlIssue2.SelectedValue)
        cmd.Parameters.AddWithValue("@Issue3", ddlIssue3.SelectedValue)
        cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        cmd.Parameters.AddWithValue("@EscalationIssue", chkEscalationIssue.Checked)
        cmd.Parameters.AddWithValue("@Concern1", ddlConcern1.SelectedValue)
        cmd.Parameters.AddWithValue("@Concern2", ddlConcern2.SelectedValue)
        cmd.Parameters.AddWithValue("@Concern3", ddlConcern3.SelectedValue)
        cmd.Parameters.AddWithValue("@G_Name", chkGName.Checked)
        cmd.Parameters.AddWithValue("@G_Clear", chkGClear.Checked)
        cmd.Parameters.AddWithValue("@G_Tone", chkGTone.Checked)
        cmd.Parameters.AddWithValue("@G_Prompt", chkGPrompt.Checked)
        cmd.Parameters.AddWithValue("@V_Name", chkVName.Checked)
        cmd.Parameters.AddWithValue("@V_SSN", chkVSSN.Checked)
        cmd.Parameters.AddWithValue("@V_Adrs", chkVAdrs.Checked)
        cmd.Parameters.AddWithValue("@V_Phon1", chkVPhon1.Checked)
        cmd.Parameters.AddWithValue("@V_Phon2", chkVPhon2.Checked)
        cmd.Parameters.AddWithValue("@V_Email", chkVEmail.Checked)
        cmd.Parameters.AddWithValue("@V_DOB", chkVDOB.Checked)
        cmd.Parameters.AddWithValue("@L_Interrupt", chkLInterrupt.Checked)
        cmd.Parameters.AddWithValue("@L_NoRepeat", chkLNoRepeat.Checked)
        cmd.Parameters.AddWithValue("@BC_Counseling", chkBCCounseling.Checked)
        cmd.Parameters.AddWithValue("@S_Clarity", SqlDbType.Bit).Value = 0
        cmd.Parameters.AddWithValue("@S_Accuracy", chkSAccuracy.Checked)
        cmd.Parameters.AddWithValue("@S_Explanation", SqlDbType.Bit).Value = 0
        cmd.Parameters.AddWithValue("@Accuracy1", chkAccuracy1.Checked)
        cmd.Parameters.AddWithValue("@Accuracy2", chkAccuracy2.Checked)
        cmd.Parameters.AddWithValue("@Accuracy3", chkAccuracy3.Checked)
        cmd.Parameters.AddWithValue("@E_Pleasant", chkEPleasant.Checked)
        cmd.Parameters.AddWithValue("@E_NonConfrontational", chkENonConfrontational.Checked)
        cmd.Parameters.AddWithValue("@E_Timeliness", chkETimeliness.Checked)
        cmd.Parameters.AddWithValue("@C_AllQuestions", chkCAllQuestions.Checked)
        cmd.Parameters.AddWithValue("@C_Recapped", chkCRecapped.Checked)
        'Check on OverallScore field
        If lblPassFailServerSide.Text = "FAIL" Then
            cmd.Parameters.AddWithValue("@OverallScore", SqlDbType.Bit).Value = 0
        Else
            cmd.Parameters.AddWithValue("@OverallScore", SqlDbType.Bit).Value = 1
        End If
        cmd.Parameters.AddWithValue("@RecordAdded", Today())
        'Check on TimeStamp field
        cmd.Parameters.AddWithValue("@TimeStamp", SqlDbType.VarChar).Value = "40862.3239236111"
        cmd.Parameters.AddWithValue("@Form", SqlDbType.VarChar).Value = "B"
        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            Dim ReviewID As String = cmd.Parameters("@ReviewID").Value.ToString()
            lblRecordStatus.Text = "Your record was successfully added.  Your Review ID is " & ReviewID.ToString()
            btnAddCall.Visible = False
            btnAddAnotherCall.Visible = True
            'Catch ex As Exception

            'Set the call center dropdown list to the previously value submitted to save the user an extra step
            'lblCallCenterID.Text = ddlCallCenterID.SelectedValue

            'Add the call to the CallHistory table
            Dim newCallHistory As New CallHistory
            newCallHistory.ReviewID = ReviewID
            newCallHistory.UserID = lblUserID.Text
            newCallHistory.EventName = "Call Added"

            'Add new record to CallHistory table
            newCallHistory.AddCallHistory(ReviewID, lblUserID.Text, "Call Added")

        Finally
            strSQLConn.Close()
        End Try

        'Rebind the page
        Page.DataBind()

    End Sub

    Sub btnAddanotherCall_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("FormB.aspx?CallCenterID=" & ddlCallCenterID.SelectedValue)
    End Sub

    
    Protected Sub ddlIssue1_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        If ddlIssue1.SelectedValue <> "" Then
            chkAccuracy1.Checked = True
        Else
            chkAccuracy1.Checked = False
        End If
    End Sub

    Protected Sub ddlIssue2_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        If ddlIssue2.SelectedValue <> "" Then
            chkAccuracy2.Checked = True
        Else
            chkAccuracy2.Checked = False
        End If
    End Sub

    Protected Sub ddlIssue3_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        If ddlIssue3.SelectedValue <> "" Then
            chkAccuracy3.Checked = True
        Else
            chkAccuracy3.Checked = False
        End If
    End Sub

    Protected Sub ddlCallCenterID_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        ddlIssue1.Items.Clear()
        ddlIssue2.Items.Clear()
        ddlIssue3.Items.Clear()
        CallCenterFunction_Lookup()
    End Sub

    Protected Sub CallCenterFunction_Lookup(Optional ByVal CallCenterID As Integer = 0)
        'This looks up the CallCenterFunction value from the CallCenters table based on the selected CallCenterID value
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim strCallCenterFunction As String = ""

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CallCenterFunction_Lookup", con)
        cmd.CommandType = CommandType.StoredProcedure
        If CallCenterID > 0 Then
            cmd.Parameters.AddWithValue("@CallCenterID", CallCenterID)
        Else
            cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        End If

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()

                While dr.Read()
                    strCallCenterFunction = dr("CallCenterFunction").ToString()
                    lblCallCenterFunction.Text = strCallCenterFunction
                End While
            End Using

            'Change the Account No/NSLDS value
            If strCallCenterFunction = "NSLDS" Then
                lblAcctNSLDS.Text = "NSLDS ID:"
            Else
                lblAcctNSLDS.Text = "Account No:"
            End If

            dsReasonCode.SelectParameters.Item("CallCenterFunction").DefaultValue = strCallCenterFunction.ToString()
            dsReasonCode.DataBind()

            ddlIssue1.DataBind()
            ddlIssue1.Items.Insert(0, "")
            ddlIssue1.SelectedIndex = 0

            ddlIssue2.DataBind()
            ddlIssue2.Items.Insert(0, "")
            ddlIssue2.SelectedIndex = 0

            ddlIssue3.DataBind()
            ddlIssue3.Items.Insert(0, "")
            ddlIssue3.SelectedIndex = 0

            UpdatePanel2.Update()

            'set the form focus to Begin Time of Review
            txtTimeofReview.Focus()
        Finally
            dr.Close()
            con.Close()
        End Try
    End Sub

End Class
