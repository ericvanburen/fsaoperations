<%@ Page Title="Call Center Monitoring Form" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FormBDetail.aspx.vb" Inherits="CCM_New_FormBDetail" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
       <script src="Scripts/menu.js" type="text/javascript"></script>
        
       
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

                    var passFail = $("#MainContent_Repeater1_lblPassFail_0");
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
//                var passFail = $("#MainContent_Repeater1_lblPassFail_0");
//                var passFailHidden = $("#MainContent_Repeater1_lblPassFail_0");
//                // place the selected pass/fail values in the label control lblPassFailHidden
//                passFail.text(passfail);
//                document.getElementById(passFailHidden).value = passfail;
                $('#MainContent_lblPassFailHidden').val(passfail);                  
            };    

</script>

    <script type="text/javascript">
    //prevents the user from hitting the backspace key to leave the page on select dropddowns
    $(document).ready(function () { // FF needs keypress, IE needs keydown
        $('select').keypress(function (event)
        { return cancelBackspace(event) });
        $('select').keydown(function (event)
        { return cancelBackspace(event) });
    }); // ready

    function cancelBackspace(event) {
        if (event.keyCode == 8) {
            return false;
        }
    }
   </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
         
    <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">                    
                    <!-- Tabs -->
		                <h2>Call Center Monitoring - Update Call</h2>                        
                            <div id="tabs">                            
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
                                <ul id="nav">
                                     <li><a href="Help.aspx">Help</a></li>
                                     <li><a href="#">Reports</a>
                                        <ul>
                                            <li><a href="MyProductivityReport.aspx">My Productivity</a></li>                                    
                                        </ul>
                                         
                                    </li>
                                    <li><a href="Search.aspx">Search</a></li>
                                    <li><a href="#">Administration</a>
                                        <ul>                                           
                                            <li><a href="admin/ReportCallsMonitored.aspx">Call Center Count</a></li>
                                            <li><a href="admin/ReportFailedCalls.aspx">Failed Calls</a></li>
                                            <li><a href="admin/ReportAccuracy.aspx">Accuracy Report</a></li>
                                            <li><a href="admin/ReportIndividualProductivity.aspx">Productivity</a></li>
                                            <li><a href="admin/ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
                                            <li><a href="admin/Search.aspx">Search</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Monitoring</a>
                                        <ul>
                                            <li><a href="FormB.aspx">Enter Call</a></li>
                                            <li><a href="MyReviews.aspx">My Reviews</a></li>
                                        </ul>
                                    </li>
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
        
                                    <asp:Label ID="lblUserID2" runat="server" Text='<%#Eval("UserID") %>' />

                                    <div align="left" style="padding-top: 10px" id="tabs-1">
                                      <asp:Repeater id="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                                        <ItemTemplate> 
                                      <asp:UpdatePanel ID="pnlUpdate1" runat="server">
                                      <ContentTemplate>
     
                                        <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>
                                                <td width="33%" valign="top"><strong>Review ID:</strong><br />
                                                <asp:Label ID="lblReviewID" runat="server" Text='<%#Eval("ReviewID") %>' /></td>
                                                
                                                 <td  width="33%" valign="top"><strong>Evaluator:</strong><br />
                                                 <asp:DropDownList ID="ddlUserID" runat="server" DataSourceID="dsUserID" Enabled="false" Height="25px"  
                                                  AppendDataBoundItems="true" DataTextField="UserID" DataValueField="UserID" SelectedValue='<%# CaseConvert(Eval("UserID"))%>'> 
                                                     <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList>                                                    
                                                </td> 
                                                <td width="33%"><strong>Call Center Location:</strong><br />
                                                    <asp:DropDownList ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters" Height="25px"  
                                                  AppendDataBoundItems="true" DataTextField="CallCenter" DataValueField="CallCenterID" SelectedValue='<%#Eval("CallCenterID") %>'>
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic"
                                                    ErrorMessage="* Please select a  Call Center Location * " ControlToValidate="ddlCallCenterID" ValidationGroup="FormB" /></td>    
                                            </tr>
                                            
                                            <tr>
                                                <td width="33%"><strong><asp:Label ID="lblInboundOutbound" runat="server" Text="Inbound/Outbound:" /></strong><br />
                                                    <asp:DropDownList ID="ddlInboundOutbound" runat="server" Height="25px" SelectedValue='<%#Eval("InboundOutbound")%>'>
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="Inbound" Value="Inbound" />
                                                        <asp:ListItem Text="Outbound" Value="Outbound" />
                                                    </asp:DropDownList></td>
                                                <td  width="33%">
                                                    <strong>Date of Review:</strong><br />
                                                    <asp:TextBox ID="txtDateofReview" runat="server" Enabled="false" Text='<%#CDate(Eval("DateofReview")).ToString("MM/dd/yyyy")%>' Height="25px" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Date of Review * " ControlToValidate="txtDateofReview" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%">
                                                    <strong>Begin Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtTimeofReview" runat="server" Width="175px" Text='<%# Right(Eval("TimeofReview"),11) %>' Height="25px" />
                                                    <asp:ImageButton ID="btnTimeofReview" runat="server" CausesValidation="false"
                                                        ImageUrl="images/clock.png" Height="20" Width="20" onclick="btnTimeofReview_Click" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Beginning Time of Review  * " ControlToValidate="txtTimeofReview" ValidationGroup="FormB" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  width="33%"><strong>Agent ID:</strong> <br />
                                                    <asp:TextBox ID="txtAgentID" runat="server" Text='<%#Eval("AgentID") %>' Height="25px" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Agent ID * " ControlToValidate="txtAgentID" ValidationGroup="FormB" /></td>
                                                <td  width="33%"><strong>Account No/NSLDS ID:</strong><br />
                                                    <asp:TextBox ID="txtBorrowerAccountNumber" runat="server" Text='<%#Eval("BorrowerAccountNumber") %>' Height="25px" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the borrower Account No or NSLDS ID  * " ControlToValidate="txtBorrowerAccountNumber" ValidationGroup="FormB" />
                                                </td>
                                                <td  width="33%"><strong>End Time of Review:</strong><br />
                                                <asp:TextBox ID="txtEndTimeofReview" runat="server" Width="175px" Text='<%# Right(Eval("EndTimeofReview"),11) %>' Height="25px" />
                                                     <asp:ImageButton ID="btnEndTimeofReview" runat="server" CausesValidation="false"
                                                        ImageUrl="images/clock.png" Height="20" Width="20" onclick="btnEndTimeofReview_Click" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the End Time of Review  * " ControlToValidate="txtEndTimeofReview" ValidationGroup="FormB" />
                                                </td>
                                            </tr>
                                            <tr>
                                               <td colspan="3" valign="top"><strong><asp:Label ID="lblCallID" runat="server" Text="Call ID Number:" /></strong><br />
                                                    <asp:TextBox ID="txtCallID" runat="server" Text='<%# Eval("CallID") %>' />
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
                                                <td width="33%"><b>Etiquette</b></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"  width="33%">  
                                                    <asp:CheckBox ID="chkGName" runat="server" CssClass="Score1" Checked='<%# Eval("G_Name") %>' /> Identified Self <br />
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
                                                    <asp:CheckBox ID="chkETimeliness" runat="server" Checked='<%# Eval("E_Timeliness") %>' class="Score2" /> Timeliness<br />                                                    
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
                                                    <asp:CheckBox ID="chkEscalationIssue" runat="server" Checked='<%# Eval("EscalationIssue") %>' /> Escalation Issue (Comments required)<br /><br />

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
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy1" runat="server" Checked='<%# Eval("Accuracy1") %>' class="Score2" /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue2" runat="server" DataSourceID="dsReasonCode" Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode" SelectedValue='<%#Eval("Issue2") %>'>
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy2" runat="server" Checked='<%# Eval("Accuracy2") %>' class="Score2" /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue3" runat="server" DataSourceID="dsReasonCode" Height="25px" Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode" SelectedValue='<%#Eval("Issue3") %>'>
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy3" runat="server" Checked='<%# Eval("Accuracy3") %>' class="Score2" /><br />
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

                                
                                        <table align="center" cellspacing="4" cellpadding="4" width="95%">
                                            <tr>
                                                <td align="center"><asp:Button ID="btnDeleteCall" runat="server" CssClass="button" Text="Delete Call" Visible="false" OnClientClick="return confirm('Are you sure that you want to delete this call?')" OnClick="btnDeleteCall_Click" /></td>
                                            </tr>                                            
                                            <tr>                                               
                                                <td align="center">
                                                    <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />                                                    
                                                </td>
                                            </tr>
                                        </table>
                                   
                   
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
                            <asp:BoundField DataField="UserID" HeaderText="Change Made By" SortExpression="UserID" />                       
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
   <%--<asp:Literal ID="lblPassFailServerSide" runat="server" Visible="false" Text="PASS" />--%>
    <asp:Literal ID="lblPassFailServerSide" runat="server" Visible="true" />
   <asp:Label ID="lblAdmin" runat="server" />
</asp:Content>

