<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportIndividualProductivityCallCenter.aspx.vb" Inherits="CCM_admin_ReportIndividualProductivityCallCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                        <h2>Call Center Monitoring - Individual Productivity By Call Center Report</h2>
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
                                
                                <div align="left" style="padding-top: 10px" id="tabs-1">
                                    <table cellpadding="2" cellspacing="2" border="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <strong>Begin Date of Review:</strong><br />                                               
                                                        <asp:TextBox ID="txtDateofReviewBegin" runat="server" /><br />
                                                        <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="txtDateofReviewBegin"
                                                            ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="VariablePeriod" />                                                    
                                            </td>
                                            <td valign="top">
                                                <strong>End Date of Review:</strong><br />                                                
                                                        <asp:TextBox ID="txtDateofReviewEnd" runat="server" /><br />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateofReviewEnd"
                                                            ErrorMessage="*End Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="VariablePeriod" />                                                    
                                            </td>
                                            <td valign="bottom">
                                                <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnSearch_Click"
                                                    ValidationGroup="VariablePeriod" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div align="center">
                                    
                                </div>
                                <div align="center">
                                    <asp:Panel ID="pnlGridViewStats" runat="server" Visible="false" Width="900px" HorizontalAlign="Center">
                                        <table border="0" width="100%">
                                            <tr>
                                                <td align="right">
                                                    <asp:ImageButton ID="btnExportExcel" runat="server" CausesValidation="false" ImageUrl="../images/btnExportExcel.gif"
                                                        OnClick="btnExportExcel_VariablePeriod_Click" CssClass="btnExportExcel" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
                                <div id="divVariablePeriod" class="grid" align="center">
                                    <asp:GridView ID="grdIndividualProductivty" runat="server" AutoGenerateColumns="false" AllowSorting="false"
                                        CssClass="datatable" BorderWidth="1px" BackColor="White" GridLines="Horizontal"
                                        CellPadding="3" BorderColor="#E7E7FF" Width="900px" BorderStyle="None" ShowFooter="false">
                                        <EmptyDataTemplate>
                                            No records matched your search
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:BoundField DataField="UserID" HeaderText="User" ItemStyle-HorizontalAlign="Left"
                                                HeaderStyle-HorizontalAlign="Left" />
                                             <asp:BoundField DataField="CallCenter" HeaderText="Call Center" ItemStyle-HorizontalAlign="Left"
                                                HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="Call Count" HeaderText="Call Count" ItemStyle-HorizontalAlign="Left"
                                                HeaderStyle-HorizontalAlign="Left" />
                                        </Columns>
                                        <RowStyle CssClass="row" />
                                        <AlternatingRowStyle CssClass="rowalternate" />
                                        <FooterStyle CssClass="gridcolumnheader" />
                                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                                        <HeaderStyle CssClass="gridcolumnheader" />
                                        <EditRowStyle CssClass="gridEditRow" />
                                    </asp:GridView>
                                    <br />
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <br />
    </fieldset>
</asp:Content>

