<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace = "CSV" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'First check for a valid, logged in user
            Dim chkLogin As New CheckLogin
            lblUserID.Text = chkLogin.CheckLogin()
            
            ChtCallCount_AllCenters.Visible = False
        End If
    End Sub
    
    Sub btnReportVariablePeriod_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView_VariablePeriod()
    End Sub
        
    Sub BindGridView_VariablePeriod()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Report_VariablePeriod", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@DateofReviewBegin", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
        cmd.Parameters.Add("@DateofReviewEnd", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text
               
        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)
            
            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
              
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCountVariablePeriod.Text = "Your search returned " & intRecordCount & " records"
                       
            grdVariablePeriod.DataSource = ds.Tables("Requests").DefaultView
            grdVariablePeriod.DataBind()
            
            grdVariablePeriod.Visible = True
            
            'Make the Excel export button visible
            pnlGridViewStats.Visible = True
            
            'Create the chart
            ChtCallCount_AllCenters.Visible = True
            Chart_CallCount_AllCenters()
            
        Finally
            strSQLConn.Close()
        End Try
    End Sub
   
    
    Private Sub btnExportExcel_VariablePeriod_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Export("Calls.Monitored.by.Call.Center.xls", grdVariablePeriod)
    End Sub
    
      
    Public Shared Sub Export(ByVal fileName As String, ByVal gv As GridView)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As StringWriter = New StringWriter
        Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        '  Create a form to contain the grid
        Dim table As Table = New Table
        table.GridLines = gv.GridLines
        '  add the header row to the table
        If (Not (gv.HeaderRow) Is Nothing) Then
            PrepareControlForExport(gv.HeaderRow)
            table.Rows.Add(gv.HeaderRow)
        End If
        '  add each of the data rows to the table
        For Each row As GridViewRow In gv.Rows
            PrepareControlForExport(row)
            table.Rows.Add(row)
        Next
        '  add the footer row to the table
        If (Not (gv.FooterRow) Is Nothing) Then
            PrepareControlForExport(gv.FooterRow)
            table.Rows.Add(gv.FooterRow)
        End If
            
        '  render the table into the htmlwriter
        table.RenderControl(htw)
        '  render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString)
        HttpContext.Current.Response.End()
    End Sub

    ' Replace any of the contained controls with literals
    Private Shared Sub PrepareControlForExport(ByVal control As Control)
        Dim i As Integer = 0
        Do While (i < control.Controls.Count)
            Dim current As Control = control.Controls(i)
            If (TypeOf current Is LinkButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
            ElseIf (TypeOf current Is ImageButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
            ElseIf (TypeOf current Is HyperLink) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
            ElseIf (TypeOf current Is DropDownList) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
            ElseIf (TypeOf current Is CheckBox) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
                'TODO: Warning!!!, inline IF is not supported ?
            End If
            If current.HasControls Then
                PrepareControlForExport(current)
            End If
            i = (i + 1)
        Loop
    End Sub
    
       
    Private Function GetSortDirection(ByVal column As String) As String
        ' By default, set the sort direction to ascending. 
        Dim sortDirection = "ASC"
        ' Retrieve the last column that was sorted. 
        Dim sortExpression = TryCast(ViewState("SortExpression"), String)
        If sortExpression IsNot Nothing Then
            ' Check if the same column is being sorted. 
            ' Otherwise, the default value can be returned. 
            If sortExpression = column Then
                Dim lastDirection = TryCast(ViewState("SortDirection"), String)
                If lastDirection IsNot Nothing _
                AndAlso lastDirection = "ASC" Then
                    sortDirection = "DESC"
                End If
            End If
        End If
        ' Save new values in ViewState. 
        ViewState("SortDirection") = sortDirection
        ViewState("SortExpression") = column
        Return sortDirection
    End Function
    
    Sub Chart_CallCount_AllCenters()
    
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_ChartCallCount"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
            cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()
            
            'Use this one as a default for each value/series in the table - remove any series value in the chart
            ChtCallCount_AllCenters.DataBindTable(myReader, "CallCenter")
           
            ChtCallCount_AllCenters.Series(0).IsValueShownAsLabel = True
            'ChtCallCount_AllCenters.Series(1).IsValueShownAsLabel = False
           
                     
            myReader.Close()
            myConnection.Close()
            
        End Using
    End Sub
  

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Calls Monitored Over Variable Period</title>
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
		                <img src="images/fSA_logo.gif" alt="Federal Student Aid - Call Center Monitoring" />
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Reports</a></li>                                
                            </ul>
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="logout.aspx">Log Out</a></li> 
                                    <li><a href="#">Reports</a>
                                    <ul>
                                       <li><a href="report.calls.monitored.aspx">Calls Monitored</a></li> 
                                       <li><a href="report.failed.calls.aspx">Failed Calls</a></li>
                                       <li><a href="report.accuracy.report.aspx">Accuracy Report</a></li>
                                    </ul>
                                    </li>                                                          
                                    <li><a href="search.aspx">Search</a></li>
                                 <li><a href="#">Administration</a>
                                <ul>
                                    <li><a href="admin/call.centers.aspx">Call Centers</a></li>
                                    <li><a href="admin/call.reasons.aspx">Call Reasons</a></li>
                                    <li><a href="admin/concerns.aspx">Concerns</a></li>
                                    <li><a href="admin/user.manager.aspx">User Manager</a></li>
                                </ul></li>
                                
                                <li><a href="#">Monitoring</a>
                                <ul>
                                    <li><a href="FormB.aspx">Enter Call</a></li>
                                    <li><a href="my.reviews.aspx">My Reviews</a></li>
                                </ul></li>                           
                          </ul>
                            </div>
                            <br /><br />
                            
                            <div id="Div1">                          
                                                                                                              
                                    <!--Call Centers-->
                                    <asp:SqlDataSource ID="dsCallCenters" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />

                                    <!--Call Reason / Issues-->
                                    <asp:SqlDataSource ID="dsReasonCode" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallReasons" SelectCommandType="StoredProcedure" />

                                    <!--Concerns-->
                                    <asp:SqlDataSource ID="dsConcerns" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" />

                                   <!--Users/Evaluators-->
                                    <asp:SqlDataSource ID="dsUserID" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />

                                    <div align="left" style="padding-top: 10px" id="tabs-1">
                                        
                                        <table cellpadding="2" cellspacing="2" border="0" width="100%">                                                                                   
                                                                                       
                                            <tr>
                                                <td  valign="top" colspan="3" class="pageSubHeader">   
                                                Calls Monitored by Call Center for a Variable Period<br /><br />
                                                  </td>
                                                 </tr>  
                                                   
                                                <tr>
                                                <td valign="top">   
                                                <strong>Begin Date of Review:</strong><br />  
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender1" runat="server" targetcontrolid="txtDateofReviewBegin" />
                                                            <asp:TextBox ID="txtDateofReviewBegin" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="txtDateofReviewBegin" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="VariablePeriod" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    
                                                    </td>

                                                    <td valign="top">
                                                    <strong>End Date of Review:</strong><br />
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender2" runat="server" targetcontrolid="txtDateofReviewEnd" />
                                                            <asp:TextBox ID="txtDateofReviewEnd" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateofReviewEnd" ErrorMessage="*End Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="VariablePeriod" /> 
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                
                                                </td> 
                                                 <td valign="bottom">
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnReportVariablePeriod_Click" ValidationGroup="VariablePeriod" />                                                        
                                                    </td>
                                                </tr>
                                                </table>
                                                                                  
                                        </div>
                                        <div align="center">

    <asp:Chart ID="ChtCallCount_AllCenters" runat="server" Width="800px" Height="450px"
                    BorderColor="26, 59, 105" Palette="BrightPastel" BorderDashStyle="Solid" BackSecondaryColor="White"
                    BackGradientStyle="TopBottom" BorderWidth="2" ImageLocation="~/TempImages/ChartPic_#SEQ(300,3)">
                    <Titles>
                        <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" ShadowOffset="3"
                            Text="Calls Monitored" ForeColor="26, 59, 105">
                        </asp:Title>
                    </Titles>
                    <Legends>
                        <asp:Legend Enabled="True" IsTextAutoFit="False" Name="Default" BackColor="Transparent"
                            Font="Trebuchet MS, 8.25pt, style=Bold">
                        </asp:Legend>
                    </Legends>
                    <BorderSkin SkinStyle="Emboss"></BorderSkin>
                    <Series>
                        <%--
								<asp:Series IsValueShownAsLabel="True" ChartArea="ChartArea1" Name="CallCount" CustomProperties="LabelStyle=Bottom" BorderColor="180, 26, 59, 105"></asp:Series> --%>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid"
                            BackSecondaryColor="White" BackColor="64, 165, 191, 228" ShadowColor="Transparent"
                            BackGradientStyle="TopBottom">
                            <AxisY2 Enabled="False">
                            </AxisY2>
                            <AxisX2 Enabled="False">
                            </AxisX2>
                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                WallWidth="0" IsClustered="False" />
                            <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisY>
                            <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" ArrowStyle="Triangle">
                                <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsStaggered="False" Angle="-90" Interval="1" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>

    </div>
                                <div align="center">
                                    <asp:Panel ID="pnlGridViewStats" runat="server" Visible="false" Width="900px" HorizontalAlign="Center">
                                        <table border="0" width="100%">
                                            <tr>
                                                <td width="33%">
                                                    &nbsp;
                                                </td>
                                                <td align="center" width="33%">
                                                    <asp:Label ID="lblRowCountVariablePeriod" runat="server" CssClass="warning" />
                                                </td>
                                                <td align="right" width="33%">
                                                    <asp:ImageButton ID="btnExportExcel" runat="server" CausesValidation="false" ImageUrl="images/btnExportExcel.gif"
                                                        OnClick="btnExportExcel_VariablePeriod_Click" CssClass="btnExportExcel" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>
    
    <div id="divVariablePeriod" class="grid" align="center">
              <asp:GridView ID="grdVariablePeriod" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="false"                         
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            BackColor="White" 
			            GridLines="Horizontal"
                        CellPadding="3" 
                        BorderColor="#E7E7FF"
			            Width="900px" 
			            BorderStyle="None" 
			            ShowFooter="false">
			            <EmptyDataTemplate>
			                No records matched your search
			            </EmptyDataTemplate>
                        <Columns>                                                                             
                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="CountOfCallCenter" HeaderText="Call Count" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />                            
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
        </asp:GridView><br />       
        </div>
                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />

    
       
      
        
      
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
    </form>
</body>
</html>
