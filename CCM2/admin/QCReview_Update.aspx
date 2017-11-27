<%@ Page Title="QC Review Update" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="QCReview_Update.aspx.vb" Inherits="CCM2_admin_QCReview" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
    <script src="../../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .auto-style1 {
            font-size: 11pt;
            text-align: center;
            font-family: Calibri;
            background-color: #CCCCCC;
        }
        .question-background {
            background-color: #CCCCCC;
        }

        .score-textbox {
           text-align:center;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.score-textbox').change(function () {
                var QCScore;
                $('#MainContent_lblQCScore').text(parseFloat("0" + $('#MainContent_txtScore_Accuracy').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Evaluate2').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Evaluate3').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Evaluate4').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_MethodResolution').val()) + 
                    parseFloat("0" + $('#MainContent_txtScore_Escalated').val()) +
                    parseFloat("0" + $('#MainContent_txtScore_Grammar').val()));
                QCScore = $('#MainContent_lblQCScore').text();
                $('#MainContent_hiddenQCScore').val(QCScore);
            });            
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
        <ul id="nav">
            <li><a href="../Help.aspx">Help</a></li>
            <li><a href="#">Reports</a>
                <ul>
                    <li><a href="../MyProductivityReport.aspx">My Productivity</a></li>
                </ul>

            </li>
            <li><a href="../Search.aspx">Search</a></li>
            <li><a href="#">Administration</a>
                <ul>
                    <li><a href="ReportCallsMonitored.aspx">Call Center Count</a></li>
                    <li><a href="ReportFailedCalls.aspx">Failed Calls</a></li>
                    <li><a href="ReportAccuracy.aspx">Accuracy Report</a></li>
                    <li><a href="ReportIndividualProductivity.aspx">Productivity</a></li>
                    <li><a href="ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
                    <li><a href="Search.aspx">Search</a></li>
                    <li><a href="../ChecksSearch.aspx">Servicer Check Report</a></li>
                    <li><a href="QCReview_New.aspx">QC Review - Add</a></li>
                    <li><a href="QCReview_Search.aspx">QC Review - Search</a></li>
                </ul>
            </li>
            <li><a href="#">Monitoring</a>
                <ul>
                    <li><a href="../FormB.aspx">Enter Call</a></li>
                    <li><a href="../MyReviews.aspx">My Reviews</a></li>
                    <li><a href="../Checks.aspx">Add Servicer Check</a></li>                    
                </ul>
            </li>
        </ul>
    </div>


    <!--Users/Evaluators-->
    <asp:SqlDataSource ID="dsUserID" runat="server"
        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />

    <div style="padding-top: 40px;">
    <div class="panel panel-primary">
    <div class="panel-heading">
    <span class="panel-title">Quality Review Update</span>
  </div>  
    <div class="panel-body">
        <table width="95%" cellpadding="3" cellspacing="3">            
            <tr>        
                <th class="tableColumnHead" colspan="1">Review ID</th>
                <th class="tableColumnHead" colspan="1">Call Monitor</th>
                <th class="tableColumnHead" colspan="1">Call Center</th>
                <th class="tableColumnHead" colspan="1">Review Date</th>
                <th class="tableColumnHead" colspan="1">In/Outbound</th>
                <th class="tableColumnHead" colspan="1">Specialty Line</th>
            </tr>
            <tr>
                <td class="text-center"><asp:TextBox ID="txtReviewID" runat="server" Width="75px" />
                    <asp:Button ID="btnReviewIDLookup" runat="server" Text="Look up" OnClick="btnReviewIDLookup_Click" CausesValidation="false" CssClass="btn btn-default btn-xs" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtReviewID" />
                </td>
                <td class="text-center"><asp:Label ID="lblUserID" runat="server" /></td>
                <td class="text-center"><asp:Label ID="lblCallCenter" runat="server" /></td>
                <td class="text-center"><asp:Label ID="lblDateofReview" runat="server" /></td>
                <td class="text-center"><asp:Label ID="lblInboundOutbound" runat="server" /></td>
                <td class="text-center"><asp:Label ID="lblSpecialtyLine" runat="server" /></td>
            </tr>
        </table>
        <br /><br />
        <table width="95%" cellpadding="3" cellspacing="3">           
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">1.  Is the form completed accurately by completing all required QC elements (Call ID, Time of Review, Agent ID, Account Number, Name of Servicer, Type of Call, and Call Review Month after the Time of Review)? Did the monitor review a call for the assigned month and not a different month as dictated by the begin and end dates of review provided?</th>
                <th class="auto-style1" colspan="1">Points Possible</th>
                <th class="auto-style1" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtScore_Accuracy_Comments" runat="server" TextMode="MultiLine" Width="95%" /></td>
                <td>10.00</td>
                <td><asp:TextBox ID="txtScore_Accuracy" runat="server" CssClass="score-textbox" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtScore_Accuracy" />
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Enter a score from 0 to 10" ControlToValidate="txtScore_Accuracy" 
                    CssClass="warning" Display="Dynamic" MinimumValue="0" MaximumValue="10" Type="Integer" />
                </td>
            </tr>
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">2.  Did the monitor properly evaluate that the agent identified self, identified their company, and informed the caller that calls may be monitored and/or recorded for Quality Assurance purposes?</th>
                <th class="auto-style1" colspan="1">Points Possible</th>
                <th class="auto-style1" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtScore_Evaluate2_Comments" runat="server" TextMode="MultiLine" Width="95%" /></td>
                <td>5.00</td>
                <td><asp:TextBox ID="txtScore_Evaluate2" runat="server" CssClass="score-textbox" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtScore_Evaluate2" /> 
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Enter a score from 0 to 5" ControlToValidate="txtScore_Evaluate2" 
                    CssClass="warning" Display="Dynamic" MinimumValue="0" MaximumValue="5" Type="Integer" />
                </td>
            </tr>
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">3.  Did the monitor properly evaluate that the agent verified/updated the following Authentication/Demographics (Borrower Full Name, DOB, Street Address, Phone Number and Email Address)?</th>
                <th class="auto-style1" colspan="1">Points Possible</th>
                <th class="auto-style1" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtScore_Evaluate3_Comments" runat="server" TextMode="MultiLine" Width="95%" /></td>
                <td>5.00</td>
                <td><asp:TextBox ID="txtScore_Evaluate3" runat="server" CssClass="score-textbox" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtScore_Evaluate3" />
                    <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Enter a score from 0 to 5" ControlToValidate="txtScore_Evaluate3" 
                    CssClass="warning" Display="Dynamic" MinimumValue="0" MaximumValue="5" Type="Integer" />
                </td>
            </tr>
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">4.  Did the monitor properly evaluate the Professionalism, Accuracy and Urgency of the call (Politeness, Call Control, Accuracy of Information, Enunciating Words Clearly, and Encourage Fast Correspondence Turnaround)?</th>
                <th class="auto-style1" colspan="1">Points Possible</th>
                <th class="auto-style1" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtScore_Evaluate4_Comments" runat="server" TextMode="MultiLine" Width="95%" /></td>
                <td>10.00</td>
                <td><asp:TextBox ID="txtScore_Evaluate4" runat="server" CssClass="score-textbox" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtScore_Evaluate4" />
                    <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="Enter a score from 0 to 10" ControlToValidate="txtScore_Evaluate4" 
                    CssClass="warning" Display="Dynamic" MinimumValue="0" MaximumValue="10" Type="Integer" />
                </td>
            </tr>
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">5.  Did the monitor complete all of the required check boxes for the Method of Resolution in line with the Call Center Monitoring Standards? </th>
                <th class="auto-style1" colspan="1">Points Possible</th>
                <th class="auto-style1" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtScore_MethodResolution_Comments" runat="server" TextMode="MultiLine" Width="95%" /></td>
                <td>40.00</td>
                <td><asp:TextBox ID="txtScore_MethodResolution" runat="server" CssClass="score-textbox" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtScore_MethodResolution" />
                    <asp:RangeValidator ID="RangeValidator5" runat="server" ErrorMessage="Enter a score from 0 to 40" ControlToValidate="txtScore_MethodResolution" 
                    CssClass="warning" Display="Dynamic" MinimumValue="0" MaximumValue="40" Type="Integer" /></td>
            </tr>
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">6.  Did the call need to be escalated? (Further account review, Unprofessionalism, Recurring Issues with Agent, etc.)</th>
                <th class="auto-style1" colspan="1">Points Possible</th>
                <th class="auto-style1" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtScore_Escalated_Comments" runat="server" TextMode="MultiLine" Width="95%" /></td>
                <td>15.00</td>
                <td><asp:TextBox ID="txtScore_Escalated" runat="server" CssClass="score-textbox" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtScore_Escalated" />
                    <asp:RangeValidator ID="RangeValidator6" runat="server" ErrorMessage="Enter a score from 0 to 15" ControlToValidate="txtScore_Escalated" 
                    CssClass="warning" Display="Dynamic" MinimumValue="0" MaximumValue="15" Type="Integer" /></td>
            </tr>
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">7.  Were the comments grammatically correct, with complete sentences to thoroughly explain Discoveries, Notations and Special Circumstances? </th>
                <th class="auto-style1" colspan="1">Points Possible</th>
                <th class="auto-style1" colspan="1">Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtScore_Grammar_Comments" runat="server" TextMode="MultiLine" Width="95%" /></td>
                <td>15.00</td>
                <td><asp:TextBox ID="txtScore_Grammar" runat="server" CssClass="score-textbox" /><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" CssClass="warning" Display="Dynamic" 
                    ErrorMessage="* This is a required field * " ControlToValidate="txtScore_Grammar" />
                    <asp:RangeValidator ID="RangeValidator7" runat="server" ErrorMessage="Enter a score from 0 to 15" ControlToValidate="txtScore_Grammar" 
                    CssClass="warning" Display="Dynamic" MinimumValue="0" MaximumValue="15" Type="Integer" />
                </td>
            </tr>
            <tr>
                <th style="font-size: 11pt; text-align:left; font-family: Calibri;" colspan="1" class="question-background">Supervisor Final Comments</th>                
                <th class="auto-style1" colspan="1">Total Points Possible</th>
                <th class="auto-style1" colspan="1">Total Points Earned</th>
            </tr>
            <tr>
                <td><asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="95%" Height="75px" /></td>
                <td>100.00</td>
                <td style="background-color:lightgreen" class="text-center"><asp:Label ID="lblQCScore" runat="server" />
                    <input id="hiddenQCScore" type="hidden" runat="server" />
                </td>               
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Button ID="btnSaveReview" runat="server" Text="Update Review" OnClick="btnSaveReview_Click" CssClass="btn btn-warning" />
                    <asp:Button ID="btnDeleteReview" runat="server" Text="Delete Review" OnClick="btnDeleteReview_Click" OnClientClick="return confirm('Are you sure you want delete this QC Review?');" CssClass="btn btn-danger" CausesValidation="false" />
                    <br />
                    <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />
                </td>
            </tr>

        </table>     

     <asp:Label ID="lblQCID" runat="server" Visible="false" />                                     
    </div>
  </div>
</div>
</asp:Content>

