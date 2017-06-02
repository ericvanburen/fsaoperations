<%@ Page Title="All Unconsolidation Requests" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Requests.aspx.vb" Inherits="Unconsolidation_Requests" EnableEventValidation="false" %>

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
        /* increase modal size*/
        .modal-dialog   {
            width: 650px;
        }
</style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                         <h2 style="color: black; font-size: 25px; font-family: Calibri;">UNCONSOLIDATION REQUEST TRACKING - All Requests</h2>
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
                               
                                <asp:SqlDataSource ID="dsRequests" runat="server" SelectCommand="p_Requests"
                                SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:UnconsolidationConnectionString %>">
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="dsServicers" runat="server" ConnectionString="<%$ ConnectionStrings:UnconsolidationConnectionString %>"
                                    SelectCommand="p_ServicersAll" SelectCommandType="StoredProcedure" />

                                 <div align="left" style="padding-top: 10px" id="tabs-1">
                                     <asp:UpdatePanel id="pnlupdate1" runat="server">
                                        <ContentTemplate>    
                                            <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <span class="panel-title">All Unconsolidation Requests</span>
                                            </div>
                                            <div class="panel-body">
                                                Search By: <asp:DropDownList ID="ddlSearchType" runat="server" CssClass="inputBox">
                                                            <asp:ListItem Text="Borrower Name" Value="Borrower_Name" />
                                                            <asp:ListItem Text="Account #" Value="Account" />
                                                            <asp:ListItem Text="Underlying Servicer" Value="Underlying_Servicer" />
                                                            <asp:ListItem Text="Current Servicer" Value="Servicer" />
                                                            <asp:ListItem Text="Underlying Loan Type" Value="Underlying_Loan_Type" />
                                                            <asp:ListItem Text="Underlying Loan ID" Value="Underlying_Loan_ID" />
                                                            <asp:ListItem Text="FSA Approved" Value="FSA_Approved" />
                                                            <asp:ListItem Text="Decision Date" Value="Decision_Date" />
                                                        </asp:DropDownList>
                                                        For <asp:TextBox ID="txtSearchPhrase" runat="server" CssClass="inputBox" />
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn-sm btn-primary" CausesValidation="false" />
                                                    <asp:Button ID="btnShowAll" runat="server" Text="Show All" OnClick="btnShowAll_Click" CssClass="btn-sm btn-danger" CausesValidation="false" Visible="false" />
                                                    <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" OnClick="btnExportExcel_Click" CssClass="btn-sm btn-success" CausesValidation="false" />
                                                <br /><br />
                                                <asp:GridView ID="GridView1" runat="server" DataSourceID="dsRequests" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-hover table-striped" 
                                                    OnRowCommand="GridView1_RowCommand" DataKeyNames="RequestID">
                                                    <Columns>                   
                                                        <asp:BoundField DataField="RequestID" HeaderText="Request ID" SortExpression="RequestID" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Borrower_Name" HeaderText="Borrower Name" SortExpression="Borrower_Name" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Underlying_Servicer" HeaderText="Underlying Servicer" SortExpression="Underlying_Servicer" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Servicer" HeaderText="Current Servicer" SortExpression="Servicer" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Underlying_Loan_Type" HeaderText="Underlying Loan Type" SortExpression="Underlying_Loan_Type" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Underlying_Loan_ID" HeaderText="Underlying Loan ID" SortExpression="Underlying_Loan_ID" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="FSA_Approved" HeaderText="FSA Approved?" SortExpression="FSA_Approved" 
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Decision_Date" HeaderText="Decision Date" SortExpression="Decision_Date" DataFormatString="{0:d}" HtmlEncode="false"  
                                                        HeaderStyle-HorizontalAlign="Center" />
                                                        <asp:BoundField DataField="Consolidation_Date" HeaderText="Consolidation Date"  
                                                            DataFormatString="{0:d}" HtmlEncode="false" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />  
                                                        <asp:BoundField DataField="Reason_For_Unconsolidation_Request" HeaderText="Reason For Unconsolidation Request" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        <asp:BoundField DataField="Requestor" HeaderText="Requestor" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        <asp:BoundField DataField="FSA_Response" HeaderText="FSA Response"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        <asp:BoundField DataField="Servicer_Response" HeaderText="Servicer Response"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        <asp:BoundField DataField="FSA_Decision_Criteria" HeaderText="FSA Decision Criteria"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        <asp:BoundField DataField="Date_Submitted" HeaderText="Date Submitted" DataFormatString="{0:d}" HtmlEncode="false" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info hidePrint" HeaderStyle-CssClass="hidePrint" ButtonType="Button" Text="Update" HeaderText="Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>                                  
                                        </ContentTemplate>
                                         <Triggers>
                                             <asp:PostBackTrigger ControlID="btnExportExcel" />
                                         </Triggers>
                                     </asp:UpdatePanel>

                                     <!-- Update Modal -->
                                     <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                         <div class="modal-dialog">
                                             <div class="modal-content">
                                                 <div class="modal-header">
                                                     <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                     <h4 class="modal-title" id="myModalLabel">Update Request</h4>
                                                 </div>

                                                 <div class="modal-body">
                                                     <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always">
                                                         <ContentTemplate>
                                                             <div class="container-fluid">
                                                                 <strong>Request ID:</strong> <asp:Label ID="lblRequestID" runat="server" Visible="true" /><br /><br />
                                                                 <table width="95%" cellpadding="3" cellspacing="3">
                                                                     <tr>

                                                                         <td><strong>Borrower Name:</strong><br />
                                                                             <asp:TextBox ID="txtBorrower_Name" runat="server" TabIndex="1" /><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please enter the borrower's name * " ControlToValidate="txtBorrower_Name" />
                                                                         </td>
                                                                         <td>
                                                                             <strong>Last 4 of Account:</strong><br />
                                                                             <asp:TextBox ID="txtAccount" runat="server" TabIndex="2" /><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please enter the last 4 digits of the account number * " ControlToValidate="txtAccount" />
                                                                         </td>
                                                                         <td>
                                                                             <strong>Underlying Loan Servicer:</strong><br />
                                                                             <asp:TextBox ID="txtUnderlying_Servicer" runat="server" TabIndex="3" /><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please enter the underlying loan servicer  * " ControlToValidate="txtUnderlying_Servicer" />
                                                                         </td>
                                                                         

                                                                     </tr>
                                                                     <tr>
                                                                         <td>
                                                                             <strong>Current Servicer:</strong><br />
                                                                             <asp:DropDownList ID="ddlCurrent_ServicerID" runat="server" TabIndex="4" DataSourceID="dsServicers" Height="25px"
                                                                                 AppendDataBoundItems="true" DataTextField="Servicer"
                                                                                 DataValueField="ServicerID">
                                                                                 <asp:ListItem Text="" Value="" />
                                                                             </asp:DropDownList><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please select the current servicer  * " ControlToValidate="ddlCurrent_ServicerID" />
                                                                         </td>
                                                                         <td valign="top"><strong>Date of Consolidation:</strong>
                                                                             <br />
                                                                             <asp:TextBox ID="txtConsolidation_Date" runat="server" TabIndex="5" /><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please enter the consolidation date * " ControlToValidate="txtConsolidation_Date" /></td>

                                                                         <td valign="top"><strong>Underlying Loan Type:</strong><br />
                                                                             <asp:TextBox ID="txtUnderlying_Loan_Type" runat="server" TabIndex="6" /><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please enter the underlying loan type  * " ControlToValidate="txtUnderlying_Loan_Type" />
                                                                         </td>
                                                                         </tr>
                                                                       <tr>
                                                                         <td valign="top"><strong>Underlying Loan ID:</strong><br />
                                                                             <asp:TextBox ID="txtUnderlying_Loan_ID" runat="server" TabIndex="7" /><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please enter the underlying loan ID  * " ControlToValidate="txtUnderlying_Loan_ID" />
                                                                         </td>
                                                                         <td valign="top"><strong>Requestor:</strong><br />
                                                                             <asp:DropDownList ID="ddlRequestor" runat="server" Height="25px" TabIndex="8">
                                                                                 <asp:ListItem Text="" Value="" Selected="True" />
                                                                                 <asp:ListItem Text="Borrower" Value="Borrower" />
                                                                                 <asp:ListItem Text="Servicer" Value="Servicer" />
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                         <td valign="top"><strong>FSA Approved?</strong>
                                                                             <br />
                                                                             <asp:DropDownList ID="ddlFSA_Approved" runat="server" Height="25px" TabIndex="9">
                                                                                 <asp:ListItem Text="N" Value="N" Selected="True" />
                                                                                 <asp:ListItem Text="Y" Value="Y" />
                                                                             </asp:DropDownList>
                                                                         </td>
                                                                     </tr>
                                                                     <tr>                                                                        
                                                                         <td colspan="3" valign="top"><strong>Decision Date</strong><br />
                                                                             <asp:TextBox ID="txtDecision_Date" runat="server" TabIndex="10" />
                                                                         </td>
                                                                     </tr>
                                                                     <tr>
                                                                         <td width="100%" valign="top" colspan="4"><strong>Reason For Request:</strong><br />
                                                                             <asp:TextBox ID="txtReason_For_Unconsolidation_Request" runat="server" TabIndex="11" Height="42px" Width="100%" /><br />
                                                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="warning" Display="Dynamic"
                                                                                 ErrorMessage="* Please enter the Reason For Unconsolidation Request  * " ControlToValidate="txtReason_For_Unconsolidation_Request" />
                                                                         </td>
                                                                     </tr>
                                                                     <tr>
                                                                         <td width="100%" valign="top" colspan="4"><strong>FSA Response:</strong><br />
                                                                             <asp:TextBox ID="txtFSA_Response" runat="server" Height="42px" Width="100%" TabIndex="12" />
                                                                     </tr>
                                                                     <tr>
                                                                         <td width="100%" valign="top" colspan="4"><strong>Servicer Response:</strong><br />
                                                                             <asp:TextBox ID="txtServicer_Response" runat="server" Height="42px" Width="100%" TabIndex="13" />
                                                                     </tr>
                                                                     <tr>
                                                                         <td width="100%" valign="top" colspan="4"><strong>FSA Decision Criteria:</strong><br />
                                                                             <asp:TextBox ID="txtFSA_Decision_Criteria" runat="server" Height="42px" Width="100%" TabIndex="14" />
                                                                     </tr>
                                                                     <tr>
                                                                         <td colspan="2" align="center">
                                                                             <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-danger" Visible="false" /></td>
                                                                     </tr>

                                                                 </table>
                                                             </div>
                                                         </ContentTemplate>
                                                         <Triggers>
                                                             <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                                                         </Triggers>
                                                     </asp:UpdatePanel>
                                                 </div>
                                                 <div class="modal-footer">
                                                     <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                         <ContentTemplate>
                                                             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                             <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSaveChanges_Click" />
                                                             <asp:Button ID="btnDeleteAssignment" runat="server" Text="Delete Request" CssClass="btn btn-warning" OnClick="btnDeleteAssignment_Click" OnClientClick="return confirm('Are you sure that you want to delete this request?')" />
                                                         </ContentTemplate>
                                                     </asp:UpdatePanel>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                     <!-- End Update Modal -->
                                                    
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
</asp:Content>

