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
            lblUserID.Text = Request.Cookies("Dashboard")("UserID")
        
            Dim intSelectedProjectID As String = Request.QueryString("ProjectID")
            lblSelectedProjectID.Text = intSelectedProjectID
        
            'Set the all projects list selected value equal to this
            ddlProjectName.SelectedValue = intSelectedProjectID
        
            BindGridView(intSelectedProjectID)
            
            'Bind the user assignments to the project (checkboxlist)
            BindUserProjectsList(intSelectedProjectID)
            
        End If
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
    
    
    Sub BindGridView(ByVal ProjectID As Integer)
        dsProjectUpdates.SelectParameters.Item("ProjectID").DefaultValue = ProjectID
        dsProjectAssignments.SelectParameters.Item("ProjectID").DefaultValue = ProjectID
        dsProjectDescription.SelectParameters.Item("ProjectID").DefaultValue = ProjectID
        GridView1.DataBind()
        BindUserProjectsList(ProjectID)
        rptProjectDescription.DataBind()
    End Sub
       
    Protected Sub ddlProjectName_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        If ddlProjectName.SelectedValue = "0" Then
            GridView1.ClearPreviousDataSource()
            GridView1.DataSourceID = "dsProjectUpdatesAll"
            dsProjectUpdatesAll.SelectParameters.Item("UserID").DefaultValue = lblUserID.Text
            GridView1.DataBind()
            
            'Hide project description and users assigned to the project
            pnlProjectDescription.Visible = False
            pnlUsersAssigned.Visible = False
            
        Else
            GridView1.ClearPreviousDataSource()
            GridView1.DataSourceID = "dsProjectUpdates"
            dsProjectUpdates.SelectParameters.Item("ProjectID").DefaultValue = ddlProjectName.SelectedValue
            GridView1.DataBind()
            
            dsProjectDescription.SelectParameters.Item("ProjectID").DefaultValue = ddlProjectName.SelectedValue
            rptProjectDescription.DataBind()
            
            'Bind the assigned users checkboxlist section
            BindUserProjectsList(ddlProjectName.SelectedValue)
            
            'Unhide project description and users assigned to the project
            pnlProjectDescription.Visible = True
            pnlUsersAssigned.Visible = True
            
            'Reset the lblSaveUsers value
            lblSaveUsers.Text = ""
            
        End If
    End Sub
    
    Public Sub BindUserProjectsList(ByVal ProjectID As Integer)

        'This creates the list of checkboxes for the alert events types 
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim objReader As SqlDataReader
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("SELECT DISTINCT(UserName) AS UserName, UserID FROM Users ORDER BY UserName", strSQLConn)

        strSQLConn.Open()
        cblUserProjectList.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        cblUserProjectList.DataTextField = "UserName"
        cblUserProjectList.DataValueField = "UserID"
        cblUserProjectList.DataBind()
        'Dim cmd As SqlCommmand
        cmd = New SqlCommand("SELECT ProjectName, ProjectID, Username, UserID FROM v_ProjectAssignments WHERE ProjectID=" & ProjectID, strSQLConn)
        strSQLConn.Open()
        objReader = cmd.ExecuteReader()
        While objReader.Read()
            Dim currentCheckBox As System.Web.UI.WebControls.ListItem = cblUserProjectList.Items.FindByValue(objReader("UserID").ToString())
            If Not (currentCheckBox Is Nothing) Then
                currentCheckBox.Selected = True
            End If
        End While
        strSQLConn.Close()
    End Sub
    
    
    
    Protected Sub btnUpdateUsers_Click(sender As Object, e As System.EventArgs)
        'We first need to delete all of the records in the UserProjectAssignments table for this project
        ProjectAssignments_Delete()
        
        'Then we insert the new project assigment values
        ProjectAssignments_Insert()
    End Sub
    
    Sub ProjectAssignments_Delete()
        'Delete all of the records in the UserProjectAssignments table for this user
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ProjectUserAssignments_Delete", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ProjectID", ddlProjectName.SelectedValue)
        
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
        Dim intProjectID As Integer = CInt(ddlProjectName.SelectedValue)

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        SqlText = "p_UserProjectAssignments_Insert"
        Try
            strSQLConn.Open()
            For Each Item As System.Web.UI.WebControls.ListItem In cblUserProjectList.Items
                If (Item.Selected) Then
                    cmd = New SqlCommand(SqlText)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Connection = strSQLConn
                    'input parameters for the sproc
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = Item.Value
                    cmd.Parameters.Add("@ProjectID", SqlDbType.Int).Value = intProjectID
                    cmd.ExecuteNonQuery()
                End If
            Next
        Finally
            strSQLConn.Close()
            lblSaveUsers.Visible = True
            lblSaveUsers.Text = "Project Assignments Have Been Updated"
        End Try
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
        Response.AddHeader("content-disposition", "attachment;filename=MyProjectUpdates.csv")
        Response.ContentType = "text/csv"
        Response.End()
    End Sub
    Protected Sub btnPDFExport_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Export current page
        ExportGridToPDF()
    End Sub

    Protected Sub btnPDFExport2_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Export all pages
        GridView1.PageSize = -1
        GridView1.DataBind()
        ExportGridToPDF()
    End Sub

    Private Sub ExportGridToPDF()
        ' Stream which will be used to render the data
        Dim fileStream As MemoryStream = New MemoryStream()

        Dim doc As Document = New Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35)

        Try
            ' Create Document class object and set its size to letter and give space left, right, Top, Bottom Margin
            Dim wri As PdfWriter = PdfWriter.GetInstance(doc, fileStream)

            doc.Open() ' Open Document to write

            Dim font8 As Font = FontFactory.GetFont("ARIAL", 7)

            ' Write some content
            Dim paragraph As Paragraph = New Paragraph("All Projects")

            'Craete instance of the pdf table and set the number of column in that table
            Dim PdfTable As PdfPTable = New PdfPTable(GridView1.Columns.Count)
            Dim PdfPCell As PdfPCell = Nothing

            ' Add headers of the pdf table
            For Each col As Column In GridView1.Columns
                PdfPCell = New PdfPCell(New Phrase(New Chunk(col.HeaderText, font8)))
                PdfTable.AddCell(PdfPCell)
            Next

            ' How add the data from the Grid to pdf table
            For i As Integer = 0 To GridView1.Rows.Count - 1
                Dim dataItem As Hashtable = GridView1.Rows(i).ToHashtable()

                For Each col As Column In GridView1.Columns

                    PdfPCell = New PdfPCell(New Phrase(New Chunk(dataItem(col.DataField).ToString(), font8)))
                    PdfTable.AddCell(PdfPCell)
                Next
            Next i

            PdfTable.SpacingBefore = 15.0F

            doc.Add(paragraph)
            doc.Add(PdfTable)
        Catch docEx As DocumentException
            ' handle pdf document exception if any        
        Catch ioEx As IOException
            ' handle IO exception        
        Catch ex As Exception
            ' ahndle other exception if occurs        
        Finally
            ' Close document and writer
            doc.Close()
        End Try

        ' Send the data and the appropriate headers to the browser
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Project.Update.History.pdf")
        Response.ContentType = "application/pdf"
        Response.BinaryWrite(fileStream.ToArray())
        Response.End()
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
                                <ul>
                                    <li><asp:HyperLink ID="hypProjectManager" runat="server" Text="Project Manager" NavigateUrl="admin/project.manager.aspx" /></li>
                                    <li><asp:HyperLink ID="hypUserManager" runat="server" Text="User Manager" NavigateUrl="user.detail.aspx?UserID=1" /></li>  
                                    <li><asp:HyperLink ID="hypProjectSearch" runat="server" Text="Project Search" NavigateUrl="project.search.aspx" /></li>                                  
                                </ul></li>                   
                                 <li><a href="#">Reports</a>
                                     <ul>
                                        <li><asp:HyperLink ID="hypReportsMetricsCallCenter" runat="server" Text="Metrics - Call Center" NavigateUrl="reports.metric.view.call.center.aspx" /></li>
                                        <li><asp:HyperLink ID="hypReportsPerformance" runat="server" Text="Metrics - Others" NavigateUrl="reports.metric.view.aspx" /></li>
                                        <li><asp:HyperLink ID="hypReportsProject" runat="server" Text="Projects" NavigateUrl="reports.project.view.aspx" /></li>
                                        <li><asp:HyperLink ID="hypReportRedFlag" runat="server" Text="Red Flags" NavigateUrl="reports.redflag.view.aspx" /></li>
                                    </ul></li>
                                 <li><a href="#">Performance Metrics</a>                                  
                                     <ul>
                                        <li><asp:HyperLink ID="hypPerformanceView" runat="server" Text="My Metrics" NavigateUrl="performance.view.aspx" /></li>
                                        <li><asp:HyperLink ID="hypPerformanceAdd" runat="server" Text="Add New Status" NavigateUrl="performance.add.aspx" /></li>
                                    </ul></li>
                                    <li><a href="#">Projects</a>
                                    <ul>
                                        <li><asp:HyperLink ID="hypProjectView" runat="server" Text="My Projects" NavigateUrl="my.projects.aspx" /></li>
                                        <li><asp:HyperLink ID="hypProjectAdd" runat="server" Text="Add New Status" NavigateUrl="project.add.aspx" /></li>
                                    </ul></li>
                                     
                          </ul>
                            </div>
                            <br /><br /><br />
                               <%-- <asp:UpdatePanel runat="server">
                                    <ContentTemplate>--%>
                                    <div id="Div1">   

                                    <!--GridView1-->
                                    <asp:SqlDataSource ID="dsProjectUpdates" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectUpdates" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ProjectID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>
                                        
                                      <asp:SqlDataSource ID="dsProjectUpdatesAll" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectUpdatesUser" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="UserID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource> 

                                         <!--Project Name Values-->
                                        <asp:SqlDataSource ID="dsProjectName" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectsAll_All" SelectCommandType="StoredProcedure">                                        
                                        </asp:SqlDataSource>

                                        <!--Users Assigned to a project-->
                                        <asp:SqlDataSource ID="dsProjectAssignments" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectAssignments" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ProjectID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>

                                        <asp:SqlDataSource ID="dsProjectDescription" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_ProjectDescription" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="ProjectID" />
                                        </SelectParameters>
                                        </asp:SqlDataSource>
                                       
                                    
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                         <table border="0" width="98%">
                                            <tr>
                                                <td align="left"> </td>
                                                <td align="right">Project Name: <asp:DropDownList ID="ddlProjectName" runat="server" 
                                                        DataSourceID="dsProjectName" AppendDataBoundItems="true"
                                                DataTextField="ProjectName" DataValueField="ProjectID" AutoPostBack="true" 
                                                        onselectedindexchanged="ddlProjectName_SelectedIndexChanged">
                                                <asp:ListItem Text="-Show All-" Value="0" />                                                
                                            </asp:DropDownList></td>
                                            </tr>
                                         </table>     
                                        
                                         <asp:Panel ID="pnlProjectDescription" runat="server">
                                        <h3>Project Description</h3>
                                        <asp:Repeater ID="rptProjectDescription" runat="server" DataSourceID="dsProjectDescription">
                                        <ItemTemplate>
                                            <asp:Label ID="lblProjectDescription" runat="server" Text='<%# Eval("Description") %>' />
                                            <br /><br />
                                            Project Start Date: <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("StartDate") %>' /><br />
                                            Projected End Date: <asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("EndDate") %>' />
                                        </ItemTemplate>
                                        </asp:Repeater>
                                        </asp:Panel>     
                                        <br />
                                        <h3>Project History</h3>
                                        <cc1:Grid id="GridView1" runat="server" DataSourceID="dsProjectUpdates" AutoGenerateColumns="false" AllowFiltering="true" FolderStyle="Styles/style_5" 
                                         AllowSorting="true" AllowGrouping="true" Width="100%" AllowAddingRecords="false">
                                        <Columns>                                            
                                            <cc1:Column DataField="ProjectName" HeaderText="Project Name" runat="server" Wrap="true" />
                                            <cc1:Column DataField="WeekEnding" HeaderText="Week Ending" runat="server" DataFormatString="{0:d}" Width="100" />
                                            <cc1:Column ID="PercentComplete" DataField="PercentComplete" HeaderText="% Complete" runat="server" />
                                            <cc1:Column DataField="Username" HeaderText="Entered By" runat="server" />
                                            <cc1:Column DataField="Comments" HeaderText="Comments" runat="server" Wrap="true" Width="100%" />
                                            <cc1:Column ID="Column3" DataField="Status" HeaderText="Status" Width="50" Align="center" runat="server">
				                                <TemplateSettings TemplateID="ImageTemplate" />
				                            </cc1:Column>
                                        </Columns>
                                        <Templates>
				                        <cc1:GridTemplate runat="server" ID="ImageTemplate">
					                        <Template><img src="images/<%# Container.Value %>.gif" alt="" width="12" height="12" border="0" /></Template>
				                        </cc1:GridTemplate>
			                            </Templates>
                                        <ExportingSettings ExportAllPages="true" ColumnsToExport="ProjectName,WeekEnding,Username,Comments,Status" KeepColumnSettings="true" />
                                        </cc1:Grid>
                                        <br />
                                        <%--<asp:Button ID="btnExportExcel" runat="server" Text="Export recordsto Excel" OnClick="btnExportExcel_Click" CssClass="button" />--%>
                                        <div align="center">
                                        <asp:Button ID="btnExportExcel" runat="server" Text="Export Records To Excel" OnClientClick="exportToExcel();return false;" />
                                        <asp:Button ID="btnExportPDF" runat="server" Text="Export Records To PDF" OnClick="btnPDFExport_Click" />                                        
                                        </div>
                                        <br />
                                        
                                        <asp:Panel ID="pnlUsersAssigned" runat="server">
                                         <h3>Users Assigned To This Project</h3>
                                         <DIV style="OVERFLOW-Y:scroll; WIDTH:100%; HEIGHT:100px">  
                                            <asp:CheckBoxList ID="cblUserProjectList" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" CellPadding="3" CellSpacing="4">
                                            </asp:CheckBoxList> 
                                         </DIV> 
                                        <div align="center">
                                            <asp:Button ID="btnUpdateUsers" runat="server" Text="Update User Assignments" OnClick="btnUpdateUsers_Click" />
                                            <br /><asp:Label id="lblSaveUsers" runat="server" CssClass="warning" /> 
                                        </div>
                                                                                 
                                        </asp:Panel>
                                    
                                    </div>    

                                        
                                  </div>
                                 <%-- </ContentTemplate>
                                </asp:UpdatePanel>--%>
                            <p>&nbsp;</p>
                            <p>&nbsp;</p>                           
                  
                   
                     
                         </td>
                </tr>
            </table>
            </div>
        
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblProjectID" runat="server" Visible="false" />
   <asp:Label ID="lblSelectedProjectID" runat="server" Visible="false" />
    </form>
</body>
</html>
