<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Report_Liaison_Closed_Issues.aspx.vb" Inherits="Issues_Report_Liaison_Core" EnableEventValidation="false" %>

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
<h5>Liaison Team - Closed Issues</h5>

<div>
    Date Received: <asp:TextBox ID="txtDateReceived" runat="server" />
    Date Resolved: <asp:TextBox id="txtDateResolved" runat="server" />
    <asp:Button ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" CssClass="btn btn-sm btn-primary" Text="Search" />
</div>
<!--Datasource for the Gridview-->
<asp:SqlDataSource ID="dsGridView" runat="server" SelectCommand="p_Report_Liaison_Closed_Issues" 
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>">
<SelectParameters>
    <asp:Parameter Name="DateReceived" />
    <asp:Parameter Name="DateResolved" />
</SelectParameters>
</asp:SqlDataSource>

<asp:GridView ID="GridView1" runat="server" DataSourceID="dsGridView" AllowSorting="true" Caption="Liaison Team - Closed ISsues Report" RowStyle-VerticalAlign="Top" 
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
           
             <asp:BoundField DataField="BorrowersAffected" HeaderText="# Borrowers" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="LoansAffected" HeaderText="# Loans" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="FinancialImpact" HeaderText="Financial Impact" HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="DateResolved" HeaderText="Date Resolved" SortExpression="DateResolved" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:d}" HtmlEncode="false" />
        </Columns>
     <RowStyle Font-Names="Calibri" Font-Size="10.5pt" />
     <HeaderStyle Font-Names="Calibri" Font-Size="11pt" />
</asp:GridView>

<div align="center">
    <asp:Button ID="btnExportExcel" runat="server" CausesValidation="false" OnClick="btnExportExcel_Click" CssClass="btn btn-md btn-danger" Text="Download to Excel" Visible="false" />
    <asp:Button ID="btnExportWord" runat="server" CausesValidation="false" OnClick="btnExportWord_Click" CssClass="btn btn-md btn-alert" Text="Download to Word" Visible="false" />
</div>
</asp:Content>

