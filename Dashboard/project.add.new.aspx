﻿<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
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
        
        'Look up the user's DivisionID
        lblDivisionID.Text = DivisionIDLookup.ToString()
    End Sub
    
    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ProjectAddNew", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@ProjectName", txtProjectName.Text)
        cmd.Parameters.AddWithValue("@Description", txtDescription.Text)
        cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text)
        cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text)
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.AddWithValue("@Approved", False)
        cmd.Parameters.AddWithValue("@DivisionID", lblDivisionID.Text)
           
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your new project was submitted for approval"
                                               
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
        
    Private Function DivisionIDLookup() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_DivisionIDLookup", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
       
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
                                <li><a href="#tabs-1">Submit New Project</a></li>                                
                            </ul>
                            
                            <!--Navigation Menu-->
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
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                    <table align="center" cellspacing="4" cellpadding="4">                                    
                                    <tr>
                                        <td colspan="4">Please complete this form only to submit a <u>new</u> project to Jana for approval. Submitting a project is required to begin tracking this project
                                        on the dashboard reports.</td>
                                    </tr>
                                    <tr>
                                        <td class="style1">Project Name:</td>
                                        <td colspan="3"><asp:TextBox ID="txtProjectName" runat="server" Columns="50" /><br />
                                            <asp:RequiredFieldValidator ID="rfdProjectName" runat="server" CssClass="warning" ControlToValidate="txtProjectName" ErrorMessage="Please enter a project name" Display="Dynamic" />
                                        </td>
                                    </tr>
                                    
                                     <tr>
                                            <td class="style1">Project Start Date:</td>
                                            <td>                                                
                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender1" runat="server" targetcontrolid="txtStartDate" />
                                                            <asp:TextBox ID="txtStartDate" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="rfdStartDate" runat="server" ErrorMessage="Please enter a project start date" CssClass="warning" ControlToValidate="txtStartDate" Display="Dynamic" />                                                           
                                                        </ContentTemplate>
                                                 </asp:UpdatePanel>
                                            </td>
                                            <td class="style1">Projected End Date:</td>
                                            <td><asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender2" runat="server" targetcontrolid="txtEndDate" />
                                                            <asp:TextBox ID="txtEndDate" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="rfdEndDate" runat="server" ErrorMessage="Please enter a project end date" CssClass="warning" ControlToValidate="txtEndDate" Display="Dynamic" />                                                           
                                                        </ContentTemplate>
                                                 </asp:UpdatePanel></td>
                                     </tr>
                                    
                                    <tr>
                                        <td class="style1">Project Description:</td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtDescription" runat="server" Height="200px" TextMode="MultiLine" Width="544px" /><br />
                                            <asp:RequiredFieldValidator ID="rfdDescription" runat="server" ErrorMessage="Please enter a project description" CssClass="warning" ControlToValidate="txtDescription" Display="Dynamic" />
                                        </td>
                                    </tr>
                                       
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit New Project" CssClass="button" OnClick="btnSubmit_Click" />
                                        </td>
                                    </tr>
                                     <tr>
                                        <td align="center" colspan="4">
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
                         </td>
                </tr>
            </table>
            </div>
        
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblDivisionID" runat="server" Visible="false" />
    </form>
</body>
</html>
