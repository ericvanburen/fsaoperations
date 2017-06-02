<%@ Page Title="ATB - Add New School" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddSchool.aspx.vb" Inherits="ATB_New_admin_AddSchool" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
       
    <script type="text/JavaScript">
        $(document).ready(function () {
            $.ajaxSetup({
                cache: false
            });

            $("#MainContent_hypValidateOPEID").click(function () {
                var OPEID = $("#MainContent_txtOPEID").val();
                var loadUrl = "OPEIDLookup.aspx?OPEID=" + OPEID;
                var reLink = '<a href="AddSchool.aspx?OPEID=' + OPEID + '">Populate This Form</a>';
                //$("#result").html(ajax_load).load(loadUrl);
                $("#result").load(loadUrl);
                //alert(loadUrl);
                //$("#reLink").html(reLink);
                //$("#result").load(loadUrl);
                //var resultsText = $("#result").val();
                //alert(resultsText);
            });
        });

</script>       
   
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
        <li class="active"><a href="AddSchool.aspx">Add ATB Findings</a></li>
        <li><a href="AddNewSchool.aspx">Add New School</a></li>
    </ul>
  </li>   
 </ul>
 </div>
<!--End Navigation Menu-->  
<br />                                        
    <table width="100%" cellpadding="4" cellspacing="5" border="0">
        <tr>
            <td valign="top" align="right" width="25%">
                <strong>OPEID</strong>:
            </td>
            <td valign="top" class="style1">
                <asp:TextBox ID="txtOPEID" runat="server" MaxLength="8" />
                <asp:HyperLink ID="hypValidateOPEID" runat="server" NavigateUrl="#">Check OPEID</asp:HyperLink><br />
                <span id="result" class="warning"></span><span id="reLink" runat="server" class="hideColumn">
                </span>
                <br />
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
                <asp:TextBox ID="txtSchoolName_Summary" runat="server" Width="200px" /><br />
                <asp:RequiredFieldValidator ID="rfdbtnSearch" runat="server" Text="Please enter a school name"
                    ControlToValidate="txtSchoolName_Summary" CssClass="warning" />
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="4">
                <strong>ATB Findings:</strong><br />
                <asp:TextBox ID="txtViolationDescription_Summary" runat="server" Height="195px" TextMode="MultiLine"
                    Columns="131" Rows="8" Width="749px" />
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="4">
                <strong>Source of ATB Findings:</strong><br />
                <asp:DropDownList ID="ddlViolationSources_Summary" runat="server" Width="340px">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Accreditor/Oversight/Guarantor Data" Value="Accreditor/Oversight/Guarantor Data" />
                    <asp:ListItem Text="OIG or ED Audit" Value="OIG or ED Audit" />
                    <asp:ListItem Text="Other" Value="Other" />
                    <asp:ListItem Text="Press or Investigative Report" Value="Press or Investigative Report" />
                    <asp:ListItem Text="Program Review" Value="Program Review" />
                </asp:DropDownList>
                <asp:TextBox ID="txtViolationSources_Summary" runat="server" Visible="false" Height="95px"
                    TextMode="MultiLine" Columns="131" Rows="5" Width="751px" />
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="4">
                <strong>Recommendation:</strong><br />
                <asp:DropDownList ID="ddlRecommendation_Summary" runat="server">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Recommend Discharge All" Value="Recommend Discharge All" />
                    <asp:ListItem Text="No Corroboration Found" Value="No Corroboration Found" />
                    <asp:ListItem Text="Recommend Discharge For Certain Time Periods Only" Value="Recommend Discharge For Certain Time Periods Only" />
                    <asp:ListItem Text="Recommend Discharge For Certain Campuses Only" Value="Recommend Discharge For Certain Campuses Only" />
                    <asp:ListItem Text="Other--See Comments" Value="Other--See Comments" />
                </asp:DropDownList>
                <asp:TextBox ID="txtRecommendation_Summary" runat="server" Visible="false" Height="95px"
                    TextMode="MultiLine" Columns="131" Rows="5" Width="751px" />
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="4">
                <strong>Comments:</strong><br />
                <asp:TextBox ID="txtComments_Summary" runat="server" Height="95px" TextMode="MultiLine"
                    Columns="131" Rows="5" Width="847px" />
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnAddRecord" runat="server" Text="Add ATB Findings" OnClick="btnAddRecord_Click"
                    CssClass="btn btn-md btn-primary" />
                <asp:Button ID="btnUpdateRecord" runat="server" Text="Update ATB Findings" OnClick="btnUpdateRecord_Click"
                    CssClass="btn btn-md btn-primary" />
            </td>
        </tr>
        <tr>
            <td colspan="4" align="center">
                <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warning" />
            </td>
        </tr>
    </table>

                                        
    
    <br />
    
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblUserAdmin" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
</asp:Content>

