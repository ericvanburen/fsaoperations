<%@ Page Title="PCA Call Monitoring - Rehab Call Review Details" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RehabCallReviewDetail.aspx.vb" Inherits="PCACalls_RehabCallReviewDetail" MaintainScrollPositionOnPostback="true" %>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <%--<li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Enter New Review <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="NewReview.aspx">PCA Review</a></li>
        <li><a href="NewRehabReview.aspx">Rehab Review</a></li>
    </ul>
  </li>--%>

  <li class="dropdown active">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">PCA Phone Reviews</a></li>
        <li><a href="MyRehabReviews.aspx">Rehab Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
        <li><a href="SearchRehab.aspx">Rehab Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">PCA Reviews - One PCA</a></li>
        <li><a href="Reports_MultiPCA.aspx">PCA Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsRehab.aspx">Rehab Reviews - One PCA</a></li>
        <li><a href="ReportsRehab_MultiPCA.aspx">Rehab Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="ReportsRehabCallErrors.aspx">Rehab Reviews - LA Errors</a></li>
        <li><a href="MakeAssignments.aspx">Make New Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p> </p>


<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>" /> 

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Rehab Call Review Details</span>
  </div>
  <div class="panel-body">
     <table class="table">    
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Call Date" data-content="The date the call was recorded">Call Date</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="PCA" data-content="The PCA being reviewed">PCA</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The borrower's DMCS borrower number">Borrower Number</a></th>
        <th class="tableColumnHead" colspan="1">&nbsp;</th>
        <th class="tableColumnHead" colspan="1">&nbsp;</th>
        <th class="tableColumnHead" colspan="1">&nbsp;</th>
    </tr>
            
    <tr>
        <td valign="top" class="tableColumnCell" colspan="1">            
        <asp:TextBox ID="txtCallDate" runat="server" CssClass="datepicker" TabIndex="1" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Call Date is a required field *"
                    ControlToValidate="txtCallDate" Display="Dynamic" CssClass="alert-danger" /><br /></td>
        <td valign="top" class="tableColumnCell" colspan="1">                  
            <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID">
            </asp:DropDownList><br /></td>
        <td valign="top" class="tableColumnCell" colspan="1">                     
            <asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" TabIndex="3" /> <input id="btnCheck" type="button" value="Check Borrower ID" class="btn btn-sm btn-primary" /><br />
            <span id="response" class="alert-danger"><!-- Our message will be echoed out here --></span><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Borrower Number is a required field *"
                ControlToValidate="txtBorrowerNumber" Display="Dynamic" CssClass="alert-danger" /><br />          
        </td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td>
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Report Quarter" data-content="The fiscal quarter the review falls under">Report Quarter</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Report Year" data-content="The fiscal year the review falls under">Report Year</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Recording Delivery Date" data-content="The date the PCA call recording was assigned to the Loan Analyst">Recording Delivery Date</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Review Date" data-content="The date the review was performed">Review Date</a></th>
        <th class="tableColumnHead" colspan="1">&nbsp;</th>
        <th class="tableColumnHead" colspan="1">&nbsp;</th>
    </tr>          
    <tr>
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:DropDownList ID="ddlReportQuarter" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="1 (Oct, Nov, Dec)" Value="1" />
                <asp:ListItem Text="2 (Jan, Feb, Mar)" Value="2" />
                <asp:ListItem Text="3 (Apr, May, Jun)" Value="3" />
                <asp:ListItem Text="4 (Jul, Aug, Sep)" Value="4" />                    
            </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="* Specify a report quarter *" Display="Dynamic" ControlToValidate="ddlReportQuarter" CssClass="alert-danger" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">               
                <asp:DropDownList ID="ddlReportYear" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="2013" Value="2013" />
                <asp:ListItem Text="2014" Value="2014" />
                <asp:ListItem Text="2015" Value="2015" />
                <asp:ListItem Text="2016" Value="2016" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Specify a report year *" Display="Dynamic" ControlToValidate="ddlReportYear" CssClass="alert-danger" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:TextBox ID="txtRecordingDeliveryDate" runat="server" CssClass="datepicker" TabIndex="18" /> 
        </td> 
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:TextBox ID="txtReviewDate" runat="server" CssClass="datepicker" TabIndex="18" /> 
        </td>  
        <td class="tableColumnCell" colspan="1">&nbsp;</td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td>  
   </tr>
    
    <!--Collector MUST say these things-->
    <tr>
        <th class="alert-success" colspan="6">Collector MUST say these things</th> 
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
        <asp:DropDownList ID="ddlScore_Rehab_Program" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />            
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Rehab_Once" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Nine_Payments" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Loans_Transferred_After_60_Days" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Reversed_Payments" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
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
        <asp:DropDownList ID="ddlScore_TOP" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_AWG" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Continue_Payments" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_New_Payment_Schedule" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_TPD" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">&nbsp;</td>
    </tr>
    <tr>
        <th class="alert-caution" colspan="6">Collector MAY say these things</th> 
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
        <asp:DropDownList ID="ddlScore_Eligible_Payment_Plans" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Deferment_Forb" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TitleIV" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td> 
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_Collection_Charges_Waived" runat="server">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">
        <asp:DropDownList ID="ddlScore_TOP_Payment_PIFs_Account" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell" colspan="1">&nbsp;</td> 
        
    </tr>
    <tr>
        <th class="alert-danger" colspan="6">Collector MUST NOT say these things</th> 
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
        <asp:DropDownList ID="ddlScore_Delay_Tax_Reform" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_More_Aid" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Collection_Costs_Waived" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_False_Requirements" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Not_Factual" runat="server">
           <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
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
        <asp:DropDownList ID="ddlScore_Unaffordable_Payments" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Avoid_PIF" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Rehab_Then_TPD" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Ineligible_Borrower" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
            <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
            <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
            <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Payments_Are_Final" runat="server">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="OK" Value="OK" />
            <asp:ListItem Text="Error" Value="Error" />
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
        <asp:DropDownList ID="ddlScore_Credit_All_Negative_Data_Removed" runat="server">
        <asp:ListItem Text="" Value="" />
        <asp:ListItem Text="OK" Value="OK" />
        <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
        <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Credit_Never_Defaulted" runat="server">
        <asp:ListItem Text="" Value="" />
        <asp:ListItem Text="OK" Value="OK" />
        <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
        <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
        <td class="tableColumnCell">
        <asp:DropDownList ID="ddlScore_Credit_Score_Will_Improve" runat="server">
        <asp:ListItem Text="" Value="" />
        <asp:ListItem Text="OK" Value="OK" />
        <asp:ListItem Text="Error-Omission" Value="Error-Omission" />
        <asp:ListItem Text="Error-Misstatement" Value="Error-Misstatement" />
        <asp:ListItem Text="Error-Omission & Misstatement" Value="Error-Omission and Misstatement" />
        </asp:DropDownList></td>
    </tr>                                                   
    <tr>
        <th class="alert-info" colspan="6">Comments</th> 
    </tr>
    
    <tr>
        <td colspan="3" >
            <span class="style1">
        <label class="form-label">FSA Loan Analyst Comments:</label></span>
            <ASPNetSpell:SpellTextBox ID="txtFSA_Comments" runat="server" Columns="75" Rows="6" TextMode="MultiLine" />
            <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Comments" />             
        </td>
       <td colspan="3" >
            <span class="style1">
        <label class="form-label">FSA Supervisor Comments:</label></span>
            <ASPNetSpell:SpellTextBox ID="txtFSASupervisor_Comments" runat="server" Columns="75" Rows="6" TextMode="MultiLine" /><br />
            <ASPNetSpell:SpellButton ID="SpellButton4" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Comments" />             
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <span class="style1">
        <label class="form-label">PCA Comments:</label></span>
            <ASPNetSpell:SpellTextBox ID="txtPCA_Comments" runat="server" Columns="75" Rows="6" TextMode="MultiLine" />
            <ASPNetSpell:SpellButton ID="SpellButton2" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtPCA_Comments" />             
        </td>
       <td colspan="3">
            <span class="style1">
        <label class="style2">FSA Conclusions:</label></span>
            <ASPNetSpell:SpellTextBox ID="txtFSA_Conclusions" runat="server" Columns="75" Rows="6" TextMode="MultiLine" />
            <ASPNetSpell:SpellButton ID="SpellButton3" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtFSA_Conclusions" />             
        </td>                  
    </tr>
         <tr>
            <th class="alert-danger" colspan="10">Review Errors Made By the Loan Analyst</th> 
        </tr> 
        <tr>
            <td colspan="10"><asp:CheckBoxList ID="cblRehabErrors" runat="server" RepeatColumns="4" /></td>
        </tr>
         <tr>
           <td colspan="10" align="center"><br />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-lg btn-primary" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-lg btn-danger" Text="Delete" OnClick="btnDelete_Click" CausesValidation="false" />
            <br /><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
            </td>
        </tr>

</table>
</div>
</div>
<asp:Label ID="lblRehabCallID" runat="server" Visible="false" />
</asp:Content>

