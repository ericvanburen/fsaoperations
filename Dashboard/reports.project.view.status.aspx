<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>
<%@ Import Namespace="iTextSharp.text" %>
<%@ Import Namespace="iTextSharp.text.pdf" %>
<%@ Import Namespace='iTextSharp.text.html.simpleparser' %>
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
            
            Dim strStatus As String = Request.QueryString("Status")
            lblStatus.Text = strStatus
            
            lblPageHeader.Text = "All Projects in Status " & strStatus.ToString()
            'Manually set the Grid page size
            GridView1.PageSize = 50
            
        End If
    End Sub
          
    Sub btnExportExcel_Click(ByVal sender As Object, e As EventArgs)
        ExportGridToCSV()
    End Sub
    
    Private Sub ExportGridToCSV()
        Response.Clear()
        Dim j As Integer = 0
        'Add headers of the csv table
        For Each col As Column In GridView1.Columns
            If (j > 0) Then
                Response.Write(",")
            End If
            Response.Write(col.HeaderText)
            j = (j + 1)
        Next
        'How add the data from the Grid to csv table
        Dim i As Integer = 0
        Do While (i < GridView1.Rows.Count)
            Dim dataItem As Hashtable = GridView1.Rows(i).ToHashtable
            j = 0
            Response.Write("" & vbLf)
            For Each col As Column In GridView1.Columns
                If (j > 0) Then
                    Response.Write(",")
                End If
                Response.Write(dataItem(col.DataField).ToString)
                j = (j + 1)
            Next
            i = (i + 1)
        Loop
        ' Send the data and the appropriate headers to the browser        
        Response.AddHeader("content-disposition", "attachment;filename=AllProjectUpdates.csv")
        Response.ContentType = "text/csv"
        Response.End()
    End Sub
    
  
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - Project Status</title>
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
  
    <fieldset class="fieldset">
        
        <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                 <img src="images/fSA_logo_dashboard.gif" alt="Federal Student Aid - Dashboard Reports" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">All Projects</a></li>                                
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
                                    <asp:SqlDataSource ID="dsProjectUpdates" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_UpdateStatusMostRecentByStatus" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:QueryStringParameter QueryStringField="Status" Name="Status" />
                                        </SelectParameters>                                        
                                        </asp:SqlDataSource>
                                        

                                     <!--Week Ending Values-->
                                    <asp:SqlDataSource ID="dsWeekEnding" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingAll" SelectCommandType="StoredProcedure" />

                                                                                                               
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        
                                        <table border="0" width="100%">
                                            <tr>
                                                <td align="left"><h2><asp:Label ID="lblPageHeader" runat="server" /></h2></td>                                               
                                            </tr>
                                        </table>
                                        
                                        <cc1:Grid id="GridView1" runat="server" DataSourceID="dsProjectUpdates" 
                                            AutoGenerateColumns="false" AllowFiltering="true" Width="100%" 
                                        FolderStyle="Styles/style_5" AllowSorting="true" 
                                            AllowGrouping="true" AllowAddingRecords="false">
                                        <Columns>                                            
                                            <cc1:Column HeaderText="Details" runat="server" Width="10%" templateID="tplProjectName" />
                                            <cc1:Column DataField="ProjectName" HeaderText="Project Name" runat="server" Width="30%" />
                                            <cc1:Column DataField="WeekEnding" HeaderText="Week Ending" runat="server" DataFormatString="{0:d}" Width="20%" />
                                            <cc1:Column DataField="Comments" HeaderText="Comments" runat="server" Wrap="true" Width="20%" />
                                            <cc1:Column ID="Column3" DataField="Status" HeaderText="Status" Width="50" Align="center" runat="server" HeaderAlign="center">
				                                <TemplateSettings TemplateID="ImageTemplate" />
				                            </cc1:Column>
                                        </Columns>
                                         <Templates>
				                        <cc1:GridTemplate runat="server" ID="ImageTemplate">
					                        <Template><img src="images/<%# Container.Value %>.gif" alt="" width="12" height="12" border="0" /></Template>
				                        </cc1:GridTemplate>
			                            </Templates>
                                        <Templates>
                                            <cc1:GridTemplate runat="server" ID="tplProjectName">                    
                                            <Template>
                                                 <a href="project.updates.detail.aspx?ProjectID=<%# Container.DataItem("ProjectID")%>">
                                                     <img src="images/page_find.gif" border="0" /></a>                                                                
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
   <asp:Label ID="lblProjectID" runat="server" Visible="false" />
   <asp:Label ID="lblStatus" runat="server" Visible="false" />
    </form>
</body>
</html>
