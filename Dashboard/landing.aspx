<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'First check for a valid, logged in user
            Dim chkLogin As New CheckLogin
            lblUserID.Text = chkLogin.CheckLogin()
            If lblUserID.Text = "0" Then
                Response.Redirect("default.aspx")
            End If
        
            'Enable Admin menu only for Eric Van Buren
            If lblUserID.Text = "1" Then
                adminMenu.Visible = True
            Else
                adminMenu.Visible = False
            End If
            
            ''Green
            'lblTotalGreen.Text = GetTotalGreen().ToString()
            
            ''Yellow
            'lblTotalYellow.Text = GetTotalYellow().ToString()
            
            ''Red
            'lblTotalRed.Text = GetTotalRed().ToString()
            
            'No Status
            lblNoStatus.Text = GetTotalNull().ToString()
            
            'Total Projects
            lblTotalProjects.Text = "* " & GetTotalProjects.ToString() & " total active projects"
           
        End If
    End Sub
    
    Private Function GetTotalGreen() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_GetGreenStatusCount", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalYellow() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_GetYellowStatusCount", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalRed() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_GetRedStatusCount", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalNull() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_GetNullStatusCount", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalProjects() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_GetTotalProjectCount", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    
   
    Protected Sub Chart1_OnLoad(sender As Object, e As System.EventArgs)
        Chart1.Palette = ChartColorPalette.None
    End Sub
    
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - Dashboard</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

     <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
     <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
     <script src="Scripts/menu.js" type="text/javascript"></script>
         
     <script type="text/javascript">
         $(function () {
             $("#tabs").tabs();
         });
	</script>
        
        
    <style type="text/css">
        .style1
        {
            text-align: left;
            font-weight: bold;
            font-size: small;
            width: 427px;
        }
        .style2
        {
            text-align: left;
        }
        .style3
        {
            font-size: medium;
        }
        </style>
        
        
</head>
<body>
    <form id="form1" runat="server">
  
    <fieldset class="fieldset">
        
        <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                 <img src="images/fSA_logo_dashboard.gif" alt="Federal Student Aid - Dashboard Reports" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Dashboard Summary</a></li>                                
                            </ul>
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="logout.aspx">Log Out</a></li>
                                    <li><a href="#">Administration</a>
                                <ul id="adminMenu" runat="server">
                                    <li><asp:HyperLink ID="hypProjectManager" runat="server" Text="Project Manager" NavigateUrl="project.updates.aspx?AllIssues=All" /></li>
                                    <li><asp:HyperLink ID="hypUserManager" runat="server" Text="User Manager" NavigateUrl="user.detail.aspx?UserID=1" /></li> 
                                    <li><asp:HyperLink ID="hypProjectSearch" runat="server" Text="Project Search" NavigateUrl="project.search.aspx" /></li>
                                    <li><asp:HyperLink ID="hypProjectNewApprove" runat="server" Text="Approve Projects" NavigateUrl="project.new.approve.aspx" /></li>                                    
                                </ul></li>                   
                                 <li><a href="#">Reports</a>
                                     <ul>
                                        <li><asp:HyperLink ID="hypReportsMetricsCallCenter" runat="server" Text="Metrics - Call Center" NavigateUrl="reports.metric.view.call.center.aspx" /></li>
                                        <li><asp:HyperLink ID="hypNSLDSReport" runat="server" Text="Metrics - NSLDS" NavigateUrl="reports.metric.view.nslds.aspx" /></li>
                                        <li><asp:HyperLink ID="hypReportsPerformance" runat="server" Text="Metrics - Others" NavigateUrl="reports.metric.view.aspx" /></li>                                        
                                        <li><asp:HyperLink ID="hypReportsProject" runat="server" Text="Projects" NavigateUrl="reports.project.view.aspx" /></li>
                                        <li><asp:HyperLink ID="hypReportRedFlag" runat="server" Text="Red Flags" NavigateUrl="reports.redflag.view.aspx" /></li>
                                        <li><asp:HyperLink ID="hypReportComments" runat="server" Text="Comments" NavigateUrl="reports.comments.view.aspx" /></li>
                                    </ul></li>
                                 
                                 <li><a href="#">Red Flags/Comments</a>                                  
                                     <ul>
                                        <li><asp:HyperLink ID="hypRedFlagAdd" runat="server" Text="Add Red Flag" NavigateUrl="redflag.add.aspx" /></li>
                                        <li><asp:HyperLink ID="hypReportRedFlag2" runat="server" Text="Red Flags" NavigateUrl="reports.redflag.view.aspx" /></li>
                                        <li><asp:HyperLink ID="hypCommentAdd" runat="server" Text="Add Comment" NavigateUrl="comment.add.aspx" /></li>                                       
                                    </ul></li>
                                 
                                 <li><a href="#">Performance Metrics</a>                                  
                                     <ul>
                                        <li><asp:HyperLink ID="hypPerformanceView" runat="server" Text="My Metrics" NavigateUrl="metric.view.aspx" /></li>
                                        <li><asp:HyperLink ID="hypPerformanceAdd" runat="server" Text="Add New Status" NavigateUrl="metric.add.aspx" /></li>
                                        <li><asp:HyperLink ID="hypNSLDSCallCenter" runat="server" Text="NSLDS Call Center" NavigateUrl="metric.nslds.add.aspx" /></li>
                                    </ul></li>
                                    <li><a href="#">Projects</a>
                                    <ul>
                                        <li><asp:HyperLink ID="hypProjectView" runat="server" Text="My Projects" NavigateUrl="my.projects.aspx" /></li>
                                        <li><asp:HyperLink ID="hypProjectAdd" runat="server" Text="Add New Status" NavigateUrl="project.add.aspx" /></li> 
                                        <li><asp:HyperLink ID="hypProjectAddNew" runat="server" Text="Add New Project" NavigateUrl="project.add.new.aspx" /></li>                                       
                                    </ul></li>
                                     
                          </ul>
                            </div>
                            <br /><br />

                                        <asp:SqlDataSource ID="dsTotalsByStatus" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_TotalsByStatus" SelectCommandType="StoredProcedure">                                        
                                        </asp:SqlDataSource>
                                
                                <div id="Div1">   
                                    <br /><br />
                                    <div align="center">
                                    <span class="style3"><strong>Project Status</strong></span><br /><br />
                                    <table width="100%">
                                        <tr>
                                              <td class="style1" valign="top">
                                                <a href="reports.project.view.status.aspx?Status=Green">Green</a>,
                                                <a href="reports.project.view.status.aspx?Status=Yellow">Yellow</a>,
                                                <a href="reports.project.view.status.aspx?Status=Red">Red</a>,
                                                No Status: <asp:Label id="lblNoStatus" runat="server" style="font-size: small" />
                                            <br />
                                                <asp:Chart ID="Chart1" runat="server" DataSourceID="dsTotalsByStatus" OnLoad="Chart1_OnLoad"
                                                    Height="284px" Palette="Excel" Width="403px" PaletteCustomColors="LightGreen; Tomato; LemonChiffon"
                                                    Style="text-align: center">
                                                    <Series>
                                                        <asp:Series Name="Series1" XValueMember="Status" YValueMembers="TotalProjects" ChartType="Pie"
                                                            IsVisibleInLegend="true" LegendText="Status" IsValueShownAsLabel="true">
                                                        </asp:Series>
                                                    </Series>
                                                    <ChartAreas>
                                                        <asp:ChartArea Name="ChartArea1">
                                                            <Area3DStyle Enable3D="True" Inclination="30" LightStyle="Realistic" Perspective="30"
                                                                IsRightAngleAxes="False" IsClustered="False" />
                                                        </asp:ChartArea>
                                                    </ChartAreas>
                                                </asp:Chart><br />
                                                <span class="smallText"><asp:Label ID="lblTotalProjects" runat="server" /></span>
                                            </td>
                                            <td class="style2" rowspan="3" valign="top">
                                            <!--Populates GridView1-->
                                        <asp:SqlDataSource ID="dsProjectUpdates" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_UpdateStatusMostRecent" SelectCommandType="StoredProcedure">                                        
                                        </asp:SqlDataSource>

                                  <span class="formLabel">Most Recent Project Status</span>
                                  <cc1:Grid id="GridView1" runat="server" DataSourceID="dsProjectUpdates" 
                                            AutoGenerateColumns="false" AllowFiltering="false" Width="100%" FolderStyle="Styles/style_5" 
                                            AllowSorting="true" AllowGrouping="false" AllowAddingRecords="false" 
                                                    AllowPageSizeSelection="false">
                                        <Columns>                                            
                                            <cc1:Column ID="Column1" HeaderText="Details" runat="server" templateID="tplProjectName" Width="60" />
                                            <cc1:Column ID="Column2" DataField="ProjectName" HeaderText="Project Name" runat="server" Wrap="true" Width="300" />                                           
                                            <cc1:Column ID="Column3" DataField="Status" HeaderText="Status" Align="center" runat="server" Width="60">
				                                <TemplateSettings TemplateID="ImageTemplate" />
				                            </cc1:Column>
                                        </Columns>

                                        <Templates>
                                            <cc1:GridTemplate runat="server" ID="tplProjectName">                    
                                            <Template>
                                                 <a href="project.updates.detail.aspx?ProjectID=<%# Container.DataItem("ProjectID")%>">
                                                     <img src="images/page_find.gif" border="0" /></a>                                                                
                                            </Template>                                                        
                                         </cc1:GridTemplate>
                                         <cc1:GridTemplate runat="server" ID="ImageTemplate">
					                        <Template><img src="images/<%# Container.Value %>.gif" alt="" width="12" height="12" border="0" /></Template>
				                        </cc1:GridTemplate>
                                        </Templates>                                        
                                        </cc1:Grid>
                                       </td>
                                        </tr>
                                        </table>
                                        <br /><br />
                                        <!--Week Ending Summary--> 
                                        <table width="100%"> 
                                        <tr>                                        
                                            <td align="left">
                                            <asp:SqlDataSource ID="dsWeekEndingSummary" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingSummary" SelectCommandType="StoredProcedure">                                        
                                        </asp:SqlDataSource>
                                           
                                            <span class="formLabel">Project Status History Summary</span>
                                            <cc1:Grid id="GridView2" runat="server" DataSourceID="dsWeekEndingSummary" 
                                            AutoGenerateColumns="false" AllowFiltering="false" Width="100%" FolderStyle="Styles/style_5" 
                                            AllowSorting="true" AllowGrouping="false" AllowAddingRecords="false" 
                                                    AllowPageSizeSelection="false">
                                        <Columns>                                            
                                            <cc1:Column ID="Column4" DataField="WeekEnding" HeaderText="Week Ending" runat="server" DataFormatString="{0:d}" />
                                            <cc1:Column ID="Column5" DataField="TotalProjects" HeaderText="Total Projects" runat="server" />                                           
                                            <cc1:Column ID="Column6" DataField="Status" HeaderText="Status" Align="center" runat="server" Width="60">
				                                <TemplateSettings TemplateID="StatusTemplate" />
				                            </cc1:Column>
                                        </Columns>

                                        <Templates>                                            
                                         <cc1:GridTemplate runat="server" ID="StatusTemplate">
					                        <Template><img src="images/<%# Container.Value %>.gif" alt="" width="12" height="12" border="0" /></Template>
				                        </cc1:GridTemplate>
                                        </Templates>                                        
                                        </cc1:Grid>
                                            
                                            </td>
                                        </tr>
                                                                                                                    
                                    </table> 

                                                                        
                                    
                                    
                                  

                                  </div> 
                                        
                                        </div>                                     
                                        
                                    
                                    </div>    

                                        
                                  </div>
                                 <%-- </ContentTemplate>
                                </asp:UpdatePanel>--%>
                            <p>&nbsp;</p>
                            <p>&nbsp;</p>                           
                  
                   
                     
                         </td>
                </tr>
            </table>
            </div>
        
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblProjectID" runat="server" Visible="false" />
    </form>
</body>
</html>
