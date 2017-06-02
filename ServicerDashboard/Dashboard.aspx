<%@ Page Title="Servicer Outages Dashboard" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="ServicerDashboard_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Servicer Outages Dashboard</h3>

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="active"><a href="Dashboard.aspx">Dashboard</a></li>
  <li><a href="AddUpdate.aspx">Enter New Update</a></li>
  <li><a href="ServicerHistory.aspx">Servicer History</a></li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />
<asp:SqlDataSource ID="dsDashboard" runat="server" SelectCommand="p_Dashboard"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:ServicerDashboardConnectionString %>" />

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Current Servicer Status</span>
  </div>
  <div class="panel-body">
    <br />
 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsDashboard" AllowSorting="true" OnRowDataBound="GridView1_RowDataBound"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-condensed " DataKeyNames="ServicerUpdateID">
        <Columns>            
            <asp:TemplateField HeaderText="History" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="25px">
                <ItemTemplate>
                    <a href="ServicerHistory.aspx?ServicerID=<%# Container.DataItem("ServicerID")%>">
                    <img src="../Images/icons/Search.png" border="0" alt="Details" height="16" width="16" /></a>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
             <asp:BoundField DataField="DateAdded" HeaderText="Last Update" SortExpression="DateAdded"
                HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150px"  />                     
        </Columns>       
    </asp:GridView>
  </div>
</div>

</asp:Content>

