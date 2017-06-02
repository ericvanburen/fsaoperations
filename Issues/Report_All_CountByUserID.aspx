<%@ Page Title="All Issues Report - Count By Employee" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="false" CodeFile="Report_All_CountByUserID.aspx.vb" Inherits="Issues_Report_All_CountByUserID" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    
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

<!--Chart Datasource for All Issues By UserID-->
<asp:SqlDataSource ID="dsChartCountByUserID" runat="server" SelectCommand="p_Chart_All_CountByUserID"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for All Issues By UserID-->
<asp:SqlDataSource ID="dsReportCountByUserID" runat="server" SelectCommand="p_Report_All_CountByUserID"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" /> 


<br />
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Total Issues Assigned to Loan Analysts</span>
  </div>
  <div class="panel-body" align="center">
 <asp:Chart ID="chtPCAIssuesAssignedLoanAnalysts" runat="server" BackColor="#D3DFF0" Width="900px" Height="500px" DataSourceID="dsChartCountByUserID"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="All Issues Assigned to Ops Employees" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold" Docking="Top">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
              <asp:Series ChartType="StackedColumn" Name="Completed" XValueMember="UserID" 
                  YValueMembers="Completed" IsValueShownAsLabel="true">
              </asp:Series>
              <asp:Series ChartType="StackedColumn" Name="Pending" XValueMember="UserID" YValueMembers="Pending" IsValueShownAsLabel="true">
              </asp:Series>
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
 <br />
 <br />
 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsReportCountByUserID" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped">
       <Columns>
            <asp:BoundField DataField="UserID" HeaderText="Employee" SortExpression="UserID"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Pending" HeaderText="Pending" SortExpression="Pending"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="Completed" HeaderText="Completed" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="Completed" />    
             <asp:BoundField DataField="TotalIssues" HeaderText="Total" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="TotalIssues" />  
        </Columns>
    </asp:GridView>
  </div>
  </div>
</asp:Content>

