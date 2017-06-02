<%@ Page Title="Rehab Reviews - Reports For Multiple PCAs" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ReportsRehab_MultiPCA.aspx.vb" Inherits="PCACalls_ReportsRehab_MultiPCA" EnableEventValidation="false" %>

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
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->

<p> </p>

<table class="table" style="background-color:#eeeeee;">
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
            <td colspan="3" align="center"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" />
            <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" /></td>
        </tr>
</table>
<br />

<asp:SqlDataSource ID="dsReviews" runat="server" SelectCommand="p_RehabReportSummary_MultiPCA"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
        <asp:Parameter Name="ReportQuarter" />
        <asp:Parameter Name="ReportYear" />
    </SelectParameters>
</asp:SqlDataSource>

<div class="alert-info">
    Important! You must export the record(s) in the search results to Excel to see of the fields
</div>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataSourceID="dsReviews" 
AllowSorting="true">
<RowStyle Font-Size="X-Small" />
<HeaderStyle Font-Size="Small" BackColor="#EEEEEE" Font-Names="Calibri" />
        <Columns> 
            <asp:BoundField DataField="PCA" HeaderText="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Quarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Year" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Total_AnyErrors" HeaderText="Accounts With One Error or More" HeaderStyle-HorizontalAlign="Center"  />
            <asp:BoundField DataField="Score_Rehab_Program_Errors" HeaderText="It is a loan rehabilitation program" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />          
            <asp:BoundField DataField="Score_Rehab_Once_Errors" HeaderText="The borrower can only rehab once" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />  
            <asp:BoundField DataField="Score_Nine_Payments_Errors" HeaderText="Requires 9 pymts over 10 mos" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="Score_Loans_Transferred_After_60_Days_Errors" HeaderText="Loan transferred to servicer 60 days after rehab" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="Score_Reversed_Payments_Errors" HeaderText="Reversed or NSF pymts can jeopardize rehab" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="Score_TOP_Errors" HeaderText="TOP stops only after loans are transferred" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="Score_AWG_Errors" HeaderText="Can prevent AWG but cannot stop current garnishment" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="Score_Continue_Payments_Errors" HeaderText="Must continue making pymts until transferred" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />
            <asp:BoundField DataField="Score_New_Payment_Schedule_Errors" HeaderText="Must work out new pymt schedule with servicer" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />  
            <asp:BoundField DataField="Score_TPD_Errors" HeaderText="If borr indicates disability, help with TPD" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Eligible_Payment_Plans_Errors" HeaderText="After transfer, eligible for pre-default pymt plans" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Deferment_Forb_Errors" HeaderText="After transfer, borr may not qualify for deferment or forbearance" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_TitleIV_Errors" HeaderText="After 6th pymt borr may regain TIV eligbility" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_TOP_Payment_PIFs_Account_Errors" HeaderText="TOP Payment PIFs Account" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />
            <asp:BoundField DataField="Score_Delay_Tax_Reform_Errors" HeaderText="Advise the borr to delay filing tax return" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />  
            <asp:BoundField DataField="Score_More_Aid_Errors" HeaderText="Tell the borr that he/she will be eligible for TIV" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Collection_Costs_Waived_Errors" HeaderText="At transfer remaining collection charges are waived" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_False_Requirements_Errors" HeaderText="Impose requirements that are not required" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Not_Factual_Errors" HeaderText="State anything that is not factual" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Unaffordable_Payments_Errors" HeaderText="Payment Amount Too High/Low" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Avoid_PIF_Errors" HeaderText="Talk them out of PIF or SIF" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />
            <asp:BoundField DataField="Score_Rehab_Then_TPD_Errors" HeaderText="Tell a disabled borr that he/she should rehab first" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />  
            <asp:BoundField DataField="Score_Ineligible_Borrower_Errors" HeaderText="Discuss rehab with a debtor who is not eligible" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Payments_Are_Final_Errors" HeaderText="Tell the borr that pymt amounts are final" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Credit_All_Negative_Data_Removed" HeaderText="All negative information will be removed from credit report" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  /> 
            <asp:BoundField DataField="Score_Credit_Never_Defaulted" HeaderText="Credit report will look like you never defaulted" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />
            <asp:BoundField DataField="Score_Credit_Score_Will_Improve" HeaderText="Credit score will improve" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"  />
        </Columns>        
</asp:GridView>
</asp:Content>

