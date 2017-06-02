<%@ Page Title="Enter New IBR Review" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EnterNewReview.aspx.vb" Inherits="IBRReviews_EnterNewReview" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>  
    <script src="../Scripts/jquery.checkAvailabilityIBR.js" type="text/javascript"></script>  
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
  
       <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker()

            $("#MainContent_txtBorrowerNumber").checkAvailability();

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
            $(function () {
                $('#MainContent_txtIncome').on("input", function (e) {
                    this.value = this.value.replace(/[&\/\\#,+()$~%'":*?<>{}]/g, '');
                });
            });
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
 <li class="dropdown active">
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

  <li class="dropdown">
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
<p> </p>

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>" /> 

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Enter New IBR Review</span>
  </div>
  <div class="panel-body">
     <table class="table" border="0">        
     <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The borrower's DMCS borrower number">Borrower Number</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="PCA" data-content="The PCA the IBR review is for">PCA</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Quarter" data-content="The fiscal quarter of the review">Quarter</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Year" data-content="The fiscal year of the review">Year</a></th>
    </tr>
    <tr>
        <td valign="top" class="tableColumnCell" colspan="1">            
        <asp:TextBox ID="txtBorrowerNumber" runat="server" TabIndex="1" /> <input id="btnCheck" type="button" value="Check Borrower ID" class="btn btn-sm btn-primary" /><br />
                <span id="response" class="alert-danger"><!-- Our message will be echoed out here --></span><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Borrower Number is a required field *"
        ControlToValidate="txtBorrowerNumber" Display="Dynamic" CssClass="alert-danger" />
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Borrower Number must be 10 digits" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" ValidationExpression="\d{10}"   />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">                  
            <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="true">
                <asp:ListItem Text="" Value="" />
            </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="* PCA is a required field *"
        ControlToValidate="ddlPCAID" Display="Dynamic" CssClass="alert-danger" />
        </td>
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
                <asp:ListItem Text="2017" Value="2017" />
                <asp:ListItem Text="2016" Value="2016" />
                <asp:ListItem Text="2015" Value="2015" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Specify a report year *" Display="Dynamic" ControlToValidate="ddlReportYear" CssClass="alert-danger" />
        </td>
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Agreement Letter Signed?" data-content="Was the rehab agreement letter signed?">Agreement Letter Signed?</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Date Agreement Letter Was Signed" data-content="The date that the rehab agreement letter signed">Agreement Letter Signed Date</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Appropriate Financial Documentation?" data-content="Was appropriate financial documentation provided?">Appropriate Financial Documentation?</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Number of Dependents" data-content="The number of dependents the borrower has">Number of Dependents</a></th>
    </tr>
    <tr>        
        <td valign="top" class="tableColumnCell" colspan="1">               
                <asp:DropDownList ID="ddlAgreement_Letter_Signed" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Y" Value="Y" />
                <asp:ListItem Text="N" Value="N" />
                <asp:ListItem Text="N/A" Value="N/A" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Specify if the agreement letter was signed *" Display="Dynamic" ControlToValidate="ddlAgreement_Letter_Signed" CssClass="alert-danger" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:TextBox ID="txtAgreement_Letter_Signed_Date" runat="server" CssClass="datepicker" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">
             <asp:DropDownList ID="ddlFinancial_Documentation" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Y" Value="Y" />
                <asp:ListItem Text="N" Value="N" />
                <asp:ListItem Text="N/A" Value="N/A" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Specify if the financial documentation was provided *" Display="Dynamic" ControlToValidate="ddlFinancial_Documentation" CssClass="alert-danger" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">
             <asp:DropDownList ID="ddlDependents" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="0" Value="0" />
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="4" Value="4" />
                <asp:ListItem Text="5" Value="5" />
                <asp:ListItem Text="6" Value="6" />
                <asp:ListItem Text="7" Value="7" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Specify the number of dependents *" Display="Dynamic" ControlToValidate="ddlDependents" CssClass="alert-danger" />
        </td>        
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Borrower Income" data-content="The borrower's annual income">Borrower Income</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Repayment Amount Correct?" data-content="The the PCA set the borrower's repayment to the correct amount?">Repayment Amount Correct?</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Tag?" data-content="Did the PCA tag the account correctly in DMCS?">DMCS Tag?</a></th>
        <th class="tableColumnHead" colspan="1"> </th>
    </tr>
    <tr>
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:TextBox id="txtIncome" runat="server" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Specify the borrower's income *" Display="Dynamic" ControlToValidate="txtIncome" CssClass="alert-danger" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">
             <asp:DropDownList ID="ddlRepayment_Amount" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Y" Value="Y" />
                <asp:ListItem Text="N" Value="N" />
                <asp:ListItem Text="N/A" Value="N/A" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Specify if the repayment amount was correct *" Display="Dynamic" ControlToValidate="ddlRepayment_Amount" CssClass="alert-danger" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">
             <asp:DropDownList ID="ddlTag" runat="server" CssClass="inputBox">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Y" Value="Y" />
                <asp:ListItem Text="N" Value="N" />
                <asp:ListItem Text="N/A" Value="N/A" />
        </asp:DropDownList><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="* Specify if DMCS was tagged correctly *" Display="Dynamic" ControlToValidate="ddlTag" CssClass="alert-danger" />
        </td> 
        <td></td>       
    </tr>
    <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="FSA Comments" data-content="FSA Comments">FSA Comments</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="PCA Comments" data-content="PCA Comments">PCA Comments</a></th>
        <th class="tableColumnHead" colspan="2"><a href="#" data-toggle="popover" title="FSA Conclusions" data-content="PCA Comments">FSA Conclusions</a></th>

    </tr>
    <tr>
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:TextBox id="txtComments" runat="server" TextMode="MultiLine" Height="110px" Width="315px" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:TextBox id="txtPCA_Comments" runat="server" TextMode="MultiLine" Height="110px" Width="315px" />
        </td>
        <td valign="top" class="tableColumnCell" colspan="2">
            <asp:TextBox id="txtFSA_Conclusions" runat="server" TextMode="MultiLine" Height="110px" Width="315px" />
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <ul>
                <li><a href="Financial Calculators.zip">Repayment Calculators</a></li>
            </ul>
        </td>
    </tr>
         <tr>
            <td colspan="4" align="center"><br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-lg btn-primary" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnUpdateAgain" runat="server" CssClass="btn btn-lg btn-success" Text="Enter Another Review" OnClick="btnUpdateAgain_Click" Visible="false" />
            <br /><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
            </td>
        </tr>
     </table>
  </div>
 </div>
    <asp:Label ID="lblNewAssignmentID" runat="server" Visible="false" />
</asp:Content>

