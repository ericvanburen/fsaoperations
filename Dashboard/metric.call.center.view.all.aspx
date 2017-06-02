<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
   
    End Sub
    
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
        
        'Get MetricID passed to this page
        lblMetricID.Text = Request.QueryString("MetricID")
    End Sub
   
    Protected Sub ddlDivision_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        dsMetricUpdates.SelectParameters.Item("MetricID").DefaultValue = lblMetricID.Text
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
    
    Sub GridView1_RowDataBound(Sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(2).Text = "Green" Then
                e.Row.Cells(2).BackColor = System.Drawing.Color.LightGreen
            ElseIf e.Row.Cells(2).Text = "Yellow" Then
                e.Row.Cells(2).BackColor = System.Drawing.Color.LemonChiffon
            ElseIf e.Row.Cells(2).Text = "Red" Then
                e.Row.Cells(2).BackColor = System.Drawing.Color.Tomato
            End If
        End If
    End Sub
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard - All Metric Status Updates</title>
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
                                <li><a href="#tabs-1">View Performance Metrics</a></li>                                
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

                                   
                                     <!--Metric Name Values-->
                                        <asp:SqlDataSource ID="dsMetricUpdates" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_MetricUpdates" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="MetricID" ControlID="lblMetricID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>

                                   
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                                                      
                                    </div>
                                       <div class="grid">    
                                        <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMetricUpdates" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound"
                                        Width="95%" HorizontalAlign="Center" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="true">
                                            <RowStyle CssClass="row" />
                                            <HeaderStyle CssClass="gridcolumnheader" />
                                            <Columns>
                                                <asp:BoundField DataField="MetricName" HeaderText="Metric" SortExpression="MetricName" />
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
                                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                                <asp:BoundField DataField="NoAssigned" HeaderText="No Assigned" SortExpression="NoAssigned"
                                                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                                <asp:BoundField DataField="NoMonitored" HeaderText="No Monitored" SortExpression="NoMonitored"
                                                    ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                                <asp:BoundField DataField="PassFail" HeaderText="Pass/Fail" SortExpression="PassFail"
                                                    ItemStyle-HorizontalAlign="Center" />
                                                <asp:BoundField DataField="Comments" HeaderText="Comments" runat="server" ItemStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Username" HeaderText="Entered By" SortExpression="Username"
                                                    ItemStyle-HorizontalAlign="Left" />
                                            
                                            </Columns>
                                        </asp:GridView>
                                        </div>
                                        <br />
                                        <div align="center">
                                        <asp:Button ID="btnExportExcel" runat="server" Text="Export records to Excel" OnClick="btnExportExcel_Click" CssClass="button" />
                                        </div>
                                        <br />
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
   <asp:Label ID="lblMetricID" runat="server" Visible="false" />
    </form>
</body>
</html>
