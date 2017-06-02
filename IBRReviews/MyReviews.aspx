<%@ Page Title="My IBR Reviews" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyReviews.aspx.vb" Inherits="IBRReviews_MyReviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>  
    <script src="../Scripts/jquery.checkAvailabilityIBR.js" type="text/javascript"></script>  
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
 <li class="dropdown active">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">My IBR Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="EnterNewReview.aspx">Enter New Review</a></li>
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyAssignments.aspx">My Assignments</a></li>       
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">Search Reviews</a></li>      
    </ul>
  </li> 

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="ErrorReport.aspx">Error Report</a></li> 
        <li><a href="MakeAssignments.aspx">Make Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>     
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />
<asp:SqlDataSource ID="dsMyReviews" runat="server" SelectCommand="p_MyReviews" OnSelected="OnSelectedHandler"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>">
    <SelectParameters>        
        <asp:Parameter Name="UserID" Type="String" />
        <asp:Parameter Name="PCAID" Type="String" />
    </SelectParameters>
 </asp:SqlDataSource>

<asp:SqlDataSource ID="dsMyReviewsFiltered" runat="server" SelectCommand="p_MyReviewsFiltered" OnSelected="OnSelectedHandler"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>">
    <SelectParameters>        
        <asp:Parameter Name="NewAssignmentID" />
    </SelectParameters>
 </asp:SqlDataSource>

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
    SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>" />

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">My IBR Reviews</span>
  </div>
  <div class="panel-body">
<b>Select a PCA</b> <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" 
     AutoPostBack="true" OnSelectedIndexChanged="ddlPCAID_SelectedIndexChanged">
     <asp:ListItem Text="All" Value="All" Selected="True" />
    </asp:DropDownList>
      <br /><br />
<asp:Label ID="lblReviewCount" runat="server" CssClass="text-info" />
 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMyReviews" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="IBRReviewID">
        <Columns>            
            <asp:TemplateField HeaderText="IBR Review ID" SortExpression="IBRReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("IBRReviewID", "IBRReviewDetail.aspx?IBRReviewID={0}")%>'
                        Text='<%# Eval("IBRReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>            
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" SortExpression="DateSubmitted" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Agreement_Letter_Signed" HeaderText="Agreement Letter Signed?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="Agreement_Letter_Signed_Date" HeaderText="Date Agreement Letter Was Signed" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Financial_Documentation" HeaderText="Appropriate Financial Documentation?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Dependents" HeaderText="Number of Dependents" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Income" HeaderText="Borrower Income" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Repayment_Amount" HeaderText="Repayment Amount Correct?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Tag" HeaderText="Tag?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Comments" HeaderText="FSA Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="PCA_Comments" HeaderText="PCA Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="FSA_Conclusions" HeaderText="FSA Conclusions" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />            
        </Columns>
    </asp:GridView>
 <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" Text="Export Results to Excel" OnClick="btnExportExcel_Click" />    
 </div>
 </div>    
</asp:Content>

