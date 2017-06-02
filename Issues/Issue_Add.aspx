<%@ Page Title="Enter New Operations Issue" Language="VB" MasterPageFile="Site.master" AutoEventWireup="true" CodeFile="Issue_Add.aspx.vb" Inherits="Issues_Issue_Add" MaintainScrollPositionOnPostback="true" ValidateRequest="false" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="scripts/scripts.js" type="text/javascript"></script>
    <script src="scripts/IssueOwner_FSAGroup.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />

    <%--<style type="text/css">
        .divIssueStatus {
            width: 300px;
            height: 100px;
            border: 1px solid blue;
        }
    </style>--%>

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
<h3>Add New Issue</h3>
       <br />
       Select Issue Type:
       <asp:DropDownList ID="ddlIssueType" runat="server" CssClass="form-control" Width="300px">
            <asp:ListItem Text="" Value="" Selected="True" />
            <asp:ListItem Text="Liaisons" Value="Liaisons" />
            <asp:ListItem Text="Call Center" Value="Call Center" />
            <asp:ListItem Text="Escalated" Value="Escalated" />
        </asp:DropDownList> 
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Issue Type is a required field *"
            ControlToValidate="ddlIssueType" Display="Dynamic" CssClass="alert-danger" />
        <br />
     
<!--First Window Basic Issue Data-->
<div class="panel panel-primary" id="pnlMainDiv">
  <div class="panel-heading" id="pnlMainDivHeading">
    <span class="panel-title"><asp:Label ID="lblIssueType" runat="server" Text="Select Issue Type" /> </span><span id="expanderSignMainDiv">-</span>
  </div>

   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>        
        <td align="right"><a id="lblDateReceived" data-animation="true" href="#" title="Date Received" data-toggle="popover" data-content="The date the issue was received by FSA">
         Date Received</a>               
         </td>
        <td align="left">         
        <asp:TextBox ID="txtDateReceived" runat="server" CssClass="datepicker calendar" /><br />
                                     
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Date Received is a required field *"
        ControlToValidate="txtDateReceived" Display="Dynamic" CssClass="alert-danger" />        
       
        </td>
        
        <td align="right"><a href="#" data-toggle="popover" title="Issue Status" data-content="The current status of the issue">Issue Status</a></td>
        <td align="left"><asp:DropDownList ID="ddlIssueStatus" runat="server" CssClass="inputBox">
            <asp:ListItem Text="Open" Value="Open" Selected="True" />
            <asp:ListItem Text="Closed" Value="Closed" />
            <asp:ListItem Text="Deferred" Value="Deferred" />
            <asp:ListItem Text="Opened In Error" Value="Opened In Error" />
            <asp:ListItem Text="Agenda" Value="Agenda" />
        </asp:DropDownList>
            <div id="closeValidation" style="display: none"><a href="#" data-toggle="popover" title="Validation Required" data-content="Was validation required for this issue?">Was validation required for this issue?</a>
                <asp:DropDownList ID="ddlValidationRequired" runat="server" CssClass="inputBox">
                    <asp:ListItem Text="No" Value="No" />
                    <asp:ListItem Text="Yes" Value="Yes" />                    
                </asp:DropDownList>
            </div>
            <div id="accountsValidation" style="display: none"><a href="#" data-toggle="popover" title="Validation Accounts" data-content="How many accounts were validated for this issue?  ">How many accounts were validated for this issue?</a>
                <asp:TextBox ID="txtValidationAccounts" runat="server" CssClass="inputBox" Width="80px" />
            </div>
        </td>
    </tr>
      
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Owner" data-content="The internal employee at FSA who owns the issue">Owner</a></td>
        <td align="left"><asp:DropDownList ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true">
            <asp:ListItem Text="" Value="" />                                
        </asp:DropDownList></td>
        <td align="right"><a href="#" data-toggle="popover" title="Date Resolved" data-content="The date the issue was resolved or closed">Date Resolved</a></td>
        <td align="left"><asp:TextBox ID="txtDateResolved" runat="server" CssClass="datepicker calendar" /></td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Due Date" data-content="The date that the issue is due to be closed. PCA issues are due 20 days from the date received. All others must be manually specified.">Due Date</a></td>
        <td align="left">
        <asp:TextBox ID="txtDueDate" runat="server" CssClass="datepicker calendar" /></td>
        <td align="right"><a href="#" data-toggle="popover" title="Follow-up Date" data-content="The date the issue is due for a follow-up">Follow-up Date</a></td>
        <td align="left"><asp:TextBox ID="txtFollowupDate" runat="server" CssClass="datepicker calendar" /></td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Category" data-content="Your best estimate as what category this issue falls under">Category</a></td>
        <td align="left">
            <asp:DropDownList ID="ddlCategoryID" runat="server" DataSourceID="dsCategories" AppendDataBoundItems="true" 
            CssClass="inputBox" DataTextField="Category" DataValueField="CategoryID">
                <asp:ListItem Text="" Value="" Selected="True" />
            </asp:DropDownList></td>
        <td align="right"><a href="#" data-toggle="popover" title="Sub-Category" data-content="Your best estimate as what sub-category this issue falls under">Sub-Category</a></td>
        <td align="left"><asp:DropDownList ID="ddlSubCategoryID" runat="server" DataSourceID="dsCategories" AppendDataBoundItems="true" 
        CssClass="inputBox" DataTextField="Category" DataValueField="CategoryID">
            <asp:ListItem Text="" Value="" Selected="True" />            
        </asp:DropDownList></td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="FSA Group" data-content="The Department within FSA of the Issue's Owner">FSA Group</td>
        <td align="left">
            <asp:DropDownList ID="ddlFSAGroup" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Bus Ops" Value="Bus Ops" />
                <asp:ListItem Text="FMB Group" Value="FMB Group" />
                <asp:ListItem Text="FMB Topics" Value="FMB Topics" />
            </asp:DropDownList>
        </td>
        <td align="right">&nbsp;</td>
        <td align="left">&nbsp;</td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Issue Description" data-content="Please provide the details which describe this issue">Issue Description</a></td> 
        <td align="left" colspan="3">
            <ASPNetSpell:SpellTextBox ID="txtIssueDescription" runat="server" CssClass="form-control"
                TextMode="MultiLine" Width="80%" Height="100px"  />
            <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtIssueDescription" /></td>
    </tr>
    <tr>
       <td align="right"><a href="#" data-toggle="popover" title="Comments" data-content="Your comments on this issue">Comments</a></td> 
        <td align="left" colspan="3">
            <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" Width="80%" CssClass="form-control" TextMode="MultiLine" Height="250px" />
            <ASPNetSpell:SpellButton ID="SpellButton2" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtComments" /></td>
    </tr>
    <tr>
       <td align="right"><a href="#" data-toggle="popover" title="Resolution" data-content="Please provide details on how this issue was resolved">Resolution</a></td> 
        <td align="left" colspan="3">
            <ASPNetSpell:SpellTextBox ID="txtResolution" runat="server" Width="80%" CssClass="form-control" TextMode="MultiLine" Height="100px" />
            <ASPNetSpell:SpellButton ID="SpellButton3" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtResolution" /></td>
    </tr>    
   </table>
   </div>
</div>

<!--Issue Source-->
<div class="panel panel-primary" id="pnlIssueSource">
  <div class="panel-heading" id="pnlIssueSourceHeading">
    <span class="panel-title">Issue Source & Affected Organization</span> <span id="expanderSignIssueSource">-</span>
  </div>
  <div class="panel-body" id="pnlIssueSourceBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>        
        <td align="right"><a href="#" data-toggle="popover" title="Source Org Type" data-content="Please indicate what type of organization the issue originated from">Source Org Type</a></td>
        <td align="left">
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
        </asp:DropDownList>
        </td>
        <td align="right"><a href="#" data-toggle="popover" title="Source Org Name" data-content="Please indicate the organization name the issue originated from">Source Org Name</a></td>
        <td align="left">
        <asp:DropDownList ID="ddlSourceOrgID" runat="server" CssClass="inputBox" DataSourceID="dsSourceOrg" DataTextField="SourceOrg" DataValueField="SourceOrgID" AppendDataBoundItems="true">
            <asp:ListItem Text="" Value="" Selected="True" />            
        </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Source Name" data-content="The name of the individual the issue originated from">Source Name</a></td>
        <td align="left">
        <asp:TextBox ID="txtSourceName" runat="server" CssClass="inputBox" /></td>
        <td align="right"><a href="#" data-toggle="popover" title="Assigned To" data-content="Indicate the internal FSA person the issue has been assigned to">Assigned To</a></td>
        <td align="left">
        <asp:TextBox ID="txtOwner" runat="server" CssClass="inputBox" /></td>
    </tr> 
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Root Cause" data-content="Indicate the source cause of the issue">Root Cause</a></td> 
        <td align="left">
        <asp:DropDownList ID="ddlRootCause" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" Selected="True" />
                <asp:ListItem Text="Policy/Procedure" Value="Policy/Procedure" /> 
                <asp:ListItem Text="System" Value="System" />
                <asp:ListItem Text="Undetermined" Value="Undetermined" /> 
                <asp:ListItem Text="Workforce" Value="Workforce" />          
        </asp:DropDownList></td>
        <td align="right"><a href="#" data-toggle="popover" title="Affected Org/PCA" data-content="Please indicate which organization this issue impacts">Affected Org/PCA</a></td>
        <td align="left">
            <asp:DropDownList ID="ddlAffectedOrgID" runat="server" DataSourceID="dsAffectedOrg" CssClass="inputBox" DataTextField="AffectedOrg" DataValueField="AffectedOrgID" AppendDataBoundItems="true">
                <asp:ListItem Text="" Value="" Selected="True" />            
            </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Affected Org is a required field *"
            ControlToValidate="ddlAffectedOrgID" Display="Dynamic" CssClass="alert-danger" />

        </td>
    </tr>
   
    <tr>
        <td align="right" valign="top"><a href="#" data-toggle="popover" title="Sub Root Cause" data-content="Indicate the sub root cause of the issue">Sub Root Cause</a></td> 
        <td align="left" valign="top">
             <asp:DropDownList ID="ddlSubRootCause" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="Agenda" Value="Agenda" />
                 <asp:ListItem Text="Human Error" Value="" />
                 <asp:ListItem Text="Policy Clarification Needed" Value="Policy Clarification Needed" />
                 <asp:ListItem Text="Policy Constraint" Value="Policy Constraint" />
                 <asp:ListItem Text="Procedural Gap" Value="Procedural Gap" />
                 <asp:ListItem Text="Policy Needed" Value="Policy Needed" />
                 <asp:ListItem Text="Procedure Needed" Value="Procedure Needed" />
                 <asp:ListItem Text="System Configuration" Value="System Configuration" />
                 <asp:ListItem Text="System Flaw/Error" Value="System Flaw/Error" />
                 <asp:ListItem Text="System Inconsistencies" Value="System Inconsistencies" />
                 <asp:ListItem Text="System Limitation" Value="System Limitation" />
                 <asp:ListItem Text="Training Deficiency" Value="Training Deficiency" />
            </asp:DropDownList>

        </td>
       <td align="right"><a href="#" data-toggle="popover" title="Source Contact Info" data-content="The contact information (name, address, email, telephone) of the individual or organization reporting the issue">Source Contact Info</a></td> 
        <td align="left">
            <asp:TextBox ID="txtSourceContactInfo" runat="server" 
                Width="50%" TextMode="MultiLine" Height="100px" /></td>
    </tr>   
    </table>
  </div>
 </div>

<!--Liaison Issues-->
<div class="panel panel-primary" id="pnlLiaisonIssues">
 <div class="panel-heading" id="pnlLiaisonIssuesHeading">
      <span class="panel-title">Liaison Issue Details</span> <span id="expanderSignLiaisonIssues">-</span>
  </div>
  <div class="panel-body" id="pnlLiaisonIssuesBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>   
        <td align="right"><a href="#" data-toggle="popover" title="Responsible Area" data-content="The department or organization within FSA responsible for addressing the issue">Responsible Area</a></td>
        <td align="left"><asp:DropDownList ID="ddlResponsibleArea" runat="server" CssClass="inputBox">
            <asp:ListItem Text="" Value="" Selected="True" /> 
            <asp:ListItem Text="AES/PHEAA" Value="AES/PHEAA" />
            <asp:ListItem Text="Cornerstone" Value="Conerstone" />
            <asp:ListItem Text="ESA" Value="ESA" /> 
            <asp:ListItem Text="FedLoan" Value="FedLoan" /> 
            <asp:ListItem Text="FSA-Bus Ops" Value="FSA-Bus Ops" />
            <asp:ListItem Text="FSA-CFO" Value="FSA-CFO" /> 
            <asp:ListItem Text="FSA-CIO" Value="FSA-CIO" />
            <asp:ListItem Text="FSA-IC" Value="FSA-IC" /> 
            <asp:ListItem Text="FSA-Ombuds" Value="FSA-Ombuds" /> 
            <asp:ListItem Text="FSA-OpServ" Value="FSA-OpServ" />
            <asp:ListItem Text="FSA-PLI" Value="FSA-PLI" /> 
            <asp:ListItem Text="FSA-ProgMgt" Value="FSA-ProgMgt" />
            <asp:ListItem Text="FSA-Servicer Liaison" Value="FSA-Servicer Liaison" />
            <asp:ListItem Text="Granite State" Value="Granite State" />
            <asp:ListItem Text="Great Lakes" Value="Great Lakes" />
            <asp:ListItem Text="MOHELA" Value="MOHELA" /> 
            <asp:ListItem Text="N/A" Value="N/A" />
            <asp:ListItem Text="Navient" Value="Navient" />
            <asp:ListItem Text="Nelnet" Value="Nelnet" />
            <asp:ListItem Text="NNI" Value="NNI" />             
            <asp:ListItem Text="NSLDS" Value="NSLDS" /> 
            <asp:ListItem Text="Other" Value="Other" />
            <asp:ListItem Text="OSLA" Value="OSLA" />
            <asp:ListItem Text="SLMA" Value="SLMA" />
            <asp:ListItem Text="VSAC" Value="VSAC" />
            <asp:ListItem Text="Xerox" Value="Xerox" />           
        </asp:DropDownList></td>                 
      
           <td align="right"><a href="#" data-toggle="popover" title="CR Number" data-content="If this issue is associated with a CR, enter the CR number here">CR Number</a></td>
           <td align="left"><asp:TextBox ID="txtCRNumber" runat="server" /></td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Ultimate Source Type" data-content="">Ultimate Source Type</a></td>
        <td align="left">
        <asp:DropDownList ID="ddlUltimateSourceType" runat="server" CssClass="inputBox">
            <asp:ListItem Text="" Value="" Selected="True" />
            <asp:ListItem Text="Borrower" Value="Borrower" /> 
            <asp:ListItem Text="FSA" Value="FSA" /> 
            <asp:ListItem Text="NA" Value="NA" />  
            <asp:ListItem Text="School" Value="School" /> 
            <asp:ListItem Text="Servicer" Value="Servicer" />       
        </asp:DropDownList></td>
        <td align="right"><a href="#" data-toggle="popover" title="Ultimate Source Name" data-content="">Ultimate Source Name</a></td>
        <td align="left">
        <asp:TextBox ID="txtUltimateSourceName" runat="server" CssClass="inputBox" /></td>
    </tr> 
      
    <tr>        
        <td align="right"><a href="#" data-toggle="popover" title="# Borrowers Rating" data-content="A rating for the number of borrowers the issue impacts.  1 = 1-10; 2 = 11-100; 3 = 101-10,000; 4 = 10,001-100,000; 5 = 100,000+"># Borrowers Rating</a></td>
        <td align="left">
            <asp:DropDownList ID="ddlRatingBorrowers" runat="server">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
            </asp:DropDownList>
        </td>
        <td align="right"><a href="#" data-toggle="popover" title="# Borrowers Affected" data-content="An estimate of the number of borrowers affected by the issue"># of Borrowers Affected</a></td>
        <td align="left"><asp:TextBox ID="txtBorrowersAffected" runat="server" /></td>                         
    </tr>
    <tr>        
        <td align="right"><a href="#" data-toggle="popover" title="# Loans Rating" data-content="A rating for the number of loans the issue impacts.  1 = 1-10; 2 = 11-100; 3 = 101-10,000; 4 = 10,001-100,000; 5 = 100,000+"># Loans Rating</a></td>
        <td align="left"><asp:DropDownList ID="ddlRatingLoans" runat="server">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
            </asp:DropDownList></td>
        <td align="right"><a href="#" data-toggle="popover" title="# Loans Affected" data-content="An estimate of the number of loans affected by the issue"># of Loans Affected</a></td>
        <td align="left"><asp:TextBox ID="txtLoansAffected" runat="server" /></td>                         
    </tr>
    <tr>        
        <td align="right"><a href="#" data-toggle="popover" title="Financial Rating" data-content="A rating for the financial impact of the issue. 1 = < $1,000; 2 = $1,000-$10,000; 3 = $10,000-$100,000; 4 = $100,000-$1 million; 5 = $1 million+">Financial Rating</a></td>
        <td align="left"><asp:DropDownList ID="ddlRatingFinancial" runat="server">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
            </asp:DropDownList></td>
        <td align="right"><a href="#" data-toggle="popover" title="Financial Impact" data-content="An estimate of the financial impact of the issue in $">Financial Impact</a></td>
        <td align="left"><asp:TextBox ID="txtFinancialImpact" runat="server" /></td>                         
    </tr>
    <tr>
           <td align="right"><a href="#" data-toggle="popover" title="Affects FFEL Accounts?" data-content="Does this issue affect FFEL serviced accounts?">Affects FFEL Accounts?</a></td>
           <td align="left" colspan="3"><asp:DropDownList ID="ddlAffectFFEL" runat="server">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Yes" Value="Yes" />
                <asp:ListItem Text="No" Value="No" />
            </asp:DropDownList></td>
       </tr>
    </table>
  </div>


</div>

<!--Borrower Details-->
<div class="panel panel-primary" id="pnlBorrowerDetails">
  <div class="panel-heading" id="pnlBorrowerDetailsHeading">
    <span class="panel-title">Borrower Details</span> <span id="expanderSignBorrowerDetails">-</span>
  </div>
  <div class="panel-body" id="pnlBorrowerDetailsBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">  
        <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The borrower's DMCS account number">Borrower Number</a></td>           
                <td><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputbox defaultText" Title="0000000000" /><br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Borrower Number must be 10 digits" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" ValidationExpression="\d{10}" Display="Dynamic"   />
    </td>
     <td align="right"><a href="#" data-toggle="popover" title="Borrower's Name" data-content="The borrower's full name">Borrower Name</a></td>           
                <td><asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" />
            </td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Borrower/School Email" data-content="The borrower's or school's email address">Borrower/School Email</a></td>
        <td align="left"><asp:TextBox ID="txtBorrowerEmail" runat="server" /></td>
        <td align="right"><a href="#" data-toggle="popover" title="School Name" data-content="The school's name reporting the issue">School Name</a></td>
        <td align="left"><asp:TextBox ID="txtSchoolName" runat="server" /></td>
    </tr>
    <tr>           
        <td align="right"><a href="#" data-toggle="popover" title="Borrower/School Phone" data-content="The phone number of the borrower or school reporting the issue">Borrower/School Phone</a></td>
        <td align="left" colspan="3"><asp:TextBox ID="txtBorrowerSchoolPhone" runat="server" /></td>
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
    <td align="left"><asp:FileUpload ID="ImageUpload1" runat="server" /><br />
        <asp:Label ID="lblAttachment1" runat="server" />
    </td>
   </tr>
   <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload2" runat="server" /><br />
        <asp:Label ID="lblAttachment2" runat="server" />
    </td>
   </tr> 
   <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload3" runat="server" /><br />
        <asp:Label ID="lblAttachment3" runat="server" />
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

