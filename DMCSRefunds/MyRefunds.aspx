﻿<%@ Page Title="DMCS Refunds - My Refunds" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyRefunds.aspx.vb" Inherits="DMCSRefunds_MyRefunds" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery.toastmessage.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $get('<%= pnlpopup.ClientID %>').style.height = document.documentElement.clientHeight * 0.9 + "px";            
        });
   </script>
<script src="../Scripts/jquery.toastmessage.js" type="text/javascript"></script>
<script type="text/javascript">
        function showSuccessToast() {
            $().toastmessage('showSuccessToast', "Your refund was successfully updated");
        }

        function showWarningToast() {
            $().toastmessage('showWarningToast', "Your refund was not updated");
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ToolkitScriptManager ID="ScriptManager1" runat="server">
 </asp:ToolkitScriptManager>

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
    <td class="formLabelHeader">My DMCS Refunds Queue - <asp:Label ID="lblUserID" runat="server" Visible="true" /></td>
    <td align="right">
     <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" /> 

     <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
          <telerik:RadMenu ID="RadMenu1" runat="server" EnableRoundedCorners="true" EnableShadows="true" />
     </div>
    </td>
</tr>
</table>
<br />        <asp:SqlDataSource ID="dsMyRefunds" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>" 
                    SelectCommand="p_MyRefundQueue" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="UserID" /> 
                        <asp:Parameter Name="FirstLineApprovalStatus" />                       
                    </SelectParameters>                    
                  </asp:SqlDataSource>

                  <asp:SqlDataSource ID="dsMyRefundsTotals" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>" 
                    SelectCommand="p_Report_CountByLAStatus_Individual" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="UserID" />                                                
                    </SelectParameters>                    
                  </asp:SqlDataSource>

    <!--List of users/LAs-->
    <asp:SqlDataSource ID="dsUserID" runat="server" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>"
        SelectCommand="p_AllUsers" SelectCommandType="StoredProcedure" />
                  
                  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                  <Triggers>
                    <asp:PostBackTrigger ControlID="btnExportToExcel" />
                  </Triggers>
                  <ContentTemplate>
                  
                  
                  <div>
                  <table border="0" width="100%">
                  <tr>
                    <td align="left" style="padding-left: 23px">Show Refunds in Status: <asp:DropDownList ID="ddlFirstLineApprovalStatus" runat="server" OnSelectedIndexChanged="ddlFirstLineApprovalStatus_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Text="Received" Value="Received" Selected="True" />
                    <asp:ListItem Text="Approved" Value="Approved" />
                    <asp:ListItem Text="Denied" Value="Denied" />
                    <asp:ListItem Text="Pending" Value="Pending" />
                    </asp:DropDownList></td>
                    <td align="right" style="padding-right: 23px;">
                     <asp:GridView ID="grdMyTotals" runat="server" DataSourceID="dsMyRefundsTotals" 
                            CellPadding="4" ForeColor="#333333" GridLines="None" Width="200px" Caption="My Totals">
                          <AlternatingRowStyle BackColor="White" />
                          <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                          <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                          <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                          <RowStyle BackColor="#E3EAEB" Font-Size="Small" HorizontalAlign="Center" />                          
                      </asp:GridView>
                    </td>        
                                
                  </tr>                  
                  </table>                  
                  </div>
                  
                           
                  <asp:GridView ID="grdMyRefundQueue" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="There are no pending refunds in your queue" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="RefundID" HorizontalAlign="Center"
                         OnPageIndexChanging="grdMyRefundQueue_PageIndexChanging" EmptyDataRowStyle-Font-Size="Medium" AllowSorting="true" AllowPaging="true" PageSize="50" Width="95%"
                         OnRowDataBound="grdMyRefundQueue_RowDataBound" DataSourceID="dsMyRefunds"> 
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
                              <asp:TemplateField HeaderText="Edit">
                                 <ItemTemplate>
                                     <asp:ImageButton ID="imgbtn" ImageUrl="images/pencil.gif" runat="server" Width="25" Height="25"
                                         OnClick="imgbtn_Click" />
                                 </ItemTemplate>
                             </asp:TemplateField>                              
                            <asp:BoundField DataField="RefundID" HeaderText="ID" SortExpression="RefundID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                           
                            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                            
                            <asp:BoundField DataField="TagDate" HeaderText="Tag Date" SortExpression="TagDate" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                                                       
                            <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="FirstLineApprovalStatus" HeaderText="First Line Approval Status" SortExpression="FirstLineApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="SecondLineApprovalStatus" HeaderText="Second Line Approval Status" SortExpression="SecondLineApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                         </Columns>
                     </asp:GridView>

                   
 
                     <br />
                     
                     <div align="center">
                        <asp:Button ID="btnExportToExcel" runat="server" Text="Export Checked Rows To Excel" onclick="btnExportToExcel_Click"  />
                     </div>

    <!--This is the modal popup table-->
    <asp:Label ID="lblresult" runat="server" />
    <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowPopup"
        PopupControlID="pnlpopup" CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Width="700px"
        Style="display: none">
        <table width="100%" style="border: Solid 3px #D55500; width: 100%; height: 100%; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 5px;" cellpadding="5" cellspacing="5">
            <tr style="background-color: #D55500">
                <td colspan="2" style="color: White; font-weight: bold; font-size: large"
                    align="center">Refund ID: <asp:Label ID="lblRefundID" runat="server" /></td>
            </tr>
            
            <tr>
                <td colspan="2" class="formLabelHeader">
                    Refund Details <asp:Button ID="btnUpdate2" CommandName="Update" runat="server" Text="Update" OnClick="btnUpdate_Click" OnClientClick="javascript:showSuccessToast();" />
                                   <asp:Button ID="btnCancel2" runat="server" Text="Cancel" OnClientClick="javascript:showWarningToast();" /><br />
                 <hr />
                </td>
            </tr>
           
            <tr>
                <td>
                    <span class="formLabel">Borrower Number</span><br />
                    <asp:Label ID="lblBorrowerNumber" runat="server" />
                </td>
                <td>
                    <span class="formLabel">Assigned To</span><br />
                    <asp:DropDownList ID="ddlUserID" runat="server" Enabled="false">
                        <asp:ListItem Text="" Value="" />
                    </asp:DropDownList>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <span class="formLabel">Refund Tag Date</span><br />
                    <asp:Label ID="lblTagDate" runat="server" />
                </td>
                <td>
                    <span class="formLabel">Date Assigned</span><br />
                    <asp:Label ID="lblDateAssigned" runat="server" /><br />
                </td>
            </tr>
            <tr>
                <td>
                    <span class="formLabel">Refund Amount</span><br />
                    <asp:TextBox ID="txtRefundAmount" runat="server" />
                </td>
                <td>
                    <span class="formLabel"># of Payments</span><br />
                    <asp:TextBox ID="txtNoOfPayments" runat="server" /><br />
                </td>
            </tr>
           
            <tr>
                <td class="formLabelHeader" colspan="2">
                    Approval Status<br />
                    <hr />
                </td>
            </tr>            
            <tr>
                <td>
                    <span class="formLabel">First Line Approval Status</span><br />
                    <asp:DropDownList ID="ddlFirstLineApprovalStatusForm" runat="server">
                        <asp:ListItem Text="" Value="" />
                        <asp:ListItem Text="Received" Value="Received" />
                        <asp:ListItem Text="Approved" Value="Approved" />
                        <asp:ListItem Text="Denied" Value="Denied" />
                        <asp:ListItem Text="Pending" Value="Pending" />
                    </asp:DropDownList>
                </td>
                <td>
                    <span class="formLabel">First Line Date Approved</span><br />
                    <asp:Label ID="lblFirstLineDateApproved" runat="server" />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <span class="formLabel">Second Line Approval Status</span><br />
                    <asp:DropDownList ID="ddlSecondLineApprovalStatus" runat="server">
                        <asp:ListItem Text="" Value="" />
                        <asp:ListItem Text="Received" Value="Received" Selected="True" />
                        <asp:ListItem Text="Approved" Value="Approved" />
                        <asp:ListItem Text="Denied" Value="Denied" />
                        <asp:ListItem Text="Pending" Value="Pending" />
                    </asp:DropDownList>
                </td>
                <td>
                    <span class="formLabel">Second Line Approved By</span><br />
                    <asp:DropDownList ID="ddlSecondLineApprovedBy" runat="server">
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
                <td>
                    <span class="formLabel" colspan="2">Second Line Date Approved:</span><br />
                    <asp:Label ID="lblSecondLineDateApproved" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <span class="formLabel" colspan="2">Comments</span><br />
                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="3" Columns="65" /><br />
                    <asp:Button ID="btnUpdate" CommandName="Update" runat="server" Text="Update" OnClick="btnUpdate_Click" OnClientClick="javascript:showSuccessToast();" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="javascript:showWarningToast();" />
                </td>
            </tr>           
            <tr>
                <td colspan="2"><asp:Label ID="lblUpdateStatus" runat="server" CssClass="failureNotification" /></td>
            </tr>
        </table>
    </asp:Panel>
    <!--End modal popup table-->
    </ContentTemplate>
   </asp:UpdatePanel>   
                     
</asp:Content>
