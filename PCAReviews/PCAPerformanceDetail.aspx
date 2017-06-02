<%@ Page Title="PCA Performance Detail" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PCAPerformanceDetail.aspx.vb" Inherits="PCAReviews_PCAPerformanceDetail" %>

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
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown  active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">Save New PCA Review</a></li>
        <li><a href="Reports_SavedReports.aspx">Search PCA Reviews</a></li>       
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

    <asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" /> 

 <asp:SqlDataSource ID="dsPCAPerformanceDetail" runat="server" SelectCommand="p_Report_PCA_Performance_Detail"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="PCAID" />
     </SelectParameters>
</asp:SqlDataSource>

    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Performance Detail</span>
  </div>
  <div class="panel-body">
            
      <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-hover table-striped" DataSourceID="dsPCAPerformanceDetail" DataKeyNames="ReviewID">
        <Columns>          
            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ReviewID", "ReviewDetail.aspx?ReviewID={0}")%>'
                        Text='<%# Eval("ReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>         
            
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" SortExpression="DateSubmitted" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReviewAgency" HeaderText="Review Agency" SortExpression="ReviewAgency" HeaderStyle-HorizontalAlign="Center" />            
            <asp:BoundField DataField="ReviewPeriod" HeaderText="Review Period" SortExpression="ReviewPeriod" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Correct_Actions" HeaderText="Correct Actions" SortExpression="Correct_Actions" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="Incorrect_Actions" HeaderText="Incorrect Actions" SortExpression="Incorrect_Actions" HeaderStyle-HorizontalAlign="Center" />            
            <asp:BoundField DataField="Total_Actions" HeaderText="Total Actions" SortExpression="Total_Actions" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Percent_Actions" HeaderText="% Correct" SortExpression="Percent_Actions" HeaderStyle-HorizontalAlign="Center" />       

        </Columns>
    </asp:GridView>
  </div>
  </div>
</asp:Content>

