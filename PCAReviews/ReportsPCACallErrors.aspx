<%@ Page Title="PCA Reviews - Loan Analyst Errors" Language="VB" MasterPageFile="~/Site.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="ReportsPCACallErrors.aspx.vb" Inherits=" PCAReviews_ReportsPCACallErrors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
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

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Work <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Review Assignments</a></li>
        <li><a href="MyQCAssignments.aspx">My QC Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports2.aspx">Save New PCA Review</a></li>  
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="ReportCompletionCount.aspx">Completion Count</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="QCCalc.aspx">QC Calculator</a></li>
        <li><a href="QCTierReport.aspx">QC Tier Report</a></li>
        <li><a href="QCUserManager.aspx">QC User Manager</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p><br /></p>

 <asp:SqlDataSource ID="dsPCACallsLAErrorReport" runat="server" SelectCommand="p_PCACallsLAErrorReport" SelectCommandType="StoredProcedure" 
        ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
 </asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Reviews - Loan Analyst Errors</span>
  </div>
  <div class="panel-body">
      <span> Click a Loan Analyst name to see the list of reviews with errors.</span>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="dsPCACallsLAErrorReport" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="UserID">
        <Columns>            
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />                
            <asp:BoundField DataField="CorrectID_Errors" HeaderText="CorrectID Errors" SortExpression="CorrectID_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ProperlyIdentified_Errors" HeaderText="ProperlyIdentified Errors" SortExpression="ProperlyIdentified_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="MiniMiranda_Errors" HeaderText="MiniMiranda Errors" SortExpression="MiniMiranda_Errors" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Accuracy_Errors" HeaderText="Accuracy Errors" SortExpression="Accuracy_Errors" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Notepad_Errors" HeaderText="Notepad Errors" SortExpression="Notepad_Errors" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Tone_Errors" HeaderText="Tone Errors" SortExpression="Tone_Errors" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="PCAResponsive_Errors" HeaderText="PCAResponsive Errors" SortExpression="PCAResponsive_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="AWGInfo_Errors" HeaderText="AWG Info Errors" SortExpression="AWGInfo_Errors" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Complaint_Errors" HeaderText="Complaint Errors" SortExpression="Complaint_Errors" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Rehab_Errors" HeaderText="Rehab Errors" SortExpression="Rehab_Errors" HeaderStyle-HorizontalAlign="Center" />           
        </Columns>
    </asp:GridView>
      <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" Text="Export Results to Excel" OnClick="btnExportExcel_Click" />
        </div>            
      </div>
  </div>
</div>


  
</asp:Content>



