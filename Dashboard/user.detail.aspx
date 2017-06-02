<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
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
            
            Dim intSelectedUserID As String = Request.QueryString("UserID")
            lblSelectedUserID.Text = intSelectedUserID
            
            'Set the All User Name dropdownlist to the selected user
            ddlUserName.SelectedValue = intSelectedUserID
            
            'This creates the list of checkboxes for the projects
            BindProjectsList(intSelectedUserID)
           
            'The user details section at the top of the page
            UserDetails(intSelectedUserID)
            
        End If
    End Sub
    
    Public Sub BindProjectsList(ByVal UserID As Integer)

        'This creates the list of checkboxes for the alert events types 
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim objReader As SqlDataReader
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("SELECT DISTINCT(ProjectName) AS ProjectName, ProjectID FROM Projects ORDER BY ProjectName", strSQLConn)

        strSQLConn.Open()
        cblProjectList.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        cblProjectList.DataTextField = "ProjectName"
        cblProjectList.DataValueField = "ProjectID"
        cblProjectList.DataBind()
        'Dim cmd As SqlCommmand
        cmd = New SqlCommand("SELECT ProjectName, ProjectID, Username, UserID FROM v_ProjectAssignments WHERE UserID=" & UserID, strSQLConn)
        strSQLConn.Open()
        objReader = cmd.ExecuteReader()
        While objReader.Read()
            Dim currentCheckBox As ListItem = cblProjectList.Items.FindByValue(objReader("ProjectID").ToString())
            If Not (currentCheckBox Is Nothing) Then
                currentCheckBox.Selected = True
            End If
        End While
        strSQLConn.Close()
    End Sub

    Public Sub UserDetails(ByVal UserID As Integer)
        'Response.Write("UserID " & ddlUserName.SelectedValue)
        
        Dim result As String = String.Empty
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("p_UserDetails", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", UserID)
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            While reader.Read()
                'lblUsername.Text = CType(reader("Username"), String)
                lblEmail.NavigateUrl = "mailto:" & CType(reader("Username"), String) & "@ed.gov"
                lblEmail.Text = CType(reader("Username"), String)
                lblDivisionName.Text = CType(reader("DivisionName"), String)
                chkActive.Checked = CType(reader("Active"), Boolean)
            End While
        End Using
    End Sub

    Protected Sub btnUpdateProjects_Click(sender As Object, e As System.EventArgs)
        'We first need to delete all of the records in the UserProjectAssignments table for this user
        ProjectAssignments_Delete()
        
        'Then we insert the new project assigment values
        ProjectAssignments_Insert()
    End Sub
    
    Sub ProjectAssignments_Delete()
        'Delete all of the records in the UserProjectAssignments table for this user
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UserProjectAssignments_Delete", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", ddlUserName.SelectedValue)
        
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Sub ProjectAssignments_Insert()
        'Insert the new project assigment values
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String
        Dim intUserID As Integer = CInt(ddlUserName.SelectedValue)

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        SqlText = "p_UserProjectAssignments_Insert"
        Try
            strSQLConn.Open()
            For Each Item As ListItem In cblProjectList.Items
                If (Item.Selected) Then
                    cmd = New SqlCommand(SqlText)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Connection = strSQLConn
                    'input parameters for the sproc
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = intUserID
                    cmd.Parameters.Add("@ProjectID", SqlDbType.Int).Value = Item.Value
                    cmd.ExecuteNonQuery()
                End If
            Next
        Finally
            strSQLConn.Close()
            lblSaveProjects.Visible = True
            lblSaveProjects.Text = "Project Assignments Have Been Updated"
        End Try
    End Sub

    Protected Sub ddlUserName_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        'This creates the list of checkboxes for the alert events types
        BindProjectsList(ddlUserName.SelectedValue)
           
        'The user details section at the top of the page
        UserDetails(ddlUserName.SelectedValue)
        
        'Reset the lblSaveProjects value
        lblSaveProjects.Text = ""
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - User Detail</title>
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
                                <li><a href="#tabs-1">User Details</a></li>                                
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

                                      <!--All Users-->
                                      <asp:SqlDataSource ID="dsAllUsers" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure">                                        
                                        </asp:SqlDataSource>                                      
                                      
                                      
                                      <!--Projects Assigned to the user-->
                                      <asp:SqlDataSource ID="dsUserProjectsAssigned" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_UserProjectsAssigned" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="UserID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource> 
                                    
                                     <div align="left" style="padding-top: 10px" id="tabs-1"> 
                                         <table border="0" width="98%">
                                            <tr>
                                                <td align="left"> </td>
                                                <td align="right" class="formLabel">User Name: 
                                                <asp:DropDownList ID="ddlUserName" runat="server" 
                                                DataSourceID="dsAllUsers" AppendDataBoundItems="true"
                                                DataTextField="UserName" DataValueField="UserID" AutoPostBack="true" 
                                                        onselectedindexchanged="ddlUserName_SelectedIndexChanged">
                                                <asp:ListItem Text="" Value="0" />                                                
                                            </asp:DropDownList></td>
                                            </tr>
                                         </table>                                    
                                         <h3>User Details</h3>
                                         <table width="600px">
                                         <tr>
                                            <td align="right" class="formLabel">User Name:</td>
                                            <td align="left"><asp:HyperLink ID="lblEmail" runat="server"/></td>
                                            <td align="right" class="formLabel">Department:</td>
                                            <td align="left"><asp:Label ID="lblDivisionName" runat="server" /></td>
                                         </tr>
                                         <tr>                                            
                                            <td align="right" class="formLabel">Active:</td>
                                            <td align="left"><asp:CheckBox ID="chkActive" runat="server" /></td>
                                            <td align="right" class="formLabel">Update History:</td>
                                            <td align="left"><asp:HyperLink ID="hypAllUpdates" runat="server" Text="Project Updates Made By This User" /></td>
                                         </tr>                                        
                                         </table>                                       
                                     <hr />
                                     <h3>Projects Assigned to This User</h3>
                                     <asp:Button ID="btnUpdateProjects" runat="server" Text="Update Project Assignments" OnClick="btnUpdateProjects_Click" />
                                     <asp:Label ID="lblSaveProjects" runat="server" CssClass="warning" />
                                     <DIV style="OVERFLOW-Y:scroll; WIDTH:100%; HEIGHT:400px">  
                                        <asp:CheckBoxList ID="cblProjectList" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" CellPadding="3" CellSpacing="4">
                                        </asp:CheckBoxList> 
                                     </DIV> 
                                     </div>
                                    
                                    </div>
                                        
                                  </div>
                               
                            <p>&nbsp;</p>
                            <p>&nbsp;</p>                      
                         </td>
                </tr>
            </table>
            </div>
        
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSelectedUserID" runat="server" Visible="false" />
   <asp:Label ID="lblProjectID" runat="server" Visible="false" />
    </form>
</body>
</html>
