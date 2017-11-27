<%@ Page Title="PCA Reviews Incorrect Actions" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Reports_Incorrect_Actions.aspx.vb" Inherits="PCAReviews_Reports_Incorrect_Actions" %>

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
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
        <li><a href="QCCalc.aspx">QC Calculator</a></li>
        <li><a href="QCUserManager.aspx">QC User Manager</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p><br /></p>

<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />

<asp:SqlDataSource ID="dsIncorrectActions" runat="server" SelectCommand="p_IncorrectActions_All_Servicers"
 SelectCommandType="StoredProcedure" FilterExpression="PCAID={0} AND ReviewPeriodMonth LIKE '{1}%' AND ReviewPeriodYear LIKE '{2}%'" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
    <FilterParameters>
        <asp:ControlParameter Name="PCAID" ControlID="ddlPCAID" PropertyName="SelectedValue" />
        <asp:ControlParameter Name="ReviewPeriodMonth" ControlID="ddlReviewPeriodMonth" PropertyName="SelectedValue" />
        <asp:ControlParameter Name="ReviewPeriodYear" ControlID="ddlReviewPeriodYear" PropertyName="SelectedValue" />
    </FilterParameters>     
</asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Review Report - Incorrect Actions</span>
  </div>
  <div class="panel-body">
   
    <label class="form-label">PCA:</label>
    <asp:DropDownList ID="ddlPCAID" runat="server" DataSourceID="dsPCAs" AutoPostBack="true" CssClass="inputBox" TabIndex="1" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="True">
        <asp:ListItem Text="All" Value="" />
    </asp:DropDownList>

     <label class="form-label">Review Period Month:</label>
            <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" AutoPostBack="true" CssClass="inputBox" TabIndex="2">
                <asp:ListItem Text="All" Value="%" />        
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
            <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" AutoPostBack="true" CssClass="inputBox" TabIndex="3">
                 <asp:ListItem Text="All" Value="%" />    
                 <asp:ListItem Text="2015" Value="2015" />
                 <asp:ListItem Text="2016" Value="2016" />
           </asp:DropDownList>
      <br /><br />
    <table class="table-bordered progress-striped " width="95%" cellpadding="4" cellspacing="4">
    <tr>
        <th class="alert-info" colspan="14">Phone Review Rating Data</th>
    </tr>
    <tr>
        <td>
             <asp:GridView ID="GridView1" runat="server" DataSourceID="dsIncorrectActions" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-striped" Font-Size="Small" Font-Names="Calibri">
            <Columns>
                <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Review Period" HeaderText="Review Period" SortExpression="Review Period" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Number of Reviews" HeaderText="Number of Reviews" SortExpression="Number of Reviews" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="CorrectID" HeaderText="Correct ID Used" SortExpression="CorrectID" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Properly Identified Itself" HeaderText="Properly Identified Itself" SortExpression="Properly Identified Itself" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Mini-Miranda Provided" HeaderText="Mini-Miranda Provided" SortExpression="Mini-Miranda Provided" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PCA Used Professional Tone" HeaderText="PCA Used Professional Tone" SortExpression="PCA Used Professional Tone" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Accurate Information Provided" HeaderText="Accurate Information Provided" SortExpression="Accurate Information Provided" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Accurate Notepad" HeaderText="Accurate Notepad" SortExpression="Accurate Notepad" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PCA Was Responsive to the Borrower" HeaderText="PCA Was Responsive to the Borrower" SortExpression="PCA Was Responsive to the Borrower" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PCA Provided Accurate AWG Info" HeaderText="PCA Provided Accurate AWG Info" SortExpression="PCA Provided Accurate AWG Info" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PCA Received a Complaint" HeaderText="PCA Received a Complaint" SortExpression="PCA Received a Complaint" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PCA Disconnected Borrower" HeaderText="PCA Disconnected Borrower" SortExpression="PCA Disconnected Borrower" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="General_Review_Incorrect" HeaderText="Total Incorrect Actions In Group" SortExpression="General_Review_Incorrect" HeaderStyle-HorizontalAlign="Center" />
            </Columns>
            </asp:GridView>
        </td>
    </tr>
    </table>
    <br />
    <table class="table-bordered progress-striped " width="95%" cellpadding="4" cellspacing="4">
    <tr>
      <th class="alert-danger" colspan="13">Rehab Ratings - Collector MUST say these things</th> 
    </tr>
    <tr>
        <td>
            <asp:GridView ID="GridView2" runat="server" DataSourceID="dsIncorrectActions" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-striped" Font-Size="Small" Font-Names="Calibri">
            <Columns>
               
                <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Review Period" HeaderText="Review Period" SortExpression="Review Period" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Number of Reviews" HeaderText="Number of Reviews" SortExpression="Number of Reviews" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="It is a loan rehabilitation program" HeaderText="It is a loan rehabilitation program" SortExpression="It is a loan rehabilitation program" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="The borrower can only rehab once" HeaderText="The borrower can only rehab once" SortExpression="The borrower can only rehab once" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Requires 9 pymts over 10 mos" HeaderText="Requires 9 pymts over 10 mos" SortExpression="Requires 9 pymts over 10 mos" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="After 6th pymt borr may regain Title IV eligibility" HeaderText="After 6th pymt borr may regain Title IV eligibility" SortExpression="After 6th pymt borr may regain Title IV eligibility" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Rehab clears bad credit data" HeaderText="Rehab clears bad credit data" SortExpression="Rehab clears bad credit data" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="TOP stops only after loans are transferred" HeaderText="TOP stops only after loans are transferred" SortExpression="TOP stops only after loans are transferred" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Can prevent AWG but cannot stop current garnishment" HeaderText="Can prevent AWG but cannot stop current garnishment" SortExpression="Can prevent AWG but cannot stop current garnishment" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Must continue making pymts until transferred" HeaderText="Must continue making pymts until transferred" SortExpression="Must continue making pymts until transferred" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="If TOP pymt PIFs acct before rehab is complete credit not cleared" HeaderText="If TOP pymt PIFs acct before rehab is complete credit not cleared" SortExpression="If TOP pymt PIFs acct before rehab is complete credit not cleared" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="At transfer remaining collection charges are waived" HeaderText="At transfer remaining collection charges are waived" SortExpression="At transfer remaining collection charges are waived" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Borrower must supply financial documents" HeaderText="Borrower must supply financial documents" SortExpression="Borrower must supply financial documents" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Borrower must sign rehab agreement letter" HeaderText="Borrower must sign rehab agreement letter" SortExpression="Borrower must sign rehab agreement letter" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Rehab_Ratings_Must_Say_Incorrect" HeaderText="Total Incorrect Actions In Group" SortExpression="Rehab_Ratings_Must_Say_Incorrect" HeaderStyle-HorizontalAlign="Center" />
            </Columns>
            </asp:GridView>
        </td>
    </tr>
   </table>
   <br />
    <table class="table-bordered progress-striped " width="95%" cellpadding="4" cellspacing="4">
    <tr>
      <th class="alert-success" colspan="11">Rehab Ratings - Collector MAY say these things</th> 
    </tr>
    <tr>
        <td>
            <asp:GridView ID="GridView3" runat="server" DataSourceID="dsIncorrectActions" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-striped" Font-Size="Small" Font-Names="Calibri">
            <Columns>  
                <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Review Period" HeaderText="Review Period" SortExpression="Review Period" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Number of Reviews" HeaderText="Number of Reviews" SortExpression="Number of Reviews" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="After transfer eligible for pre-default pymt plans" HeaderText="After transfer eligible for pre-default pymt plans" SortExpression="After transfer eligible for pre-default pymt plans" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="After transfer borr may qualify for deferment or forbearance" HeaderText="After transfer borr may qualify for deferment or forbearance" SortExpression="After transfer borr may qualify for deferment or forbearance" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Must work out new pymt schedule with servicer" HeaderText="Must work out new pymt schedule with servicer" SortExpression="Must work out new pymt schedule with servicer" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Reversed or NSF pymts can jeopardize rehab" HeaderText="Reversed or NSF pymts can jeopardize rehab" SortExpression="Reversed or NSF pymts can jeopardize rehab" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Loans will be transferred 60 days after rehab" HeaderText="Loans will be transferred 60 days after rehab" SortExpression="Loans will be transferred 60 days after rehab" HeaderStyle-HorizontalAlign="Center" />           
                <asp:BoundField DataField="Encourage Electronic Payments" HeaderText="Encourage Electronic Payments" SortExpression="Encourage Electronic Payments" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Rehab_Ratings_May_Say_Incorrect" HeaderText="Total Incorrect Actions In Group" SortExpression="Rehab_Ratings_May_Say_Incorrect" HeaderStyle-HorizontalAlign="Center" />
            </Columns>
            </asp:GridView>
        </td>
    </tr>
   </table>
   <br />
    <table class="table-bordered progress-striped " width="95%" cellpadding="4" cellspacing="4">
    <tr>
      <th class="alert-danger" colspan="12">Rehab Ratings - Collector MUST NOT say these things</th> 
    </tr>
    <tr>
        <td>
            <asp:GridView ID="GridView4" runat="server" DataSourceID="dsIncorrectActions" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-striped" Font-Size="Small" Font-Names="Calibri">
            <Columns>
                <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Review Period" HeaderText="Review Period" SortExpression="Review Period" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Number of Reviews" HeaderText="Number of Reviews" SortExpression="Number of Reviews" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Advise the borr to delay filing tax return" HeaderText="Advise the borr to delay filing tax return" SortExpression="Advise the borr to delay filing tax return" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Will be eligible for TIV" HeaderText="Will be eligible for TIV" SortExpression="Will be eligible for TIV" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Quote an exact amt for the collection costs that will be waived" HeaderText="Quote an exact amt for the collection costs that will be waived" SortExpression="Quote an exact amt for the collection costs that will be waived" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Impose requirements that are not required" HeaderText="Impose requirements that are not required" SortExpression="Impose requirements that are not required" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Talk them out of PIF or SIF" HeaderText="Talk them out of PIF or SIF" SortExpression="Talk them out of PIF or SIF" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Should rehab first then apply for TPD" HeaderText="Should rehab first then apply for TPD" SortExpression="Should rehab first then apply for TPD" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Pymt amounts and dates are final" HeaderText="Pymt amounts and dates are final" SortExpression="Pymt amounts and dates are final" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="State anything that is not factual" HeaderText="State anything that is not factual" SortExpression="State anything that is not factual" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Rehab_Ratings_MustNot_Say_Incorrect" HeaderText="Total Incorrect Actions In Group" SortExpression="Rehab_Ratings_MustNot_Say_Incorrect" HeaderStyle-HorizontalAlign="Center" />
            </Columns>
            </asp:GridView>
        </td>
    </tr>
   </table> 
   <br />
    <table class="table-bordered progress-striped " width="95%" cellpadding="4" cellspacing="4">
    <tr>
      <th class="alert-success" colspan="11">Consolidation Ratings - Collector MAY say these things</th> 
    </tr>
    <tr>
        <td>
            <asp:GridView ID="GridView5" runat="server" DataSourceID="dsIncorrectActions" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-striped" Font-Size="Small" Font-Names="Calibri">
            <Columns>
                <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Review Period" HeaderText="Review Period" SortExpression="Review Period" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Number of Reviews" HeaderText="Number of Reviews" SortExpression="Number of Reviews" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="This is a new loan" HeaderText="This is a new loan" SortExpression="This is a new loan" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Credit reporting" HeaderText="CBR removes the record of default" SortExpression="Credit reporting" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Fixed interest rates" HeaderText="Fixed interest rates" SortExpression="Fixed interest rates" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Capitalization" HeaderText="Capitalization" SortExpression="Capitalization" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Title IV Eligibility" HeaderText="Title IV Eligibility" SortExpression="Title IV Eligibility" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Repayment Options" HeaderText="Repayment Options" SortExpression="Repayment Options" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Default" HeaderText="Default" SortExpression="Default" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Consol_Ratings_Incorrect" HeaderText="Total Incorrect Actions In Group" SortExpression="Consol_Ratings_Incorrect" HeaderStyle-HorizontalAlign="Center" />
            </Columns>
            </asp:GridView>
        </td>
    </tr>
   </table> 
  </div>
</div>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>

