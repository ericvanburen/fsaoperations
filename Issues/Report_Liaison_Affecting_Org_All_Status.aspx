<%@ Page Title="Liaison Report - Affected Organization All Statuses" Language="VB" MasterPageFile="Site.master" AutoEventWireup="false" CodeFile="Report_Liaison_Affecting_Org_All_Status.aspx.vb" Inherits="Issues_Report_Liaison_Affecting_Org_All_Status" EnableEventValidation="false" %>

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
            //Administration
            $('#navA5').removeClass("active");
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<h3>Liaison Report - Issues Affecting Organizations (All Statuses)</h3>

<!--Datasource for the Gridview-->
<asp:SqlDataSource ID="dsGridView" runat="server" SelectCommand="p_Report_Liaison_Affected_Org_All_Status"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" OnSelected="dsGridView_Selected">
<SelectParameters>
    <asp:Parameter Name="AffectedOrgID" Type="String" />
    <asp:Parameter Name="IssueStatus" Type="String" />
    <asp:Parameter Name="FSAGroup" Type="String" />
</SelectParameters>
</asp:SqlDataSource>

<!--Datasource for Affected Org Listbox-->
<asp:SqlDataSource ID="dsAffectedOrg" runat="server" SelectCommand="p_AllAffectedOrg_Servicer"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

    <table style="padding: 5px 5px 5px 15px;" border="0" cellpadding="5" cellspacing="5">
    <tr>   
        <td align="left">Affected Organization<br />
        <asp:ListBox ID="ddlAffectedOrgID" runat="server" CssClass="inputBox" SelectionMode="Multiple" DataSourceID="dsAffectedOrg" DataTextField="AffectedOrg" DataValueField="AffectedOrgID" Width="250px">
            <asp:ListItem Text="" Value="" Selected="True" />                        
        </asp:ListBox>
        </td>
        
       <td align="left">Current Status<br />
       <asp:ListBox ID="ddlIssueStatus" runat="server" CssClass="inputBox" SelectionMode="Multiple" Width="250px">
            <asp:ListItem Text="Open" Value="Open" Selected="True" />
            <asp:ListItem Text="Closed" Value="Closed" />
            <asp:ListItem Text="Deferred" Value="Deferred" />
            <asp:ListItem Text="Opened In Error" Value="Opened In Error" />
            <asp:ListItem Text="Agenda" Value="Agenda" />
        </asp:ListBox>
       </td>
       <td align="left">FSA Group<br />
       <asp:ListBox ID="ddlFSAGroup" runat="server" CssClass="inputBox" SelectionMode="Multiple" Width="250px">
                <asp:ListItem Text="Bus Ops" Value="Bus Ops" Selected="True" />
                <asp:ListItem Text="FMB Group" Value="FMB Group" />
        </asp:ListBox>
       </td>                      
    </tr>
    <tr>
        <td colspan="4" align="center"><asp:Button ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" CssClass="btn btn-md btn-primary" Text="Search" Width="150px" /></td>
    </tr>
</table>
<br />
 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsGridView" AllowSorting="true" RowStyle-VerticalAlign="Top" Caption="Liaison Report - Issues Affecting Organization (All Statuses)" 
        AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-condensed GridView" DataKeyNames="IssueID">
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

