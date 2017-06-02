<%@ Page Title="PCA Call Monitoring - Rehab Review Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SearchRehab.aspx.vb" Inherits="PCACalls_SearchRehab" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />    
   
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

  <li class="dropdown active">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
        <li><a href="SearchRehab.aspx">Rehab Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
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
<p></p>
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Search Rehab Reviews</span>
  </div>
  <div class="panel-body">
  <table class="table">
        <tr>
            <td valign="top"><!--Call ID--><label class="form-label">Call ID:</label><asp:TextBox ID="txtRehabCallID" runat="server" TabIndex="1" /></td>
            <td valign="top">
                 <label class="form-label">Call Date:</label>
                 <asp:TextBox ID="txtCallDate" runat="server" CssClass="datepicker" />
            </td>
            <td valign="top">
            <!--Call Date Greater Than-->
            <label class="form-label">Call Date Range:</label>from<br />
            <asp:TextBox ID="txtCallDateGreaterThan" runat="server" CssClass="datepicker" />            
                <br />
             to<br />
            <asp:TextBox ID="txtCallDateLessThan" runat="server" CssClass="datepicker" /></td>
        </tr>

        <tr>           
            <td valign="top">
            <!--PCA--> 
            <label class="form-label">PCA:</label>       
             <asp:ListBox ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="4" SelectionMode="Multiple">
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
             </asp:ListBox>
             </td>
            <td valign="top"><!--BorrowerNumber-->
            <label class="form-label">Borrower Number:</label>           
                <asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" TabIndex="5" /></td>            
            <td valign="top">
                <!--Reviewer-->        
            <label class="form-label">Reviewer:</label>          
               <asp:ListBox ID="ddlUserID" runat="server" CssClass="inputBox" TabIndex="6" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />               
               </asp:ListBox>                   
            </td>            
        </tr>
        <tr>
            <td valign="top"><!--Report Quarter-->    
           <label class="form-label">Report Quarter:</label> 
           <asp:ListBox ID="ddlReportQuarter" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />                   
            </asp:ListBox>
            </td>
            <td valign="top" colspan="2">
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
            <td colspan="3" align="center"><br />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" />
            <asp:Button ID="btnSearchAgain" runat="server" CssClass="btn btn-md btn-warning" Text="Search Again" Visible="true" OnClick="btnSearchAgain_Click" />            
            </td>
        </tr>
    </table>
  </div>
  </div>

       <!--Row Count Label and Export To Excel-->
 <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Label ID="lblRowCount" runat="server" CssClass="bold" /> <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
        </div>            
</div>
<br />
    <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="RehabCallID">
        <Columns>          
            <asp:TemplateField HeaderText="Rehab Call ID" SortExpression="RehabCallID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("RehabCallID", "RehabCallReviewDetail.aspx?RehabCallID={0}") %>'
                        Text='<%# Eval("RehabCallID") %>' />
                </ItemTemplate>
            </asp:TemplateField>

             <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" SortExpression="DateSubmitted" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />
            
            <asp:BoundField DataField="CallDate" HeaderText="Call Date" SortExpression="CallDate" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ReportQuarter" HeaderText="Report Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ReportYear" HeaderText="Report Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />
            
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />   

            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />
                
             <asp:BoundField DataField="RecordingDeliveryDate" HeaderText="Recording Delivery Date" SortExpression="RecordingDeliveryDate" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />      
                       
            <asp:BoundField DataField="Score_Rehab_Program" HeaderText="It is a loan rehabilitation program" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Rehab_Once" HeaderText="The borrower can only rehab once" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Nine_Payments" HeaderText="Requires 9 pymts over 10 mos, except Perkins (9 consec pymts)" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Loans_Transferred_After_60_Days" HeaderText="Loan(s) will be transferred to servicer approx 60 days after rehab" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Reversed_Payments" HeaderText="Reversed or NSF pymts can jeopardize rehab" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_TOP" HeaderText="TOP stops only after loans are transferred" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_AWG" HeaderText="Can prevent AWG but cannot stop current garnishment" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Continue_Payments" HeaderText="Must continue making pymts until transferred" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_New_Payment_Schedule" HeaderText="Must work out new pymt schedule with servicer" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_TPD" HeaderText="If borr indicates disability, help with TPD" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Eligible_Payment_Plans" HeaderText="After transfer, eligible for pre-default pymt plans" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Deferment_Forb" HeaderText="After transfer, borr may qualify for deferment or forbearance" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_TitleIV" HeaderText="After 6th pymt borr may regain TIV eligbility" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Collection_Charges_Waived" HeaderText=">At transfer remaining collection charges are waived" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_TOP_Payment_PIFs_Account" HeaderText="If TOP pymt PIFs acct before rehab is complete, credit not cleared" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Delay_Tax_Reform" HeaderText="Advise the borr to delay filing tax return" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_More_Aid" HeaderText="Tell the borr that he/she will be eligible for TIV, defers, forbs" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Collection_Costs_Waived" HeaderText="Quote an exact amt for the collection costs that will be waived" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_False_Requirements" HeaderText="Impose requirements that are not required" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Not_Factual" HeaderText="State anything that is not factual" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Unaffordable_Payments" HeaderText="Unafforable payment plan" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Avoid_PIF" HeaderText="Talk them out of PIF or SIF" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Rehab_Then_TPD" HeaderText="Tell a disabled borr that to rehab first then apply for TPD" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Ineligible_Borrower" HeaderText="Discuss rehab with ineligible borr" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Payments_Are_Final" HeaderText="State pymt amounts and dates are final" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Credit_All_Negative_Data_Removed" HeaderText="All negative information will be removed from your credit report" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Credit_Never_Defaulted" HeaderText="Credit report will look like you never defaulted" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Credit_Score_Will_Improve" HeaderText="Credit score will improve" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="FSA_Comments" HeaderText="FSA Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="PCA_Comments" HeaderText="PCA Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="FSA_Conclusions" HeaderText="FSA Conclusions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="FSASupervisor_Comments" HeaderText="FSA Supervisor Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />        
        
            
            
        </Columns>
    </asp:GridView>

</asp:Content>

