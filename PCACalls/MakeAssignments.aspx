﻿<%@ Page Title="Assign Reviews to Loan Analysts" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MakeAssignments.aspx.vb" Inherits="PCACalls_Assignments_PCACalls" %>

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

          
    <script type="text/javascript">
        $(document).ready(function () {
            $("#MainContent_ddlReviewType").change(function () {
                //var selected = $("#MainContent_ddlReviewType option:selected").val();
                var selected = $(this).val();
                //alert(selected);
                if(selected == "PCA Phone Review") {
                    $("#MainContent_txtReviewDate").removeAttr("disabled");
                    $("#MainContent_ddlReportYear").attr("disabled", "disabled");
                    $("#MainContent_ddlReportQuarter").attr("disabled", "disabled");
                    //alert("PCA Phone Review");
                }
                else if (selected == "Rehab Review") {
                    $("#MainContent_txtReviewDate").attr("disabled", "disabled");
                    $("#MainContent_ddlReportYear").removeAttr("disabled");
                    $("#MainContent_ddlReportQuarter").removeAttr("disabled");
                    //alert("Rehab Review");
                }
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

  <li class="dropdown">
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

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">PCA Reviews - One PCA</a></li>
        <li><a href="Reports_MultiPCA.aspx">PCA Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsRehab.aspx">Rehab Reviews - One PCA</a></li>
        <li><a href="ReportsRehab_MultiPCA.aspx">Rehab Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Phone Reviews - LA Errors</a></li>
        <li><a href="ReportsRehabCallErrors.aspx">Rehab Reviews - LA Errors</a></li>
        <li><a href="MakeAssignments.aspx">Make New Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">   
</asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Assign Reviews to Loan Analysts</span>
  </div>
  <div class="panel-body">

<table cellpadding="3" cellspacing="4">
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Review Type" data-content="The type of review">1) Select a Review Type: </a></label></td>
        <td><asp:DropDownList ID="ddlReviewType" runat="server" TabIndex="1">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="PCA Phone Review" Value="PCA Phone Review" />
            <asp:ListItem Text="Rehab Review" Value="Rehab Review" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="ddlReviewType" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter a review type *" /></td>
     </tr>
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA" data-content="The PCA the review is for">2) Select the PCA: </a></label></td>      
        <td><asp:DropDownList ID="ddlPCAID" runat="server" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="true">
             <asp:ListItem Text="" Value="" />
             </asp:DropDownList><br />
       <asp:RequiredFieldValidator ID="rfd2" runat="server" ControlToValidate="ddlPCAID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a PCA *" /></td>
     </tr> 
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Loan Analyst" data-content="The Loan Analyst the reviews will be assigned to">3) Select the Loan Analyst to assign them to: </a></label></td>         
            <td><asp:DropDownList ID="ddlUserID" runat="server" TabIndex="3" AppendDataBoundItems="true">
               <asp:ListItem Text="" Value="" />                
               </asp:DropDownList><br />
               <asp:RequiredFieldValidator ID="rfd3" runat="server" ControlToValidate="ddlUserID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a Loan Analyst *" /></td>
      </tr>
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Phone Recording Delivery Date" data-content="The date the supervisor gave the Loan Analyst the recording of the PCA call">4) Enter a Phone Recording Delivery Date</a></label></td>
        <td><asp:TextBox ID="txtRecordingDeliveryDate" runat="server" CssClass="datepicker" Height="25px" TabIndex="4" /><br />
        <asp:RequiredFieldValidator ID="rfd4" runat="server" ControlToValidate="txtRecordingDeliveryDate" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please enter a phone recording delivery date *" /></td>
      </tr>
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Review Date" data-content="The date that the review was performed">5) Enter a Review Date</a></label></td>
        <td><asp:TextBox ID="txtReviewDate" runat="server" CssClass="datepicker" Height="25px" TabIndex="5" /></td>
      </tr>   
   
    <tr>
        <td align="right"><label class="tableColumnHead"><a href="#" data-toggle="popover" title="Rehab Review Quarter/Year" data-content="The fiscal quarter and year that the rehab review was performed">6) Rehab Review Quarter/Year</a></label></td>
        <td><asp:DropDownList ID="ddlReportQuarter" runat="server" CssClass="inputBox" TabIndex="6">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="1 (Oct, Nov, Dec)" Value="1" />
                    <asp:ListItem Text="2 (Jan, Feb, Mar)" Value="2" Selected="True" />
                    <asp:ListItem Text="3 (Apr, May, Jun)" Value="3" />
                    <asp:ListItem Text="4 (Jul, Aug, Sep)" Value="4" />                    
            </asp:DropDownList>
            <asp:DropDownList ID="ddlReportYear" runat="server" CssClass="inputBox" TabIndex="7">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="2014" Value="2014" />
                    <asp:ListItem Text="2015" Value="2015" Selected="True" />
                    <asp:ListItem Text="2016" Value="2016" />
            </asp:DropDownList>
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

