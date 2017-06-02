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
            
            'Set Welcome back message
            lblWelcomeBack.Text = "Welcome Back " & Request.Cookies("Dashboard")("Username")
        
            BindGridView()
        End If
    End Sub
    
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gv As GridView = e.Row.FindControl("GridView2")
            Dim dbSrc As New SqlDataSource
            dbSrc.ConnectionString = ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString
            dbSrc.SelectCommand = "SELECT ProjectStatusID, WeekEnding, Status, Comments, Username FROM v_ProjectStatusUpdates WHERE ProjectID = '" & _
                e.Row.DataItem("ProjectID").ToString & "' ORDER BY WeekEnding DESC"
            gv.DataSource = dbSrc
            gv.DataBind()
        End If
    End Sub
    
    Sub GridView2_RowDataBound(Sender As Object, e As GridViewRowEventArgs)
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
    
    
    Sub BindGridView()
        dsMyProjectsActive.SelectParameters.Item("AssignedProjects").DefaultValue = Convert.ToInt32(lblUserID.Text)
        GridView1.DataBind()
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
       
    Protected Sub ddlActive_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        GridView1.DataSourceID.Remove(0)
        
        Dim ddlActive As DropDownList = CType(sender, DropDownList)
                
        Dim row As GridViewRow
        For Each row In GridView1.Rows
            
            If ddlActive.SelectedValue = "1" Then
                GridView1.DataSourceID = "dsMyProjectsActive"
                dsMyProjectsActive.SelectParameters.Item("AssignedProjects").DefaultValue = Convert.ToInt32(lblUserID.Text)
                dsMyProjectsActive.SelectParameters.Item("Active").DefaultValue = 1
            ElseIf ddlActive.SelectedValue = "0" Then
                GridView1.DataSourceID = "dsMyProjectsActive"
                dsMyProjectsActive.SelectParameters.Item("AssignedProjects").DefaultValue = Convert.ToInt32(lblUserID.Text)
                dsMyProjectsActive.SelectParameters.Item("Active").DefaultValue = 0
            Else
                GridView1.DataSourceID = "dsMyProjects"
                dsMyProjects.SelectParameters.Item("AssignedProjects").DefaultValue = Convert.ToInt32(lblUserID.Text)
            End If
        Next
        
        GridView1.DataBind()
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - My Projects</title>
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

        function switchViews(obj, row) {
            var div = document.getElementById(obj);
            var img = document.getElementById('img' + obj);

            if (div.style.display == "none") {
                div.style.display = "inline";
                if (row == 'alt') {
                    img.src = "images/page_down.gif"; mce_src = "images/page_down.gif";
                }

                else {
                    img.src = "images/page_up.gif"; mce_src = "images/page_up.gif";
                }

                img.alt = "Close to view other project updates";
            }

            else {

                div.style.display = "none";
                if (row == 'alt') {
                    img.src = "images/page_down.gif"; mce_src = "images/page_down.gif";
                }

                else {
                    img.src = "images/page_up.gif"; mce_src = "images/page_up.gif";
                }

                img.alt = "Expand to show project updates";
            }
        }   
    </script>


        
    <style type="text/css">
        .style1
        {
            font-size: x-large;
            font-family: Calibri;
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
		                 <img src="images/fSA_logo_dashboard.gif" alt="Federal Student Aid - Dashboard Reports" /> <asp:Label ID="lblWelcomeBack" runat="server" CssClass="gvHeaderRow" ForeColor="#e17009" />                       
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">My Projects</a></li>                                
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

                                    <!--My projects-->
                                    <asp:SqlDataSource ID="dsMyProjects" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_MyProjects" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="AssignedProjects" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>
                                        
                                    <!--My projects with Active Toggle-->
                                    <asp:SqlDataSource ID="dsMyProjectsActive" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_MyProjects_Active" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="AssignedProjects" />
                                            <asp:Parameter Name="Active" DefaultValue="True" />
                                        </SelectParameters>
                                        </asp:SqlDataSource> 
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">

                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="dsMyProjectsActive" 
                                            Width="870px" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound">
                                            <AlternatingRowStyle BackColor="White" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Click to<br />expand" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <a href="javascript:switchViews('div<%# Eval("ProjectID") %>', 'one');">
                                                            <img id="imgdiv<%# Eval("ProjectID") %>" alt="Click to show/hide responses" border="0"
                                                                src="images/page_down.gif" />
                                                        </a>
                                                    </ItemTemplate>
                                                    <AlternatingItemTemplate>
                                                        <a href="javascript:switchViews('div<%# Eval("ProjectID") %>', 'alt');">
                                                            <img id="imgdiv<%# Eval("ProjectID") %>" alt="Click to show/hide responses" border="0"
                                                                src="images/page_down.gif" />
                                                        </a>
                                                    </AlternatingItemTemplate>
                                                </asp:TemplateField>
                                                 
                                                 <asp:TemplateField HeaderText="Project Name" SortExpression="ProjectName" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="lnkProjectName" runat="server" NavigateUrl='<%# Eval("ProjectID", "project.updates.aspx?ProjectID={0}") %>' Text='<%# Eval("ProjectName") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Active?" FooterStyle-Font-Bold="True" HeaderStyle-HorizontalAlign="Left">
                                                    <HeaderTemplate>
                                                        Active? <asp:DropDownList ID="ddlActive" runat="server" OnSelectedIndexChanged="ddlActive_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="" Value="" />
                                                            <asp:ListItem Text="Yes" Value="1" />
                                                            <asp:ListItem Text="No" Value="0" />
                                                            <asp:ListItem Text="All" Value="All" />
                                                        </asp:DropDownList>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblActive" runat="server" Text='<%# TrueFalse(Eval("Active"))%>' />
                                                    </ItemTemplate>                                                   
                                                </asp:TemplateField>
                                                                                                
                                                <asp:TemplateField HeaderText=" ">
                                                    <ItemTemplate>
                                                        </td></tr>
                                                        <tr>
                                                            <td colspan="100%">
                                                                <div id="div<%# Eval("ProjectID") %>" style="display: none; position: relative; left: 25px;">
                                                                    <asp:GridView ID="GridView2" runat="server" Width="80%" AutoGenerateColumns="false" CellPadding="4"
                                                                        DataKeyNames="ProjectStatusID" EmptyDataText="No updates for this project">
                                                                        <RowStyle CssClass="row" />
                                                                        <AlternatingRowStyle CssClass="rowalternate" />
                                                                        <HeaderStyle CssClass="gridcolumnheader" />
                                                                        <Columns>                                                                            
                                                                            <asp:BoundField DataField="WeekEnding" HeaderText="Week Ending" DataFormatString="{0:d}" HtmlEncode="false" />
                                                                            <asp:BoundField DataField="Username" HeaderText="Entered By" />                                                                                                                                                        
                                                                            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-Wrap="true" />
                                                                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                                                            <ItemTemplate>
                                                                                <img src="images/<%# Eval("Status") %>.gif" alt="" width="12" height="12" border="0" />
                                                                            </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EditRowStyle BackColor="#2461BF" />
                                            <FooterStyle BackColor="#5c9ccc" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#5c9ccc" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                            <RowStyle BackColor="#EFF3FB" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                                        </asp:GridView>
                                    
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
