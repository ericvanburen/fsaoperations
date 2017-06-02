<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>
<%@ Import Namespace="iTextSharp.text" %>
<%@ Import Namespace="iTextSharp.text.pdf" %>


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
            
            lblProjectStatusID.Text = Request.QueryString("ProjectStatusID")
            BindRecord()
        End If
    End Sub
    
    Protected Sub DetailsView1_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewUpdateEventArgs)'Handles DetailsView1.ItemUpdating
        dsProjectStatusUpdate.UpdateParameters("StatusID").DefaultValue = DirectCast(DetailsView1.FindControl("ddlStatus"), DropDownList).SelectedValue
        dsProjectStatusUpdate.UpdateParameters("PercentComplete").DefaultValue = DirectCast(DetailsView1.FindControl("ddlPercentComplete"), DropDownList).SelectedValue
        dsProjectStatusUpdate.UpdateParameters("Comments").DefaultValue = DirectCast(DetailsView1.FindControl("txtComments"), TextBox).Text
        dsProjectStatusUpdate.UpdateParameters("ServiceDirectorComments").DefaultValue = DirectCast(DetailsView1.FindControl("txtServiceDirectorComments"), TextBox).Text
        'This is confusing so pay attention
        'UserID is a an update parameter for dsProjectStatusUpdate and we want to update this parameter it's not the Service Director (Service Director Comments field)
        'If the admin or Service Director are logged in, we do not want to update the UserID value and keep as is from the lblUserID_Old value
        If lblUserID.Text = "18" OrElse lblUserID.Text = "1" Then
            dsProjectStatusUpdate.UpdateParameters("UserID").DefaultValue = DirectCast(DetailsView1.FindControl("lblUserID_Old"), Label).Text
        Else
            dsProjectStatusUpdate.UpdateParameters("UserID").DefaultValue = lblUserID.Text
        End If
    End Sub
    
    Protected Sub DetailsView1_ItemUpdated(ByVal sender As Object, ByVal e As DetailsViewUpdatedEventArgs) 'Handles DetailsView1.ItemUpdated
        lblRecordStatus.Text = "Your record was successfully updated"
    End Sub
    
    Sub BindRecord()
        dsProjectStatusUpdate.SelectParameters.Item("ProjectStatusID").DefaultValue = lblProjectStatusID.Text
    End Sub
    
    Protected Sub DetailsView1_DataBound(sender As Object, e As System.EventArgs)
        'Allow director comments only for Jana(18) or Eric(1)
        Dim DirectorComments As TextBox
        DirectorComments = DirectCast(DetailsView1.FindControl("txtServiceDirectorComments"), TextBox)
        If lblUserID.Text = "18" OrElse lblUserID.Text = "1" Then
            DirectorComments.Enabled = True
        Else
            DirectorComments.Enabled = False
        End If
    End Sub

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - My Project Updates</title>
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
                                <li><a href="#tabs-1">Project Updates</a></li>                                
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
                            <br /><br /><br />                               
                                    <div id="Div1">   

                                  
                                    <asp:SqlDataSource ID="dsProjectStatusUpdate" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectStatusUpdate" SelectCommandType="StoredProcedure"
                                        UpdateCommand="p_ProjectStatusUpdate2" UpdateCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ProjectStatusID" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ProjectStatusID" Type="Int32" />
                                            <asp:Parameter Name="StatusID" Type="Int32" />
	                                        <asp:Parameter Name="PercentComplete" Type="Int32" />
	                                        <asp:Parameter Name="Comments" Type="String" />
                                            <asp:Parameter Name="ServiceDirectorComments" Type="String" />
                                            <asp:Parameter Name="UserID" Type="Int32" />
                                        </UpdateParameters>
                                        </asp:SqlDataSource>  
                                        
                                    <!--Status Values-->
                                    <asp:SqlDataSource ID="dsStatus" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_StatusAll" SelectCommandType="StoredProcedure" /> 
                                        
                                     <!--Week Ending Values-->
                                    <asp:SqlDataSource ID="dsWeekEnding" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingAll" SelectCommandType="StoredProcedure" />                                                                 
                                       
     <h3>Update Existing Project Status</h3>

     <p>This form updates an existing project status.  Use the <a href="project.add.aspx">New Project Status form</a> to add a new update.</p>
     <asp:DetailsView ID="DetailsView1" runat="Server" CellPadding="4" ForeColor="#333333" GridLines="None"
     Width="100%" AllowPaging="True" AutoGenerateRows="False" AutoGenerateDeleteButton="False" 
     AutoGenerateEditButton="True" DataSourceID="dsProjectStatusUpdate" DefaultMode="Edit"
     DataKeyNames="ProjectStatusID" OnItemUpdating="DetailsView1_ItemUpdating" OnItemUpdated="DetailsView1_ItemUpdated">

        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        
        <Fields>
            
            <asp:TemplateField HeaderText="Project Name" HeaderStyle-HorizontalAlign="Right">
                <ItemTemplate>
                   <%# Eval("ProjectName")%>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Project Status ID" HeaderStyle-HorizontalAlign="Right">
                <ItemTemplate>
                   <%# Eval("ProjectStatusID")%>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Week Ending" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                <asp:Label ID="lblWeekEnding" runat="server" Text='<%# Eval("WeekEnding", "{0:d}")%>' />               
            </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
            <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" SelectedValue='<%# Eval("StatusID")%>'
                DataTextField="Status" DataValueField="StatusID">                
            </asp:DropDownList> 
            </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Percent Complete" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                <asp:DropDownList ID="ddlPercentComplete" runat="server" SelectedValue='<%# Eval("PercentComplete")%>'>
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="0" Value="0" />
                    <asp:ListItem Text="10" Value="10" />
                    <asp:ListItem Text="20" Value="20" />
                    <asp:ListItem Text="30" Value="30" />
                    <asp:ListItem Text="40" Value="40" />
                    <asp:ListItem Text="50" Value="50" />
                    <asp:ListItem Text="60" Value="60" />
                    <asp:ListItem Text="70" Value="70" />
                    <asp:ListItem Text="80" Value="80" />
                    <asp:ListItem Text="90" Value="90" />
                    <asp:ListItem Text="100" Value="100" />
                </asp:DropDownList>
            </ItemTemplate>
            </asp:TemplateField>   
            
            <asp:TemplateField HeaderText="Comments" HeaderStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:TextBox id="txtComments" runat="server" Text='<%# Eval("Comments")%>' TextMode="MultiLine" Rows="9" Columns="70" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Service Director Comments" HeaderStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:TextBox id="txtServiceDirectorComments" runat="server" Text='<%# Eval("ServiceDirectorComments")%>' TextMode="MultiLine" Rows="9" Columns="70" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Entered By" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                 <asp:Label id="lblUsername" runat="server" Text='<%# Eval("Username")%>' />
                 <asp:Label ID="lblUserID_Old" runat="server" Visible="false" Text='<%# Eval("UserID")%>' />
            </ItemTemplate>
            </asp:TemplateField>        
        </Fields>
    </asp:DetailsView>                                    
     <asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" />
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
   <asp:Label ID="lblProjectStatusID" runat="server" Visible="false" />
 
    </form>
</body>
</html>
