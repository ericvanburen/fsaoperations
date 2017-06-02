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
        
            GridView1.PageSize = 50
            
        End If
    End Sub
       
    Sub GridView1_RowDataBound(Sender As Object, e As GridViewRowEventArgs)
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
    
      
    Sub btnExportExcel_Click(ByVal sender As Object, e As EventArgs)
        'ExportGridToCSV()
        btnExportExcel_Click()
    End Sub
    
    Private Sub btnExportExcel_Click()
        GridView1.AllowSorting = False
        GridView1.AllowPaging = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=DashboardProjectStatusReport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Private Sub ExportGridToCSV()
        '    Response.Clear()
        '    Dim j As Integer = 0
        '    'Add headers of the csv table
        '    For Each col As Column In GridView1.Columns
        '        If (j > 0) Then
        '            Response.Write(",")
        '        End If
        '        Response.Write(col.HeaderText)
        '        j = (j + 1)
        '    Next
        '    'How add the data from the Grid to csv table
        '    Dim i As Integer = 0
        '    Do While (i < GridView1.Rows.Count)
        '        Dim dataItem As Hashtable = GridView1.Rows(i).ToHashtable
        '        j = 0
        '        Response.Write("" & vbLf)
        '        For Each col As Column In GridView1.Columns
        '            If (j > 0) Then
        '                Response.Write(",")
        '            End If
        '            Response.Write(dataItem(col.DataField).ToString)
        '            j = (j + 1)
        '        Next
        '        i = (i + 1)
        '    Loop
        '    ' Send the data and the appropriate headers to the browser        
        '    Response.AddHeader("content-disposition", "attachment;filename=AllProjectUpdates.csv")
        '    Response.ContentType = "text/csv"
        '    Response.End()
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
        'Dim fileStream As MemoryStream = New MemoryStream()

        'Dim doc As Document = New Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35)

        'Try
        '    ' Create Document class object and set its size to letter and give space left, right, Top, Bottom Margin
        '    Dim wri As PdfWriter = PdfWriter.GetInstance(doc, fileStream)

        '    doc.Open() ' Open Document to write

        '    Dim font8 As Font = FontFactory.GetFont("ARIAL", 7)

        '    ' Write some content
        '    Dim paragraph As Paragraph = New Paragraph("My Current Projects")

        '    'Craete instance of the pdf table and set the number of column in that table
        '    Dim PdfTable As PdfPTable = New PdfPTable(GridView1.Columns.Count)
        '    Dim PdfPCell As PdfPCell = Nothing

        '    ' Add headers of the pdf table
        '    For Each col As Column In GridView1.Columns
        '        PdfPCell = New PdfPCell(New Phrase(New Chunk(col.HeaderText, font8)))
        '        PdfTable.AddCell(PdfPCell)
        '    Next

        '    ' How add the data from the Grid to pdf table
        '    For i As Integer = 0 To GridView1.Rows.Count - 1
        '        Dim dataItem As Hashtable = GridView1.Rows(i).ToHashtable()

        '        For Each col As Column In GridView1.Columns

        '            PdfPCell = New PdfPCell(New Phrase(New Chunk(dataItem(col.DataField).ToString(), font8)))
        '            PdfTable.AddCell(PdfPCell)
        '        Next
        '    Next i

        '    PdfTable.SpacingBefore = 15.0F

        '    doc.Add(paragraph)
        '    doc.Add(PdfTable)
        'Catch docEx As DocumentException
        '    ' handle pdf document exception if any        
        'Catch ioEx As IOException
        '    ' handle IO exception        
        'Catch ex As Exception
        '    ' ahndle other exception if occurs        
        'Finally
        '    ' Close document and writer
        '    doc.Close()
        'End Try

        '' Send the data and the appropriate headers to the browser
        'Response.Clear()
        'Response.AddHeader("content-disposition", "attachment;filename=My.Projects.pdf")
        'Response.ContentType = "application/pdf"
        'Response.BinaryWrite(fileStream.ToArray())
        'Response.End()
    End Sub
    
        
    Protected Sub getPdf(ByVal sender As Object, ByVal e As CommandEventArgs)
        Context.Response.ContentType = "application/pdf"
        Using stw = New StringWriter()
            Using htextw = New HtmlTextWriter(stw)
                GridView1.RenderControl(htextw)
                Using str = New StringReader(stw.ToString())
                    Dim doc As Document = New Document
                    PdfWriter.GetInstance(doc, Context.Response.OutputStream)
                    doc.Open()
                    Dim elements As List(Of IElement) = HTMLWorker.ParseToList( _
                      str, Nothing _
                    )
                    For Each element In elements
                        doc.Add(element)
                    Next
                    doc.Close()
                    Response.End()
                End Using
            End Using
        End Using
    End Sub

    Protected Sub btnExportPDF_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.ContentType = "application/pdf"
        Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf")
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        GridView1.AllowPaging = False
        GridView1.DataBind()
        GridView1.RenderControl(hw)
        Dim sr As New StringReader(sw.ToString())
        Dim pdfDoc As New Document(PageSize.A4, 10.0F, 10.0F, 10.0F, 0.0F)
        Dim htmlparser As New HTMLWorker(pdfDoc)
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
        pdfDoc.Open()
        htmlparser.Parse(sr)
        pdfDoc.Close()
        Response.Write(pdfDoc)
        Response.End()
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
                   
        If ddlActive.SelectedValue = "1" Then
            dsProjectUpdates.SelectParameters.Item("Active").DefaultValue = 1
            lblPageHeader.Text = "Active Projects Status"
        ElseIf ddlActive.SelectedValue = "0" Then
            dsProjectUpdates.SelectParameters.Item("Active").DefaultValue = 0
            lblPageHeader.Text = "Inactive Projects Status"
        End If
               
        GridView1.DataBind()
    End Sub


    'Protected Sub ddlWeekEnding_SelectedIndexChanged(sender As Object, e As System.EventArgs)
    '    If ddlWeekEnding.SelectedValue = "0" Then
    '        GridView1.ClearPreviousDataSource()
    '        GridView1.DataSourceID = "dsProjectUpdates"
    '        GridView1.DataBind()
    '        lblPageHeader.Text = "Most Recent Status"
    '    Else
    '        GridView1.ClearPreviousDataSource()
    '        GridView1.DataSourceID = "dsProjectUpdatesByDate"
    '        dsProjectUpdatesByDate.SelectParameters.Item("WeekEndingID").DefaultValue = ddlWeekEnding.SelectedValue
    '        GridView1.DataBind()
    '        lblPageHeader.Text = "Status Report As Of " & ddlWeekEnding.SelectedItem.ToString
    '    End If
    'End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Operation Services Dashboard Reports - All Project Updates</title>
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
//             if (GridView1.SelectedRecords.length == 0) {
//                 alert('Please select at least one record to export.');
//                 return;
//             }

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
                                                                     

                               <%-- <asp:UpdatePanel runat="server">
                                    <ContentTemplate>--%>
                                    <div id="Div1">   

                                    <!--Populates GridView1-->
                                    <asp:SqlDataSource ID="dsProjectUpdates" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_UpdateStatusMostRecent" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:Parameter Name="Active" DefaultValue="True" />
                                        </SelectParameters>                                        
                                        </asp:SqlDataSource>
                                        

                                     <!--Week Ending Values-->
                                    <asp:SqlDataSource ID="dsWeekEnding" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:DashboardConnectionString %>" 
                                        SelectCommand="p_WeekEndingAll" SelectCommandType="StoredProcedure" />

                                                                                                               
                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        
                                        <table border="0" width="100%">
                                            <tr>
                                                <td align="left"><h2><asp:Label ID="lblPageHeader" runat="server" Text="Active Projects Status" /></h2></td>
                                                <td>Active? <asp:DropDownList ID="ddlActive" runat="server" OnSelectedIndexChanged="ddlActive_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="Yes" Value="1" Selected="True" />
                                                            <asp:ListItem Text="No" Value="0" />                                                           
                                                        </asp:DropDownList></td>                                               
                                            </tr>
                                        </table>
                                        <div class="grid">
                                        <asp:GridView id="GridView1" runat="server" DataSourceID="dsProjectUpdates" OnRowDataBound="GridView1_RowDataBound" 
                                            AutoGenerateColumns="false" Width="100%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                                         AllowSorting="true">
                                        <RowStyle CssClass="row" />
                                        <HeaderStyle CssClass="gridcolumnheader" />
                                        <Columns>                                                                             
                                            <asp:TemplateField HeaderText=" ">
                                                <ItemTemplate>
                                                     <a href="project.updates.aspx?AllIssues=All&ProjectID=<%# Container.DataItem("ProjectID")%>">
                                                     <img src="images/page_find.gif" border="0" alt="Find" /></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>                                            
                                            <asp:BoundField DataField="ProjectName" HeaderText="Project Name" runat="server" SortExpression="ProjectName" />
                                            <asp:HyperLinkField 
                                            DataTextField="WeekEnding" 
                                            HeaderText="Week Ending" 
                                            DataNavigateUrlFields="ProjectStatusID" 
                                            SortExpression="WeekEnding"  
                                            ItemStyle-CssClass="first" 
                                            DataTextFormatString="{0:d}"                                            
                                            DataNavigateUrlFormatString="project.updates.detail.aspx?ProjectStatusID={0}">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            </asp:HyperLinkField>
                                            <asp:BoundField DataField="Status" HeaderText="Status" runat="server" SortExpression="Status" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="Comments" HeaderText="Comments" runat="server" />
                                            <asp:BoundField DataField="Username" HeaderText="Entered By" runat="server" SortExpression="Username" />                                           
                                        </Columns>
                                        </asp:GridView>
                                        </div>
                                        <%--<cc1:Grid id="GridView1" runat="server" DataSourceID="dsProjectUpdates" 
                                            AutoGenerateColumns="false" AllowFiltering="true" Width="100%" FolderStyle="Styles/style_5" 
                                         AllowSorting="true" 
                                            AllowGrouping="true" AllowAddingRecords="false">
                                        <Columns>                                            
                                            <cc1:Column HeaderText="Details" runat="server" Width="5%" templateID="tplProjectName" />
                                            <cc1:Column DataField="ProjectName" HeaderText="Project Name" runat="server" Wrap="true" Width="25%" />
                                            <cc1:Column DataField="WeekEnding" HeaderText="Week Ending" runat="server" DataFormatString="{0:d}" Width="20%" />
                                             <cc1:Column ID="PercentComplete" DataField="PercentComplete" HeaderText="% Complete" runat="server" Width="15%" />
                                            <cc1:Column DataField="Comments" HeaderText="Comments" runat="server" Wrap="true" Width="20%" />
                                            <cc1:Column ID="Column1" DataField="Status" HeaderText="Status" Width="50" Align="center" runat="server">
				                                <TemplateSettings TemplateID="ImageTemplate" />
				                            </cc1:Column>
                                        </Columns>
                                         <ExportingSettings ExportTemplates="true" />

                                        <Templates>
                                            <cc1:GridTemplate runat="server" ID="tplProjectName">                    
                                            <Template>
                                                 <a href="project.updates.detail.aspx?ProjectID=<%# Container.DataItem("ProjectID")%>">
                                                     <img src="images/page_find.gif" border="0" /></a>                                                                
                                            </Template>                                                        
                                         </cc1:GridTemplate>
                                         <cc1:GridTemplate runat="server" ID="ImageTemplate">
					                        <Template><img src="images/<%# Container.Value %>.gif" alt="" width="12" height="12" border="0" /></Template>
				                        </cc1:GridTemplate>
                                        </Templates>
                                        <ExportingSettings ExportAllPages="true" ColumnsToExport="ProjectName,WeekEnding,Comments,Status" />
                                        </cc1:Grid>--%>
                                        <br />
                                        
                                        <div align="center">
                                        <asp:Button ID="btnExportExcel" runat="server" Text="Export records to Excel" OnClick="btnExportExcel_Click" CssClass="button" />
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
    </form>
</body>
</html>
