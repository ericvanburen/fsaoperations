<%@ Page Title="Ability to Benefit Search ATB Findings" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="searchATB.aspx.vb" Inherits="ATB_New_searchATB" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h2>Ability to Benefit Research</h2>

 <!--Navigation Menu-->
<div>
 <ul id="Ul1" class="nav nav-tabs" data-tabs="tabs">
  <li class="active"><a href="searchATB.aspx">Search ATB Findings</a></li>
  <li><a href="searchOPEID.aspx">Search For OPE IDs</a></li>

  <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Administration <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="admin/AddSchool.aspx">Add ATB Findings</a></li>
        <li><a href="admin/AddNewSchool.aspx">Add New School</a></li>
    </ul>
  </li>   
 </ul>
 </div>
<!--End Navigation Menu-->
   
    
    <div align="left" style="padding-top: 10px" id="tabs-1">
        <table width="100%" cellpadding="4" cellspacing="5" border="0">
            <tr>
                <td valign="top">
                    <strong>OPE ID: </strong>
                    <br />
                    <asp:TextBox ID="txtOPEID" runat="server" MaxLength="8" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-md btn-primary" /> <asp:Button ID="btnUpdateTotalAppsProcessed" runat="server" CssClass="btn btn-md btn-warning" OnClick="btnUpdate_Click" Text="Update" CausesValidation="false" /><br />
                    <asp:Label ID="lblUpdateStatus" runat="server" />
                    <asp:RequiredFieldValidator ID="rfdbtnSearch" runat="server" Text="Please enter an eight-digit OPE ID"
                        ControlToValidate="txtOPEID" CssClass="warning" SetFocusOnError="true" Display="Dynamic" />
                    <br />
                    <asp:RegularExpressionValidator ID="regexOPEID" runat="server" ValidationExpression="^\d{8}$"
                        Text="The OPE ID must be 8 digits ending in 00" ControlToValidate="txtOPEID" Display="Dynamic"
                        CssClass="warning" />
                </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="5" cellspacing="5" class="table-condensed">
            <tr>
                <td colspan="2">
                    <hr />
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <strong>OPE ID:</strong>
                    <br />
                    <asp:Label ID="lblOPEID" runat="server" />
                </td>
                <td valign="top">
                    <strong>School Name (including AKAs):</strong>
                    <br />
                    <asp:Label ID="lblSchoolName" runat="server" />
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <strong># of apps GA/ED have received historically:</strong>
                    <br />
                    <asp:Textbox ID="lblTotalAppsProcessed" runat="server" Width="50px" /> 
                </td>
                <td valign="top">
                    <strong>Accreditor Contacted?</strong>
                    <br />
                    <asp:Label ID="chkAccreditor_Contacted" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:HyperLink ID="hypOPEID" runat="server">All Schools Under This OPE ID</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <hr />
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2">
                    <strong><u>Recommendation</u></strong><br />
                    <br />
                    <ul>
                        <asp:Label ID="lblRecommendation_Summary" runat="server" />
                        <asp:Label ID="lblViolationSources_Summary" runat="server" />
                        <asp:Label ID="lblRecommendation_EDAudits" runat="server" />
                        <asp:Label ID="lblYearsATBFindings_EDAudits" runat="server" />
                        <asp:Label ID="lblRecommendation_ProgramReviews" runat="server" />
                        <asp:Label ID="lblYearsATBFindings_ProgramReviews" runat="server" />
                        <asp:Label ID="lblRecommendation_OIGAudits" runat="server" />
                        <asp:Label ID="lblYearsAudited_OIGAudits" runat="server" />
                        <asp:Label ID="lblRecommendation_PEPS" runat="server" />
                        <asp:Label ID="lblYearsATBFindings_PEPS" runat="server" />
                        <asp:Label ID="lblRecommendation_GA_ED" runat="server" />
                        <asp:Label ID="lblYearsATBFindings_GA_ED" runat="server" />
                        <asp:Textbox ID="txtField2" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField3" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField4" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField5" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField6" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField7" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField8" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField9" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField10" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField11" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField12" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField13" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField14" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField15" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField16" runat="server" Width="50px" />
                        <asp:Textbox ID="txtField17" runat="server" Width="50px" />
                    </ul>                   
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2">
                    <asp:Label ID="lblViolationDescription_Summary" runat="server" />
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2">
                    <asp:Label ID="lblComments_Summary" runat="server" />
                </td>
            </tr>
        </table>
    </div>
                    
                          
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblUserAdmin" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
</asp:Content>

