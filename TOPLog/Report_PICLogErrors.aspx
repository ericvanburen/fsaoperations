<%@ Page Title="PIC Log Error Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Report_PICLogErrors.aspx.vb" Inherits="TOPLog_Report_PICLogErrors" EnableEventValidation="false" %>

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
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker()

            //Intializes the tooltips  
            $('[data-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                'placement': 'top'
            });
            $('[data-toggle="popover"]').popover({
                trigger: 'hover',
                'placement': 'top'
            });
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
  
         <asp:SqlDataSource ID="dsPICLogErrors" runat="server" OnSelected="OnSelectedHandler"
        ConnectionString="<%$ ConnectionStrings:TOPLogConnectionString %>"
        SelectCommand="p_PICLogErrors" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="DateApprovedFrom" />
            <asp:Parameter Name="DateApprovedTo" />
        </SelectParameters>
        </asp:SqlDataSource>

 <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PIC Log Error Report</span>
  </div>
  <div class="panel-body">    
    <table width="100%">
        <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Approved" data-content="The date(s) the TOP record was approved by a Loan Anlyst">Date Approved</a></th>
        </tr>
        <tr>
            <td class="tableColumnCell">from <asp:TextBox ID="txtDateApprovedFrom" runat="server" CssClass="datepicker" />            
             to <asp:TextBox ID="txtDateApprovedTo" runat="server" CssClass="datepicker" /></td>
        </tr>

        <tr>
            <td><asp:Label ID="lblRowCount" runat="server" CssClass="text-info" />
                <asp:GridView ID="grdPICLogErrors" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView"
                    GridLines="Horizontal" DataKeyNames="TOPLogID" HorizontalAlign="Center"
                    AllowSorting="true" Width="95%" DataSourceID="dsPICLogErrors">                   
                    <Columns>                        
                        <asp:BoundField DataField="LogDate" HeaderText="Log Date" SortExpression="LogDate" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Error" HeaderText="Error" SortExpression="Error" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />                        
                        <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval Status" SortExpression="ApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="DateApproved" HeaderText="Date Approved" SortExpression="DateApproved" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="FSAComments" HeaderText="FSA Comments" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="PICComments" HeaderText="PIC Comments" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
                   </Columns>
                </asp:GridView>
            <br /></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" />
                <asp:Button ID="btnSearchAgain" runat="server" CssClass="btn btn-md btn-warning" Text="Search Again" Visible="true" OnClick="btnSearchAgain_Click" />
                <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
            </td>
        </tr>
    </table>
    </div>
</div>
  
</asp:Content>

