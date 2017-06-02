<%@ Page Title="PCA Review Monitoring - Review Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.vb" Inherits="PCAReviews_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script> 
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />    
   
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker()

            //Intializes the tooltips  
            $('[data-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                'placement': 'top'
            });
            $('[data-toggle="popover"]').popover({
                trigger: 'hover',
                'placement': 'top'
            });
        });
      </script>

   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <!--Navigation Menu-->
    <div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
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
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p></p><br />
 <asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Search PCA Reviews</span>
  </div>
  <div class="panel-body">
  <table class="table">
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Review ID" data-content="The unique review ID # of the review">Review ID</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA" data-content="The name of the PCA the review came from">PCA</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Reviewer/Loan Analyst" data-content="The name of the Loan Analyst which reviewed the call">Reviewer/Loan Analyst</a></th>
          <th class="tableColumnHead">Review Period</th>
      </tr>        
      <tr>
            <td class="tableColumnCell"><asp:TextBox ID="txtReviewID" runat="server" TabIndex="1" /></td>                             
            <td class="tableColumnCell"> 
                 <asp:ListBox ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" SelectionMode="Multiple" AppendDataBoundItems="true">
                    <asp:ListItem Text="" Value="" />
                 </asp:ListBox>
               </td>
            <td class="tableColumnCell">          
               <asp:ListBox ID="ddlUserID" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />                
               </asp:ListBox></td> 
            <td class="tableColumnCell">
                Month: <asp:ListBox SelectionMode="Multiple" ID="ddlReviewPeriodMonth" runat="server" TabIndex="4" CssClass="inputBox">
                            <asp:ListItem Text="" Value="" />        
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
                       </asp:ListBox>
                Year: <asp:ListBox SelectionMode="Multiple" ID="ddlReviewPeriodYear" runat="server" TabIndex="5" CssClass="inputBox">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2015" Value="2015" />
                        <asp:ListItem Text="2016" Value="2016" />
                        <asp:ListItem Text="2017" Value="2017" />
                       </asp:ListBox>

            </td>           
        </tr>
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Borrower Last Name" data-content="The last name of the borrower">Borrower Last Name</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The DMCS borrower number">Borrower Number</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Call Date" data-content="The date the call was recorded">Call Date</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Call Date Range (Beginning and End Dates)" data-content="The date range the calls were recorded">Call Date Range</a></th>
      </tr>  
        <tr>
            <td class="tableColumnCell"><asp:TextBox ID="txtBorrowerLastName" runat="server" TabIndex="3" CssClass="inputBox" /></td>
            <td class="tableColumnCell"><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" TabIndex="4" /></td>
            <td class="tableColumnCell">          
                <asp:TextBox ID="txtCallDate" runat="server" CssClass="datepicker" /></td>
            <td class="tableColumnCell"> 
                 from<br /><asp:TextBox ID="txtCallDateGreaterThan" runat="server" CssClass="datepicker" /><br />
             to<br /><asp:TextBox ID="txtCallDateLessThan" runat="server" CssClass="datepicker" />
               </td>
        </tr> 
        <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Submitted" data-content="The date the call was submitted by the Loan Analyst">Date Submitted</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Submitted Range" data-content="The date the call was submitted by the Loan Analyst (Beginning and End Dates)">Date Submitted Range</a></th>
          <th class="tableColumnHead">Reviewing Agency</th>
          <th class="tableColumnHead">&nbsp;</th>
        </tr>

       <tr>
            <td class="tableColumnCell">
                <asp:TextBox ID="txtDateSubmitted" runat="server" CssClass="datepicker" />
            </td>
            <td class="tableColumnCell">         
                 from<br /><asp:TextBox ID="txtDateSubmittedGreaterThan" runat="server" CssClass="datepicker" />            
                <br />to<br /><asp:TextBox ID="txtDateSubmittedLessThan" runat="server" CssClass="datepicker" />
            </td> 
            <td class="tableColumnCell">
                <asp:ListBox ID="ddlReviewAgency" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" />                            
                    <asp:ListItem Text="FSA" Value="FSA" />
                    <asp:ListItem Text="FedLoans" Value="FedLoans" />
                </asp:ListBox></td>
            <td class="tableColumnCell">&nbsp;</td>    
        </tr>
        <tr>
            <td colspan="4" align="center"><br />
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
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ReviewID">
        <Columns>          
            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ReviewID", "ReviewDetail.aspx?ReviewID={0}")%>'
                        Text='<%# Eval("ReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>            
            
            <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" SortExpression="DateSubmitted" 
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ReviewAgency" HeaderText="Agency" SortExpression="ReviewAgency" 
                HeaderStyle-HorizontalAlign="Center" />

		    <asp:BoundField DataField="CallLength" HeaderText="Call Length" SortExpression="CallLength" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="CallDate" HeaderText="Call Date" SortExpression="CallDate" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ReviewPeriodMonth" HeaderText="Review Period Month" SortExpression="ReviewPeriodMonth" HeaderStyle-HorizontalAlign="Center" />                         
            <asp:BoundField DataField="ReviewPeriodYear" HeaderText="Review Period Year" SortExpression="ReviewPeriodYear" HeaderStyle-HorizontalAlign="Center" /> 

            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />   

            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="BorrowerLastName" HeaderText="Borrower Name" SortExpression="BorrowerLastName"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="RecordingDeliveryDate" HeaderText="Recording Delivery Date" SortExpression="RecordingDeliveryDate" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
             
            <asp:TemplateField HeaderText="Rep Disconnected Borrower?" SortExpression="Score_Disconnect_Borrower" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_Disconnect_Borrower") Is DBNull.Value, "", TrueFalse(Eval("Score_Disconnect_Borrower")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Complaint?" SortExpression="Complaint" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Complaint") Is DBNull.Value, "", TrueFalse(Eval("Complaint")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="IMF_Timely" HeaderText="Complaint Timely?" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

             <asp:TemplateField HeaderText="Correct ID?" SortExpression="Score_CorrectID" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_CorrectID") Is DBNull.Value, "", TrueFalse(Eval("Score_CorrectID")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="PCA Identified Itself" SortExpression="Score_ProperlyIdentified" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_ProperlyIdentified") Is DBNull.Value, "", TrueFalse(Eval("Score_ProperlyIdentified")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Mini-Miranda?" SortExpression="Score_MiniMiranda" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_MiniMiranda") Is DBNull.Value, "", TrueFalse(Eval("Score_MiniMiranda")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Accurate Info?" SortExpression="Score_Accuracy" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_Accuracy") Is DBNull.Value, "", TrueFalse(Eval("Score_Accuracy")))%>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Accurate Notepad?" SortExpression="Score_Notepad" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_Notepad") Is DBNull.Value, "", TrueFalse(Eval("Score_Notepad")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Prof Tone?" SortExpression="Score_Tone" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_Tone") Is DBNull.Value, "", TrueFalse(Eval("Score_Tone")))%>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Responsive?" SortExpression="Score_PCAResponsive" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_PCAResponsive") Is DBNull.Value, "", TrueFalse(Eval("Score_PCAResponsive")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="AWG Info" SortExpression="Score_AWGInfo" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_AWGInfo") Is DBNull.Value, "", TrueFalse(Eval("Score_AWGInfo")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Exceeded Hold Time?" SortExpression="Score_AWGInfo" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%# If(Eval("Score_ExceededHoldTime") Is DBNull.Value, "", TrueFalse(Eval("Score_ExceededHoldTime")))%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="Score_Rehab_Once" HeaderText="The borrower can only rehab once" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Nine_Payments" HeaderText="Requires 9 pymts over 10 mos, except Perkins (9 consec pymts)" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_TitleIV" HeaderText="After 6th pymt borr may regain TIV eligbility" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Credit_Reporting" HeaderText="Rep mislead borrower that rehab would clear credit?" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_TOP" HeaderText="TOP stops only after loans are transferred" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_AWG" HeaderText="Can prevent AWG but cannot stop current garnishment" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Continue_Payments" HeaderText="Must continue making pymts until transferred" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Collection_Charges_Waived" HeaderText="At transfer remaining collection charges are waived" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Financial_Documents" HeaderText="Financial Documents" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Rehab_Agreement_Letter" HeaderText="Rehab Agreement Letter" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Contact_Us" HeaderText="Contact Us" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Eligible_Payment_Plans" HeaderText="After transfer, eligible for pre-default pymt plans" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Deferment_Forb" HeaderText="After transfer, borr may qualify for deferment or forbearance" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_New_Payment_Schedule" HeaderText="Must work out new pymt schedule with servicer" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Reversed_Payments" HeaderText="Reversed or NSF pymts can jeopardize rehab" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Loans_Transferred_After_60_Days" HeaderText="Loan(s) will be transferred to servicer approx 60 days after rehab" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Electronic_Payments" HeaderText="Did the rep encourage electronic payments?" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Delay_Tax_Reform" HeaderText="Advise the borr to delay filing tax return" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_More_Aid" HeaderText="Tell the borr that he/she will be eligible for TIV, defers, forbs" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Collection_Costs_Waived" HeaderText="Quote an exact amt for the collection costs that will be waived" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_False_Requirements" HeaderText="Impose requirements that are not required" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Avoid_PIF" HeaderText="Talk them out of PIF or SIF" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Rehab_Then_TPD" HeaderText="Tell a disabled borr that to rehab first then apply for TPD" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Payments_Are_Final" HeaderText="State pymt amounts and dates are final" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Not_Factual" HeaderText="State anything that is not factual" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Consol_New_Loan" HeaderText="Did the PCA rep advise the borrower that consolidation is a new loan?" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Consol_Credit_Reporting" HeaderText="PCA accurately explained how consolidation affects credit reporting?" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Consol_Interest_Rates" HeaderText="PCA accurately explained interest rate of consolidation loan" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Consol_Capitalization" HeaderText="PCA accurately explained interst and fees are capitalized with consolidation loan" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Consol_TitleIV" HeaderText="PCA explained consolidation allows borrower to receive additional Title IV aid" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Consol_Repayment_Options" HeaderText="PCA explained consolidation repayment options" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Score_Consol_Default" HeaderText="PCA advised borrower if consolidation loan defaults it cannot be consolidated" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Correct_Actions" HeaderText="Number of correct actions PCA took" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Incorrect_Actions" HeaderText="Number of incorrect actions PCA took" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Total_Actions" HeaderText="Total number of actions PCA took" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Percent_Actions" HeaderText="% of correct actions PCA took" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />                        
            <asp:BoundField DataField="FSA_Comments" HeaderText="FSA Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="PCA_Comments" HeaderText="PCA Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="FSA_Conclusions" HeaderText="FSA Conclusions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="FSASupervisor_Comments" HeaderText="FSA Supervisor Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="RecordingDeliveryDate" HeaderText="Recording Delivery Date" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="WorksheetPCADate" HeaderText="Date Worksheet Completed By LA" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="FinalPCADate" HeaderText="Date Final Report Completed By LA" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="QCWorksheetDate" HeaderText="Date Worksheet Approved" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="QCFinalDate" HeaderText="Date Final Report Approved" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
         </Columns>
    </asp:GridView>
</asp:Content>

