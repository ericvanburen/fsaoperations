<%@ Page Title="Call Center Monitoring Form" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="FormB.aspx.vb" Inherits="CCM_New_FormB" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">    
        <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
        <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>      
        <script src="Scripts/menu.js" type="text/javascript"></script>       
        <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
        <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

    <style type="text/css">
    .resolutionBox {
        display: none;
        margin-bottom: 10px;
    }  
    
    .resolutionBox a:link {
        color: #555555; 
    }  

    .resolutionBox a:visited {
        color: #555555; 
    }

    .resolutionDDL {
        margin-bottom: 3px;
    }

    .fieldTitle 
    {
        font-size: 11pt; 
        text-align:left; 
        font-family: Calibri;      
    }

    .fieldTitle  a:link
    {
        color: #555555; 
    }

    .fieldTitle  a:visited
    {
        color: #555555; 
    }
</style>

        
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

          //Intializes the tooltips  
          $('[data-toggle="tooltip"]').tooltip({
              trigger: 'hover',
              'placement': 'top'
          });
          $('[data-toggle="popover"]').popover({
              trigger: 'hover',
              'placement': 'top'
          });
          
      }); // ready      

      function cancelBackspace(event) {
          if (event.keyCode == 8) {
              return false;
          }
      }
   </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('input:checkbox.resolution').click(function () {
                if ($(this).attr("value") == "delinquency") {
                    $("#divResolution_Delinquency").toggle();
                }
                if ($(this).attr("value") == "military") {
                    $("#divResolution_Military").toggle();
                }
                if ($(this).attr("value") == "pslf") {
                    $("#divResolution_PSLF").toggle();
                }
                if ($(this).attr("value") == "tlf") {
                    $("#divResolution_TLF").toggle();
                }
                if ($(this).attr("value") == "teach") {
                    $("#divResolution_TEACH").toggle();
                }
                if ($(this).attr("value") == "tpd") {
                    $("#divResolution_TPD").toggle();
                }
                if ($(this).attr("value") == "idr") {
                    $("#divResolution_IDR").toggle();
                }
                if ($(this).attr("value") == "deferment") {
                    $("#divResolution_Deferment").toggle();
                }
                if ($(this).attr("value") == "forbearance") {
                    $("#divResolution_Forbearance").toggle();
                }
                if ($(this).attr("value") == "amortization") {
                    $("#divResolution_NegativeAmortization").toggle();
                }
                if ($(this).attr("value") == "discharge") {
                    $("#divResolution_LoanDischarge").toggle();
                }
                if ($(this).attr("value") == "documentation") {
                    $("#divResolution_Documentation").toggle();
                }
                if ($(this).attr("value") == "payments") {
                    $("#divResolution_Payments").toggle();
                }
                if ($(this).attr("value") == "consolidation") {
                    $("#divResolution_Consolidation").toggle();
                }
                if ($(this).attr("value") == "other") {
                    $("#divResolution_Other").toggle();
                    alert("Please remember to add comments regarding the resolution of this call");
                }
            });
        });
</script>

   <script type="text/javascript">
        $(function () {
            $("#btnBeginTimeofReview").on('click', function () {
                var d = new Date();
                h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
                m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                $("#MainContent_txtBeginTimeofReview").val(h + ':' + m);               
            });
        });

        $(function () {
            $("#btnEndTimeofReview").on('click', function () {
                var d = new Date();
                h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
                m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                $("#MainContent_txtEndTimeofReview").val(h + ':' + m);
                $("#MainContent_txtEndTimeofReview2").val(h + ':' + m);
            });
        });

        $(function () {
            $("#btnEndTimeofReview2").on('click', function () {
                var d = new Date();
                h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
                m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                $("#MainContent_txtEndTimeofReview").val(h + ':' + m);
                $("#MainContent_txtEndTimeofReview2").val(h + ':' + m);
            });
        });
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
                         <h2 style="color: black; font-size: 25px; font-family: Calibri;">Call Center Monitoring - Enter New Call</h2>
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
                                            <li><a href="ChecksSearch.aspx">Servicer Check Report</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Monitoring</a>
                                        <ul>
                                            <li><a href="FormB.aspx">Enter Call</a></li>
                                            <li><a href="MyReviews.aspx">My Reviews</a></li>
                                            <li><a href="Checks.aspx">Add Servicer Check</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Call Centers-->
                                <asp:SqlDataSource ID="dsCallCenters" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
                                    SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />
                               
                                 <div align="left" style="padding-top: 10px" id="tabs-1">
                                  <%-- <asp:UpdatePanel id="pnlupdate1" runat="server">
                                        <ContentTemplate> --%>      
                                            
                                            <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>                                             
                                                
                                                <td width="25%"><strong>Call Center Location:</strong><br />
                                                    <asp:DropDownList ID="ddlCallCenterID" runat="server" TabIndex="1" 
                                                        DataSourceID="dsCallCenters" Height="25px"
                                                        AppendDataBoundItems="true" DataTextField="CallCenter" 
                                                        DataValueField="CallCenterID">
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
                                                    <asp:TextBox ID="txtBeginTimeofReview" runat="server" Width="175px" TabIndex="3"  />
                                                    <button type="button" class="btn btn-default btn-sm" Height="20" Width="20" name="btnBeginTimeofReview" id="btnBeginTimeofReview"><span class="glyphicon glyphicon-time"></span></button>
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Beginning Time of Review  * " ControlToValidate="txtBeginTimeofReview" ValidationGroup="FormB" />
                                                </td>
                                                <td width="25%">
                                                    <strong>End Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtEndTimeofReview" runat="server" Width="175px" TabIndex="3"  />
                                                    <button type="button" class="btn btn-default btn-sm" Height="20" Width="20" name="btnEndTimeofReview" id="btnEndTimeofReview"><span class="glyphicon glyphicon-time"></span></button>
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the End Time of Review  * " ControlToValidate="txtEndTimeofReview" ValidationGroup="FormB" />
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
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the borrower Account No or NSLDS ID  * " ControlToValidate="txtBorrowerAccountNumber" ValidationGroup="FormB" />
                                                </td>
                                                <td width="25%" valign="top"><strong><asp:Label ID="lblInboundOutbound" runat="server" Text="Inbound/Outbound:" /></strong><br />
                                                    <asp:DropDownList ID="ddlInboundOutbound" runat="server" Height="25px" TabIndex="4">
                                                        <asp:ListItem Selected="True" Text="Inbound" Value="Inbound" />
                                                        <asp:ListItem Text="Outbound" Value="Outbound" />
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="25%" valign="top"><strong><asp:Label ID="lblSpecialtyLine" runat="server" Text="Specialty Line:" /></strong><br />
                                                    <asp:DropDownList ID="ddlSpecialtyLine" runat="server" Height="25px">
                                                        <asp:ListItem Text="" Value="" Selected="True" />
                                                        <asp:ListItem Text="Accessibility Requests" Value="Accessibility Requests" />
                                                        <asp:ListItem Text="Borrower Defense" Value="Borrower Defense" />
                                                        <asp:ListItem Text="Consolidation" Value="Consolidation" />
                                                        <asp:ListItem Text="Default Aversion" Value="Default Aversion" />
                                                        <asp:ListItem Text="IDR Campaign Calls" Value="IDR Campaign Calls" />
                                                        <asp:ListItem Text="Military" Value="Military" />
                                                        <asp:ListItem Text="PSLF" Value="PSLF" />
                                                        <asp:ListItem Text="School" Value="School" />
                                                        <asp:ListItem Text="TEACH" Value="TEACH" />
                                                        <asp:ListItem Text="Visually Impaired" Value="Visually Impaired" />
                                                        <asp:ListItem Text="WC/Scheduled Callbacks" Value="WC/Scheduled Callbacks" />
                                                    </asp:DropDownList> </td> 
                                                <td width="25%" valign="top"><strong><asp:Label ID="lblEscalated" runat="server" Text="Escalate This Call?" /></strong> <br />
                                                    <asp:DropDownList ID="ddlEscalated" runat="server" Height="25px">
                                                        <asp:ListItem Text="No" Value="No" Selected ="True" />
                                                        <asp:ListItem Text="Yes" Value="Yes" />
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="25%" valign="top"> </td>
                                                <td width="25%" valign="top"> </td>                                                  
                                            </tr>
                                            <tr>
                                                <td colspan="4"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                            </tr>
                                            </table>                                        
                                          
                                     <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                        <tr>
                                            <td width="33%">
                                                <b>Introduction/Greeting</b>
                                            </td>
                                            <td width="33%">
                                                <b>Authentication/Demographics</b>
                                            </td>
                                            <td width="33%">
                                                <b>Professionalism/Accuracy/Urgency</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" width="33%" class="fieldTitle">
                                                <asp:CheckBox ID="chkintro_identified_self" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Identified Self" data-content="Agent clearly identify self"> Identified self</a><br />
                                                <asp:CheckBox ID="chkintro_identified_agency" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Identified Agency" data-content="Agent clearly identified agency"> Identified agency</a><br />
                                                <asp:CheckBox ID="chkintro_calls_recorded" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Advised calls may be monitored" data-content="Agent advise calls may be monitored or recorded for quality assurance"> Advised calls may be monitored</a><br />                    
                                            </td>
                                            <td valign="top" width="33%" class="fieldTitle">
                                                <asp:CheckBox ID="chkauth_borrower_name" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Verified borrower name and DOB" data-content="Agent verified the borrower's first and last name and DOB. If the borrower does not verify by DOB, the last 4 of SSN must be verified"> Verified borrower name and DOB</a><br />
                                                <asp:CheckBox ID="chkauth_id_procedures" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Followed proper identification procedures" data-content="If the customer is not the borrower, the agent must follow Immediate Family Member (IFM) and third party authorization procedures"> Followed proper identification procedures</a><br />
                                                <asp:CheckBox ID="chkauth_address" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Verified/updated the address" data-content="Verified/updated the address"> Verified/updated the address</a><br />
                                                <asp:CheckBox ID="chkauth_phone_number" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Verified/updated the phone number" data-content="Verified/updated the phone number"> Verified/updated the phone number</a><br />
                                                <asp:CheckBox ID="chkauth_email" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Verified/updated the email address" data-content="Verified/updated the email address"> Verified/updated the email address</a><br />                                                
                                            </td>
                                            <td valign="top" width="33%" class="fieldTitle">
                                                <asp:CheckBox ID="chkaccuracy_polite" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Was polite" data-content="Agent was polite with overall tone of voice, attitude and demeanor"> Was polite</a><br />
                                                <asp:CheckBox ID="chkaccuracy_enunciating_words" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Was enunciating words properly" data-content="Agent was enunciating words properly and was not chewing or eating while on the phone"> Was enunciating words properly</a><br />
                                                <asp:CheckBox ID="chkaccuracy_mainted_control" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Maintained control of the call" data-content="Agent maintained appropriate control of the call"> Maintained control of the call</a><br />
                                                <asp:CheckBox ID="chkaccuracy_accurate_info" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Provided accurate information" data-content="Agent provided accurate information to the borrower and answered inquiries accurately"> Provided accurate information</a><br />
                                                <asp:CheckBox ID="chkaccuracy_expedient_correspondence" runat="server" Checked="True" /><a href="#" data-toggle="popover" title="Encouraged fast correspondence turnaround" data-content="Agent encouraged expedient correspodence turnaround (if applicable)"> Encouraged fast correspondence turnaround</a><br />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                        <tr>
                                            <td colspan="2">
                                                <hr noshade="noshade" style="height: 1px; color: #000000" />
                                            </td>
                                        </tr>
                                        <tr>
                                           <td colspan="2">
                                               <b>Method of Resolution</b><br />
                                               Select the method(s) of resolution the agent used to address the call
                                           </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            <%--<asp:CheckBox ID="chkResolution_Delinquency" CssClass="Resolution" Text="Delinquency" runat="server" />--%>
                                            <input type="checkbox" name="chkResolution_Delinquency" value="delinquency" class="resolution" /> Basic Counseling<br />
                                            <input type="checkbox" name="chkResolution_Military" value="military" class="resolution" /> Special Consideration for Members of the Military<br />
                                            <input type="checkbox" name="chkResolution_PSLF" value="pslf" class="resolution" /> PSLF<br />
                                            <input type="checkbox" name="chkResolution_TLF" value="tlf" class="resolution" /> TLF<br />
                                            <input type="checkbox" name="chkResolution_TEACH" value="teach" class="resolution" /> TEACH<br />
                                            <input type="checkbox" name="chkResolution_TPD" value="tpd" class="resolution" /> TPD<br />
                                            <input type="checkbox" name="chkResolution_IDR" value="idr" class="resolution" /> IDR</td>
                                            <td><input type="checkbox" name="chkResolution_Deferment" value="deferment" class="resolution" /> Deferment<br />
                                            <input type="checkbox" name="chkResolution_Forbearance" value="forbearance" class="resolution" /> Forbearance<br />
                                            <input type="checkbox" name="chkResolution_NegativeAmortization" value="amortization" class="resolution" /> Negative Amortization and Capping vs Non-Capping Events<br />
                                            <input type="checkbox" name="chkResolution_LoanDischarge" value="discharge" class="resolution" /> Loan Discharge<br />
                                            <input type="checkbox" name="chkResolution_Documentation" value="documentation" class="resolution" /> Documentation<br />
                                            <input type="checkbox" name="chkResolution_Payments" value="payments" class="resolution" /> Payments<br />
                                            <input type="checkbox" name="chkResolution_Consolidation" value="consolidation" class="resolution" /> Consolidation<br />
                                            <input type="checkbox" name="chkResolution_Other" value="other" class="resolution" /> Unknown/Misc/Other<br />
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td colspan="2">
                                                <hr noshade="noshade" style="height: 1px; color: #000000" />
                                            </td>
                                        </tr>                                       
                                    </table>                          
                                    
                                    <!--Delinquency-->
                                    <div id="divResolution_Delinquency" class="container, fieldTitle, resolutionBox">                                        
                                        <span><b>Basic Counseling</b></span><br />                                        
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddldelinquency_days_delinquent" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised of days delinquent past due amount and upcoming payment" data-content="Agent advised of the day’s delinquent, past due amount and upcoming payment"> Advised of delinquency amount and upcoming payment</a>
                                        <br />
                                        
                                        <asp:Dropdownlist ID="ddldelinquency_past_due_amount" runat="server" CssClass="resolutionDDL">
                                        <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Asked for full past due amount" data-content="Agent inquired for past due payment in full to cover the delinquency prior to the next due date. 
                                            If the borrower could cover the past due payment, the agent must ensure that the borrower can continue making payments before continuing with that resolution"> Asked for full past due amount </a>    
                                        <br />
                                            
                                        <asp:Dropdownlist ID="ddldelinquency_forbearance" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Offered forbearance" data-content="If payment cannot be made and the borrower has forbearance time remaining, the agent must offer a forbearance to bring the account current to resume the next monthly installment that is due."> Offered forbearance</a>
                                        </div>

                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddldelinquency_lower_payment_option" runat="server" CssClass="resolutionDDL">
                                         <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Offered Lower Payment Options" data-content="If payments cannot be made the following month, the agent must offer a lower payment option, focusing on IDR programs first.
                                            When focusing on the IDR plans, the agent must (1) Explain the IDR options (2) Explain questions about payment amount, denials and income verification
                                            (3) Must explain that it must be completed online or via an application that must be returned to ensure the borrower is properly placed on the plan"> Offered Lower Payment Options</a>
                                        <br />
                                       
                                        <asp:Dropdownlist ID="ddldelinquency_deferment_option" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Offered deferment options" data-content="If lower payments are still not an option then deferment options must be reviewed before forbearance options"> Offered deferment options</a>                                
                                       </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />
                                    </div>

                                    <!--Military-->
                                    <div id="divResolution_Military" class="container, fieldTitle, resolutionBox">                                        
                                        <span><b>Special Consideration for Members of the Military</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlmilitary_programs" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Identified which program(s) borrower may qualify for" data-content="Can the agent identify which program(s) the service member may qualify for?">Identified which program(s) borrower may qualify for</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlscra_eligibility_requirements" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Described eligibility requirements for SCRA" data-content="Agent described the eligibility requirements to receive SCRA benefits">Described eligibility requirements for SCRA</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlscra_borrower_eligibility" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Verified SCRA eligibility" data-content="Agent properly verified service member eligibility for SCRA benefits">Verified SCRA eligibility</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlscra_loan_eligibility" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Loan Eligibility" data-content="Agent is able to discuss loan eligibility">Agent is able to discuss loan eligibility</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlscra_benefits" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Benefits of SCRA" data-content="Agent is able to describe the benefits of SCRA">Agent is able to describe the benefits of SCRA</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlhostility_no_interest_payments" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="No interest payments are required on Direct Loans" data-content="No interest payments are required on Direct Loans made on or after October 1, 2008, for up to 60 months">No interest payments are required on Direct Loans</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlhostility_zero_interest" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="0% interest" data-content="Service member qualifies for 0 percent interest, documentation indicating that are serving in a hostile pay area must be submitted">0% interest</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlmilitary_deferment1" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Military deferment during war or emergency" data-content="During a period of active duty military service during a war, military operation, or national emergency">Military deferment during war or emergency</a>
                                        </div>

                                        <div class="col-md-6">                                       
                                        <asp:Dropdownlist ID="ddlmilitary_deferment2" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Military deferment after service" data-content="During the 13 months following the conclusion of qualifying active duty military service, or until you return to enrollment on at least a half-time basis, whichever is earlier, if: you are a member of the National Guard or other reserve component of the U.S. armed forces and you were called or ordered to active duty while enrolled at least half-time at an eligible school or within six months of having been enrolled at least half-time">Military deferment after service</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlnational_guard_forbearance" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Guard Member is not eligible for the Military Service deferment" data-content="Guard Member is not eligible for the Military Service deferment, but is called to State active duty that qualifies for the Post-Active Duty Student deferment">Guard Member is not eligible for the Military Service deferment</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlnational_guard_activated_6_months" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Guard member activated within 6 months of enrollment" data-content="Guard Member must have been activated to National Guard duty within six months of being enrolled in school at least half time">Guard member activated within 6 months of enrollment</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlnational_guard_fed_loans_eligible" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Only federal loans are eligible" data-content="Only federal loans are eligible">Only federal loans are eligible</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddldod_forbearance" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="" data-content="Eligibility varies by agency. Talk to your commanding officer to find out if you are eligible">Eligible for mandatory forbearance</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddldod_forbearance_fed_loans_eligible" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Only federal loans are eligible" data-content="">Only federal loans are eligible for Dod mandatory forbearance</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddldod_postpone_payments" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Temporarily postpone payments by applying for DoD forbearance" data-content="If the service member is in the National Guard and waiting for a military student loan payment to go through, he or she can temporarily postpone your payments by applying for this forbearance">Postpone payments by applying for DoD forbearance</a>
                                        <br />
                                      </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />
                                    </div>

                                    <!--PSLF-->
                                    <div id="divResolution_PSLF" class="container, fieldTitle, resolutionBox">
                                        <span><b>PSLF</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                            <asp:Dropdownlist ID="ddlpslf_eligibility" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Eligibility for PSLF" data-content="Agent properly described the eligibility requirements to qualify for PSLF">Eligibility for PSLF</a>
                                        <br />
                                            <asp:Dropdownlist ID="ddlpslf_loan_types" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained PSLF Loan Types" data-content="Agent properly advised of loan types available for PSLF, if prompted by the borrower">Explained PSLF loan types</a>
                                        <br />
                                        <asp:Dropdownlist ID="ddlpslf_other_options" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="How to qualify for PSLF" data-content="Agent properly advised the borrower of options available to qualify for PSLF if the borrower is ineligible">How to qualify for PSLF</a>
                                        <br />
                                            <asp:Dropdownlist ID="ddlpslf_120_payments" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="120 qualifying payments" data-content="Agent properly advised the borrower of the payment requirement of 120 qualifying payments for PSLF eligibility">120 qualifying payments</a>
                                        </div>

                                        <div class="col-md-6">
                                            <asp:Dropdownlist ID="ddlpslf_eligible_payment_plan" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Eligible payment plan" data-content="Agent properly advised the borrower to make payments under an eligible repayment plan">Eligible payment plan</a>
                                        <br />

                                         <asp:Dropdownlist ID="ddlpslf_fulltime_employment" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Maintain a full-time employment status" data-content="Agent properly advised borrower of maintaining a full-time employment status around PSLF">Maintain a full-time employment status</a>
                                        <br />

                                         <asp:Dropdownlist ID="ddlpslf_work_for_pso" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Work for a qualifying Public Service Organization" data-content="Agent properly advised the borrower of work for a qualifying Public Service Organization">Work for a qualifying Public Service Organization</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlpslf_consolidating" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Consolidation" data-content="If the borrower is consolidating their loans, the agent must convey the following: Consolidating could Make Loans Eligible for PSLF; Information about Qualifying Payments for PSLF; Repayment Options for PSL">Consolidation</a>
                                        </div>
                                        </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />
                                      </div>
                                   <!--TLF-->
                                   <div id="divResolution_TLF" class="container, fieldTitle, resolutionBox">
                                        <span><b>TLF</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlteacher_forgiveness_described_eligibility" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Agent described eligibility criteria" data-content="Agent properly described eligibility criteria based on the program qualifications">Agent described eligibility criteria</a>
                                        <br /> 
                                        <asp:Dropdownlist ID="ddlteacher_forgiveness_how_to_apply" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Agent explained how to apply" data-content="Agent explained how to apply for Teacher Loan Forgiveness">Agent explained how to apply</a>
                                        </div> 
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlteacher_forgiveness_explained_benefit" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Agent explained benefit" data-content="Agent explained Teacher Loan Forgiveness Benefit">Agent explained benefit</a>
                                        </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />
                                    </div>                
                                    
                                   <!--TEACH-->
                                   <div id="divResolution_TEACH" class="container, fieldTitle, resolutionBox">
                                        <span><b>TEACH</b></span><br />
                                       <div class="row"> 
                                       <div class="col-md-6">
                                            <asp:Dropdownlist ID="ddlteach_advised_conditions" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained conditions for receiving a TEACH Grant" data-content="Agent properly advised the conditions for receiving a TEACH Grant">Explained conditions for receiving a TEACH Grant</a>
                                        <br />                                       
                                        
                                            <asp:Dropdownlist ID="ddlteach_advised_borrower" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Must sign a TEACH Grant Agreement to serve" data-content="Agent properly advised the borrower must sign a TEACH Grant Agreement to Serve">Must sign a TEACH Grant Agreement to serve</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddlteach_advised_service_must_be_completed" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="TEACH Grant funds received will be converted to a Direct Unsubsidized Loan" data-content="Agent properly advised the borrowers that if the service obligation is not complete, all TEACH Grant funds received will be converted to a Direct Unsubsidized Loan.  This loan must be repaid to the Department of Education, with interest charged from the date the TEACH Grant was disbursed">TEACH Grant funds received will be converted to a Direct Unsubsidized Loan</a>
                                        </div>
                                        
                                       <div class="col-md-6">
                                            <asp:Dropdownlist ID="ddlteach_must_teach_needed_capacity" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="" data-content="Agent properly advised the borrower must agree to teach in the needed capacity">Must agree to teach in the needed capacity</a>
                                        <br />
                                            <asp:Dropdownlist ID="ddlteach_may_request_suspension" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="May request a temporary suspension" data-content="Agent properly advised that students may request a temporary suspension of the eight-year period for completing their TEACH Grant service obligation">May request a temporary suspension</a>
                                        </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />
                                    </div>

                                    <!--TPD-->
                                    <div id="divResolution_TPD" class="container, fieldTitle, resolutionBox">
                                        <span><b>TPD</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddltpd_how_to_apply_for_TPD" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained how to apply for TPD" data-content="Agent properly advised of methods by which to apply for TPD">Explained how to apply for TPD</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddltpd_collection_will_suspend_120_days" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Collection will suspend 120 days" data-content="Agent properly informed borrower collection will suspend 120 days to allow applicant the opportunity to complete application and submit documentation">Collection will suspend 120 days</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddltpd_document_disability" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="3 ways to document disability" data-content="Agent properly informed the three ways to document disability">3 ways to document disability</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddltpd_advised_TPD_application" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised of the TPD application process" data-content="Agent advised of the TPD application process once information is received">Advised of the TPD application process</a>
                                        <br />
                                        
                                        <asp:Dropdownlist ID="ddltpd_procedures_approves_TPD_discharge" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised proper procedures after receipt" data-content="Agent advised proper procedures when the Department Approves TPD discharge request for the following circumstances: Veteran or SSA or Physician Certification">Advised proper procedures after receipt</a>
                                        </div>
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddltpd_TPD_monitoring_period" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="3 year post-discharge monitoring period" data-content="Agent advised the requirements for 3 year post-discharge monitoring period">3 year post-discharge monitoring period</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddltpd_advised_reinstatements" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised of reinstatements" data-content="Agent properly advised of reinstatements (if applicable to the borrower’s situation)">Advised of reinstatements</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddltpd_new_loans_teach_grants" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised of future eligibility for new loans or grants" data-content="Agents properly advised of future eligibility for new loans or TEACH Grants">Advised of future eligibility for new loans or grants</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddltpd_advised_TPD_refund_procedures" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised of refund procedures" data-content="Agent properly advised of TPD – refund procedures at the direction of the Department">Advised of refund procedures</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddltpd_1099_sent" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="1099C will be sent" data-content="Agent properly advised that a 1099C will be sent after loans and/or TEACH Grants are discharged for amounts at or in excess of $600 for tax filing purposes">1099C will be sent</a>
                                      
                                        </div>
                                      </div>  
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />
                                    </div>

                                    <!--IDR-->
                                    <div id="divResolution_IDR" class="container, fieldTitle, resolutionBox">
                                        <span><b>IDR</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                            <asp:Dropdownlist ID="ddlidr_eligibility" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Discussed the borrower's eligibility" data-content="Agent properly discussed the borrower's eligibility for the IDR plans that are available">Discussed the borrower's eligibility</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlidr_how_payments_calculated" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="How monthly payments are calculated" data-content="Agent properly explained the following (when asked by the borrower) how monthly payments are calculated under the IDR">How monthly payments are calculated</a>
                                        </div> 
                                        <div class="col-md-6">    
                                        <asp:Dropdownlist ID="ddlidr_qualifying_loans" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained the Title IV loans that qualify" data-content="Agent properly explained (when asked by the borrower) the Title IV loans that qualify for the IDR plan">Explained the Title IV loans that qualify</a>
                                        <br />
                                            
                                        <asp:Dropdownlist ID="ddlidr_how_to_apply" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="How to apply" data-content="Agent properly advised (when asked by the borrower) how to apply for an IDR plan">How to apply</a>

                                        </div>
                                      </div> 
                                        <hr noshade="noshade" style="height: 1px; color: #000000" /> 
                                    </div>

                                    <!--Deferment-->
                                    <div id="divResolution_Deferment" class="container, fieldTitle, resolutionBox">
                                        <span><b>Deferment</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                            <asp:Dropdownlist ID="ddldeferment_meaning_deferment" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Meaning of deferment" data-content="Agent properly explained the meaning of deferment when requested by the borrower">Meaning of deferment</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddldeferment_qualifying_deferment" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised the borrower if he/she qualifies" data-content="Agent properly advised the borrower if he/she qualifies for a deferment based on the type of loan the borrower has">Advised the borrower if he/she qualifies</a>
                                        </div>
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddldeferment_how_to_apply" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Advised the borrower how s/he applies for deferment" data-content="Agent properly advised the borrower (when asked by the borrower) how he/she applies for deferment">Advised the borrower how s/he applies for deferment</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddldeferment_length" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Borrower understands how long s/he may defer payment" data-content="Agent properly ensured that the borrower understands how long he/she may defer payment on the loan">Borrower understands how long s/he may defer payment</a>
                                        </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />  
                                    </div>

                                    <!--Forbearance-->
                                    <div id="divResolution_Forbearance" class="container, fieldTitle, resolutionBox">
                                        <span><b>Forbearance</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlforbearance_not_qualified_for_deferment" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Not qualified for deferment but qualified for forbearance" data-content="Agent properly ensured that the borrower did not qualify for deferment, but in fact qualified for forbearance">Not qualified for deferment but qualified for forbearance</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlforbearance_explained_meaning" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained the meaning of forbearance" data-content="Agent properly explained the meaning of forbearance when requested by the borrower">Explained the meaning of forbearance</a>
                                        <br />
                                        <asp:Dropdownlist ID="ddlforbearance_provided_documentation" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Provided the borrower with the documentation" data-content="Agent properly provided the borrower with the documentation that must be submitted in addition to the application if necessary">Provided the borrower with the documentation</a>
                                        </div>
                                        <div class="col-md-6">                                          
                                         <asp:Dropdownlist ID="ddlforbearance_explained_different_types" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained the difference between the types of forbearances" data-content="Agent properly explained the difference between the two types of forbearances: Discretionary/Mandatory">Explained the difference between the types of forbearances</a>        
                                        <br />
                                         <asp:Dropdownlist ID="ddlforbearance_read_script" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Read Forbearance Script" data-content="Agent properly read forbearance terms and submitted after borrower agreed">Read forbearance script</a>        
                                        <br />
                                        
                                        </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />  
                                    </div>

                                    <!--Negative Amortization-->
                                    <div id="divResolution_NegativeAmortization" class="container, fieldTitle, resolutionBox">
                                        <span><b>Negative Amortization</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlamortization_loan_amount_growing" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained why loan amount is getting larger" data-content="Agent properly advised the borrower why his/her loan amount is getting larger and not paid down">Explained why loan amount is getting larger</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlamortization_which_payment_plan" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained which payment plan would reduce balance" data-content="Agent properly explained which payment plan a borrower would need in order to reduce the loan balance">Explained which payment plan would reduce balance</a>
                                        </div>
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlamortization_interest_capitalization" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Explained interest capitalization" data-content="Agent properly explained to the borrower that if the payment does not cover interest, the interest will become a part of principal (interest capitalization)">Explained interest capitalization</a>
                                        </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />  
                                    </div>

                                    <!--Loan Discharge-->
                                    <div id="divResolution_LoanDischarge" class="container, fieldTitle, resolutionBox">
                                        <span><b>Loan Discharge</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                       <asp:Dropdownlist ID="ddlclosed_school_criteria" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Closed School - explained criteria" data-content="Agent properly advised the criteria for a discharge and eligibility for a discharge">Closed School - explained criteria</a>
                                        <br />

                                         <asp:Dropdownlist ID="ddlclosed_school_process" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Closed School - explained process" data-content="Agent properly advised the discharge process">Closed School - explained process</a>
                                        <br />

                                         <asp:Dropdownlist ID="ddlclosed_school_approve_deny" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Closed School - explained process after discharge" data-content="Agent properly advised (when asked by the borrower) what happens if a loan discharge is approved or denied">Closed School - explained process after discharge</a>
                                        <br /><br />

                                        <asp:Dropdownlist ID="ddlbankruptcy_bankruptcy_filed" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Bankruptcy - borrower has filed" data-content="Agent properly identified, after being notified by the borrower, endorser or third party, an instance of bankruptcy filing with intent to file or that the party has filed">Bankruptcy - borrower has filed</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlbankruptcy_additional_information" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Bankruptcy - agent obtained additional info" data-content="Agent obtained, or attempted to obtain, information such as filings date, case number, or Any additional information provided by the party providing the information">Bankruptcy - agent obtained additional info</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlbankruptcy_mailing_address" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Bankruptcy - advised to send documentation" data-content="Agent advised to submit any supporting documentation to the mailing address/fax/e-mail for further review">Bankruptcy - advised to send documentation</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlbankruptcy_notified_internal_parties" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Bankruptcy - notified the parties for monitoring" data-content="Agent properly notified the correct internal parties for monitoring of the account and potential forbearance application during the period of bankruptcy monitoring">Bankruptcy - notified the parties for monitoring</a>
                                        <br /><br />
                                            
                                        <asp:Dropdownlist ID="ddldeath_deceased_borrower" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Death - identified borrower" data-content="Agent properly identified, after being notified, an instance of a deceased borrower or endorser">Death - identified borrower</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddldeath_collected_info_third_party" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Death - collected info from 3rd party" data-content="Agent collected information from the third party (authorized or unauthorized)">Death - collected info from 3rd party</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddldeath_send_documentation" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Death - notified the correct internal parties" data-content="Agent properly notified the correct internal parties of the instance for monitoring of the account and to send proper documentation to the closest living relative to return a death certificate for potential discharge">Death - notified the correct internal parties</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddldeath_death_cert_mailing_address" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Death - gave address for death cert" data-content="Agent advised of the mailing address to send the Death Certificate of the deceased borrower or endorser to expedite the process of review and potential discharge">Death - gave address for death cert</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddldeath_identified_circumstances" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Death - identified circumstances" data-content="Agent properly identified specific circumstances, provided below, and counseled accordingly">Death - identified circumstances</a>
                                        </div>
                                        <div class="col-md-6">
                                            <asp:Dropdownlist ID="ddlatb_eligibility_requirements" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="ATB - discussed eligibilty requirements" data-content="Agent properly counseled the borrower on their option for discharge based on the following eligibility requirements">ATB - discussed eligibilty requirements</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddlatb_take_test" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="ATB - must take test" data-content="Agent properly advised that in order for the borrower to show the ability to benefit, a test must have been taken and passed">ATB - must take test</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddlatb_advised_loans_may_be_discharged" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="ATB - advised loans may be discharged" data-content="Agent properly advised the borrower’s and parent PLUS borrower’s loans (and any endorser) may be discharged if the borrower was improperly certified with the ability to benefit">ATB - advised loans may be discharged</a>
                                        <br />

                                       <asp:Dropdownlist ID="ddlatb_how_to_send_application" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="ATB - How to obtain app" data-content="Agent advised how to obtain an application and offered to send to the borrower">ATB - How to obtain app</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlatb_how_to_complete" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="ATB - How to complete app" data-content="Agent provided instruction on how to complete the application and return any documentation to support the request for discharge">ATB - How to complete app</a>
                                        <br /><br />

                                        <asp:Dropdownlist ID="ddlfalsecert_eligibility_requirements" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="False Cert - agent identified that borrower may be eligible" data-content="Agent properly identified that the borrower may be eligible for a False Certification Discharge if the borrower’s loan application or promissory note was falsely certified">False Cert - agent identified that borrower may be eligible</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlfalsecert_how_to_send_application" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="False Cert - how to obtain and send app" data-content="Agent advised how to obtain an application and offered to send to the borrower">False Cert - how to obtain and send app</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddlfalsecert_how_to_complete" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="False Cert - how to complete app" data-content="Agent provided instruction on how to complete the application and return any documentation to support the request for discharge">False Cert - how to complete app</a>
                                        <br /><br />

                                            <asp:Dropdownlist ID="ddlfalsecert_refund_unpaid_refund" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="False  Refund - identified an unpaid refund" data-content="Agent properly identified an unpaid refund and explained the concept of an unpaid refund to the borrower">False Cert Refund - identified an unpaid refund</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlfalsecert_refund_how_to_send_application" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="False Cert Refund - how to obtain and send app" data-content="Agent advised how to obtain an application and offered to send to the borrower">False Cert Refund - how to obtain and send app</a>
                                        <br />

                                            <asp:Dropdownlist ID="ddlfalsecert_refund_how_to_complete" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="False Cert Refund - how to complete app" data-content="Agent provided instruction on how to complete the application and return any documentation to support the request for discharge">False Cert Refund - how to complete app</a>

                                        </div>
                                      </div> 
                                        <hr noshade="noshade" style="height: 1px; color: #000000" /> 
                                    </div>

                                    <!--Documentation-->
                                    <div id="divResolution_Documentation" class="container, fieldTitle, resolutionBox">
                                        <span><b>Documentation</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddldocumentation_accuracy" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Documented and logged call" data-content="Agent documented the call and relevant information accurately">Documented and logged call</a>
                                        </div>
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddldocumentation_logged_complaint" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Documented and logged complaint" data-content="Agent documented and logged complaint information (if applicable)">Documented and logged complaint</a>
                                        <br />
                                        </div>
                                      </div> 
                                        <hr noshade="noshade" style="height: 1px; color: #000000" /> 
                                    </div>

                                    <!--Payments-->
                                    <div id="divResolution_Payments" class="container, fieldTitle, resolutionBox">
                                        <span><b>Payments</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlpayment_accessing_web_account" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Help accessing web site" data-content="Agent was able to assist the borrower if he or she was having trouble accessing his or her web based account in order to make a payment (if the servicer offered that service)">Help accessing web site</a>
                                        <br />
                                        <asp:Dropdownlist ID="ddlpayment_direct_debit" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Set up a direct debit" data-content="The agent was able to assist the borrower in how to set up a direct debit to make the borrower’s payment by direct debit from his or her checking account">Set up a direct debit</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlpayment_phone_payment" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Take a payment over the phone" data-content="Agent was able to take a payment through the phone using the routing numbers for the borrower’s checking account">Take a payment over the phone</a>
                                        </div>
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlpayment_creditcards_not_accepted" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Credit cards not accepted" data-content="Depending on the servicer, the agent was able to explain the servicer did not take credit/debit cards to make payments on a federally insured student loan">Credit cards not accepted</a>
                                        <br />

                                        <asp:Dropdownlist ID="ddlpayment_creditcards_emergency" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Credit cards accepted in emergencies" data-content="If the servicer takes credit and debit cards, the agent was able to explain the card could not be taken unless the borrower’s payment was overdue and the borrower was at eminent risk of default OR The borrower is living abroad and has no United States banking relationship the use of a credit/debit card is acceptable as the borrower would otherwise have a limited ability to make a payment any other way.">Credit cards accepted in emergencies</a>
                                        <br />
                                        </div>
                                      </div>
                                    </div>

                                   <!--Consolidation-->
                                   <div id="divResolution_Consolidation" class="container, fieldTitle, resolutionBox">
                                        <span><b>Consolidation</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlconsolidation_explained_benefits" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Agent explained benefits" data-content="Agent explained (when asked by the borrower) benefits of Consolidation">Agent explained benefits</a>
                                        <br /> 
                                        <asp:Dropdownlist ID="ddlconsolidation_program_requirements" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Agent properly explained the program requirements" data-content="Agent properly explained the program requirements for Consolidation">Agent properly explained the program requirements</a>
                                        </div> 
                                         <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlconsolidation_loan_types" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Agent properly advised of loan types available" data-content="Agent properly advised of loan types available for Consolidation">Agent properly advised of loan types available</a>
                                        <br /> 
                                        <asp:Dropdownlist ID="ddlconsolidation_explained_app_process" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Agent explained the application process" data-content="Agent properly explained the application process">Agent explained the application process</a>
                                        </div>
                                      </div>
                                        <hr noshade="noshade" style="height: 1px; color: #000000" />
                                    </div>  

                                    <!--Other-->
                                    <div id="divResolution_Other" class="container, fieldTitle, resolutionBox">
                                        <span><b>Unknown/Misc/Other</b></span><br />
                                        <div class="row">
                                        <div class="col-md-6">
                                        <asp:Dropdownlist ID="ddlresolution_other" runat="server" CssClass="resolutionDDL">
                                            <asp:ListItem Text="" Value="" Selected="True" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>
                                        <a href="#" data-toggle="popover" title="Unknown/Misc/Other" data-content="The call was resolved by another means other than those listed above">Unknown/Misc/Other</a>
                                        </div>
                                      </div>
                                    </div>
                                             
                                           
                                    
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                                <table width="100%" cellpadding="2" cellspacing="2" border="0">
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
                                                        <strong>End Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtEndTimeofReview2" runat="server" Width="175px" TabIndex="3"  />
                                                    <button type="button" class="btn btn-default btn-sm" Height="20" Width="20" name="btnEndTimeofReview2" id="btnEndTimeofReview2"><span class="glyphicon glyphicon-time"></span></button>                                                  
                                                    <br /> <asp:Button ID="btnAddCall" runat="server" CssClass="button" Text="Add Call" 
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

