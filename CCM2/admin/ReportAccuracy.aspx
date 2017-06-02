<%@ Page Title="Call Center Monitoring Accuracy Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportAccuracy.aspx.vb" Inherits="CCM_New_ReportAccuracy" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
    <style type="text/css">
    .sectionHeader {
        background-color: #5C9CCC;
        font-weight: bold;
    }

    .subjectHeader {
        background-color: #d8d4d4;
    }

</style>
       
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                        <h2>Call Center Monitoring - Accuracy Report</h2>
                        <div id="tabs">
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
                                <ul id="nav">
                                     <li><a href="../Help.aspx">Help</a></li>
                                     <li><a href="#">Reports</a>
                                        <ul>
                                            <li><a href="../MyProductivityReport.aspx">My Productivity</a></li>                                    
                                        </ul>
                                         
                                    </li>
                                    <li><a href="../Search.aspx">Search</a></li>
                                    <li><a href="#">Administration</a>
                                        <ul>                                           
                                            <li><a href="ReportCallsMonitored.aspx">Call Center Count</a></li>
                                            <li><a href="ReportFailedCalls.aspx">Failed Calls</a></li>
                                            <li><a href="ReportAccuracy.aspx">Accuracy Report</a></li>
                                            <li><a href="ReportIndividualProductivity.aspx">Productivity</a></li>
                                            <li><a href="ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
                                            <li><a href="Search.aspx">Search</a></li>
                                            <li><a href="../ChecksSearch.aspx">Servicer Check Report</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Monitoring</a>
                                        <ul>
                                            <li><a href="../FormB.aspx">Enter Call</a></li>
                                            <li><a href="../MyReviews.aspx">My Reviews</a></li>
                                            <li><a href="../Checks.aspx">Add Servicer Check</a></li>
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
                                    <table cellpadding="2" cellspacing="2" border="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <strong>Call Center:</strong><br />
                                                <asp:DropDownList ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters"
                                                    SelectionMode="Multiple" Rows="4" AppendDataBoundItems="true" DataTextField="CallCenter"
                                                    DataValueField="CallCenterID">
                                                    <asp:ListItem Text="" Value="" />
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlCallCenterID"
                                                    ErrorMessage="* Call Center is reqired" CssClass="warning" Display="Dynamic" />
                                            </td>
                                            <td valign="top">
                                                <strong>Begin Date of Review:</strong><br />                                                
                                                            <asp:TextBox ID="txtDateofReviewBegin" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="txtDateofReviewBegin" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic"/>                                                        
                                            </td>
                                            <td valign="top">
                                                <strong>End Date of Review:</strong><br />                                               
                                                            <asp:TextBox ID="txtDateofReviewEnd" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateofReviewEnd" ErrorMessage="*End Date is reqired" CssClass="warning" Display="Dynamic" />                                                         
                                            </td>
                                            <td valign="bottom">
                                                <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnAccuracyReport_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                    <p>
                                        &nbsp;</p>
                                </div>
                                <asp:Repeater ID="rptCenterProfile" runat="server">
                                <HeaderTemplate>
                                 <table width="900px" cellpadding="2" cellspacing="4" 
                                        style="background-color: White; border-style: solid; border-width: 1px; border-color: #5C9CCC;" 
                                        align="center">
                                </HeaderTemplate>
                                <ItemTemplate>       
                                    <tr>
                                        <td colspan="2"><strong>Calls Summary</strong></td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="50%">Passed Calls:</td>
                                        <td align="left" width="50%"><asp:Label ID="lblPassedCalls" runat="server" text='<%# Eval("PassedCalls") %>' /></td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="50%">Failed Calls:</td>
                                        <td align="left" width="50%"><asp:Label ID="lblFailedCalls" runat="server" text='<%# Eval("FailedCalls") %>' /></td>
                                    </tr>
                                     <tr>
                                        <td align="right" width="50%">Total Calls:</td>
                                        <td align="left" width="50%"><asp:Label ID="lblCallCount" runat="server" text='<%# Eval("CallCount") %>' /></td>
                                    </tr>  
    
                                </ItemTemplate>
                                <FooterTemplate>
                                        </table>
                                        </FooterTemplate> 
                                </asp:Repeater>
                                
                                <div>
                                    <asp:ImageButton ID="btnExportWordAccuracy" runat="server" CausesValidation="false" ImageUrl="../images/word.png"
                                    OnClick="btnExportWordAccuracy_Click" Height="25px" Width="25px" Visible="false" ToolTip="Export to Word" />
                                </div>
                                
                                <div id="divVariablePeriod" align="center">
                                    
                                    <asp:GridView ID="grdVariablePeriod" runat="server" AutoGenerateColumns="false" AllowSorting="false"
                                        BorderWidth="1px" BackColor="White" 
                                        CellPadding="3" BorderColor="#E7E7FF" Width="900px" BorderStyle="Solid" ShowFooter="false">
                                        <EmptyDataTemplate>
                                            No records matched your search
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>                                             
                                                    
                                                    <table width="100%" border="1" cellpadding="3" cellspacing="0">
                                                        <tr>
                                                            <td colspan="2" bgcolor="#5C9CCC"><h3>Introduction/Greeting</h3></td>
                                                        </tr>                                                      
                                                        <tr>
                                                            <td colspan="2" bgcolor="#d8d4d4"><h4>Identified Self</h4></td>
                                                        </tr> 
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label1" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="lblintro_identified_self_Passed" runat="server" Text='<%#Eval("intro_identified_self_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label7" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label8" runat="server" Text='<%#Eval("intro_identified_self_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label9" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label10" runat="server" Text='<%#Eval("intro_identified_self_PctngPassed")%>' /></td>
                                                        </tr>
                                                                                                         
                                                      
                                                       <%--intro_identified_agency--%>                                                      
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Identified Agency</h4></td>
                                                        </tr>                                                           
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label2" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label3" runat="server" Text='<%#Eval("intro_identified_agency_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label4" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label5" runat="server" Text='<%#Eval("intro_identified_agency_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label6" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label11" runat="server" Text='<%#Eval("intro_identified_agency_PctngPassed")%>' /></td>
                                                        </tr>                                                    
                                                     
                                                    
                                                    <%--intro_calls_recorded--%>                                                      
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised calls may be monitored</h4></td>
                                                        </tr>                                                            
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label12" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label13" runat="server" Text='<%#Eval("intro_calls_recorded_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label14" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label15" runat="server" Text='<%#Eval("intro_calls_recorded_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label16" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label17" runat="server" Text='<%#Eval("intro_calls_recorded_PctngPassed")%>' /></td>
                                                        </tr>  
                                                        <tr>
                                                            <td colspan="2" bgcolor="#5C9CCC"><h3>Authentication/Demographics</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Verified borrower name and DOB</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label24" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label25" runat="server" Text='<%#Eval("auth_borrower_name_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label26" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label27" runat="server" Text='<%#Eval("auth_borrower_name_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label28" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label29" runat="server" Text='<%#Eval("auth_borrower_name_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Followed proper identification procedures</h4></td>
                                                        </tr>                                                            
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label18" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label19" runat="server" Text='<%#Eval("auth_id_procedures_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label20" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label21" runat="server" Text='<%#Eval("auth_id_procedures_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label22" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label23" runat="server" Text='<%#Eval("auth_id_procedures_PctngPassed")%>' /></td>
                                                        </tr> 
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Verified/updated the address</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label30" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label31" runat="server" Text='<%#Eval("auth_address_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label32" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label33" runat="server" Text='<%#Eval("auth_address_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label34" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label35" runat="server" Text='<%#Eval("auth_address_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Verified/updated the phone number</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label36" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label37" runat="server" Text='<%#Eval("auth_phone_number_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label38" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label39" runat="server" Text='<%#Eval("auth_phone_number_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label40" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label41" runat="server" Text='<%#Eval("auth_phone_number_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Verified/updated the email address</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label42" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label43" runat="server" Text='<%#Eval("auth_email_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label44" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label45" runat="server" Text='<%#Eval("auth_email_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label46" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label47" runat="server" Text='<%#Eval("auth_email_PctngPassed")%>' /></td>
                                                        </tr>
                                                       
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Professionalism/Accuracy/Urgency</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Was polite</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label48" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label49" runat="server" Text='<%#Eval("accuracy_polite_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label50" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label51" runat="server" Text='<%#Eval("accuracy_polite_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label52" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label53" runat="server" Text='<%#Eval("accuracy_polite_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Was enunciating words properly</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label54" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label55" runat="server" Text='<%#Eval("accuracy_enunciating_words_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label56" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label57" runat="server" Text='<%#Eval("accuracy_enunciating_words_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label58" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label59" runat="server" Text='<%#Eval("accuracy_enunciating_words_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Maintained control of the call</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label60" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label61" runat="server" Text='<%#Eval("accuracy_mainted_control_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label62" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label63" runat="server" Text='<%#Eval("accuracy_mainted_control_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label64" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label65" runat="server" Text='<%#Eval("accuracy_mainted_control_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Provided accurate information</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label66" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label67" runat="server" Text='<%#Eval("accuracy_accurate_info_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label68" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label69" runat="server" Text='<%#Eval("accuracy_accurate_info_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label70" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label71" runat="server" Text='<%#Eval("accuracy_accurate_info_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Encouraged fast correspondence turnaround</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label72" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label73" runat="server" Text='<%#Eval("accuracy_expedient_correspondence_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label74" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label75" runat="server" Text='<%#Eval("accuracy_expedient_correspondence_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label76" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label77" runat="server" Text='<%#Eval("accuracy_expedient_correspondence_PctngPassed")%>' /></td>
                                                        </tr>
 
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Basic Counseling</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised of delinquency amount and upcoming payment</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label78" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label79" runat="server" Text='<%#Eval("delinquency_days_delinquent_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label80" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label81" runat="server" Text='<%#Eval("delinquency_days_delinquent_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label82" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label83" runat="server" Text='<%#Eval("delinquency_days_delinquent_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Asked for full past due amount</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label84" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label85" runat="server" Text='<%#Eval("delinquency_past_due_amount_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label86" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label87" runat="server" Text='<%#Eval("delinquency_past_due_amount_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label88" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label89" runat="server" Text='<%#Eval("delinquency_past_due_amount_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Offered Forbearance</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label90" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label91" runat="server" Text='<%#Eval("delinquency_forbearance_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label92" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label93" runat="server" Text='<%#Eval("delinquency_forbearance_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label94" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label95" runat="server" Text='<%#Eval("delinquency_forbearance_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Offered lower payment Options</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label96" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label97" runat="server" Text='<%#Eval("delinquency_lower_payment_option_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label98" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label99" runat="server" Text='<%#Eval("delinquency_lower_payment_option_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label100" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label101" runat="server" Text='<%#Eval("delinquency_lower_payment_option_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Offered Deferment Options</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label102" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label103" runat="server" Text='<%#Eval("delinquency_deferment_option_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label104" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label105" runat="server" Text='<%#Eval("delinquency_deferment_option_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label106" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label107" runat="server" Text='<%#Eval("delinquency_deferment_option_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Special Consideration for Members of the Military</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Identified which program(s) borrower may qualify for</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label108" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label109" runat="server" Text='<%#Eval("military_programs_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label110" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label111" runat="server" Text='<%#Eval("military_programs_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label112" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label113" runat="server" Text='<%#Eval("military_programs_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Described eligibility requirements for SCRA</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label120" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label121" runat="server" Text='<%#Eval("scra_eligibility_requirements_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label122" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label123" runat="server" Text='<%#Eval("scra_eligibility_requirements_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label124" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label125" runat="server" Text='<%#Eval("scra_eligibility_requirements_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent is able to discuss loan eligibility</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label132" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label133" runat="server" Text='<%#Eval("scra_loan_eligibility_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label134" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label135" runat="server" Text='<%#Eval("scra_loan_eligibility_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label136" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label137" runat="server" Text='<%#Eval("scra_loan_eligibility_PctngPassed")%>' /></td>
                                                        </tr>
      
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Identified which program(s) borrower may qualify for</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label114" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label115" runat="server" Text='<%#Eval("scra_eligibility_requirements_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label116" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label117" runat="server" Text='<%#Eval("scra_eligibility_requirements_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label118" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label119" runat="server" Text='<%#Eval("scra_eligibility_requirements_PctngPassed")%>' /></td>
                                                        </tr>
                                                        
                                                        
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Verified SCRA eligibility</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label126" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label127" runat="server" Text='<%#Eval("scra_borrower_eligibility_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label128" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label129" runat="server" Text='<%#Eval("scra_borrower_eligibility_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label130" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label131" runat="server" Text='<%#Eval("scra_borrower_eligibility_PctngPassed")%>' /></td>
                                                        </tr>
                                                        
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent is able to describe the benefits of SCRA</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label138" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label139" runat="server" Text='<%#Eval("scra_benefits_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label140" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label141" runat="server" Text='<%#Eval("scra_benefits_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label142" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label143" runat="server" Text='<%#Eval("scra_benefits_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>No interest payments are required on Direct Loans</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label144" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label145" runat="server" Text='<%#Eval("hostility_no_interest_payments_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label146" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label147" runat="server" Text='<%#Eval("hostility_no_interest_payments_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label148" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label149" runat="server" Text='<%#Eval("hostility_no_interest_payments_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>0% interest</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label150" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label151" runat="server" Text='<%#Eval("hostility_zero_interest_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label152" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label153" runat="server" Text='<%#Eval("hostility_zero_interest_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label154" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label155" runat="server" Text='<%#Eval("hostility_zero_interest_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Military deferment during war or emergency  Military deferment after service </h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label156" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label157" runat="server" Text='<%#Eval("military_deferment1_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label158" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label159" runat="server" Text='<%#Eval("military_deferment1_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label160" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label161" runat="server" Text='<%#Eval("military_deferment1_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Guard Member is not eligible for the Military Service deferment</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label162" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label163" runat="server" Text='<%#Eval("national_guard_forbearance_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label164" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label165" runat="server" Text='<%#Eval("national_guard_forbearance_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label166" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label167" runat="server" Text='<%#Eval("national_guard_forbearance_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Guard member activated within 6 months of enrollment</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label168" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label169" runat="server" Text='<%#Eval("national_guard_activated_6_months_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label170" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label171" runat="server" Text='<%#Eval("national_guard_activated_6_months_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label172" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label173" runat="server" Text='<%#Eval("national_guard_activated_6_months_PctngPassed")%>' /></td>
                                                        </tr>
                                                        
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Only federal loans are eligible</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label174" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label175" runat="server" Text='<%#Eval("national_guard_fed_loans_eligible_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label176" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label177" runat="server" Text='<%#Eval("national_guard_fed_loans_eligible_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label178" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label179" runat="server" Text='<%#Eval("national_guard_fed_loans_eligible_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Eligible for mandatory forbearance</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label180" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label181" runat="server" Text='<%#Eval("dod_forbearance_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label182" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label183" runat="server" Text='<%#Eval("dod_forbearance_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label184" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label185" runat="server" Text='<%#Eval("dod_forbearance_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Only federal loans are eligible for Dod mandatory forbearance</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label186" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label187" runat="server" Text='<%#Eval("dod_forbearance_fed_loans_eligible_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label188" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label189" runat="server" Text='<%#Eval("dod_forbearance_fed_loans_eligible_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label190" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label191" runat="server" Text='<%#Eval("dod_forbearance_fed_loans_eligible_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Postpone payments by applying for DoD forbearance</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label192" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label193" runat="server" Text='<%#Eval("dod_postpone_payments_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label194" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label195" runat="server" Text='<%#Eval("dod_postpone_payments_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label196" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label197" runat="server" Text='<%#Eval("dod_postpone_payments_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>PSLF</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Eligibility for PSLF</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label198" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label199" runat="server" Text='<%#Eval("pslf_eligibility_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label200" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label201" runat="server" Text='<%#Eval("pslf_eligibility_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label202" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label203" runat="server" Text='<%#Eval("pslf_eligibility_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained PSLF Loan Types</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label204" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label205" runat="server" Text='<%#Eval("pslf_loan_types_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label206" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label207" runat="server" Text='<%#Eval("pslf_loan_types_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label208" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label209" runat="server" Text='<%#Eval("pslf_loan_types_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>How to Qualify for PSLF</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label210" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label211" runat="server" Text='<%#Eval("pslf_other_options_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label212" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label213" runat="server" Text='<%#Eval("pslf_other_options_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label214" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label215" runat="server" Text='<%#Eval("pslf_other_options_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>120 Qualifying Payments</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label216" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label217" runat="server" Text='<%#Eval("pslf_120_payments_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label218" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label219" runat="server" Text='<%#Eval("pslf_120_payments_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label220" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label221" runat="server" Text='<%#Eval("pslf_120_payments_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Eligible Payment Plan</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label222" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label223" runat="server" Text='<%#Eval("pslf_eligible_payment_plan_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label224" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label225" runat="server" Text='<%#Eval("pslf_eligible_payment_plan_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label226" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label227" runat="server" Text='<%#Eval("pslf_eligible_payment_plan_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Maintain a Full-time Employment Status</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label228" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label229" runat="server" Text='<%#Eval("pslf_fulltime_employment_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label230" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label231" runat="server" Text='<%#Eval("pslf_fulltime_employment_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label232" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label233" runat="server" Text='<%#Eval("pslf_fulltime_employment_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Work for a Qualifying Employment Status</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label234" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label235" runat="server" Text='<%#Eval("pslf_work_for_pso_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label236" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label237" runat="server" Text='<%#Eval("pslf_work_for_pso_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label238" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label239" runat="server" Text='<%#Eval("pslf_work_for_pso_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Consolidation</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label240" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label241" runat="server" Text='<%#Eval("pslf_consolidating_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label242" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label243" runat="server" Text='<%#Eval("pslf_consolidating_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label244" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label245" runat="server" Text='<%#Eval("pslf_consolidating_PctngPassed")%>' /></td>
                                                        </tr>
                                                        
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>TLF</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent properly described eligibility criteria based on the program qualifications</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label618" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label619" runat="server" Text='<%#Eval("teacher_forgiveness_described_eligibility_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label620" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label621" runat="server" Text='<%#Eval("teacher_forgiveness_described_eligibility_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label622" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label623" runat="server" Text='<%#Eval("teacher_forgiveness_described_eligibility_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent explained how to apply for Teacher Loan Forgiveness</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label624" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label625" runat="server" Text='<%#Eval("teacher_forgiveness_how_to_apply_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label626" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label627" runat="server" Text='<%#Eval("teacher_forgiveness_how_to_apply_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label628" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label629" runat="server" Text='<%#Eval("teacher_forgiveness_how_to_apply_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent explained Teacher Loan Forgiveness Benefit</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label630" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label631" runat="server" Text='<%#Eval("teacher_forgiveness_explained_benefit_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label632" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label633" runat="server" Text='<%#Eval("teacher_forgiveness_explained_benefit_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label634" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label635" runat="server" Text='<%#Eval("teacher_forgiveness_explained_benefit_PctngPassed")%>' /></td>
                                                        </tr>
                                                        





                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>TEACH</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained Conditions For Receiving a TEACH Grant</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label246" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label247" runat="server" Text='<%#Eval("teach_advised_conditions_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label248" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label249" runat="server" Text='<%#Eval("teach_advised_conditions_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label250" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label251" runat="server" Text='<%#Eval("teach_advised_conditions_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Must Sign a TEACH Grant Agreement to Serve</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label252" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label253" runat="server" Text='<%#Eval("teach_advised_borrower_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label254" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label255" runat="server" Text='<%#Eval("teach_advised_borrower_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label256" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label257" runat="server" Text='<%#Eval("teach_advised_borrower_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>TEACH Grant Funds Received Will Be Converted to a Direct Unsubsubsidized Loan</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label258" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label259" runat="server" Text='<%#Eval("teach_advised_service_must_be_completed_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label260" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label261" runat="server" Text='<%#Eval("teach_advised_service_must_be_completed_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label262" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label263" runat="server" Text='<%#Eval("teach_advised_service_must_be_completed_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Must Agree to Teach in the Needed Capacity</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label264" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label265" runat="server" Text='<%#Eval("teach_must_teach_needed_capacity_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label266" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label267" runat="server" Text='<%#Eval("teach_must_teach_needed_capacity_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label268" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label269" runat="server" Text='<%#Eval("teach_must_teach_needed_capacity_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>May Request a Temporary Suspension</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label270" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label271" runat="server" Text='<%#Eval("teach_may_request_suspension_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label272" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label273" runat="server" Text='<%#Eval("teach_may_request_suspension_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label274" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label275" runat="server" Text='<%#Eval("teach_may_request_suspension_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>TPD</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained How to Apply For TPD</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label276" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label277" runat="server" Text='<%#Eval("tpd_how_to_apply_for_TPD_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label278" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label279" runat="server" Text='<%#Eval("tpd_how_to_apply_for_TPD_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label280" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label281" runat="server" Text='<%#Eval("tpd_how_to_apply_for_TPD_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Collection Will Suspend In 120 Days</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label282" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label283" runat="server" Text='<%#Eval("tpd_collection_will_suspend_120_days_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label284" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label285" runat="server" Text='<%#Eval("tpd_collection_will_suspend_120_days_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label286" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label287" runat="server" Text='<%#Eval("tpd_collection_will_suspend_120_days_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>3 Ways to Document Disability</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label288" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label289" runat="server" Text='<%#Eval("tpd_document_disability_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label290" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label291" runat="server" Text='<%#Eval("tpd_document_disability_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label292" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label293" runat="server" Text='<%#Eval("tpd_document_disability_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised of the TPD Application Process</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label294" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label295" runat="server" Text='<%#Eval("tpd_advised_TPD_application_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label296" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label297" runat="server" Text='<%#Eval("tpd_advised_TPD_application_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label298" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label299" runat="server" Text='<%#Eval("tpd_advised_TPD_application_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised of Proper Procedures After Receipt</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label300" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label301" runat="server" Text='<%#Eval("tpd_procedures_approves_TPD_discharge_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label302" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label303" runat="server" Text='<%#Eval("tpd_procedures_approves_TPD_discharge_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label304" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label305" runat="server" Text='<%#Eval("tpd_procedures_approves_TPD_discharge_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>3 Year Post-Discharge Monitoring Period</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label306" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label307" runat="server" Text='<%#Eval("tpd_TPD_monitoring_period_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label308" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label309" runat="server" Text='<%#Eval("tpd_TPD_monitoring_period_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label310" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label311" runat="server" Text='<%#Eval("tpd_TPD_monitoring_period_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised of Reinstatements</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label312" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label313" runat="server" Text='<%#Eval("tpd_advised_reinstatements_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label314" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label315" runat="server" Text='<%#Eval("tpd_advised_reinstatements_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label316" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label317" runat="server" Text='<%#Eval("tpd_advised_reinstatements_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised of Future Eligibility For New Loans or Grants</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label318" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label319" runat="server" Text='<%#Eval("tpd_new_loans_teach_grants_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label320" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label321" runat="server" Text='<%#Eval("tpd_new_loans_teach_grants_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label322" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label323" runat="server" Text='<%#Eval("tpd_new_loans_teach_grants_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised of Refund Procedures</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label324" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label325" runat="server" Text='<%#Eval("tpd_advised_TPD_refund_procedures_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label326" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label327" runat="server" Text='<%#Eval("tpd_advised_TPD_refund_procedures_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label328" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label329" runat="server" Text='<%#Eval("tpd_advised_TPD_refund_procedures_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>1099c Will Be Sent</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label330" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label331" runat="server" Text='<%#Eval("tpd_1099_sent_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label332" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label333" runat="server" Text='<%#Eval("tpd_1099_sent_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label334" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label335" runat="server" Text='<%#Eval("tpd_1099_sent_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>IDR</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Discussed the borrower's eligibility</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label336" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label337" runat="server" Text='<%#Eval("idr_eligibility_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label338" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label339" runat="server" Text='<%#Eval("idr_eligibility_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label340" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label341" runat="server" Text='<%#Eval("idr_eligibility_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>How Monthy Payments Are Calculated</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label342" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label343" runat="server" Text='<%#Eval("idr_how_payments_calculated_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label344" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label345" runat="server" Text='<%#Eval("idr_how_payments_calculated_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label346" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label347" runat="server" Text='<%#Eval("idr_how_payments_calculated_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained the Title IV loans that qualify</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label348" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label349" runat="server" Text='<%#Eval("idr_qualifying_loans_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label350" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label351" runat="server" Text='<%#Eval("idr_qualifying_loans_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label352" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label353" runat="server" Text='<%#Eval("idr_qualifying_loans_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>How to Apply</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label354" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label355" runat="server" Text='<%#Eval("idr_how_to_apply_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label356" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label357" runat="server" Text='<%#Eval("idr_how_to_apply_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label358" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label359" runat="server" Text='<%#Eval("idr_how_to_apply_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Deferment</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Meaning of Deferment</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label360" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label361" runat="server" Text='<%#Eval("deferment_meaning_deferment_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label362" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label363" runat="server" Text='<%#Eval("deferment_meaning_deferment_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label364" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label365" runat="server" Text='<%#Eval("deferment_meaning_deferment_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised the borrower is s/he qualifies</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label366" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label367" runat="server" Text='<%#Eval("deferment_qualifying_deferment_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label368" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label369" runat="server" Text='<%#Eval("deferment_qualifying_deferment_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label370" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label371" runat="server" Text='<%#Eval("deferment_qualifying_deferment_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Advised the borrower how s/he applies for deferment</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label372" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label373" runat="server" Text='<%#Eval("deferment_how_to_apply_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label374" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label375" runat="server" Text='<%#Eval("deferment_how_to_apply_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label376" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label377" runat="server" Text='<%#Eval("deferment_how_to_apply_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Borrower understands how long s/he may defer payment</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label378" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label379" runat="server" Text='<%#Eval("deferment_length_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label380" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label381" runat="server" Text='<%#Eval("deferment_length_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label382" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label383" runat="server" Text='<%#Eval("deferment_length_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Forbearance</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Not qualified for deferment but qualified for forbearance</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label384" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label385" runat="server" Text='<%#Eval("forbearance_not_qualified_for_deferment_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label386" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label387" runat="server" Text='<%#Eval("forbearance_not_qualified_for_deferment_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label388" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label389" runat="server" Text='<%#Eval("forbearance_not_qualified_for_deferment_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained the meaning of forbearance</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label390" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label391" runat="server" Text='<%#Eval("forbearance_explained_meaning_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label392" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label393" runat="server" Text='<%#Eval("forbearance_explained_meaning_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label394" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label395" runat="server" Text='<%#Eval("forbearance_explained_meaning_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Provided the borrower with the documentation</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label396" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label397" runat="server" Text='<%#Eval("forbearance_provided_documentation_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label398" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label399" runat="server" Text='<%#Eval("forbearance_provided_documentation_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label400" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label401" runat="server" Text='<%#Eval("forbearance_provided_documentation_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained the differences between the types of forbearances</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label402" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label403" runat="server" Text='<%#Eval("forbearance_explained_different_types_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label404" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label405" runat="server" Text='<%#Eval("forbearance_explained_different_types_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label406" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label407" runat="server" Text='<%#Eval("forbearance_explained_different_types_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Read forbearance script</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label408" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label409" runat="server" Text='<%#Eval("forbearance_read_script_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label410" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label411" runat="server" Text='<%#Eval("forbearance_read_script_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label412" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label413" runat="server" Text='<%#Eval("forbearance_read_script_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Negative amortization and capping vs non-capping events</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained why loan amount is getting larger</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label414" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label415" runat="server" Text='<%#Eval("amortization_loan_amount_growing_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label416" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label417" runat="server" Text='<%#Eval("amortization_loan_amount_growing_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label418" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label419" runat="server" Text='<%#Eval("amortization_loan_amount_growing_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained which payment plan would reduce balance</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label420" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label421" runat="server" Text='<%#Eval("amortization_which_payment_plan_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label422" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label423" runat="server" Text='<%#Eval("amortization_which_payment_plan_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label424" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label425" runat="server" Text='<%#Eval("amortization_which_payment_plan_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Explained interest capitalization</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label426" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label427" runat="server" Text='<%#Eval("amortization_interest_capitalization_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label428" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label429" runat="server" Text='<%#Eval("amortization_interest_capitalization_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label430" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label431" runat="server" Text='<%#Eval("amortization_interest_capitalization_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Loan Discharge</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Closed School - explained criteria</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label432" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label433" runat="server" Text='<%#Eval("closed_school_criteria_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label434" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label435" runat="server" Text='<%#Eval("closed_school_criteria_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label436" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label437" runat="server" Text='<%#Eval("closed_school_criteria_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Closed School - explained process</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label438" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label439" runat="server" Text='<%#Eval("closed_school_process_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label440" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label441" runat="server" Text='<%#Eval("closed_school_process_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label442" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label443" runat="server" Text='<%#Eval("closed_school_process_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Closed School - explained process after discharge</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label444" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label445" runat="server" Text='<%#Eval("closed_school_approve_deny_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label446" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label447" runat="server" Text='<%#Eval("closed_school_approve_deny_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label448" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label449" runat="server" Text='<%#Eval("closed_school_approve_deny_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Bankruptcy - borrower has filed</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label450" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label451" runat="server" Text='<%#Eval("bankruptcy_bankruptcy_filed_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label452" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label453" runat="server" Text='<%#Eval("bankruptcy_bankruptcy_filed_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label454" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label455" runat="server" Text='<%#Eval("bankruptcy_bankruptcy_filed_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Bankruptcy - agent obtained additional info</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label456" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label457" runat="server" Text='<%#Eval("bankruptcy_additional_information_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label458" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label459" runat="server" Text='<%#Eval("bankruptcy_additional_information_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label460" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label461" runat="server" Text='<%#Eval("bankruptcy_additional_information_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Bankruptcy - advised to send documentation</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label462" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label463" runat="server" Text='<%#Eval("bankruptcy_mailing_address_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label464" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label465" runat="server" Text='<%#Eval("bankruptcy_mailing_address_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label466" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label467" runat="server" Text='<%#Eval("bankruptcy_mailing_address_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Bankruptcy - notified the parties for monitoring</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label468" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label469" runat="server" Text='<%#Eval("bankruptcy_notified_internal_parties_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label470" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label471" runat="server" Text='<%#Eval("bankruptcy_notified_internal_parties_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label472" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label473" runat="server" Text='<%#Eval("bankruptcy_notified_internal_parties_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Death - identified borrower</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label474" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label475" runat="server" Text='<%#Eval("death_deceased_borrower_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label476" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label477" runat="server" Text='<%#Eval("death_deceased_borrower_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label478" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label479" runat="server" Text='<%#Eval("death_deceased_borrower_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Death - collected info from 3rd party</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label480" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label481" runat="server" Text='<%#Eval("death_collected_info_third_party_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label482" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label483" runat="server" Text='<%#Eval("death_collected_info_third_party_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label484" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label485" runat="server" Text='<%#Eval("death_collected_info_third_party_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Death - notified the correct internal parties</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label486" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label487" runat="server" Text='<%#Eval("death_send_documentation_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label488" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label489" runat="server" Text='<%#Eval("death_send_documentation_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label490" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label491" runat="server" Text='<%#Eval("death_send_documentation_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Death - gave address for death certificate</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label492" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label493" runat="server" Text='<%#Eval("death_death_cert_mailing_address_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label494" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label495" runat="server" Text='<%#Eval("death_death_cert_mailing_address_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label496" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label497" runat="server" Text='<%#Eval("death_death_cert_mailing_address_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Death - identified circumstances</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label498" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label499" runat="server" Text='<%#Eval("death_identified_circumstances_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label500" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label501" runat="server" Text='<%#Eval("death_identified_circumstances_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label502" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label503" runat="server" Text='<%#Eval("death_identified_circumstances_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>ATB - discussed eligibility requirements</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label504" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label505" runat="server" Text='<%#Eval("atb_eligibility_requirements_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label506" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label507" runat="server" Text='<%#Eval("atb_eligibility_requirements_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label508" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label509" runat="server" Text='<%#Eval("atb_eligibility_requirements_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>ATB - must take test</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label510" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label511" runat="server" Text='<%#Eval("atb_take_test_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label512" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label513" runat="server" Text='<%#Eval("atb_take_test_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label514" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label515" runat="server" Text='<%#Eval("atb_take_test_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>ATB - advised loans may be discharged</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label516" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label517" runat="server" Text='<%#Eval("atb_advised_loans_may_be_discharged_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label518" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label519" runat="server" Text='<%#Eval("atb_advised_loans_may_be_discharged_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label520" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label521" runat="server" Text='<%#Eval("atb_advised_loans_may_be_discharged_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>ATB - how to obtain app</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label522" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label523" runat="server" Text='<%#Eval("atb_how_to_send_application_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label524" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label525" runat="server" Text='<%#Eval("atb_how_to_send_application_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label526" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label527" runat="server" Text='<%#Eval("atb_how_to_send_application_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>ATB - How to complete app</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label528" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label529" runat="server" Text='<%#Eval("atb_how_to_complete_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label530" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label531" runat="server" Text='<%#Eval("atb_how_to_complete_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label532" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label533" runat="server" Text='<%#Eval("atb_how_to_complete_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>False Certfication - agent identified that borrower may be eligible</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label534" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label535" runat="server" Text='<%#Eval("falsecert_eligibility_requirements_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label536" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label537" runat="server" Text='<%#Eval("falsecert_eligibility_requirements_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label538" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label539" runat="server" Text='<%#Eval("falsecert_eligibility_requirements_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>False Certification - how to obtain and send app</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label540" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label541" runat="server" Text='<%#Eval("falsecert_how_to_send_application_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label542" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label543" runat="server" Text='<%#Eval("falsecert_how_to_send_application_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label544" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label545" runat="server" Text='<%#Eval("falsecert_how_to_send_application_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>False Certification - how to complete app</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label546" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label547" runat="server" Text='<%#Eval("falsecert_how_to_complete_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label548" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label549" runat="server" Text='<%#Eval("falsecert_how_to_complete_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label550" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label551" runat="server" Text='<%#Eval("falsecert_how_to_complete_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>False Certification Refund - identified an unpaid refund</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label552" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label553" runat="server" Text='<%#Eval("falsecert_refund_unpaid_refund_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label554" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label555" runat="server" Text='<%#Eval("falsecert_refund_unpaid_refund_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label556" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label557" runat="server" Text='<%#Eval("falsecert_refund_unpaid_refund_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>False Certification Refund - how to obtain and send an app</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label558" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label559" runat="server" Text='<%#Eval("falsecert_refund_how_to_send_application_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label560" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label561" runat="server" Text='<%#Eval("falsecert_refund_how_to_send_application_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label562" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label563" runat="server" Text='<%#Eval("falsecert_refund_how_to_send_application_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>False Certification Refund - how to complete app</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label564" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label565" runat="server" Text='<%#Eval("falsecert_refund_how_to_complete_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label566" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label567" runat="server" Text='<%#Eval("falsecert_refund_how_to_complete_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label568" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label569" runat="server" Text='<%#Eval("falsecert_refund_how_to_complete_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Documentation</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Documented and logged call</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label570" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label571" runat="server" Text='<%#Eval("documentation_accuracy_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label572" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label573" runat="server" Text='<%#Eval("documentation_accuracy_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label574" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label575" runat="server" Text='<%#Eval("documentation_accuracy_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Documented and logged complaint</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label576" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label577" runat="server" Text='<%#Eval("documentation_logged_complaint_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label578" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label579" runat="server" Text='<%#Eval("documentation_logged_complaint_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label580" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label581" runat="server" Text='<%#Eval("documentation_logged_complaint_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Payments</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Help accessing Web site</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label582" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label583" runat="server" Text='<%#Eval("payment_accessing_web_account_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label584" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label585" runat="server" Text='<%#Eval("payment_accessing_web_account_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label586" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label587" runat="server" Text='<%#Eval("payment_accessing_web_account_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Set up a direct debit</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label588" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label589" runat="server" Text='<%#Eval("payment_direct_debit_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label590" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label591" runat="server" Text='<%#Eval("payment_direct_debit_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label592" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label593" runat="server" Text='<%#Eval("payment_direct_debit_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Take a payment over the phone</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label594" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label595" runat="server" Text='<%#Eval("payment_phone_payment_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label596" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label597" runat="server" Text='<%#Eval("payment_phone_payment_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label598" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label599" runat="server" Text='<%#Eval("payment_phone_payment_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Credit cards not accepted</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label600" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label601" runat="server" Text='<%#Eval("payment_creditcards_not_accepted_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label602" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label603" runat="server" Text='<%#Eval("payment_creditcards_not_accepted_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label604" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label605" runat="server" Text='<%#Eval("payment_creditcards_not_accepted_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Credit cards accepted in emergencies</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label606" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label607" runat="server" Text='<%#Eval("payment_creditcards_emergency_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label608" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label609" runat="server" Text='<%#Eval("payment_creditcards_emergency_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label610" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label611" runat="server" Text='<%#Eval("payment_creditcards_emergency_PctngPassed")%>' /></td>
                                                        </tr>
                                                        
                                                        
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Consolidation</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent explained (when asked by the borrower) benefits of Consolidation</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label636" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label637" runat="server" Text='<%#Eval("consolidation_explained_benefits_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label638" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label639" runat="server" Text='<%#Eval("consolidation_explained_benefits_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label640" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label641" runat="server" Text='<%#Eval("consolidation_explained_benefits_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent properly explained the program requirements for Consolidation</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label642" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label643" runat="server" Text='<%#Eval("consolidation_program_requirements_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label644" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label645" runat="server" Text='<%#Eval("consolidation_program_requirements_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label646" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label647" runat="server" Text='<%#Eval("consolidation_program_requirements_PctngPassed")%>' /></td>
                                                        </tr>
                                                         <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent properly advised of loan types available for Consolidation</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label648" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label649" runat="server" Text='<%#Eval("consolidation_loan_types_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label650" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label651" runat="server" Text='<%#Eval("consolidation_loan_types_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label652" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label653" runat="server" Text='<%#Eval("consolidation_loan_types_PctngPassed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Agent properly explained the application process</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label654" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label655" runat="server" Text='<%#Eval("consolidation_explained_app_process_Passed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label656" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label657" runat="server" Text='<%#Eval("consolidation_explained_app_process_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label658" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label659" runat="server" Text='<%#Eval("consolidation_explained_app_process_PctngPassed")%>' /></td>
                                                        </tr>
                                                        
                                                        <tr>
                                                             <td colspan="2" bgcolor="#5C9CCC"><h3>Unknown/Misc/Other</h3></td>
                                                        </tr>
                                                        <tr>
                                                             <td colspan="2" bgcolor="#d8d4d4"><h4>Uknown Misc/Other</h4></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label612" runat="server" Text="Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label613" runat="server" Text='<%#Eval("resolution_other_Passed")%>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label614" runat="server" Text="Reviewed:" /></td><td align="left" width="50%"><asp:Label ID="Label615" runat="server" Text='<%#Eval("resolution_other_Reviewed")%>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" width="50%"><asp:Label ID="Label616" runat="server" Text="% Failed:" /></td><td align="left" width="50%"><asp:Label ID="Label617" runat="server" Text='<%#Eval("resolution_other_PctngPassed")%>' /></td>
                                                        </tr>
          
                                                                                                         
                                                      </table>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                       
                                        <FooterStyle CssClass="gridcolumnheader" />
                                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                                        <HeaderStyle CssClass="gridcolumnheader" />
                                        <EditRowStyle CssClass="gridEditRow" />
                                    </asp:GridView>
                                    <br />
                                    
                                </div>
                                
                                <!--Notes and Observations of Failed Calls-->
                                <h2>Notes and Observations of Errors</h2>
                                <div>
                                    <asp:ImageButton ID="btnExportWordNotes" runat="server" CausesValidation="false" ImageUrl="../images/word.png"
                                    OnClick="btnExportWordNotes_Click" Height="25px" Width="25px" Visible="false" ToolTip="Export to Word" />
                                </div>
                                <div id="dvGrid" class="grid" align="center">                          
                                    
                                    <asp:GridView ID="grdFailedCalls" runat="server" AutoGenerateColumns="false" AllowSorting="false"
                                        BorderWidth="1px" BackColor="White" DataKeyNames="ReviewID" AlternatingRowStyle-BackColor = "#C2D69B" HeaderStyle-BackColor = "#5C9CCC"
                                        CellPadding="3" BorderColor="#E7E7FF" Width="900px" BorderStyle="Solid" ShowFooter="false" Visible="false">
                                                                                                                  
                                        <Columns>  
                                            <asp:TemplateField HeaderText="Failed Calls">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReviewID" Text='<%# Eval("ReviewID")%>' runat="server" />, <asp:Label ID="lblAgentID" Text='<%# Eval("AgentID")%>' runat="server" />,
                                                    <asp:Label ID="lblCallID" Text='<%# Eval("CallID")%>' runat="server" />, <asp:Label ID="lblComments" Text='<%# Eval("Comments")%>' runat="server" />
                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>                                       

                                        </Columns>                                        
                                    </asp:GridView>

                                    <asp:Repeater runat="server" ID="rptFailedCalls">
                                        <HeaderTemplate>
                                            <ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <li align="left">
                                                <%# Eval("ReviewID")%>, <%# Eval("AgentID")%>, <%# Eval("CallID")%>, <%# Eval("Comments")%><br /><br />
                                            </li>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </ul>
                                        </FooterTemplate>
                                    </asp:Repeater>

                                    <br />
                                </div>
        </div>
        </div> </td> </tr> </table> </div>
        <br />
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
</asp:Content>

