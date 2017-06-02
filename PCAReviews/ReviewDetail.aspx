<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReviewDetail.aspx.vb" Inherits="PCAReviews_ReviewDetail2" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.checkAvailability.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />

      <script type="text/javascript">
         $(document).ready(function () {
             $('.datepicker').datepicker()

             $("#MainContent_txtBorrowerNumber").checkAvailability();

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

    <script type="text/javascript">
        // If the Complaint? field = True/Yes, then the LA needs to indicate whether the complaint was timely by completing the
        // Cmpt IMF Timely field. Set focus to ddlIMF_Timely if true
        $(function () {
            $('select[id$=MainContent_ddlComplaint]').change(function () {
                if (this.value == 'True') {
                    $('#MainContent_ddlIMF_Timely').focus();
                      alert("Please indicate whether the complaint was timely by completing the Cmpt IMF Timely field");
                }
            })
         });  
    </script>

    <script type="text/javascript">
        function secondstotime() {
            var secs = $('#MainContent_txtCallLength').val();;
            var t = new Date(1970, 0, 1);
            t.setSeconds(secs);
            var s = t.toTimeString().substr(0, 8);
            if (secs > 86399)
                s = Math.floor((t - Date.parse("1/1/70")) / 3600000) + s.substr(2);
            $('#MainContent_txtCallLength').val(s);
            $('#MainContent_txtCallLengthActual').val(s);
        }
    </script>

    <style type="text/css">
        .auto-style1 {
            padding-right: 35px;
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown active">
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
<br />
<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />        

 <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Review Details: Review ID <asp:Label ID="lblReviewID" runat="server" /> Reviewed By <asp:Label ID="lblReviewAgency" runat="server" /></span>
  </div>
  <div class="panel-body">
  <asp:Label ID="lblUserID" runat="server" Visible="false" />
  
  <!--Call Scoring Section-->
  <table class="table" id="tblCallScoring">
      <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Correct Actions" data-content="The number of metrics the PCA performed correctly">Correct Actions</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Incorrect Actions" data-content="The number of metrics the PCA performed incorrectly">Incorrect Actions</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Total Actions" data-content="The total number of metrics the PCA performed on the review">Total Actions</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="% Correct" data-content="The percentage of metrics the PCA performed correctly on the review">% Correct</a></th>
      </tr>
      <tr class="alert-danger">
        <td class="tableColumnCell"><asp:Label ID="lblCorrect_Actions" runat="server" CssClass="h3" /></td>
        <td class="tableColumnCell"><asp:Label ID="lblIncorrect_Actions" runat="server" CssClass="h3" /></td>
        <td class="tableColumnCell"><asp:Label ID="lblTotal_Actions" runat="server" CssClass="h3" /></td>
        <td class="tableColumnCell"><asp:Label ID="lblPercent_Actions" runat="server" CssClass="h3" /></td>
      </tr>
  </table> 
  
      
      <!--Borrower/Call Details--> 
  <table class="table" id="tblBorrowerDetails">
     <tr>        
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Initial Rehab/Consolidation Talk-Off?" data-content="Is this review a rehab or consolidation talk=off?">Rehab/Consol Talk-Off?</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Call Date" data-content="The date the call was placed">Call Date</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="PCA" data-content="The PCA the review is for">PCA</a></th>     
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Review Period" data-content="The date the review was performed">Review Period</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The DMCS account number">Borrower Number</a></th>
    </tr>
      <tr>            
          <td class="tableColumnCell">
                Rehab: <asp:DropDownList ID="ddlRehabTalkOff" runat="server" CssClass="inputBox" TabIndex="1">
                    <asp:ListItem Selected="True">No</asp:ListItem>
                    <asp:ListItem>Yes</asp:ListItem>
                </asp:DropDownList><br />
                Consol: <asp:DropDownList ID="ddlConsolTalkOff" runat="server" CssClass="inputBox" TabIndex="2">
                    <asp:ListItem Selected="True">No</asp:ListItem>
                    <asp:ListItem>Yes</asp:ListItem>
                </asp:DropDownList>
          </td>  
          <td class="tableColumnCell">
            <asp:TextBox ID="txtCallDate" runat="server" CssClass="datepicker" TabIndex="3" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Call Date is a required field *"
                        ControlToValidate="txtCallDate" Display="Dynamic" CssClass="alert-danger" /></td>
            <td class="tableColumnCell">              
            <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="4" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID">
             </asp:DropDownList>                 
            </td>
            <td class="tableColumnCell">                   
                Month: <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" TabIndex="5" CssClass="inputBox">
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
                       </asp:DropDownList>
                Year: <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" TabIndex="6" CssClass="inputBox">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2015" Value="2015" />
                        <asp:ListItem Text="2016" Value="2016" />
                        <asp:ListItem Text="2017" Value="2017" Selected="True" />
                       </asp:DropDownList>  
                    <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Review Month is a required field *"
                    ControlToValidate="ddlReviewPeriodMonth" Display="Dynamic" CssClass="alert-danger" />

                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Review Year is a required field *"
                    ControlToValidate="ddlReviewPeriodYear" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell">                   
                <asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" TabIndex="7" /> <br /><input id="btnCheck" type="button" value="Check Borrower ID" class="btn btn-sm btn-primary" /><br />
                <span id="response" class="alert-danger"><!-- Our message will be echoed out here --></span>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Borrower Number is a required field *"
                ControlToValidate="txtBorrowerNumber" Display="Dynamic" CssClass="alert-danger" /><br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Borrower Number must be 10 digits" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" ValidationExpression="\d{10}"   />
            </td>           
      </tr>
      <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Borrower Last Name" data-content="The borrower's last name">Borrower Last Name</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Call Length" data-content="The length of the call in minutes and seconds that was placed. Example: 4:15">Call Length</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Phone Recording Delivery Date" data-content="The date the supervisor gave the Loan Analyst the recording of the PCA call">Phone Recording Delivery Date</a></th>     
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Inbound/Outbound" data-content="Was the PCA call an inbound or outbound call?">Inbound/Outbound</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Call Type" data-content="The type of call that was placed to the PCA">Call Type</a></th>
      </tr>
      <tr>            
          <td class="tableColumnCell">   
                <asp:TextBox ID="txtBorrowerLastName" runat="server" CssClass="inputBox" TabIndex="8" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Borrower Last Name is a required field *"
                    ControlToValidate="txtBorrowerLastName" Display="Dynamic" CssClass="alert-danger" />
            </td>  
          <td class="tableColumnCell">        
                <asp:TextBox ID="txtCallLength" runat="server" CssClass="inputBox" TabIndex="9" /> (stated)<br />
                <asp:TextBox ID="txtCallLengthActual" runat="server" CssClass="inputBox" TabIndex="9" /> (actual)<br />
                <input id="btnConvertSeconds" type="button" value="Convert Seconds" class="btn btn-xs btn-primary" onclick="secondstotime()" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="* Call Length is a required field *"
                    ControlToValidate="txtCallLength" Display="Dynamic" CssClass="alert-danger" />
                    <br />
            </td>
            <td class="tableColumnCell">
            <asp:TextBox ID="txtRecordingDeliveryDate" runat="server" CssClass="datepicker" TabIndex="10" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Recording Delivery Date is a required field *"
                    ControlToValidate="txtRecordingDeliveryDate" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell"> 
            <asp:DropDownList ID="ddlInOutBound" runat="server" CssClass="inputBox" TabIndex="11">
                <asp:ListItem Text="" Value="" Selected="True" />    
                <asp:ListItem Text="Inbound" Value="Inbound" />
                <asp:ListItem Text="Outbound" Value="Outbound" />
                </asp:DropDownList>
            </td>        
            <td class="tableColumnCell"> 
             <asp:DropDownList ID="ddlCallType" runat="server" CssClass="inputBox" TabIndex="12">
                <asp:ListItem Text="" Value="" Selected="True" />
                <asp:ListItem Text="Borrower" Value="Borrower" />
                <asp:ListItem Text="3rd Party" Value="3rd Party" />
             </asp:DropDownList></td>
            <td class="tableColumnCell"> </td>        
        </tr>
  </table>
  
  <!--General Call Review-->
      <table class="table" id="tblGeneralReview">
      <tr>
        <th class="alert-caution" colspan="5">General Call Review</th> 
      </tr>
      <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Correct ID?" data-content="Right party authentication: Name and SSN, Acct Number, DOB, Address (at least one)">Correct ID?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Identified Itself" data-content="Rep stated company name and reason for call">PCA Identified Itself</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Mini-Miranda?" data-content="Did the collector mirandize the borrower when applicable?">Mini-Miranda?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Professional Tone Used?" data-content="Did the collector use a professional tone of voice with the borrower?">Professional Tone Used?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info?" data-content="Did the PCA provide accurate information to the caller?">Accurate Info Provided?</a></th>
      </tr>
            <tr>
          <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_CorrectID" runat="server" CssClass="inputBox" TabIndex="13">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
          <td class="tableColumnCell">
                  <asp:DropDownList ID="ddlScore_ProperlyIdentified" runat="server" CssClass="inputBox" TabIndex="14">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>  
          <td class="tableColumnCell">
                  <asp:DropDownList ID="ddlScore_MiniMiranda" runat="server" CssClass="inputBox" TabIndex="15">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>          
          <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_Tone" runat="server" CssClass="inputBox" TabIndex="16">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td> 
          <td class="tableColumnCell">
                    <asp:DropDownList ID="ddlScore_Accuracy" runat="server" CssClass="inputBox" TabIndex="17">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>           
      </tr>            

      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Notepad?" data-content="Did the collector update the DMCS notepad screen accurately?">Accurate Notepad?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Responsive?" data-content="Was the PCA responsive toward the borrower?">PCA Responsive?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info about AWG?" data-content="Did the collector provide accurate Info about AWG?">Accurate Info For AWG</a>?</th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Disconnect Borrower?" data-content="Did the PCA disconnect the borrower?">PCA Disconnect Borrower?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Complaint?" data-content="Did the borrower raise a complaint during the call?">Complaint?</a></th>
      </tr>
      <tr>            
          <td class="tableColumnCell">                    
                    <asp:DropDownList ID="ddlScore_Notepad" runat="server" CssClass="inputBox" TabIndex="18">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
           <td class="tableColumnCell">                    
                <asp:DropDownList ID="ddlScore_PCAResponsive" runat="server" CssClass="inputBox" TabIndex="19">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
            <td class="tableColumnCell">
                <asp:DropDownList ID="ddlScore_AWGInfo" runat="server" CssClass="inputBox" TabIndex="20">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>            
            </td>
         <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Disconnect_Borrower" runat="server" CssClass="inputBox" TabIndex="21">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
            </asp:DropDownList>
            </td>
           <td class="tableColumnCell">
            <asp:DropDownList ID="ddlComplaint" runat="server" CssClass="inputBox" TabIndex="22">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
            </asp:DropDownList></td>
      </tr>
      <tr>        
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="IMF Submission Date" data-content="If the review was submitted by eIMF, the date it was submitted">IMF Submission Date</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Cmpt IMF Timely?" data-content="Was the IMF submitted timely?">Cmpt IMF Timely</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Exceeded Hold Time" data-content="Did the PCA put the borrower on hold too long?">Exceeded Hold Time</a></th>
        <th class="tableColumnHead">&nbsp;</th>
        <th class="tableColumnHead">&nbsp;</th>
      </tr>
      <tr>    
          <td class="tableColumnCell">    
               <asp:TextBox ID="txtIMF_Submission_Date" runat="server" CssClass="datepicker" TabIndex="23" />
                </td>
            <td class="tableColumnCell">            
                <asp:DropDownList ID="ddlIMF_Timely" runat="server" CssClass="inputBox" TabIndex="24">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="Yes" />
                    <asp:ListItem Text="No" Value="No" />
                </asp:DropDownList></td>
            <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_ExceededHoldTime" runat="server" CssClass="inputBox" TabIndex="25">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
            <td class="tableColumnCell">&nbsp;</td>
            <td class="tableColumnCell">&nbsp;</td>
        </tr>
</table>

  <!--Rehab Section-->
  <div id="pnlRehab">
    <table class="table" id="tblRehab">
         <!--Collector MUST say these things-->
    <tr>
        <th class="alert-success" colspan="5">Rehab Review - Collector MUST say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Rehab Once" data-content="Did the PCA inform the borrower that loan(s) can be rehabilitated only once?">Rehab Once</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="9 Payments" data-content="Requires 9 payments over 10 months except Perkins (9 consecutive payments)">9 Payments</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Title IV Eligibility" data-content="Did the PCA Representative inform the consumer:  Title IV eligibility is restored as long as you have no other federally defaulted student loans and meet all other student eligibility requirements.  However, before the loan(s) is rehabilitated you can apply for reinstatement after your 6th on-time consecutive monthly payment is made.  You can only reinstate eligibility in this way once and you have to continue making payments or you will lose eligibility again.">Title IV Eligibility</a></th>     
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="CBR removes the record of default" data-content="Did the PCA Representative mislead the consumer to believe that Rehabilitation removes all evidence of delinquency on the consumer’s credit report - PCA Manual states: The loan is no longer in default and ED requests that credit reporting agencies remove the record of default reported by ED. The credit update is normally reflected in the next monthly credit reporting cycle. ED does not request that credit reporting agencies remove or update any credit reporting done prior to default, including reporting of late payments.  If a Treasury offset pays your balance in full prior to completing the loan rehabilitation program, ED will not request that credit reporting agencies remove the default reported by ED from their credit report.">CBR removes the record of default</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="TOP" data-content="Did the PCA Representative Inform the consumer:  The loans included in this rehabilitation will be decertified for Treasury offset.  When beginning the rehabilitation program, if the loans included are already certified for offset, they will be offset until after they are transferred to the new servicer, entering into the rehabilitation program will not stop the offset.">TOP</a></th>    </tr>    
    <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Rehab_Once" runat="server" TabIndex="26">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Nine_Payments" runat="server" TabIndex="27">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TitleIV" runat="server" TabIndex="28">
             <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Credit_Reporting" runat="server" TabIndex="29">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TOP" runat="server" TabIndex="30">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>        
    </tr> 
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="AWG" data-content="Did the PCA Representative Inform the consumer: FSA will stop any current garnishments on the loans being rehabilitated. However, prior to rehabilitating the loans, if they are on an active garnishment (the order of withholding, WG15, was sent to the employer) you may be able to suspend the garnishment on the loans included in the rehabilitation after the 5th on time payment is made as long as you meet all of the other requirements. (See section 2.5.1, “Suspending AWG for rehabilitation” and section 2.4, “REHABILITATION AGREEMENT LETTER (RAL)”  for what the requirements are for this benefit.)">AWG</a></th>        
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Continue Payments" data-content="Must continue making payments until transferred">Continue Payments</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Collection Charges Waived" data-content="Did the PCA Representative inform the consumer:   Before completing the rehabilitation collection costs are charged on each payment made toward rehabilitation.  ED does not charge any collection costs on a loan after it is rehabilitated.  Once the loan is transferred to the new servicer, the collection costs will not be charged on the loan, unless you re-default.">Collection Charges Waived</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Financial Documents" data-content="Did the PCA Representative inform the consumer: The financial documents required in order to calculate the approved monthly payment amount for the rehabilitation program must be supplied before you are accepted into the program.">Financial Documents</a></th>        
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Rehab Agreement Letter" data-content="Did the PCA Representative inform the consumer: A rehabilitation agreement letter (RAL) must be signed and returned and it must include the list of all eligible loans. (optional: After 60 days, the PCA may pursue involuntary repayment or choose to extend additional time for the borrower to return the RAL.)">Rehab Agreement Letter</a></th>        
    </tr>
    <tr>
       <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_AWG" runat="server" TabIndex="31">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Continue_Payments" runat="server" TabIndex="32">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Collection_Charges_Waived" runat="server" TabIndex="33">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
           <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Financial_Documents" runat="server" TabIndex="34">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
         <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Rehab_Agreement_Letter" runat="server" TabIndex="35">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>         
       </tr>        

        <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Contact Us" data-content="The requirements are outlined in the Rehabilitation agreement letter as well as additional information on the program. When you receive the letter please review it and contact us at (PCA#) with any questions">Contact Us</a></th>
            <th class="tableColumnHead">&nbsp;</th>            
            <th class="tableColumnHead">&nbsp;</th>
            <th class="tableColumnHead">&nbsp;</th>
            <th class="tableColumnHead">&nbsp;</th>
        </tr>
        <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Contact_Us" runat="server" TabIndex="36">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
            &nbsp;</td>
        <td class="tableColumnCell"></td>   
        <td class="tableColumnCell"></td>
        <td class="tableColumnCell"></td>                    
    </tr>   
    <tr>
        <th class="alert-caution" colspan="6">Rehab Review - Collector MAY say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Pre-Default Payment Plans" data-content="After transfer eligible for pre-default payment plans">Eligible For Pre-Default Payment Plans</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Deferment/Forbearance" data-content="After transfer borrower may (not will) qualify for deferment of forbearance">Deferment/Forbearance</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="New Payment Schedule" data-content="Must work out new payment schedule with servicer">New Payment Schedule</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Reversed Payments" data-content="Reversed or NSF payments can jeopardize rehab">Reversed Payments</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Loans Transferred After 60 Days" data-content="Borrower must continue making payments until transferred to new servicer">Loans Transferred After 60 Days</a></th>
        <th class="tableColumnHead"> </th>
    </tr>    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Eligible_Payment_Plans" runat="server" TabIndex="37">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Deferment_Forb" runat="server" TabIndex="38">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td> 
         <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_New_Payment_Schedule" runat="server" TabIndex="39">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>        
       
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Reversed_Payments" runat="server" TabIndex="40">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>  
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Loans_Transferred_After_60_Days" runat="server" TabIndex="41">
               <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            </asp:DropDownList></td>
    </tr>
   <tr>
     <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Electronic Payments" data-content="Electronic payment methods such as credit or debit cards may be encouraged">Electronic Payments</a></th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
    </tr>
    <tr>
     <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Electronic_Payments" runat="server" TabIndex="42">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>        
    </tr>
    <tr>
        <th class="alert-danger" colspan="5">Rehab Review - Collector MUST NOT say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Delay Tax Return" data-content="Advise the borrower to delay filing tax return">Delay Tax Return</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="More Aid or Deferment" data-content="Tell the borrower that s/he will be eligible for Title IV, deferments forbearances">More Aid or Deferment</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Quote Collection Costs Waived" data-content="Quote an exact amount for collection costs that will be waived">Quote Collection Costs Waived</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="False Requirements" data-content="Impose requirements that are not required">False Requirements</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Avoid PIF" data-content="Talk them out of PIF or SIF if they are able and willing (can see the credit benefit of rehab)">Avoid PIF</a></th>
    </tr>
    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Delay_Tax_Reform" runat="server" TabIndex="44">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_More_Aid" runat="server" TabIndex="45">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Collection_Costs_Waived" runat="server" TabIndex="46">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_False_Requirements" runat="server" TabIndex="47">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Avoid_PIF" runat="server" TabIndex="48">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>           
    </tr> 
    
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Rehab Then TPD" data-content="Tell a disabled borrower that s/he should rehab first then apply for TPD">Rehab Then TPD</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Payments Are Final" data-content="Tell the borrower that payment amounts and dates are final and cannot be changed">Payments Are Final</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Not Factual" data-content="State anything that is not factual including attributing to ED things that are not ED policy">Not Factual</a></th>
        <th class="tableColumnHead">&nbsp;</th>
        <th class="tableColumnHead">&nbsp;</th>
    </tr>
    <tr>     
        
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Rehab_Then_TPD" runat="server" TabIndex="49">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Payments_Are_Final" runat="server" TabIndex="50">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Not_Factual" runat="server" TabIndex="51">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>  
    </tr> 
    </table>
</div>
        
  
 <!--Consolidation Section-->
 <div id="pnlConsol">
 <table class="table">
        <tr>
            <th class="alert-success" colspan="5">Consolidation Review - Collectors MAY Say These Things </th> 
        </tr>
      <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="This is a New Loan" data-content="Collector explains that consolidation loan is a new loan">This is a new loan</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Credit Reporting" data-content="Collector explained credit bureau reporting and update to default trade line accurately">Credit reporting</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Fixed Interest Rates" data-content="Consolidation loans have a fixed interest rate which is weighted average of the interest rates rounded up to nearest eighth of a percent. Variable interest rate loans become fixed.  Over the life of the loan interest rates may be higher or lower">Fixed interest rates</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Capitalization" data-content="By consolidating, all interest, as well as collection costs equal to 2.78% of the combined principal and interest will become the principal balance of their new loan - thus, interest accrurals on their consolidation loan may be higher than on their defaulted loans">Capitalization</a></th>
      </tr>
      <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_New_Loan" runat="server" TabIndex="52">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Credit_Reporting" runat="server" TabIndex="53">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Interest_Rates" runat="server" TabIndex="54">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Capitalization" runat="server" TabIndex="55">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>                
     </tr>
     <tr>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Title IV Eligibility" data-content="Upon consolidation, the loans consolidated will no longer prevent the borrower from receiving additional Title IV financial aid">Title IV Eligibility</a></th>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Repayment Options" data-content="Direct Loans offers several different repayment plans to accomodate differing financial circumstances and can be changed due to changing financial situations to avoid delinquency">Repayment options</a></th>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Default" data-content="If the consolidation loan defaults, it will not be eligible for consolidation">Default</a></th>
         <th class="tableColumnHead">&nbsp;</th>
     </tr> 
      <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_TitleIV" runat="server" TabIndex="56">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
          <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Repayment_Options" runat="server" TabIndex="57">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Default" runat="server" TabIndex="58">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td>
      </tr>    
   </table>
 </div>

<!--Comments-->    
 <table class="table"> 
       <tr>
            <th class="alert-info" colspan="4">Comments</th> 
        </tr>

        <tr>
            <td valign="top"  colspan="2">
            <!--FSA Comments-->           
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Loan Analyst Comments" data-content="Comments provided by the FSA Loan Analyst">FSA Loan Analyst Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtFSA_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="59" />                
                <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Comments" />                        
           </td>
          
            <td valign="top" colspan="2">
            <!--FSA Supervisor Comments-->           
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Supervisor Comments" data-content="Comments provided by a FSA supervisor">FSA Supervisor Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtFSASupervisor_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="60" />                
                <ASPNetSpell:SpellButton ID="SpellButton4" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSASupervisor_Comments" />                      
           <br /></td>
           </tr>
           <tr>
            <td valign="top"  colspan="2"> 
            <!--PCA Comments-->          
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Comments" data-content="Comments provided the PCA">PCA Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtPCA_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="61" />
                <ASPNetSpell:SpellButton ID="SpellButton2" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtPCA_Comments" />              
          </td>
           <td valign="top" colspan="2"> <!--FSA_Conclusions-->          
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Conclusions" data-content="Conclusions reached by FSA">FSA Conclusions</a></label><br />           
                <ASPNetSpell:SpellTextBox ID="txtFSA_Conclusions" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="62" />                     
                 <ASPNetSpell:SpellButton ID="SpellButton3" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Conclusions" />             
           <br /></td>
        </tr>
        <tr>
            <td colspan="4" align="center"><br />
            <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="btn btn-lg btn-primary" OnClick="btnUpdate_Click" TabIndex="63" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-lg btn-warning" Text="Cancel" />
            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-lg btn-danger" Text="Delete" OnClick="btnDelete_Click" CausesValidation="false" />
            <br /><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
            </td>
        </tr>
    </table>

<!--Begin QC Tier1-->
<asp:Panel ID="pnlQCTier1" runat="server" BackColor="Wheat">
  <table class="table">
        <tr>
            <th class="auto-style1" colspan="5">Tier 1 QC Assessment (Complete ONLY if you are doing a QC assessment of this review). Submitted: <asp:Label ID="lblQCTier1DateSubmitted" runat="server" /></th> 
        </tr>
                
          <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Correct ID Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Correct ID Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Identified Itself Accuracy" data-content="Rep stated company name and reason for call">PCA Identified Itself Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Mini-Miranda Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Mini-Miranda Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Professional Tone Used Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Professional Tone Used Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Accurate Info Accuracy</a></th>
      </tr> 
      <tr>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_CorrectID_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_ProperlyIdentified_Accuracy" runat="server" CssClass="inputBox">
                   <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_MiniMiranda_Accuracy" runat="server" CssClass="inputBox">
                   <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
           <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Tone_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Accuracy_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
      </tr>
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Notepad Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Accurate Notepad Accuracy</a></th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Responsive Accuracy" data-content="Did the Loan Analyst score this metric correctly?">PCA Responsive Accuracy</a></th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Did the collector provide accurate Info about AWG?" data-content="Did the Loan Analyst score this metric correctly?">Accurate Info For AWG</a>?</th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Complaints Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Complaint Accuracy</a></th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Exceeded Hold Time Accuracy" data-content="Did the PCA put the borrower on hold too long?">Exceeded Hold Time Accuracy</a></th>
      </tr>
      <tr>          
           
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Notepad_Accuracy" CssClass="inputBox" runat="server">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_PCAResponsive_Accuracy" CssClass="inputBox" runat="server">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_AWGInfo_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>

          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlComplaint_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_ExceededHoldTime_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
      </tr>
      </table>

  <!--QC Rehab Section-->
  <div id="pnlQCRehab">
    <table class="table" id="tblRehabQC">
    <!--Collector MUST say these things-->
    <tr>
        <th class="alert-success" colspan="5">QC Rehab Review - Collector MUST say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA inform the borrower that loan(s) can be rehabilitated only once?" data-toggle="popover" href="#" title="Rehab Once">Rehab Once</a></th>
        <th class="tableColumnHead" colspan="1"><a data-content="Requires 9 payments over 10 months except Perkins (9 consecutive payments)" data-toggle="popover" href="#" title="9 Payments">9 Payments</a></th>
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA Representative inform the consumer:  Title IV eligibility is restored as long as you have no other federally defaulted student loans and meet all other student eligibility requirements.  However, before the loan(s) is rehabilitated you can apply for reinstatement after your 6th on-time consecutive monthly payment is made.  You can only reinstate eligibility in this way once and you have to continue making payments or you will lose eligibility again." data-toggle="popover" href="#" title="Title IV Eligibility">Title IV Eligibility</a></th>     
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA Representative mislead the consumer to believe that Rehabilitation removes all evidence of delinquency on the consumer’s credit report - PCA Manual states: The loan is no longer in default and ED requests that credit reporting agencies remove the record of default reported by ED. The credit update is normally reflected in the next monthly credit reporting cycle. ED does not request that credit reporting agencies remove or update any credit reporting done prior to default, including reporting of late payments.  If a Treasury offset pays your balance in full prior to completing the loan rehabilitation program, ED will not request that credit reporting agencies remove the default reported by ED from their credit report." data-toggle="popover" href="#" title="CBR removes the record of default">CBR removes the record of default</a></th>
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA Representative Inform the consumer:  The loans included in this rehabilitation will be decertified for Treasury offset.  When beginning the rehabilitation program, if the loans included are already certified for offset, they will be offset until after they are transferred to the new servicer, entering into the rehabilitation program will not stop the offset." data-toggle="popover" href="#" title="TOP">TOP</a></th>    </tr>    
    <tr>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Rehab_Once_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Nine_Payments_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_TitleIV_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Credit_Reporting_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td> 
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_TOP_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>        
    </tr> 
    <tr>
        <th class="tableColumnHead"><a data-content="Did the PCA Representative Inform the consumer: FSA will stop any current garnishments on the loans being rehabilitated. However, prior to rehabilitating the loans, if they are on an active garnishment (the order of withholding, WG15, was sent to the employer) you may be able to suspend the garnishment on the loans included in the rehabilitation after the 5th on time payment is made as long as you meet all of the other requirements. (See section 2.5.1, “Suspending AWG for rehabilitation” and section 2.4, “REHABILITATION AGREEMENT LETTER (RAL)”  for what the requirements are for this benefit.)" data-toggle="popover" href="#" title="AWG">AWG</a></th>        
        <th class="tableColumnHead"><a data-content="Must continue making payments until transferred" data-toggle="popover" href="#" title="Continue Payments">Continue Payments</a></th>
        <th class="tableColumnHead"><a data-content="Did the PCA Representative inform the consumer:   Before completing the rehabilitation collection costs are charged on each payment made toward rehabilitation.  ED does not charge any collection costs on a loan after it is rehabilitated.  Once the loan is transferred to the new servicer, the collection costs will not be charged on the loan, unless you re-default." data-toggle="popover" href="#" title="Collection Charges Waived">Collection Charges Waived</a></th>
        <th class="tableColumnHead"><a data-content="Did the PCA Representative inform the consumer: The financial documents required in order to calculate the approved monthly payment amount for the rehabilitation program must be supplied before you are accepted into the program." data-toggle="popover" href="#" title="Financial Documents">Financial Documents</a></th>        
        <th class="tableColumnHead"><a data-content="Did the PCA Representative inform the consumer: A rehabilitation agreement letter (RAL) must be signed and returned and it must include the list of all eligible loans. (optional: After 60 days, the PCA may pursue involuntary repayment or choose to extend additional time for the borrower to return the RAL.)" data-toggle="popover" href="#" title="Rehab Agreement Letter">Rehab Agreement Letter</a></th>        
    </tr>
    <tr>
       <td class="tableColumnCell">
           <asp:DropDownList ID="ddlScore_AWG_Accuracy" runat="server" CssClass="inputBox">
               <asp:ListItem Text="" Value=""></asp:ListItem>
               <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
               <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
               <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
           </asp:DropDownList>
        </td> 
        <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Continue_Payments_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Collection_Charges_Waived_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
           <td class="tableColumnCell">
               <asp:DropDownList ID="ddlScore_Financial_Documents_Accuracy" runat="server" CssClass="inputBox">
                   <asp:ListItem Text="" Value=""></asp:ListItem>
                   <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                   <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                   <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
               </asp:DropDownList>
        </td>
         <td class="tableColumnCell">
             <asp:DropDownList ID="ddlScore_Rehab_Agreement_Letter_Accuracy" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value=""></asp:ListItem>
                 <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                 <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                 <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
             </asp:DropDownList>
        </td>         
       </tr>        

        <tr>
            <th class="tableColumnHead"><a data-content="The requirements are outlined in the Rehabilitation agreement letter as well as additional information on the program. When you receive the letter please review it and contact us at (PCA#) with any questions" data-toggle="popover" href="#" title="Contact Us"></a><a href="#">Contact Us</a></th>
            <th class="tableColumnHead">&nbsp;</th>            
            <th class="tableColumnHead">&nbsp;</th>
            <th class="tableColumnHead">&nbsp;</th>
            <th class="tableColumnHead">&nbsp;</th>
        </tr>
        <tr>
        <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Contact_Us_Accuracy" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
            </td>
        <td class="tableColumnCell">
            &nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>   
        <td class="tableColumnCell"></td>
        <td class="tableColumnCell"></td>                    
    </tr>   
    <tr>
        <th class="alert-caution" colspan="6">QC Rehab Review - Collector MAY say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Pre-Default Payment Plans" data-content="After transfer eligible for pre-default payment plans">Eligible For Pre-Default Payment Plans</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Deferment/Forbearance" data-content="After transfer borrower may (not will) qualify for deferment of forbearance">Deferment/Forbearance</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="New Payment Schedule" data-content="Must work out new payment schedule with servicer">New Payment Schedule</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Reversed Payments" data-content="Reversed or NSF payments can jeopardize rehab">Reversed Payments</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Loans Transferred After 60 Days" data-content="Borrower must continue making payments until transferred to new servicer">Loans Transferred After 60 Days</a></th>
        <th class="tableColumnHead"> </th>
    </tr>    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Eligible_Payment_Plans_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Deferment_Forb_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td> 
         <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_New_Payment_Schedule_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>        
       
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Reversed_Payments_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>  
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Loans_Transferred_After_60_Days_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
   <tr>
     <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Electronic Payments" data-content="Electronic payment methods such as credit or debit cards may be encouraged">Electronic Payments</a></th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>     
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
    </tr>
    <tr>
     <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Electronic_Payments_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td> 
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>        
    </tr>
    <tr>
        <th class="alert-danger" colspan="5">QC Rehab Review - Collector MUST NOT say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Delay Tax Return" data-content="Advise the borrower to delay filing tax return">Delay Tax Return</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="More Aid or Deferment" data-content="Tell the borrower that s/he will be eligible for Title IV, deferments forbearances">More Aid or Deferment</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Quote Collection Costs Waived" data-content="Quote an exact amount for collection costs that will be waived">Quote Collection Costs Waived</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="False Requirements" data-content="Impose requirements that are not required">False Requirements</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Avoid PIF" data-content="Talk them out of PIF or SIF if they are able and willing (can see the credit benefit of rehab)">Avoid PIF</a></th>
    </tr>
    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Delay_Tax_Reform_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_More_Aid_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Collection_Costs_Waived_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_False_Requirements_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Avoid_PIF_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>           
    </tr> 
    
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Rehab Then TPD" data-content="Tell a disabled borrower that s/he should rehab first then apply for TPD">Rehab Then TPD</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Payments Are Final" data-content="Tell the borrower that payment amounts and dates are final and cannot be changed">Payments Are Final</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Not Factual" data-content="State anything that is not factual including attributing to ED things that are not ED policy">Not Factual</a></th>
        <th class="tableColumnHead"></th>
        <th class="tableColumnHead"></th>
    </tr>
    <tr>     
        
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Rehab_Then_TPD_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Payments_Are_Final_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Not_Factual_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>  
    </tr> 
    </table>
</div>

<!--QC Consolidation Section-->
 <div id="pnlQCConsol">
 <table class="table">
        <tr>
            <th class="alert-success" colspan="5">QC Consolidation Review - Collectors MAY Say These Things </th> 
        </tr>
      <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="This is a New Loan" data-content="Collector explains that consolidation loan is a new loan">This is a new loan</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Credit Reporting" data-content="Collector explained credit bureau reporting and update to default trade line accurately">Credit reporting</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Fixed Interest Rates" data-content="Consolidation loans have a fixed interest rate which is weighted average of the interest rates rounded up to nearest eighth of a percent. Variable interest rate loans become fixed.  Over the life of the loan interest rates may be higher or lower">Fixed interest rates</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Capitalization" data-content="By consolidating, all interest, as well as collection costs equal to 2.78% of the combined principal and interest will become the principal balance of their new loan - thus, interest accrurals on their consolidation loan may be higher than on their defaulted loans">Capitalization</a></th>
      </tr>
      <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_New_Loan_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Credit_Reporting_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Interest_Rates_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Capitalization_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>                
     </tr>
     <tr>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Title IV Eligibility" data-content="Upon consolidation, the loans consolidated will no longer prevent the borrower from receiving additional Title IV financial aid">Title IV Eligibility</a></th> 
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Repayment Options" data-content="Direct Loans offers several different repayment plans to accomodate differing financial circumstances and can be changed due to changing financial situations to avoid delinquency">Repayment options</a></th>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Default" data-content="If the consolidation loan defaults, it will not be eligible for consolidation">Default</a></th>
         <th class="tableColumnHead">&nbsp;</th>
     </tr> 
      <tr>
         <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_TitleIV_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
          <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Repayment_Options_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Default_Accuracy" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td>
      </tr> 
     <tr>
         <td colspan="4"><strong>QC Comments:</strong><br />
            <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" CssClass="inputBox" Columns="100" Rows="6" TextMode="MultiLine" />
         </td>
     </tr>  
     <tr>
         <td colspan="4" align="center"><asp:Button ID="btnUpdateQCTier1" runat="server" Text="Update QC Tier1" CssClass="btn btn-lg btn-primary" OnClick="UpdateQCTier1_Click" /><br />
                         <asp:Label ID="lblUpdateConfirmQCTier1" runat="server" CssClass="alert-success" />
         </td>
     </tr> 
   </table>
     
 </div>
</asp:Panel>
<!--End QC Tier1-->

<!--Begin QC Tier2-->
<asp:Panel ID="pnlQCTier2" runat="server" BackColor="#CCCCFF">
  <table class="table">
        <tr>
            <th class="auto-style1" colspan="5">Tier 2 QC Assessment (Complete ONLY if you are doing a QC assessment of this review).</th> 
        </tr>
                
          <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Correct ID Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Correct ID Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Identified Itself Accuracy" data-content="Rep stated company name and reason for call">PCA Identified Itself Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Mini-Miranda Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Mini-Miranda Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Professional Tone Used Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Professional Tone Used Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Accurate Info Accuracy</a></th>
      </tr> 
      <tr>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_CorrectID_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_ProperlyIdentified_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_MiniMiranda_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
           <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Tone_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Accuracy_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
      </tr>
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Notepad Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Accurate Notepad Accuracy</a></th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Responsive Accuracy" data-content="Did the Loan Analyst score this metric correctly?">PCA Responsive Accuracy</a></th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Did the collector provide accurate Info about AWG?" data-content="Did the Loan Analyst score this metric correctly?">Accurate Info For AWG</a>?</th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Complaints Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Complaint Accuracy</a></th> 
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Exceeded Hold Time Accuracy" data-content="Did the PCA put the borrower on hold too long?">Exceeded Hold Time Accuracy</a></th>
      </tr>
      <tr>          
           
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Notepad_Accuracy2" CssClass="inputBox" runat="server">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList>
          </td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_PCAResponsive_Accuracy2" CssClass="inputBox" runat="server">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_AWGInfo_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>

          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlComplaint_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
         <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_ExceededHoldTime_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
              </asp:DropDownList></td>
      </tr>
      </table>

  <!--QC Rehab Section-->
  <div id="pnlQC2Rehab">
    <table class="table" id="tblRehabQC2">
    <!--Collector MUST say these things-->
    <tr>
        <th class="alert-success" colspan="5">QC Rehab Review - Collector MUST say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA Representative advise the consumer:  They can only rehabilitate loan(s) one time.  If they re-default on these loans after they rehabilitated them, they will not be able to rehabilitate them again" data-toggle="popover" href="#" title="Rehab Once">Rehab Once</a></th>
        <th class="tableColumnHead" colspan="1"><a data-content="Requires 9 payments over 10 months except Perkins (9 consecutive payments)" data-toggle="popover" href="#" title="9 Payments">9 Payments</a></th>
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA Representative inform the consumer:  Title IV eligibility is restored as long as you have no other federally defaulted student loans and meet all other student eligibility requirements.  However, before the loan(s) is rehabilitated you can apply for reinstatement after your 6th on-time consecutive monthly payment is made.  You can only reinstate eligibility in this way once and you have to continue making payments or you will lose eligibility again." data-toggle="popover" href="#" title="Title IV Eligibility">Title IV Eligibility</a></th>     
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA Representative mislead the consumer to believe that Rehabilitation removes all evidence of delinquency on the consumer’s credit report - PCA Manual states: The loan is no longer in default and ED requests that credit reporting agencies remove the record of default reported by ED. The credit update is normally reflected in the next monthly credit reporting cycle. ED does not request that credit reporting agencies remove or update any credit reporting done prior to default, including reporting of late payments.  If a Treasury offset pays your balance in full prior to completing the loan rehabilitation program, ED will not request that credit reporting agencies remove the default reported by ED from their credit report." data-toggle="popover" href="#" title="CBR removes the record of default">CBR removes the record of default</a></th>
        <th class="tableColumnHead" colspan="1"><a data-content="Did the PCA Representative Inform the consumer:  The loans included in this rehabilitation will be decertified for Treasury offset.  When beginning the rehabilitation program, if the loans included are already certified for offset, they will be offset until after they are transferred to the new servicer, entering into the rehabilitation program will not stop the offset." data-toggle="popover" href="#" title="TOP">TOP</a></th>    </tr>    
    <tr>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Rehab_Once_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Nine_Payments_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_TitleIV_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Credit_Reporting_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td> 
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_TOP_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>        
    </tr> 
    <tr>
        <th class="tableColumnHead"><a data-content="Did the PCA Representative Inform the consumer: FSA will stop any current garnishments on the loans being rehabilitated. However, prior to rehabilitating the loans, if they are on an active garnishment (the order of withholding, WG15, was sent to the employer) you may be able to suspend the garnishment on the loans included in the rehabilitation after the 5th on time payment is made as long as you meet all of the other requirements. (See section 2.5.1, “Suspending AWG for rehabilitation” and section 2.4, “REHABILITATION AGREEMENT LETTER (RAL)”  for what the requirements are for this benefit.)" data-toggle="popover" href="#" title="AWG">AWG</a></th>        
        <th class="tableColumnHead"><a data-content="Must continue making payments until transferred" data-toggle="popover" href="#" title="Continue Payments">Continue Payments</a></th>
        <th class="tableColumnHead"><a data-content="Did the PCA Representative inform the consumer:   Before completing the rehabilitation collection costs are charged on each payment made toward rehabilitation.  ED does not charge any collection costs on a loan after it is rehabilitated.  Once the loan is transferred to the new servicer, the collection costs will not be charged on the loan, unless you re-default." data-toggle="popover" href="#" title="Collection Charges Waived">Collection Charges Waived</a></th>
        <th class="tableColumnHead"><a data-content="Did the PCA Representative inform the consumer: The financial documents required in order to calculate the approved monthly payment amount for the rehabilitation program must be supplied before you are accepted into the program." data-toggle="popover" href="#" title="Financial Documents">Financial Documents</a></th>        
        <th class="tableColumnHead"><a data-content="Did the PCA Representative inform the consumer: A rehabilitation agreement letter (RAL) must be signed and returned and it must include the list of all eligible loans. (optional: After 60 days, the PCA may pursue involuntary repayment or choose to extend additional time for the borrower to return the RAL.)" data-toggle="popover" href="#" title="Rehab Agreement Letter">Rehab Agreement Letter</a></th>        
    </tr>
    <tr>
       <td class="tableColumnCell">
           <asp:DropDownList ID="ddlScore_AWG_Accuracy2" runat="server" CssClass="inputBox">
               <asp:ListItem Text="" Value=""></asp:ListItem>
               <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
               <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
               <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
           </asp:DropDownList>
        </td> 
        <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Continue_Payments_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Collection_Charges_Waived_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
        </td>
           <td class="tableColumnCell">
               <asp:DropDownList ID="ddlScore_Financial_Documents_Accuracy2" runat="server" CssClass="inputBox">
                   <asp:ListItem Text="" Value=""></asp:ListItem>
                   <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                   <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                   <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
               </asp:DropDownList>
        </td>
         <td class="tableColumnCell">
             <asp:DropDownList ID="ddlScore_Rehab_Agreement_Letter_Accuracy2" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value=""></asp:ListItem>
                 <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                 <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                 <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
             </asp:DropDownList>
        </td>         
       </tr>        

        <tr>
            <th class="tableColumnHead">Contact Us</th>
            <th class="tableColumnHead">&nbsp;</th>            
            <th class="tableColumnHead">&nbsp;</th>
            <th class="tableColumnHead">&nbsp;</th>
            <th class="tableColumnHead">&nbsp;</th>
        </tr>
        <tr>
        <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Contact_Us_Accuracy2" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value=""></asp:ListItem>
                <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList>
            </td>
        <td class="tableColumnCell">
            &nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>   
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>                    
    </tr>   
    <tr>
        <th class="alert-caution" colspan="6">QC Rehab Review - Collector MAY say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Pre-Default Payment Plans" data-content="After transfer eligible for pre-default payment plans">Eligible For Pre-Default Payment Plans</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Deferment/Forbearance" data-content="After transfer borrower may (not will) qualify for deferment of forbearance">Deferment/Forbearance</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="New Payment Schedule" data-content="Must work out new payment schedule with servicer">New Payment Schedule</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Reversed Payments" data-content="Reversed or NSF payments can jeopardize rehab">Reversed Payments</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Loans Transferred After 60 Days" data-content="Borrower must continue making payments until transferred to new servicer">Loans Transferred After 60 Days</a></th>
        <th class="tableColumnHead">&nbsp;</th>
    </tr>    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Eligible_Payment_Plans_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Deferment_Forb_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td> 
         <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_New_Payment_Schedule_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>        
       
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Reversed_Payments_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>  
        <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Loans_Transferred_After_60_Days_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
   <tr>
     <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Electronic Payments" data-content="Electronic payment methods such as credit or debit cards may be encouraged">Electronic Payments</a></th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>     <th class="tableColumnHead" colspan="1">&nbsp;</th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
     <th class="tableColumnHead" colspan="1">&nbsp;</th>
    </tr>
    <tr>
     <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Electronic_Payments_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td> 
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>        
    </tr>
    <tr>
        <th class="alert-danger" colspan="5">QC Rehab Review - Collector MUST NOT say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Delay Tax Return" data-content="Advise the borrower to delay filing tax return">Delay Tax Return</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="More Aid or Deferment" data-content="Tell the borrower that s/he will be eligible for Title IV, deferments forbearances">More Aid or Deferment</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Quote Collection Costs Waived" data-content="Quote an exact amount for collection costs that will be waived">Quote Collection Costs Waived</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="False Requirements" data-content="Impose requirements that are not required">False Requirements</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Avoid PIF" data-content="Talk them out of PIF or SIF if they are able and willing (can see the credit benefit of rehab)">Avoid PIF</a></th>
    </tr>
    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Delay_Tax_Reform_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_More_Aid_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Collection_Costs_Waived_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_False_Requirements_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Avoid_PIF_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>           
    </tr> 
    
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Rehab Then TPD" data-content="Tell a disabled borrower that s/he should rehab first then apply for TPD">Rehab Then TPD</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Payments Are Final" data-content="Tell the borrower that payment amounts and dates are final and cannot be changed">Payments Are Final</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Not Factual" data-content="State anything that is not factual including attributing to ED things that are not ED policy">Not Factual</a></th>
        <th class="tableColumnHead">&nbsp;</th>
        <th class="tableColumnHead">&nbsp;</th>
    </tr>
    <tr>     
        
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Rehab_Then_TPD_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Payments_Are_Final_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Not_Factual_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>  
    </tr> 
    </table>
</div>

<!--QC Consolidation Section-->
 <div id="pnlQC2Consol">
 <table class="table">
        <tr>
            <th class="alert-success" colspan="4">QC Consolidation Review - Collectors MAY Say These Things </th> 
        </tr>
      <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="This is a New Loan" data-content="Collector explains that consolidation loan is a new loan">This is a new loan</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Credit Reporting" data-content="Collector explained credit bureau reporting and update to default trade line accurately">Credit reporting</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Fixed Interest Rates" data-content="Consolidation loans have a fixed interest rate which is weighted average of the interest rates rounded up to nearest eighth of a percent. Variable interest rate loans become fixed.  Over the life of the loan interest rates may be higher or lower">Fixed interest rates</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Capitalization" data-content="By consolidating, all interest, as well as collection costs equal to 2.78% of the combined principal and interest will become the principal balance of their new loan - thus, interest accrurals on their consolidation loan may be higher than on their defaulted loans">Capitalization</a></th>
      </tr>
      <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_New_Loan_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Credit_Reporting_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Interest_Rates_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Capitalization_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>                
     </tr>
     <tr>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Title IV Eligibility" data-content="Upon consolidation, the loans consolidated will no longer prevent the borrower from receiving additional Title IV financial aid">Title IV Eligibility</a></th> 
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Repayment Options" data-content="Direct Loans offers several different repayment plans to accomodate differing financial circumstances and can be changed due to changing financial situations to avoid delinquency">Repayment options</a></th>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Default" data-content="If the consolidation loan defaults, it will not be eligible for consolidation">Default</a></th>
         <th class="tableColumnHead">&nbsp;</th>
     </tr> 
      <tr>
         <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_TitleIV_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
          <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Repayment_Options_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Default_Accuracy2" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="OK" Value="OK">OK</asp:ListItem>
                  <asp:ListItem Text="Error" Value="Error">Error</asp:ListItem>
                  <asp:ListItem Text="Other" Value="Other">Other</asp:ListItem>
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td>
      </tr> 
      <tr>
            <th class="alert-info" colspan="4">Incorrect Worksheets</th> 
       </tr>
      <tr>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Returned Entire Worksheet" data-content="Returned Entire Worksheet">Returned Entire Worksheet</a></th> 
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Returned Worksheet Once" data-content="Returned Worksheet Once">Returned Worksheet Once</a></th>
         <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Returned Worksheet Twice" data-content="Returned Worksheet Twice">Returned Worksheet Twice</a></th>
         <th class="tableColumnHead">&nbsp;</th>
     </tr> 
     <tr>
         <td class="tableColumnCell" colspan="1">
             <asp:DropDownList ID="ddlReturned_Worksheet_Entire" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="Yes" Value="Yes">Yes</asp:ListItem>
                  <asp:ListItem Text="No" Value="No">No</asp:ListItem>
        </asp:DropDownList></td>
         <td class="tableColumnCell" colspan="1">
             <asp:DropDownList ID="ddlReturned_Worksheet_Once" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="Yes" Value="Yes">Yes</asp:ListItem>
                  <asp:ListItem Text="No" Value="No">No</asp:ListItem>
        </asp:DropDownList></td>
         <td class="tableColumnCell" colspan="1">
             <asp:DropDownList ID="ddlReturned_Worksheet_Twice" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value=""></asp:ListItem>
                  <asp:ListItem Text="Yes" Value="Yes">Yes</asp:ListItem>
                  <asp:ListItem Text="No" Value="No">No</asp:ListItem>
        </asp:DropDownList></td>
         <td class="tableColumnCell" colspan="1">&nbsp;</td>
     </tr>
     <tr>
         <td colspan="4"><strong>QC Comments:</strong><br />
            <ASPNetSpell:SpellTextBox ID="txtComments2" runat="server" CssClass="inputBox" Columns="100" Rows="6" TextMode="MultiLine" />
         </td>
     </tr> 
     <tr>
         <td colspan="4" align="center"><asp:Button ID="btnUpdateQCTier2" runat="server" Text="Update QC Tier2" CssClass="btn btn-lg btn-primary" OnClick="UpdateQCTier2_Click" /><br />
                         <asp:Label ID="lblUpdateConfirmQCTier2" runat="server" CssClass="alert-success" />
         </td>
     </tr>  
   </table>
 </div>
</asp:Panel>
<!--End QC Tier2-->
      

 </div>
</div>
 <asp:Label ID="lblNewAssignmentID" runat="server" Visible="false" />
</asp:Content>

