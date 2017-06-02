<%@ Page Title="Liaison Report - Aging Issues" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="false" CodeFile="Report_Liaison_Aging.aspx.vb" Inherits="Issues_Report_Liaison_Aging" EnableEventValidation="false" %>

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
<h5>Liaison Report - Aging Issues</h5>

Open Issues That Were Opened Greater Than   
    <asp:DropDownList ID="ddlDays" runat="server" CssClass="input" AutoPostBack="true">
        <asp:ListItem Value="1" Text="1" />
        <asp:ListItem Value="2" Text="2" />
        <asp:ListItem Value="3" Text="3" />
        <asp:ListItem Value="4" Text="4" />
        <asp:ListItem Value="5" Text="5" />
        <asp:ListItem Value="6" Text="6" />
        <asp:ListItem Value="7" Text="7" />
        <asp:ListItem Value="8" Text="8" />
        <asp:ListItem Value="9" Text="9" />
        <asp:ListItem Value="10" Text="10" Selected="True" />
        <asp:ListItem Value="11" Text="11" />
        <asp:ListItem Value="12" Text="12" />
        <asp:ListItem Value="13" Text="13" />
        <asp:ListItem Value="14" Text="14" />
        <asp:ListItem Value="15" Text="15" />
        <asp:ListItem Value="16" Text="16" />
        <asp:ListItem Value="17" Text="17" />
        <asp:ListItem Value="18" Text="18" />
        <asp:ListItem Value="19" Text="19" />
        <asp:ListItem Value="20" Text="20" />
        <asp:ListItem Value="21" Text="21" />
        <asp:ListItem Value="22" Text="22" />
        <asp:ListItem Value="23" Text="23" />
        <asp:ListItem Value="24" Text="24" />
        <asp:ListItem Value="25" Text="25" />
        <asp:ListItem Value="26" Text="26" />
        <asp:ListItem Value="27" Text="27" />
        <asp:ListItem Value="28" Text="28" />
    </asp:DropDownList> Days Ago

<!--Datasource for the Gridview-->
<asp:SqlDataSource ID="dsGridView" runat="server" SelectCommand="p_Report_Liaison_Aging" OnSelected="dsGridView_Selected"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>">
<SelectParameters>
    <asp:Parameter Name="Days" Type="Int32" DefaultValue="14" />
</SelectParameters>
</asp:SqlDataSource>

<asp:GridView ID="GridView1" runat="server" DataSourceID="dsGridView" AllowSorting="true" Caption="Liaison Report - Aging Issues" RowStyle-VerticalAlign="Top" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView" DataKeyNames="IssueID" Width="100%" >
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
            <asp:BoundField DataField="UserID" HeaderText="Owner" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Owner" HeaderText="Assigned To" SortExpression="Owner" HeaderStyle-HorizontalAlign="Center" />
            <asp:TemplateField HeaderText="Description"> 
            <ItemTemplate>
	             <%# If(Eval("IssueDescription") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("IssueDescription")))%> 
            </ItemTemplate>
            </asp:TemplateField>           
            <asp:TemplateField HeaderText="Comments"> 
             <ItemTemplate>
	            <%# If(Eval("Comments") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("Comments")))%> 
             </ItemTemplate> 
             </asp:TemplateField>
             <asp:BoundField DataField="BorrowersAffected" HeaderText="# Borrowers" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="LoansAffected" HeaderText="# Loans" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="FinancialImpact" HeaderText="Financial Impact" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="IssueStatus" HeaderText="Issue Status" SortExpression="IssueStatus" HeaderStyle-HorizontalAlign="Center" />
        </Columns>
     <RowStyle Font-Names="Calibri" Font-Size="10.5pt" />
     <HeaderStyle Font-Names="Calibri" Font-Size="11pt" />
</asp:GridView>

<div align="center">
    <asp:Button ID="btnExportExcel" runat="server" CausesValidation="false" OnClick="btnExportExcel_Click" CssClass="btn btn-md btn-danger" Text="Download to Excel" />
    <asp:Button ID="btnExportWord" runat="server" CausesValidation="false" OnClick="btnExportWord_Click" CssClass="btn btn-md btn-alert" Text="Download to Word" Visible="false" />
</div>
</asp:Content>

