<%@ Page Title="PCA Rehab Reviews - Report Summary" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ReportsRehab.aspx.vb" Inherits="PCACalls_ReportsRehab" %>

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

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Rehab Reviews Report</span>
  </div>
  <div class="panel-body">
  <table class="table">
        <tr>
            <td valign="top">
            <!--PCA--> 
            <label class="form-label">PCA:</label>       
             <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="1" AutoPostBack="true">
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
             </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPCAID" ErrorMessage="* Select a PCA *" CssClass="alert-danger" Display="Dynamic" />
            </td>
             <td valign="top">
            <!--Report Quarter-->
            <label class="form-label">Report Quarter:</label>            
            <asp:DropDownList ID="ddlReportQuarter" runat="server" CssClass="inputBox">            
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />                   
            </asp:DropDownList>        
            </td>
             <td valign="top">
            <!--Report Year-->
            <label class="form-label">Report Year:</label>
            <asp:DropDownList ID="ddlReportYear" runat="server" CssClass="inputBox">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="2013" Value="2013" />
                    <asp:ListItem Text="2014" Value="2014" />
                    <asp:ListItem Text="2015" Value="2015" />
                    <asp:ListItem Text="2016" Value="2016" />
            </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="center"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" />
            <asp:Button ID="btnSaveRehabReview" runat="server" Text="Save Report" CssClass="btn btn-md btn-danger" OnClick="btnSaveRehabReview_Click" Visible="false" /><br />
            <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
            </td>
        </tr>
</table>
</div>
</div>
<span class="h4">Population Size: <asp:Label ID="lblPopulationSize" runat="server" /></span>

<table class="table-bordered" width="95%">
<thead>
    <tr>
        <th>Metric</th>
        <th class="text-right">Total</th>
        <th class="text-right">% of Total</th>
    </tr>
</thead>
<tr>
    <td>Accounts With One Error or More</td>
    <td class="text-right"><asp:Label ID="lblTotal_AnyErrors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblTotal_AnyErrors_Percent" runat="server" /></td> 
</tr>

<tr>
    <td>It is a loan rehabilitation program</td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Program" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Program_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>The borrower can only rehab once</td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Once" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Once_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Requires 9 pymts over 10 mos, except Perkins (9 consec pymts)</td>
    <td class="text-right"><asp:Label ID="lblScore_Nine_Payments" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Nine_Payments_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Loan(s) will be transferred to servicer approx 60 days after rehab</td>
    <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Reversed or NSF pymts can jeopardize rehab</td>
    <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>TOP stops only after loans are transferred</td>
    <td class="text-right"><asp:Label ID="lblScore_TOP" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_TOP_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Can prevent AWG but cannot stop current garnishment</td>
    <td class="text-right"><asp:Label ID="lblScore_AWG" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_AWG_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Must continue making pymts until transferred</td>
    <td class="text-right"><asp:Label ID="lblScore_Continue_Payments" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Continue_Payments_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Must work out new pymt schedule with servicer</td>
    <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>If borr indicates disability, help with TPD</td>
    <td class="text-right"><asp:Label ID="lblScore_TPD" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_TPD_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>After transfer, eligible for pre-default pymt plans</td>
    <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>After transfer, borr may (not "will") qualify for deferment or forbearance</td>
    <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>After 6th pymt borr may regain TIV eligibility , If there are no other blocks</td>
    <td class="text-right"><asp:Label ID="lblScore_TitleIV" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_TitleIV_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>At transfer remaining collection charges are waived</td>
    <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>If TOP pymt PIFs acct before rehab is complete, credit not cleared</td>
    <td class="text-right"><asp:Label ID="lblScore_TOP_Payment_PIFs_Account" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_TOP_Payment_PIFs_Account_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Advise the borr to delay filing tax return</td>
    <td class="text-right"><asp:Label ID="lblScore_Delay_Tax_Reform" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Delay_Tax_Reform_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Tell the borr that he/she will be eligible for TIV, defers, forbs</td>
    <td class="text-right"><asp:Label ID="lblScore_More_Aid" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_More_Aid_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Quote an exact amt for the collection costs that will be waived</td>
    <td class="text-right"><asp:Label ID="lblScore_Collection_Costs_Waived" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Collection_Costs_Waived_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Impose requirements that are not required</td>
    <td class="text-right"><asp:Label ID="lblScore_False_Requirements" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_False_Requirements_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>State anything that is not factual, including attributing to ED things that are not ED policy</td>
    <td class="text-right"><asp:Label ID="lblScore_Not_Factual" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Not_Factual_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Set the borr up on a pymt lower than the amt he/she says he/she can afford</td>
    <td class="text-right"><asp:Label ID="lblScore_Unaffordable_Payments" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Unaffordable_Payments_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Talk them out of PIF or SIF if they are able and willing.  (Can see the credit benefit of rehab.)</td>
    <td class="text-right"><asp:Label ID="lblScore_Avoid_PIF" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Avoid_PIF_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Tell a disabled borr that he/she should rehab first, then apply for TPD.</td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Then_TPD" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Then_TPD_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Discuss rehab with a debtor who is not eligible for rehab.</td>
    <td class="text-right"><asp:Label ID="lblScore_Ineligible_Borrower" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Ineligible_Borrower_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Tell the borr that pymt amounts and dates are final and cannot be changed</td>
    <td class="text-right"><asp:Label ID="lblScore_Payments_Are_Final" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Payments_Are_Final_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>All negative information will be removed from credit report</td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_All_Negative_Data_Removed" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_All_Negative_Data_Removed_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Credit report will look like you never defaulted</td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_Never_Defaulted" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_Never_Defaulted_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Credit score will improve</td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_Score_Will_Improve" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_Score_Will_Improve_Percent" runat="server" /></td>    
</tr>

</table>
<br />
<asp:SqlDataSource ID="dsPreviousRehabReviews" runat="server" SelectCommand="p_SavedRehabReviews"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>" DeleteCommand="DELETE FROM RehabReviews WHERE RehabReviewID=@RehabReviewID">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
    </SelectParameters>
    <DeleteParameters>
       <asp:Parameter Name="RehabReviewID" />
   </DeleteParameters>
</asp:SqlDataSource>

<asp:Button ID="btnExportExcel" runat="server" Text="Export Records to Excel" CssClass="btn btn-md btn-danger" OnClick="btnExcelExport_Click" Visible="false" />

<h3>Saved Reports</h3>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" 
DataKeyNames="RehabReviewID" DataSourceID="dsPreviousRehabReviews" OnRowDataBound="GridView1_OnRowDataBound">
<EmptyDataTemplate>
    No Saved Rehab Reviews For This PCA
</EmptyDataTemplate>
<RowStyle Font-Size="X-Small" />
<HeaderStyle Font-Size="Small" BackColor="#EEEEEE" Font-Names="Calibri" />
        <Columns>          
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="cbRows" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Report">   
                <ItemTemplate>
                    <asp:HyperLink id="hypViewAttachment" runat="server" NavigateUrl='<%# String.Format("ReviewAttachments/{0}", Eval("Attachment")) %>' Text='View' Target="_blank" /><br />
                    <asp:HyperLink ID="hypUploadAttachment" runat="server" NavigateUrl='<%# Eval("RehabReviewID", "RehabAttachmentManager.aspx?RehabReviewID={0}&Action=Upload") %>' Text='Upload' Target="_blank" /><br />
                    <asp:HyperLink ID="hypDeleteAttachment" runat="server" NavigateUrl='<%# Eval("RehabReviewID", "RehabAttachmentManager.aspx?RehabReviewID={0}&Action=Delete") %>' Text='Delete' Target="_blank" />               
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="DateEntered" HeaderText="Review Date" SortExpression="DateEntered" DataFormatString="{0:d}" HtmlEncode="false" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Report Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Report Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Total_AnyErrors" HeaderText="Accounts With One Error or More" SortExpression="Total_AnyErrors" HeaderStyle-HorizontalAlign="Center" />                    
		</Columns>        
</asp:GridView>
    <br />

    <asp:Button ID="btnDeleteSavedReport" OnClick="btnDeleteSavedReport_Click" runat="server" Text="Delete Checked Saved Reports" 
    CssClass="btn btn-sm btn-danger" OnClientClick="if ( !confirm('Are you sure you want to delete this saved report?')) return false" CausesValidation="false" />

</asp:Content>

