<%@ Page Title="PCA Monitoring - Review Details" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReviewDetail_Old.aspx.vb" Inherits="PCAReviews_ReviewDetail" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

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

      <%--<script type="text/javascript">
          $(document).ready(function () {
              //$("#pnlRehab").hide();
              $('select[id$=MainContent_ddlRehabTalkOff]').change(function () {
                  $("#pnlRehab").toggle();
              });
          });
      </script>

    <script type="text/javascript">
        $(function () {
            $('select[id$=MainContent_ddlRehabTalkOff]').change(function () {
                if (this.value == 'Yes') {    
                    $('div[id$=pnlRehab').show();         
                } else if (this.value == 'No') {
                    $('div[id$=pnlRehab').hide();
                }
                });
            });
     </script>--%>
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
        <li><a href="Reports.aspx">Save New PCA Review</a></li>
        <li><a href="Reports_SavedReports.aspx">Search PCA Reviews</a></li>       
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p><br /></p>

    <asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />
  
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Review Details - Review ID <asp:Label ID="lblReviewID" runat="server" /></span>
  </div>
  <div class="panel-body">
  <asp:Label ID="lblUserID" runat="server" Visible="false" />  
  <table class="table">
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Rehab Talk-Off?" data-content="Is this review a rehab talk=off?">Rehab Talk-Off?</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Call Date" data-content="The date the call was placed">Call Date</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="PCA" data-content="The PCA the review is for">PCA</a></th>     
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Review Period" data-content="The date the review was performed">Review Period</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The DMCS account number">Borrower Number</a></th>
    </tr>

      <tr>
            <td class="tableColumnCell">
                <asp:DropDownList ID="ddlRehabTalkOff" runat="server" CssClass="inputBox" TabIndex="1">
                    <asp:ListItem Selected="True">No</asp:ListItem>
                    <asp:ListItem>Yes</asp:ListItem>
                </asp:DropDownList>
                <br /></td>
            <td class="tableColumnCell">
            <asp:TextBox ID="txtCallDate" runat="server" CssClass="datepicker" TabIndex="2" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Call Date is a required field *"
                        ControlToValidate="txtCallDate" Display="Dynamic" CssClass="alert-danger" /></td>
            <td class="tableColumnCell">              
            <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="3" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID">
             </asp:DropDownList>
                 
            </td>
            <td class="tableColumnCell">                   
                Month: <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" TabIndex="4" CssClass="inputBox">
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
                Year: <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" TabIndex="5" CssClass="inputBox">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2015" Value="2015" Selected="True" />
                        <asp:ListItem Text="2016" Value="2016" />
                       </asp:DropDownList>  
                    <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Review Month is a required field *"
                    ControlToValidate="ddlReviewPeriodMonth" Display="Dynamic" CssClass="alert-danger" />

                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Review Year is a required field *"
                    ControlToValidate="ddlReviewPeriodYear" Display="Dynamic" CssClass="alert-danger" />
                 
            </td>
            <td class="tableColumnCell">                   
                <asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" TabIndex="6" /> <br /><input id="btnCheck" type="button" value="Check Borrower ID" class="btn btn-sm btn-primary" /><br />
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
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Call Type" data-content="The type of call that was placed to the PCA">Call Type</a></th>
      </tr>
        <tr>
            <td class="tableColumnCell">   
                <asp:TextBox ID="txtBorrowerLastName" runat="server" CssClass="inputBox" TabIndex="7" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Borrower Last Name is a required field *"
                    ControlToValidate="txtBorrowerLastName" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell">        
                <asp:TextBox ID="txtCallLength" runat="server" CssClass="inputBox" TabIndex="8" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="* Call Length is a required field *"
                    ControlToValidate="txtCallLength" Display="Dynamic" CssClass="alert-danger" />
                    <br />
            </td>
            <td class="tableColumnCell">
            <asp:TextBox ID="txtRecordingDeliveryDate" runat="server" CssClass="datepicker" TabIndex="9" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Recording Delivery Date is a required field *"
                    ControlToValidate="txtRecordingDeliveryDate" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell"> 
            <asp:DropDownList ID="ddlInOutBound" runat="server" CssClass="inputBox" TabIndex="10">
                    <asp:ListItem Text="Inbound" Value="Inbound" />
                    <asp:ListItem Text="Outbound" Value="Outbound" />
                </asp:DropDownList>
            </td>        
            <td class="tableColumnCell"> 
             <asp:DropDownList ID="ddlCallType" runat="server" CssClass="inputBox" TabIndex="11">
                <asp:ListItem Text="Borrower" Value="Borrower" />
                <asp:ListItem Text="3rd Party" Value="3rd Party" />
             </asp:DropDownList></td>        
        </tr>
         </table>
  <table class="table">
        <tr>
            <th class="alert-caution" colspan="5">Phone Review Rating Data</th> 
        </tr>
      <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Correct ID?" data-content="Did the collector call the borrower by the correct name?">Correct ID?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Mini-Miranda?" data-content="Did the collector mirandize the borrower when applicable?">Mini-Miranda?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Professional Tone Used?" data-content="Did the collector use a professional tone of voice with the borrower?">Professional Tone Used?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info?" data-content="Did the collector provide the borrower with accurate information?">Accurate Info Provided?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="" data-content=""></a><a href="#" data-toggle="popover" title="Accurate Notepad?" data-content="Did the collector update the DMCS notepad screen accurately?">Accurate Notepad?</a></th>
      </tr>

        <tr>
            <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_CorrectID" runat="server" CssClass="inputBox" TabIndex="12">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="* Required Field *" ControlToValidate="ddlScore_CorrectID" Display="Dynamic" CssClass="alert-danger" />
                </td>
            <td class="tableColumnCell">
                  <asp:DropDownList ID="ddlScore_MiniMiranda" runat="server" CssClass="inputBox" TabIndex="13">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList> <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Required Field *" ControlToValidate="ddlScore_MiniMiranda" Display="Dynamic" CssClass="alert-danger" />           
            </td>
            <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_Tone" runat="server" CssClass="inputBox" TabIndex="14">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="* Required Field *" ControlToValidate="ddlScore_Tone" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell">
                    <asp:DropDownList ID="ddlScore_Accuracy" runat="server" CssClass="inputBox" TabIndex="15">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList><br />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="* Required Field *" ControlToValidate="ddlScore_Accuracy" Display="Dynamic" CssClass="alert-danger" /></td>
            <td class="tableColumnCell">                    
                    <asp:DropDownList ID="ddlScore_Notepad" runat="server" CssClass="inputBox" TabIndex="16">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="* Required Field *" ControlToValidate="ddlScore_Notepad" Display="Dynamic" CssClass="alert-danger" />                 
                </td>
         </tr>
            <tr>
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Responsive?" data-content="Was the PCA responsive toward the borrower?">PCA Responsive?</a></th>
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Did the collector provide accurate Info about AWG?" data-content="">Accurate Info For AWG</a>?</th> 
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Complaint?" data-content="Did the borrower raise a complaint during the call?">Complaint?</a></th> 
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="IMF Submission Date" data-content="If the review was submitted by eIMF, the date it was submitted">IMF Submission Date</a></th> 
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="" data-content=""></a><a href="#" data-toggle="popover" title="Cmpt IMF Timely?" data-content="Was the IMF submitted timely?">Cmpt IMF Timely</a></th>
            </tr>
            <tr>
            <td class="tableColumnCell">                    
                <asp:DropDownList ID="ddlScore_PCAResponsive" runat="server" CssClass="inputBox" TabIndex="17">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="* Required Field *" ControlToValidate="ddlScore_PCAResponsive" Display="Dynamic" CssClass="alert-danger" />
                </td>
            <td class="tableColumnCell">
                <asp:DropDownList ID="ddlScore_AWGInfo" runat="server" CssClass="inputBox" TabIndex="18">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="* Required Field *" ControlToValidate="ddlScore_AWGInfo" Display="Dynamic" CssClass="alert-danger" />
            </td>
            <td class="tableColumnCell">
            <asp:DropDownList ID="ddlComplaint" runat="server" CssClass="inputBox" TabIndex="19">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
            </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="* Specify if there was a complaint *" Display="Dynamic" ControlToValidate="ddlComplaint" CssClass="alert-danger" />
                <br />
            </td>
            <td class="tableColumnCell">    
               <asp:TextBox ID="txtIMF_Submission_Date" runat="server" CssClass="datepicker" TabIndex="20" />
                </td>
            <td class="tableColumnCell">            
                <asp:DropDownList ID="ddlIMF_Timely" runat="server" CssClass="inputBox" TabIndex="21">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="Yes" />
                    <asp:ListItem Text="No" Value="No" />
                </asp:DropDownList></td>
        </tr>
        </table>

  <!--Rehab Section-->
  <div id="pnlRehab">
      <table class="table">
         <!--Collector MUST say these things-->
    <tr>
        <th class="alert-success" colspan="6">Rehab Ratings - Collector MUST say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Rehab Program" data-content="It is a loan rehabilitation program">Rehab Program</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Rehab Once" data-content="The borrower can only rehab once">Rehab Once</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="9 Payments" data-content="Requires 9 payments over 10 months except Perkins (9 consecutive payments)">9 Payments</a></th>     
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Loans Transferred After 60 Days" data-content="Loans will be transferred to servicer approximately 60 days after rehab">Loans Transferred After 60 Days</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Reversed Payments" data-content="Reversed or NSF payments can jeopardize rehab">Reversed Payments</a></th>                
        <th class="tableColumnHead" colspan="1">&nbsp;</th>
    </tr>    
    <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Rehab_Program" runat="server" TabIndex="22">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Rehab_Once" runat="server" TabIndex="23">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Nine_Payments" runat="server" TabIndex="24">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Loans_Transferred_After_60_Days" runat="server" TabIndex="25">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Reversed_Payments" runat="server" TabIndex="26">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>  
        <td class="tableColumnCell" colspan="1">&nbsp;</td>    
    </tr>

    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="TOP" data-content="TOP stops only after loans are transferred">TOP</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="AWG" data-content="Can prevent AWG but cannot stop current garnishment">AWG</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Continue Payments" data-content="Must continue making payments until transferred">Continue Payments</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="New Payment Schedule" data-content="Must work out new payment schedule with servicer">New Payment Schedule</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="TPD" data-content="If borrower indicates disability, help with TPD">TPD</a></th>
        <th class="tableColumnHead">&nbsp;</th>
    </tr>
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_TOP" runat="server" TabIndex="27">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_AWG" runat="server" TabIndex="28">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Continue_Payments" runat="server" TabIndex="29">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_New_Payment_Schedule" runat="server" TabIndex="30">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_TPD" runat="server" TabIndex="31">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">&nbsp;</td>
    </tr>
    <tr>
        <th class="alert-caution" colspan="6">Rehab Ratings - Collector MAY say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Pre-Default Payment Plans" data-content="After transfer eligible for pre-default payment plans">Eligible For Pre-Default Payment Plans</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Deferment/Forbearance" data-content="After transfer borrower may (not will) qualify for deferment of forbearance">Deferment/Forbearance</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Title IV Eligibility" data-content="After 6th payment borrower may regain Title IV eligibility if there are no other blocks">Title IV Eligibility</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Collection Charges Waived" data-content="At transfer remaining collection charges are waived">Collection Charges Waived</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="TOP Payment PIFs Account" data-content="If TOP payment PIFs account before rehab is complete, credit not cleared">TOP Payment PIFs Account</a></th>        
        <th class="tableColumnHead" colspan="1">&nbsp;</th>
    </tr>
    <tr>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Eligible_Payment_Plans" runat="server" TabIndex="32">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Deferment_Forb" runat="server" TabIndex="33">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TitleIV" runat="server" TabIndex="34">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Collection_Charges_Waived" runat="server" TabIndex="35">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TOP_Payment_PIFs_Account" runat="server" TabIndex="36">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td> 
        
    </tr>
    <tr>
        <th class="alert-danger" colspan="6">Rehab Ratings - Collector MUST NOT say these things</th> 
    </tr>
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Delay Tax Return" data-content="Advise the borrower to delay filing tax return">Delay Tax Return</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="More Aid or Deferment" data-content="Tell the borrower that s/he will be eligible for Title IV, deferments forbearances">More Aid or Deferment</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Collection Costs Waived" data-content="Quote an exact amount for collection costs that will be waived">Collection Costs Waived</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="False Requirements" data-content="Impose requirements that are not required">False Requirements</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Not Factual" data-content="State anything that is not factual including attributing to ED things that are not ED policy">Not Factual</a></th>
        <th class="tableColumnHead">&nbsp;</th>        
    </tr>
    
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Delay_Tax_Reform" runat="server" TabIndex="37">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_More_Aid" runat="server" TabIndex="38">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Collection_Costs_Waived" runat="server" TabIndex="39">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_False_Requirements" runat="server" TabIndex="40">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Not_Factual" runat="server" TabIndex="41">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell">&nbsp;</td>     
    </tr> 
    
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Unaffordable Payments" data-content="Set the borrower up on a payment lower than the amount s/he says s/he can afford">Unaffordable Payments</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Avoid PIF" data-content="Talk them out of PIF or SIF if they are able and willing (can see the credit benefit of rehab)">Avoid PIF</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Rehab Then TPD" data-content="Tell a disabled borrower that s/he should rehab first then apply for TPD">Rehab Then TPD</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Ineligible Borrower" data-content="Discuss rehab with a debtor who is not eligible for rehab">Ineligible Borrower</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Payments Are Final" data-content="Tell the borrower that payment amounts and dates are final and cannot be changed">Payments Are Final</a></th>
        <th class="tableColumnHead">&nbsp;</th>
    </tr>
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Unaffordable_Payments" runat="server" TabIndex="42">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Avoid_PIF" runat="server" TabIndex="43">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Rehab_Then_TPD" runat="server" TabIndex="44">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Ineligible_Borrower" runat="server" TabIndex="45">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Payments_Are_Final" runat="server" TabIndex="46">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">&nbsp;</td>
    </tr>                                           
    
    <tr>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="All negative information will be removed from your credit report" data-content="PCA falsely advised the borrower that all negative or derogatory information or trade lines will be removed from your credit report">All negative information will be <br />removed from credit report</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Credit report will look like you never defaulted" data-content="PCA falsely advised the borrower that his/her credit report will look like you never defaulted">Credit report will look like<br /> you never defaulted</a></th>
        <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Credit score will improve" data-content="PCA falsely advised the borrower that his/her credit score will improve">Credit score will improve</a></th>
        <th class="tableColumnHead">&nbsp;</th>
        <th class="tableColumnHead">&nbsp;</th>
        <th class="tableColumnHead">&nbsp;</th>
    </tr>
    <tr>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Credit_All_Negative_Data_Removed" runat="server" TabIndex="47">
        <asp:ListItem Text="" Value="" />
        <asp:ListItem Text="OK" Value="OK" />
        <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
        <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Credit_Never_Defaulted" runat="server" TabIndex="48">
        <asp:ListItem Text="" Value="" />
        <asp:ListItem Text="OK" Value="OK" />
        <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
        <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Credit_Score_Will_Improve" runat="server" TabIndex="49">
        <asp:ListItem Text="" Value="" />
        <asp:ListItem Text="OK" Value="OK" />
        <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
        <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
    </tr>
    </table>
  </div>
      <asp:Panel ID="pnlLAAccuracy" runat="server">
      <table class="table">
        <tr>
            <th class="alert-success" colspan="4">Loan Analyst Accuracy</th> 
        </tr>
       <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Correct ID Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Correct ID Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Mini-Miranda Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Mini-Miranda Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Professional Tone Used Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Professional Tone Used Accuracy</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Did the collector provide accurate Info about AWG?" data-content="Did the Loan Analyst score this metric correctly?">Accurate Info For AWG</a>?</th> 
      </tr> 
      <tr>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_CorrectID_Accuracy" runat="server" CssClass="inputBox" TabIndex="50">
                  <asp:ListItem>OK</asp:ListItem>
                  <asp:ListItem>Error</asp:ListItem>
                  <asp:ListItem>Other</asp:ListItem>
              </asp:DropDownList></td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_MiniMiranda_Accuracy" runat="server" CssClass="inputBox" TabIndex="51">
                  <asp:ListItem>OK</asp:ListItem>
                  <asp:ListItem>Error</asp:ListItem>
                  <asp:ListItem>Other</asp:ListItem>
              </asp:DropDownList>
          </td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Tone_Accuracy" runat="server" CssClass="inputBox" TabIndex="52">
                  <asp:ListItem>OK</asp:ListItem>
                  <asp:ListItem>Error</asp:ListItem>
                  <asp:ListItem>Other</asp:ListItem>
              </asp:DropDownList></td>

          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_AWGInfo_Accuracy" runat="server" CssClass="inputBox" TabIndex="53">
                  <asp:ListItem>OK</asp:ListItem>
                  <asp:ListItem>Error</asp:ListItem>
                  <asp:ListItem>Other</asp:ListItem>
              </asp:DropDownList></td>

      </tr>
      <tr>
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Accurate Info Accuracy</a></th>
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Notepad Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Accurate Notepad Accuracy</a></th> 
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Responsive Accuracy" data-content="Did the Loan Analyst score this metric correctly?">PCA Responsive Accuracy</a></th> 
                <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Complaints Accuracy" data-content="Did the Loan Analyst score this metric correctly?">Complaint Accuracy</a></th> 
      </tr>
      <tr>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlScore_Accuracy_Accuracy" runat="server" CssClass="inputBox" TabIndex="54">
                                <asp:ListItem>OK</asp:ListItem>
                                <asp:ListItem>Error</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList></td>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_Notepad_Accuracy" CssClass="inputBox" runat="server" TabIndex="55">
                                <asp:ListItem>OK</asp:ListItem>
                                <asp:ListItem>Error</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>  </td>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_PCAResponsive_Accuracy" CssClass="inputBox" runat="server" TabIndex="56">
                                <asp:ListItem>OK</asp:ListItem>
                                <asp:ListItem>Error</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList></td>
          <td class="tableColumnCell">
              <asp:DropDownList ID="ddlComplaint_Accuracy" runat="server" CssClass="inputBox" TabIndex="57">
                  <asp:ListItem>OK</asp:ListItem>
                  <asp:ListItem>Error</asp:ListItem>
                  <asp:ListItem>Other</asp:ListItem>
              </asp:DropDownList></td>
      </tr>
      </table>

      <table class="table">
       <tr>
            <th class="alert-danger" colspan="10">Rehab Errors Made By the Loan Analyst</th> 
        </tr> 
        <tr>
            <td><asp:CheckBoxList ID="cblRehabErrors" runat="server" RepeatColumns="5" /></td>
        </tr>
       </table>
      </asp:Panel>

      <table class="table">     
        <tr>
            <th class="alert-info" colspan="4">Comments</th> 
        </tr>

        <tr>
            <td valign="top"  colspan="2">
            <!--FSA Comments-->           
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Loan Analyst Comments" data-content="Comments provided by the FSA Loan Analyst">FSA Loan Analyst Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtFSA_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="58" />                
                <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Comments" />                        
           </td>
          
            <td valign="top" colspan="2">
            <!--FSA Supervisor Comments-->           
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Supervisor Comments" data-content="Comments provided by a FSA supervisor">FSA Supervisor Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtFSASupervisor_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="59" />                
                <ASPNetSpell:SpellButton ID="SpellButton4" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSASupervisor_Comments" />                      
           <br /></td>
           </tr>
           <tr>
            <td valign="top"  colspan="2"> 
            <!--PCA Comments-->          
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Comments" data-content="Comments provided the PCA">PCA Comments</a></label><br />            
                <ASPNetSpell:SpellTextBox ID="txtPCA_Comments" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="60" />
                <ASPNetSpell:SpellButton ID="SpellButton2" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtPCA_Comments" />              
          </td>
           <td valign="top" colspan="2"> <!--FSA_Conclusions-->          
            <label class="tableColumnHead"><a href="#" data-toggle="popover" title="FSA Conclusions" data-content="Conclusions reached by FSA">FSA Conclusions</a></label><br />           
                <ASPNetSpell:SpellTextBox ID="txtFSA_Conclusions" runat="server" CssClass="inputBox" Columns="60" Rows="6" TextMode="MultiLine" TabIndex="61" />                     
                 <ASPNetSpell:SpellButton ID="SpellButton3" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Conclusions" />             
           <br /></td>
        </tr>
        <tr>
            <td colspan="3" align="center"><br />
            <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="btn btn-lg btn-primary" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-lg btn-warning" Text="Cancel" />
            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-lg btn-danger" Text="Delete" OnClick="btnDelete_Click" CausesValidation="false" />
            <br /><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
            </td>
        </tr>

    </table>
  </div>
</div>
<asp:Label ID="lblReviewID2" runat="server" Visible="false" />
</asp:Content>

