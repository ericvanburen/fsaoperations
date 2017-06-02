<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace = "CSV" %>
<%@ Import Namespace="CheckLogin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            
            'First check for a valid, logged in user
            Dim chkLogin As New CheckLogin
            lblUserID.Text = chkLogin.CheckLogin()
            
            BindGridView()
        End If
    End Sub
       
    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_MyReviews", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(lblUserID.Text)
                
        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)
            
            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
              
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your list contains returned " & intRecordCount & " records"
            
            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text
           
            GridView1.DataSource = ds.Tables("Requests").DefaultView
            GridView1.DataBind()
            
            'Make the Excel export button visible
            pnlGridViewStats.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    'Private Sub btnExcelExport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
    Protected Sub btnExportExcel_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_Search", MyConnection)
                
        With cmd
            .CommandType = CommandType.StoredProcedure
            cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = Convert.ToInt32(lblUserID.Text)
        End With

        Dim da As New SqlDataAdapter(cmd)
        Dim myDataTable As DataTable = New DataTable()
        da.Fill(myDataTable)

        Try
            MyConnection.Open()
            Response.Clear()
            Response.ClearHeaders()
            Dim writer As New CsvWriter(Response.OutputStream, ","c, Encoding.Default)
            writer.WriteAll(myDataTable, True)
            writer.Close()

            Dim FileDate As String = Replace(FormatDateTime(Now(), DateFormat.ShortDate), "/", "")
            Response.AddHeader("Content-Disposition", "attachment;filename=Call_Monitoring_" & FileDate & ".csv")
            Response.ContentType = "application/vnd.ms-excel"
            Response.End()
        Finally
            If MyConnection.State <> ConnectionState.Closed Then MyConnection.Close()
            MyConnection.Dispose()
            MyConnection = Nothing
            myDataTable.Dispose()
            myDataTable = Nothing
        End Try
    End Sub
    
    Protected Sub GridView1_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim strSortString = Convert.ToString(e.SortExpression) & " " & GetSortDirection(e.SortDirection)
        lblSortExpression.Text = strSortString.ToString
        'Now bind the gridview with the results
        BindGridView()
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
    
    Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        GridView1.PageIndex = e.NewPageIndex
        BindGridView()
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Center Monitor</title>
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
                                <li><a href="#tabs-1">Monitoring</a></li>                                
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

                            <div class="pageSubHeader" align="left" style="padding-left: 20px">
                              <span>My Call Reviews</span> 
                            </div>
                                
                                <div align="center">
                                    <asp:Panel ID="pnlGridViewStats" runat="server" Visible="false" Width="900px" HorizontalAlign="Center">
                                        <table border="0" width="100%">
                                            <tr>
                                                <td width="33%">&nbsp;</td>
                                                <td align="center" width="33%">
                                                    <asp:Label ID="lblRowCount" runat="server" CssClass="warning" />
                                                </td>
                                                <td align="right" width="33%">
                                                    <asp:ImageButton ID="btnExportExcel" runat="server" CausesValidation="false" ImageUrl="images/btnExportExcel.gif"
                                                        OnClick="btnExportExcel_Click" CssClass="btnExportExcel" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>             

               <div id="dvGrid" class="grid" align="center">               
               <asp:GridView ID="GridView1" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="true" 
                        AllowPaging="true" 
                        PageSize="30" 
                        OnSorting="GridView1_Sorting" 
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            DataKeyNames="ReviewID"
			            BackColor="White" 
			            GridLines="Horizontal"
                        CellPadding="3" 
                        BorderColor="#E7E7FF"
			            Width="875px" 
			            BorderStyle="None" 
			            ShowFooter="false">
			            <EmptyDataTemplate>
			                No records matched your search
			            </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                                <ItemTemplate>
                    
                                   <asp:hyperlink id="HyperLink2" runat="server" navigateurl='<%# Eval("ReviewID", "formB.detail.aspx?ReviewID={0}") %>'
                                    text='<%# Eval("ReviewID") %>' />

                                </ItemTemplate>                            
                            </asp:TemplateField>                                                       
                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" SortExpression="CallCenter" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Username" HeaderText="Evaluator" SortExpression="Username" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="DateofReview" HeaderText="Date of Review" SortExpression="DateofReview" DataFormatString="{0:d}" HtmlEncode="false" />
                            <asp:BoundField DataField="AgentID" HeaderText="Agent ID" SortExpression="AgentID" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="BorrowerAccountNumber" HeaderText="Acct #" SortExpression="BorrowerAccountNumber" ItemStyle-HorizontalAlign="Left" />                            
                            <asp:TemplateField HeaderText="Passed?" SortExpression="OverallScore">
                            <ItemTemplate>
                                <asp:Label id="lblOverallScore" runat="server" text='<%# IIF(Eval("OverallScore"),"Yes","No") %>'></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />      
                            <asp:BoundField DataField="Issue1" HeaderText="Issue1" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Issue2" HeaderText="Issue2" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Issue3" HeaderText="Issue3" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Concern1" HeaderText="Concern1" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Concern2" HeaderText="Concern2" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Concern3" HeaderText="Concern3" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
        </asp:GridView>
        
        <br />
       
        </div>
        </ContentTemplate>
        </asp:UpdatePanel>
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
