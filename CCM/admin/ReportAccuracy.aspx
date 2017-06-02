<%@ Page Title="Call Center Monitoring Accuracy Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportAccuracy.aspx.vb" Inherits="CCM_New_ReportAccuracy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
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
                        <h2>Call Center Monitoring - Accuracy Report</h2>
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
                                <!--Call Centers-->
                                <asp:SqlDataSource ID="dsCallCenters" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />
                                <!--Call Reason / Issues-->
                                <asp:SqlDataSource ID="dsReasonCode" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallReasons" SelectCommandType="StoredProcedure" />
                                <!--Concerns-->
                                <asp:SqlDataSource ID="dsConcerns" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" />
                                <!--Users/Evaluators-->
                                <asp:SqlDataSource ID="dsUserID" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />
                                <div align="left" style="padding-top: 10px" id="tabs-1">
                                    <table cellpadding="2" cellspacing="2" border="0" width="100%">
                                        <tr>
                                            <td valign="top">
                                                <strong>Call Center:</strong><br />
                                                <asp:DropDownList ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters"
                                                    SelectionMode="Multiple" Rows="4" AppendDataBoundItems="true" DataTextField="CallCenter"
                                                    DataValueField="CallCenterID">
                                                    <asp:ListItem Text="" Value="" />
                                                </asp:DropDownList>
                                                <br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlCallCenterID"
                                                    ErrorMessage="* Call Center is reqired" CssClass="warning" Display="Dynamic" />
                                            </td>
                                            <td valign="top">
                                                <strong>Begin Date of Review:</strong><br />                                                
                                                            <asp:TextBox ID="txtDateofReviewBegin" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="txtDateofReviewBegin" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic"/>                                                        
                                            </td>
                                            <td valign="top">
                                                <strong>End Date of Review:</strong><br />                                               
                                                            <asp:TextBox ID="txtDateofReviewEnd" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateofReviewEnd" ErrorMessage="*End Date is reqired" CssClass="warning" Display="Dynamic" />                                                         
                                            </td>
                                            <td valign="bottom">
                                                <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnAccuracyReport_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                    <p>
                                        &nbsp;</p>
                                </div>
                                <div id="divVariablePeriod" class="grid" align="center">
                                    <asp:Label ID="lblRowCountVariablePeriod" runat="server" CssClass="warning" />
                                    <asp:GridView ID="grdVariablePeriod" runat="server" AutoGenerateColumns="false" AllowSorting="false"
                                        CssClass="datatable" BorderWidth="1px" BackColor="White" GridLines="Horizontal"
                                        CellPadding="3" BorderColor="#E7E7FF" Width="900px" BorderStyle="None" ShowFooter="false">
                                        <EmptyDataTemplate>
                                            No records matched your search
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" ItemStyle-HorizontalAlign="Left"
                                                HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="CountOfCallCenter" HeaderText="Call Count" ItemStyle-HorizontalAlign="Left"
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
                                    <div align="center">
                                        <asp:Button ID="btnExportExcel_VariablePeriod" runat="server" CssClass="button" Text="Export to Excel"
                                            Visible="false" />
                                    </div>
                                </div>
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <contenttemplate>
     
     
    <asp:Repeater ID="rptCenterProfile" runat="server">
    <HeaderTemplate>
     <table width="900px" cellpadding="2" cellspacing="4" 
            style="background-color: White; border-style: solid; border-width: 1px; border-color: #5C9CCC;" 
            align="center">
    </HeaderTemplate>
    <ItemTemplate>       
        <tr>
            <td align="right" width="50%">Passed Calls:</td>
            <td align="left" width="50%"><asp:Label ID="lblPassedCalls" runat="server" text='<%# Eval("PassedCalls") %>' /></td>
        </tr>
        <tr>
            <td align="right" width="50%">Failed Calls:</td>
            <td align="left" width="50%"><asp:Label ID="lblFailedCalls" runat="server" text='<%# Eval("FailedCalls") %>' /></td>
        </tr>
         <tr>
            <td align="right" width="50%">Total Calls:</td>
            <td align="left" width="50%"><asp:Label ID="lblCallCount" runat="server" text='<%# Eval("CallCount") %>' /></td>
        </tr>  
    
    </ItemTemplate>
    <FooterTemplate>
            </table>
            </FooterTemplate> 
    </asp:Repeater>
            <!--Chart-->
            <asp:Panel ID="pnlCharts" runat="server" Visible="false">
                <table width="900px" cellpadding="2" cellspacing="4" style="background-color: White;
                    border-style: solid; border-width: 0px; border-color: #5C9CCC;" align="center">
                    <tr>
                        <td align="center">
                            <!--Chart for one call center -->
                            <asp:Chart ID="ChtCallCount" runat="server" BackColor="#D3DFF0" Width="800px" Height="450px"
                                BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
                                BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
                                <titles>
                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                            Text="Call Center Accuracy" ForeColor="26, 59, 105">
                        </asp:Title>
                    </titles>
                                <legends>
                        <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                            Font="Trebuchet MS, 8.25pt, style=Bold">
                        </asp:Legend>
                    </legends>
                                <borderskin skinstyle="Emboss"></borderskin>
                                <series>
                        <%--
								<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="CallCount" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series> --%>
                    </series>
                                <chartareas>
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
                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False"
                                    Interval="1" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisX>
                        </asp:ChartArea>
                    </chartareas>
                            </asp:Chart>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <!--Chart for all call centers-->
                            <asp:CheckBox ID="chkCallCount_AllCenters" runat="server" Text="Show values" OnCheckedChanged="chkCallCount_AllCenters_CheckedChanged"
                                AutoPostBack="true" /><br />
                            <asp:chart id="ChtCallCount_AllCenters" runat="server" BackColor="#D3DFF0" Width="800px"
                                Height="450px" BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid"
                                BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
                                <titles>
								<asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3" Text="Calls By Call Center" ForeColor="26, 59, 105"></asp:Title>
							</titles>
                                <legends>
								<asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"></asp:Legend>
							</legends>
                                <borderskin skinstyle="Emboss"></borderskin>
                                <series><%--
								<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="CallCount" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series> --%>                               
							</series>
                                <chartareas>
								<asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid" BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent" BackGradientStyle="TopBottom">
									<axisy2 Enabled="False"></axisy2>
									<axisx2 Enabled="False"></axisx2>
									<area3dstyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False" />
									<axisy LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
										<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
										<MajorGrid LineColor="64, 64, 64, 64" />
									</axisy>
									<axisx LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
										<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Angle="-90" Interval="1" />
										<MajorGrid LineColor="64, 64, 64, 64" />
									</axisx>
								</asp:ChartArea>                                
							</chartareas>
                            </asp:chart>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlAccuracyReport" runat="server" Visible="false" HorizontalAlign="Center">
                <table width="900px" cellpadding="2" cellspacing="4" style="background-color: White;
                    border-style: solid; border-width: 1px; border-color: #5C9CCC;" align="center">
                    <tr>
                        <td colspan="4" align="left" class="pageSubHeader">
                            <strong>Accuracy Report For
                                <asp:Label ID="lblReportCallCenter" runat="server" /></strong><br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <strong><u>Category</u></strong>
                        </td>
                        <td align="center">
                            <strong><u>Calls Passed</u></strong>
                        </td>
                        <td align="center">
                            <strong><u>Calls Reviewed</u></strong>
                        </td>
                        <td align="center">
                            <strong><u>Percent Passed</u></strong>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Greeting</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Idenitified Self:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_Name" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_NameCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_NamePctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Spoke Clearly:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_Clear" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_ClearCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_ClearPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Tone:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_Tone" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_ToneCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_TonePctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Answered Promptly:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_Prompt" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_PromptCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblG_PromptPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Verification</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Name:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Name" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_NameCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_NamePctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            SSN:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_SSN" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_SSNCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_SSNPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Address:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Adrs" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_AdrsCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_AdrsPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Primary Phone:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Phon1" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Phon1CallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Phon1PctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Alternate Phone:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Phon2" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Phon2CallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Phon2PctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Email:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_Email" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_EmailCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_EmailPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Date of Birth:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_DOB" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblV_DOBCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblV_DOBPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Effective Listening</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Didn't Interrupt:
                        </td>
                        <td align="center">
                            <asp:Label ID="lblL_Interrupt" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblL_InterruptCallsReviewed" runat="server" />
                        </td>
                        <td align="center">
                            <asp:Label ID="lblL_InterruptPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Didn't Ask to Repeat:
                        </td>
                        <td>
                            <asp:Label ID="lblL_NoRepeat" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblL_NoRepeatCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblL_NoRepeatPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Basic Counseling</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Basic Counseling:
                        </td>
                        <td>
                            <asp:Label ID="lblBC_Counseling" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblBC_CounselingCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblBC_CounselingPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Solution</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Correct Solution:
                        </td>
                        <td>
                            <asp:Label ID="lblS_Accuracy" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblS_AccuracyCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblS_AccuracyPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Accuracy</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Primary Issue:
                        </td>
                        <td>
                            <asp:Label ID="lblIssue1" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblIssue1CallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblIssue1PctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Secondary Issue:
                        </td>
                        <td>
                            <asp:Label ID="lblIssue2" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblIssue2CallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblIssue2PctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Tertiary Issue:
                        </td>
                        <td>
                            <asp:Label ID="lblIssue3" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblIssue3CallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblIssue3PctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Phone Etiquette</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Pleasant Manner:
                        </td>
                        <td>
                            <asp:Label ID="lblE_Pleasant" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblE_PleasantCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblE_PleasantPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Non-Confrontational:
                        </td>
                        <td>
                            <asp:Label ID="lblE_NonConfrontational" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblE_NonConfrontationalCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblE_NonConfrontationalPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Timeliness:
                        </td>
                        <td>
                            <asp:Label ID="lblE_Timeliness" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblE_TimelinessCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblE_TimelinessPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="left">
                            <strong>Closing</strong>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            All Questions Answered:
                        </td>
                        <td>
                            <asp:Label ID="lblC_AllQuestions" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblC_AllQuestionsCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblC_AllQuestionsPctngPassed" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Recapped the Call:
                        </td>
                        <td>
                            <asp:Label ID="lblC_Recapped" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblC_RecappedCallsReviewed" runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="lblC_RecappedPctngPassed" runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            </ContentTemplate> </asp:UpdatePanel>
        </div>
        </div> </td> </tr> </table> </div>
        <br />
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
</asp:Content>

