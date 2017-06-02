<%@ Page Title="Issues - Report Summary" Language="VB" MasterPageFile="Site.master" AutoEventWireup="true" CodeFile="Report_Summary.aspx.vb" Inherits="Issues_Report_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
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

    <script type="text/javascript">
        $(document).ready(function () {
            // initialize the datepicker object
            $('.datepicker').datepicker()
        }); 
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!--Datasource for Issue Type-->
<asp:SqlDataSource ID="dsIssueTypeOpen" runat="server" SelectCommand="p_Report_Issue_Type_Open"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for Issue Status-->
<asp:SqlDataSource ID="dsIssueStatus" runat="server" SelectCommand="p_Report_IssueStatus"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<h4>Summary Reports</h4>
<table cellpadding="5" cellspacing="5">
    <tr>
        <td colspan="3">Enter Date Received Range</td>
    </tr>
    <tr>
        <td><input id="txtDateReceivedBegin" type="text" name="txtDateReceivedBegin" class="form-control datepicker" runat="server" placeholder="Begin Date Received" /><br />
            <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtDateReceivedBegin" CssClass="alert-danger" ErrorMessage="Please enter a beginning received date" runat="server" />
        </td>
        <td><input id="txtDateReceivedEnd" type="text" name="txtDateReceivedEnd" class="form-control datepicker" runat="server" placeholder="End Date Received" /><br />
         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" ControlToValidate="txtDateReceivedEnd" CssClass="alert-danger" ErrorMessage="Please enter an ending received date" runat="server" />
        <td valign="top"><asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Create Charts" CssClass="btn btn-md btn-warning" /></td>
    </tr>    
</table>
<br />   

<div class="panel panel-primary" id="pnlIssueType">
  <div class="panel-heading" id="pnlIssueTypeHeading">
    <span class="panel-title">Open Issues By Type</span>
  </div>
  <div class="panel-body" id="pnlIssueTypeBody" align="center">
  <table>
    <tr>
        <td valign="top">
        
        <!--Chart Open Issues By Issue Type-->
         <asp:Chart ID="chtOpenIssues" runat="server" BackColor="#D3DFF0" Width="900px" Height="500px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Open Issues By Type" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 9.25pt, style=Bold">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
            <%--<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="CallCount" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series>--%> 
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
                    <LabelStyle Font="Trebuchet MS, 9.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 9.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart></td>
        <td valign="top">
            <asp:GridView ID="GridView_IssueType" runat="server" DataSourceID="dsIssueTypeOpen"
                CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="false" Visible="false">
                <Columns>
                    <asp:BoundField DataField="Issue Type" HeaderText="Issue Type" SortExpression="Issue Type"
                        HeaderStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Total Issues" HeaderText="Total Issues" SortExpression="Total Issues"
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                    
                </Columns>
                <AlternatingRowStyle BackColor="White" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" Font-Size="Small" HorizontalAlign="Left" />
            </asp:GridView>
        </td>
   </tr>
</table> 
      
</div>
</div>    

<div class="panel panel-primary" id="pnlIssueStatus">
  <div class="panel-heading" id="pnlIssueStatusHeading">
    <span class="panel-title">Issue Status</span>
  </div>
  <div class="panel-body" id="pnlIssueStatusBody" align="center">
 <table>
    <tr>
       <td valign="top"><!--Chart Issue Status-->
            <asp:Chart ID="chtIssueStatus" runat="server" BackColor="#D3DFF0" Width="900px" Height="500px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Issue Status" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
           
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
                    <LabelStyle Font="Trebuchet MS, 9.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 9.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart></td>
        <td valign="top">
            <asp:GridView ID="GridView_IssueStatus" runat="server" DataSourceID="dsIssueStatus" CellPadding="4"
                ForeColor="#333333" GridLines="None" AutoGenerateColumns="false" Visible="false">
                <Columns>                    
                    <asp:BoundField DataField="Issue Status" HeaderText="Issue Status" 
                        HeaderStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Total Issues" HeaderText="Total Issues" 
                        HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />                    
                </Columns>
                <AlternatingRowStyle BackColor="White" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" Font-Size="Small" HorizontalAlign="Left" />
            </asp:GridView>
        </td>
    </tr>    
  </table>
</div>
</div>
    
<div class="panel panel-primary" id="pnlUserID">
  <div class="panel-heading" id="pnlUserIDHeading">
    <span class="panel-title">Issues Assigned</span>
  </div>
  <div class="panel-body" id="pnlUserIDBody" align="center">
 <table>
    <tr>
    <td>
    <!--Chart Assigned To-->
    <asp:Chart ID="chtAssignedTo" runat="server" BackColor="#D3DFF0" Width="900px" Height="500px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Issues Assigned" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
           
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
                    <LabelStyle Font="Trebuchet MS, 9.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 9.25pt, style=Bold" IsStaggered="False" Interval="1" Angle="-50" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
</td>
</tr>
</table>
</div>
</div>

<div class="panel panel-primary" id="pnlCategory">
  <div class="panel-heading" id="pnlCategoryHeading">
    <span class="panel-title">Category</span>
  </div>
  <div class="panel-body" id="pnlCategoryBody" align="center">
 <table>
    <tr>
    <td>
    <!--Chart Category-->
    <asp:Chart ID="chtCategory" runat="server" BackColor="#D3DFF0" Width="900px" Height="500px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Category" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
           
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
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" Angle="-50" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    </td>
    </tr>
 </table>
</div>
</div>

<div class="panel panel-primary" id="pnlAffectedOrg">
  <div class="panel-heading" id="pnlAffectedOrgHeading">
    <span class="panel-title">Affected Org</span>
  </div>
  <div class="panel-body" id="pnlAffectedOrgBody" align="center">
 <table>
    <tr>
    <td>
    <!--Chart AffectedOrg-->
    <asp:Chart ID="chtAffectedOrg" runat="server" BackColor="#D3DFF0" Width="900px" Height="500px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Affected Org" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
           
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
                    <LabelStyle Font="Trebuchet MS, 9.25pt, style=Bold" IsStaggered="False" Interval="1" Angle="-50"  />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    </td>
    </tr>
 </table>
</div>
</div>
 
</asp:Content>

