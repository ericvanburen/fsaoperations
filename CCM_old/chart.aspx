<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString

            Dim myCommand As New SqlCommand
            myCommand.Connection = myConnection
            myCommand.CommandText = "p_ReportCallCount"
            myCommand.CommandType = Data.CommandType.StoredProcedure

            myConnection.Open()
            Dim myReader As SqlDataReader = myCommand.ExecuteReader()

            'Bind the data using the DataBindTable method 
            
            'Chart1.Series(0).SmartLabelStyle.Enabled = False
            'Chart1.ChartAreas(0).AxisX.LabelStyle.Angle = -30
            'Chart1.ChartAreas(0).AxisX.LabelStyle.IsStaggered = True
            'Chart1.ChartAreas(0).AxisX.LabelStyle.TruncatedLabels = True
            'Chart1.ChartAreas(0).AxisX.LabelStyle.IsEndLabelVisible = True
           
            'ChtCallCount.Series("CallCount").Points.DataBindXY(myReader, "CallCenter", myReader, "CallCount")
            'ChtCallCount.Series("CallCount").XValueMember = myReader("CallCenter")
            'ChtCallCount.Series("CallCount").YValueMembers = myReader("CallCount")  
                        
            'Use this one as a default for each value/series in the table - remove any series value in the chart
            ChtCallCount.DataBindTable(myReader, "CallCenter")
            'ChtCallCount.Series(0).IsValueShownAsLabel = "True"
            'ChtCallCount.Series(1).IsValueShownAsLabel = "True"
                     
            myReader.Close()
            myConnection.Close()
            
        End Using
    End Sub
  
    Protected Sub ChtFailedCalls_Load(sender As Object, e As System.EventArgs)
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString

            Dim myCommand As New SqlCommand
            myCommand.Connection = myConnection
            myCommand.CommandText = "p_CallCount"
            myCommand.CommandType = Data.CommandType.StoredProcedure

            myConnection.Open()
            Dim myReader As SqlDataReader = myCommand.ExecuteReader()
           
            ChtFailedCalls.Series("FailedCalls").Points.DataBindXY(myReader, "CallCenter", myReader, "FailedCalls")
                     
            myReader.Close()
            myConnection.Close()
        End Using
    End Sub
    
    Protected Sub CheckBox1_CheckedChanged(sender As Object, e As System.EventArgs)
        If CheckBox1.Checked = True Then
            ChtCallCount.Series(0).IsValueShownAsLabel = True
            ChtCallCount.Series(1).IsValueShownAsLabel = True
        Else
            ChtCallCount.Series(0).IsValueShownAsLabel = False
            ChtCallCount.Series(1).IsValueShownAsLabel = False
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
       <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
            SelectCommand="p_CallCount" SelectCommandType="StoredProcedure">
        </asp:SqlDataSource>
        
          
       <asp:CheckBox ID="CheckBox1" runat="server" Text="Show labels" OnCheckedChanged="CheckBox1_CheckedChanged" AutoPostBack="true" />

       <asp:chart id="ChtCallCount" runat="server" BackColor="#D3DFF0" Width="800px" Height="450px" BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
							<titles>
								<asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3" Text="Calls By Call Center" ForeColor="26, 59, 105"></asp:Title>
							</titles>
							<legends>
								<asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"></asp:Legend>
							</legends>
							<borderskin SkinStyle="Emboss"></borderskin>
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




      
      <p></p>

       <asp:chart id="ChtFailedCalls" onload="ChtFailedCalls_Load" runat="server" BackColor="#D3DFF0" Width="800px" Height="450px" BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White" BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
							<titles>
								<asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3" Text="Failed Calls By Call Center" ForeColor="26, 59, 105"></asp:Title>
							</titles>
							<legends>
								<asp:Legend Enabled="False" IsTextAutoFit="False" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold"></asp:Legend>
							</legends>
							<borderskin SkinStyle="Emboss"></borderskin>
							<series>
								<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="FailedCalls" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series>                                
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
   <%-- <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource1" 
        onload="Chart2_Load" Height="470px" Width="643px">
        <series>
            <asp:Series ChartType="Pie" Name="Series1" XValueMember="CallCenter" 
                YValueMembers="CallCount" Legend="CallCenters">
            </asp:Series>
        </series>
        <chartareas>
            <asp:ChartArea Name="ChartArea1">
                <AxisX IsLabelAutoFit="False" IsMarksNextToAxis="False" 
                    Title="Call Center Calls Reviewed">
                </AxisX>
                <Area3DStyle Enable3D="True" />
            </asp:ChartArea>
        </chartareas>
        <Legends>
            <asp:Legend Name="CallCenters" Title="Calls Reviewed">
            </asp:Legend>
        </Legends>
    </asp:Chart>--%>
    </div>
    </form>
</body>
</html>
