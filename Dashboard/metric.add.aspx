<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

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
        
            'There are two panels containing metrics - one for Call Center the other for everyone else
            pnlOther.Visible = True
        End If
    End Sub
    
    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_MetricStatusAdd", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@MetricID", ddlMetricName.SelectedValue)
        cmd.Parameters.AddWithValue("@Aging", txtAging.Text)
        cmd.Parameters.AddWithValue("@VolumeReceived", txtVolumeReceived.Text)
        cmd.Parameters.AddWithValue("@VolumeCompleted", txtVolumeCompleted.Text)
        cmd.Parameters.AddWithValue("@NoAssigned", txtNoAssigned.Text)
        cmd.Parameters.AddWithValue("@NoMonitored", txtNoMonitored.Text)
        cmd.Parameters.AddWithValue("@PassFail", ddlPassFail.SelectedValue)
        cmd.Parameters.AddWithValue("@Pending", txtPending.Text)
        cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        cmd.Parameters.AddWithValue("@WeekEndingID", ddlWeekEnding.SelectedValue)
        cmd.Parameters.AddWithValue("@StatusID", ddlStatus.SelectedValue)
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now())
        
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your metric status was successfully added"
            
            'Clear the form
            ddlStatus.SelectedValue = ""
            txtVolumeReceived.Text = ""
            txtVolumeCompleted.Text = ""
            txtNoAssigned.Text = ""
            txtNoMonitored.Text = ""
            ddlPassFail.SelectedValue = ""
            txtPending.Text = ""
            txtAging.Text = ""
            txtComments.Text = ""
                                               
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
   
    Protected Sub ddlDivision_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        ddlMetricName.Items.Clear()
        dsMetricName.SelectParameters.Item("DivisionID").DefaultValue = ddlDivision.SelectedValue
        If ddlDivision.SelectedValue = "2" Then
            pnlCallCenter.Visible = True
            pnlOther.Visible = False
        Else
            pnlCallCenter.Visible = False
            pnlOther.Visible = True
        End If
    End Sub
    
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        lblRecordStatus.Text = ""
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard - Add New Metric Status</title>
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
            text-align: right;
        }
    </style>
        
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
        
        <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                 <img src="images/fSA_logo_dashboard.gif" alt="Federal Student Aid - Dashboard Reports" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Add Performance Metric</a></li>                                
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

                                      <!--Division Values-->
                                    <asp:SqlDataSource ID="dsDivisions" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_DivisionsMetrics" SelectCommandType="StoredProcedure" />

                                     <!--Week Ending Values-->
                                    <asp:SqlDataSource ID="dsWeekEnding" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingAll" SelectCommandType="StoredProcedure" />

                                     <!--Metric Name Values-->
                                        <asp:SqlDataSource ID="dsMetricName" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_Metrics_Divisions" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="DivisionID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>

                                     <!--Status Values-->
                                    <asp:SqlDataSource ID="dsStatus" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_StatusAll" SelectCommandType="StoredProcedure" />
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                    <table align="center" cellspacing="4" cellpadding="4">
                                     <tr>
                                        <td class="style1">Step 1: Select Your Division:</td>
                                        <td colspan="3">
                                            <asp:DropDownList ID="ddlDivision" runat="server" DataSourceID="dsDivisions" DataTextField="DivisionName" DataValueField="DivisionID"                                             
                                                onselectedindexchanged="ddlDivision_SelectedIndexChanged" AppendDataBoundItems="true" AutoPostBack="true">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList><br />
                                            <asp:RequiredFieldValidator ID="rfDivision" runat="server" ErrorMessage="* Please select a Division *" ControlToValidate="ddlDivision" CssClass="warning" Display="Dynamic" />
                                        </td>
                                         
                                    </tr>
                                        <tr>
                                            <td class="style1">Metric Name:</td>
                                            <td colspan="3">
                                                <asp:DropDownList ID="ddlMetricName" runat="server" AppendDataBoundItems="true" 
                                                    DataSourceID="dsMetricName" DataTextField="MetricName" 
                                                    DataValueField="MetricID">
                                                    <asp:ListItem Text="" Value="" />
                                                </asp:DropDownList><br />
                                                <asp:RequiredFieldValidator ID="rfMetricName" runat="server" ErrorMessage="* Please select a Metric Name *" ControlToValidate="ddlMetricName" CssClass="warning" Display="Dynamic" />
                                            </td>
                                        </tr>
                                    <tr>
                                        <td class="style1">Week Ending:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlWeekEnding" runat="server" DataSourceID="dsWeekEnding" AppendDataBoundItems="true"
                                                DataTextField="WeekEnding" DataValueField="WeekEndingID">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList><br />
                                            <asp:RequiredFieldValidator ID="rfWeekEnding" runat="server" ErrorMessage="* Please select a Week Ending value *" ControlToValidate="ddlWeekEnding" CssClass="warning" Display="Dynamic" />
                                        </td>
                                        <td class="style1">Current Status:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" AppendDataBoundItems="true"
                                            DataTextField="Status" DataValueField="StatusID">
                                                <asp:ListItem Text="" Value="" />                                                
                                            </asp:DropDownList><br />
                                            <asp:RequiredFieldValidator ID="rfStatus" runat="server" ErrorMessage="* Please select a Status *" ControlToValidate="ddlStatus" CssClass="warning" Display="Dynamic" />
                                        </td>
                                    </tr>                              
                                   
                                     <asp:Panel ID="pnlCallCenter" runat="server" Visible="false">
                                       <tr>
                                            <td class="style1">Number Assigned:</td>
                                            <td><asp:Textbox ID="txtNoAssigned" runat="server" Text="50" /><br />
                                                <asp:RequiredFieldValidator ID="rfNoAssigned" runat="server" ErrorMessage="* Please enter the Number Assigned *" ControlToValidate="txtNoAssigned" CssClass="warning" Display="Dynamic" /><br />
                                                <asp:CompareValidator ID="cmpNoAssigned" runat="server" Operator="DataTypeCheck" Type="Integer"   ControlToValidate="txtNoAssigned" ErrorMessage="* Number Assigned value must be a whole number *" CssClass="warning" Display="Dynamic" />
                                            </td>
                                            <td class="style1">Number Monitored:</td>
                                            <td><asp:Textbox ID="txtNoMonitored" runat="server" /><br />
                                            <asp:RequiredFieldValidator ID="rfNoMonitored" runat="server" ErrorMessage="* Please enter the Number Monitored *" ControlToValidate="txtNoMonitored" CssClass="warning" Display="Dynamic" /><br />
                                            <asp:CompareValidator ID="cmpNoMonitored" runat="server" Operator="DataTypeCheck" Type="Integer"   ControlToValidate="txtNoMonitored" ErrorMessage="* Number Monitored value must be a whole number *" CssClass="warning" Display="Dynamic" /></td>
                                        </tr>
                                        <tr>
                                            <td class="style1">Pass/Fail</td>
                                            <td colspan="3"><asp:DropDownList ID="ddlPassFail" runat="server">
                                                <asp:ListItem Text="" Value="" Selected="True" />
                                                <asp:ListItem Text="Pass" Value="Pass" />
                                                <asp:ListItem Text="Fail" Value="Fail" />
                                            </asp:DropDownList></td>
                                        </tr>
                                     </asp:Panel>
                                     
                                     <asp:Panel ID="pnlOther" runat="server" Visible="false"> 
                                        <tr>
                                            <td class="style1">Volume Received:</td>
                                            <td><asp:Textbox ID="txtVolumeReceived" runat="server" /><br />
                                                <asp:RequiredFieldValidator ID="rfVolumeReceived" runat="server" ErrorMessage="* Please enter the Volume Received *" ControlToValidate="txtVolumeReceived" CssClass="warning" Display="Dynamic" /><br />
                                                <asp:CompareValidator ID="cmpVolumeReceived" runat="server" Operator="DataTypeCheck" Type="Integer"   ControlToValidate="txtVolumeReceived" ErrorMessage="* Volume Received value must be a whole number *" CssClass="warning" Display="Dynamic" />
                                            </td>
                                            <td class="style1">Volume Completed:</td>
                                            <td><asp:Textbox ID="txtVolumeCompleted" runat="server" /><br />
                                            <asp:RequiredFieldValidator ID="rfVolumeCompleted" runat="server" ErrorMessage="* Please enter the Volume Completed *" ControlToValidate="txtVolumeCompleted" CssClass="warning" Display="Dynamic" /><br />
                                            <asp:CompareValidator ID="cmpVolumeCompleted" runat="server" Operator="DataTypeCheck" Type="Integer"   ControlToValidate="txtVolumeCompleted" ErrorMessage="* Volume Completed value must be a whole number *" CssClass="warning" Display="Dynamic" /></td>
                                        </tr>
                                        <tr>
                                            <td class="style1">Pending:</td>
                                            <td><asp:Textbox ID="txtPending" runat="server" /><br />
                                            <asp:RequiredFieldValidator ID="rfPending" runat="server" ErrorMessage="* Please enter the number pending *" ControlToValidate="txtPending" CssClass="warning" Display="Dynamic" /><br />
                                            <asp:CompareValidator ID="cmpPending" runat="server" Operator="DataTypeCheck" Type="Integer"   ControlToValidate="txtPending" ErrorMessage="* Pending value must be a whole number *" CssClass="warning" Display="Dynamic" /></td>
                                            <td class="style1">Aging:</td>
                                            <td><asp:Textbox ID="txtAging" runat="server" /><br />
                                            <asp:RequiredFieldValidator ID="rfAging" runat="server" ErrorMessage="* Please enter the number aging *" ControlToValidate="txtAging" CssClass="warning" Display="Dynamic" /><br />
                                            <asp:CompareValidator ID="cmpAging" runat="server" Operator="DataTypeCheck" Type="Integer"   ControlToValidate="txtAging" ErrorMessage="* Aging value must be a whole number *" CssClass="warning" Display="Dynamic" /></td>
                                        </tr>
                                      </asp:Panel>
                                    <tr>
                                        <td class="style1">Comments:</td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtComments" runat="server" Height="200px" TextMode="MultiLine" Width="544px" />
                                        </td>
                                    </tr>
                                       
                                    <tr>
                                        <td class="style1">&nbsp;</td>
                                        <td align="center" colspan="2">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Metric Update" CssClass="button" OnClick="btnSubmit_Click" />
                                        </td>
                                    </tr>
                                    </table>

                                    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                    <ContentTemplate>
                                    <table align="center" cellspacing="4" cellpadding="4">
                                     <tr>
                                        <td class="style1">&nbsp;</td>
                                        <td align="center" colspan="2">
                                            <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />
                                            <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick">
                                            </asp:Timer>
                                        </td>
                                    </tr>                                    
                                   </table>
                                   </ContentTemplate>
                                   </asp:UpdatePanel>
                                    
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
