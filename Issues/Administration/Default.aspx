<%@ Page Title="" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="Issues_Administration_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../scripts/scripts.js" type="text/javascript"></script>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
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
            $('#navA3').removeClass("active");
            //Reports
            $('#navA4').removeClass("active");
            //Administration
            $('#navA5').addClass("active");
        });     
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<asp:SqlDataSource ID="dsIssues" runat="server" SelectCommand="p_AllIssues"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<h5>Administrative Functions</h5>
<div align="center">
<table border="0" width="90%" cellpadding="5" cellspacing="5">
<tr>
    <td>Add New Category <br />
        <asp:TextBox ID="txtCategory" runat="server" /> <asp:Button ID="btnAddCategory" runat="server" Text="Add Category" CssClass=" btn btn-sm btn-warning" OnClick="btnAddCategory_Click" /><br />
        <asp:Label ID="lblInsertConfirmCategory" runat="server" CssClass="alert-danger" />
    </td>
    <td>Add Source Org Name <br />
        <asp:TextBox ID="txtSourceOrg" runat="server" /> <asp:Button ID="btnAddSourceOrg" runat="server" Text="Add Source Org" CssClass=" btn btn-sm btn-warning" OnClick="btnAddSourceOrg_Click" /><br />
        <asp:Label ID="lblInsertConfirmSourceOrg" runat="server" CssClass="alert-danger" />
    </td>
     <td>Add Affected Org <br />
        <asp:TextBox ID="txtAffectedOrg" runat="server" /> <asp:Button ID="btnAddAffectedOrg" runat="server" Text="Add Affected Org" CssClass=" btn btn-sm btn-warning" OnClick="btnAddAffectedOrg_Click" /><br />
        <asp:Label ID="lblInsertConfirmAffectedOrg" runat="server" CssClass="alert-danger" />
    </td>
</tr>
<tr>
    <td><br />Delete Issue & Reason<br />
        <asp:Dropdownlist ID="ddlIssueID" runat="server" DataSourceID="dsIssues" DataTextField="IssueID" DataValueField="IssueID" /> 
        <asp:TextBox ID="txtDeleteReason" runat="server" />
        <asp:Button ID="btnDeleteIssue" runat="server" Text="Delete Issue" CssClass=" btn btn-sm btn-warning" OnClick="btnDeleteIssue_Click" /><br />
        <asp:Label ID="lblDeleteIssueConfirm" runat="server" CssClass="alert-danger" />
    </td>

</tr>
</table>
</div>



</asp:Content>

