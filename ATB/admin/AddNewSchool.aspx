<%@ Page Title="Ability to Benefit - Add New School" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="AddNewSchool.aspx.vb" Inherits="ATB_New_admin_AddNewSchool" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
   
<h2>Ability to Benefit Research</h2>
    
<!--Navigation Menu-->
<div>
 <ul id="Ul1" class="nav nav-tabs" data-tabs="tabs">
  <li><a href="../searchATB.aspx">Search ATB Findings</a></li>
  <li><a href="../searchOPEID.aspx">Search For OPE IDs</a></li>

  <li class="dropdown active">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Administration <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="AddSchool.aspx">Add ATB Findings</a></li>
        <li class="active"><a href="AddNewSchool.aspx">Add New School</a></li>
    </ul>
  </li>   
 </ul>
 </div>
<!--End Navigation Menu-->   


    <table width="100%" cellpadding="4" cellspacing="5" border="0">
        <tr>
            <td colspan="4"><br />
                <p>
                    This feature adds a new school to the master ATB OPEID table. Please be sure that
                    the school doesn't already exist in the application before adding a new one by using
                    the <a href="../searchOPEID.aspx">Search For OPE IDs</a> page.</p>
            </td>
        </tr>
        <tr>
            <td valign="top" align="right" width="25%">
                <strong>OPEID</strong>:
            </td>
            <td valign="top" class="style1">
                <asp:TextBox ID="txtOPEID" runat="server" MaxLength="8" /><br />
                <asp:RequiredFieldValidator ID="rfdOPEID" runat="server" Text="Please enter a OPE ID"
                    ControlToValidate="txtOPEID" CssClass="warning" />
                <br />
                <asp:RegularExpressionValidator ID="regexOPEID" runat="server" ValidationExpression="^\d{8}$"
                    Text="The OPE ID must be 8 digits ending in 00" ControlToValidate="txtOPEID"
                    CssClass="warning" />
            </td>
            <td valign="top" align="right" width="25%">
                <strong>School Name: </strong>
            </td>
            <td valign="top" width="25%">
                <asp:TextBox ID="txtSchoolName" runat="server" Width="164px" /><br />
                <asp:RequiredFieldValidator ID="rfdbtnSearch" runat="server" Text="Please enter a school name"
                    ControlToValidate="txtSchoolName" CssClass="warning" />
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnAddRecord" runat="server" Text="Add New School" OnClick="btnAddRecord_Click"
                    CssClass="btn btn-md btn-primary" />
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warning" />
            </td>
        </tr>
    </table>
                            
       
</asp:Content>

