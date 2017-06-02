<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UserManager.aspx.vb" Inherits="AWGHearings_UserManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .cb label
        {
            margin-left: 7px;
            font-weight: normal;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<h3>AWG Hearings - User Manager</h3>  

 <div>
 <ul class="nav nav-tabs">
  <li><a href="Upload.aspx">Upload New Batch</a></li>
  <li><a href="Reports.aspx">Reports</a></li>
  <li><a href="Search.aspx">Search</a></li>
  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Admin <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="UserManager.aspx">User Manager</a></li> 
    </ul>
  </li>
 </ul>
 </div>


<div class="well">
<p>The checked users are active and available to receive new hearings.</p>
<asp:CheckBoxList ID="cblUsers" runat="server" CssClass="cb" RepeatColumns="2" RepeatDirection="Vertical" Width="90%" CellPadding="5" CellSpacing="5">
</asp:CheckBoxList>
<asp:Button ID="btnUpdate" CssClass="btn btn-md btn-primary col-lg-offset-6" Text="Update" runat="server" OnClick="btnUpdate_Click" />
</div>
</asp:Content>

