<%@ Page Title="PCA Report - Count By PCA" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="Report_PCA_CountByAffectedOrg.aspx.vb" Inherits="Issues_Report_PCA_CountByAffectedOrg" %>

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

<!--Chart Datasource for Total Complaints By PCA -->
<asp:SqlDataSource ID="dsChartPCAReportCompletedPendingByPCA" runat="server" SelectCommand="p_Chart_PCA_ReportCompletedPendingByPCA"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for Total Complaints By PCA -->
<asp:SqlDataSource ID="dsReportPCAReportCompletedPendingByPCA" runat="server" SelectCommand="p_Report_PCA_ReportCompletedPendingByPCA"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<br />

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Total PCA Issues By Affected Org</span>
  </div>
  <div class="panel-body" align="center">
 
      

    <asp:Chart ID="Chart2" runat="server" BackColor="#D3DFF0" Width="900px" Height="350px" DataSourceID="dsChartPCAReportCompletedPendingByPCA" 
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="PCA Issues By Affected Org" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold" >
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
              <asp:Series ChartType="StackedColumn" Name="Completed" XValueMember="AffectedOrg" 
                  YValueMembers="Completed" IsValueShownAsLabel="true" >
              </asp:Series>
              <asp:Series ChartType="StackedColumn" Name="Pending" XValueMember="AffectedOrg" YValueMembers="Pending" IsValueShownAsLabel="true">
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
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle" >
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
           
      
 <br /><br />
 <asp:GridView ID="GridView2" runat="server" DataSourceID="dsReportPCAReportCompletedPendingByPCA" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped">
       <Columns>
            <asp:BoundField DataField="AffectedOrg" HeaderText="Affected Org" SortExpression="AffectedOrg"
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

