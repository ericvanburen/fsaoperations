<%@ Page Title="Specialty Claims Tracking - Servicer Files" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Reports.aspx.vb" Inherits="SpecialtyClaims_Reports" 
MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

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

    <style type="text/css">
        .cb label
        {
            margin-left: 7px;
        }
    </style>
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
<p>Please select a servicer name.  To export the report to Excel enter a Servicer Informed Date and click the Export to Excel button</p>

    <asp:SqlDataSource ID="dsAllAgencies" runat="server" SelectCommand="p_AllAgencies_Report"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>" />

    <asp:SqlDataSource ID="dsReportByAgency" runat="server" SelectCommand="p_Report_By_Agency" OnSelected="dsReportByAgency_Selected"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>">
        <SelectParameters>
            <asp:Parameter Name="Servicer" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

       

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Create Servicer Files</span>
  </div>
  <div class="panel-body">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>
        <td>
        <asp:RadioButtonList ID="cblAllAgencies" runat="server" DataSourceID="dsAllAgencies" AutoPostBack="true" 
        DataTextField="Servicer" DataValueField="Servicer" CssClass="cb" RepeatColumns="2" RepeatDirection="Vertical" Width="90%" CellPadding="5" CellSpacing="5" />
        
        <p>Servicer Informed Date: <asp:TextBox ID="txtServicerInformedDate" runat="server" CssClass="datepicker" /></p>
          <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List" CssClass="alert-danger" />
          <asp:RequiredFieldValidator ID="rfdServicerInformedDate" runat="server" ErrorMessage="* Servicer Informed Date is a required field to export to Excel *" Display="None" ControlToValidate="txtServicerInformedDate" />
          <asp:RequiredFieldValidator ID="rfdAllAgencies" runat="server" ErrorMessage="* Please select a servicer *" Display="None" ControlToValidate="cblAllAgencies" /></td>
    </tr>
    <tr>
        <td align="center" colspan="2"><asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" OnClick="btnExportExcel_Click" 
        CssClass="btn btn-lg btn-warning" Visible="false" /></td>
    </tr>
</table>
</div>
</div>

<br />
<asp:Label ID="lblSearchResultsStatus" runat="server" />
    <asp:GridView ID="GridView1" runat="server" DataSourceID="dsReportByAgency" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ClaimID">
        <Columns>
            <asp:BoundField DataField="ClaimID" HeaderText="Claim ID" SortExpression="ClaimID"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="AccountNumber" HeaderText="SSN" SortExpression="AccountNumber"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="BorrowerName" HeaderText="Name" SortExpression="BorrowerName"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DischargeType" HeaderText="Discharge Type" SortExpression="DischargeType"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
            <asp:BoundField DataField="Approve" HeaderText="Approved?" SortExpression="Approve"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateCompleted" HeaderText="Date Completed" SortExpression="DateCompleted"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
        </Columns>
    </asp:GridView>
    

</asp:Content>

