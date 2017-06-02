<%@ Page Title="PCA Issues - Complaint Counts" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="Report_PCA_CountComplaintValidity.aspx.vb" Inherits="Issues_Report_PCA_CountComplaintValidity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        // this updates the active tab on the navbar
        $(document).ready(function () {
            //Dashboard
            $('#navA0').removeClass("active");
            //Add Issue
            $('#navA1').removeClass("active");
            //My Issues
            $('#navA2').removeClass("active");
            //Search Issues
            $('#navA3').removeClass("active");
            //Reports
            $('#navA4').addClass("active");
        });     
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            // initialize the datepicker object
            $('.datepicker').datepicker()
        }); 
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


<!--Datasource for GridView-->
<asp:SqlDataSource ID="dsPCAComplaints" runat="server" SelectCommand="p_Report_PCA_CountComplaintValidity"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>">
<SelectParameters>
    <asp:Parameter Name="DateReceivedBegin" Type="DateTime" />
    <asp:Parameter Name="DateReceivedEnd" Type="DateTime" />
</SelectParameters>
</asp:SqlDataSource>

<h4>PCA Complaint Counts</h4>
<table cellpadding="5" cellspacing="5">
    <tr>
        <td colspan="3">Enter Date Received Range</td>
    </tr>
    <tr>
        <td><input id="txtDateReceivedBegin" type="text" name="txtDateReceivedBegin" class="form-control datepicker" runat="server" placeholder="Begin Date Received" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="txtDateReceivedBegin" CssClass="alert-danger" ErrorMessage="Please enter a beginning received date" runat="server" />
        </td>
        <td><input id="txtDateReceivedEnd" type="text" name="txtDateReceivedEnd" class="form-control datepicker" runat="server" placeholder="End Date Received" /><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="txtDateReceivedEnd" CssClass="alert-danger" ErrorMessage="Please enter an ending received date" runat="server" />
        <td valign="top"><asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Search" CssClass="btn btn-md btn-warning" /></td>
    </tr>    
</table>
<br />   

<div class="panel panel-primary" id="pnlIssueType">
  <div class="panel-heading" id="pnlIssueTypeHeading">
    <span class="panel-title">PCA Complaint Counts</span>
  </div>
  <div class="panel-body" id="pnlIssueTypeBody" align="center">
  
    <table width="95%">    
    <tr>
        <td valign="top">
            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsPCAComplaints" Width="95%"
                CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="table table-hover table-striped" 
                AutoGenerateColumns="true" HorizontalAlign="Center">               
            </asp:GridView>
        </td>
   </tr>
    <tr>
        <td><asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" /></td>
    </tr>
</table> 
      
</div>
</div>
</asp:Content>

