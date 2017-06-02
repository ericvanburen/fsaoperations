<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
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
        
            'Check the Pending only checkbox
            chkPendingOnly.Checked = True
            dsProjectApproval.SelectCommand = "p_ProjectsNewPending"
                        
        End If
    End Sub
    
        
    'Sub CreateGrid()
    '    Dim strSQLConn As SqlConnection
    '    Dim cmd As SqlCommand
    '    Dim da As SqlDataAdapter
    '    Dim ds As DataSet
    '    Dim dr As SqlDataReader
        
    '    strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
    '    cmd = New SqlCommand("p_ProjectsNew", strSQLConn)
    '    cmd.CommandType = CommandType.StoredProcedure
    '    'cmd.Parameters.AddWithValue("@Approved", False)
        
    '    Try
    '        strSQLConn.Open()
    '        da = New SqlDataAdapter()
    '        ds = New DataSet()
    '        da.SelectCommand = cmd
    '        da.Fill(ds, "Projects")
    '        dr = cmd.ExecuteReader()
    '        GridView1.DataSource = dr
    '        GridView1.DataBind()
    '    Finally
    '        strSQLConn.Close()
    '    End Try
    'End Sub

    'Protected Sub btnMultipleRowUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)
    
    '    Dim strSQLConn As SqlConnection
    '    Dim cmd As SqlCommand
    '    Dim ProjectID As Integer
        
    '    strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
    '    cmd = New SqlCommand("p_ProjectNewApproveUpdate", strSQLConn)
    '    cmd.CommandType = CommandType.StoredProcedure
        
    '    ' Looping through all the rows in the GridView
    '    For Each row As GridViewRow In GridView1.Rows
    '        Dim checkbox As CheckBox = CType(row.FindControl("cbRows"), CheckBox)

    '        'Check if the checkbox is checked. 
    '        If checkbox.Checked Then
        
    '            cmd.Parameters.Add("@ProjectNewID", SqlDbType.Int).Value = e.Record("ProjectNewID")
    '            cmd.Parameters.Add("@ProjectName", SqlDbType.VarChar).Value = e.Record("ProjectName")
    '            cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = e.Record("Description")
    '            cmd.Parameters.Add("@StartDate", SqlDbType.SmallDateTime).Value = e.Record("StartDate")
    '            cmd.Parameters.Add("@EndDate", SqlDbType.SmallDateTime).Value = e.Record("EndDate")
    '            cmd.Parameters.Add("@DivisionID", SqlDbType.Int).Value = e.Record("DivisionID")
    '            cmd.Parameters.Add("@ProjectID", SqlDbType.Int)
    '            cmd.Parameters("@ProjectID").Direction = ParameterDirection.Output
            
    '            Try
    '                strSQLConn.Open()
    '                cmd.Connection = strSQLConn
    '                cmd.ExecuteNonQuery()
    '                ProjectID = cmd.Parameters("@ProjectID").Value
    '            Finally
    '                strSQLConn.Close()
    '            End Try
    '        End If
    '    Next
        
    '    CreateGrid()
        
    '    'Now we need to insert the new project which was inserted into the projects table into the UserProjectAssignments table
    '    UserProjectAssignment(ProjectID)
        
    'End Sub
    
      
    Protected Sub btnMultipleRowApprove_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Approves Selected Projects
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ProjectID As Integer
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ProjectNewApproveUpdate", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
               
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            'Retreive the ProjectNewID
            Dim ProjectNewID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
            
            Dim checkbox As CheckBox = CType(row.FindControl("chkRows"), CheckBox)
            Dim strProjectNewID As String = DirectCast(row.FindControl("lblProjectNewID"), Label).Text
            Dim strProjectName As String = DirectCast(row.FindControl("lblProjectName"), Label).Text
            Dim strDescription As String = DirectCast(row.FindControl("lblDescription"), Label).Text
            Dim strStartDate As String = DirectCast(row.FindControl("lblStartDate"), Label).Text
            Dim strEndDate As String = DirectCast(row.FindControl("lblEndDate"), Label).Text
            Dim strDivisionID As String = DirectCast(row.FindControl("lblDivisionID"), Label).Text
	
            'Check if the checkbox is checked. 
            If checkbox.Checked Then

                cmd.Parameters.Add("@ProjectNewID", SqlDbType.Int).Value = strProjectNewID
                'We want to add the appropriate prefix to the project name depending on which DivisionID they are in
                Dim strProjectPrefix = ""
                Select Case (strDivisionID).ToString
                    Case "1"
                        strProjectPrefix = "Processing Division"
                    Case "2"
                        strProjectPrefix = "Call Center Branch"
                    Case "3"
                        strProjectPrefix = "Operations Services"
                    Case "6"
                        strProjectPrefix = "SL"
                    Case "11"
                        strProjectPrefix = "Training"
                End Select
                cmd.Parameters.Add("@ProjectName", SqlDbType.VarChar).Value = strProjectPrefix & " - " & strProjectName
                cmd.Parameters.Add("@Description", SqlDbType.VarChar).Value = strDescription
                cmd.Parameters.Add("@StartDate", SqlDbType.SmallDateTime).Value = strStartDate
                cmd.Parameters.Add("@EndDate", SqlDbType.SmallDateTime).Value = strEndDate
                cmd.Parameters.Add("@DivisionID", SqlDbType.Int).Value = strDivisionID
                cmd.Parameters.Add("@ProjectID", SqlDbType.Int)
                cmd.Parameters("@ProjectID").Direction = ParameterDirection.Output
                
                Try
                    strSQLConn.Open()
                    cmd.Connection = strSQLConn
                    cmd.ExecuteNonQuery()
                    ProjectID = cmd.Parameters("@ProjectID").Value
                Finally
                    strSQLConn.Close()
                End Try
            End If
        Next row
        
        lblUpdateStatus.Text = "The selected projects were approved"
        
        'Now we need to insert the new project which was inserted into the projects table into the UserProjectAssignments table
        UserProjectAssignment(ProjectID)
    End Sub
    
    Protected Sub btnMultipleRowDeny_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Denies Selected Projects
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
       
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ProjectNewDenyUpdate", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
               
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            'Retreive the ProjectNewID
            Dim ProjectNewID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
            
            Dim checkbox As CheckBox = CType(row.FindControl("chkRows"), CheckBox)
            Dim strProjectNewID As String = DirectCast(row.FindControl("lblProjectNewID"), Label).Text
            
            'Check if the checkbox is checked. 
            If checkbox.Checked Then

                cmd.Parameters.Add("@ProjectNewID", SqlDbType.Int).Value = strProjectNewID
                Try
                    strSQLConn.Open()
                    cmd.Connection = strSQLConn
                    cmd.ExecuteNonQuery()
                Finally
                    strSQLConn.Close()
                End Try
            End If
        Next row
        
        lblUpdateStatus.Text = "The selected projects were not approved"
        GridView1.DataBind()
       
    End Sub
    
    Sub UserProjectAssignment(ByVal ProjectID As Integer)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
               
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UserProjectAssignments_AddNew", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = lblUserID.Text
        cmd.Parameters.Add("@ProjectID", SqlDbType.Int).Value = ProjectID
                   
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Public Shared Function TrueFalse(ByVal MyValue As Boolean) As String
        Dim result As String = String.Empty
        If MyValue = True Then
            Return "Yes"
        Else
            Return "No"
        End If
        Return result
    End Function
       
    Protected Sub chkPendingOnly_CheckedChanged(sender As Object, e As System.EventArgs)
        If chkPendingOnly.Checked Then
            dsProjectApproval.SelectCommand = "p_ProjectsNewPending"
        Else
            dsProjectApproval.SelectCommand = "p_ProjectsNew"
        End If
        GridView1.DataBind()
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - Approve New Project</title>
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
    
    <fieldset class="fieldset">
        
        <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                 <img src="images/fSA_logo_dashboard.gif" alt="Federal Student Aid - Dashboard Reports" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Approve New Project</a></li>                                
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

                            <div id="Div1">
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                                                        
                                    <asp:SqlDataSource ID="dsProjectApproval" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectsNew" SelectCommandType="StoredProcedure" 
                                        UpdateCommand="p_ProjectNewApproveUpdate" UpdateCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <%--<asp:Parameter Name="Approved" Type="Boolean" DefaultValue=False />--%>
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ProjectNewID" Type="Int32" />
                                            <asp:Parameter Name="ProjectName" Type="String" />
                                            <asp:Parameter Name="Description" Type="String" />
                                            <asp:Parameter Name="StartDate" Type="DateTime" />
                                            <asp:Parameter Name="EndDate" Type="DateTime" />
                                            <asp:Parameter Name="DivisionID" Type="Int32" />                                           
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                    
                                    <h3>Projects Awaiting Approval</h3>
                                    <asp:Button ID="btnMultipleRowApprove" OnClick="btnMultipleRowApprove_Click" runat="server" Text="Approve Selected Projects" OnClientClick="return confirm('Are you sure you want to approve the selected projects?')" />
                                    <asp:Button ID="btnMultipleRowDeny" OnClick="btnMultipleRowDeny_Click" runat="server" Text="Deny Selected Projects" OnClientClick="return confirm('Are you sure you want to deny the selected projects?')" />
                                    <asp:CheckBox ID="chkPendingOnly" runat="server" oncheckedchanged="chkPendingOnly_CheckedChanged" Text="Show Only Projects Pending Approval" AutoPostBack="true" />
                                    <br />
                                    <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warning" Font-Size="Small" />
                                    <br /><br />
                                    <div class="grid">
                                        <asp:GridView id="GridView1" runat="server" AutoGenerateColumns="false" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" 
                                           PageSize="25" AllowSorting="true" Width="100%" DataKeyNames="ProjectNewID" DataSourceID="dsProjectApproval">
                                         <RowStyle CssClass="row" />
                                            <HeaderStyle CssClass="gridcolumnheader" />
                                        <Columns>
                                            <asp:TemplateField HeaderText=" ">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkRows" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField Visible="false" HeaderText=" ">
                                                <ItemTemplate> 
                                                <asp:Label ID="lblProjectNewID" runat="server" Text='<%# Eval("ProjectNewID")%>' />                                                   
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Project Name" SortExpression="ProjectName">
                                                <ItemTemplate>
                                                <asp:Label ID="lblProjectName" runat="server" Text='<%# Eval("ProjectName")%>' />                                                     
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Submitted By" SortExpression="UserName">
                                                <ItemTemplate>
                                                <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Description">
                                                <ItemTemplate>
                                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Approved?" SortExpression="Approved">
                                                <ItemTemplate>
                                                <asp:Label ID="lblApproved" runat="server" Text='<%# TrueFalse(Eval("Approved"))%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Date Approved" SortExpression="DateApproved">
                                                <ItemTemplate>
                                                <asp:Label ID="lblDateApproved" runat="server" Text='<%# Eval("DateApproved")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Date Denied" SortExpression="DateDenied">
                                                <ItemTemplate>
                                                <asp:Label ID="lblDateDenied" runat="server" Text='<%# Eval("DateDenied")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("StartDate")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                <asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("EndDate")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField Visible="false">
                                                <ItemTemplate>
                                                <asp:Label ID="lblDivisionID" runat="server" Text='<%# Eval("DivisionID")%>' />                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                                                                 
                                        </Columns>
                                        </asp:GridView>
                                    </div>
                                        
                                  </div>
                                
                            <p>&nbsp;</p>
                            <p>&nbsp;</p>
                            </div>
                            </div>
                            <br /><br />
                             
                                    
                         </td>
                </tr>
            </table>
            </div>
        
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
    </form>
</body>
</html>
