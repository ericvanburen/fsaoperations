<%@ Page Title="PCA Reviews - My Reviews" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyReviews.aspx.vb" Inherits="PCAReviews_MyReviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown active">
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

  <li class="dropdown">
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
<br />

 <asp:SqlDataSource ID="dsMyReviews" runat="server" SelectCommand="p_MyReviews"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="UserID" Type="String" />
    </SelectParameters>
 </asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">My PCA Reviews</span>
  </div>
  <div class="panel-body">

 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMyReviews" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ReviewID">
        <Columns>            
            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ReviewID", "ReviewDetail.aspx?ReviewID={0}")%>'
                        Text='<%# Eval("ReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ReviewPeriod" HeaderText="Review Period" SortExpression="ReviewPeriod" HeaderStyle-HorizontalAlign="Center" />           
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="BorrowerLastName" HeaderText="Borrower Last Name" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="BorrowerLastName" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />                    
        </Columns>
    </asp:GridView>
      
 </div>
 </div>    
</asp:Content>

