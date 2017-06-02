<%@ Page Title="Liaison Report - Issues Assigned to Responsible Area" Language="VB" MasterPageFile="Site.master" AutoEventWireup="false" CodeFile="Report_Liaison_Assigned_Responsible_Area.aspx.vb" Inherits="Issues_Report_Liaison_Assigned_Responsible_Area" EnableEventValidation="false" %>

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

<h3>Liaison Report - Assigned to Responsible Area</h3>
<!--Datasource for the Gridview-->
<asp:SqlDataSource ID="dsGridView" runat="server" SelectCommand="p_Report_Liaison_Responsible_Area"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" OnSelected="dsGridView_Selected">
<SelectParameters>
    <asp:Parameter Name="ResponsibleArea" Type="String" />
</SelectParameters>
</asp:SqlDataSource>

<div class="pull-left">
    <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>   
        <td align="right">Responsible Area</td>
        <td align="left" colspan="3"><asp:DropDownList ID="ddlResponsibleArea" runat="server" CssClass="inputBox" AutoPostBack="true">
            <asp:ListItem Text="" Value="" Selected="True" /> 
            <asp:ListItem Text="AES/PHEAA" Value="AES/PHEAA" /> 
            <asp:ListItem Text="FedLoan" Value="FedLoan" /> 
            <asp:ListItem Text="FSA-CFO" Value="FSA-CFO" /> 
            <asp:ListItem Text="FSA-CIO" Value="FSA-CIO" /> 
            <asp:ListItem Text="FSA-Ombuds" Value="FSA-Ombuds" /> 
            <asp:ListItem Text="FSA-OpServ" Value="FSA-OpServ" /> 
            <asp:ListItem Text="FSA-ProgMgt" Value="FSA-ProgMgt" /> 
            <asp:ListItem Text="FSA-Servicer Liaison" Value="FSA-Servicer Liaison" />
            <asp:ListItem Text="MOHELA" Value="MOHELA" /> 
            <asp:ListItem Text="N/A" Value="N/A" />
            <asp:ListItem Text="NNI" Value="NNI" /> 
            <asp:ListItem Text="NSLDS" Value="NSLDS" /> 
            <asp:ListItem Text="Other" Value="Other" />
            <asp:ListItem Text="SLMA" Value="SLMA" />
            <asp:ListItem Text="Xerox" Value="Xerox" />           
        </asp:DropDownList></td>                 
    </tr>
</table>
</div>

 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsGridView" AllowSorting="true" RowStyle-VerticalAlign="Top" Caption="Liaison Report - Assigned to Responsible Area" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView" DataKeyNames="IssueID">
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
            <asp:BoundField DataField="ResponsibleArea" HeaderText="Responsible Area" SortExpression="ResponsibleArea" HeaderStyle-HorizontalAlign="Center" />
            <asp:TemplateField HeaderText="Description"> 
                <ItemTemplate>
	             <%# If(Eval("IssueDescription") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("IssueDescription")))%> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Owner" HeaderText="Assigned To" HeaderStyle-HorizontalAlign="Center" />
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

