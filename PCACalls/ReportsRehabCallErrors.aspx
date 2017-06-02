<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportsRehabCallErrors.aspx.vb" EnableEventValidation="false" Inherits="PCACalls_ReportsRehabCallErrors" %>

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
 <%-- <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Enter New Review <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="NewReview.aspx">PCA Review</a></li>
        <li><a href="NewRehabReview.aspx">Rehab Review</a></li>
    </ul>
  </li>--%>

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">PCA Phone Reviews</a></li>
        <li><a href="MyRehabReviews.aspx">Rehab Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
        <li><a href="SearchRehab.aspx">Rehab Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">PCA Reviews - One PCA</a></li>
        <li><a href="Reports_MultiPCA.aspx">PCA Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsRehab.aspx">Rehab Reviews - One PCA</a></li>
        <li><a href="ReportsRehab_MultiPCA.aspx">Rehab Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="ReportsRehabCallErrors.aspx">Rehab Reviews - LA Errors</a></li>
        <li><a href="MakeAssignments.aspx">Make New Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p> </p>
    <p> </p>

 <asp:SqlDataSource ID="dsRehabCallsLAErrorReport" runat="server" SelectCommand="p_RehabLAErrorReport" SelectCommandType="StoredProcedure" 
        ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">
 </asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Rehab Reviews - Loan Analyst Errors</span>
  </div>
  <div class="panel-body">
      <span> Click a Loan Analyst name to see the list of reviews with errors.</span>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="dsRehabCallsLAErrorReport" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="UserID">
        <Columns>            
            <asp:TemplateField HeaderText="Loan Analyst" SortExpression="UserID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("UserID", "ReportsRehabCallErrors.aspx?UserID={0}")%>'
                        Text='<%# Eval("UserID")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Error Count" HeaderText="Error Count" SortExpression="Error Count" HeaderStyle-HorizontalAlign="Center" />                       
        </Columns>
    </asp:GridView>
      <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" Text="Export Results to Excel" OnClick="btnExportExcel_Click" />
        </div>            
      </div>
  </div>
</div>

<asp:SqlDataSource ID="dsRehabLAErrorReportList" runat="server" SelectCommand="p_RehabLAErrorReportList" SelectCommandType="StoredProcedure" 
        ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="UserID" />
     </SelectParameters>
 </asp:SqlDataSource>
    
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Rehab Reviews With Errors For <asp:Label ID="lblUserIDName" runat="server" /></span>
  </div>
  <div class="panel-body">
      <span> Click a Call ID to see the details for a specific review</span>
      <asp:GridView ID="GridView2" runat="server" DataSourceID="dsRehabLAErrorReportList" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="RehabCallID">
        <Columns>            
            <asp:TemplateField HeaderText="Rehab Call ID" SortExpression="RehabCallID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("RehabCallID", "RehabCallReviewDetail.aspx?RehabCallID={0}")%>'
                        Text='<%# Eval("RehabCallID")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CallDate" HeaderText="Call Date" SortExpression="CallDate" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" DataFormatString="{0:d}" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower Number" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="RehabMetric" HeaderText="Rehab Metric" SortExpression="RehabMetric" HeaderStyle-HorizontalAlign="Center" /> 
        </Columns>
    </asp:GridView>
      <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Button ID="btnExportExcel2" runat="server" CssClass="btn btn-sm btn-danger" Text="Export Results to Excel" OnClick="btnExportExcel2_Click" Visible="false" />
        </div>            
      </div>
  </div>
</div>
</asp:Content>

