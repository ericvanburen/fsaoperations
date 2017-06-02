<%@ Page Title="Aging Claims Report By Claim Type" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="AgingClaims_ClaimType.aspx.vb" Inherits="SpecialtyClaims_AgingClaims" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
  
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
        <li><a href="AgingClaims.aspx">Aging Claims - Servicer</a></li> 
        <li><a href="AgingClaims_ClaimType.aspx">Aging Claims - Claim Type</a></li>     
    </ul>
  </li>
  <li><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />
<asp:SqlDataSource ID="dsAgingClaimsReport" runat="server" SelectCommand="p_ReportAgingClaims_ClaimType"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>">       
</asp:SqlDataSource>

<div class="panel panel-primary">
    <div class="panel-heading">
        <span class="panel-title">Aging Claims Report By Claim Type</span>
    </div>
    <div class="panel-body"> 
        <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-md btn-danger" Text="Export to Excel" OnClick="btnExportExcel_Click" /><br />   
    <br />
        <asp:GridView ID="GridView1" runat="server" DataSourceID="dsAgingClaimsReport" AllowSorting="true" 
        AutoGenerateColumns="false" CssClass="table">
        <Columns>
            <asp:BoundField DataField="Discharge Type" HeaderText="Discharge Type" SortExpression="Discharge Type"
                HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Outstanding Claims" HeaderText="Outstanding Claims" SortExpression="Outstanding Claims"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Oldest_Claim" HeaderText="Oldest Claim" SortExpression="Oldest_Claim" HtmlEncode="false" DataFormatString="{0:d}"
                HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Days_Old" HeaderText="Days Old" SortExpression="Days_Old"
                HeaderStyle-HorizontalAlign="Center" /> 
        </Columns>
    </asp:GridView>
</div>
</div>
</asp:Content>

