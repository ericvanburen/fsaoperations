Imports System.Data
Imports System.Data.SqlClient
Imports CallHistory

Partial Class CCM_New_FormBDetail
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            Dim blnAdmin As Boolean

            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name

            'Delete call button is visible only to those in the CCM_Admin group
            'Date of Review is enabled only to those in the CCM_Admin group
            If Roles.IsUserInRole("CCM_Admins") = True Then
                btnDeleteCall.Visible = True
                blnAdmin = True
            Else
                btnDeleteCall.Visible = False
                blnAdmin = False
            End If

            Dim DateofReview As TextBox
            Dim CallCenterID As DropDownList
            Dim TimeofReview As TextBox
            Dim EndTimeofReview As TextBox
            Dim dataItem As RepeaterItem
            For Each dataItem In Repeater1.Items
                DateofReview = CType(dataItem.FindControl("txtDateofReview"), TextBox)
                CallCenterID = CType(dataItem.FindControl("ddlCallCenterID"), DropDownList)
                TimeofReview = CType(dataItem.FindControl("txtTimeofReview"), TextBox)
                EndTimeofReview = CType(dataItem.FindControl("txtEndTimeofReview"), TextBox)
                If blnAdmin = True Then
                    DateofReview.Enabled = True
                    CallCenterID.Enabled = True
                    TimeofReview.Enabled = True
                    EndTimeofReview.Enabled = True
                Else
                    DateofReview.Enabled = False
                    CallCenterID.Enabled = False
                    TimeofReview.Enabled = False
                    EndTimeofReview.Enabled = False
                End If
            Next

            Dim intReviewID = Request.QueryString("ReviewID")
            lblReviewID2.Text = intReviewID.ToString()

            'Set the overall pass/fail value
            lblPassFailHidden.Value = GetPassFail(intReviewID)
            lblPassFailServerSide.Text = GetPassFail(intReviewID)

            'Bind the form with all values
            BindForm(intReviewID)
            
        End If
    End Sub

    Protected Sub btnTimeofReview_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        txtTimeofReview.Text = Now.ToShortTimeString()
        txtTimeofReview.Focus()
    End Sub

    Protected Sub btnEndTimeofReview_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        txtEndTimeofReview.Text = Now.ToShortTimeString
        txtEndTimeofReview.Focus()
    End Sub


    Sub BindForm(ByVal ReviewID As Integer)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim da As SqlDataAdapter
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_BindCall_FormB", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ReviewID", ReviewID)
        da = New SqlDataAdapter(cmd)
        strSQLConn.Open()
        ds = New DataSet()
        da.Fill(ds)

        Repeater1.DataSource = ds
        Repeater1.DataBind()

        'Set the form focus to Call Center Location to get ready for the first call
        ddlCallCenterID.Focus()
    End Sub

    Public Shared Function GetPassFail(ByVal ReviewID As Integer) As String
        Dim result As String = String.Empty
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("p_getPassFail", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ReviewID", ReviewID)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                result = CType(reader("OverallScore"), String)
            End If
        End Using
        Return result
    End Function

    Sub btnUpdateCall_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim CallCenterID As Integer
        Dim AgentID As String = ""
        Dim CallID As String = ""
        Dim DateofReview As String = ""
        Dim TimeofReview As String = ""
        Dim EndTimeofReview As String = ""
        Dim BorrowerAccountNumber As String = ""
        Dim InboundOutbound As String = ""
        Dim Issue1 As Integer
        Dim Issue2 As Integer
        Dim Issue3 As Integer
        Dim Comments As String = ""
        Dim EscalationIssue As Boolean
        Dim Concern1 As Integer
        Dim Concern2 As Integer
        Dim Concern3 As Integer
        Dim GName As Boolean
        Dim GClear As Boolean
        Dim GTone As Boolean
        Dim GPrompt As Boolean
        Dim VName As Boolean
        Dim VSSN As Boolean
        Dim VAdrs As Boolean
        Dim VPhon1 As Boolean
        Dim VPhon2 As Boolean
        Dim VEmail As Boolean
        Dim VDOB As Boolean
        Dim LInterrupt As Boolean
        Dim LNoRepeat As Boolean
        Dim BCCounseling As Boolean
        Dim SAccuracy As Boolean
        Dim Accuracy1 As Boolean
        Dim Accuracy2 As Boolean
        Dim Accuracy3 As Boolean
        Dim EPleasant As Boolean
        Dim ENonConfrontational As Boolean
        Dim ETimeliness As Boolean
        Dim CAllQuestions As Boolean
        Dim CRecapped As Boolean
        Dim RecordStatus As String = ""

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
            CallCenterID = CType(dataItem.FindControl("ddlCallCenterID"), DropDownList).SelectedValue
            AgentID = CType(dataItem.FindControl("txtAgentID"), TextBox).Text
            CallID = CType(dataItem.FindControl("txtCallID"), TextBox).Text
            DateofReview = CType(dataItem.FindControl("txtDateofReview"), TextBox).Text
            TimeofReview = CType(dataItem.FindControl("txtTimeofReview"), TextBox).Text
            EndTimeofReview = CType(dataItem.FindControl("txtEndTimeofReview"), TextBox).Text
            BorrowerAccountNumber = CType(dataItem.FindControl("txtBorrowerAccountNumber"), TextBox).Text
            InboundOutbound = CType(dataItem.FindControl("ddlInboundOutbound"), DropDownList).SelectedValue
            Issue1 = CType(dataItem.FindControl("ddlIssue1"), DropDownList).SelectedValue
            Issue2 = CType(dataItem.FindControl("ddlIssue2"), DropDownList).SelectedValue
            Issue3 = CType(dataItem.FindControl("ddlIssue3"), DropDownList).SelectedValue
            Comments = CType(dataItem.FindControl("txtComments"), TextBox).Text
            EscalationIssue = CType(dataItem.FindControl("chkEscalationIssue"), CheckBox).Checked
            Concern1 = CType(dataItem.FindControl("ddlConcern1"), DropDownList).SelectedValue
            Concern2 = CType(dataItem.FindControl("ddlConcern2"), DropDownList).SelectedValue
            Concern3 = CType(dataItem.FindControl("ddlConcern3"), DropDownList).SelectedValue
            GName = CType(dataItem.FindControl("chkGName"), CheckBox).Checked
            GClear = CType(dataItem.FindControl("chkGClear"), CheckBox).Checked
            GTone = CType(dataItem.FindControl("chkGTone"), CheckBox).Checked
            GPrompt = CType(dataItem.FindControl("chkGPrompt"), CheckBox).Checked
            VName = CType(dataItem.FindControl("chkVName"), CheckBox).Checked
            VSSN = CType(dataItem.FindControl("chkVSSN"), CheckBox).Checked
            VAdrs = CType(dataItem.FindControl("chkVAdrs"), CheckBox).Checked
            VPhon1 = CType(dataItem.FindControl("chkVPhon1"), CheckBox).Checked
            VPhon2 = CType(dataItem.FindControl("chkVPhon2"), CheckBox).Checked
            VEmail = CType(dataItem.FindControl("chkVEmail"), CheckBox).Checked
            VDOB = CType(dataItem.FindControl("chkVDOB"), CheckBox).Checked
            LInterrupt = CType(dataItem.FindControl("chkLInterrupt"), CheckBox).Checked
            LNoRepeat = CType(dataItem.FindControl("chkLNoRepeat"), CheckBox).Checked
            BCCounseling = CType(dataItem.FindControl("chkBCCounseling"), CheckBox).Checked
            SAccuracy = CType(dataItem.FindControl("chkSAccuracy"), CheckBox).Checked
            Accuracy1 = CType(dataItem.FindControl("chkAccuracy1"), CheckBox).Checked
            Accuracy2 = CType(dataItem.FindControl("chkAccuracy2"), CheckBox).Checked
            Accuracy3 = CType(dataItem.FindControl("chkAccuracy3"), CheckBox).Checked
            EPleasant = CType(dataItem.FindControl("chkEPleasant"), CheckBox).Checked
            ENonConfrontational = CType(dataItem.FindControl("chkENonConfrontational"), CheckBox).Checked
            ETimeliness = CType(dataItem.FindControl("chkETimeliness"), CheckBox).Checked
            CAllQuestions = CType(dataItem.FindControl("chkCAllQuestions"), CheckBox).Checked
            CRecapped = CType(dataItem.FindControl("chkCRecapped"), CheckBox).Checked
        Next

        lblPassFailServerSide.Text = lblPassFailHidden.Value
        'Page.ClientScript.RegisterStartupScript(Type.GetType("System.String"), "addScript", "calculateScore()", True)

        'Page.ClientScript("calculateScore()", "JScript");

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateCall_FormB", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@CallCenterID", CallCenterID)
        cmd.Parameters.AddWithValue("@AgentID", AgentID)
        cmd.Parameters.AddWithValue("@CallID", CallID)
        cmd.Parameters.AddWithValue("@DateofReview", DateofReview)
        cmd.Parameters.AddWithValue("@TimeofReview", TimeofReview)
        cmd.Parameters.AddWithValue("@EndTimeofReview", EndTimeofReview)
        cmd.Parameters.AddWithValue("@BorrowerAccountNumber", BorrowerAccountNumber)
        cmd.Parameters.AddWithValue("@InboundOutbound", InboundOutbound)
        cmd.Parameters.AddWithValue("@Issue1", Issue1)
        cmd.Parameters.AddWithValue("@Issue2", Issue2)
        cmd.Parameters.AddWithValue("@Issue3", Issue3)
        cmd.Parameters.AddWithValue("@Comments", Comments)
        cmd.Parameters.AddWithValue("@EscalationIssue", EscalationIssue)
        cmd.Parameters.AddWithValue("@Concern1", Concern1)
        cmd.Parameters.AddWithValue("@Concern2", Concern2)
        cmd.Parameters.AddWithValue("@Concern3", Concern3)
        cmd.Parameters.AddWithValue("@G_Name", GName)
        cmd.Parameters.AddWithValue("@G_Clear", GClear)
        cmd.Parameters.AddWithValue("@G_Tone", GTone)
        cmd.Parameters.AddWithValue("@G_Prompt", GPrompt)
        cmd.Parameters.AddWithValue("@V_Name", VName)
        cmd.Parameters.AddWithValue("@V_SSN", VSSN)
        cmd.Parameters.AddWithValue("@V_Adrs", VAdrs)
        cmd.Parameters.AddWithValue("@V_Phon1", VPhon1)
        cmd.Parameters.AddWithValue("@V_Phon2", VPhon2)
        cmd.Parameters.AddWithValue("@V_Email", VEmail)
        cmd.Parameters.AddWithValue("@V_DOB", VDOB)
        cmd.Parameters.AddWithValue("@L_Interrupt", LInterrupt)
        cmd.Parameters.AddWithValue("@L_NoRepeat", LNoRepeat)
        cmd.Parameters.AddWithValue("@BC_Counseling", BCCounseling)
        'Check on these 3 S fields
        cmd.Parameters.AddWithValue("@S_Clarity", SqlDbType.Bit).Value = 0
        cmd.Parameters.AddWithValue("@S_Accuracy", SAccuracy)
        cmd.Parameters.AddWithValue("@S_Explanation", SqlDbType.Bit).Value = 0
        cmd.Parameters.AddWithValue("@Accuracy1", Accuracy1)
        cmd.Parameters.AddWithValue("@Accuracy2", Accuracy2)
        cmd.Parameters.AddWithValue("@Accuracy3", Accuracy3)
        cmd.Parameters.AddWithValue("@E_Pleasant", EPleasant)
        cmd.Parameters.AddWithValue("@E_NonConfrontational", ENonConfrontational)
        cmd.Parameters.AddWithValue("@E_Timeliness", ETimeliness)
        cmd.Parameters.AddWithValue("@C_AllQuestions", CAllQuestions)
        cmd.Parameters.AddWithValue("@C_Recapped", CRecapped)
        cmd.Parameters.AddWithValue("@ReviewID", lblReviewID2.Text)
        'Check on OverallScore field
        If lblPassFailServerSide.Text = "FAIL" Then
            cmd.Parameters.AddWithValue("@OverallScore", SqlDbType.Bit).Value = 0
        Else
            cmd.Parameters.AddWithValue("@OverallScore", SqlDbType.Bit).Value = 1
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your record was successfully updated"
            'Catch ex As Exception

            'Add the call to the CallHistory table
            Dim newCallHistory As New CallHistory
            newCallHistory.AddCallHistory(lblReviewID.Text, lblUserID.Text, "Call Updated")

            'Update Call History table
            GridView1.DataBind()

            'Set the form focus to Begin Time of Review
            txtTimeofReview.Focus()

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    

    Sub btnDeleteCall_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteCall", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ReviewID", lblReviewID2.Text)
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your record was successfully deleted"
        Catch ex As Exception
            lblRecordStatus.Text = "An error occurred while deleting this record"
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub chkEscalationIssue_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'If chkEscalationIssue.Checked = True Then
        '    rfdComments.Enabled = True
        'Else
        '    rfdComments.Enabled = False
        'End If        
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        lblRecordStatus.Text = ""
    End Sub

    Protected Sub Repeater1_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        Dim lblPassFail As Label = e.Item.FindControl("lblPassFail")
        If Not e.Item.FindControl("lblPassFail") Is Nothing Then
            lblPassFail.Text = GetPassFail(lblReviewID2.Text)
        End If
    End Sub

    Protected Function CaseConvert(obj As Object) As String
        Return obj.ToString().ToLower()
    End Function

  
End Class
