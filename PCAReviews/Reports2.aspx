<%@ Page Title="PCA Review Monitoring - Report Summary" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Reports2.aspx.vb" Inherits="PCAReviews_Report_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" media="print" href="print.css" />
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
  <li class="dropdown">
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

  <li class="dropdown active">
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
<p><br /></p>

<asp:SqlDataSource ID="dsCallDates" runat="server" SelectCommand="p_ReportCallDates"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
    </SelectParameters>    
</asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Review Report - One PCA</span>
  </div>
  <div class="panel-body">
  <table class="table">
        <tr>
            <td valign="top">
            <!--PCA--> 
            <label class="form-label">PCA:</label>       
             <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="1">
                 <asp:ListItem Text="" Value="" />
                 <asp:ListItem Value="1" Text="Account Control Technology"></asp:ListItem>
                 <asp:ListItem Value="26" Text="Action Financial Services"></asp:ListItem>
                 <asp:ListItem Value="2" Text="Allied Interstate"></asp:ListItem>
                 <asp:ListItem Value="27" Text="Bass and Associates"></asp:ListItem>
                 <asp:ListItem Value="3" Text="CBE Group"></asp:ListItem>
                 <asp:ListItem Value="25" Text="Central Credit Adjustments"></asp:ListItem>
                 <asp:ListItem Value="24" Text="Central Research"></asp:ListItem>
                 <asp:ListItem Value="4" Text="Coast Professional"></asp:ListItem>
                 <asp:ListItem Value="5" Text="Collection Technology"></asp:ListItem>
                 <asp:ListItem Value="6" Text="ConServe"></asp:ListItem>
                 <asp:ListItem Value="7" Text="Delta Management Associates"></asp:ListItem>
                 <asp:ListItem Value="8" Text="Performant (DCS)"></asp:ListItem>
                 <asp:ListItem Value="9" Text="Enterprise Recovery Systems"></asp:ListItem>
                 <asp:ListItem Value="10" Text="EOS-Collecto"></asp:ListItem>
                 <asp:ListItem Value="11" Text="FAMS"></asp:ListItem>
                 <asp:ListItem Value="28" Text="FH Cann"></asp:ListItem>
                 <asp:ListItem Value="12" Text="FMS"></asp:ListItem>
                 <asp:ListItem Value="13" Text="GC Services"></asp:ListItem>
                 <asp:ListItem Value="21" Text="GRSI (West)"></asp:ListItem>
                 <asp:ListItem Value="14" Text="Immediate Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="29" Text="National Credit Services"></asp:ListItem>
                 <asp:ListItem Value="15" Text="National Recoveries"></asp:ListItem>
                 <asp:ListItem Value="16" Text="Transworld Systems (NCO)"></asp:ListItem>
                 <asp:ListItem Value="17" Text="Pioneer Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="18" Text="Premiere Credit of North America"></asp:ListItem>
                 <asp:ListItem Value="30" Text="Professional Bur of Coll MD"></asp:ListItem>
                 <asp:ListItem Value="19" Text="Progressive Financial Services"></asp:ListItem>
                 <asp:ListItem Value="31" Text="Reliant Capital Solutions"></asp:ListItem>
                 <asp:ListItem Value="23" Text="Treasury"></asp:ListItem>
                 <asp:ListItem Value="20" Text="Van Ru Credit Corp"></asp:ListItem>                 
                 <asp:ListItem Value="22" Text="Windham Professionals"></asp:ListItem>                                 
             </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPCAID" ErrorMessage="* Select a PCA *" CssClass="alert-danger" Display="Dynamic" />
            </td>
            <td valign="top">
            <label class="form-label">Review Period Month:</label>
            <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" TabIndex="4" CssClass="inputBox">
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
                       </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlReviewPeriodMonth" ErrorMessage="* Select a Review Period Month *" CssClass="alert-danger" Display="Dynamic" /></td>
            <td valign="top">
            <label class="form-label">Review Period Year:</label>
            <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" TabIndex="5" CssClass="inputBox">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2015" Value="2015" />
                        <asp:ListItem Text="2016" Value="2016" />
                        <asp:ListItem Text="2017" Value="2017" />
                       </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlReviewPeriodYear" ErrorMessage="* Select a Review Period Year *" CssClass="alert-danger" Display="Dynamic" /></td>
          </tr>
        
        <tr>
            <td colspan="3" align="center">
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" /> 
            <asp:Button ID="btnExportExcel" runat="server" Text="Export Records to Excel" CssClass="btn btn-md btn-info" OnClick="btnExcelExport_Click" Visible="false" />
            <asp:Button id="btnFinalReport" runat="server" CssClass="btn btn-md btn-default" Text="Final Report" OnClick="btnFinalReport_Click" Visible="false" OnClientClick="confirm('Click the ED logo on the report window to create a final PDF report')" /><br />
            <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
            </td>
        </tr>
</table>
</div>
</div>

<br />
<span class="h4">Number of Reviews: <asp:Label ID="lblPopulationSize" runat="server" /></span>

<table class="table-bordered table-hover progress-striped" width="95%" cellpadding="4">
<thead>
    <tr>
        <th>Metric</th>        
        <th class="text-center">Total Actions</th>
        <th class="text-center">Incorrect Actions</th>
        <th class="text-center">% Incorrect In Category</th>
        <th class="text-center">Error Details</th>
    </tr>
</thead>
<tr>
    <th class="alert-info" colspan="5">Phone Review Rating Data</th> 
</tr>
<tr>
    <td>Correct ID: Right Party Authentication</td>
    <td class="text-right"><asp:Label ID="lblScore_CorrectID_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_CorrectID_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_CorrectID_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="btn1" runat="server" CommandArgument="Score_CorrectID,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<!--Added-->
<tr>
    <td>Properly Idenitified Itself</td>
    <td class="text-right"><asp:Label ID="lblScore_ProperlyIdentified_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_ProperlyIdentified_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_ProperlyIdentified_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="btn2" runat="server" CommandArgument="Score_ProperlyIdentified,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Mini-Miranda Provided</td>
    <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button1" runat="server" CommandArgument="Score_MiniMiranda,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Call Recording</td>
    <td class="text-right"><asp:Label ID="lblScore_CallRecording_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_CallRecording_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_CallRecording_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button9" runat="server" CommandArgument="Score_CallRecording,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>PCA Used Professional Tone</td>
    <td class="text-right"><asp:Label ID="lblScore_Tone_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Tone_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Tone_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button2" runat="server" CommandArgument="Score_Tone,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>

</tr>    
<tr>
    <td>Accurate Information Provided</td>
    <td class="text-right"><asp:Label ID="lblScore_Accuracy_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Accuracy_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Accuracy_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button3" runat="server" CommandArgument="Score_Accuracy,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Accurate Notepad</td>
    <td class="text-right"><asp:Label ID="lblScore_Notepad_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Notepad_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Notepad_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button4" runat="server" CommandArgument="Score_Notepad,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>PCA Was Responsive to the Borrower</td>
    <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button5" runat="server" CommandArgument="Score_PCAResponsive,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>PCA Provided Accurate AWG Info</td>
    <td class="text-right"><asp:Label ID="lblScore_AWGInfo_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_AWGInfo_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_AWGInfo_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button6" runat="server" CommandArgument="Score_AWGInfo,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<!--Added-->
<tr>
    <td>PCA Disconnected Borrower</td>
    <td class="text-right">N/A</td>
    <td class="text-right"><asp:Label ID="lblScore_Disconnect_Borrower_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Disconnect_Borrower_Percent" runat="server" Text="N/A" /></td>
    <td class="text-center"><asp:Button ID="Button7" runat="server" CommandArgument="Score_Disconnect_Borrower,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>PCA Received a Complaint</td>
    <td class="text-right"><asp:Label ID="lblScore_Complaint_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Complaint_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Complaint_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button8" runat="server" CommandArgument="Complaint,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Exceeded Hold Time</td>
    <td class="text-right"><asp:Label ID="lblScore_ExceededHoldTime_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_ExceededHoldTime_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_ExceededHoldTime_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button42" runat="server" CommandArgument="Score_ExceededHoldTime,bit" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
   <th class="alert-danger" colspan="5">Rehab Ratings - Collector MUST say these things</th> 
</tr>

<tr>
    <td>The borrower can only rehab once</td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Once_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Once_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Once_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button10" runat="server" CommandArgument="Score_Rehab_Once,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Requires 9 pymts over 10 mos, except Perkins (9 consec pymts)</td>
    <td class="text-right"><asp:Label ID="lblScore_Nine_Payments_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Nine_Payments_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Nine_Payments_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button11" runat="server" CommandArgument="Score_Nine_Payments,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>After 6th pymt borr may regain Title IV eligibility</td>
    <td class="text-right"><asp:Label ID="lblScore_TitleIV_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_TitleIV_Incorrect" runat="server" /></td> 
    <td class="text-right"><asp:Label ID="lblScore_TitleIV_Percent" runat="server" /></td>   
    <td class="text-center"><asp:Button ID="Button19" runat="server" CommandArgument="Score_TitleIV,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>CBR removes the record of default</td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_Reporting_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_Reporting_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Credit_Reporting_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button22" runat="server" CommandArgument="Score_Credit_Reporting,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>TOP stops only after loans are transferred</td>
    <td class="text-right"><asp:Label ID="lblScore_TOP_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_TOP_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_TOP_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button13" runat="server" CommandArgument="Score_TOP,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Can prevent AWG but cannot stop current garnishment</td>
    <td class="text-right"><asp:Label ID="lblScore_AWG_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_AWG_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_AWG_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button14" runat="server" CommandArgument="Score_AWG,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Must continue making pymts until transferred</td>
    <td class="text-right"><asp:Label ID="lblScore_Continue_Payments_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Continue_Payments_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Continue_Payments_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button15" runat="server" CommandArgument="Score_Continue_Payments,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>At transfer remaining collection charges are waived</td>
    <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived_Incorrect" runat="server" /></td> 
    <td class="text-right"><asp:Label ID="lblScore_Collection_Charges_Waived_Percent" runat="server" /></td>   
    <td class="text-center"><asp:Button ID="Button20" runat="server" CommandArgument="Score_Collection_Charges_Waived,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Explained borrower must supply financial documents for payment amount</td>
    <td class="text-right"><asp:Label ID="lblScore_Financial_Documents_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Financial_Documents_Incorrect" runat="server" /></td> 
    <td class="text-right"><asp:Label ID="lblScore_Financial_Documents_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button40" runat="server" CommandArgument="Score_Financial_Documents,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td> 
</tr>
<tr>
    <td>Explained borrower must sign rehab agreement letter (RAL)</td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Agreement_Letter_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Agreement_Letter_Incorrect" runat="server" /></td> 
    <td class="text-right"><asp:Label ID="lblScore_Rehab_Agreement_Letter_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button41" runat="server" CommandArgument="Score_Rehab_Agreement_Letter,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td> 
</tr>
<tr>
    <td>Contact Us</td>
    <td class="text-right"><asp:Label ID="lblScore_Contact_Us_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Contact_Us_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Contact_Us_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button21" runat="server" CommandArgument="Score_Contact_Us,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
   <th class="alert-success" colspan="5">Rehab Ratings - Collector MAY say these things</th> 
</tr>
<tr>
    <td>After transfer eligible for pre-default pymt plans</td>
    <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Eligible_Payment_Plans_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button17" runat="server" CommandArgument="Score_Eligible_Payment_Plans,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>After transfer borr may qualify for deferment or forbearance</td>
    <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Deferment_Forb_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button18" runat="server" CommandArgument="Score_Deferment_Forb,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Must work out new pymt schedule with servicer</td>
    <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_New_Payment_Schedule_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button16" runat="server" CommandArgument="Score_New_Payment_Schedule,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Reversed or NSF pymts can jeopardize rehab</td>
    <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Reversed_Payments_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button12" runat="server" CommandArgument="Score_Reversed_Payments,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Loans Transferred After 60 Days</td>
    <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days_Incorrect" runat="server" /></td> 
    <td class="text-right"><asp:Label ID="lblScore_Loans_Transferred_After_60_Days_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button39" runat="server" CommandArgument="Score_Loans_Transferred_After_60_Days,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Encourage Electronic Payments</td>
    <td class="text-right"><asp:Label ID="lblScore_Electronic_Payments_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Electronic_Payments_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Electronic_Payments_Percent" runat="server" /></td>    
    <td class="text-center"><asp:Button ID="Button23" runat="server" CommandArgument="Score_Electronic_Payments,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>

<!--Section Added-->
<tr>
   <th class="alert-success" colspan="5">Consolidation Ratings - Collector MAY say these things</th> 
</tr>
<tr>
    <td>This is a new loan</td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_New_Loan_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_New_Loan_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_New_Loan_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button32" runat="server" CommandArgument="Score_Consol_New_Loan,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Credit Reporting</td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Credit_Reporting_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Credit_Reporting_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Credit_Reporting_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button33" runat="server" CommandArgument="Score_Consol_Credit_Reporting,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Fixed interest rates</td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Interest_Rates_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Interest_Rates_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Interest_Rates_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button34" runat="server" CommandArgument="Score_Consol_Interest_Rates,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Capitalization</td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Capitalization_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Capitalization_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Capitalization_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button35" runat="server" CommandArgument="Score_Consol_Capitalization,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Title IV Eligibility</td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_TitleIV_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_TitleIV_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_TitleIV_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button36" runat="server" CommandArgument="Score_Consol_TitleIV,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Repayment Options</td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Repayment_Options_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Repayment_Options_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Repayment_Options_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button37" runat="server" CommandArgument="Score_Consol_Repayment_Options,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>
<tr>
    <td>Default</td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Default_Total" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Default_Incorrect" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Consol_Default_Percent" runat="server" /></td>
    <td class="text-center"><asp:Button ID="Button38" runat="server" CommandArgument="Score_Consol_Default,string" CssClass="btn-sm" Text="Show Me" OnClick="btnErrorType_Click" /></td>
</tr>

</table>
<br />
<asp:SqlDataSource ID="dsPreviousReviews" runat="server" SelectCommand="p_SavedReviews2"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" DeleteCommand="DELETE FROM SavedReviews2 WHERE SavedReviewID=@SavedReviewID">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
    </SelectParameters>
    <DeleteParameters>
       <asp:Parameter Name="SavedReviewID" />
   </DeleteParameters>
</asp:SqlDataSource>

<h3>Saved Reports</h3>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" 
DataKeyNames="SavedReviewID" DataSourceID="dsPreviousReviews" OnRowDataBound="GridView1_OnRowDataBound">
<EmptyDataTemplate>
    No Saved Reviews For This PCA
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
                    <asp:HyperLink ID="hypUploadAttachment" runat="server" NavigateUrl='<%# Eval("SavedReviewID", "AttachmentManager2.aspx?SavedReviewID={0}&Action=Upload")%>' Text='Upload' Target="_blank" /><br />
                    <asp:HyperLink ID="hypDeleteAttachment" runat="server" NavigateUrl='<%# Eval("SavedReviewID", "AttachmentManager2.aspx?SavedReviewID={0}&Action=Delete")%>' Text='Delete' Target="_blank" />               
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="DateEntered" HeaderText="Date Entered" SortExpression="DateEntered" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
		</Columns>        
</asp:GridView>
    <br />

    <asp:Button ID="btnDeleteSavedReport" OnClick="btnDeleteSavedReport_Click" runat="server" Text="Delete Checked Saved Reports" 
    CssClass="btn btn-sm btn-danger" OnClientClick="if ( !confirm('Are you sure you want to delete this saved report?')) return false" CausesValidation="false" />

</asp:Content>