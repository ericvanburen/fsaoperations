<%@ Page Title="Servicer Receipt Report - Specialty Claims" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ServicerReceipts.aspx.vb" Inherits="SpecialtyClaims_ServicerReceipts" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>      
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
   
<script type="text/javascript">
    $(document).ready(function () {
       $('.datepicker').datepicker()
     }); 

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>Specialty Claims Tracking</h3> 

<div>
 <ul class="nav nav-tabs">
  <li><a href="EnterNewClaim.aspx">Enter New Claim</a></li>
  <li><a href="Search.aspx">Search/Update By Account</a></li>
  <li><a href="UpdateBatch.aspx">Approve Batch</a></li>  
  <li><a href="Upload.aspx">Upload New Batch</a></li>
  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="Reports.aspx">Servicer Files</a></li>
        <li><a href="ProductivityReport.aspx">LA Productivity</a></li>
        <li><a href="ServicerReceipts.aspx">Received By FSA</a></li>  
        <li><a href="ServicerReceiptsCountByMonth.aspx">Received By FSA By Month</a></li>
        <li><a href="AgingClaims.aspx">Aging Claims - Servicer</a></li> 
        <li><a href="AgingClaims_ClaimType.aspx">Aging Claims - Claim Type</a></li>     
    </ul>
  </li>
  <li><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />
<asp:SqlDataSource ID="dsServicerReceiptReport" runat="server" SelectCommand="p_ReportServicerReceipt"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="DateReceivedBegin" />
         <asp:Parameter Name="DateReceivedEnd" />
     </SelectParameters>      
</asp:SqlDataSource>

<div class="panel panel-primary">
    <div class="panel-heading">
        <span class="panel-title">FSA Receipt Report</span>
    </div>
    <div class="panel-body">
     <div class="row">
      <fieldset>                
        <!--DateReceived Begin-->
        <label class="control-label" for="MainContent_txtDateReceived" style="margin-left: 15px;"> Date Received Begin Date: </label>
        <asp:TextBox ID="txtDateReceivedBegin" runat="server" CssClass="datepicker" TabIndex="1" />
        <!--DateReceived End-->
        <label class="control-label" for="MainContent_txtDateReceived"> Date Received End Date: </label>
        <asp:TextBox ID="txtDateReceivedEnd" runat="server" CssClass="datepicker" TabIndex="2" />   
      
        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-md btn-primary" Text="Search" OnClick="btnSearch_Click" TabIndex="3" />
        <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-md btn-danger" Text="Export to Excel" OnClick="btnExportExcel_Click" Visible="false" />
    </fieldset>
    </div>
    <br />
        <asp:GridView ID="GridView1" runat="server" DataSourceID="dsServicerReceiptReport" AllowSorting="true" OnRowDataBound="GridView1_RowDataBound"
        AutoGenerateColumns="false" CssClass="table">
        <Columns>
            <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Discharge Type" HeaderText="Discharge Type" SortExpression="Discharge Type"
                HeaderStyle-HorizontalAlign="Center" />            
            <asp:BoundField DataField="NumberReceived" HeaderText="Number Received" SortExpression="NumberReceived"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="NumberApproved" HeaderText="Number Approved" SortExpression="NumberApproved"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="NumberDenied" HeaderText="Number Denied" SortExpression="NumberDenied"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="NumberPending" HeaderText="Number Pending" SortExpression="NumberPending"
                HeaderStyle-HorizontalAlign="Center" />
        </Columns>
    </asp:GridView>
</div>
</div>

</asp:Content>

