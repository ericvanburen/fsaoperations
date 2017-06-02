<%@ Page Title="Loan Analyst Count" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Report_LACount.aspx.vb" Inherits="TOPLog_Report_LACount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script> 
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
         $(document).ready(function () {
             $('#NavigationMenu').addClass('active');
        });
      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <!--Begin Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="MyTOPRecords.aspx">My TOP Reviews</a></li>
        <li><a href="Assign.aspx">Assign Myself New Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="Search.aspx">TOP Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Report_LACount.aspx">LA Review Counts</a></li>
        <li><a href="Report_PICLogErrors.aspx">PIC Log Errors</a></li>        
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A4" class="dropdown-toggle" data-toggle="dropdown">Administrator <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Upload.aspx">Upload New PIC Log</a></li>
        <li><a href="Reassign.aspx">Reassign Logs</a></li>
    </ul>
  </li>  
 </ul>
 </div><br />
<!--End Navigation Menu-->

   <asp:SqlDataSource ID="dsReportLoanAnalystCount" runat="server"
        ConnectionString="<%$ ConnectionStrings:TOPLogConnectionString %>"
        SelectCommand="p_ReportLoanAnalystCount" SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    
  <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Loan Analyst TOP Log Status Count</span>
  </div>
        <div class="panel-body">
            <table class="table">
                <tr>
                    <td>This report provides a count of TOP log records assigned to Loan Analysts and their current status.</td>
                </tr>
                <tr><td>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="dsReportLoanAnalystCount" 
                AutoGenerateColumns="false" CssClass="table table-hover table-striped" AllowSorting="true">
                <Columns>                     
                    <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval Status" SortExpression="ApprovalStatus" HeaderStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="TOPLogCount" HeaderText="Log Count" HeaderStyle-HorizontalAlign="Center" SortExpression="TOPLogCount" /> 
                </Columns>
                </asp:GridView>
                </td></tr>
            </table>
        </div>
   </div>
</asp:Content>

