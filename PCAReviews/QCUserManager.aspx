<%@ Page Title="QC Tier 1 User Manager" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="QCUserManager.aspx.vb" Inherits="PCAReviews_admin_AddRefund" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
  <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
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
<p></p>
        
    <asp:SqlDataSource ID="dsUsers" runat="server" 
        ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>"
        SelectCommand="p_QCTier1Users" SelectCommandType="StoredProcedure"
        UpdateCommand="p_QCTier1UsersUpdate" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="UserID" Type="String" />
        </UpdateParameters>
        </asp:SqlDataSource>

 <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Reviews QC Tier 1 User Manager</span>
  </div>
   <div class="panel-body">
    
    <table>
        <tr>
            <td>
                <p>This form allows administrators to enable or disable users from receiving new QC Tier 1 assignments</p>
            </td>
        </tr>        
     </table>
    <p />
    <asp:Label ID="lblRowCount" runat="server" CssClass="text-info" />
    <asp:GridView ID="grdUserManager" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="UserID" HorizontalAlign="Center" AllowSorting="True" Width="95%"
        DataSourceID="dsUsers" CssClass="table table-hover table-striped table-bordered table-condensed GridView">        
        <Columns>
            <asp:CommandField ShowEditButton="True" HeaderStyle-Width="50px" />
            <asp:TemplateField HeaderText="Active?" HeaderStyle-Width="50px" SortExpression="Active">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" runat="server" Checked='<%# Bind("Active")%>' />                    
                </ItemTemplate>
            <HeaderStyle Width="75px"></HeaderStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true">
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Grade" HeaderText="Grade" SortExpression="Grade" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true">
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </asp:BoundField>
        </Columns>
    </asp:GridView>

 </div></div>
    <asp:Label ID="lblUserID" runat="server" Visible="false" />
    
</asp:Content>

