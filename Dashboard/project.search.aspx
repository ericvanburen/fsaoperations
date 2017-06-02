<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data"  %>
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
            
            GridView1.Visible = False
            btnExportExcel.Visible = False
        End If
    End Sub
    
    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub
    
       
    Sub BindGridView()
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        strSQL = "p_ProjectSearch"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        If ddlProjectName.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ProjectID", SqlDbType.Int).Value = ddlProjectName.SelectedValue
        End If
        
        If ddlStatus.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@StatusID", SqlDbType.Int).Value = ddlStatus.SelectedValue
        End If
        
        If ddlWeekEnding.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@WeekEndingID", SqlDbType.Int).Value = ddlWeekEnding.SelectedValue
        End If
        
        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", SqlDbType.Int).Value = txtComments.Text
        End If
        
        
        Try
            con.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "SearchResults")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRecordCount.Text = "Your search returned " & intRecordCount & " records"
            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If
            
            GridView1.DataSource = ds.Tables("SearchResults").DefaultView
            GridView1.DataBind()
            GridView1.Visible = True
        Finally
            con.Close()
        End Try
    End Sub
        
    Sub GridView1_RowDataBound(Sender As Object, e As GridRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(4).Text = "Green" Then
                e.Row.Cells(4).BackColor = System.Drawing.Color.LightGreen
            ElseIf e.Row.Cells(4).Text = "Yellow" Then
                e.Row.Cells(4).BackColor = System.Drawing.Color.LemonChiffon
            ElseIf e.Row.Cells(4).Text = "Red" Then
                e.Row.Cells(4).BackColor = System.Drawing.Color.Tomato
            End If
        End If
    End Sub
       
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - Project Search</title>
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
    
    <script type="text/javascript">
        function exportToExcel() {           
            GridView1.exportToExcel();
        }    		
	 </script>	
        
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
                                <li><a href="#tabs-1">Project Search</a></li>                                
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
                                <%--<asp:UpdatePanel runat="server">
                                    <ContentTemplate>--%>
                                    <div id="Div1"> 
                                    <asp:SqlDataSource ID="dsProjectSearch" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectSearch" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ProjectID" Type="Int32" />
                                            <asp:Parameter Name="StatusID" Type="Int32" />
                                            <asp:Parameter Name="WeekEndingID" Type="Int32" />
                                            <asp:Parameter Name="Comments" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>
                                      

                                     <!--Week Ending Values-->
                                    <asp:SqlDataSource ID="dsWeekEnding" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingAll" SelectCommandType="StoredProcedure" />

                                     <!--Project Name Values-->
                                        <asp:SqlDataSource ID="dsProjectName" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectsAll_All" SelectCommandType="StoredProcedure">
                                       </asp:SqlDataSource>

                                     <!--Status Values-->
                                    <asp:SqlDataSource ID="dsStatus" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_StatusAll" SelectCommandType="StoredProcedure" />
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                    <table align="center" cellspacing="4" cellpadding="4">
                                    <tr>
                                        <td>Week Ending:</td>
                                        <td><asp:DropDownList ID="ddlWeekEnding" runat="server" DataSourceID="dsWeekEnding" AppendDataBoundItems="true"
                                                DataTextField="WeekEnding" DataValueField="WeekEndingID">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList>
                                        </td>
                                        <td>Project:</td>
                                        <td><asp:DropDownList ID="ddlProjectName" runat="server" DataSourceID="dsProjectName" AppendDataBoundItems="true"
                                            DataTextField="ProjectName" DataValueField="ProjectID">
                                                <asp:ListItem Text="" Value="" />                                                
                                            </asp:DropDownList>
                                        </td>  
                                        
                                    </tr>
                                    <tr>
                                         <td>Current Status:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" AppendDataBoundItems="true"
                                            DataTextField="Status" DataValueField="StatusID">
                                                <asp:ListItem Text="" Value="" />                                                
                                            </asp:DropDownList>
                                        </td>                               
   
                                        <td>Comments:</td>
                                            <td><asp:TextBox ID="txtComments" runat="server" Height="19px" Width="482px" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="button" OnClick="btnSearch_Click" />
                                        </td>
                                    </tr>                                                                    
                                </table> 

                                <div align="center">
                                    <asp:Label ID="lblRecordCount" runat="server" CssClass="warning" />
                                </div>
                                <cc1:Grid id="GridView1" runat="server" 
                                            AutoGenerateColumns="false" AllowFiltering="true" Width="100%" FolderStyle="Styles/style_5" 
                                         AllowSorting="true" AllowGrouping="true" AllowAddingRecords="false">
                                        <Columns>                                            
                                            <cc1:Column ID="Column1" HeaderText="Details" runat="server" templateID="tplProjectName" />
                                            <cc1:Column ID="Column2" DataField="ProjectName" HeaderText="Project Name" runat="server" />
                                            <cc1:Column ID="Column3" DataField="WeekEnding" HeaderText="Week Ending" runat="server" DataFormatString="{0:d}" />
                                            <cc1:Column ID="Column4" DataField="Comments" HeaderText="Comments" runat="server" Wrap="true" Width="100%" />
                                            <cc1:Column ID="Column5" DataField="Status" HeaderText="Status" HeaderAlign="center" Align="center" runat="server" TemplateID="tplStatus" />				                               
                                        </Columns>
                                        <Templates>
                                            <cc1:GridTemplate runat="server" ID="tplProjectName">                    
                                            <Template>
                                                 <a href="project.updates.detail.aspx?ProjectID=<%# Container.DataItem("ProjectID")%>">
                                                     <img src="images/page_find.gif" border="0" alt="Details for this project" /></a>                                                                
                                            </Template>                                                        
                                         </cc1:GridTemplate>
                                         <cc1:GridTemplate runat="server" ID="tplStatus">
                                         <Template>
                                            <img src="images/<%# Container.Value %>.gif" alt="" width="12" height="12" border="0" alt="Status <%# Container.Value %>" />
                                         </Template>
                                         </cc1:GridTemplate>

                                        </Templates>
                                        <ExportingSettings ExportAllPages="true" ColumnsToExport="ProjectName,WeekEnding,Comments,Status" />
                                        </cc1:Grid>
                                        <br />
                                        <div align="center">
                                            <asp:Button ID="btnExportExcel" runat="server" Text="Export Records To Excel" OnClientClick="exportToExcel();return false;" />
                                        </div>
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
