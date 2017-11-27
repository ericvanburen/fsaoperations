<%@ Page Title="Assign IBR Reviews" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MakeAssignments.aspx.vb" Inherits="IBRReviews_MakeAssignments" %>

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
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">My IBR Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="EnterNewReview.aspx">Enter New Review</a></li>
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyAssignments.aspx">My Assignments</a></li>       
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">Search Reviews</a></li>      
    </ul>
  </li> 

  <li class="dropdown active">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="ErrorReport.aspx">Error Report</a></li> 
        <li><a href="MakeAssignments.aspx">Make Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>     
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />
<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>">   
</asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Assign IBR Reviews to Loan Analysts</span>
  </div>
  <div class="panel-body">

<table cellpadding="3" cellspacing="4">    
    <tr>
        <td align="right"><label class="tableColumnHead">1<a href="#" data-toggle="popover" title="PCA" data-content="The PCA the review is for">) Select the PCA: </a></label></td>      
        <td><asp:DropDownList ID="ddlPCAID" runat="server" TabIndex="1" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="true">
             <asp:ListItem Text="" Value="" />
             </asp:DropDownList><br />
       <asp:RequiredFieldValidator ID="rfd2" runat="server" ControlToValidate="ddlPCAID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a PCA *" /></td>
     </tr> 
    <tr>
        <td align="right"><label class="tableColumnHead">2<a href="#" data-toggle="popover" title="Loan Analyst" data-content="The Loan Analyst the reviews will be assigned to">) Select the Loan Analyst to assign them to: </a></label></td>         
            <td><asp:DropDownList ID="ddlUserID" runat="server" TabIndex="2" AppendDataBoundItems="true">
               <asp:ListItem Text="" Value="" />                
               </asp:DropDownList><br />
               <asp:RequiredFieldValidator ID="rfd3" runat="server" ControlToValidate="ddlUserID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a Loan Analyst *" /></td>
      </tr>
    <tr>
        <td align="right"><label class="tableColumnHead">3<a href="#" data-toggle="popover" title="Phone Recording Delivery Date" data-content="The date the supervisor gave the Loan Analyst the recording of the PCA call">) Enter a Phone Recording Delivery Date</a></label></td>
        <td><asp:TextBox ID="txtRecordingDeliveryDate" runat="server" CssClass="datepicker" Height="25px" TabIndex="3" /><br />
        <asp:RequiredFieldValidator ID="rfd4" runat="server" ControlToValidate="txtRecordingDeliveryDate" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter a phone recording delivery date *" /></td>
      </tr>
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#">4</a><a href="#" data-toggle="popover" title="Review Date" data-content="The date that the review was performed">) Enter a Review Date</a></label></td>
        <td><asp:TextBox ID="txtReviewDate" runat="server" CssClass="datepicker" Height="25px" TabIndex="4" /><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtReviewDate" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter a Review Date *" /></td>
      </tr> 
    <tr>
           <td align="right"><label class="tableColumnHead"><a href="#">5</a><a href="#" data-toggle="popover" title="Review Month" data-content="The month that the review was performed">) Enter a Review Month</a></label></td>
           <td><asp:DropDownList ID="ddlReportMonth" runat="server" CssClass="inputBox">
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
           </asp:DropDownList><br /><asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="* Month is a required field *"
        ControlToValidate="ddlReportMonth" Display="Dynamic" CssClass="alert-danger" />
        </td> 
    </tr>
    <tr>
        <td align="right"><label class="tableColumnHead">6<a href="#" data-toggle="popover" title="Rehab Review Quarter/Year" data-content="The fiscal quarter and year that the rehab review was performed">) Rehab Review Quarter/Year</a></label></td>
        <td><asp:DropDownList ID="ddlReportQuarter" runat="server" CssClass="inputBox" TabIndex="5">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="1 (Oct, Nov, Dec)" Value="1" />
                    <asp:ListItem Text="2 (Jan, Feb, Mar)" Value="2" />
                    <asp:ListItem Text="3 (Apr, May, Jun)" Value="3" />
                    <asp:ListItem Text="4 (Jul, Aug, Sep)" Value="4" />                    
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlReportQuarter" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a Report Quarter *" />
            <asp:DropDownList ID="ddlReportYear" runat="server" CssClass="inputBox" TabIndex="6">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="2018" Value="2018" />
                    <asp:ListItem Text="2017" Value="2017" />
                    <asp:ListItem Text="2016" Value="2016" />                     
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlReportYear" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a Report Year *" />
        </td>
      </tr>
    <tr>
        <td align="right"><label class="tableColumnHead">7<a href="#" data-toggle="popover" title="Date Assigned" data-content="The date that the review was assigned to the Loan Analyst">) Date Assigned</a></label></td>
        <td><asp:TextBox ID="txtDateAssigned" runat="server" CssClass="datepicker" Height="25px" TabIndex="7" /><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDateAssigned" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter the Date Assigned *" /></td>
    </tr>
    <tr>
        <td align="right"><label class="tableColumnHead">8<a href="#" data-toggle="popover" title="Due Date" data-content="The date that the review is due">) Due Date</a></label></td>
        <td><asp:TextBox ID="txtDueDate" runat="server" CssClass="datepicker" Height="25px" TabIndex="8" /><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtDueDate" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter the Due Date *" /></td>
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

