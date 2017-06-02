<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Import Namespace='System.Collections.Generic' %> 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
   Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control) 
   
    End Sub


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
        
            GridView1.PageSize = 50
            'BindChart1()
        End If
    End Sub
       
    Sub GridView1_RowDataBound(Sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(3).Text = "Green" Then
                e.Row.Cells(3).BackColor = System.Drawing.Color.LightGreen
            ElseIf e.Row.Cells(3).Text = "Yellow" Then
                e.Row.Cells(3).BackColor = System.Drawing.Color.LemonChiffon
            ElseIf e.Row.Cells(3).Text = "Red" Then
                e.Row.Cells(3).BackColor = System.Drawing.Color.Tomato
            End If
        End If
    End Sub
    
      
    Sub btnExportExcel_Click(ByVal sender As Object, e As EventArgs)
        ExportGridToExcel()
    End Sub
    
    Private Sub ExportGridToExcel()
        GridView1.AllowSorting = False
        GridView1.AllowPaging = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=DashboardMetricStatusReport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
   
    'Sub BindChart1()
    
    '    Using myConnection As New SqlConnection
    '        myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString

    '        Dim cmd As New SqlCommand
    '        cmd.Connection = myConnection
    '        cmd.CommandText = "p_DivisionMetricsCallCenterBranchChart"
    '        cmd.CommandType = Data.CommandType.StoredProcedure
            
    '        myConnection.Open()
    '        'Dim myReader As SqlDataReader = cmd.ExecuteReader()
            
    '        ''Use this one as a default for each value/series in the table - remove any series value in the chart
    '        ''Chart1.DataBindTable(myReader, "MetricName")
    '        'Chart1.Series(0).Points.DataBindXY(myReader, "MetricName", myReader, "NoAssigned")

           
    '        'Chart1.Series(0).IsValueShownAsLabel = False
    '        'Chart1.Series(1).IsValueShownAsLabel = False          
                     
              
    '        ' Initializes a new instance of the OleDbDataAdapter class
    '        Dim myDataAdapter As New SqlDataAdapter()
    '        myDataAdapter.SelectCommand = cmd
   
    '        ' Initializes a new instance of the DataSet class
    '        Dim myDataSet As New DataSet()
   
    '        ' Adds rows in the DataSet
    '        myDataAdapter.Fill(myDataSet, "Query")
   
    '        Dim row As DataRow
    '        For Each row In myDataSet.Tables("Query").Rows
    '            ' for each Row, add a new series
    '            Dim seriesName As String = row("MetricName").ToString()
    '            Chart1.Series.Add(seriesName)
    '            Chart1.Series(seriesName).ChartType = SeriesChartType.Line
                
    '            Chart1.Series(seriesName).BorderWidth = 2
      
    '            Dim colIndex As Integer
    '            For colIndex = 1 To (myDataSet.Tables("Query").Columns.Count) - 1
    '                ' for each column (column 1 and onward), add the value as a point
    '                Dim columnName As String = myDataSet.Tables("Query").Columns(colIndex).ColumnName
    '                Dim YVal As Integer = CInt(row(columnName))
    '                'Dim YVal As Date = CDate(row(columnName))
         
    '                Chart1.Series(seriesName).Points.AddXY(columnName, YVal)
    '            Next colIndex
    '        Next row
   
    '        'DataGrid.DataSource = myDataSet
    '        'DataGrid.DataBind()
   
    '        ' Closes the connection to the data source. This is the preferred 
    '        ' method of closing any open connection.
    '        cmd.Connection.Close()
            
    '    End Using
    'End Sub
    
    

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - All Metric Updates</title>
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
                                <li><a href="#tabs-1">All Metrics</a></li>                                
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
                            
                                    <div id="Div1">   

                                    <!--Populates GridView1-->
                                    <asp:SqlDataSource ID="dsMetricUpdates" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_DivisionMetricsUpdatesCallCenterBranch" SelectCommandType="StoredProcedure">                                        
                                        </asp:SqlDataSource>                                    

                                                                                                               
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        
                                        <table border="0" width="100%">
                                            <tr>
                                                <td align="left"><h2><asp:Label ID="lblPageHeader" runat="server" Text="Current Metrics Status - Call Center Branch" /></h2></td>                                                                                               
                                            </tr>
                                            <tr>
                                                <td>
                                                    <%--<asp:chart id="Chart1" runat="server" BackColor="WhiteSmoke" 
                                                        BackSecondaryColor="White" BackGradientStyle="TopBottom" 
                                                        BorderDashStyle="Solid" Palette="BrightPastel" BorderColor="26, 59, 105" 
                                                        Height="296px" Width="878px" BorderWidth="2" 
                                                        ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
							<legends>
								<asp:Legend IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"></asp:Legend>
							</legends>
							<borderskin SkinStyle="Emboss"></borderskin>
							<chartareas>
								<asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid" BackSecondaryColor="White" BackColor="Gainsboro" ShadowColor="Transparent" BackGradientStyle="TopBottom">
									<area3dstyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False" />
									<axisy LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
										<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
										<MajorGrid LineColor="64, 64, 64, 64" />
									</axisy>
									<axisx LineColor="64, 64, 64, 64">
										<LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IntervalType="Auto" />
										<MajorGrid Interval="Auto" IntervalType="Auto" LineColor="64, 64, 64, 64" />
										<MajorTickMark IntervalType="Auto" />
									</axisx>
								</asp:ChartArea>
							</chartareas>
						</asp:chart>--%>
                                                </td>
                                            </tr>
                                        </table>
                                        <div class="grid">
                                        <asp:GridView id="GridView1" runat="server" DataSourceID="dsMetricUpdates" OnRowDataBound="GridView1_RowDataBound" 
                                            AutoGenerateColumns="false" Width="100%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                                         AllowSorting="true">
                                        <RowStyle CssClass="row" />
                                        <HeaderStyle CssClass="gridcolumnheader" />
                                        <Columns>                                                                             
                                            <asp:TemplateField HeaderText=" ">
                                                <ItemTemplate>
                                                     <a href="metric.call.center.view.all.aspx?MetricID=<%# Container.DataItem("MetricID")%>">
                                                     <img src="images/page_find.gif" border="0" alt="Find" /></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>                                       
                                            <asp:BoundField DataField="MetricName" HeaderText="Metric Name" runat="server" SortExpression="MetricName" />
                                            <asp:HyperLinkField 
                                                DataTextField="WeekEnding" 
                                                HeaderText="Week Ending" 
                                                DataNavigateUrlFields="MetricUpdateID" 
                                                SortExpression="WeekEnding"  
                                                ItemStyle-CssClass="first" 
                                                DataTextFormatString="{0:d}"                                            
                                                DataNavigateUrlFormatString="metric.call.center.updates.detail.aspx?MetricUpdateID={0}">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                </asp:HyperLinkField>                                             
                                            <asp:BoundField DataField="Status" HeaderText="Status" runat="server" SortExpression="Status" ItemStyle-HorizontalAlign="Center" />                                            
                                            <%--These three columns are used only by the call center branch--%>
                                            <asp:BoundField DataField="NoAssigned" HeaderText="No Assigned" SortExpression="NoAssigned" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                            <asp:BoundField DataField="NoMonitored" HeaderText="No Monitored" SortExpression="NoMonitored" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                            <asp:BoundField DataField="PassFail" HeaderText="Pass/Fail" SortExpression="PassFail" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="Comments" HeaderText="Comments" runat="server" ItemStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="Username" HeaderText="Entered By" runat="server" SortExpression="Username" />                                                                                      
                                        </Columns>
                                        </asp:GridView>
                                        </div>
                                        <br />
                                        <div align="center">
                                        <asp:Button ID="btnExportExcel" runat="server" Text="Export records to Excel" OnClick="btnExportExcel_Click" CssClass="button" />
                                        </div>
                                        
                                        <br />                                    
                                    </div> 
                                  </div>
                            <p>&nbsp;</p>
                            <p>&nbsp;</p>
                         </div>
                         </td>
                </tr>
            </table>
            </div>
        
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
    </form>
</body>
</html>
