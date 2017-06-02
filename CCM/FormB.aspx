<%@ Page Title="Call Center Monitoring Form" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FormB.aspx.vb" Inherits="CCM_New_FormB" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
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

                    var passFail = $("#MainContent_lblPassFail");
                    if (total >= 4) {
                        passFail.text("FAIL");
                        setHiddenPassFail("FAIL");
                        alert("Reminder: Comments are required for failed calls");
                    } else {
                        passFail.text("PASS");
                        setHiddenPassFail("PASS");
                    }
                }
            });

            function setHiddenPassFail(passfail) {
                //var passFail = $("#MainContent_lblPassFail"); 
                //var passFailHidden = $("#MainContent_lblPassFailHidden");
                // place the selected pass/fail values in the label control lblPassFailHidden
                //passFailHidden.text(passfail);                
                //document.getElementById(passFailHidden).value = passfail;
                $('#MainContent_lblPassFailHidden').val(passfail);                
            };    

</script>

   <script type="text/javascript">
    $(function () {
        $(".datepicker").datepicker();
    });
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
                         <h2>Call Center Monitoring - Enter New Call</h2>
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
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Call Centers-->
                                <asp:SqlDataSource ID="dsCallCenters" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />
                                <!--Call Reason / Issues-->
                                <asp:SqlDataSource ID="dsReasonCode" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_ReasonGroup_Lookup" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:Parameter Name="CallCenterFunction" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <!--Concerns-->
                                <asp:SqlDataSource ID="dsConcerns" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" />
                                <div align="left" style="padding-top: 10px" id="tabs-1">
                                   <asp:UpdatePanel id="pnlupdate1" runat="server">
                                        <ContentTemplate> 
                                         
                                        <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>
                                                <td width="25%"><strong>Call Center Location:</strong><br />
                                                    <asp:DropDownList ID="ddlCallCenterID" runat="server" TabIndex="1" 
                                                        DataSourceID="dsCallCenters" Height="25px"
                                                  AppendDataBoundItems="true" DataTextField="CallCenter" 
                                                        DataValueField="CallCenterID" AutoPostBack="true" 
                                                        onselectedindexchanged="ddlCallCenterID_SelectedIndexChanged">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please select a  Call Center Location * " ControlToValidate="ddlCallCenterID" ValidationGroup="FormB" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Date of Review:</strong><br />
                                                    <asp:TextBox ID="txtDateofReview" runat="server" class="datepicker" 
                                                        TabIndex="2" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Date of Review * " ControlToValidate="txtDateofReview" ValidationGroup="FormB" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Begin Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtTimeofReview" runat="server" Width="175px" TabIndex="3"  />
                                                    <asp:ImageButton ID="btnBeginTimeofReview" runat="server" CausesValidation="false"
                                                        ImageUrl="images/clock.png" Height="20" Width="20" 
                                                        onclick="btnTimeofReview_Click" />
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Beginning Time of Review  * " ControlToValidate="txtTimeofReview" ValidationGroup="FormB" />
                                                </td>
                                                <td width="25%"> <strong><asp:Label ID="lblInboundOutbound" runat="server" Text="Inbound/Outbound:" /></strong><br />
                                                    <asp:DropDownList ID="ddlInboundOutbound" runat="server" Height="25px" TabIndex="4">
                                                        <asp:ListItem Selected="True" Text="Inbound" Value="Inbound" />
                                                        <asp:ListItem Text="Outbound" Value="Outbound" />
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="25%" valign="top"><strong>Agent ID:</strong> <br />
                                                    <asp:TextBox ID="txtAgentID" runat="server" TabIndex="5" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Agent ID * " ControlToValidate="txtAgentID" ValidationGroup="FormB" /></td>
                                                <td width="25%" valign="top"><strong><asp:Label ID="lblCallID" runat="server" Text="Call ID Number:" /></strong><br />
                                                    <asp:TextBox ID="txtCallID" runat="server" TabIndex="6" /><br /><br />                                                    
                                                </td>  
                                                <td width="25%" valign="top"><strong><asp:Label ID="lblAcctNSLDS" runat="server" Text="Account No:" /></strong><br />
                                                    <asp:TextBox ID="txtBorrowerAccountNumber" runat="server" TabIndex="7" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" 
                                                    ErrorMessage="* Please enter the borrower Account No or NSLDS ID  * " ControlToValidate="txtBorrowerAccountNumber" ValidationGroup="FormB" />
                                                </td>
                                                <td width="25%" valign="top">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                            </tr>
                                            </table>                                        
                                          
                                     </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                        <tr>
                                            <td width="33%">
                                                <b>Greeting</b>
                                            </td>
                                            <td width="33%">
                                                <b>Verification</b>
                                            </td>
                                            <td width="33%">
                                                <b>Etiquette</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" width="33%">
                                                <asp:CheckBox ID="chkGName" runat="server" Checked="true" CssClass="Score1" />
                                                Identified Self
                                                <br />
                                                <asp:CheckBox ID="chkGClear" runat="server" Checked="true" class="Score1" />
                                                Spoke Clearly<br />
                                                <asp:CheckBox ID="chkGTone" runat="server" Checked="true" class="Score1" />
                                                Friendly Tone<br />
                                                <asp:CheckBox ID="chkGPrompt" runat="server" Checked="true" class="Score1" />
                                                Answered Promptly<br />
                                            </td>
                                            <td valign="top" width="33%">
                                                <asp:CheckBox ID="chkVName" runat="server" Checked="true" class="Score1" />
                                                Caller's Name<br />
                                                <asp:CheckBox ID="chkVSSN" runat="server" Checked="true" class="Score1" />
                                                Account No/NSLDS ID<br />
                                                <asp:CheckBox ID="chkVAdrs" runat="server" Checked="true" class="Score1" />
                                                Address/School ID<br />
                                                <asp:CheckBox ID="chkVPhon1" runat="server" Checked="true" class="Score1" />
                                                Primary Phone No<br />
                                                <asp:CheckBox ID="chkVPhon2" runat="server" Checked="true" class="Score1" />
                                                Alternate Phone No<br />
                                                <asp:CheckBox ID="chkVEmail" runat="server" Checked="true" class="Score1" />
                                                Email Address<br />
                                                <asp:CheckBox ID="chkVDOB" runat="server" Checked="true" class="Score1" />
                                                DOB<br />
                                            </td>
                                            <td valign="top" width="33%">
                                                <asp:CheckBox ID="chkEPleasant" runat="server" Checked="true" class="Score4" />
                                                Pleasant Manner<br />
                                                <asp:CheckBox ID="chkENonConfrontational" runat="server" Checked="true" class="Score4" />
                                                Non-Confrontational<br />
                                                <asp:CheckBox ID="chkETimeliness" runat="server" Checked="true" class="Score2" />
                                                Timeliness<br />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                        <tr>
                                            <td width="33%">
                                                <b>Listening</b>
                                            </td>
                                            <td width="33%">
                                                <b>Closing</b>
                                            </td>
                                            <td width="33%">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" width="33%">
                                                <asp:CheckBox ID="chkLInterrupt" runat="server" Checked="true" class="Score2" />
                                                Didn't Interrupt
                                                <br />
                                                <asp:CheckBox ID="chkLNoRepeat" runat="server" Checked="true" class="Score2" />
                                                Borrower Focus<br />
                                            </td>
                                            <td valign="top" width="33%">
                                                <asp:CheckBox ID="chkCRecapped" runat="server" Checked="true" class="Score2" />
                                                Recapped Call
                                                <br />
                                                <asp:CheckBox ID="chkCAllQuestions" runat="server" Checked="true" class="Score4" />
                                                Answered All Questions<br />
                                                <asp:CheckBox ID="chkBCCounseling" runat="server" Checked="true" class="Score4" />
                                                Basic Counseling<br />
                                                <asp:CheckBox ID="chkSAccuracy" runat="server" Checked="true" class="Score4" />
                                                Correct Solution<br />
                                            </td>
                                            <td width="33%" valign="top">
                                                <asp:CheckBox ID="chkEscalationIssue" runat="server" Checked="false" />
                                                Escalation Issue (Comments required)<br />
                                                <br />
                                                <p id="total" style="display: none">
                                                </p>
                                                PASS/FAIL:
                                                <asp:Label ID="lblPassFail" runat="server" CssClass="warning" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <hr noshade="noshade" style="height: 1px; color: #000000" />
                                            </td>
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
                                                            TabIndex="8">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy1" runat="server" Checked="true" class="Score2" /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue2" runat="server" DataSourceID="dsReasonCode" 
                                                            Height="25px" Width="350px" 
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode" 
                                                            TabIndex="9">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy2" runat="server" Checked="true" class="Score2" /><br /><br />

                                                    <asp:DropDownList ID="ddlIssue3" runat="server" DataSourceID="dsReasonCode" 
                                                            Height="25px" Width="350px"                 
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" DataValueField="ReasonCode"
                                                            TabIndex="10">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList> <asp:Checkbox ID="chkAccuracy3" runat="server" Checked="true" class="Score2" /><br />
                                                    </td>

                                                    <td valign="top" width="33%">
                                                     <asp:DropDownList ID="ddlConcern1" runat="server" DataSourceID="dsConcerns" 
                                                            Height="25px" Width="275px"
                                                            AppendDataBoundItems="true" DataTextField="Concern" 
                                                            DataValueField="ConcernID" TabIndex="11">
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />

                                                     <asp:DropDownList ID="ddlConcern2" runat="server" DataSourceID="dsConcerns" 
                                                            Height="25px" Width="275px" 
                                                            AppendDataBoundItems="true" DataTextField="Concern" 
                                                            DataValueField="ConcernID" TabIndex="12">
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />

                                                    <asp:DropDownList ID="ddlConcern3" runat="server" DataSourceID="dsConcerns" 
                                                            Height="25px" Width="275px" 
                                                            AppendDataBoundItems="true" DataTextField="Concern" 
                                                            DataValueField="ConcernID" TabIndex="13">
                                                        <asp:ListItem Text="" Value="0" />
                                                    </asp:DropDownList><br /><br />
                                                    </td>
                                                 </tr>
                                                
                                                 <tr>
                                                    <td colspan="3"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3"><strong>Comments:</strong> 
                                                    <br />                                                        
                                                    <asp:RequiredFieldValidator ID="rfdComments" runat="server" ControlToValidate="txtComments" CssClass="warning" ErrorMessage="Comments are required when the call fails" Display="Dynamic" Enabled="false" ValidationGroup="FormB" />
                                                  
                                                    <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" TextMode="MultiLine" 
                                                            Width="750" Height="100" TabIndex="14" />
                                                    <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtComments" />
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <td colspan="3" align="center">
                                                        <asp:Button ID="btnAddCall" runat="server" CssClass="button" Text="Add Call" 
                                                            OnClick="btnAddCall_Click" ValidationGroup="FormB" TabIndex="15" />                                                        
                                                        <asp:Button ID="btnAddAnotherCall" runat="server" CssClass="button" Text="Add Another Call" OnClick="btnAddAnotherCall_Click" CausesValidation="false" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                     <td  colspan="3" align="center"><asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" /></td>
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
   <asp:Label ID="lblUserID" runat="server" Visible="true" /><br />
   <input id="lblPassFailHidden" name="lblPassFailHidden" type="Hidden" runat="server" visible="true" />
   <asp:Literal ID="lblPassFailServerSide" runat="server" Visible="false" Text="PASS" />
   <asp:Label ID="lblCallCenterID" runat="server" />
   <asp:Label ID="lblCallCenterFunction" runat="server" />
</asp:Content>

