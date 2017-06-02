<%@ Page Title="PCA Complaints Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="PCAComplaint_ReportCompletedPending.aspx.vb" Inherits="Issues_PCAComplaint_ReportCompletedPending" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Operations Issues</h3>

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Enter New Issue <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="PCAComplaint_Add.aspx">PCA Complaint</a></li>       
    </ul>
  </li>  
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Issues <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="MyPCAComplaints.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search Issues <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="PCAComplaintSearch.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
  <li class="dropdown active">
    <a href="#" id="A4" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="PCAComplaint_ReportCompletedPending.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

<!--Datasource for Total Complaints By Loan Analyst-->
<asp:SqlDataSource ID="dsReportCompletedPending" runat="server" SelectCommand="p_PCAComplaint_ReportCompletedPending"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" /> 

<!--Datasource for Total Complaints By PCA-->
<asp:SqlDataSource ID="dsReportCompletedPendingByPCA" runat="server" SelectCommand="p_PCAComplaint_ReportCompletedPendingByPCA"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" /> 


<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Total Complaints By Loan Analyst</span>
  </div>
  <div class="panel-body">
 
 <br />
 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsReportCompletedPending" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped">
       <Columns>
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Pending" HeaderText="Pending" SortExpression="Pending"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Completed" HeaderText="Completed" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="Completed" />    
             <asp:BoundField DataField="TotalComplaints" HeaderText="Total" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="TotalComplaints" />  
        </Columns>
    </asp:GridView>
  </div>
  </div>

  <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Total Complaints By PCA</span>
  </div>
  <div class="panel-body">
 
 <br />
 <asp:GridView ID="GridView2" runat="server" DataSourceID="dsReportCompletedPendingByPCA" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped">
       <Columns>
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Pending" HeaderText="Pending" SortExpression="Pending"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Completed" HeaderText="Completed" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="Completed" />    
             <asp:BoundField DataField="TotalComplaints" HeaderText="Total" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="TotalComplaints" />  
        </Columns>
    </asp:GridView>
  </div>
  </div>
  </asp:Content>