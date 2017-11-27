<%@ Page Title="Issue Search - Liaisons" Language="VB" MasterPageFile="Site.master" AutoEventWireup="true" CodeFile="Issue_Search.aspx.vb" Inherits="Issues_Issue_Search_Liaisons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="scripts/scripts_search.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        // this updates the active tab on the navbar
        $(document).ready(function () {
            //Dashboard
            $('#navA0').removeClass("active");
            //Add Issue
            $('#navA1').removeClass("active");
            //My Issues
            $('#navA2').removeClass("active");
            //Search Issues
            $('#navA3').addClass("active");
            //Reports
            $('#navA4').removeClass("active");
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

<br />
<h3>Advanced Issue Search</h3>
Select Issue Type: 
<asp:DropDownList ID="ddlIssueType" runat="server" CssClass="inputBox">
    <asp:ListItem Text="PCA Complaints" Value="PCA" />
    <asp:ListItem Text="Liaisons" Value="Liaisons" />
    <asp:ListItem Text="Call Center" Value="Call Center" />
    <asp:ListItem Text="Escalated" Value="Escalated" />
    <asp:ListItem Text="All Types" Value="All Types" Selected="True" />
</asp:DropDownList> <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-md btn-primary" Text="Search" OnClick="btnSearch_Click" ClientIDMode="Static" />
<asp:Button runat="server" ID="btnSearchAgain" CssClass="btn btn-md btn-warning" Text="Search Again" Visible="false" OnClick="btnSearchAgain_Click"  />
<br />
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Issue Type is a required field *"
        ControlToValidate="ddlIssueType" Display="Dynamic" CssClass="alert-danger" />
<br />


<!--First Window Basic Issue Data-->
<div class="panel panel-primary" id="pnlMainDiv">
  <div class="panel-heading" id="pnlMainDivHeading">
    <span class="panel-title"><asp:Label ID="lblIssueType" runat="server" Text="Search Liaison Issues" /></span> <span id="expanderSignMainDiv">-</span>
  </div>
  <div class="panel-body" id="pnlMainDivBody">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>
        <td align="right">Issue ID</td>
        <td align="left" colspan="3"><asp:TextBox ID="txtIssueID" runat="server" /></td>
    </tr>
    
    <tr>        
        <td align="right">
        <!--Received Date-->
        Date Received</td>
        <td align="left">         
            <asp:TextBox ID="txtDateReceivedGreaterThan" runat="server" CssClass="datepicker calendar" /> (from)
            <asp:TextBox ID="txtDateReceivedLessThan" runat="server" CssClass="datepicker calendar" /> (to)            
        </td>
    
        <td align="right">Issue Status</td>
        <td align="left"><asp:ListBox ID="ddlIssueStatus" runat="server" CssClass="inputBox" SelectionMode="Multiple">
            <asp:ListItem Text="" Value="" Selected="True" />
            <asp:ListItem Text="Open" Value="Open" />
            <asp:ListItem Text="Closed" Value="Closed" />
            <asp:ListItem Text="Deferred" Value="Deferred" />
            <asp:ListItem Text="Opened In Error" Value="Opened In Error" />
            <asp:ListItem Text="Agenda" Value="Agenda" />
        </asp:ListBox></td>
    </tr>
    <tr>
        <td align="right">Owner</td>
        <td align="left"><asp:ListBox ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true" SelectionMode="Multiple">
                            <asp:ListItem Text="" Value="" />                                
                         </asp:ListBox></td>
        <td align="right">
        <!--Received Date-->
        Date Resolved </td>
        <td align="left">
            <asp:TextBox ID="txtDateResolvedGreaterThan" runat="server" CssClass="datepicker calendar" /> (from)
            <asp:TextBox ID="txtDateResolvedLessThan" runat="server" CssClass="datepicker calendar" /> (to)
       </td>
    </tr>
    <tr>
        <td align="right">Due Date
        <td align="left"><asp:TextBox ID="txtDueDate" runat="server" CssClass="datepicker calendar" /></td>
        <td align="right">Follow-up Date</td>
        <td align="left"><asp:TextBox ID="txtFollowupDate" runat="server" CssClass="datepicker calendar" /></td>
    </tr>
    <tr>
        <td align="right">Category</td>
        <td align="left">
            <asp:ListBox ID="ddlCategoryID" runat="server" DataSourceID="dsCategories" AppendDataBoundItems="true" 
            CssClass="inputBox" DataTextField="Category" DataValueField="CategoryID" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" Selected="True" />
            </asp:ListBox></td>
        <td align="right">Sub-Category</td>
        <td align="left"><asp:ListBox ID="ddlSubCategoryID" runat="server" SelectionMode="Multiple" DataSourceID="dsCategories" AppendDataBoundItems="true" 
        CssClass="inputBox" DataTextField="Category" DataValueField="CategoryID">
            <asp:ListItem Text="" Value="" Selected="True" />            
        </asp:ListBox></td>
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
        <td align="right">Source Org Type</td>
        <td align="left">
        <asp:ListBox ID="ddlSourceOrgType" runat="server" CssClass="inputBox" SelectionMode="Multiple">
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
        </asp:ListBox>
        </td>
        <td align="right">Source Org Name</td>
        <td align="left">
        <asp:DropDownList ID="ddlSourceOrgID" runat="server" CssClass="inputBox" DataSourceID="dsSourceOrg" DataTextField="SourceOrg" DataValueField="SourceOrgID" AppendDataBoundItems="true">
            <asp:ListItem Text="" Value="" Selected="True" />            
        </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td align="right">SourSource Name</td>
        <td align="left">
        <asp:TextBox ID="txtSourceName" runat="server" CssClass="inputBox" /></td>
        <td align="right">Assigned To</td>
        <td align="left">
        <asp:TextBox ID="txtOwner" runat="server" CssClass="inputBox" /></td>
    </tr> 
    <tr>
        <td align="right">Root Cause> 
        <td align="left">
        <asp:ListBox ID="ddlRootCause" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" Selected="True" />
                <asp:ListItem Text="Policy/Procedure" Value="Policy/Procedure" /> 
                <asp:ListItem Text="System" Value="System" />
                <asp:ListItem Text="Undetermined" Value="Undetermined" /> 
                <asp:ListItem Text="Workforce" Value="Workforce" />          
        </asp:ListBox></td>
        <td align="right">Affected Org</td>
        <td align="left">
        <asp:ListBox ID="ddlAffectedOrgID" runat="server" CssClass="inputBox" DataSourceID="dsSourceOrg" DataTextField="SourceOrg" DataValueField="SourceOrgID" 
        AppendDataBoundItems="true" SelectionMode="Multiple">
            <asp:ListItem Text="" Value="" Selected="True" />            
        </asp:ListBox></td>
    </tr>
   
    <tr>
       <td align="right">Source Contact Info</td> 
        <td align="left" colspan="3">
            <asp:TextBox ID="txtSourceContactInfo" runat="server" 
                Width="619px" TextMode="MultiLine" Height="50px" /></td>
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
    <td align="right"><!--ReceivedBy-->
        Received By </td>       
             <td><asp:ListBox ID="ddlReceivedBy" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                 <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="PCA" Value="PCA"  />
                 <asp:ListItem Text="PIC/Vangent" Value="PIC/Vangent" />
                 <asp:ListItem Text="Web" Value="Web" />
                 <asp:ListItem Text="ECS" Value="ECS" />
                 <asp:ListItem Text="ED" Value="ED" />
             </asp:ListBox>       
        </td>
        <td align="right">Collector Name</td>
             <td>
             <asp:TextBox ID="txtCollectorFirstName" runat="server" CssClass="inputBox defaultText" Title="First Name" /><br />
             <asp:TextBox ID="txtCollectorLastName" runat="server" CssClass="inputBox defaultText" Title="Last Name" />
         </td>                 
    </tr>    
    <tr>
    <td align="right">Written/Verbal</td>
            <td><asp:DropDownList ID="ddlWrittenVerbal" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="Written" Value="Written" />
                 <asp:ListItem Text="Verbal" Value="Verbal" />                                 
             </asp:DropDownList></td>
        <td align="right">Severity</td>
            <td><asp:DropDownList ID="ddlSeverity" runat="server" CssClass="inputBox">
                  <asp:ListItem Text="" Value="" Selected="True" />
                 <asp:ListItem Text="TBD" Value="TBD" />
                 <asp:ListItem Text="Insignificant" Value="Insignificant" />
                 <asp:ListItem Text="Significant" Value="Significant" />
                 <asp:ListItem Text="Severe" Value="Severe" />                 
             </asp:DropDownList>           
        </td> 
    </tr>   
    <tr>
        <td align="right">eIMF</td>
        <td><asp:TextBox ID="txteIMF" runat="server" CssClass="inputBox" /></td>
        <td align="right">&nbsp;</td>
        <td>&nbsp;</td> 
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
        <td align="right">Responsible Area</td>
        <td align="left" colspan="3"><asp:ListBox ID="ddlResponsibleArea" runat="server" CssClass="inputBox" SelectionMode="Multiple">
            <asp:ListItem Text="" Value="" Selected="True" />             
            <asp:ListItem Text="AES/PHEAA" Value="AES/PHEAA" />
            <asp:ListItem Text="Cornerstone" Value="Conerstone" />
            <asp:ListItem Text="EdFinancial-HESC" Value="EdFinancial-HESC" />
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
        </asp:ListBox></td>                 
    </tr>
    <tr>
        <td align="right">Ultimate Source Type</td>
        <td align="left">
        <asp:DropDownList ID="ddlUltimateSourceType" runat="server" CssClass="inputBox">
            <asp:ListItem Text="" Value="" Selected="True" />
            <asp:ListItem Text="Borrower" Value="Borrower" /> 
            <asp:ListItem Text="FSA" Value="FSA" /> 
            <asp:ListItem Text="NA" Value="NA" />  
            <asp:ListItem Text="School" Value="School" /> 
            <asp:ListItem Text="Servicer" Value="Servicer" />        
        </asp:DropDownList></td>
        <td align="right">Ultimate Source Name</td>
        <td align="left">
        <asp:TextBox ID="txtUltimateSourceName" runat="server" CssClass="inputBox" /></td>
    </tr>
      
    <tr>        
        <td align="right"># Borrowers Rating</td>
        <td align="left">
            <asp:DropDownList ID="ddlRatingBorrowers" runat="server">
                <asp:ListItem Text="" Value="" Selected="True" />
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
            </asp:DropDownList>
        </td>
        <td align="right"># of Borrowers Affected</td>
        <td align="left"><asp:TextBox ID="txtBorrowersAffected" runat="server" /></td>                         
    </tr>
    <tr>        
        <td align="right"># Loans Rating</td>
        <td align="left"><asp:DropDownList ID="ddlRatingLoans" runat="server">
                <asp:ListItem Text="" Value="" Selected="True" />
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
            </asp:DropDownList></td>
        <td align="right"># of Loans Affected</td>
        <td align="left"><asp:TextBox ID="txtLoansAffected" runat="server" /></td>                         
    </tr>
    <tr>        
        <td align="right">Financial Rating</td>
        <td align="left"><asp:DropDownList ID="ddlRatingFinancial" runat="server">
                <asp:ListItem Text="" Value="" Selected="True" />
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
            </asp:DropDownList></td>
        <td align="right">Financial Impact</td>
        <td align="left"><asp:TextBox ID="txtFinancialImpact" runat="server" /></td>                         
    </tr>
    <tr>
           <td align="right">Affect FFEL Accounts?</td>
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
        <td align="right"><!--BorrowerNumber-->Borrower Number </td>           
                <td><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputbox" TabIndex="4" /><br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Borrower Number must be 10 digits" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" ValidationExpression="\d{10}" Display="Dynamic"   />
    </td>
     <td align="right"><!--BorrowerName-->Borrower Name </td>           
                <td><asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" TabIndex="3" />
            </td>
    </tr>
    <tr>
        <td align="right">School Name</td>
        <td align="left"><asp:TextBox ID="txtSchoolName" runat="server" colspan="3" /></td>    
    </tr>
   </table>
  </div>
 </div>

<!--Row Count Label and Export To Excel-->
 <div class="row">       
        <div class="col-lg-offset-5"><br />
            <asp:Button runat="server" ID="btnSearch2" CssClass="btn btn-md btn-primary" Text="Search" OnClick="btnSearch_Click" />
            <asp:Label ID="lblRowCount" runat="server" CssClass="alert-info" /> 
            <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
        </div>            
</div>

<br />
<a id="SearchResults"> </a>
 <asp:GridView ID="GridView1" runat="server" AllowSorting="false" OnRowDataBound="GridView1_RowDataBound" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView" DataKeyNames="IssueID">
        <Columns>
            <%--All Issues Columns 0-9--%>
            <asp:TemplateField HeaderText="Issue ID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="IssueType" HeaderText="Issue Type" SortExpression="IssueType" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateResolved" HeaderText="Date Resolved" SortExpression="DateResolved" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="IssueStatus" HeaderText="Issue Status" SortExpression="IssueStatus" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="IssueDescription" HeaderText="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="500px" />
		    <%--<asp:TemplateField HeaderText="Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"> 
             <ItemTemplate>
	            <%# If(Eval("Comments") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("Comments")))%> 
             </ItemTemplate>
             </asp:TemplateField>--%>
            <asp:BoundField DataField="UserID" HeaderText="Owner" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="FollowupDate" HeaderText="Followup Date" SortExpression="FollowupDate" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:d}" HtmlEncode="false" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                       
            <%--Issue Source Columns 10-16--%>    
             <asp:BoundField DataField="SourceOrg" HeaderText="Source Org" SortExpression="SourceOrg" HeaderStyle-HorizontalAlign="Center"  />
             <asp:BoundField DataField="SourceOrgType" HeaderText="Source Org Type" SortExpression="SourceOrgType" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="SourceName" HeaderText="SourceName" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 		     
		     <asp:BoundField DataField="Owner" HeaderText="Assigned To" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="RootCause" HeaderText="RootCause" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="AffectedOrg" HeaderText="Affected Org" SortExpression="AffectedOrg" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="SourceContactInfo" HeaderText="Source Contact Info" SortExpression="SourceContactInfo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

             <%--PCA Issues Columns 17-75---%>
             <asp:BoundField DataField="ReceivedBy" HeaderText="Received By" SortExpression="Received By" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="WrittenVerbal" HeaderText="Written/Verbal" SortExpression="WrittenVerbal" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="Severity" HeaderText="Severity" SortExpression="Severity" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="CollectorFirstName" HeaderText="Collector FName" SortExpression="CollectorFirstName" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />		                
             <asp:BoundField DataField="CollectorLastName" HeaderText="Collector LName" SortExpression="CollectorLastName" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             
            <asp:BoundField DataField="ComplaintTypeA" HeaderText="A - Required a down payment to rehab a loan" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeA_Validity" HeaderText="A - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 

            <asp:BoundField DataField="ComplaintTypeB" HeaderText="B - Required electronic payments" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeB_Validity" HeaderText="B - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                  
            <asp:BoundField DataField="ComplaintTypeC" HeaderText="C - Set up a borrower on loan rehabilitation when they had reason to believe that borrower is TPD" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeC_Validity" HeaderText="C - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeD" HeaderText="D - Set up borrower for the loan rehabilitation program that have a “dNoRehab” tag in Titanium or who has only Pell Grant Overpayments" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeD_Validity" HeaderText="D - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeE" HeaderText="E - Advised borrower to delay a filing a tax return to avoid offset" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeE_Validity" HeaderText="E - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeF" HeaderText="F - Negotiated a lower payment if the borrower is willing to pay a higher amount" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeF_Validity" HeaderText="F - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeG" HeaderText="G - Talked the borrower out of wanting to PIF or SIF" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeG_Validity" HeaderText="G - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeH" HeaderText="H - Entered into rehab agreement with a borrower who is not eligible" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeH_Validity" HeaderText="H - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeI" HeaderText="I - Ignored signs that the borrower may qualify for discharge" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeI_Validity" HeaderText="I - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeJ" HeaderText="J - Special assistance unit not helpful or available" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeJ_Validity" HeaderText="J - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeK" HeaderText="K - Told borrower they can be criminally prosecuted because they will not pay this debt" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeK_Validity" HeaderText="K - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeL" HeaderText="L - Unauthorized payment made by the PCA" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeL_Validity" HeaderText="L - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeM" HeaderText="M - Stated that taxes will not be offset if a borrower enters into a repayment agreement or the rehabilitation loan program" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeM_Validity" HeaderText="M - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeN" HeaderText="N - Stated if account falls out of rehab it goes to AWG" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeN_Validity" HeaderText="N - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeO" HeaderText="O - Stated that borrower can set whatever payment amt after rehab" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeO_Validity" HeaderText="O - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeP" HeaderText="P - Told borrower will qualify for Title IV aid or other benefits without verifying eligibility" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeP_Validity" HeaderText="P - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeQ" HeaderText="Q - Stated that borrower is not certified for offset when he or she is actually certified for offset" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeQ_Validity" HeaderText="Q - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeR" HeaderText="R - Misstatement of ED policy" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                
            <asp:BoundField DataField="ComplaintTypeR_Validity" HeaderText="R - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeS" HeaderText="S - Any allegation of violation of the FDCPA" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             
            <asp:BoundField DataField="ComplaintTypeS_Validity" HeaderText="S - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeT" HeaderText="T - PCA did not represent itself as collection agency" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                
            <asp:BoundField DataField="ComplaintTypeT_Validity" HeaderText="T - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeU" HeaderText="U - PCA contacted wrong party" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeU_Validity" HeaderText="U - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeV" HeaderText="V - Stated the payment amount cannot be negotiated" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeV_Validity" HeaderText="V - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeW" HeaderText="W - Disclosure of info to a third party" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeW_Validity" HeaderText="W - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeX" HeaderText="X - Contacted borrower's employer after being told not to do so" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeX_Validity" HeaderText="X - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeY" HeaderText="Y - Unprofessional behavior - unresponsive to borrowers needs" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeY_Validity" HeaderText="Y - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeZ" HeaderText="Z - Unprofessional behavior - rude, argumentative" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeZ_Validity" HeaderText="Z - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="ComplaintTypeZZ" HeaderText="ZZ - Other" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeZZ_Validity" HeaderText="ZZ - Validity" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

             <%--Liaison Issues 76-85 --%>
             <asp:BoundField DataField="ResponsibleArea" HeaderText="ResponsibleArea" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
             <asp:BoundField DataField="UltimateSourceType" HeaderText="UltimateSourceType" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="UltimateSourceName" HeaderText="UltimateSourceName" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="RatingBorrowers" HeaderText="Borrowers Rating" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
             <asp:BoundField DataField="BorrowersAffected" HeaderText="Borrowers Affected" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
             <asp:BoundField DataField="RatingLoans" HeaderText="Loans Rating" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />  
             <asp:BoundField DataField="LoansAffected" HeaderText="Loans Affected" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />    
             <asp:BoundField DataField="RatingFinancial" HeaderText="Rating Financial" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="FinancialImpact" HeaderText="Financial Impact" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             <asp:BoundField DataField="AffectFFEL" HeaderText="Affects FFEL Accounts?" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

        
            <%--Borrower Details Columns 86-88 --%>
            <asp:BoundField DataField="BorrowerNumber" HeaderText="BorrowerNumber" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="BorrowerName" HeaderText="BorrowerName" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="SchoolName" HeaderText="SchoolName" HeaderStyle-HorizontalAlign="Center" /> 

            <%--Misc Fields 89-91--%>
            <asp:BoundField DataField="FSAGroup" HeaderText="FSA Group" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="SubRootCause" HeaderText="SubRoot Cause" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="SubCategoryID" HeaderText="SubCategory" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />


            <asp:BoundField DataField="DateEntered" HeaderText="Date Entered" HeaderStyle-HorizontalAlign="Center" />
        </Columns>
</asp:GridView>

    <asp:Label ID="lblUserID" runat="server" Visible="false" />
</asp:Content>

