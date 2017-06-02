<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Report_TotalCount.aspx.vb" Inherits="DMCSRefunds_admin_Report_TotalCount" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
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
                BorderColor="#E7E7FF" Width="90%" BorderStyle="None" ShowFooter="false" DataSourceID="dsTotalCount">
                <EmptyDataTemplate>
                    No records matched your search
                </EmptyDataTemplate>
                <Columns>                    
                    <asp:BoundField DataField="FirstLineApprovalStatus" HeaderText="First Line Approval Status" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="RefundCount" HeaderText="Refund Count" ItemStyle-HorizontalAlign="Center" />                    
                </Columns>
                <RowStyle CssClass="row" />
                <AlternatingRowStyle CssClass="rowalternate" />
                <FooterStyle CssClass="gridcolumnheader" />
                <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                <HeaderStyle CssClass="gridcolumnheader" />
                <EditRowStyle CssClass="gridEditRow" />
            </asp:GridView>
            <br />
        </div>
        <hr />
        <!--Total Count By LA-->
        <div id="Div1" class="grid" align="center">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" AllowSorting="false"
               CssClass="datatable" BorderWidth="1px" BackColor="White" GridLines="Horizontal" CellPadding="3"
                BorderColor="#E7E7FF" Width="90%" BorderStyle="None" ShowFooter="false" DataSourceID="dsTotalCountByLA">
                <EmptyDataTemplate>
                    No records matched your search
                </EmptyDataTemplate>
                <Columns>                    
                    <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="RefundCount" HeaderText="Refund Count" ItemStyle-HorizontalAlign="Center" />                    
                </Columns>
                <RowStyle CssClass="row" />
                <AlternatingRowStyle CssClass="rowalternate" />
                <FooterStyle CssClass="gridcolumnheader" />
                <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                <HeaderStyle CssClass="gridcolumnheader" />
                <EditRowStyle CssClass="gridEditRow" />
            </asp:GridView>
            <br />
        </div>
        <hr />


</asp:Content>

