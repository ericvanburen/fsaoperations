<%@ Page Title="Operations Issues Dashboard" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.vb" Inherits="Issues_Dashboard" %>

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
            $('#navA0').addClass("active");
            //Add Issue
            $('#navA1').removeClass("active");
            //My Issues
            $('#navA2').removeClass("active");
            //Search Issues
            $('#navA3').removeClass("active");
            //Reports
            $('#navA4').removeClass("active");
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
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

<h3>Operations Issues Tracking Dashboard</h3>
    
<!--Datasource for Issues Closed With Last X Days-->
<asp:SqlDataSource ID="dsClosedIssuesXDays" runat="server" SelectCommand="p_IssuesResolvedLastXDays_Data"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>">
<SelectParameters>
    <asp:Parameter Name="Days" Type="Int32" DefaultValue="7" />
</SelectParameters>
</asp:SqlDataSource>

<!--Datasource for All Issues By UserID-->
<asp:SqlDataSource ID="dsReportCountByUserID" runat="server" SelectCommand="p_Report_All_CountByUserID"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" /> 

<!--Chart Datasource for Liaison Issues By Affected Org -->
<asp:SqlDataSource ID="dsChartReportCompletedPendingByAffectedOrg" runat="server" SelectCommand="p_Chart_Liaison_ReportCompletedPendingByAffectedOrg"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Chart Datasource for PCA Issues By Affected Org -->
<asp:SqlDataSource ID="dsChartPCAReportCompletedPendingByPCA" runat="server" SelectCommand="p_Chart_PCA_ReportCompletedPendingByPCA"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Chart Datasource for Resolved Issues Trend-->
<asp:SqlDataSource ID="dsResolvedIssuesTrend" runat="server" SelectCommand="p_IssuesResolvedBucketDays"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<div class="row">
  <div class="col-md-6"><div class="panel panel-primary" id="pnlIssueType">
  <div class="panel-heading" id="pnlIssueTypeHeading">
    <span class="glyphicon glyphicon-file"></span> <span class="panel-title">Open Issues By Department</span>
  </div>
  <div class="panel-body" id="pnlIssueTypeBody" align="center">
  <table>
    <tr>
        <td valign="top">        
        <!--Chart Open Issues By Issue Type-->
         <asp:Chart ID="chtOpenIssues" runat="server" BackColor="#D3DFF0" Width="500px" Height="400px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Open Issues By Department" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold">
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
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisY>
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart></td>
   </tr>
  </table>      
</div>
</div>
</div>
  <div class="col-md-6">
    <div class="panel panel-primary" id="pnlIssueStatus">
  <div class="panel-heading" id="pnlIssueStatusHeading">
    <span class="glyphicon glyphicon-stats"></span> <span class="panel-title">Issue Status</span>
  </div>
  <div class="panel-body" id="pnlIssueStatusBody" align="center">
 <table>
    <tr>
       <td valign="top"><!--Chart Issue Status-->
            <asp:Chart ID="chtIssueStatus" runat="server" BackColor="#D3DFF0" Width="500px" Height="400px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Issue Status" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold" Docking="Top">
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
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart></td>       
    </tr>    
  </table>
</div>
</div>
</div>

</div>

<div class="row">
  <div class="col-md-6">
   <div class="panel panel-primary" id="Div1">
  <div class="panel-heading" id="Div2">
    <span class="glyphicon glyphicon-calendar"></span> <span class="panel-title">Issues Closed Within Last 
    <asp:DropDownList ID="ddlDays" runat="server" CssClass="input" AutoPostBack="true">
        <asp:ListItem Value="1" Text="1" />
        <asp:ListItem Value="2" Text="2" />
        <asp:ListItem Value="3" Text="3" />
        <asp:ListItem Value="4" Text="4" />
        <asp:ListItem Value="5" Text="5" />
        <asp:ListItem Value="6" Text="6" />
        <asp:ListItem Value="7" Text="7" Selected="True" />
        <asp:ListItem Value="8" Text="8" />
        <asp:ListItem Value="9" Text="9" />
        <asp:ListItem Value="10" Text="10" />
        <asp:ListItem Value="11" Text="11" />
        <asp:ListItem Value="12" Text="12" />
        <asp:ListItem Value="13" Text="13" />
        <asp:ListItem Value="14" Text="14" />
        <asp:ListItem Value="15" Text="15" />
    </asp:DropDownList> Days</span>
  </div>
  <div class="panel-body" id="Div3">
       <asp:Label ID="lblCompletedIssueCount" runat="server" CssClass="h4" />
       <asp:GridView ID="GridView1" runat="server" DataSourceID="dsClosedIssuesXDays" AllowSorting="true" AllowPaging="true" PageSize="10"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-condensed">
       <Columns>            
           <asp:BoundField DataField="IssueID" HeaderText="Issue ID" SortExpression="IssueID"
                HeaderStyle-HorizontalAlign="Center" />  
           <asp:BoundField DataField="DateResolved" HeaderText="Date Resolved" SortExpression="DateResolved"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="IssueDescription" HeaderText="Issue Description" SortExpression="IssueDescription"
                HeaderStyle-HorizontalAlign="Center" />               
        </Columns>
    </asp:GridView>
  </div>
</div>
</div>
  <div class="col-md-6"><div class="panel panel-primary" id="Div4">
  <div class="panel-heading" id="Div5">
    <span class="glyphicon glyphicon-user"></span> <span class="panel-title">Issues Assigned to Staff</span>
  </div>
  <div class="panel-body" id="Div6" align="center">
    <asp:GridView ID="GridView2" runat="server" DataSourceID="dsReportCountByUserID" AllowSorting="true" AllowPaging="true" PageSize="15"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-condensed">
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
  </div>
</div>

<div class="row">
<div class="col-md-6">
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="glyphicon glyphicon-home"></span> <span class="panel-title">Servicer Issues By Affected Org</span>
  </div>
  <div class="panel-body" align="center">
 
    <asp:Chart ID="Chart2" runat="server" BackColor="#D3DFF0" Width="500px" Height="400px" DataSourceID="dsChartReportCompletedPendingByAffectedOrg" 
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Servicer Issues By Affected Org" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold" Docking="Top">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
              <asp:Series ChartType="StackedColumn" Name="Completed" XValueMember="AffectedOrg" 
                  YValueMembers="Completed" IsValueShownAsLabel="true">
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
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" Angle="-50" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    </div>
</div>
</div>
<div class="col-md-6">
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="glyphicon glyphicon-home"></span> <span class="panel-title">PCA Issues By Affected Org</span>
  </div>
  <div class="panel-body" align="center">
 
    <asp:Chart ID="Chart1" runat="server" BackColor="#D3DFF0" Width="500px" Height="400px" DataSourceID="dsChartPCAReportCompletedPendingByPCA" 
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="PCA Issues By Affected Org" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold" Docking="Top">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
        <Series>
              <asp:Series ChartType="StackedColumn" Name="Completed" XValueMember="AffectedOrg" 
                  YValueMembers="Completed" IsValueShownAsLabel="true">
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
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" Angle="-50" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    </div>
</div>
</div>
</div>

<div class="row">
<div class="col-md-6">
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="glyphicon glyphicon-stats"></span> </span> <span class="panel-title">Resolved Issues Trend</span>
  </div>
  <div class="panel-body" align="center"> 
         
     <!--Chart Resolved Issues Trend-->
      <asp:Chart ID="ChartResolvedIssuesTrend" runat="server" BackColor="#D3DFF0" Width="500px" Height="400px" DataSourceID="dsResolvedIssuesTrend" 
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Resolved Issues Trend" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold" Title="Issues Resolved Within Last" Docking="Top">
            </asp:Legend>
        </Legends>
        <BorderSkin SkinStyle="Emboss"></BorderSkin>
          <Series>
              <asp:Series ChartType="Column" Name="1-7 Days" YValueMembers="Days 1-7">
              </asp:Series>
              <asp:Series ChartType="Column" Name="8-14 Days" YValueMembers="Days 8-14">
              </asp:Series>
               <asp:Series ChartType="Column" Name="15-21 Days" YValueMembers="Days 15-21">
              </asp:Series>
              <asp:Series ChartType="Column" Name="22-28 Days" YValueMembers="Days 22-28">
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
                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Interval="1" />
                    <MajorGrid LineColor="64, 64, 64, 64" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
         
     
  </div>
</div>
</div>
<div class="row">
<div class="col-md-6">
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="glyphicon glyphicon-stats"></span> <span class="panel-title">Issues Received By Source Type</span>
  </div>
  <div class="panel-body" align="center">
    <asp:Chart ID="chtSourceOrgType" runat="server" BackColor="#D3DFF0" Width="500px" Height="400px"
        BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
        BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
        <Titles>
            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                Text="Issues Received By Source Type" ForeColor="26, 59, 105">
            </asp:Title>
        </Titles>
        <Legends>
            <asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                Font="Trebuchet MS, 8.25pt, style=Bold" Docking="Top">
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
  </div>
</div>
</div>
</div>
</div>

</ContentTemplate>
</asp:UpdatePanel>

</asp:Content>

