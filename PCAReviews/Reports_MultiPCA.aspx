<%@ Page Title="PCA Reviews - Reports for Multiple PCAs" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Reports_MultiPCA.aspx.vb" Inherits="PCACalls_Reports_MultiPCA" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
 <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tab.js" type="text/javascript"></script>
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

<p> </p>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Review Report - Multiple PCAs</span>
  </div>
  <div class="panel-body">
   <table class="table">
        <tr>
            <td valign="top">
            <!--PCA--> 
            <label class="form-label">PCA:</label>       
             <asp:ListBox ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="1" SelectionMode="Multiple">
                 <asp:ListItem Text="" Value="" />
                 <asp:ListItem Value="1" Text="Account Control Technology"></asp:ListItem>
                 <asp:ListItem Value="2" Text="Allied Interstate"></asp:ListItem>
                 <asp:ListItem Value="3" Text="CBE Group"></asp:ListItem>
                 <asp:ListItem Value="4" Text="Coast Professional"></asp:ListItem>
                 <asp:ListItem Value="5" Text="Collection Technology"></asp:ListItem>
                 <asp:ListItem Value="6" Text="ConServe"></asp:ListItem>
                 <asp:ListItem Value="7" Text="Delta Management Associates"></asp:ListItem>
                 <asp:ListItem Value="8" Text="Diversified Collection Systems"></asp:ListItem>
                 <asp:ListItem Value="9" Text="Enterprise Recovery Systems"></asp:ListItem>
                 <asp:ListItem Value="10" Text="EOS-Collecto"></asp:ListItem>
                 <asp:ListItem Value="11" Text="FAMS"></asp:ListItem>
                 <asp:ListItem Value="12" Text="FMS"></asp:ListItem>
                 <asp:ListItem Value="13" Text="GC Services"></asp:ListItem>
                 <asp:ListItem Value="14" Text="Immediate Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="15" Text="National Recoveries"></asp:ListItem>
                 <asp:ListItem Value="16" Text="NCO Financial Systems"></asp:ListItem>
                 <asp:ListItem Value="17" Text="Pioneer Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="18" Text="Premiere Credit of North America"></asp:ListItem>
                 <asp:ListItem Value="19" Text="Progressive Financial Services"></asp:ListItem>
                 <asp:ListItem Value="20" Text="Van Ru Credit Corp"></asp:ListItem>
                 <asp:ListItem Value="21" Text="West Asset Management"></asp:ListItem>
                 <asp:ListItem Value="22" Text="Windham Professionals"></asp:ListItem>
             </asp:ListBox><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPCAID" ErrorMessage="* Select a PCA *" CssClass="alert-danger" Display="Dynamic" />
            </td>
            <td valign="top">
            <!--Report Quarter-->
            <label class="form-label">Report Quarter:</label>            
            <asp:ListBox ID="ddlReportQuarter" runat="server" CssClass="inputBox" SelectionMode="Multiple">            
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />                   
            </asp:ListBox>        
            </td>
             <td valign="top">
            <!--Report Year-->
            <label class="form-label">Report Year:</label>
            <asp:ListBox ID="ddlReportYear" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="2013" Value="2013" />
                    <asp:ListItem Text="2014" Value="2014" />
                    <asp:ListItem Text="2015" Value="2015" />
                    <asp:ListItem Text="2016" Value="2016" />
            </asp:ListBox>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" /></td>
        </tr>
</table>
</div>
</div>
<br />

<asp:SqlDataSource ID="dsReviews" runat="server" SelectCommand="p_ReportSummary_MultiPCA"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
        <asp:Parameter Name="ReportQuarter" />
        <asp:Parameter Name="ReportYear" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataSourceID="dsReviews" 
AllowSorting="true">
<RowStyle Font-Size="X-Small" />
<HeaderStyle Font-Size="Small" BackColor="#EEEEEE" Font-Names="Calibri" />
        <Columns>                 
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Qtr" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Yr" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Total_AnyErrors" HeaderText="Accounts With One Error or More" SortExpression="Total_AnyErrors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_CorrectID_Errors" HeaderText="Improper or Incorrect Identification" SortExpression="Score_CorrectID_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_MiniMiranda_Errors" HeaderText="Mini-Miranda Not Provided" SortExpression="Score_MiniMiranda_Errors" HeaderStyle-HorizontalAlign="Center" />
		    <asp:BoundField DataField="Score_Accuracy_Errors" HeaderText="Accurate Information Not Provided" SortExpression="Score_Accuracy_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_Notepad_Errors" HeaderText="Incomplete or Inaccurate Notepad" SortExpression="Score_Notepad_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_PCAResponsive_Errors" HeaderText="PCA Was Not Responsive to the Borrower" SortExpression="Score_PCAResponsive_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Complaint_Errors" HeaderText="PCA Received a Complaint" SortExpression="Complaint_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="IMF_Timely_Errors" HeaderText="Complaint Not Submitted to FSA" SortExpression="IMF_Timely_Errors" HeaderStyle-HorizontalAlign="Center" />            
		</Columns>        
</asp:GridView>
<div class="row">       
        <div class="col-md-12" align="center"><br />
        <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-md btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
</div>            
</div>
</asp:Content>

