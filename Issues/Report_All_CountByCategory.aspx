<%@ Page Title="All Issues - Count By Category" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="Report_All_CountByCategory.aspx.vb" Inherits="Issues_Report_All_CountByCategory" %>

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

<!--Chart/Report Datasource for Total Issues ByCategory -->
<asp:SqlDataSource ID="dsChartReportCountByCategory" runat="server" SelectCommand="p_Report_All_CountByCategory"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<br />

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Total PCA Issues By Category</span>
  </div>
  <div class="panel-body">
 
    <asp:Chart ID="chtCategories" runat="server" BackColor="211, 223, 240" 
          Width="900px" Height="350px"
        BorderColor="#1A3B69" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2px" 
          ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)" 
          DataSourceID="dsChartReportCountByCategory">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="All Issues By Category" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
            <%--<asp:Series ChartType="Column" IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="Category" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series> --%>
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
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart> 
           
      
 <br /><br />
 <asp:GridView ID="GridView2" runat="server" DataSourceID="dsChartReportCountByCategory" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped">
       <Columns>
            <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"
                HeaderStyle-HorizontalAlign="Center" />             
             <asp:BoundField DataField="TotalIssues" HeaderText="Total" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="TotalIssues" />
        </Columns>
    </asp:GridView>
  </div>
  </div>

</asp:Content> 
      
