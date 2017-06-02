<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" Debug="true" %>
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
            
            Dim intReviewID = Request.QueryString("ReviewID")
            lblReviewID2.Text = intReviewID.ToString()
            
            BindForm(intReviewID)
        End If
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
    End Sub
        
    Sub btnUpdateCall_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim CallCenterID As Integer
        Dim AgentID As String = ""
        Dim DateofReview As String = ""
        Dim TimeofReview As String = ""
        Dim EndTimeofReview As String = ""
        Dim BorrowerAccountNumber As String = ""
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
            DateofReview = CType(dataItem.FindControl("txtDateofReview"), TextBox).Text
            TimeofReview = CType(dataItem.FindControl("txtTimeofReview"), TextBox).Text
            EndTimeofReview = CType(dataItem.FindControl("txtEndTimeofReview"), TextBox).Text
            BorrowerAccountNumber = CType(dataItem.FindControl("txtBorrowerAccountNumber"), TextBox).Text
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
            Accuracy1 = CType(dataItem.FindControl("chkAccuracy1"), CheckBox).Checked
            Accuracy2 = CType(dataItem.FindControl("chkAccuracy2"), CheckBox).Checked
            Accuracy3 = CType(dataItem.FindControl("chkAccuracy3"), CheckBox).Checked
            EPleasant = CType(dataItem.FindControl("chkEPleasant"), CheckBox).Checked
            ENonConfrontational = CType(dataItem.FindControl("chkENonConfrontational"), CheckBox).Checked
            ETimeliness = CType(dataItem.FindControl("chkETimeliness"), CheckBox).Checked
            CAllQuestions = CType(dataItem.FindControl("chkCAllQuestions"), CheckBox).Checked
            CRecapped = CType(dataItem.FindControl("chkCRecapped"), CheckBox).Checked
            'RecordStatus = CType(dataItem.FindControl("lblRecordStatus"), Label).Text
            
        Next
        
        lblPassFailServerSide.Text = lblPassFailHidden.Value
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateCall_FormB", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@CallCenterID", CallCenterID)
        cmd.Parameters.AddWithValue("@AgentID", AgentID)
        cmd.Parameters.AddWithValue("@DateofReview", DateofReview)
        cmd.Parameters.AddWithValue("@TimeofReview", TimeofReview)
        cmd.Parameters.AddWithValue("@EndTimeofReview", EndTimeofReview)
        cmd.Parameters.AddWithValue("@BorrowerAccountNumber", BorrowerAccountNumber)
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
        cmd.Parameters.AddWithValue("@S_Accuracy", SqlDbType.Bit).Value = 1
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
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Monitoring Form Detail</title>
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

                    var passFail = $("#Repeater1_ctl00_lblPassFail");
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
                    <!-- Tabs -->
		                <img src="images/fSA_logo.gif" alt="Federal Student Aid - Call Center Monitoring" />
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Call Monitoring B</a></li>                                
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
                            <p>&nbsp;</p>
                            
                            <div id="Div1">                          
                                                                                                              
                                    <!--Call Centers-->
                                    <asp:SqlDataSource ID="dsCallCenters" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallCentersAll" />

                                    <!--Call Reason / Issues-->
                                    <asp:SqlDataSource ID="dsReasonCode" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallReasons" />

                                    <!--Concerns-->
                                    <asp:SqlDataSource ID="dsConcerns" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_ConcernsAll" />

                                    <!--Users/Evaluators-->
                                    <asp:SqlDataSource ID="dsUserID" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />

                                   <!--Update History-->
                                    <asp:SqlDataSource ID="dsUpdateHistory" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_UpdateHistory" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="ReviewID" ControlID="lblReviewID2"  />
                                    </SelectParameters>
                                    </asp:SqlDataSource>
        
                                    <asp:Label ID="lblUsername" runat="server" Text='<%#Eval("Username") %>' />

                                    <div align="left" style="padding-top: 10px" id="tabs-1">
                                      <asp:Repeater id="Repeater1" runat="server">
                                        <ItemTemplate> 
                                      <asp:UpdatePanel ID="pnlUpdate1" runat="server">
                                      <ContentTemplate>
     
                                        <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>
                                                <td width="33%" valign="top"><strong>Review ID:</strong><br />
                                                <asp:Label ID="lblReviewID" runat="server" Text='<%#Eval("ReviewID") %>' /></td>
                                                
                                                 <td  width="33%" valign="top"><strong>Evaluator:</strong><br />
                                                 <asp:DropDownList ID="ddlUserID" runat="server" DataSourceID="dsUserID" Enabled="false"  
                                                  AppendDataBoundItems="true" DataTextField="Username" DataValueField="UserID" SelectedValue='<%#Eval("UserID") %>'> 
                                                     <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList>                                                    
                                                </td> 
                                                <td width="33%"><br /><br /><br /></td>    
                                            </tr>
                                            
                                            <tr>
                                                <td width="33%"><strong>Call Center Location:</strong><br />
                                                    <asp:DropDownList ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters" Height="25px" Enabled="false"  
                                                  AppendDataBoundItems="true" DataTextField="CallCenter" DataValueField="CallCenterID" SelectedValue='<%#Eval("CallCenterID") %>' >
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please select a  Call Center Location * " ControlToValidate="ddlCallCenterID" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%">
                                                    <strong>Date of Review:</strong><br />
                                                    <asp:TextBox ID="txtDateofReview" runat="server" Text='<%#CDate(Eval("DateofReview")).ToString("MM/dd/yyyy")%>' /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the Date of Review * " ControlToValidate="txtDateofReview" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%">
                                                    <strong>Begin Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtTimeofReview" runat="server" Width="175px" Text='<%#Eval("TimeofReview") %>'  />
                                                    <asp:ImageButton ID="btnTimeofReview" runat="server" CausesValidation="false"
                                                        ImageUrl="images/clock.png" Height="20" Width="20" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the Beginning Time of Review  * " ControlToValidate="txtTimeofReview" ValidationGroup="FormB" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  width="33%"><strong>Agent ID:</strong> <br />
                                                    <asp:TextBox ID="txtAgentID" runat="server" Text='<%#Eval("AgentID") %>' /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the Agent ID * " ControlToValidate="txtAgentID" ValidationGroup="FormB" /></td>
                                                <td  width="33%"><strong>Account No/NSLDS ID:</strong><br />
                                                    <asp:TextBox ID="txtBorrowerAccountNumber" runat="server" Text='<%#Eval("BorrowerAccountNumber") %>' /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the borrower Account No or NSLDS ID  * " ControlToValidate="txtBorrowerAccountNumber" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%"><strong>End Time of Review:</strong><br />
                                                <asp:TextBox ID="txtEndTimeofReview" runat="server" Width="175px" Text='<%#Eval("EndTimeofReview") %>' />
                                                     <asp:ImageButton ID="btnEndTimeofReview" runat="server" CausesValidation="false"
                                                        ImageUrl="images/clock.png" Height="20" Width="20" /><br />
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
                                                    <asp:CheckBox ID="chkGName" runat="server" CssClass="Score1" Checked='<%# Eval("G_Name") %>' /> Idenitified Self <br />
                                                    <asp:CheckBox ID="chkGClear" runat="server" Checked='<%# Eval("G_Clear") %>' class="Score1" /> Spoke Clearly<br />
                                                    <asp:CheckBox ID="chkGTone" runat="server" Checked='<%# Eval("G_Tone") %>' class="Score1" /> Friendly Tone<br />
                                                    <asp:CheckBox ID="chkGPrompt" runat="server" Checked='<%# Eval("G_Prompt") %>' class="Score1" /> Answered Promptly<br />
                                                 </td>
                                                  <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkVName" runat="server" Checked='<%# Eval("V_Name") %>' class="Score1" /> Caller's Name<br />
                                                    <asp:CheckBox ID="chkVSSN" runat="server" Checked='<%# Eval("V_SSN") %>' class="Score1" /> Account No/NSLDS ID<br />
                                                    <asp:CheckBox ID="chkVAdrs" runat="server" Checked='<%# Eval("V_Adrs") %>' class="Score1" /> Address/School ID<br /> 
                                                    <asp:CheckBox ID="chkVPhon1" runat="server" Checked='<%# Eval("V_Phon1") %>' class="Score1" /> Primary Phone No<br />   
                                                    <asp:CheckBox ID="chkVPhon2" runat="server" Checked='<%# Eval("V_Phon2") %>' class="Score1" /> Alternate Phone No<br />
                                                    <asp:CheckBox ID="chkVEmail" runat="server" Checked='<%# Eval("V_Email") %>' class="Score1" /> Email Address<br />    
                                                    <asp:CheckBox ID="chkVDOB" runat="server" Checked='<%# Eval("V_DOB") %>' class="Score1" /> DOB<br />                                            
                                                 </td>
                                                 <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkEPleasant" runat="server" Checked='<%# Eval("E_Pleasant") %>' class="Score4" /> Pleasant Manner<br />
                                                    <asp:CheckBox ID="chkENonConfrontational" runat="server" Checked='<%# Eval("E_NonConfrontational") %>' class="Score4" /> Non-Confrontational<br />
                                                    <asp:CheckBox ID="chkETimeliness" runat="server" Checked='<%# Eval("E_Timeliness") %>' class="Score4" /> Timeliness<br />                                                    
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
                                                    <asp:CheckBox ID="chkLInterrupt" runat="server" Checked='<%# Eval("L_Interrupt") %>' class="Score2" /> Didn't Interrupt <br />
                                                    <asp:CheckBox ID="chkLNoRepeat" runat="server" Checked='<%# Eval("L_NoRepeat") %>'  class="Score2" /> Borrower Focus<br />                                                    
                                                 </td>
                                               
                                                <td valign="top"  width="33%">
                                                    <asp:CheckBox ID="chkCRecapped" runat="server" Checked='<%# Eval("C_Recapped") %>' class="Score2" /> Recapped Call <br />
                                                    <asp:CheckBox ID="chkCAllQuestions" runat="server" Checked='<%# Eval("C_AllQuestions") %>' class="Score4" /> Answered All Questions<br />
                                                    <asp:CheckBox ID="chkBCCounseling" runat="server" Checked='<%# Eval("BC_Counseling") %>' class="Score4" /> Basic Counseling<br />
                                                    <asp:CheckBox ID="chkSAccuracy" runat="server" Checked='<%# Eval("S_Accuracy") %>' class="Score4" /> Correct Solution<br />
                                                 </td>
                                                 <td  width="33%" valign="top">
                                                    <asp:CheckBox ID="chkEscalationIssue" runat="server" Checked='<%# Eval("EscalationIssue") %>'  AutoPostBack="true" 
                                                         oncheckedchanged="chkEscalationIssue_CheckedChanged" /> Escalation Issue (Comments required)<br /><br />

                                                    <p id="total" style="display:none"></p>

                                                     PASS/FAIL: <asp:Label ID="lblPassFail" runat="server" CssClass="warning" Text='<%# IIF(Eval("OverallScore"),"PASS","FAIL") %>' />
                                                    
                                                  </td>
                                              </tr>
                                                 <tr>
                                                    <td colspan="3"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                                </tr>
                                                </table>

                                            <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                                 <tr>
                                                    <td  width="33%"><strong>Issues / Accuracy</strong></td>
                                                    <td  align="left"> </td>
                                                    <td  width="33%"><strong>Common Concerns</strong></td>
                                                 </tr>
                                                 <tr>
                                                    <td valign="top" colspan="2">
                                                     <asp:DropDownList ID="ddlIssue1" runat="server" DataSourceID="dsReasonCode" Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode" SelectedValue='<%#Eval("Issue1") %>'>
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy1" runat="server" Checked='<%# Eval("Accuracy1") %>' /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue2" runat="server" DataSourceID="dsReasonCode" Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode" SelectedValue='<%#Eval("Issue2") %>'>
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy2" runat="server" Checked='<%# Eval("Accuracy2") %>' /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue3" runat="server" DataSourceID="dsReasonCode" Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode" SelectedValue='<%#Eval("Issue3") %>'>
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy3" runat="server" Checked='<%# Eval("Accuracy3") %>' /><br />
                                                    </td>

                                                 

                                                    <td valign="top"  width="33%">
                                                     <asp:DropDownList ID="ddlConcern1" runat="server" DataSourceID="dsConcerns" Height="25px" Width="275px"
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID" SelectedValue='<%#Eval("Concern1") %>'>
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />

                                                     <asp:DropDownList ID="ddlConcern2" runat="server" DataSourceID="dsConcerns" Height="25px" Width="275px"
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID" SelectedValue='<%#Eval("Concern2") %>'>
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />

                                                    <asp:DropDownList ID="ddlConcern3" runat="server" DataSourceID="dsConcerns" Height="25px" Width="275px"
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID" SelectedValue='<%#Eval("Concern3") %>'>
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
                                                    <%--<asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="750" Height="175" Text='<%#Eval("Comments") %>' />--%>
                                                    <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="750" Height="100" Text='<%#Eval("Comments") %>' />
                                                    <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtComments" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" align="center">
                                                        <asp:Button ID="btnUpdateCall" runat="server" CssClass="button" Text="Update Call" OnClick="btnUpdateCall_Click" ValidationGroup="FormB" />
                                                    </td>
                                                </tr>
                                        </table>
                                         </ItemTemplate>
                                        </asp:Repeater>
                                        </div>

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
                   
                    <div id="dvGrid" class="grid" align="center">               
                        <asp:GridView ID="GridView1" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="false" 
                        DataSourceID="dsUpdateHistory" 
                        AllowPaging="false"                        
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            DataKeyNames="ReviewID"
			            BackColor="White" 
			            GridLines="Horizontal"
                        CellPadding="3" 
                        BorderColor="#E7E7FF"
			            Width="875px" 
                        Caption="Update History" 
			            BorderStyle="None" 
			            ShowFooter="false">
			            <EmptyDataTemplate>
			                No update history is available for this call
			            </EmptyDataTemplate>
                        <Columns>                                                                                 
                            <asp:BoundField DataField="DateChanged" HeaderText="Date Changed" SortExpression="DateChanged" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="EventName" HeaderText="Event Type" SortExpression="EventName" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Username" HeaderText="Change Made By" SortExpression="Username" />                       
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
                    </asp:GridView>


                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
          
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblReviewID2" runat="server" Visible="false" />
   <input id="lblPassFailHidden" name="lblPassFailHidden" type="Hidden" runat="server" visible="true" />
   <asp:Literal ID="lblPassFailServerSide" runat="server" Visible="false" Text="PASS" />
    </form>
</body>
</html>
