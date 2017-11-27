<%@ Page Title="DMCS Refunds - Refund Detail" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RefundDetail.aspx.vb" Inherits="DMCSRefunds_RefundDetail" %>
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

<asp:SqlDataSource ID="dsRefundID" runat="server" SelectCommand="p_RefundID" SelectCommandType="StoredProcedure" OnUpdating="dsRefundID_Updating"
UpdateCommand="p_RefundID_Update" UpdateCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>">
<SelectParameters>
    <asp:Parameter Name="RefundID" Type="Int32" DefaultValue="0" />
</SelectParameters>
<UpdateParameters>
    <asp:Parameter Name="RefundID" Type="Int32" DefaultValue="0" />
    <asp:Parameter Name="UserID" Type="String" />
    <asp:Parameter Name="NoOfPayments" Type="Int32" />
    <asp:Parameter Name="RefundAmount" Type="Decimal" />
    <asp:Parameter Name="FirstLineApprovalStatus" Type="String" />
    <asp:Parameter Name="FirstLineDateApproved" Type="DateTime" />
    <asp:Parameter Name="SecondLineApprovalStatus" Type="String" />
    <asp:Parameter Name="SecondLineApprovedBy" Type="String" />
	<asp:Parameter Name="SecondLineDateApproved" Type="DateTime" />
	<asp:Parameter Name="Comments" Type="String" />
</UpdateParameters>
</asp:SqlDataSource>

<table border="0" width="100%">
<tr>
    <td class="formLabelHeader">DMCS Refund Details</td>
    <td align="right">
     <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" /> 

     <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
          <telerik:RadMenu ID="RadMenu1" runat="server" EnableRoundedCorners="true" EnableShadows="true" />
     </div>
    </td>
</tr>
</table>
<br />   

    <!--List of users/LAs-->
    <asp:SqlDataSource ID="dsUserID" runat="server" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>"
        SelectCommand="p_AllUsers" SelectCommandType="StoredProcedure" />
<fieldset>

       <asp:FormView ID="FormView1" runat="server" DataSourceID="dsRefundID" OnItemUpdating="FormView1_ItemUpdating" OnItemUpdated="FormView1_ItemUpdated" 
        DataKeyNames="RefundID" DefaultMode="Edit" Width="95%" 
        HorizontalAlign="Center">
<EditItemTemplate>

    <table width="100%" cellpadding="2" cellspacing="2" border="0">
     <tr>
        <td colspan="2"><hr /></td>
     </tr>     
     <tr>
        <td colspan="2" class="formLabelHeader">Refund Details</td>
     </tr>
     <tr>
        <td colspan="2"><hr /></td>
     </tr>
      <tr>
        <td colspan="2"><span class="formLabel">Refund ID: <%# Eval("RefundID")%></span></td>
     </tr>
      <tr>
        <td><span class="formLabel">Borrower Number</span><br />
        <asp:Label ID="lblBorrowerNumber" runat="server" Text='<%# Eval("BorrowerNumber")%>' /></td> 
        
        <td><span class="formLabel">Assigned To</span><br />
        <asp:DropDownList ID="ddlUserID" runat="server" DataSourceID="dsUserID" DataTextField="UserID"
                  DataValueField="UserID" AppendDataBoundItems="true" SelectedValue='<%# Bind("UserID") %>'>
                  <asp:ListItem Text="" Value="" />
              </asp:DropDownList><br /></td>
        </tr>
        <tr>                                                   
            <td><span class="formLabel">Refund Tag Date</span><br />      
            <asp:Label ID="lblTagDate" runat="server" Text='<%# Eval("TagDate")%>' /></td>

            <td><span class="formLabel">Date Assigned:</span><br />      
            <asp:Label ID="Label1" runat="server" Text='<%# Eval("DateAssigned")%>' /><br /></td>
      </tr>
    
      <tr>
        <td><span class="formLabel">Refund Amount</span><br />                    
        <asp:TextBox ID="txtRefundAmount" runat="server" Text='<%# Bind("RefundAmount")%>' /></td>
        <td><span class="formLabel"># of Payments</span><br />       
        <asp:TextBox ID="txtNoOfPayments" runat="server" Text='<%# Bind("NoOfPayments")%>' /><br /></td>        
      </tr>
      <tr>   
      <tr>
        <td colspan="2"><hr /></td>
     </tr>
      <tr>
        <td colspan="2" class="formLabelHeader">Approval Status</td>
     </tr>
     <tr>
        <td colspan="2"><hr /></td>
     </tr>    
        
        <td><span class="formLabel">First Line Approval Status</span><br />
        <asp:DropDownList ID="ddlFirstLineApprovalStatus" runat="server" SelectedValue='<%#Bind("FirstLineApprovalStatus") %>'>
                  <asp:ListItem Text="" Value="" />
                  <asp:ListItem Text="Received" Value="Received" />
                  <asp:ListItem Text="Approved" Value="Approved" />
                  <asp:ListItem Text="Denied" Value="Denied" />
                  <asp:ListItem Text="Pending" Value="Pending" />
                  <asp:ListItem Text="Issue" Value="Issue" />
              </asp:DropDownList>
          </td>
          <td><span class="formLabel">First Line Date Approved</span><br />          
          <asp:Label id="lblFirstLineDateApproved" runat="server" Text='<%# Bind("FirstLineDateApproved")%>' /><br /></td>
      </tr>
      <tr>        
        <td><span class="formLabel">Second Line Approval Status</span><br />
        <asp:DropDownList ID="ddlSecondLineApprovalStatus" runat="server" SelectedValue='<%#Bind("SecondLineApprovalStatus") %>'>
                  <asp:ListItem Text="" Value="" />
                  <asp:ListItem Text="Received" Value="Received" />
                  <asp:ListItem Text="Approved" Value="Approved" />
                  <asp:ListItem Text="Denied" Value="Denied" />
                  <asp:ListItem Text="Pending" Value="Pending" />
                  <asp:ListItem Text="Issue" Value="Issue" />
              </asp:DropDownList>
          </td>
          <td><span class="formLabel">Second Line Approved By</span><br />
          <asp:DropDownList ID="ddlSecondLineApprovedBy" runat="server" SelectedValue='<%#Bind("SecondLineApprovedBy") %>'>
                  <asp:ListItem Text="" Value="" />
                  <asp:ListItem Text="alicia.wise" Value="alicia.wise" />
                  <asp:ListItem Text="bobby.ferrell" Value="bobby.ferrell" />
                  <asp:ListItem Text="evelyn.gresham" Value="evelyn.gresham" />
                  <asp:ListItem Text="melissa.yancy-venson" Value="melissa.yancy-venson" />
                  <asp:ListItem Text="virginia.avery" Value="virginia.avery" />
                  <asp:ListItem Text="wanda.briscoe" Value="wanda.briscoe" />
              </asp:DropDownList>
          </td>
      </tr>
      <tr>        
        <td><span class="formLabel" colspan="2">Second Line Date Approved:</span><br />       
        <%# Eval("SecondLineDateApproved")%></td>
      </tr>
      <tr>
        <td><span class="formLabel" colspan="2">Comments</span><br />                    
        <asp:Label id="lblComments" runat="server" Text='<%# Bind("Comments")%>' /></td>
      </tr>      
      <tr>
              <td colspan="2" align="center">
                <asp:Button id="UpdateButton"
                  text="Update"
                  commandname="Update"
                  runat="server" Visible="false" />
                <asp:Button id="CancelButton"
                  text="Cancel"
                  commandname="Cancel"
                  runat="server" Visible="false" /> 
              </td>
            </tr>

    </table>    
               
  </EditItemTemplate> 
</asp:FormView>

<div align="center">
        <asp:Label ID="lblUpdateStatus" runat="server" CssClass="failureNotification" />
    </div>
</fieldset> 
<asp:Label ID="lblRefundID" runat="server" Visible="true" />
</asp:Content>

