<%@ Page Title="Upload New TOP Log" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Upload.aspx.vb" Inherits="TOPLog_Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/print.css" media="print" rel="stylesheet" />    
    
    <script type="text/javascript">
        $(function () {
            $("#MainContent_fileuploadExcel").on("click", function () {
                $('#MainContent_btnUploadExcelFile').prop('disabled', false);
            });
        });
    </script>   
    

     <script type="text/javascript">
         $(document).ready(function () {
             $('#NavigationMenu').addClass('active');
             $('#MainContent_btnUploadExcelFile').prop('disabled', true);

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

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Report_LACount.aspx">LA Review Counts</a></li>
        <li><a href="Report_PICLogErrors.aspx">PIC Log Errors</a></li>        
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="A4" class="dropdown-toggle" data-toggle="dropdown">Administrator <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Upload.aspx">Upload New PIC Log</a></li>
    </ul>
  </li>  
 </ul>
 </div><br />
<!--End Navigation Menu-->

    <asp:SqlDataSource ID="dsTOPLog" runat="server" ConnectionString="<%$ ConnectionStrings:TOPLogConnectionString %>"
        SelectCommand="p_RefundQueue" SelectCommandType="StoredProcedure" UpdateCommand="p_RefundAssign"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="RefundID" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <div class="panel panel-primary">
    <div class="panel-heading">
        <span class="panel-title">Upload New PIC Log</span>
    </div>
        <div class="panel-body">
        <table cellpadding="2" cellspacing="1" border="0" style="border-collapse: collapse;" width="100%">
        <tr>
            <td>Use this tool to upload a new batch of TOP logs into the application. <a href="PIC Log Format Template.xls">This template</a> must be used for all file uploads.<br /><br /></td>
        </tr>
            <tr>
            <td align="left"><b>Step 1:</b> Click the "Choose File" button and browse your desktop for the Excel file you want to upload. 
                     <asp:FileUpload ID="fileuploadExcel" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;<span
                         onclick="return confirm('Are you sure to import the selected Excel file?')">                         
                     </span>
            </td>
        </tr>
        <tr>
            <td align="left"><b>Step 2:</b> Click the "Import File" button. <asp:Button ID="btnUploadExcelFile" runat="Server" Text="Import File" OnClick="UploadFile_Click" /></td>
        </tr>
        <tr>
            <td align="left">
                <asp:Label ID="lblMessage" runat="Server" EnableViewState="False" ForeColor="Blue"> 
                </asp:Label>
            </td>
        </tr>
    </table>

  <hr />

    <asp:Label ID="lblRowCount" runat="server" /></p>
    <asp:GridView ID="grdTOPLog" runat="server" AutoGenerateColumns="false" EmptyDataText="There are no pending TOP logs in the queue" CssClass="table table-hover table-striped table-bordered table-condensed GridView"
       DataKeyNames="TOPLogID" HorizontalAlign="Center" AllowSorting="false" AllowPaging="false" Width="95%">        
        <Columns>
            <asp:BoundField DataField="TOPLogID" HeaderText="TOP Log ID" SortExpression="TOPLogID" />
            <asp:BoundField DataField="RowID" HeaderText="Row ID" SortExpression="RowID" />
            <asp:BoundField DataField="LogDate" HeaderText="Log Date" SortExpression="LogDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" />
            <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" />
            <asp:BoundField DataField="NewOffsetAmount" HeaderText="New Offset Amount" SortExpression="NewOffsetAmount" DataFormatString="{0:c}" HtmlEncode="false" />
            <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval Status" SortExpression="ApprovalStatus" />
        </Columns>
    </asp:GridView>
 </div>
 </div>
    <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
</asp:Content>

