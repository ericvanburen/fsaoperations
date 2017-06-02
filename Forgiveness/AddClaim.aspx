﻿<%@ Page Title="Add New Claim" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddClaim.aspx.vb" Inherits="Unconsolidation_AddRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
        <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
        <script src="Scripts/menu.js" type="text/javascript"></script>       
        <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
        <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

<fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">                         
                        <div id="tabs">
                           
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
                                <ul id="nav">
                                    <li><a href="MyClaims.aspx">My Claims</a></li>                                   
                                    <li><a href="Search.aspx">Search Claims</a></li>
                                    <li><a href="AddClaim.aspx">Add New Claim</a></li>
                                </ul>
                            </div>
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Servicers-->
                                <asp:SqlDataSource ID="dsServicers" runat="server" ConnectionString="<%$ ConnectionStrings:ForgivenessConnectionString %>"
                                    SelectCommand="p_ServicersAll" SelectCommandType="StoredProcedure" />
                               
                                 <div align="left" style="padding-top: 10px" id="tabs-1">
                                     <asp:UpdatePanel id="pnlupdate1" runat="server">
                                        <ContentTemplate>    
                                            <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <span class="panel-title">FORGIVENESS PROCESSING - Add New Claim</span>
                                            </div>
                                            <div class="panel-body">

                                            <table width="100%" cellpadding="2" cellspacing="2" border="0" class="table">
                                            <tr>                                             
                                                
                                                <td width="25%"><strong>Borrower Name:</strong><br />
                                                    <asp:Textbox ID="txtBorrower_Name" runat="server" TabIndex="1" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the borrower's name * " ControlToValidate="txtBorrower_Name" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Last 4 of Account:</strong><br />
                                                    <asp:TextBox ID="txtAccount" runat="server" TabIndex="2" MaxLength="4" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the last 4 digits of the account number * " ControlToValidate="txtAccount" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Award ID:</strong><br />
                                                    <asp:TextBox ID="txtAwardID" runat="server" TabIndex="3" MaxLength="21" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Award ID number * " ControlToValidate="txtAwardID" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Sequence Number:</strong><br />
                                                    <asp:TextBox ID="txtSequenceNumber" runat="server" TabIndex="4" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the sequence number * " ControlToValidate="txtSequenceNumber" />
                                                </td>                                              
                                                
                                            </tr>
                                            <tr>
                                                <td width="25%">
                                                    <strong>Loan Servicer:</strong><br />
                                                    <asp:DropdownList ID="ddlServicerID" runat="server" TabIndex="5" DataSourceID="dsServicers" Height="25px"
                                                        AppendDataBoundItems="true" DataTextField="Servicer" 
                                                        DataValueField="ServicerID">
                                                        <asp:ListItem Text="" Value="" />
                                                     </asp:DropdownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please select the current servicer  * " ControlToValidate="ddlServicerID" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Date Received By FSA:</strong><br />
                                                    <asp:TextBox ID="txtDate_Received" runat="server" TabIndex="6" /><br />                                                                                                       
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the date received  * " ControlToValidate="txtDate_Received" />
                                                </td>
                                                <td width="25%" valign="top"><strong>Claim Type:</strong><br />
                                                    <asp:DropDownList ID="ddlClaim_Type" runat="server" Height="25px" TabIndex="7">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="IDR" Value="IDR" />
                                                        <asp:ListItem Text="PSLF" Value="PSLF" />                                                        
                                                        <asp:ListItem Text="TEACH" Value="TEACH" />
                                                    </asp:DropDownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please select the claim type  * " ControlToValidate="ddlClaim_Type" />
                                                </td>  
                                                <td width="25%" valign="top"><strong>Status:</strong> <br />
                                                    <asp:DropDownList ID="ddlFSA_Approved" runat="server" Height="25px" TabIndex="8">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="Approved" Value="Approved" />
                                                        <asp:ListItem Text="Denied" Value="Denied" />
                                                        <asp:ListItem Text="Pending" Value="Pending" />
                                                        <asp:ListItem Text="Pre-Forgiveness Reporting" Value="Pre-Forgiveness Reporting" Selected="True" />
                                                    </asp:DropDownList>
                                                </td>
                                                 
                                                  
                                            </tr>
                                            <tr>
                                              <td width="25%" valign="top"><strong>Decision Date:</strong><br />
                                                    <asp:TextBox ID="txtDecision_Date" runat="server" TabIndex="9" placeholder="mm/dd/yyyy" />                                                    
                                                </td>
                                                <td width="25%" valign="top"><strong>Qualifying Payments/Number of Servicer Credits:</strong><br /> 
                                                    <asp:TextBox ID="txtQualifying_Payments" runat="server" TabIndex="10" placeholder="#" />
                                                </td> 
                                                <td width="25%" valign="top"><strong>PSLF/TEACH Decision Type:</strong><br />
                                                    <asp:DropDownList ID="ddlApproval_Type" runat="server" Height="25px" TabIndex="11">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="PSLF - Forgiveness" Value="PSLF - Forgiveness" />
                                                        <asp:ListItem Text="PSLF - Qualifying Payment Counts" Value="PSLF - Qualifying Payment Counts" />
                                                        <asp:ListItem Text="PSLF - Qualifying Employment" value="PSLF - Qualifying Employment" />
                                                        <asp:ListItem Text="TEACH - Service Credit" value="TEACH - Service Credit" />
                                                        <asp:ListItem Text="TEACH - Reinstate" value="TEACH - Reinstate" />
                                                    </asp:DropDownList>
                                                </td>                                               
                                             
                                                <td width="25%" valign="top"><strong>Category Type For IDR:</strong><br />
                                                    <asp:DropDownList ID="ddlCategory_Program_Type_IDR" runat="server" Height="25px" TabIndex="12">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="IBR" Value="IBR" />  
                                                        <asp:ListItem Text="IDR" Value="IDR" />                                                                                                              
                                                        <asp:ListItem Text="PAYE" Value="PAYE" />
                                                        <asp:ListItem Text="REPAYE" Value="REPAYE" />
                                                    </asp:DropDownList>
                                                </td>                                                
                                            </tr>
                                            <tr>
                                                <td width="25%" valign="top"><strong>Outstanding Principal:</strong><br /> 
                                                    <asp:TextBox ID="txtOutstanding_Principal" runat="server" TabIndex="13" placeholder="###.##" />
                                                 <td width="25%" valign="top"><strong>Outstanding Interest:</strong><br /> 
                                                    <asp:TextBox ID="txtOutstanding_Interest" runat="server" TabIndex="14" placeholder="###.##" />
                                                <td width="25%" valign="top"><strong>Select For QA?</strong><br />
                                                    <asp:CheckBox ID="chkQA_Account" runat="server" TabIndex="15" />
                                                <td width="25%" valign="top"><strong>QA Analyst</strong><br />
                                                    <asp:DropDownList ID="ddlQA_Analyst" runat="server" Height="25px" TabIndex="16" AppendDataBoundItems="true">  
                                                        <asp:ListItem Text="" Value="" />                                                     
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"><strong>Escalated?</strong><br />
                                                    <asp:CheckBox ID="chkEscalated" runat="server" TabIndex="16" /></td>
                                                
                                                <td valign="top"><strong>Assigned To</strong><br />
                                                    <asp:DropDownList ID="ddlUserID" runat="server" TabIndex="17" Height="25px" AppendDataBoundItems="true">  
                                                        <asp:ListItem Text="" Value="" />                                                     
                                                    </asp:DropDownList></td>    
                                                <td colspan="2" valign="top"><strong>IDR/PSLF Estimated Forgiveness Date:</strong><br />
                                                    <asp:TextBox ID="txtIDR_Forgiveness_Date" runat="server" TabIndex="18" placeholder="mm/dd/yyyy" /></td>
                                            </tr>
                                            <tr>                                              
                                                <td width="100%" valign="top" colspan="4"><strong>Resolution:</strong><br />
                                                    <asp:Textbox id="txtResolution" runat="server" Height="60px" Width="818px" TabIndex="19" />
                                            </tr>
                                            <tr>                                              
                                                <td width="100%" valign="top" colspan="4"><strong>Comments:</strong><br />
                                                    <asp:Textbox id="txtComments" runat="server" Height="60px" Width="818px" TabIndex="20" />
                                            </tr>
                                            <tr>
                                                    <td colspan="4" align="center">
                                                        <button type="button" id="btnAddClaim" class="btn btn-info" runat="server" OnServerClick="btnAddClaim_Click">
                                                            <span class="glyphicon glyphicon-floppy-disk"></span> Save Claim
                                                        </button>
                                                        <button type="button" id="btnAddAnotherClaim" class="btn btn-success" runat="server" OnServerClick="btnAddAnotherClaim_Click" CausesValidation="false" Visible="false">
                                                            <span class="glyphicon glyphicon-floppy-disk"></span> Save Another Claim
                                                        </button>
                                                   </td>
                                            </tr>
                                            <tr>
                                                    <td  colspan="4" align="center"><asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" /></td>
                                            </tr>
                                         </table>
                                            </div>
                                         </div>                                   
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
<asp:Label ID="lblSubmittedBy" runat="server" Visible="false" />
</asp:Content>

