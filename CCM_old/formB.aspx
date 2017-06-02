<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CallHistory" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            
            'First check for a valid, logged in user
            Dim chkLogin As New CheckLogin
            lblUserID.Text = chkLogin.CheckLogin()
            
            txtDateofReview.Text = Today()
            lblRecordStatus.Text = ""
                                    
            'Grab the previously submitted CallCenterID, if any
            If Not Request.QueryString("CallCenterID") Is Nothing Then
                Dim strCallCenterID As String = Request.QueryString("CallCenterID")
                ddlCallCenterID.SelectedValue = strCallCenterID.ToString()
            End If
            
        End If
    End Sub

    Protected Sub btnTimeofReview_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        'txtTimeofReview.Text = Now.ToShortTimeString
        txtTimeofReview.Text = Now()
    End Sub
    
    Protected Sub btnEndTimeofReview_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        'txtEndTimeofReview.Text = Now.ToShortTimeString
        txtEndTimeofReview.Text = Now()
    End Sub
    
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
        cmd.Parameters.AddWithValue("@DateofReview", txtDateofReview.Text)
        cmd.Parameters.AddWithValue("@TimeofReview", txtTimeofReview.Text)
        cmd.Parameters.AddWithValue("@EndTimeofReview", txtEndTimeofReview.Text)
        cmd.Parameters.AddWithValue("@BorrowerAccountNumber", txtBorrowerAccountNumber.Text)
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
        'Check on these 3 S fields
        cmd.Parameters.AddWithValue("@S_Clarity", SqlDbType.Bit).Value = 0
        cmd.Parameters.AddWithValue("@S_Accuracy", SqlDbType.Bit).Value = 1
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
            'Catch ex As Exception
            
            'Set the call center dropdown list to the previously value submitted to save the user an extra step
            lblCallCenterID.Text = ddlCallCenterID.SelectedValue
            
            'Add the call to the CallHistory table
            Dim newCallHistory As New CallHistory
            newCallHistory.ReviewID = ReviewID
            newCallHistory.UserID = lblUserID.Text
            newCallHistory.EventName = "Call Added"
                       
            'Add new record to CallHistory table
            newCallHistory.AddCallHistory(ReviewID, lblUserID.Text, "Call Added")
            
            'Clear the form
            txtDateofReview.Text = ""
            txtTimeofReview.Text = ""
            txtEndTimeofReview.Text = ""
            txtAgentID.Text = ""
            txtBorrowerAccountNumber.Text = ""
            txtComments.Text = ""
            ddlIssue1.SelectedValue = ""
            ddlIssue2.SelectedValue = ""
            ddlIssue3.SelectedValue = ""
            chkAccuracy1.Checked = False
            chkAccuracy2.Checked = False
            chkAccuracy3.Checked = False
            ddlConcern1.SelectedValue = "0"
            ddlConcern2.SelectedValue = "0"
            ddlConcern3.SelectedValue = "0"
                                   
        Finally
            strSQLConn.Close()
        End Try
                
        'Rebind the page
        Page.DataBind()
               
    End Sub
    
    Protected Sub chkEscalationIssue_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkEscalationIssue.Checked = True Then
            rfdComments.Enabled = True
        Else
            rfdComments.Enabled = False
        End If
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

    Protected Sub CallCenterFunction_Lookup()
        
        'This looks up the CallCenterFunction value from the CallCenters table based on the selected CallCenterID value
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim strCallCenterFunction As String = ""
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CallCenterFunction_Lookup", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        
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
        Finally
            dr.Close()
            con.Close()
        End Try
    End Sub
    
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        lblRecordStatus.Text = ""
    End Sub
   

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Monitoring Form</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
       <script src="Scripts/menu.js" type="text/javascript"></script>
        
        <script type="text/javascript">
            $(function () {
                $("#tabs").tabs();
            });
	</script>	
        <script type="text/javascript">
            $(function () {
                var total;
                var checked = $(".Score1 input[type='checkbox']").click(function (e) {
                    calculateScore();
                });

                var checked = $(".Score2 input[type='checkbox']").click(function (e) {
                    calculateScore();
                });

                var checked = $(".Score4 input[type='checkbox']").click(function (e) {
                    calculateScore();
                });

                function calculateScore() {
                    var $checked1 = $(".Score1 :checkbox:not(:checked)")
                    total = 0;
                    $checked1.each(function () {
                        total += 1
                    });

                    // Now calculate the two pointers                    
                    var $checked2 = $(".Score2 :checkbox:not(:checked)")
                    $checked2.each(function () {
                        total += 2
                    });

                    // Now calculate the four pointers                    
                    var $checked4 = $(".Score4 :checkbox:not(:checked)")
                    $checked4.each(function () {
                        total += 4
                    });

                    $('#total').text("Points deducted: " + total);

                    var passFail = $("#lblPassFail");
                    if (total >= 4) {
                        passFail.text("FAIL");
                        setHiddenPassFail("FAIL");
                    } else {
                        passFail.text("PASS");
                        setHiddenPassFail("PASS");
                    }
                }
            });

            function setHiddenPassFail(passfail) {
                var passFail = $("#lblPassFail");
                 var passFailHidden = '<%= lblPassFailHidden.ClientID %>';
                // place the selected pass/fail values in the label control lblPassFailHidden
                 passFail.text(passfail);
                 document.getElementById(passFailHidden).value = passfail;
            };    

</script>

<script type="text/javascript" language="javascript">
   function printCall() {
        javascript:window.print();
    };
</script>

</head>
<body onload="setHiddenPassFail()">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
         
    <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		               <img src="images/fSA_logo.png" alt="Federal Student Aid - Call Center Monitoring" />
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Call Monitoring Form</a></li>                                
                            </ul>
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="logout.aspx">Log Out</a></li> 
                                    <li><a href="#">Reports</a>
                                    <ul>
                                       <li><a href="report.calls.monitored.aspx">Calls Monitored</a></li> 
                                       <li><a href="report.failed.calls.aspx">Failed Calls</a></li>
                                       <li><a href="report.accuracy.report.aspx">Accuracy Report</a></li>
                                    </ul>
                                    </li>                                                          
                                    <li><a href="search.aspx">Search</a></li>
                                 <li><a href="#">Administration</a>
                                <ul>
                                    <li><a href="admin/call.centers.aspx">Call Centers</a></li>
                                    <li><a href="admin/call.reasons.aspx">Call Reasons</a></li>
                                    <li><a href="admin/concerns.aspx">Concerns</a></li>
                                    <li><a href="admin/user.manager.aspx">User Manager</a></li>
                                </ul></li>
                                
                                <li><a href="#">Monitoring</a>
                                <ul>
                                    <li><a href="FormB.aspx">Enter Call</a></li>
                                    <li><a href="my.reviews.aspx">My Reviews</a></li>
                                </ul></li>                          
                                     
                          </ul>
                            </div>
                            <br /><br />
                            
                            <div id="Div1">                          
                                                                                                              
                                    <!--Call Centers-->
                                    <asp:SqlDataSource ID="dsCallCenters" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />

                                    <!--Call Reason / Issues-->
                                    <asp:SqlDataSource ID="dsReasonCode" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                    SelectCommand="p_ReasonGroup_Lookup" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:Parameter Name="CallCenterFunction" /> 
                                    </SelectParameters>
                                    </asp:SqlDataSource>

                                    <!--Concerns-->
                                    <asp:SqlDataSource ID="dsConcerns" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" />

                                    <div align="left" style="padding-top: 10px" id="tabs-1">
                                      
                                      <asp:UpdatePanel ID="pnlUpdate1" runat="server">
                                      <ContentTemplate>   
                                         
                                        <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>
                                                <td width="33%"><strong>Call Center Location:</strong><br />
                                                    <asp:DropDownList ID="ddlCallCenterID" runat="server" 
                                                        DataSourceID="dsCallCenters" Height="25px"
                                                  AppendDataBoundItems="true" DataTextField="CallCenter" 
                                                        DataValueField="CallCenterID" AutoPostBack="true" 
                                                        onselectedindexchanged="ddlCallCenterID_SelectedIndexChanged">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please select a  Call Center Location * " ControlToValidate="ddlCallCenterID" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%">
                                                    <strong>Date of Review:</strong><br />
                                                    <asp:TextBox ID="txtDateofReview" runat="server" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the Date of Review * " ControlToValidate="txtDateofReview" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%">
                                                    <strong>Begin Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtTimeofReview" runat="server" Width="175px"  />
                                                    <asp:ImageButton ID="btnTimeofReview" runat="server" CausesValidation="false"
                                                        ImageUrl="images/clock.png" Height="20" Width="20" 
                                                        onclick="btnTimeofReview_Click" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the Beginning Time of Review  * " ControlToValidate="txtTimeofReview" ValidationGroup="FormB" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  width="33%"><strong>Agent ID:</strong> <br />
                                                    <asp:TextBox ID="txtAgentID" runat="server" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the Agent ID * " ControlToValidate="txtAgentID" ValidationGroup="FormB" /></td>
                                                <td  width="33%"><strong><asp:Label ID="lblAcctNSLDS" runat="server" Text="Account No:" /></strong><br />
                                                    <asp:TextBox ID="txtBorrowerAccountNumber" runat="server" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the borrower Account No or NSLDS ID  * " ControlToValidate="txtBorrowerAccountNumber" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%"><strong>End Time of Review:</strong><br />
                                                <asp:TextBox ID="txtEndTimeofReview" runat="server" Width="175px" />
                                                     <asp:ImageButton ID="btnEndTimeofReview" runat="server" CausesValidation="false"
                                                        ImageUrl="images/clock.png" Height="20" Width="20" 
                                                        onclick="btnEndTimeofReview_Click" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the End Time of Review  * " ControlToValidate="txtEndTimeofReview" ValidationGroup="FormB" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                            </tr>
                                            </table>                                        
                                          
                                      </ContentTemplate>
                                      </asp:UpdatePanel>   
                                         
                                            <table width="100%" cellpadding="2" cellspacing="2" border="0">                                            
                                            <tr>
                                                <td  width="33%"><b>Greeting</b></td>
                                                <td  width="33%"><b>Verification</b></td>
                                                <td width="33%"><b>Eiquette</b></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkGName" runat="server" Checked="true" CssClass="Score1" /> Idenitified Self <br />
                                                    <asp:CheckBox ID="chkGClear" runat="server" Checked="true" class="Score1" /> Spoke Clearly<br />
                                                    <asp:CheckBox ID="chkGTone" runat="server" Checked="true" class="Score1" /> Friendly Tone<br />
                                                    <asp:CheckBox ID="chkGPrompt" runat="server" Checked="true" class="Score1" /> Answered Promptly<br />
                                                 </td>
                                                  <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkVName" runat="server" Checked="true" class="Score1" /> Caller's Name<br />
                                                    <asp:CheckBox ID="chkVSSN" runat="server" Checked="true" class="Score1" /> Account No/NSLDS ID<br />
                                                    <asp:CheckBox ID="chkVAdrs" runat="server" Checked="true" class="Score1" /> Address/School ID<br /> 
                                                    <asp:CheckBox ID="chkVPhon1" runat="server" Checked="true" class="Score1" /> Primary Phone No<br />   
                                                    <asp:CheckBox ID="chkVPhon2" runat="server" Checked="true" class="Score1" /> Alternate Phone No<br />
                                                    <asp:CheckBox ID="chkVEmail" runat="server" Checked="true" class="Score1" /> Email Address<br />    
                                                    <asp:CheckBox ID="chkVDOB" runat="server" Checked="true" class="Score1" /> DOB<br />                                            
                                                 </td>
                                                 <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkEPleasant" runat="server" Checked="true" class="Score4" /> Pleasant Manner<br />
                                                    <asp:CheckBox ID="chkENonConfrontational" runat="server" Checked="true" class="Score4" /> Non-Confrontational<br />
                                                    <asp:CheckBox ID="chkETimeliness" runat="server" Checked="true" class="Score4" /> Timeliness<br />                                                    
                                                 </td>
                                            </tr>
                                            </table>
                                            <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>
                                                <td  width="33%"><b>Listening</b></td>
                                                <td  width="33%"><b>Closing</b></td>
                                                <td  width="33%">&nbsp; </td>
                                            </tr>
                                            <tr>
                                                <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkLInterrupt" runat="server" Checked="true" class="Score2" /> Didn't Interrupt <br />
                                                    <asp:CheckBox ID="chkLNoRepeat" runat="server" Checked="true" class="Score2" /> Borrower Focus<br />                                                    
                                                 </td>
                                               
                                                <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkCRecapped" runat="server" Checked="true" class="Score2" /> Recapped Call <br />
                                                    <asp:CheckBox ID="chkCAllQuestions" runat="server" Checked="true" class="Score4" /> Answered All Questions<br />
                                                    <asp:CheckBox ID="chkBCCounseling" runat="server" Checked="true" class="Score4" /> Basic Counseling<br />
                                                    <asp:CheckBox ID="chkSAccuracy" runat="server" Checked="true" class="Score4" /> Correct Solution<br />
                                                 </td>
                                                 <td  width="33%" valign="top">
                                                    <asp:CheckBox ID="chkEscalationIssue" runat="server" Checked="false" AutoPostBack="true" 
                                                         oncheckedchanged="chkEscalationIssue_CheckedChanged" /> Escalation Issue (Comments required)<br /><br />

                                                    <p id="total" style="display:none"></p>

                                                     PASS/FAIL: <asp:Label ID="lblPassFail" runat="server" CssClass="warning" />
                                                    
                                                  </td>
                                              </tr>
                                                 <tr>
                                                    <td colspan="3"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                                </tr>
                                                </table>

                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                                 <tr>
                                                    <td  width="33%"><strong>Issues / Accuracy</strong></td>
                                                    <td  align="left"> </td>
                                                    <td  width="33%"><strong>Common Concerns</strong></td>
                                                 </tr>
                                                 <tr>
                                                    <td valign="top" colspan="2">
                                                     <asp:DropDownList ID="ddlIssue1" runat="server" DataSourceID="dsReasonCode" 
                                                            Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" 
                                                            DataValueField="ReasonCode" 
                                                            onselectedindexchanged="ddlIssue1_SelectedIndexChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy1" runat="server" /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue2" runat="server" DataSourceID="dsReasonCode" Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode" 
                                                            onselectedindexchanged="ddlIssue2_SelectedIndexChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy2" runat="server" /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue3" runat="server" DataSourceID="dsReasonCode" Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode"
                                                            onselectedindexchanged="ddlIssue3_SelectedIndexChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy3" runat="server" /><br />
                                                    </td>

                                                    <td valign="top" width="33%">
                                                     <asp:DropDownList ID="ddlConcern1" runat="server" DataSourceID="dsConcerns" Height="25px" Width="275px"
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID">
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />

                                                     <asp:DropDownList ID="ddlConcern2" runat="server" DataSourceID="dsConcerns" Height="25px" Width="275px"
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID">
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />

                                                    <asp:DropDownList ID="ddlConcern3" runat="server" DataSourceID="dsConcerns" Height="25px" Width="275px"
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID">
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />
                                                    </td>
                                                 </tr>
                                                
                                                 <tr>
                                                    <td colspan="3"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3"><strong>Comments:</strong> 
                                                    <asp:RequiredFieldValidator ID="rfdComments" runat="server" ControlToValidate="txtComments" CssClass="warning" ErrorMessage="Comments are required when the Escalation Issue is checked" Display="Dynamic" Enabled="false" ValidationGroup="FormB" />
                                                    <br />
                                                    <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="750" Height="100" />
                                                    <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtComments" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" align="center">
                                                        <asp:Button ID="btnAddCall" runat="server" CssClass="button" Text="Add Call" OnClick="btnAddCall_Click" ValidationGroup="FormB" />                                                        
                                                    </td>
                                                </tr>
                                                </table>
                                                </ContentTemplate>
                                                </asp:UpdatePanel>

                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <table align="center" cellspacing="4" cellpadding="4" width="95%">
                                                                <tr>
                                                                    <td class="style1">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td align="center">
                                                                        <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />
                                                                        <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick">
                                                                        </asp:Timer>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                        </div>
                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
          
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible = "false" /><br />
   <input id="lblPassFailHidden" name="lblPassFailHidden" type="Hidden" runat="server" visible="true" />
   <asp:Literal ID="lblPassFailServerSide" runat="server" Visible="false" Text="PASS" />
   <asp:Label ID="lblCallCenterID" runat="server" />
   <asp:Label ID="lblCallCenterFunction" runat="server" />
    </form>
</body>
</html>
