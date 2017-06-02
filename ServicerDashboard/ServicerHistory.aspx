<%@ Page Title="Servicer History" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ServicerHistory.aspx.vb" Inherits="ServicerDashboard_ServicerHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    table {
        border-collapse: collapse;
        border-spacing: 0;
        font-size: small;
    }
    
    </style> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Servicer Outages Dashboard</h3>

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li><a href="Dashboard.aspx">Dashboard</a></li>
  <li><a href="AddUpdate.aspx">Enter New Update</a></li>
  <li class="active"><a href="ServicerHistory.aspx">Servicer History</a></li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />
<!--Datasource for all of the Servicers-->
<asp:SqlDataSource ID="dsServicers" runat="server" SelectCommand="p_AllServicers"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:ServicerDashboardConnectionString %>" />

<!--Datasource for Servicers History-->
<asp:SqlDataSource ID="dsServicerHistory" runat="server" SelectCommand="p_ServicerHistory"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:ServicerDashboardConnectionString %>">
<SelectParameters>
    <asp:Parameter Name="ServicerID" />
</SelectParameters>
</asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Servicer History</span>
  </div>
  <div class="panel-body">

<div class="pull-right">
Select a Servicer: 
<asp:DropDownList ID="ddlServicer" runat="server" CssClass="inputBox" AppendDataBoundItems="true" 
        DataSourceID="dsServicers" DataValueField="ServicerID" DataTextField="Servicer" AutoPostBack="true">
            <asp:ListItem Text="" Value="" />
</asp:DropDownList>
</div>

<asp:GridView ID="GridView1" runat="server" DataSourceID="dsServicerHistory" AllowSorting="true" OnRowDataBound="GridView1_RowDataBound" EmptyDataText="No updates available for this servicer"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-condensed " DataKeyNames="ServicerUpdateID" AllowPaging="true" PageSize="20">
        <EmptyDataRowStyle Font-Bold="true" Font-Size="Medium" />
        <Columns>            
              <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="DateAdded" HeaderText="Updated" SortExpression="DateAdded"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150px"  />                                
             <asp:TemplateField HeaderText="History" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="25px">
                <ItemTemplate>
                <asp:TextBox ID="txtComments" runat="server" Text='<%# Container.DataItem("Comments")%>' TextMode="MultiLine" Columns="60" Height="100px" />                    
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>       
    </asp:GridView>

</div>
</div>
</asp:Content>

