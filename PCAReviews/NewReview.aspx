<%@ Page Title="New PCA Review" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="NewReview.aspx.vb" Inherits="PCAReviews_NewReview" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.checkAvailability.js" type="text/javascript"></script>
    <script src="js/form_validation.js" type="text/javascript"></script>
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
      <%--<script type="text/javascript">
          $(document).ready(function () {
              $("#pnlRehab").hide();
              $("#pnlConsol").hide();
              $('select[id$=MainContent_ddlRehabTalkOff]').change(function () {
                  $("#pnlRehab").toggle();
              });
              $('select[id$=MainContent_ddlConsolTalkOff]').change(function () {
                  $("#pnlConsol").toggle();
              });
          });
    </script>--%>

    
 
    <script type="text/javascript">
        //Score_Contact_Us in the rehab section is a required field if Rehab Talk-Off = Yes
        $(function () {
            $('select[id$=MainContent_ddlRehabTalkOff]').change(function () {
                if (this.value == 'Yes') {
                    $('#MainContent_ddlScore_Contact_Us').val('OK');                     
                }
            })
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
        function secondstotimestated() {
            //stated
            var secs = $('#MainContent_txtCallLength').val();;
            var t = new Date(1970, 0, 1);
            t.setSeconds(secs);
            var s = t.toTimeString().substr(0, 8);
            if (secs > 86399)
                s = Math.floor((t - Date.parse("1/1/70")) / 3600000) + s.substr(2);
            $('#MainContent_txtCallLength').val(s);
        }

        function secondstotimeactual() {
            //actual
            var secs = $('#MainContent_txtCallLengthActual').val();;
            var t = new Date(1970, 0, 1);
            t.setSeconds(secs);
            var s = t.toTimeString().substr(0, 8);
            if (secs > 86399)
                s = Math.floor((t - Date.parse("1/1/70")) / 3600000) + s.substr(2);
            $('#MainContent_txtCallLengthActual').val(s);
        }
    </script>
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
        <li><a href="QCUserManager.aspx">QC User Manager</a></li>
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
    <span class="panel-title">Enter New PCA Review</span>
  </div>
  <div class="panel-body">
  <asp:LoginName ID="lblUserID" runat="server" Visible="false" />
  
  <!--Borrower/Call Details--> 
  <table class="table" id="tblBorrowerDetails">
     <tr>        
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Initial Rehab/Consolidation Talk-Off?" data-content="Is this review a rehab or consolidation talk=off?">Initial Rehab/Consol Talk-Off?</a></th>
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
            <asp:TextBox ID="txtCallDate" runat="server" CssClass="datepicker" TabIndex="1" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Call Date is a required field *"
                        ControlToValidate="txtCallDate" Display="Dynamic" CssClass="alert-danger" /></td>
            <td class="tableColumnCell">              
            <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID">
             </asp:DropDownList>                 
            </td>
            <td class="tableColumnCell">                   
                Month: <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" TabIndex="3" CssClass="inputBox">
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
                Year: <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" TabIndex="4" CssClass="inputBox">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2015" Value="2015" />
                        <asp:ListItem Text="2016" Value="2016" />
                        <asp:ListItem Text="2017" Value="2017" />
                       </asp:DropDownList>  
                    <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Review Month is a required field *"
                    ControlToValidate="ddlReviewPeriodMonth" Display="Dynamic" CssClass="alert-danger" />

                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Review Year is a required field *"
                    ControlToValidate="ddlReviewPeriodYear" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell">                   
                <asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" TabIndex="5" /> <br /><input id="btnCheck" type="button" value="Check Borrower ID" class="btn btn-xs btn-primary" /><br />
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
                <asp:TextBox ID="txtBorrowerLastName" runat="server" CssClass="inputBox" TabIndex="6" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Borrower Last Name is a required field *"
                    ControlToValidate="txtBorrowerLastName" Display="Dynamic" CssClass="alert-danger" />
            </td>  
          <td class="tableColumnCell">        
                <asp:TextBox ID="txtCallLength" runat="server" CssClass="inputBox" TabIndex="7" /> (stated) <input id="btnConvertSecondsStated" title="Convert seconds" type="button" value="C" class="btn btn-xs btn-primary" onclick="secondstotimestated()" /><br />
                <asp:TextBox ID="txtCallLengthActual" runat="server" CssClass="inputBox" TabIndex="7" /> (actual) <input id="btnConvertSecondsActual" title="Convert seconds" type="button" value="C" class="btn btn-xs btn-primary" onclick="secondstotimeactual()" /><br />
                
                <asp:RegularExpressionValidator ID="rfdCallLength" runat="server" ControlToValidate="txtCallLength" Display="Dynamic" CssClass="alert-danger" ErrorMessage="Must be in the format hh:mm:ss" 
                    ValidationExpression="^(?:1[0-2]|0[0-9]):[0-5][0-9]:[0-5][0-9]$" /><br />
               <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="* Call Length is a required field *"
                    ControlToValidate="txtCallLength" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell">
            <asp:TextBox ID="txtRecordingDeliveryDate" runat="server" CssClass="datepicker" TabIndex="8" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Recording Delivery Date is a required field *"
                    ControlToValidate="txtRecordingDeliveryDate" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell"> 
            <asp:DropDownList ID="ddlInOutBound" runat="server" CssClass="inputBox" TabIndex="9">
                <asp:ListItem Text="" Value="" Selected="True" />    
                <asp:ListItem Text="Inbound" Value="Inbound" />
                <asp:ListItem Text="Outbound" Value="Outbound" />
                </asp:DropDownList>
            </td>        
            <td class="tableColumnCell"> 
             <asp:DropDownList ID="ddlCallType" runat="server" CssClass="inputBox" TabIndex="10">
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
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Identified Itself?" data-content="Rep stated company name and reason for call">PCA Identified Itself?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Mini-Miranda?" data-content="Did the collector mirandize the borrower when applicable?">Mini-Miranda?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Call Recording?" data-content="Did the collector inform the borrower that the call was being recorded?">Call Recording?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Professional Tone Used?" data-content="Did the collector use a professional tone of voice with the borrower?">Professional Tone Used?</a></th>
      </tr>
      <tr>
          <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_CorrectID" runat="server" CssClass="inputBox" TabIndex="11">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
          <td class="tableColumnCell">
                  <asp:DropDownList ID="ddlScore_ProperlyIdentified" runat="server" CssClass="inputBox" TabIndex="12">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>            
            </td>  
          <td class="tableColumnCell">
                  <asp:DropDownList ID="ddlScore_MiniMiranda" runat="server" CssClass="inputBox" TabIndex="13">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>
            </td> 
          <td class="tableColumnCell">
                  <asp:DropDownList ID="ddlScore_CallRecording" runat="server" CssClass="inputBox" TabIndex="14">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>
            </td>         
          <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_Tone" runat="server" CssClass="inputBox" TabIndex="15">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>
            </td>                     
      </tr>
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info?" data-content="Did the PCA provide accurate information to the caller?">Accurate Info Provided?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Notepad?" data-content="Did the collector update the DMCS notepad screen accurately?">Accurate Notepad?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Responsive?" data-content="Was the PCA responsive toward the borrower?">PCA Responsive?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info about AWG?" data-content="Did the collector provide accurate Info about AWG?">Accurate Info For AWG</a>?</th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Disconnect Borrower?" data-content="Did the PCA disconnect the borrower?">PCA Disconnect Borrower?</a></th>
      </tr>
      <tr>     
           <td class="tableColumnCell">
                    <asp:DropDownList ID="ddlScore_Accuracy" runat="server" CssClass="inputBox" TabIndex="16">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>       
          <td class="tableColumnCell">                    
                    <asp:DropDownList ID="ddlScore_Notepad" runat="server" CssClass="inputBox" TabIndex="16">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>                 
             </td>
           <td class="tableColumnCell">                    
                <asp:DropDownList ID="ddlScore_PCAResponsive" runat="server" CssClass="inputBox" TabIndex="17">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>
                </td>
            <td class="tableColumnCell">
                <asp:DropDownList ID="ddlScore_AWGInfo" runat="server" CssClass="inputBox" TabIndex="18">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>            
            </td>
         <td class="tableColumnCell">
            <asp:DropDownList ID="ddlScore_Disconnect_Borrower" runat="server" CssClass="inputBox" TabIndex="19">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
            </asp:DropDownList>
            </td>           
      </tr>
      <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Complaint?" data-content="Did the borrower raise a complaint during the call?">Complaint?</a></th>        
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="IMF Submission Date" data-content="If the review was submitted by eIMF, the date it was submitted">IMF Submission Date</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Cmpt IMF Timely?" data-content="Was the IMF submitted timely?">Cmpt IMF Timely</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Exceeded Hold Time" data-content="Did the PCA put the borrower on hold too long?">Exceeded Hold Time</a></th>
        <th class="tableColumnHead">&nbsp;</th>
        <th class="tableColumnHead">&nbsp;</th>
      </tr>
      <tr>    
          <td class="tableColumnCell">
            <asp:DropDownList ID="ddlComplaint" runat="server" CssClass="inputBox" TabIndex="20">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
            </asp:DropDownList>
         </td>
          <td class="tableColumnCell">    
               <asp:TextBox ID="txtIMF_Submission_Date" runat="server" CssClass="datepicker" TabIndex="21" />
                </td>
            <td class="tableColumnCell">            
                <asp:DropDownList ID="ddlIMF_Timely" runat="server" CssClass="inputBox" TabIndex="22">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="Yes" />
                    <asp:ListItem Text="No" Value="No" />
                </asp:DropDownList></td>
            <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_ExceededHoldTime" runat="server" CssClass="inputBox" TabIndex="23">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" Selected="True" />
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
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="TOP" data-content="Did the PCA Representative inform the consumer:  The loans included in this rehabilitation will be decertified for Treasury offset.  When beginning the rehabilitation program, if the loans included are already certified for offset, they will be offset until after they are transferred to the new servicer, entering into the rehabilitation program will not stop the offset.">TOP</a></th>
    </tr>    
    <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Rehab_Once" runat="server" TabIndex="24">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Nine_Payments" runat="server" TabIndex="25">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TitleIV" runat="server" TabIndex="26">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Credit_Reporting" runat="server" TabIndex="27">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TOP" runat="server" TabIndex="28">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>        
    </tr> 
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="AWG" data-content="Did the PCA Representative inform the consumer: FSA will stop any current garnishments on the loans being rehabilitated. However, prior to rehabilitating the loans, if they are on an active garnishment (the order of withholding, WG15, was sent to the employer) you may be able to suspend the garnishment on the loans included in the rehabilitation after the 5th on time payment is made as long as you meet all of the other requirements. (See section 2.5.1, “Suspending AWG for rehabilitation” and section 2.4, “REHABILITATION AGREEMENT LETTER (RAL)”  for what the requirements are for this benefit.)">AWG</a></th>        
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Continue Payments" data-content="Did the PCA Representative advise the consumer they have to keep making payments until the loan is transferred to the new servicer?">Continue Payments</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Collection Charges Waived" data-content="Did the PCA Representative inform the consumer:   Before completing the rehabilitation collection costs are charged on each payment made toward rehabilitation.  ED does not charge any collection costs on a loan after it is rehabilitated.  Once the loan is transferred to the new servicer, the collection costs will not be charged on the loan, unless you re-default.">Collection Charges Waived</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Financial Documents" data-content="Did the PCA Representative inform the consumer: The financial documents required in order to calculate the approved monthly payment amount for the rehabilitation program must be supplied before you are accepted into the program.">Financial Documents</a></th>        
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Rehab Agreement Letter" data-content="Did the PCA Representative inform the consumer: A rehabilitation agreement letter (RAL) must be signed and returned and it must include the list of all eligible loans. (optional: After 60 days, the PCA may pursue involuntary repayment or choose to extend additional time for the borrower to return the RAL.)">Rehab Agreement Letter</a></th>        
    </tr>
    <tr>
       <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_AWG" runat="server" TabIndex="29">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Continue_Payments" runat="server" TabIndex="30">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Collection_Charges_Waived" runat="server" TabIndex="31">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
           <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Financial_Documents" runat="server" TabIndex="32">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
         <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Rehab_Agreement_Letter" runat="server" TabIndex="33">
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
        <asp:DropDownList ID="ddlScore_Contact_Us" runat="server" TabIndex="34">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList>
        </td>
        <td class="tableColumnCell">&nbsp;</td>
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
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Loans Transferred After 60 Days" data-content="Loans will be transferred 60 days after rehab">Loans Transferred After 60 Days</a></th>
        <th class="tableColumnHead"> </th>
    </tr>    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Eligible_Payment_Plans" runat="server" TabIndex="35">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Deferment_Forb" runat="server" TabIndex="36">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td> 
         <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_New_Payment_Schedule" runat="server" TabIndex="37">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>        
       
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Reversed_Payments" runat="server" TabIndex="38">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>  
        <td class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlScore_Loans_Transferred_After_60_Days" runat="server" TabIndex="39">
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
        <asp:DropDownList ID="ddlScore_Electronic_Payments" runat="server" TabIndex="40">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell">&nbsp;</td>
        <td class="tableColumnCell">&nbsp;</td>
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
        <asp:DropDownList ID="ddlScore_Consol_New_Loan" runat="server" TabIndex="41">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Credit_Reporting" runat="server" TabIndex="42">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Interest_Rates" runat="server" TabIndex="43">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Capitalization" runat="server" TabIndex="44">
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
        <asp:DropDownList ID="ddlScore_Consol_TitleIV" runat="server" TabIndex="45">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
          <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Repayment_Options" runat="server" TabIndex="46">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Consol_Default" runat="server" TabIndex="47">
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
                <ASPNetSpell:SpellTextBox ID="txtFSA_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="48" />                
                <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Comments" />                        
           </td>
          
            <td valign="top" colspan="2">
            <!--FSA Supervisor Comments-->           
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Supervisor Comments" data-content="Comments provided by a FSA supervisor">FSA Supervisor Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtFSASupervisor_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="49" />                
                <ASPNetSpell:SpellButton ID="SpellButton4" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSASupervisor_Comments" />                      
           <br /></td>
           </tr>
           <tr>
            <td valign="top"  colspan="2"> 
            <!--PCA Comments-->          
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Comments" data-content="Comments provided the PCA">PCA Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtPCA_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="50" />
                <ASPNetSpell:SpellButton ID="SpellButton2" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtPCA_Comments" />              
          </td>
           <td valign="top" colspan="2"> <!--FSA_Conclusions-->          
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Conclusions" data-content="Conclusions reached by FSA">FSA Conclusions</a></label><br />           
                <ASPNetSpell:SpellTextBox ID="txtFSA_Conclusions" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="51" />                     
                 <ASPNetSpell:SpellButton ID="SpellButton3" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Conclusions" />             
           <br /></td>
        </tr>
        <tr>
            <td colspan="4" align="center"><br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-lg btn-primary" OnClick="btnSubmit_Click" TabIndex="52" />
            <asp:Button ID="btnUpdateAgain" runat="server" CssClass="btn btn-lg btn-success" Text="Enter Another Review" OnClick="btnSubmitAgain_Click" Visible="false" />
            <br /><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
            </td>
        </tr>

    </table>
 </div>
</div>
 <asp:Label ID="lblNewAssignmentID" runat="server" Visible="false" />
</asp:Content>

