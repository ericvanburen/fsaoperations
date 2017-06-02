<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
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
        
        dsProjectName.SelectParameters.Item("UserID").DefaultValue = Convert.ToInt32(lblUserID.Text)
        
    End Sub
    
    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ProjectStatusAdd", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.AddWithValue("@ProjectID", ddlProjectName.SelectedValue)
        cmd.Parameters.AddWithValue("@StatusID", ddlStatus.SelectedValue)
        cmd.Parameters.AddWithValue("@WeekEndingID", ddlWeekEnding.SelectedValue)
        cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your project status was successfully added"
            
            'Clear the form
            ddlProjectName.SelectedValue = ""
            ddlStatus.SelectedValue = ""
            txtComments.Text = ""
                                                          
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        lblRecordStatus.Text = ""
    End Sub
    
      
   
       
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports</title>
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
                                <li><a href="#tabs-1">Add New Project Status</a></li>                                
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

                                     <!--Week Ending Values-->
                                    <asp:SqlDataSource ID="dsWeekEnding" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingAll" SelectCommandType="StoredProcedure" />

                                     <!--Project Name Values-->
                                        <asp:SqlDataSource ID="dsProjectName" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectsAllActive" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="UserID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>

                                     <!--Status Values-->
                                    <asp:SqlDataSource ID="dsStatus" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_StatusAll" SelectCommandType="StoredProcedure" />
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                    <table align="center" cellspacing="4" cellpadding="4" width="95%">
                                    <tr>
                                        <td class="style1">Week Ending:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlWeekEnding" runat="server" DataSourceID="dsWeekEnding" AppendDataBoundItems="true"
                                                DataTextField="WeekEnding" DataValueField="WeekEndingID">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList><br />
                                            <asp:RequiredFieldValidator ID="rfWeekEnding" runat="server" ErrorMessage="* Please select a Week Ending value *" ControlToValidate="ddlWeekEnding" CssClass="warning" Display="Dynamic" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style1">Project:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlProjectName" runat="server" DataSourceID="dsProjectName" AppendDataBoundItems="true"
                                            DataTextField="ProjectName" DataValueField="ProjectID">
                                                <asp:ListItem Text="" Value="" />                                                
                                            </asp:DropDownList><br />
                                            (Project not here? email <a href="mailto:eric.vanburen@ed.gov">Eric Van Buren</a>)<br />
                                            <asp:RequiredFieldValidator ID="rfProjectName" runat="server" ErrorMessage="* Please select a Project Name *" ControlToValidate="ddlProjectName" CssClass="warning" Display="Dynamic" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style1">Current Status:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" AppendDataBoundItems="true"
                                            DataTextField="Status" DataValueField="StatusID">
                                                <asp:ListItem Text="" Value="" />                                                
                                            </asp:DropDownList><br />
                                            <asp:RequiredFieldValidator ID="rfStatus" runat="server" ErrorMessage="* Please select a Status *" ControlToValidate="ddlStatus" CssClass="warning" Display="Dynamic" />
                                        </td>
                                    </tr>                                     
                                    <tr>
                                        <td class="style1">Comments:</td>
                                        <td>
                                            <asp:TextBox ID="txtComments" runat="server" Height="200px" TextMode="MultiLine" 
                                                Width="544px"></asp:TextBox>
                                        </td>
                                    </tr>
                                       
                                    <tr>
                                        <td class="style1">&nbsp;</td>
                                        <td align="center">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit Project Update" CssClass="button" OnClick="btnSubmit_Click" />
                                            
                                        </td>
                                    </tr>
                                    </table>                                    
                                    </div> 
                                   
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                    <table align="center" cellspacing="4" cellpadding="4" width="95%">
                                     <tr>
                                        <td class="style1">&nbsp;</td>
                                        <td align="center">
                                            <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />
                                            <asp:Timer ID="Timer1" runat="server" Interval="5000" OnTick="Timer1_Tick">
                                            </asp:Timer>
                                        </td>
                                    </tr>                                    
                                </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
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
