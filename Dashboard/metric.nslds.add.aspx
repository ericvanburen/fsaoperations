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
        End If
    End Sub
    
    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_NSLDSMetricStatusAdd", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@WeekEndingID", ddlWeekEnding.SelectedValue)
        cmd.Parameters.AddWithValue("@CallsOffered", txtCallsOffered.Text)
        cmd.Parameters.AddWithValue("@Abandoned", txtCallsAbandoned.Text)
        cmd.Parameters.AddWithValue("@AvgSpeedAnswer", txtAvgSpeedAnswer.Text)
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.AddWithValue("@UpdateDate", DateTime.Now())
        
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your NSLDS metric status was successfully added"
                                                         
        Finally
            strSQLConn.Close()
        End Try
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
                                <li><a href="#tabs-1">Add NSLDS Call Center Performance Metric</a></li>                                
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
                               <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                    <div id="Div1">   

                                     <!--Week Ending Values-->
                                    <asp:SqlDataSource ID="dsWeekEnding" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingAll" SelectCommandType="StoredProcedure" />
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                    <table align="center" cellspacing="4" cellpadding="4">                                   
                                    <tr>
                                        <td class="style1">Week Ending:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlWeekEnding" runat="server" DataSourceID="dsWeekEnding" AppendDataBoundItems="true"
                                                DataTextField="WeekEnding" DataValueField="WeekEndingID">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList><br />
                                            <asp:RequiredFieldValidator ID="rfWeekEnding" runat="server" ErrorMessage="* Please select a Week Ending value *" ControlToValidate="ddlWeekEnding" CssClass="warning" Display="Dynamic" />
                                        </td>
                                        <td class="style1">Calls Offered:</td>
                                        <td>
                                            <asp:TextBox ID="txtCallsOffered" runat="server" /><br />
                                            <asp:RequiredFieldValidator ID="rfCallsOffered" runat="server" ErrorMessage="* Please enter Calls Offered *" ControlToValidate="txtCallsOffered" CssClass="warning" Display="Dynamic" />
                                        </td>
                                    </tr>                              
                                   
                                       <tr>
                                            <td class="style1">Calls Abandoned:</td>
                                            <td><asp:TextBox ID="txtCallsAbandoned" runat="server" /><br />
                                                <asp:RequiredFieldValidator ID="rfCallsAbandoned" runat="server" ErrorMessage="* Please enter the Calls Abandoned *" ControlToValidate="txtCallsAbandoned" CssClass="warning" Display="Dynamic" />
                                            </td>
                                            <td class="style1">Avg Speed of Answer:</td>
                                            <td><asp:Textbox ID="txtAvgSpeedAnswer" runat="server" /><br />
                                            <asp:RequiredFieldValidator ID="rfAvgSpeedAnswer" runat="server" ErrorMessage="* Please enter the Avg Speed of Answer *" ControlToValidate="txtAvgSpeedAnswer" CssClass="warning" Display="Dynamic" /></td>
                                        </tr>
                                        
                                    <tr>
                                        <td class="style1">&nbsp;<br /><br /></td>
                                        <td align="center" colspan="2">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Metric Update" CssClass="button" OnClick="btnSubmit_Click" />                                            
                                        </td>
                                    </tr>
                                     <tr>
                                        <td class="style1">&nbsp;</td>
                                        <td align="center" colspan="2">
                                            <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />
                                        </td>
                                    </tr>                                    
                                </table>                                    
                                    </div>
                                  </div>
                                  </ContentTemplate>
                                </asp:UpdatePanel>
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
