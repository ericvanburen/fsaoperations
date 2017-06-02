<%@ Page Title="DMCS Refunds - Assign Refunds" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="assign.aspx.vb" Inherits="DMCSRefunds_admin_assign" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    <Scripts>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.Core.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.jQuery.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.jQueryInclude.js">
        </asp:ScriptReference>
    </Scripts>
</telerik:RadScriptManager>

    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="OrientationComboBox">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <table border="0" width="100%">
<tr>
    <td class="formLabelHeader">DMCS Refunds Queue</td>
    <td align="right">
     <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" /> 

     <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
          <telerik:RadMenu ID="RadMenu1" runat="server" EnableRoundedCorners="true" EnableShadows="true" />
     </div>
    </td>
</tr>
</table>
<br />

                <!--Populates the Gridview with refunds-->
                <asp:SqlDataSource ID="dsRefunds" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>" 
                    SelectCommand="p_RefundReceivedStatus" SelectCommandType="StoredProcedure" 
                    UpdateCommand="p_RefundAssign" UpdateCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:Parameter Name="RefundID" />
                        <asp:Parameter Name="UserID" />                        
                    </UpdateParameters>                    
                  </asp:SqlDataSource>

                <table>                    
                <tr>
                    <td><p>Administrators may use this form to assign refunds to Loan Analysts.</p></td>
                </tr>
                    <tr>
                        <td style="padding-left:20px">
                        <asp:Button ID="btnMasterCheck" runat="server" CommandName="Check" CommandArgument="Check" OnCommand="MasterCheck_Click" Text="Check All Refunds" CausesValidation="false" />                        
                        <asp:Button ID="btnAssignRefunds" runat="server" Text="Assign Checked Refunds to Loan Analyst" OnClick="btnAssignRefunds_Click" OnClientClick="return confirm('Are you sure that you want to assign the checked refunds to the selected LA?')" />
                        <asp:DropDownList ID="ddlUserID" runat="server" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please select a Loan Analyst" ControlToValidate="ddlUserID" CssClass="failureNotification" />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAssignStatus" runat="server" ForeColor="Blue" /></td>
                    </tr>
                </table>
                <p />

                <asp:GridView ID="grdRefundQueue" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="There are no pending refunds in the queue" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="RefundID" HorizontalAlign="Center"
                         OnPageIndexChanging="grdRefundQueue_PageIndexChanging" EmptyDataRowStyle-Font-Size="Medium" AllowSorting="true" AllowPaging="true" PageSize="50" Width="95%"
                         OnRowDataBound="grdRefundQueue_RowDataBound" DataSourceID="dsRefunds"> 
                         <AlternatingRowStyle BackColor="#F7F7F7"  />
                         <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C"  />
                         <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7"  />
                         <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right"  />
                         <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C"  />
                         <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7"  />
                         <SortedAscendingCellStyle BackColor="#F4F4FD"  />
                         <SortedAscendingHeaderStyle BackColor="#5A4C9D"  />
                         <SortedDescendingCellStyle BackColor="#D8D8F0"  />
                         <SortedDescendingHeaderStyle BackColor="#3E3277" />
                         <Columns>
                             <asp:TemplateField>
                                 <ItemTemplate>
                                     <asp:CheckBox ID="chkSelect" runat="server" />
                                 </ItemTemplate>
                             </asp:TemplateField> 
                                                       
                            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                            
                            <asp:BoundField DataField="TagDate" HeaderText="Tag Date" SortExpression="TagDate" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />  
                            <asp:BoundField DataField="UserID" HeaderText="Assigned To" SortExpression="UserID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" /> 
                            <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />  
                            <asp:BoundField DataField="FirstLineApprovalStatus" HeaderText="First Line Approval Status" SortExpression="FirstLineApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                                                  
                         </Columns>
                     </asp:GridView> 

                     <asp:Label ID="lblUserID" runat="server" Visible="false" /> 
</asp:Content>

