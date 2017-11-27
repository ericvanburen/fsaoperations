<%@ Page Title="PCA Performance Summary" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" EnableEventValidation="false" CodeFile="Reports_PCA_Performance.aspx.vb" Inherits="PCAReviews_Reports_PCA_Performance" %>

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
<br />

    <asp:SqlDataSource ID="dsPCACumulativeActions" runat="server" SelectCommand="p_Report_PCA_Cumulative_Actions"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />

<%--<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Average Performance Summary</span>
  </div>
  <div class="panel-body">
       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-hover table-striped" DataSourceID="dsPCAAverageActions">
        <Columns>          
            <asp:TemplateField HeaderText="PCA" SortExpression="PCA">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("PCAID", "PCAPerformanceDetail.aspx?PCAID={0}")%>'
                        Text='<%# Eval("PCA")%>' />
                </ItemTemplate>
            </asp:TemplateField>         
            
            <asp:BoundField DataField="Total_Reviews" HeaderText="Total Reviews" SortExpression="Total_Reviews" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Avg_Correct_Actions" HeaderText="AVG Correct Actions" SortExpression="Avg_Correct_Actions" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
            <asp:BoundField DataField="Avg_Incorrect_Actions" HeaderText="AVG Incorrect Actions" SortExpression="Avg_Incorrect_Actions" HeaderStyle-HorizontalAlign="Center"  DataFormatString="{0:N0}" />
            <asp:BoundField DataField="Avg_Total_Actions" HeaderText="AVG Total Actions" SortExpression="Avg_Total_Actions" HeaderStyle-HorizontalAlign="Center"  DataFormatString="{0:N0}" />
            <asp:BoundField DataField="Avg_Percent_Actions" HeaderText="AVG % Correct Actions" SortExpression="Avg_Percent_Actions" HeaderStyle-HorizontalAlign="Center"  DataFormatString="{0:N0}" />
        </Columns>
    </asp:GridView>
      <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-md btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" /><br /><br />
  </div>
</div>--%>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Cumulative Performance Summary</span>
  </div>
  <div class="panel-body">
       <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-hover table-striped" DataSourceID="dsPCACumulativeActions">
        <Columns>          
            <asp:TemplateField HeaderText="PCA" SortExpression="PCA">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("PCAID", "PCAPerformanceDetail.aspx?PCAID={0}")%>'
                        Text='<%# Eval("PCA")%>' />
                </ItemTemplate>
            </asp:TemplateField>         
            
            <asp:BoundField DataField="Total_Reviews" HeaderText="Total Reviews" SortExpression="Total_Reviews" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Count_Correct_Actions" HeaderText="Total Correct Actions" SortExpression="Count_Correct_Actions" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Count_Incorrect_Actions" HeaderText="Total Incorrect Actions" SortExpression="Count_Incorrect_Actions" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Count_Total_Actions" HeaderText="Total Actions" SortExpression="Count_Total_Actions" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Avg_Percent_Actions" HeaderText="AVG % Correct Actions" SortExpression="Avg_Percent_Actions" HeaderStyle-HorizontalAlign="Center" />
        </Columns>
    </asp:GridView>
      <asp:Button ID="Button1" runat="server" CssClass="btn btn-md btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" /><br /><br />
  </div>

</div>
</asp:Content>

