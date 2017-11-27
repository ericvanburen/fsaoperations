<%@ Page Title="Add New PCA Issue" Language="VB" MasterPageFile="Site.master" AutoEventWireup="true" CodeFile="Issue_Add_PCA.aspx.vb" Inherits="Issues_Issue_Add_PCA" MaintainScrollPositionOnPostback="true" ValidateRequest="false" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js" type="text/javascript"></script>
    
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="scripts/scripts_PCA.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.0/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
    <script src="scripts/FileUpload.js" type="text/javascript"></script>

    <script type="text/javascript">
        // this updates the active tab on the navbar
        $(document).ready(function () {
            //Dashboard
            $('#navA0').removeClass("active");
            //Add Issue
            $('#navA1').addClass("active");
            //My Issues
            $('#navA2').removeClass("active");
            //Search Issues
            $('#navA3').removeClass("active");
            //Reports
            $('#navA4').removeClass("active");
            //Administration
            $('#navA5').removeClass("active");

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

    <style type="text/css">
        .progressbar {
            width: 300px;
            height: 21px;
        }

        .progressbarlabel {
            width: 300px;
            height: 21px;
            position: absolute;
            text-align: center;
            font-size: small;
        }
    </style>

       
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<!--Datasource for all of the Categories-->
<asp:SqlDataSource ID="dsCategories" runat="server" SelectCommand="p_AllCategories"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for all of the Source Org Names-->
<asp:SqlDataSource ID="dsSourceOrg" runat="server" SelectCommand="p_AllSourceOrg"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for all of the Affected Org Names-->
<asp:SqlDataSource ID="dsAffectedOrg" runat="server" SelectCommand="p_AllAffectedOrg"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for all of the Affected Org Names for PCAs-->
<asp:SqlDataSource ID="dsAffectedOrgPCA" runat="server" SelectCommand="p_AllAffectedOrg_PCA"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for all of the Affected Org Names for Servicers-->
<asp:SqlDataSource ID="dsAffectedOrgServicer" runat="server" SelectCommand="p_AllAffectedOrg_Servicer"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />
<h3>Add New PCA Issue</h3>
        

<!--First Window Basic Issue Data-->
<div class="panel panel-primary" id="pnlMainDiv">
  <div class="panel-heading" id="pnlMainDivHeading">
    <span class="panel-title"><asp:Label ID="lblIssueType" runat="server" Text="Select Issue Type" /> </span><span id="expanderSignMainDiv">-</span>
  </div>
  <div class="panel-body" id="pnlMainDivBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
        <tr>
            <td align="right"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The borrower's DMCS account number">Borrower Number</a></td>
            <td><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputbox" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Borrower Number is a required field" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Borrower Number must be 10 digits" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" ValidationExpression="\d{10}" Display="Dynamic" /></td>
            <td align="right"><a href="#" data-toggle="popover" title="Borrower's Name" data-content="The borrower's full name">Borrower Name</a></td>
            <td><asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" /></td>
            <td align="right"><a href="#" data-toggle="popover" title="eIMF #" data-content="The eIMF number associated with the complaint">eIMF #</a></td>
            <td><asp:TextBox ID="txteIMF" runat="server" CssClass="inputBox" Width="87px" /></td>
        </tr>
        
        <tr>
            <td align="right"><a href="#" id="lblDateReceived" CssClass="inputbox" data-animation="true" title="Date Received" data-toggle="popover" data-content="The date the issue was received by FSA">
                Date Received</a></td>
            <td><asp:TextBox ID="txtDateReceived" runat="server" CssClass="datepicker calendar" /><br />                                     
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Date Received is a required field *"
            ControlToValidate="txtDateReceived" Display="Dynamic" CssClass="alert-danger" /></td>
            <td align="right"><a href="#" data-toggle="popover" title="Issue Status" data-content="The current status of the issue">Issue Status</a></td>
            <td><asp:DropDownList ID="ddlIssueStatus" runat="server" CssClass="inputBox">
                <asp:ListItem Text="Open" Value="Open" Selected="True" />
                <asp:ListItem Text="Closed" Value="Closed" />
                <asp:ListItem Text="Deferred" Value="Deferred" />
                <asp:ListItem Text="Opened In Error" Value="Opened In Error" />
                <asp:ListItem Text="Agenda" Value="Agenda" />
            </asp:DropDownList></td>
            <td align="right"><a href="#" data-toggle="popover" title="Owner" data-content="The internal employee at FSA who owns the issue">Owner</a></td>
            <td><asp:DropDownList ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true">
            <asp:ListItem Text="" Value="" />                                
        </asp:DropDownList></td>
        </tr>

    <tr>        
        <td align="right"><a href="#" data-toggle="popover" title="Date Resolved" data-content="The date the issue was resolved or closed">Date Resolved</a></td>
        <td align="left"><asp:TextBox ID="txtDateResolved" runat="server" CssClass="datepicker calendar" /></td>
        <td align="right"><a href="#" data-toggle="popover" title="Due Date" data-content="The date that the issue is due to be closed. PCA issues are due 20 days from the date received. All others must be manually specified.">Due Date</a></td>
        <td align="left"><asp:TextBox ID="txtDueDate" runat="server" CssClass="datepicker calendar" /></td>
        <td align="right"><a href="#" data-toggle="popover" title="Follow-up Date" data-content="The date the issue is due for a follow-up">Follow-up Date</a></td>
        <td align="left"><asp:TextBox ID="txtFollowupDate" runat="server" CssClass="datepicker calendar" /></td>        
    </tr>
    <tr>
        <td colspan="3"><a href="#" data-toggle="popover" title="Issue Description" data-content="Please provide the details which describe this issue">Issue Description</a><br />
            <ASPNetSpell:SpellTextBox ID="txtIssueDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Height="100px" Width="100%" />
            <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtIssueDescription" /></td>
       <td colspan="3"><a href="#" data-toggle="popover" title="PCA Response/Your Comments" data-content="The PCA's response/comments on this issue">PCA Response/Your Comments</a><br />
          <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" CssClass="form-control" TextMode="MultiLine" Height="100px" Width="100%" />
            <ASPNetSpell:SpellButton ID="SpellButton2" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtComments" /></td>
    </tr>
    <tr>
       <td colspan="3"><a href="#" data-toggle="popover" title="Final Resolution" data-content="Please provide details on how this issue was resolved">Final Resolution</a><br /> 
            <ASPNetSpell:SpellTextBox ID="txtResolution" runat="server" CssClass="form-control" TextMode="MultiLine" Height="100px" Width="100%" />
            <ASPNetSpell:SpellButton ID="SpellButton3" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtResolution" /></td>
        <td colspan="3"><a href="#" data-toggle="popover" title="PCA Corrective Action" data-content="These are the steps the PCA took to address the source of the complaint">PCA Corrective Action</a><br /> 
            <ASPNetSpell:SpellTextBox ID="txtPCACorrectiveAction" runat="server" CssClass="form-control" TextMode="MultiLine" Height="100px" Width="100%" />
            <ASPNetSpell:SpellButton ID="SpellButton4" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtPCACorrectiveAction" /></td>
    </tr>   
   </table>
   </div>
</div>

<!--PCA Complaints-->
<div class="panel panel-primary" id="pnlPCAComplaints">
  <div class="panel-heading" id="pnlPCAComplaintsHeading">
      <span class="panel-title">PCA Complaint Details</span> <span id="expanderSignPCAComplaints">-</span>
  </div>
  <div class="panel-body" id="pnlPCAComplaintsBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
      
    <tr>    
    <td align="right"><a href="#" data-toggle="popover" title="Source Org Type" data-content="Please indicate what type of organization the issue originated from">Issue Source</a></td>
            <td>
        <asp:DropDownList ID="ddlSourceOrgType" runat="server" CssClass="inputBox">
            <asp:ListItem Text="" Value="" Selected="True" />
            <asp:ListItem Text="Attorney" Value="Attorney" />
            <asp:ListItem Text="BBB" Value="BBB" />
            <asp:ListItem Text="Borrower" Value="Borrower" />
            <asp:ListItem Text="CFPB" Value="CFPB" />
            <asp:ListItem Text="Congressional Office" Value="Congressional Office" />
            <asp:ListItem Text="FSA" Value="FSA" />
            <asp:ListItem Text="FSA-Ombudsman" Value="FSA-Ombudsman" />
            <asp:ListItem Text="Monitor Group-KC" Value="Monitor Group-KC" />
            <asp:ListItem Text="Other" Value="Other" />
            <asp:ListItem Text="PCA" Value="PCA" />
            <asp:ListItem Text="School" Value="School" />
            <asp:ListItem Text="Servicer" Value="Servicer" />
            <asp:ListItem Text="Student" Value="Student" />
            <asp:ListItem Text="Survey" Value="Survey" />
            <asp:ListItem Text="Third-Party" Value="Third-Party" />
        </asp:DropDownList><br />
       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Issue Source is a required field *"
        ControlToValidate="ddlSourceOrgType" Display="Dynamic" CssClass="alert-danger" />
        </td>
    <td align="right"><a href="#" data-toggle="popover" title="Affected Org/PCA" data-content="Please indicate which organization this issue impacts">PCA</a></td>       
             <td><asp:DropDownList ID="ddlAffectedOrgID" runat="server" DataSourceID="dsAffectedOrg" CssClass="inputBox" DataTextField="AffectedOrg" DataValueField="AffectedOrgID" AppendDataBoundItems="true">
            <asp:ListItem Text="" Value="" Selected="True" />            
        </asp:DropDownList><br />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* PCA is a required field *"
        ControlToValidate="ddlAffectedOrgID" Display="Dynamic" CssClass="alert-danger" />       
        </td>
    </tr>    
      
    <tr>    
    <td align="right"><a href="#" data-toggle="popover" title="Written/Verbal" data-content="Was the PCA complaint received in a written or verbal format?">Written/Verbal</a></td>
            <td><asp:DropDownList ID="ddlWrittenVerbal" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="Written" Value="Written" />
                 <asp:ListItem Text="Verbal" Value="Verbal" />                                 
             </asp:DropDownList></td>
    <td align="right"><a href="#" data-toggle="popover" title="Received By" data-content="The organization that received the complaint about the PCA">Received By</a></td>       
             <td><asp:DropDownList ID="ddlReceivedBy" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="PCA" Value="PCA" />
                 <asp:ListItem Text="PIC/Vangent" Value="PIC/Vangent" />
                 <asp:ListItem Text="Web" Value="Web" />
                 <asp:ListItem Text="ED" Value="ED" />
		 <asp:ListItem Text="ECS" Value="ECS" />
             </asp:DropDownList>       
        </td>
    </tr>    
    <tr>    
        <td align="right"><a href="#" data-toggle="popover" title="Severity" data-content="Insignificant is for one or two valid items in the complaint; Significant is for more than 2 valid items; Severe is for extreme unprofessionalism that would warrant removal from the contract; NA is to be used for invalid complaints">Severity</a></td>
            <td><asp:DropDownList ID="ddlSeverity" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="TBD" Value="TBD" />
                 <asp:ListItem Text="Insignificant" Value="Insignificant" />
                 <asp:ListItem Text="Significant" Value="Significant" />
                 <asp:ListItem Text="Severe" Value="Severe" />
                 <asp:ListItem Text="N/A" Value="N/A" />                 
             </asp:DropDownList>           
        </td> 
         <td align="right"><a href="#" data-toggle="popover" title="Collector Name" data-content="The name of the collector at the PCA that received the complaint. Please enter the first name and then the last name. More than one collector name may be added separated by a semicolon ;">Collector Name(s)</a></td>
             <td>
             <asp:TextBox ID="txtCollectorFirstName" runat="server" CssClass="inputBox defaultText" Title="First Name(s)" /><br />
             <asp:TextBox ID="txtCollectorLastName" runat="server" CssClass="inputBox defaultText" Title="Last Name(s)" />
         </td>
    </tr>   
    <tr>
        <td colspan="4"><hr /></td>
    </tr>     
    </table>
     
     <table>
     <tr>
        <td align="left" valign="top"><a href="#" data-toggle="popover" title="Complaint Type" data-content="The type of complaint about the PCA">Complaint Type</a></td>
     </tr>
     </table>

     <br />
     
     <table class="table">
        <tr>
            <td colspan="2" class="alert-success">Examples of unfair or unreasonable behavior</td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeA" runat="server" CssClass="inputBox" />A - Required a down payment to rehab a loan</td>
            <td><asp:DropDownList ID="ddlComplaintTypeA_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
        <td><asp:CheckBox ID="chkComplaintTypeB" runat="server" CssClass="inputBox" />B -Required electronic payments</td>
        <td><asp:DropDownList ID="ddlComplaintTypeB_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeC" runat="server" CssClass="inputBox" />C - Set up a borrower on loan rehabilitation when they had reason to believe that borrower is TPD</td>
            <td> <asp:DropDownList ID="ddlComplaintTypeC_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeD" runat="server" CssClass="inputBox" />D - Set up borrower for the loan rehabilitation program that have a “dNoRehab” tag in Titanium or who has only Pell Grant Overpayments</td>
            <td><asp:DropDownList ID="ddlComplaintTypeD_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeE" runat="server" CssClass="inputBox" />E - Advised borrower to delay a filing a tax return to avoid offset</td>
            <td><asp:DropDownList ID="ddlComplaintTypeE_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeF" runat="server" CssClass="inputBox" />F - Negotiated a lower payment if the borrower is willing to pay a higher amount</td>
            <td><asp:DropDownList ID="ddlComplaintTypeF_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeG" runat="server" CssClass="inputBox" />G - Talked the borrower out of wanting to PIF or SIF</td>
            <td><asp:DropDownList ID="ddlComplaintTypeG_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeH" runat="server" CssClass="inputBox" />H - Entered into rehab agreement with a borrower who is not eligible</td>
            <td><asp:DropDownList ID="ddlComplaintTypeH_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeI" runat="server" CssClass="inputBox" />I - Ignored signs that the borrower may qualify for discharge</td>
            <td><asp:DropDownList ID="ddlComplaintTypeI_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeJ" runat="server" CssClass="inputBox" />J - Special assistance unit not helpful or available</td>
            <td> <asp:DropDownList ID="ddlComplaintTypeJ_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" class="alert-success">Harassment or Intimidation</td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeK" runat="server" CssClass="inputBox" />K - Told borrower they can be criminally prosecuted because they will not pay this debt</td>
            <td><asp:DropDownList ID="ddlComplaintTypeK_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeL" runat="server" CssClass="inputBox" />L - Unauthorized payment made by the PCA</td>
            <td> <asp:DropDownList ID="ddlComplaintTypeL_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>        
        <tr>
            <td colspan="2" class="alert-success">False or Misleading Representation</td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeM" runat="server" CssClass="inputBox" />M - Stated that taxes will not be offset if a borrower enters into a repayment agreement or the rehabilitation loan program</td>
            <td><asp:DropDownList ID="ddlComplaintTypeM_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeN" runat="server" CssClass="inputBox" />N - Stated if account falls out of rehab it goes to AWG</td>
            <td><asp:DropDownList ID="ddlComplaintTypeN_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeO" runat="server" CssClass="inputBox" />O - Stated that borrower can set whatever payment amt after rehab</td>
            <td> <asp:DropDownList ID="ddlComplaintTypeO_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeP" runat="server" CssClass="inputBox" />P - Told borrower will qualify for Title IV aid or other benefits without verifying eligibility</td>
            <td><asp:DropDownList ID="ddlComplaintTypeP_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeQ" runat="server" CssClass="inputBox" />Q - Stated that borrower is not certified for offset when he or she is actually certified for offset</td>
            <td><asp:DropDownList ID="ddlComplaintTypeQ_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeR" runat="server" CssClass="inputBox" />R - Other Misstatement of ED policy</td>
            <td><asp:DropDownList ID="ddlComplaintTypeR_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeS" runat="server" CssClass="inputBox" />S - Any allegation of violation of the FDCPA</td>
            <td><asp:DropDownList ID="ddlComplaintTypeS_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeT" runat="server" CssClass="inputBox" />T - PCA did not represent itself as collection agency</td>
            <td><asp:DropDownList ID="ddlComplaintTypeT_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeU" runat="server" CssClass="inputBox" />U - PCA contacted wrong party more than once</td>
            <td><asp:DropDownList ID="ddlComplaintTypeU_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" class="alert-success">Incomplete or Inaccurate Information or PCA Practices</td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeV" runat="server" CssClass="inputBox" />V - Stated the payment amount cannot be negotiated</td>
            <td><asp:DropDownList ID="ddlComplaintTypeV_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" class="alert-success">Unnecessary Communication Concerning the Existence of a Debt Without Authorization</td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeW" runat="server" CssClass="inputBox" />W - Disclosure of info to a third party</td>
            <td><asp:DropDownList ID="ddlComplaintTypeW_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeX" runat="server" CssClass="inputBox" />X - Contacted borrower's employer after being told not to do so</td>
            <td><asp:DropDownList ID="ddlComplaintTypeX_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" class="alert-success">Unprofessional Behavior</td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeY" runat="server" CssClass="inputBox" />Y - Unprofessional behavior - unresponsive to borrowers needs</td>
            <td><asp:DropDownList ID="ddlComplaintTypeY_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeZ" runat="server" CssClass="inputBox" />Z - Unprofessional behavior - rude, argumentative</td>
            <td><asp:DropDownList ID="ddlComplaintTypeZ_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" class="alert-success">Other</td>            
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeZZ" runat="server" CssClass="inputBox" />ZZ - Other</td>
            <td><asp:DropDownList ID="ddlComplaintTypeZZ_Validity" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
      </table>
  </div>
</div>

<!--Attachments-->
<div class="panel panel-primary" id="pnlAttachments">
  <div class="panel-heading" id="pnlAttachmentsHeading">
    <span class="panel-title">Attachments</span> <span id="expanderSignAttachments">-</span>
  </div>
  <div class="panel-body" id="pnlAttachmentsBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
       <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload1" runat="server" /><asp:Button ID="btnAttachment1" runat="server" Text="Upload" CausesValidation="false" /><br />
        <asp:hiddenfield ID="lblAttachment1Number" runat="server" />
        <div id="progressbar1" class="progressbar">
          <div id="progresslabel1" class="progressbarlabel"></div>
      </div>
    </td>
   </tr>
   <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload2" runat="server" /><asp:Button ID="btnAttachment2" runat="server" Text="Upload" CausesValidation="false" /><br />
        <asp:hiddenfield ID="lblAttachment2Number" runat="server" />
        <div id="progressbar2" class="progressbar">
          <div id="progresslabel2" class="progressbarlabel"></div>
      </div>
    </td>
   </tr> 
   <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload3" runat="server" /><asp:Button ID="btnAttachment3" runat="server" Text="Upload" CausesValidation="false" /><br />
        <asp:hiddenfield ID="lblAttachment3Number" runat="server" />
        <div id="progressbar3" class="progressbar">
          <div id="progresslabel3" class="progressbarlabel"></div>
      </div>
    </td>
   </tr>  
   </table>
  </div>
</div>

<div align="center">
    <asp:Label runat="server" ID="lblInsertConfirm" CssClass="alert-success" /> <br /><br />
    <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-lg btn-primary" Text="Submit" OnClick="btnSubmit_Click" />
    <asp:Button runat="server" ID="btnAddAnother" CssClass="btn btn-lg btn-success" Text="Add Another Complaint" OnClick="btnAddAnother_Click" Visible="false" />
   </div> 
</asp:Content>

