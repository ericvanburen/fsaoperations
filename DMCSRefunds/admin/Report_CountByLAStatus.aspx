<%@ Page Title="DMCS Refunds - Report Count By LA In Each Status" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Report_CountByLAStatus.aspx.vb" Inherits="DMCSRefunds_Report_CountByLAStatus" %>
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
    <td class="formLabelHeader">Refund Count By Loan Analyst</td>
    <td align="right">
     <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" /> 

     <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
          <telerik:RadMenu ID="RadMenu1" runat="server" EnableRoundedCorners="true" EnableShadows="true" />
     </div>
    </td>
</tr>
</table>
<br />

                <!--First Line Approvals-->
                <asp:SqlDataSource ID="dsReport_CountByLAStatus" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>" 
                    SelectCommand="p_Report_CountByLAStatus" SelectCommandType="StoredProcedure">                           
                </asp:SqlDataSource>

                <!--Second Line Approvals-->
                <asp:SqlDataSource ID="dsReport_CountByLAStatus_SecondLine" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>" 
                    SelectCommand="p_Report_CountByLAStatus_SecondLine" SelectCommandType="StoredProcedure">                           
                </asp:SqlDataSource>

                <br />
                <asp:GridView ID="grdCountByLAStatus" runat="server" AutoGenerateColumns="false" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" HorizontalAlign="Center"
                         EmptyDataRowStyle-Font-Size="Medium" AllowSorting="true" AllowPaging="false" PageSize="50" Width="95%"
                         DataSourceID="dsReport_CountByLAStatus" Caption="First Line Approvals"> 
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
                            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                            
                            <asp:BoundField DataField="FirstLineApprovalStatus" HeaderText="First Line Approval Status" SortExpression="FirstLineApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="RefundCount" HeaderText="Total" SortExpression="RefundCount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                         </Columns>
                     </asp:GridView>
                     <br /><br />
                     <asp:GridView ID="grdCountByLAStatus_SecondLine" runat="server" AutoGenerateColumns="false" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" HorizontalAlign="Center"
                         EmptyDataRowStyle-Font-Size="Medium" AllowSorting="true" AllowPaging="false" PageSize="50" Width="95%"
                         DataSourceID="dsReport_CountByLAStatus_SecondLine" Caption="Second Line Approvals"> 
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
                            <asp:BoundField DataField="SecondLineApprovedBy" HeaderText="Loan Analyst" SortExpression="SecondLineApprovedBy" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                            
                            <asp:BoundField DataField="SecondLineApprovalStatus" HeaderText="Second Line Approval Status" SortExpression="SecondLineApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="RefundCount" HeaderText="Total" SortExpression="RefundCount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                         </Columns>
                     </asp:GridView>

  <asp:SqlDataSource ID="dsTotalCount" runat="server" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>"
        SelectCommand="p_Report_TotalCount" SelectCommandType="StoredProcedure">        
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsTotalCountByLA" runat="server" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>"
        SelectCommand="p_Report_TotalCountByLA" SelectCommandType="StoredProcedure">        
    </asp:SqlDataSource>    

    <br />

    <div id="dvGrid" class="grid" align="center">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="false"
               CssClass="datatable" BorderWidth="1px" BackColor="White" GridLines="Horizontal" CellPadding="3"
                BorderColor="#E7E7FF" Width="95%" BorderStyle="None" ShowFooter="false" DataSourceID="dsTotalCount">
                <EmptyDataTemplate>
                    No records matched your search
                </EmptyDataTemplate>
                <Columns>                    
                    <asp:BoundField DataField="FirstLineApprovalStatus" HeaderText="First Line Approval Status" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="RefundCount" HeaderText="Refund Count" ItemStyle-HorizontalAlign="Center" />                    
                </Columns>
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
            </asp:GridView>
            <br />
        </div>
      <br /><br />

        <!--Total Count By LA-->
        <div id="Div1" class="grid" align="center">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" AllowSorting="false"
               CssClass="datatable" BorderWidth="1px" BackColor="White" GridLines="Horizontal" CellPadding="3"
                BorderColor="#E7E7FF" Width="95%" BorderStyle="None" ShowFooter="false" DataSourceID="dsTotalCountByLA">
                <EmptyDataTemplate>
                    No records matched your search
                </EmptyDataTemplate>
                <Columns>                    
                    <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="RefundCount" HeaderText="Refund Count" ItemStyle-HorizontalAlign="Center" />                    
                </Columns>
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
            </asp:GridView>
            <br />
        </div>

</asp:Content>

