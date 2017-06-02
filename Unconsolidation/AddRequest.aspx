<%@ Page Title="Add New Request" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="AddRequest.aspx.vb" Inherits="Unconsolidation_AddRequest" %>

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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

<fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                         <h2 style="color: black; font-size: 25px; font-family: Calibri;">UNCONSOLIDATION REQUEST TRACKING - Add New Request</h2>
                        <div id="tabs">
                           
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
                                <ul id="nav">
                                     <li><a href="#">Reports</a>
                                        <ul>
                                            <li><a href="Report1.aspx">Report1</a></li>  
                                            <li><a href="Report2.aspx">Report2</a></li>                                   
                                        </ul>                                         
                                    </li>
                                   
                                    <li><a href="Requests.aspx">Search</a></li>
                                    <li><a href="AddRequest.aspx">Add Request</a></li>
                                </ul>
                            </div>
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Servicers-->
                                <asp:SqlDataSource ID="dsServicers" runat="server" ConnectionString="<%$ ConnectionStrings:UnconsolidationConnectionString %>"
                                    SelectCommand="p_ServicersAll" SelectCommandType="StoredProcedure" />
                               
                                 <div align="left" style="padding-top: 10px" id="tabs-1">
                                     <asp:UpdatePanel id="pnlupdate1" runat="server">
                                        <ContentTemplate>    
                                            <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>                                             
                                                
                                                <td width="25%"><strong>Borrower Name:</strong><br />
                                                    <asp:Textbox ID="txtBorrower_Name" runat="server" TabIndex="1" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the borrower's name * " ControlToValidate="txtBorrower_Name" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Last 4 of Account:</strong><br />
                                                    <asp:TextBox ID="txtAccount" runat="server" TabIndex="2" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the last 4 digits of the account number * " ControlToValidate="txtAccount" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Underlying Loan Servicer:</strong><br />
                                                    <asp:TextBox ID="txtUnderlying_Servicer" runat="server" TabIndex="3"  /><br />                                                                                                       
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the underlying loan servicer  * " ControlToValidate="txtUnderlying_Servicer" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Current Servicer:</strong><br />
                                                    <asp:DropdownList ID="ddlCurrent_ServicerID" runat="server" TabIndex="4" DataSourceID="dsServicers" Height="25px"
                                                        AppendDataBoundItems="true" DataTextField="Servicer" 
                                                        DataValueField="ServicerID">
                                                        <asp:ListItem Text="" Value="" />
                                                     </asp:DropdownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please select the current servicer  * " ControlToValidate="ddlCurrent_ServicerID" />
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <td width="25%" valign="top"><strong>Date of Consolidation:</strong> <br />
                                                    <asp:TextBox ID="txtConsolidation_Date" runat="server" TabIndex="5" placeholder="mm/dd/yyyy" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the consolidation date * " ControlToValidate="txtConsolidation_Date" /></td>
                                                
                                                <td width="25%" valign="top"><strong>Underlying Loan Type:</strong><br />
                                                    <asp:TextBox ID="txtUnderlying_Loan_Type" runat="server" TabIndex="6" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the underlying loan type  * " ControlToValidate="txtUnderlying_Loan_Type" />                                                    
                                                </td>  
                                                <td width="25%" valign="top"><strong>Underlying Loan ID:</strong><br />
                                                    <asp:TextBox ID="txtUnderlying_Loan_ID" runat="server" TabIndex="7" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the underlying loan ID  * " ControlToValidate="txtUnderlying_Loan_ID" />
                                                </td>
                                                 <td width="25%" valign="top"><strong>Requestor:</strong><br />
                                                    <asp:DropDownList ID="ddlRequestor" runat="server" Height="25px" TabIndex="8">
                                                        <asp:ListItem Text="" Value="" Selected="True" />
                                                        <asp:ListItem Text="Borrower" Value="Borrower" />
                                                        <asp:ListItem Text="Servicer" Value="Servicer" />                                                        
                                                    </asp:DropDownList> </td>
                                            </tr>
                                            <tr>
                                                
                                                <td width="25%" valign="top"><strong>FSA Approved?</strong> <br />
                                                    <asp:DropDownList ID="ddlFSA_Approved" runat="server" Height="25px" TabIndex="9">
                                                        <asp:ListItem Text="N" Value="N" Selected ="True" />
                                                        <asp:ListItem Text="Y" Value="Y" />
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="25%" valign="top"><strong>Decision Date</strong><br />
                                                    <asp:TextBox ID="txtDecision_Date" runat="server" TabIndex="10" placeholder="mm/dd/yyyy" />
                                                </td>
                                                <td width="25%" valign="top"> </td>  
                                                <td width="25%" valign="top"> </td>                                                 
                                            </tr>
                                            <tr>
                                               <td width="100%" valign="top" colspan="4"><strong>Reason For Request:</strong><br />
                                                    <asp:TextBox ID="txtReason_For_Unconsolidation_Request" runat="server" TabIndex="11" Height="42px" Width="818px" /><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Reason For Unconsolidation Request  * " ControlToValidate="txtReason_For_Unconsolidation_Request" />
                                                </td>
                                            </tr>
                                                <tr>
                                                <td width="100%" valign="top" colspan="4"><strong>FSA Response:</strong><br />
                                                    <asp:Textbox id="txtFSA_Response" runat="server" Height="42px" Width="818px" TabIndex="12" />

                                            </tr>
                                            <tr>
                                                <td width="100%" valign="top" colspan="4"><strong>Servicer Response:</strong><br />
                                                    <asp:Textbox id="txtServicer_Response" runat="server" Height="42px" Width="818px" TabIndex="13" />

                                            </tr>
                                            <tr>
                                                <td width="100%" valign="top" colspan="4"><strong>FSA Decision Criteria:</strong><br />
                                                    <asp:Textbox id="txtFSA_Decision_Criteria" runat="server" Height="42px" Width="818px" TabIndex="14" />

                                            </tr> 
                                            <tr>
                                                <td colspan="4"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                                            </tr>
                                                                                  
                                          
                                    
                                                <tr>
                                                    <td colspan="3" align="center">
                                                        <asp:Button ID="btnAddRequest" runat="server" CssClass="button" Text="Add Request" TabIndex="15" OnClick="btnAddRequest_Click" />                                                        
                                                        <asp:Button ID="btnAddAnotherRequest" runat="server" CssClass="button" Text="Add Another Request" OnClick="btnAddAnotherRequest_Click" CausesValidation="false" Visible="false" />
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

</asp:Content>

