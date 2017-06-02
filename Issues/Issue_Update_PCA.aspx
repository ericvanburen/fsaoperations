<%@ Page Title="" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="Issue_Update_PCA.aspx.vb" Inherits="Issues_Issue_Update_PCA" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="scripts/scripts_detail.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
   
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

            //Collapse the QC section by default
            $("#pnlQCBody").css("display", "none");
            $("#expanderSignQC").text("+")

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

<!--Datasource for Issue History-->
<asp:SqlDataSource ID="dsIssueHistory" runat="server" SelectCommand="p_IssueHistory"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>">
<SelectParameters>
    <asp:Parameter Name="IssueID" Type="Int32" />
</SelectParameters>
</asp:SqlDataSource>

<asp:Repeater id="Repeater1" runat="server">
<ItemTemplate>

<h3>Update PCA Issue</h3>
       
<!--First Window Basic Issue Data-->
<div class="panel panel-primary" id="pnlMainDiv">
  <div class="panel-heading" id="pnlMainDivHeading">
    <span class="panel-title"><asp:Label ID="lblIssueType" runat="server" Text="Select Issue Type" /> </span><span id="expanderSignMainDiv">-</span>
  </div>
  <div class="panel-body" id="pnlMainDivBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
        <tr>
        <td align="right">Issue ID</td>
        <td align="left"><asp:Label ID="lblIssueID" runat="server" Text='<%# Eval("IssueID")%>' /></td>
        <td align="right"><a href="#" data-toggle="popover" title="eIMF #" data-content="The eIMF number associated with the complaint">eIMF #</a></td>
        <td align="left"><asp:TextBox ID="txteIMF" runat="server" Text='<%# Eval("eIMF")%>' /></td></td>
        <td align="right"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The borrower's DMCS account number">Borrower Number</a></td>
        <td align="left"><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputbox" Text='<%# Eval("BorrowerNumber")%>' /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Borrower Number is a required field" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Borrower Number must be 10 digits" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" ValidationExpression="\d{10}" Display="Dynamic" />
       </td>
    </tr>
        <tr>
            <td align="right"><a href="#" data-toggle="popover" title="Borrower's Name" data-content="The borrower's full name">Borrower Name</a></td>
            <td align="left"><asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" Text='<%# Eval("BorrowerName")%>' /></td>
            <td align="right"><a href="#" id="lblDateReceived" CssClass="inputbox" data-animation="true" title="Date Received" data-toggle="popover" data-content="The date the issue was received by FSA">Date Received</a></td>
            <td align="left"><asp:TextBox ID="txtDateReceived" runat="server" CssClass="datepicker calendar" Text='<%# Eval("DateReceived")%>' /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Date Received is a required field *"
            ControlToValidate="txtDateReceived" Display="Dynamic" CssClass="alert-danger" /></td>    
            <td align="right"><a href="#" data-toggle="popover" title="Issue Status" data-content="The current status of the issue">Issue Status</a></td>
            <td align="left">
                <asp:DropDownList ID="ddlIssueStatus" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("IssueStatus") %>'>
                <asp:ListItem Text="Open" Value="Open" Selected="True" />
                <asp:ListItem Text="Closed" Value="Closed" />
                <asp:ListItem Text="Deferred" Value="Deferred" />
                <asp:ListItem Text="Opened In Error" Value="Opened In Error" />
                <asp:ListItem Text="Agenda" Value="Agenda" />
        </asp:DropDownList></td>
    </tr>
    <tr>
        <td align="right"><a href="#" data-toggle="popover" title="Owner" data-content="The internal employee at FSA who owns the issue">Owner</a></td>
        <td align="left"><asp:DropDownList ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSource='<%# GetRoleUsers() %>' SelectedValue='<%# Eval("UserID")%>'>
            <asp:ListItem Text="" Value="" />                                
        </asp:DropDownList></td>
        <td align="right"><a href="#" data-toggle="popover" title="Date Resolved" data-content="The date the issue was resolved or closed">Date Resolved</a></td>
        <td align="left"><asp:TextBox ID="txtDateResolved" runat="server" CssClass="datepicker calendar" Text='<%# Eval("DateResolved")%>' /></td>
        <td align="right"><a href="#" data-toggle="popover" title="Due Date" data-content="The date that the issue is due to be closed. PCA issues are due 20 days from the date received. All others must be manually specified.">Due Date</a></td>
        <td align="left"><asp:TextBox ID="txtDueDate" runat="server" CssClass="datepicker calendar" Text='<%# Eval("DueDate")%>' /></td>
    </tr>     
    <tr>
        <td colspan="3"><a href="#" data-toggle="popover" title="Issue Description" data-content="Please provide the details which describe this issue">Issue Description</a><br /> 
            <ASPNetSpell:SpellTextBox ID="txtIssueDescription" runat="server" CssClass="form-control" Text='<%# Eval("IssueDescription")%>'
                TextMode="MultiLine"  Height="100px" Width="100%" />
            <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtIssueDescription" /></td>
       <td colspan="3"><a href="#" data-toggle="popover" title="PCA Response/Your Comments" data-content="The PCA's response/comments on this issue">PCA Response/Your Comments</a><br /> 
            <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" CssClass="form-control" TextMode="MultiLine"  Height="100px" Width="100%" Text='<%# Eval("Comments")%>' />
            <ASPNetSpell:SpellButton ID="SpellButton2" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtComments" /></td>
    </tr>
    <tr>
       <td colspan="3"><a href="#" data-toggle="popover" title="Final Resolution" data-content="Please provide details on how this issue was resolved">Final Resolution</a><br />
            <ASPNetSpell:SpellTextBox ID="txtResolution" runat="server" CssClass="form-control" TextMode="MultiLine"  Height="100px" Width="100%" Text='<%# Eval("Resolution")%>' />
            <ASPNetSpell:SpellButton ID="SpellButton3" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtResolution" /></td>
        <td colspan="3"><a href="#" data-toggle="popover" title="PCA Corrective Action" data-content="These are the steps the PCA took to address the source of the complaint">PCA Corrective Action</a><br /> 
            <ASPNetSpell:SpellTextBox ID="txtPCACorrectiveAction" runat="server" CssClass="form-control" TextMode="MultiLine"  Height="100px" Width="100%" Text='<%# Eval("PCACorrectiveAction") %>' />
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
        <asp:DropDownList ID="ddlSourceOrgType" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("SourceOrgType") %>'>
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
             <td><asp:DropDownList ID="ddlAffectedOrgID" runat="server" DataSourceID="dsSourceOrg" DataTextField="SourceOrg" DataValueField="SourceOrgID" AppendDataBoundItems="true" SelectedValue='<%# Eval("AffectedOrgID") %>'>
            <asp:ListItem Text="" Value="" Selected="True" />            
        </asp:DropDownList><br />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* PCA is a required field *"
        ControlToValidate="ddlAffectedOrgID" Display="Dynamic" CssClass="alert-danger" />      
        </td>
    </tr>    
      
    <tr>    
    <td align="right"><a href="#" data-toggle="popover" title="Written/Verbal" data-content="Was the PCA complaint received in a written or verbal format?">Written/Verbal</a></td>
            <td><asp:DropDownList ID="ddlWrittenVerbal" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("WrittenVerbal") %>'>
                 <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="Written" Value="Written" />
                 <asp:ListItem Text="Verbal" Value="Verbal" />                                 
             </asp:DropDownList></td>
    <td align="right"><a href="#" data-toggle="popover" title="Received By" data-content="The organization that received the complaint about the PCA">Received By</a></td>       
             <td><asp:DropDownList ID="ddlReceivedBy" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("ReceivedBy") %>'>
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
            <td><asp:DropDownList ID="ddlSeverity" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("Severity") %>'>
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
             <asp:TextBox ID="txtCollectorFirstName" runat="server" CssClass="inputBox defaultText" Title="First Name(s)" Text='<%# Eval("CollectorFirstName") %>' /><br />
             <asp:TextBox ID="txtCollectorLastName" runat="server" CssClass="inputBox defaultText" Title="Last Name(s)" Text='<%# Eval("CollectorLastName") %>' />
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
            <td><asp:CheckBox ID="chkComplaintTypeA" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeA")%>' />A - Required a down payment to rehab a loan</td>
            <td><asp:DropDownList ID="ddlComplaintTypeA_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeA_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
        <td><asp:CheckBox ID="chkComplaintTypeB" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeB")%>' />B - Required electronic payments</td>
        <td><asp:DropDownList ID="ddlComplaintTypeB_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeB_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeC" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeC")%>' />C - Set up a borrower on loan rehabilitation when they had reason to believe that borrower is TPD</td>
            <td> <asp:DropDownList ID="ddlComplaintTypeC_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeC_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeD" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeD")%>' />D - Set up borrower for the loan rehabilitation program that have a “dNoRehab” tag in Titanium or who has only Pell Grant Overpayments</td>
            <td><asp:DropDownList ID="ddlComplaintTypeD_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeD_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeE" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeE")%>' />E - Advised borrower to delay a filing a tax return to avoid offset</td>
            <td><asp:DropDownList ID="ddlComplaintTypeE_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeE_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeF" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeF")%>' />F - Negotiated a lower payment if the borrower is willing to pay a higher amount</td>
            <td><asp:DropDownList ID="ddlComplaintTypeF_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeF_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeG" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeG")%>' />G - Talked the borrower out of wanting to PIF or SIF</td>
            <td><asp:DropDownList ID="ddlComplaintTypeG_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeG_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeH" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeH")%>' />H - Entered into rehab agreement with a borrower who is not eligible</td>
            <td><asp:DropDownList ID="ddlComplaintTypeH_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeH_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeI" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeI")%>' />I - Ignored signs that the borrower may qualify for discharge</td>
            <td><asp:DropDownList ID="ddlComplaintTypeI_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeI_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeJ" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeJ")%>' />J - Special assistance unit not helpful or available</td>
            <td> <asp:DropDownList ID="ddlComplaintTypeJ_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeJ_Validity")%>'>
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
            <td><asp:CheckBox ID="chkComplaintTypeK" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeK")%>' />K - Told borrower they can be criminally prosecuted because they will not pay this debt</td>
            <td><asp:DropDownList ID="ddlComplaintTypeK_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeK_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeL" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeL")%>' />L - Unauthorized payment made by the PCA</td>
            <td> <asp:DropDownList ID="ddlComplaintTypeL_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeL_Validity")%>'>
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
            <td><asp:CheckBox ID="chkComplaintTypeM" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeM")%>' />M - Stated that taxes will not be offset if a borrower enters into a repayment agreement or the rehabilitation loan program</td>
            <td><asp:DropDownList ID="ddlComplaintTypeM_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeM_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeN" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeN")%>' />N - Stated if account falls out of rehab it goes to AWG</td>
            <td><asp:DropDownList ID="ddlComplaintTypeN_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeN_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeO" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeO")%>' />O - Stated that borrower can set whatever payment amt after rehab</td>
            <td><asp:DropDownList ID="ddlComplaintTypeO_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeO_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeP" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeP")%>' />P - Told borrower will qualify for Title IV aid or other benefits without verifying eligibility</td>
            <td><asp:DropDownList ID="ddlComplaintTypeP_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeP_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeQ" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeQ")%>' />Q - Stated that borrower is not certified for offset when he or she is actually certified for offset</td>
            <td><asp:DropDownList ID="ddlComplaintTypeQ_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeQ_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeR" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeR")%>' />R - Other Misstatement of ED policy</td>
            <td><asp:DropDownList ID="ddlComplaintTypeR_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeR_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeS" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeS")%>' />S - Any allegation of violation of the FDCPA</td>
            <td><asp:DropDownList ID="ddlComplaintTypeS_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeS_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeT" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeT")%>' />T - PCA did not represent itself as collection agency</td>
            <td><asp:DropDownList ID="ddlComplaintTypeT_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeT_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:CheckBox ID="chkComplaintTypeU" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeU")%>' />U - PCA contacted wrong party more than once</td>
            <td><asp:DropDownList ID="ddlComplaintTypeU_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeU_Validity")%>'>
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
            <td><asp:CheckBox ID="chkComplaintTypeV" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeV")%>' />V - Stated the payment amount cannot be negotiated</td>
            <td><asp:DropDownList ID="ddlComplaintTypeV_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeV_Validity")%>'>
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
            <td><asp:CheckBox ID="chkComplaintTypeW" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeW")%>' />W - Disclosure of info to a third party</td>
            <td><asp:DropDownList ID="ddlComplaintTypeW_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeW_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeX" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeX")%>' />X = Contacted borrower's employer after being told not to do so</td>
            <td><asp:DropDownList ID="ddlComplaintTypeX_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeX_Validity")%>'>
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
            <td><asp:CheckBox ID="chkComplaintTypeY" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeY")%>' />Y - Unprofessional behavior - unresponsive to borrowers needs</td>
            <td><asp:DropDownList ID="ddlComplaintTypeY_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeY_Validity")%>'>
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Pending" Value="Pending" />
            <asp:ListItem Text="Invalid" Value="Invalid" />
            <asp:ListItem Text="Undetermined" Value="Undetermined" />
            <asp:ListItem Text="Valid" Value="Valid" />
        </asp:DropDownList></td>
        </tr>
         <tr>
            <td><asp:CheckBox ID="chkComplaintTypeZ" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeZ")%>' />Z - Unprofessional behavior - rude, argumentative</td>
            <td><asp:DropDownList ID="ddlComplaintTypeZ_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeZ_Validity")%>'>
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
            <td><asp:CheckBox ID="chkComplaintTypeZZ" runat="server" CssClass="inputBox" Checked='<%# Eval("ComplaintTypeZZ")%>' />ZZ - Other</td>
            <td><asp:DropDownList ID="ddlComplaintTypeZZ_Validity" runat="server" SelectedValue='<%# Eval("ComplaintTypeZZ_Validity")%>'>
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
    <td align="left">
    <asp:FileUpload ID="ImageUpload1" runat="server" /><br />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Attachment1", "/Issues/FileHandler.ashx?fileName={0}")%>' Text='<%# Eval("Attachment1")%>' Target="_blank" />
    
    </td>
   </tr>
   <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload2" runat="server" /><br />
    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("Attachment2", "/Issues/FileHandler.ashx?fileName={0}") %>' Text='<%# Eval("Attachment2")%>' Target="_blank" />
    </td>
   </tr> 
   <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload3" runat="server" /><br />
    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl='<%# Eval("Attachment3", "/Issues/FileHandler.ashx?fileName={0}") %>' Text='<%# Eval("Attachment3")%>' Target="_blank" />
    </td>
   </tr>     
   </table>
  </div>
 </div>

<!--QC Section-->
<div class="panel panel-primary" id="pnlQC">
  <div class="panel-heading" id="pnlQCHeading">
    <span class="panel-title">QC</span> <span id="expanderSignQC">-</span>
  </div>
  <div class="panel-body" id="pnlQCBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5" border="0">
       <tr> 
           <td align="right"><a href="#" data-toggle="popover" title="Decision Correct?" data-content="Did the Loan Analyst make the correct decision?">Decision Correct?</a></td>
           <td align="left"><asp:DropDownList ID="ddlQCDecisionCorrect" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("QCDecisionCorrect")%>'>
                    <asp:ListItem Text="" Value="" />     
                    <asp:ListItem Text="Yes" Value="Yes" />
                    <asp:ListItem Text="No" Value="No" />
               </asp:DropDownList></td>
           <td align="right"><a href="#" data-toggle="popover" title="DMCS Updated Accurately?" data-content="Did the Loan Analyst update DMCS accurately?">DMCS Updated Accurately?</a></td>
           <td align="left"><asp:DropDownList ID="ddlQCDMCSUpdated" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("QCDMCSUpdated")%>'>
                    <asp:ListItem Text="" Value="" />     
                    <asp:ListItem Text="Yes" Value="Yes" />
                    <asp:ListItem Text="No" Value="No" />
               </asp:DropDownList></td>
           <td align="right"><a href="#" data-toggle="popover" title="FSA Operations Website Updated Accurately?" data-content="Did the Loan Analyst update the FSA Operations Website accurately?">FSA Operations Website Updated Accurately?</a></td>
           <td><asp:DropDownList ID="ddlQCFSAOperations" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("QCFSAOperations")%>'>
               <asp:ListItem Text="" Value="" />     
               <asp:ListItem Text="Yes" Value="Yes" />
                    <asp:ListItem Text="No" Value="No" />
               </asp:DropDownList></td>
           <td align="right"><a href="#" data-toggle="popover" title="Did PCA Submit eIMF Materials Timely?" data-content="Did PCA Submit eIMF Materials Timely?">Did PCA Submit eIMF Materials Timely?</a></td>
           <td><asp:DropDownList ID="ddlQCeIMF" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("QCeIMF")%>'>
               <asp:ListItem Text="" Value="" />     
               <asp:ListItem Text="Yes" Value="Yes" />
                    <asp:ListItem Text="No" Value="No" />
               </asp:DropDownList></td>            
       </tr>
       <tr>
           <td align="right"><a href="#" data-toggle="popover" title="Supervisor QC Comments" data-content="Comments from your supervisor on QC issues">Supervisor Comments</a></td>
           <td colspan="5">
               <asp:TextBox ID="txtQCSupervisorComments" TextMode="MultiLine" Width="80%" CssClass="form-control" Height="100px" runat="server" Text='<%# Eval("QCSupervisorComments")%>' /></td>
       </tr>
       <tr>
           <td align="right"><a href="#" data-toggle="popover" title="Employee QC Comments" data-content="Comments from the employee on QC issues">Employee Comments</a></td>
           <td colspan="5">
               <asp:TextBox ID="txtQCEmployeeComments" TextMode="MultiLine" Width="80%" CssClass="form-control" Height="100px" runat="server" Text='<%# Eval("QCEmployeeComments")%>' /></td>
       </tr>
    </table>
</div>
</div>

 <!--Issue History-->
<div class="panel panel-primary" id="pnlHistory">
  <div class="panel-heading" id="pnlHistoryHeading">
    <span class="panel-title">Issue History</span> <span id="expanderSignHistory">-</span>
  </div>
  <div class="panel-body" id="pnlHistoryBody">
         <asp:GridView ID="GridView1" runat="server" AllowSorting="true" DataSourceID="dsIssueHistory" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView" DataKeyNames="IssueHistoryID">
        <Columns>
             <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="EnteredBy" HeaderText="Entered By" SortExpression="EnteredBy" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="EventType" HeaderText="Event Type" SortExpression="EventType" HeaderStyle-HorizontalAlign="Center" />
             <asp:TemplateField HeaderText="Comments"> 
             <ItemTemplate>	             
                 <%# If(Eval("Comments") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("Comments")))%> 
             </ItemTemplate> 
             </asp:TemplateField>
            </Columns>
        </asp:GridView>
  </div>
 </div>   
<div align="center">
    <asp:Label runat="server" ID="lblInsertConfirm" CssClass="alert-success" /> <br /><br />
    <asp:Button runat="server" ID="btnUpdate" CssClass="btn btn-md btn-warning" Text="Update Issue" OnClick="btnUpdate_Click" />    
</div>
    
</div> 
</ItemTemplate>
</asp:Repeater>
</asp:Content>

