<%@ Page Title="Assign New Reviews to Loan Analysts" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MakeAssignments.aspx.vb" Inherits="PCAReviews_Assignments_PCAReviews" %>

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
<br />

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">   
</asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Assign New Reviews to Loan Analysts</span>
  </div>
  <div class="panel-body">

<table cellpadding="3" cellspacing="4">    
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA" data-content="The PCA the review is for">1) Select the PCA: </a></label></td>      
        <td><asp:DropDownList ID="ddlPCAID" runat="server" TabIndex="1" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="true">
             <asp:ListItem Text="" Value="" />
             </asp:DropDownList><br />
       <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="ddlPCAID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a PCA *" /></td>
     </tr> 
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Loan Analyst" data-content="The Loan Analyst the reviews will be assigned to">2) Select the Loan Analyst to assign them to: </a></label></td>         
            <td><asp:DropDownList ID="ddlUserID" runat="server" TabIndex="2" AppendDataBoundItems="true">
               <asp:ListItem Text="" Value="" />                
               </asp:DropDownList><br />
               <asp:RequiredFieldValidator ID="rfd2" runat="server" ControlToValidate="ddlUserID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a Loan Analyst *" /></td>
      </tr>
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Phone Recording Delivery Date" data-content="The date the supervisor gave the Loan Analyst the recording of the PCA call">3) Enter a Phone Recording Delivery Date</a></label></td>
        <td><asp:TextBox ID="txtRecordingDeliveryDate" runat="server" CssClass="datepicker" Height="25px" TabIndex="3" /><br />
        <asp:RequiredFieldValidator ID="rfd3" runat="server" ControlToValidate="txtRecordingDeliveryDate" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter a phone recording delivery date *" /></td>
      </tr>
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Call Review Due Date" data-content="The date the call review is due">4) Call Review Due Date</a></label></td>
        <td><asp:TextBox ID="txtCallReviewDueDate" runat="server" CssClass="datepicker" Height="25px" TabIndex="4" /><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCallReviewDueDate" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter the call review due date *" /></td>
    </tr>
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Review Period Month/Year" data-content="The month and year that the review was performed">5) Review Period Month/Year</a></label></td>
        <td><asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" TabIndex="5" CssClass="inputBox">
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
            <asp:RequiredFieldValidator ID="rfd5" runat="server" ControlToValidate="ddlReviewPeriodMonth" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a review month *" />

            <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" TabIndex="5" CssClass="inputBox">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2016" Value="2016" />
                        <asp:ListItem Text="2017" Value="2017" Selected="True" />
                       </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfd6" runat="server" ControlToValidate="ddlReviewPeriodYear" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a review year *" />
        </td>
      </tr>
      <tr>
        <td> </td>
        <td><asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-md btn-primary" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnUpdateAgain" runat="server" CssClass="btn btn-md btn-success" Text="Enter More Assignments" OnClick="btnSubmitAgain_Click" Visible="false" />
        <br /><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" /></td>
      </tr>
    
</table>

  </div>
</div>
</asp:Content>

