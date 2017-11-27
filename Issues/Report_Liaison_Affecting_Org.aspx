<%@ Page Title="Liaison Report - Affected Organization" Language="VB" MasterPageFile="Site.master" AutoEventWireup="false" CodeFile="Report_Liaison_Affecting_Org.aspx.vb" Inherits="Issues_Report_Liaison_Affecting_Org" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="scripts/scripts_detail.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
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
            $('#navA4').addClass("active");
        });
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<h5>Liaison Report - Issues Affecting Organization (Open, Deferred, Agenda OR Closed Within Last 14 Days)</h5>

<!--Datasource for the Gridview-->
<asp:SqlDataSource ID="dsGridView" runat="server" SelectCommand="p_Report_Liaison_Affected_Org"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" OnSelected="dsGridView_Selected">
<SelectParameters>
    <asp:Parameter Name="AffectedOrgID" Type="String" />
</SelectParameters>
</asp:SqlDataSource>

<!--Datasource for Affected Org Listbox-->
<asp:SqlDataSource ID="dsAffectedOrg" runat="server" SelectCommand="p_AllAffectedOrg_Servicer"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<div class="pull-left">
    <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>   
        <td align="right">Affected Organization<br /></td>
        <td align="left">
       <asp:ListBox ID="ddlAffectedOrgID" runat="server" CssClass="inputBox" SelectionMode="Multiple" DataSourceID="dsAffectedOrg" DataTextField="AffectedOrg" DataValueField="AffectedOrgID" Width="250px">
            <asp:ListItem Text="" Value="" Selected="True" />                        
        </asp:ListBox></td>                 
    </tr>
    <tr>
        <td colspan="2" align="center"><asp:Button ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" CssClass="btn btn-md btn-primary" Text="Search" Width="150px" /></td>
    </tr>
</table>
</div>

 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsGridView" AllowSorting="true" Caption="Liaison Report - Issues Affecting Organization (Open, Deferred, Agenda OR Closed Within Last 14 Days)" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView" DataKeyNames="IssueID" RowStyle-VerticalAlign="Top">
        <Columns>          
            <asp:TemplateField HeaderText="Issue" SortExpression="IssueID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("IssueID", "Issue_Update.aspx?IssueID={0}") %>'
                        Text='<%# Eval("IssueID") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="AffectedOrg" HeaderText="Affected Org" SortExpression="AffectedOrg" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="FSAGroup" HeaderText="FSA Group" HeaderStyle-HorizontalAlign="Center" SortExpression="FSAGroup" /> 
	    <asp:BoundField DataField="UserID" HeaderText="Owner" HeaderStyle-HorizontalAlign="Center" SortExpression="UserID" /> 
            <asp:TemplateField HeaderText="Description"> 
            <ItemTemplate>
	             <%# If(Eval("IssueDescription") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("IssueDescription")))%> 
            </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Owner" HeaderText="Assigned To" HeaderStyle-HorizontalAlign="Center" SortExpression="Owner" />
            <asp:TemplateField HeaderText="Comments"> 
             <ItemTemplate>
	            <%# If(Eval("Comments") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("Comments")))%> 
             </ItemTemplate> 
             </asp:TemplateField>
            <asp:BoundField DataField="IssueStatus" HeaderText="Issue Status" SortExpression="IssueStatus" HeaderStyle-HorizontalAlign="Center" />
        </Columns>
     <RowStyle Font-Names="Calibri" Font-Size="10.5pt" />
     <HeaderStyle Font-Names="Calibri" Font-Size="11pt" />
</asp:GridView>

<div align="center">
    <asp:Button ID="btnExportExcel" runat="server" CausesValidation="false" OnClick="btnExportExcel_Click" CssClass="btn btn-md btn-danger" Text="Download to Excel" Visible="false" />
    <asp:Button ID="btnExportWord" runat="server" CausesValidation="false" OnClick="btnExportWord_Click" CssClass="btn btn-md btn-alert" Text="Download to Word" Visible="false" />
</div>
</asp:Content>

