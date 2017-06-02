<%@ Page Title="Assign New TOP Logs" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Assign.aspx.vb" Inherits="TOPLog_Assign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/print.css" media="print" rel="stylesheet" />    
    
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
  <li class="dropdown active">
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

  <li class="dropdown">
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
 
         <asp:SqlDataSource ID="dsAssignments" runat="server" OnSelected="OnSelectedHandler"
        ConnectionString="<%$ ConnectionStrings:TOPLogConnectionString %>"
        SelectCommand="p_TOPLogQueue" SelectCommandType="StoredProcedure"
        UpdateCommand="p_TOPLogAssign" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="TOPLogID" />
            <asp:Parameter Name="UserID" />
        </UpdateParameters>
        </asp:SqlDataSource>

 <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">TOP Assignments</span>
  </div>
        <div class="panel-body">
    
    <table>
        <tr>
            <td>
                <p>This form allows Loan Analysts to assign TOP records to themselves.</p>
            </td>
        </tr>
        <tr>
            <td style="padding-left: 20px">
                <asp:Button ID="btnMasterCheck" runat="server" CommandName="Check" CommandArgument="Check" OnCommand="MasterCheck_Click" Text="Check All TOP records" />
                <asp:Button ID="btnAssignTopLogs" runat="server" Text="Assign Checked TOP records to Me" OnClick="btnAssignTOPLogs_Click" OnClientClick="return confirm('Are you sure that you want to assign the checked TOP records to yourself?')" Enabled="false" /></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblAssignStatus" runat="server" ForeColor="Blue" /></td>
        </tr>
    </table>
    <p />
    <asp:Label ID="lblRowCount" runat="server" CssClass="text-info" />
    <asp:GridView ID="grdTOPLogQueue" runat="server" AutoGenerateColumns="false" EmptyDataText="There are no pending TOP records in the queue"
        DataKeyNames="TOPLogID" OnPageIndexChanging="grdTOPLogQueue_PageIndexChanging" AllowSorting="true" AllowPaging="true" PageSize="50" Width="95%"
        OnRowDataBound="grdTOPLogQueue_RowDataBound" DataSourceID="dsAssignments" CssClass="table table-hover table-striped table-bordered table-condensed GridView">       
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" runat="server" OnCheckedChanged="chkSelect_CheckedChanged" AutoPostBack="true" Width="5px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="LogDate" HeaderText="Log Date" SortExpression="LogDate" DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval Status" SortExpression="ApprovalStatus" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" />
        </Columns>
    </asp:GridView>

 </div></div>
    <asp:Label ID="lblUserID" runat="server" Visible="false" />
</asp:Content>

