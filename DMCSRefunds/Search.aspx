<%@ Page Title="DMCS Refunds Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.vb" Inherits="DMCSRefunds_Search" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
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
    <td class="formLabelHeader">DMCS Refunds Search</td>
    <td align="right">
     <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" /> 

     <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
          <telerik:RadMenu ID="RadMenu1" runat="server" EnableRoundedCorners="true" EnableShadows="true" />
     </div>
    </td>
</tr>
</table>
<br />   
   
<div>
<fieldset>
<table border="0" width="100%">
<tr>
    <td class="formLabel">Refund ID:</td>
    <td><asp:TextBox ID="txtRefundID" runat="server" /></td>
    <td class="formLabel">Borrower #:</td>
    <td><asp:TextBox ID="txtBorrowerNumber" runat="server" /></td>
</tr>
<tr>
    <td class="formLabel">Tag Date >=:</td>
    <td><asp:TextBox ID="txtTagDate" runat="server" /></td>
    <td class="formLabel">Tag Date <=:</td>
    <td><asp:TextBox ID="txtTagDateEnd" runat="server" /></td>    
</tr>
<tr>
    <td class="formLabel">Assigned To:</td>
    <td> <asp:ListBox ID="ddlUserID" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" Rows="3">
                  <asp:ListItem Text="" Value="" />
              </asp:ListBox></td>
    <td class="formLabel">First Line Approval Status:</td>
    <td><asp:ListBox ID="ddlFirstLineApprovalStatus" runat="server" SelectionMode="Multiple" Rows="3">
                  <asp:ListItem Text="" Value="" />
                  <asp:ListItem Text="Received" Value="Received" />
                  <asp:ListItem Text="Approved" Value="Approved" />
                  <asp:ListItem Text="Denied" Value="Denied" />
                  <asp:ListItem Text="Pending" Value="Pending" />
              </asp:ListBox></td>
</tr>
<tr>
    <td class="formLabel">First Line Date Approved >=:</td>
    <td><asp:TextBox id="txtFirstLineDateApproved" runat="server" /></td>
    <td class="formLabel">First Line Date Approved <=:</td>
    <td><asp:TextBox id="txtFirstLineDateApprovedEnd" runat="server" /></td>
   
</tr>
<tr>
    <td class="formLabel">Second Line Date Approved >=:</td>
    <td><asp:TextBox id="txtSecondLineDateApproved" runat="server" /></td>
    <td class="formLabel">Second Line Date Approved <=:</td>
    <td><asp:TextBox id="txtSecondLineDateApprovedEnd" runat="server" /></td>
</tr>
<tr>
     <td class="formLabel">Second Line Approval Status:</td>
    <td><asp:ListBox ID="ddlSecondLineApprovalStatus" runat="server" SelectionMode="Multiple" Rows="3">
                  <asp:ListItem Text="" Value="" />
                  <asp:ListItem Text="Received" Value="Received" />
                  <asp:ListItem Text="Approved" Value="Approved" />
                  <asp:ListItem Text="Denied" Value="Denied" />
                  <asp:ListItem Text="Pending" Value="Pending" />
              </asp:ListBox></td>
    <td class="formLabel">Second Line Approved By:</td>
    <td><asp:ListBox ID="ddlSecondLineApprovedBy" runat="server" SelectionMode="Multiple" Rows="3">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="alicia.wise" Value="alicia.wise" />
                <asp:ListItem Text="bobby.ferrell" Value="bobby.ferrell" />
                <asp:ListItem Text="evelyn.gresham" Value="evelyn.gresham" />
                <asp:ListItem Text="melissa.yancy-venson" Value="melissa.yancy-venson" />
                <asp:ListItem Text="virginia.avery" Value="virginia.avery" />
                <asp:ListItem Text="wanda.briscoe" Value="wanda.briscoe" />
              </asp:ListBox></td>    
</tr>
<tr>
    <td class="formLabel">Refund Amount <=:</td>
    <td><asp:TextBox id="txtRefundAmount" runat="server" /></td>
    <td> </td>
    <td> </td>
</tr>

<tr>
    <td colspan="4" align="center"><br /><asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" Width="100px" CausesValidation="false" /></td>
</tr>
</table>
</fieldset>
<br /><br />
</div>
<!--Reassignment Section-->
<asp:Panel ID="pnlReassignmentSection" runat="server" Visible="false" style="padding-left: 12px">
    <asp:Button ID="btnMasterCheck" runat="server" CommandName="Check" CommandArgument="Check"
        OnCommand="MasterCheck_Click" Text="Check All Refunds" CausesValidation="false" />
    <asp:Button ID="btnAssignRefunds" runat="server" Text="Assign Checked Refunds to Loan Analyst"
        OnClick="btnAssignRefunds_Click" OnClientClick="return confirm('Are you sure that you want to assign the checked refunds to the selected LA?')" />
    <asp:DropDownList ID="ddlUserIDAssign" runat="server" AppendDataBoundItems="true">
        <asp:ListItem Text="" Value="" />
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please select a Loan Analyst"
        ControlToValidate="ddlUserIDAssign" CssClass="failureNotification" /> 
   <asp:Button ID="btnExportToExcel2" runat="server" Text="Export All Rows To Excel" onclick="btnExportToExcel_Click" Visible="false" CausesValidation="false" />
</asp:Panel>
 <br />
 <div>
    <asp:Label ID="lblRowCount" runat="server" CssClass="failureNotification" />
 </div>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="No refunds matched your search criteria" BorderColor="#E7E7FF" BorderStyle="None"       
    BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="RefundID" HorizontalAlign="Center"
    OnPageIndexChanging="GridView1_PageIndexChanging" EmptyDataRowStyle-Font-Size="Medium" AllowSorting="false" AllowPaging="false" Width="98%"
    OnRowDataBound="GridView1_RowDataBound" Font-Size="9pt"> 
    <AlternatingRowStyle BackColor="#F7F7F7"  />
    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C"  />
    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" Font-Size="9pt"  />
    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right"  />
    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" Font-Size="9pt"  />
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
    
        <asp:TemplateField HeaderText="Refund ID" SortExpression="RefundID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("RefundID", "RefundDetail.aspx?RefundID={0}") %>'
                    Text='<%# Eval("RefundID") %>' />
            </ItemTemplate>
        </asp:TemplateField>  
                            
    <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                            
    <asp:BoundField DataField="TagDate" HeaderText="Tag Date" SortExpression="TagDate" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" /> 
    <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                                                      
    <asp:BoundField DataField="UserID" HeaderText="Assigned To" SortExpression="UserID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
    <asp:BoundField DataField="FirstLineApprovalStatus" HeaderText="First Line Approval Status" SortExpression="FirstLineApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
    <asp:BoundField DataField="FirstLineDateApproved" HeaderText="First Line Date Approved" SortExpression="FirstLineDateApproved" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                            
    <asp:BoundField DataField="SecondLineApprovalStatus" HeaderText="Second Line Approval Status" SortExpression="SecondLineApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
    <asp:BoundField DataField="SecondLineDateApproved" HeaderText="Second Line Date Approved" SortExpression="SecondLineDateApproved" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" /> 
    </Columns>
</asp:GridView>
    <br />
    <div align="center">
        <asp:Button ID="btnExportToExcel" runat="server" Text="Export All Rows To Excel"
            OnClick="btnExportToExcel_Click" Visible="false" CausesValidation="false" />
    </div>
</asp:Content>

