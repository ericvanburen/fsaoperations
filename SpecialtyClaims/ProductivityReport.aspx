<%@ Page Title="Loan Analyst Productivity Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ProductivityReport.aspx.vb" Inherits="SpecialtyClaims_ProductivityReport" EnableEventValidation="false" %>

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
 
 <asp:SqlDataSource ID="dsProductivityReport" runat="server" SelectCommand="p_ReportLAProductivity"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="DateCompletedBegin" />
         <asp:Parameter Name="DateCompletedEnd" />
     </SelectParameters>      
</asp:SqlDataSource>

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
        <li><a href="AgingClaims.aspx">Aging Claims - Servicer</a></li> 
        <li><a href="AgingClaims_ClaimType.aspx">Aging Claims - Claim Type</a></li>        
    </ul>
  </li>
  <li><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />


    <div class="panel panel-primary">
    <div class="panel-heading">
        <span class="panel-title">Loan Analyst Productivity Report</span>
    </div>
    <div class="panel-body">
     <div class="row">
      <fieldset>                
        <!--DateCompleted Begin-->
        <label class="control-label" for="MainContent_txtDateCompleted" style="margin-left: 15px;"> Date Completed Begin Date: </label>
        <asp:TextBox ID="txtDateCompletedBegin" runat="server" CssClass="datepicker" TabIndex="1" />
        <!--DateCompleted End-->
        <label class="control-label" for="MainContent_txtDateCompleted"> Date Completed End Date: </label>
        <asp:TextBox ID="txtDateCompletedEnd" runat="server" CssClass="datepicker" TabIndex="2" />   
      
        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-md btn-primary" Text="Search" OnClick="btnSearch_Click" TabIndex="3" />
        <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-md btn-danger" Text="Export to Excel" OnClick="btnExportExcel_Click" Visible="false" />
    </fieldset>
    </div>
    <br />
        <asp:GridView ID="GridView1" runat="server" DataSourceID="dsProductivityReport" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped">
        <Columns>
            <asp:BoundField DataField="Loan Analyst" HeaderText="Loan Analyst" SortExpression="Loan Analyst"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Discharge Type" HeaderText="Discharge Type" SortExpression="Discharge Type"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Date Completed" HeaderText="Date Completed" SortExpression="Date Completed"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Completions" HeaderText="Completions" SortExpression="Completions"
                HeaderStyle-HorizontalAlign="Center" />
        </Columns>
    </asp:GridView>
</div>
</div>
</asp:Content>

