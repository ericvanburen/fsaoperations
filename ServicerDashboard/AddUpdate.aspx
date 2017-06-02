<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="AddUpdate.aspx.vb" Inherits="ServicerDashboard_AddUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />   
    <script type="text/javascript">
        $(document).ready(function () {
            $("#form1").addClass("form-horizontal");
        });
    </script> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Servicer Outages Dashboard</h3>

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li><a href="Dashboard.aspx">Dashboard</a></li>
  <li class="active"><a href="AddUpdate.aspx">Enter New Update</a></li>
  <li><a href="ServicerHistory.aspx">Servicer History</a></li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

<!--Datasource for all of the Servicers-->
<asp:SqlDataSource ID="dsServicers" runat="server" SelectCommand="p_AllServicers"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:ServicerDashboardConnectionString %>" />

<!--Datasource for all of the Status-->
<asp:SqlDataSource ID="dsStatus" runat="server" SelectCommand="p_AllStatus"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:ServicerDashboardConnectionString %>" />

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Enter New Servicer Update</span>
  </div>
  <div class="panel-body">

<div class="control-group">
    <label class="control-label" for="inputEmail">Servicer Name</label>
    <div class="controls">
        <asp:DropDownList ID="ddlServicer" runat="server" CssClass="inputBox" AppendDataBoundItems="true" Width="150px" 
        DataSourceID="dsServicers" DataValueField="ServicerID" DataTextField="Servicer" AutoPostBack="true">
            <asp:ListItem Text="" Value="" />
        </asp:DropDownList>
        <br />            
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Servicer is a required field *"
        ControlToValidate="ddlServicer" Display="Dynamic" CssClass="alert-danger"  />
    </div>
</div>
    <div class="control-group">
        <label class="control-label" for="inputPassword">Current Status</label>
        <div class="controls">
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="inputBox" AppendDataBoundItems="true"
                DataSourceID="dsStatus" DataValueField="StatusID" DataTextField="Status" Width="150px">
                <asp:ListItem Text="" Value="" />
            </asp:DropDownList>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Status is a required field *"
                ControlToValidate="ddlStatus" Display="Dynamic" CssClass="alert-danger" />
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="inputPassword">Details</label>
        <div class="controls">
            <asp:TextBox ID="txtComments" runat="server" CssClass="inputbox" 
                TextMode="MultiLine" Columns="75" Height="143px" Width="620px" />
        </div>
    </div>
    <div class="control-group">
         <div class="controls"><br />
            <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-lg btn-primary" Text="Submit" OnClick="btnSubmit_Click" /><br />
        <asp:Label id="lblUpdateStatus" runat="server" CssClass="alert-success col-lg-offset-3" />
        </div>
    </div>   

   
  </div>
</div>

</asp:Content>

