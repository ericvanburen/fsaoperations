<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="CheckLogin" %>

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
            
            lblUserID.Text = Request.Cookies("Dashboard")("UserID")
            lblMetricUpdateID.Text = Request.QueryString("MetricUpdateID")
            
            BindRecord()
        End If
    End Sub
       
    Protected Sub DetailsView1_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewUpdateEventArgs) Handles DetailsView1.ItemUpdating
        dsMetricStatusUpdate.UpdateParameters("Aging").DefaultValue = DirectCast(DetailsView1.FindControl("txtAging"), TextBox).Text
        dsMetricStatusUpdate.UpdateParameters("VolumeReceived").DefaultValue = DirectCast(DetailsView1.FindControl("txtVolumeReceived"), TextBox).Text
        dsMetricStatusUpdate.UpdateParameters("VolumeCompleted").DefaultValue = DirectCast(DetailsView1.FindControl("txtVolumeCompleted"), TextBox).Text
        dsMetricStatusUpdate.UpdateParameters("Pending").DefaultValue = DirectCast(DetailsView1.FindControl("txtPending"), TextBox).Text
        dsMetricStatusUpdate.UpdateParameters("WeekEndingID").DefaultValue = DirectCast(DetailsView1.FindControl("ddlWeekEnding"), DropDownList).SelectedValue
        dsMetricStatusUpdate.UpdateParameters("StatusID").DefaultValue = DirectCast(DetailsView1.FindControl("ddlStatus"), DropDownList).SelectedValue
        dsMetricStatusUpdate.UpdateParameters("Comments").DefaultValue = DirectCast(DetailsView1.FindControl("txtComments"), TextBox).Text
        dsMetricStatusUpdate.UpdateParameters("ServiceDirectorComments").DefaultValue = DirectCast(DetailsView1.FindControl("txtServiceDirectorComments"), TextBox).Text
    End Sub
    
    Sub BindRecord()
        dsMetricStatusUpdate.SelectParameters.Item("MetricUpdateID").DefaultValue = lblMetricUpdateID.Text
    End Sub
    
    Protected Sub DetailsView1_ItemUpdated(sender As Object, e As System.Web.UI.WebControls.DetailsViewUpdatedEventArgs)
        lblRecordStatus.Text = "Your record was successfully updated"
    End Sub
    
    Protected Sub DetailsView1_DataBound(sender As Object, e As System.EventArgs)
        'Allow director comments only for Jana or Eric
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
    <title>Operation Services Dashboard Reports - My Metric Status Updates</title>
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
                                <li><a href="#tabs-1">Metric Updates</a></li>                                
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
                                    <asp:SqlDataSource ID="dsMetricStatusUpdate" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_MetricStatusSelect" SelectCommandType="StoredProcedure"
                                        UpdateCommand="p_MetricStatusUpdate" UpdateCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="MetricUpdateID" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="MetricUpdateID" Type="Int32" />
                                            <asp:Parameter Name="Aging" Type="Int32" />
                                            <asp:Parameter Name="VolumeReceived" Type="Int32" />
	                                        <asp:Parameter Name="VolumeCompleted" Type="Int32" />
                                            <asp:Parameter Name="Pending" Type="Int32" />
                                            <asp:Parameter Name="Comments" Type="String" />
                                            <asp:Parameter Name="ServiceDirectorComments" Type="String" />
                                            <asp:Parameter Name="WeekEndingID" Type="Int32" />
                                            <asp:Parameter Name="StatusID" Type="Int32" />                                                                                   
                                            <asp:ControlParameter ControlID="lblUserID" Name="UserID" Type="Int32" />       
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
                                       
     <asp:DetailsView ID="DetailsView1" runat="Server" CellPadding="4" ForeColor="#333333" GridLines="None"
     Width="100%" AllowPaging="True" AutoGenerateRows="False" AutoGenerateDeleteButton="False" 
     AutoGenerateEditButton="True" DataSourceID="dsMetricStatusUpdate" DefaultMode="Edit"
     DataKeyNames="MetricUpdateID" OnItemUpdating="DetailsView1_ItemUpdating" OnItemUpdated="DetailsView1_ItemUpdated" 
                                            ondatabound="DetailsView1_DataBound">

        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" />
        <EditRowStyle BackColor="#999999" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <FieldHeaderStyle BackColor="#E9ECF1" Font-Bold="True" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />         
         <Fields>
            <asp:TemplateField HeaderText="Metric Update ID" HeaderStyle-HorizontalAlign="Right">
                <ItemTemplate>
                   <%# Eval("MetricUpdateID")%>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Week Ending" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                <asp:DropDownList ID="ddlWeekEnding" runat="server" DataSourceID="dsWeekEnding" 
                    DataTextField="WeekEnding" DataValueField="WeekEndingID" SelectedValue='<%# Eval("WeekEndingID")%>'>
                </asp:DropDownList> 
            </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
            <asp:DropDownList ID="ddlStatus" runat="server" DataSourceID="dsStatus" SelectedValue='<%# Eval("StatusID")%>'
                DataTextField="Status" DataValueField="StatusID">                
            </asp:DropDownList> 
            </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Volume Received" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
              <asp:TextBox id="txtVolumeReceived" runat="server" Text='<%# Eval("VolumeReceived")%>' />            
            </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Volume Completed" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                 <asp:TextBox id="txtVolumeCompleted" runat="server" Text='<%# Eval("VolumeCompleted")%>' />
            </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Pending" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                 <asp:TextBox id="txtPending" runat="server" Text='<%# Eval("Pending")%>' />
            </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Aging" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                 <asp:TextBox id="txtAging" runat="server" Text='<%# Eval("Aging")%>' />
            </ItemTemplate>
            </asp:TemplateField>
                        
            <asp:TemplateField HeaderText="Comments" HeaderStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:TextBox id="txtComments" runat="server" Text='<%# Eval("Comments")%>' TextMode="MultiLine" Rows="9" Columns="40" />
                </ItemTemplate>
            </asp:TemplateField> 

            <asp:TemplateField HeaderText="Service Director Comments" HeaderStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:TextBox id="txtServiceDirectorComments" runat="server" Text='<%# Eval("ServiceDirectorComments")%>' TextMode="MultiLine" Rows="9" Columns="40" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Entered By" HeaderStyle-HorizontalAlign="Right">
            <ItemTemplate>
                 <asp:Label id="lblUsername" runat="server" Text='<%# Eval("Username")%>' />
            </ItemTemplate>
            </asp:TemplateField>       
        </Fields>
    </asp:DetailsView> 
    <asp:Label id="lblRecordStatus" runat="server" CssClass="warning" Font-Size="Small" />                                   
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
   <asp:Label ID="lblMetricUpdateID" runat="server" Visible="false" />
 
    </form>
</body>
</html>
