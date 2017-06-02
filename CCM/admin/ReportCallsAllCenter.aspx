<%@ Page Title="Call Center Monitoring - All Call Centers" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportCallsAllCenter.aspx.vb" Inherits="CCM_New_ReportFailedCalls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                        <h2>Call Center Monitoring - All Call Centers</h2>
                        <div id="tabs">
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
                                <ul id="nav">
                                     <li><a href="../Help.aspx">Help</a></li>
                                     <li><a href="#">Reports</a>
                                        <ul>
                                            <li><a href="../MyProductivityReport.aspx">My Productivity</a></li>                                    
                                        </ul>
                                         
                                    </li>
                                    <li><a href="../Search.aspx">Search</a></li>
                                    <li><a href="#">Administration</a>
                                        <ul>                                           
                                            <li><a href="ReportCallsMonitored.aspx">Call Center Count</a></li>
                                            <li><a href="ReportFailedCalls.aspx">Failed Calls</a></li>
                                            <li><a href="ReportAccuracy.aspx">Accuracy Report</a></li>
                                            <li><a href="ReportIndividualProductivity.aspx">Productivity</a></li>
                                            <li><a href="ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
                                            <li><a href="ReportCallsAllCenter.aspx">Call Center Summary</a></li>
                                            <li><a href="Search.aspx">Search</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Monitoring</a>
                                        <ul>
                                            <li><a href="../FormB.aspx">Enter Call</a></li>
                                            <li><a href="../MyReviews.aspx">My Reviews</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Datasource for the GridView-->
                                <asp:SqlDataSource ID="dsCallsSummary" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_Report_CallsSummary_AllCallCenters" SelectCommandType="StoredProcedure" />
                                
                                <div align="left" style="padding-top: 10px" id="tabs-1">
                                    <table cellpadding="2" cellspacing="2" border="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <strong>Begin Date of Review:</strong><br />                                                
                                                        <asp:TextBox ID="txtDateofReviewBeginFailedCalls" runat="server" /><br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateofReviewBeginFailedCalls"
                                                            ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="CallsSummary" />                                                   
                                            </td>
                                            <td valign="top">
                                                <strong>End Date of Review:</strong><br />                                                
                                                        <asp:TextBox ID="txtDateofReviewEndFailedCalls" runat="server" /><br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateofReviewEndFailedCalls"
                                                            ErrorMessage="* End Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="CallsSummary" />                                                    
                                            </td>
                                            <td valign="bottom">
                                                <asp:Button ID="btnCallsSummary" runat="server" CssClass="button" Text="Search"
                                                    OnClick="btnCallsSummary_Click" ValidationGroup="CallsSummary" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div align="center">
            <asp:Panel ID="pnlGridViewStats" runat="server" Visible="false" HorizontalAlign="Center">
                <table border="0" width="90%">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="center" width="33%">
                            <asp:Label ID="lblRowCount" runat="server" CssClass="warning" />
                        </td>
                        <td align="right" width="33%">
                            <asp:ImageButton ID="btnExportExcel" runat="server" CausesValidation="false" ImageUrl="../images/btnExportExcel.gif"
                                OnClick="btnExportExcel_CallsSummary_Click" CssClass="btnExportExcel" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div id="dvGrid" class="grid" align="center">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="true"
                OnSorting="GridView1_Sorting" CssClass="datatable" BorderWidth="1px" 
                BackColor="White" GridLines="Horizontal" CellPadding="3" BorderColor="#E7E7FF"
                Width="90%" BorderStyle="None" ShowFooter="false">
                <EmptyDataTemplate>
                    No records matched your search
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="Call Center" HeaderText="Call Center" SortExpression="Call Center"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="Calls Monitored" HeaderText="Calls Monitored" SortExpression="Calls Monitored"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="Calls Failed" HeaderText="Calls Failed" SortExpression="Calls Failed"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="% Passed" HeaderText="% Passed" SortExpression="% Passed"
                        ItemStyle-HorizontalAlign="Left" />                   
                </Columns>
                <RowStyle CssClass="row" />
                <AlternatingRowStyle CssClass="rowalternate" />
                <FooterStyle CssClass="gridcolumnheader" />
                <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                <HeaderStyle CssClass="gridcolumnheader" Font-Size="Medium" />
                <EditRowStyle CssClass="gridEditRow" />
            </asp:GridView>
            <br />
        </div>
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
</asp:Content>

