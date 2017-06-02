<%@ Page Title="Specialty Claims - Enter New Claim" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="EnterNewClaim.aspx.vb" Inherits="SpecialtyClaims_UpdateSSN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<meta http-equiv="X-UA-Compatible" content="IE=9" />

    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>      
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
   
<script type="text/javascript">
    $(document).ready(function () {
       $('.datepicker').datepicker()
     }); 

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<h3>Specialty Claims Tracking</h3>  

 <div>
 <ul class="nav nav-tabs">
  <li class="active"><a href="EnterNewClaim.aspx">Enter New Claim</a></li>
  <li><a href="Search.aspx">Search/Update By Account</a></li>
  <li><a href="UpdateBatch.aspx">Approve Batch</a></li>  
  <li><a href="Upload.aspx">Upload New Batch</a></li>
  <li class="dropdown">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="Reports.aspx">Servicer Files</a></li>
        <li><a href="ProductivityReport.aspx">LA Productivity</a></li>
        <li><a href="ServicerReceipts.aspx">Received By FSA</a></li>  
        <li><a href="AgingClaims.aspx">Aging Claims - Servicer</a></li> 
        <li><a href="AgingClaims_ClaimType.aspx">Aging Claims - Claim Type</a></li>        
    </ul>
  </li>
  <li><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />


    <div class="panel panel-primary">
    <div class="panel-heading">
        <span class="panel-title">Enter New Claim</span>
    </div>
    <div class="panel-body">
    <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>
        <td>
            &nbsp;&nbsp;</td>
        <td>
        <!--Account Number-->
        <label class="control-label" for="MainContent_txtSSN">Account Number</label><br />
        <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="inputBox" TabIndex="1" /><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Account Number is a required field *" ControlToValidate="txtAccountNumber" Display="Dynamic" CssClass="alert-danger" /></td>
        <td><!--Borrower Name-->
        <label class="control-label" for="MainContent_txtBorrowerName">Borrower Name</label><br />
        <asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" TabIndex="2" /><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Borrower Name is a required field *" ControlToValidate="txtBorrowerName" Display="Dynamic" CssClass="alert-danger" /></td>
    </tr>
    <tr>
        <td>
            &nbsp;&nbsp;</td>
        <td>
        <!--Claim/Discharge Type-->
        <label class="control-label" for="MainContent_txtClaimType">Claim Type</label><br />
        <asp:DropDownList ID="ddlDischargeType" runat="server" CssClass="inputBox" TabIndex="3">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="ATB" Value="atb" />
                <asp:ListItem Text="ATB Appeal" Value="atb appeal" />
                <asp:ListItem Text="CLS" Value="cls" />
                <asp:ListItem Text="CLS Appeal" Value="cls appeal" />
                <asp:ListItem Text="Death" Value="death" />
                <asp:ListItem Text="DQS" Value="dqs" />
                <asp:ListItem Text="DQS Appeal" Value="dqs appeal" />
                <asp:ListItem Text="Fraud" Value="fraud" />
                <asp:ListItem Text="ID Theft" Value="id theft" />
                <asp:ListItem Text="ID Theft Appeal" Value="id theft appeal" />
                <asp:ListItem Text="Ineligible Borrower" Value="ineligible borrower" />
                <asp:ListItem Text="Perkins Cancellation" Value="perkins cancellation" />
                <asp:ListItem Text="TLF" Value="tlf" />
                <asp:ListItem Text="Unenforceable" Value="unenforceable" />
                <asp:ListItem Text="UNP" Value="unp" />
                <asp:ListItem Text="UNP Appeal" Value="unp appeal" />
                <asp:ListItem Text="UNS" Value="uns" />
                <asp:ListItem Text="UNS Appeal" Value="uns appeal" />
            </asp:DropDownList>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Claim Type is a required field *"
                ControlToValidate="ddlDischargeType" Display="Dynamic" CssClass="alert-danger" /></td>
        <td>            
        <!--DateCompleted-->
        <label class="control-label" for="MainContent_txtDateCompleted"> Date Completed</label><br />
        <asp:TextBox ID="txtDateCompleted" runat="server" CssClass="datepicker" TabIndex="6" /></td>
    </tr>
    <tr>
        <td>
            &nbsp;&nbsp;</td>
        <td>
        <!--Servicer Name-->
        <label class="control-label" for="MainContent_ddlServicer">Servicer</label><br />
            <asp:DropDownList ID="ddlServicer" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Aspire" Value="aspire" />
                <asp:ListItem Text="Cornerstone" Value="cornerstone" />
                <asp:ListItem Text="COSTEP" Value="costep" />
                <asp:ListItem Text="EDGEucation" Value="edgeucation" />
                <asp:ListItem Text="EdFinancial" Value="edfinancial" />
                <asp:ListItem Text="EdManage" Value="edmanage" />
                <asp:ListItem Text="ECSI" Value="ecsi" />
                <asp:ListItem Text="Granite State" Value="granite state" />
                <asp:ListItem Text="Great Lakes" Value="great lakes" />
                <asp:ListItem Text="KSA" Value="ksa" />
                <asp:ListItem Text="MOHELA" Value="mohela" />
                <asp:ListItem Text="Nelnet" Value="nelnet" />
                <asp:ListItem Text="OSLA" Value="osla" />
                <asp:ListItem Text="PHEAA" Value="pheaa" />
                <asp:ListItem Text="SLMA" Value="slma" />
                <asp:ListItem Text="VSAC" Value="vsac" />
            </asp:DropDownList>
            <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Servicer is a required field *" ControlToValidate="ddlServicer" Display="Dynamic" CssClass="alert-danger" /></td>
        <td>
         <!--Date Received-->
         <label class="control-label" for="MainContent_txtDateReceived">Date Received</label><br />
        <asp:TextBox ID="txtDateReceived" runat="server" CssClass="datepicker" TabIndex="5" /><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Date Received is a required field *" ControlToValidate="txtDateReceived" Display="Dynamic" CssClass="alert-danger" /></td>
    </tr>

    <tr>
        <td>&nbsp;&nbsp;</td>
        <td colspan="2">
         <!--Approve-->
         <label class="control-label" for="MainContent_chkApprove">Approve?</label><br />
         <asp:CheckBox ID="chkApprove" runat="server" TabIndex="7" /></td>
    </tr>
    <tr>
        <td colspan="3" align="center">
        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-lg btn-primary" Text="Enter New Claim" OnClick="btnUpdate_Click" TabIndex="8" />
            <asp:Button ID="btnUpdateAgain" runat="server" CssClass="btn btn-lg btn-success" Text="Enter Another Claim" OnClick="btnUpdateAgain_Click" Visible="false" />     
            <br /><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" /> </td>
    </tr>
</table>
</div>
</div>


</asp:Content>

