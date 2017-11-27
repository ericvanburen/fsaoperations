<%@ Page Title="Individual Productivity Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportIndividualProductivity.aspx.vb" Inherits="CCM_admin_ReportIndividualProductivty" %>

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
                        <h2>Call Center Monitoring - Individual Productivity Report</h2>
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
                                            <li><a href="../ChecksSearch.aspx">Servicer Check Report</a></li>
                                            <li><a href="QCReview_New.aspx">QC Review - Add</a></li>
                                            <li><a href="QCReview_Search.aspx">QC Review - Search</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Monitoring</a>
                                        <ul>
                                            <li><a href="../FormB.aspx">Enter Call</a></li>
                                            <li><a href="../MyReviews.aspx">My Reviews</a></li>
                                            <li><a href="../Checks.aspx">Add Servicer Check</a></li>
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
                                    <asp:Chart ID="ChtIndividualProductivty" runat="server" Width="800px" Height="450px"
                                        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
                                        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
                                        <Titles>
                                            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                                                Text="Productivity Report" ForeColor="26, 59, 105">
                                            </asp:Title>
                                        </Titles>
                                        <Legends>
                                            <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                                                Font="Trebuchet MS, 8.25pt, style=Bold">
                                            </asp:Legend>
                                        </Legends>
                                        <BorderSkin SkinStyle="Emboss"></BorderSkin>
                                        <Series>
                                            <%--
								<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="CallCount" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series> --%>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid"
                                                BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent"
                                                BackGradientStyle="TopBottom">
                                                <AxisY2 Enabled="False">
                                                </AxisY2>
                                                <AxisX2 Enabled="False">
                                                </AxisX2>
                                                <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                    WallWidth="0" IsClustered="False" />
                                                <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                                                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                                    <MajorGrid LineColor="64, 64, 64, 64" />
                                                </AxisY>
                                                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                                                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Angle="-90"
                                                        Interval="1" />
                                                    <MajorGrid LineColor="64, 64, 64, 64" />
                                                </AxisX>
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
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

