<%@ Page Title="Report Completion Count" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportCompletionCount.aspx.vb" Inherits="PCAReviews_ReportCount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" media="print" href="print.css" />
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


<!--Navigation Menu-->
<div class="hidden-print">
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

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">Save New PCA Review Old</a></li>
        <li><a href="Reports2.aspx">Save New PCA Review</a></li>
        <li><a href="Reports_SavedReports.aspx">Search PCA Reviews</a></li>       
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="ReportCompletionCount.aspx">Review Completion Count</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
        <li><a href="QCCalc.aspx">QC Calculator</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p><br /></p>
<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>

<asp:SqlDataSource ID="dsReviewCompletionCount" runat="server" SelectCommand="p_ReportReviewCompletionCount" 
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="ReviewPeriodMonth" />
        <asp:Parameter Name="ReviewPeriodYear" />
    </SelectParameters>  
 </asp:SqlDataSource>

    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Review Completion Count</span>
  </div>
  <div class="panel-body">
  <label class="form-label">Review Period Month:</label>
            <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlReviewPeriodMonth_SelectedIndexChanged" CssClass="inputBox" TabIndex="2">
                <asp:ListItem Text="01" Value="01" />
                <asp:ListItem Text="02" Value="02" />
                <asp:ListItem Text="03" Value="03" />
                <asp:ListItem Text="04" Value="04" />
                <asp:ListItem Text="05" Value="05" />
                <asp:ListItem Text="06" Value="06" />
                <asp:ListItem Text="07" Value="07" />
                <asp:ListItem Text="08" Value="08" />
                <asp:ListItem Text="09" Value="09" />
                <asp:ListItem Text="10" Value="10" />
                <asp:ListItem Text="11" Value="11" />
                <asp:ListItem Text="12" Value="12" />
            </asp:DropDownList>
             <label class="form-label">Review Period Year:</label>
            <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlReviewPeriodMonth_SelectedIndexChanged" CssClass="inputBox" TabIndex="3"> 
                 <asp:ListItem Text="2017" Value="2017" />
                 <asp:ListItem Text="2016" Value="2016" />
           </asp:DropDownList>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="dsReviewCompletionCount" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped">
        <EmptyDataTemplate><strong>There are no review completions for the dates selected</strong></EmptyDataTemplate>
        <Columns>            
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReviewCompletions" HeaderText="Completions" SortExpression="ReviewCompletions" HeaderStyle-HorizontalAlign="Center" />           
        </Columns>
    </asp:GridView>
  </div>
</div>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>

