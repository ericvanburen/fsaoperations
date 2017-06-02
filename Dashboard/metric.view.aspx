﻿<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>
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
    End Sub
    
    Protected Sub ddlDivision_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        If ddlDivision.SelectedValue = "2" Then
            'Show the Call Center Branch Gridview and hide the Processing Division gridview
            GridView1.Visible = False
            GridView2.Visible = True
            
            'Same idea for the associated Export to Excel buttons
            btnExportExcel.Visible = False
            btnExportExcel2.Visible = True
        Else
            'Show the Processing Division Gridview and hide the Call Center Branch Gridview
            GridView1.Visible = True
            GridView2.Visible = False
            
            'Same idea for the associated Export to Excel buttons
            btnExportExcel.Visible = True
            btnExportExcel2.Visible = False
            
            dsMetricUpdates.SelectParameters.Item("DivisionID").DefaultValue = ddlDivision.SelectedValue
        End If
    End Sub
       
    Sub btnExportExcel_Click(sender As Object, e As CommandEventArgs)
        If e.CommandArgument = "GridView1" Then
            ExportGridToExcel(GridView1)
        Else
            ExportGridToExcel(GridView2)
        End If
    End Sub
    
    Private Sub ExportGridToExcel(ByVal gv As GridView)
        gv.AllowSorting = False
        gv.AllowPaging = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=DashboardMetricStatusReport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        gv.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Public Shared Function ServiceDirectorComments(ByVal MyValue As Object) As Object
        If MyValue IsNot DBNull.Value Then
            Return CStr("*").ToString
        Else
            Return Nothing
        End If
    End Function
    
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

                                      <!--Division Values-->
                                    <asp:SqlDataSource ID="dsDivisions" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_DivisionsMetrics" SelectCommandType="StoredProcedure" />
                                    

                                       <!--Populates Grid for Processing Division-->
                                        <asp:SqlDataSource ID="dsMetricUpdates" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_DivisionMetricsUpdates" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="DivisionID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>

                                        <!--Populates Grid for Call Center Branch-->
                                        <asp:SqlDataSource ID="dsMetricUpdatesCallCenterBranch" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_DivisionMetricsUpdatesCallCenterBranch" SelectCommandType="StoredProcedure">                                       
                                        </asp:SqlDataSource>
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                    <table align="center" cellspacing="4" cellpadding="4" width="100%">
                                     <tr>
                                        <td align="right">View Metrics By Division:</td>
                                        <td>
                                            <asp:DropDownList ID="ddlDivision" runat="server" DataSourceID="dsDivisions" DataTextField="DivisionName" DataValueField="DivisionID"                                             
                                                onselectedindexchanged="ddlDivision_SelectedIndexChanged" AppendDataBoundItems="true" AutoPostBack="true">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList><br />
                                        </td>
                                    </tr>
                                   </table>                                    
                                    </div>
                                    <!--This grid is for the Processing Division and everyone but the Call Center Branch-->
                                       <div class="grid">    
                                        <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMetricUpdates" AutoGenerateColumns="false" 
                                        Width="95%" HorizontalAlign="Center" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="false" AllowSorting="true">
                                            <RowStyle CssClass="row" />
                                            <HeaderStyle CssClass="gridcolumnheader" />
                                            <Columns>
                                                <asp:HyperLinkField 
                                                DataTextField="MetricName" 
                                                HeaderText="MetricName" 
                                                DataNavigateUrlFields="MetricID" 
                                                SortExpression="MetricName"  
                                                ItemStyle-CssClass="first" 
                                                DataTextFormatString="{0:d}"                                            
                                                DataNavigateUrlFormatString="metric.view.all.aspx?MetricID={0}">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                </asp:HyperLinkField>                                              

                                                <asp:TemplateField HeaderText="Week Ending" HeaderStyle-HorizontalAlign="Center" SortExpression="WeekEnding">
                                                <ItemTemplate>                                                
                                                     <a href='metric.updates.detail.aspx?MetricUpdateID=<%# Container.DataItem("MetricUpdateID")%>'><%# Eval("WeekEnding", "{0:d}")%></a>
                                                     <asp:Label ID="lblServiceDirectorComments" runat="server" Text='<%# ServiceDirectorComments(Container.DataItem("ServiceDirectorComments"))%>' CssClass="warning" />
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                                <%--These 4 columns are metrics used by processing division--%>
                                                <asp:BoundField DataField="VolumeReceived" HeaderText="Volume Received" SortExpression="VolumeReceived" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                                <asp:BoundField DataField="VolumeCompleted" HeaderText="Volume Completed" SortExpression="VolumeCompleted" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                                <asp:BoundField DataField="Pending" HeaderText="Pending" SortExpression="Pending" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                                <asp:BoundField DataField="Aging" HeaderText="Aging" SortExpression="Aging" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />                                               
                                                <asp:BoundField DataField="Username" HeaderText="Entered By" SortExpression="Username" ItemStyle-HorizontalAlign="Left" />
                                            </Columns>
                                        </asp:GridView>
                                        </div>
                                        <br />
                                        <div align="center">
                                          <asp:Button ID="btnExportExcel" runat="server" Text="Export records to Excel" OnCommand="btnExportExcel_Click" CommandName="ExportExcel" CommandArgument="GridView1" Visible="false" CssClass="button" />
                                        </div>


                                        <!--This grid is only for the Call Center Branch-->
                                        <div class="grid">    
                                        <asp:GridView ID="GridView2" runat="server" DataSourceID="dsMetricUpdatesCallCenterBranch" AutoGenerateColumns="false" 
                                        Width="95%" HorizontalAlign="Center" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="false" AllowSorting="true">
                                            <RowStyle CssClass="row" />
                                            <HeaderStyle CssClass="gridcolumnheader" />
                                            <Columns>
                                                <asp:HyperLinkField 
                                                DataTextField="MetricName" 
                                                HeaderText="MetricName" 
                                                DataNavigateUrlFields="MetricID" 
                                                SortExpression="MetricName"  
                                                ItemStyle-CssClass="first" 
                                                DataTextFormatString="{0:d}"                                            
                                                DataNavigateUrlFormatString="metric.view.all.aspx?MetricID={0}">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                </asp:HyperLinkField>

                                                <asp:TemplateField HeaderText="Week Ending" HeaderStyle-HorizontalAlign="Center" SortExpression="WeekEnding">
                                                <ItemTemplate>
                                                    <a href='metric.updates.detail.aspx?MetricUpdateID=<%# Container.DataItem("MetricUpdateID")%>'><%# Container.DataItem("WeekEnding")%></a>
                                                     <asp:Label ID="lblServiceDirectorComments" runat="server" Text='<%# ServiceDirectorComments(Container.DataItem("ServiceDirectorComments"))%>' CssClass="warning" />
                                                </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                                <%--These three columns are used only by the call center branch--%>
                                                <asp:BoundField DataField="NoAssigned" HeaderText="No Assigned" SortExpression="NoAssigned" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                                <asp:BoundField DataField="NoMonitored" HeaderText="No Monitored" SortExpression="NoMonitored" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:N0}" />
                                                <asp:BoundField DataField="PassFail" HeaderText="Pass/Fail" SortExpression="PassFail" ItemStyle-HorizontalAlign="Center" />

                                                <asp:BoundField DataField="Username" HeaderText="Entered By" SortExpression="Username" ItemStyle-HorizontalAlign="Left" />
                                            </Columns>
                                        </asp:GridView>
                                        </div>
                                        <br />
                                        <div align="center">
                                          <asp:Button ID="btnExportExcel2" runat="server" Text="Export records to Excel" OnCommand="btnExportExcel_Click" CommandName="ExportExcel" CommandArgument="GridView2" CssClass="button" />
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
