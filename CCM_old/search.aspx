<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
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
        End If
    End Sub
    
    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        If GridView1.Rows.Count > 0 Then
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub
    
    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub
    
    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("search.aspx")
    End Sub
    
    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtReviewID.Text <> "" Then
            cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = Convert.ToInt32(txtReviewID.Text)
        End If
        
        'This one passes a comma-delimited string for @CallCenterID which is used in the split function
        If ddlCallCenterID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlCallCenterID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@CallCenterID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        If txtDateofReview.Text <> "" Then
            cmd.Parameters.Add("@DateofReview", SqlDbType.VarChar).Value = txtDateofReview.Text
        End If
        
        If txtDateofReviewLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateofReviewLessThan", SqlDbType.VarChar).Value = txtDateofReviewLessThan.Text
        End If
        
        If txtAgentID.Text <> "" Then
            cmd.Parameters.Add("@AgentID", SqlDbType.VarChar).Value = txtAgentID.Text
        End If
        
        If txtBorrowerAccountNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerAccountNumber", SqlDbType.VarChar).Value = txtBorrowerAccountNumber.Text
        End If
        
        If txtComments.Text <> "" Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        End If

        If ddlUserID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlUserID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        If ddlOverAllScore.SelectedValue <> "" Then
            cmd.Parameters.Add("@OverallScore", SqlDbType.Bit).Value = ddlOverAllScore.SelectedValue
        End If
        
        'This one passes a comma-delimited string for @Issue1ID which is used in the split function
        If ddlIssue1.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlIssue1.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Issue1ID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        'This one passes a comma-delimited string for @Issue2ID which is used in the split function
        If ddlIssue2.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlIssue2.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Issue2ID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        'This one passes a comma-delimited string for @Concern1ID which is used in the split function
        If ddlConcern1.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlConcern1.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Concern1ID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        'This one passes a comma-delimited string for @Concern2ID which is used in the split function
        If ddlConcern2.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlConcern2.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Concern2ID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        
        If ddlEscalationIssue.SelectedValue <> "" Then
            cmd.Parameters.Add("@EscalationIssue", SqlDbType.Bit).Value = ddlEscalationIssue.SelectedValue
        End If
        
        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)
            
            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
              
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"
            
            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text
           
            GridView1.DataSource = ds.Tables("Requests").DefaultView
            GridView1.DataBind()
            
            'Make the Excel export button visible
            pnlGridViewStats.Visible = True
            
            'Make search again button visible
            btnSearchAgain.Visible = True
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
            If txtReviewID.Text <> "" Then
                .Parameters.Add("@ReviewID", SqlDbType.Int).Value = Convert.ToInt32(txtReviewID.Text)
            End If
            
            'This one passes a comma-delimited string for @CallCenterID which is used in the split function
            If ddlCallCenterID.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlCallCenterID.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                .Parameters.AddWithValue("@CallCenterID", SqlDbType.VarChar).Value = strSearchValue
            End If
        
            If txtDateofReview.Text <> "" Then
                .Parameters.Add("@DateofReview", SqlDbType.VarChar).Value = txtDateofReview.Text
            End If
            
            If txtDateofReviewLessThan.Text <> "" Then
                cmd.Parameters.Add("@DateofReviewLessThan", SqlDbType.VarChar).Value = txtDateofReviewLessThan.Text
            End If
        
            If txtAgentID.Text <> "" Then
                .Parameters.Add("@AgentID", SqlDbType.VarChar).Value = txtAgentID.Text
            End If
        
            If txtBorrowerAccountNumber.Text <> "" Then
                .Parameters.Add("@BorrowerAccountNumber", SqlDbType.VarChar).Value = txtBorrowerAccountNumber.Text
            End If
               
            If txtComments.Text <> "" Then
                .Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
            End If

            If ddlUserID.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlUserID.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                .Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
            End If
            
            If ddlOverAllScore.SelectedValue <> "" Then
                .Parameters.Add("@OverallScore", SqlDbType.Bit).Value = ddlOverAllScore.SelectedValue
            End If
            
            'This one passes a comma-delimited string for @Issue1ID which is used in the split function
            If ddlIssue1.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlIssue1.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                .Parameters.AddWithValue("@Issue1ID", SqlDbType.VarChar).Value = strSearchValue
            End If
        
            'This one passes a comma-delimited string for @Issue2ID which is used in the split function
            If ddlIssue2.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlIssue2.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                .Parameters.AddWithValue("@Issue2ID", SqlDbType.VarChar).Value = strSearchValue
            End If
        
            'This one passes a comma-delimited string for @Concern1ID which is used in the split function
            If ddlConcern1.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlConcern1.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                .Parameters.AddWithValue("@Concern1ID", SqlDbType.VarChar).Value = strSearchValue
            End If
        
            'This one passes a comma-delimited string for @Concern2ID which is used in the split function
            If ddlConcern2.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlConcern2.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                .Parameters.AddWithValue("@Concern2ID", SqlDbType.VarChar).Value = strSearchValue
            End If
        
        
            If ddlEscalationIssue.SelectedValue <> "" Then
                .Parameters.Add("@EscalationIssue", SqlDbType.Bit).Value = ddlEscalationIssue.SelectedValue
            End If
            
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
    <title>Call Center Monitor Search</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

     <style type="text/css">
     .highlite {
        background-color: Yellow;
    }
    </style>

     <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
     <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
     <script src="Scripts/menu.js" type="text/javascript"></script>
     <script src="Scripts/jquery.quicksearch.js" type="text/javascript"></script>
     <script type="text/javascript">
        $(function () {
            $('input#id_search').quicksearch('table#GridView1 tbody tr')
        })
    </script>

         
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
                                <li><a href="#tabs-1">Search</a></li>                                
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
                                        
                                        <table width="100%" cellpadding="4" cellspacing="5" border="0">
                                                                                   
                                            <tr>
                                                <td width="33%" valign="top">   
                                                <strong>Review ID: </strong><br />
                                                <asp:TextBox ID="txtReviewID" runat="server" />                                       
                                                </td>
                                                <td  width="33%" valign="top">
                                                   <strong>Call Center Location:</strong><br />
                                                    <asp:Listbox ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters" Rows="4"  
                                                  AppendDataBoundItems="true" DataTextField="CallCenter" DataValueField="CallCenterID" SelectionMode="Multiple">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:Listbox>          
                                                </td>
                                                <td  width="33%" valign="top">
                                                        <strong>Date of Review:</strong><br />                                                     
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender3" runat="server" targetcontrolid="txtDateofReview" />
                                                            <asp:TextBox ID="txtDateofReview" runat="server" /> (greater than)                                                            
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    
                                                    <br /><br />
                                                    
                                                    <strong>Date of Review:</strong><br />                                           
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender4" runat="server" targetcontrolid="txtDateofReviewLessThan" />
                                                            <asp:TextBox ID="txtDateofReviewLessThan" runat="server" /> (less than)                                                            
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                             
                                                </td>
                                            </tr>
                                            <tr>
                                                <td  width="33%" valign="top"><strong>Agent ID: </strong><br />
                                                    <asp:TextBox ID="txtAgentID" runat="server" /></td>
                                                <td  width="33%" valign="top"><strong>Account No/NSLDS ID:</strong><br />
                                                    <asp:TextBox ID="txtBorrowerAccountNumber" runat="server" /></td>
                                                <td  width="33%" valign="top"><strong>Evaluator:</strong><br />
                                                 <asp:Listbox ID="ddlUserID" runat="server" DataSourceID="dsUserID" Rows="4"  
                                                  AppendDataBoundItems="true" DataTextField="Username" DataValueField="UserID" SelectionMode="Multiple"> 
                                                     <asp:ListItem Text="" Value="" />
                                                    </asp:Listbox>                                                    
                                                </td>
                                            </tr>
                                            
                                             <tr>
                                                 <td valign="top"><strong>Issue 1:</strong><br />
                                                 <asp:ListBox ID="ddlIssue1" runat="server" DataSourceID="dsReasonCode" SelectionMode="Multiple" Rows="4" 
                                                           Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" 
                                                            DataValueField="ReasonCode">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:ListBox> 
                                                 </td>
                                                 <td valign="top" colspan="2">
                                                 <strong>Issue 2:</strong><br />
                                                 <asp:ListBox ID="ddlIssue2" runat="server" DataSourceID="dsReasonCode" SelectionMode="Multiple" Rows="4" 
                                                            Width="350px"
                                                            AppendDataBoundItems="true" DataTextField="ReasonForCall" 
                                                            DataValueField="ReasonCode">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:ListBox>
                                                 </td>
                                            </tr> 
                                            <tr>
                                                <td valign="top"><strong>Common Concern 1:</strong><br />
                                                <asp:ListBox ID="ddlConcern1" runat="server" DataSourceID="dsConcerns" SelectionMode="Multiple" Rows="4" 
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID" Width="350px">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:ListBox>
                                                 </td>
                                                 <td valign="top" colspan="2"><strong>Common Concern 2:</strong><br />
                                                <asp:ListBox ID="ddlConcern2" runat="server" DataSourceID="dsConcerns" SelectionMode="Multiple" Rows="4" 
                                                            AppendDataBoundItems="true" DataTextField="Concern" DataValueField="ConcernID" Width="350px">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:ListBox>
                                                 </td>
                                            </tr>
                                            <tr>
                                                <td  width="33%" valign="top"><strong>Pass/Fail:</strong><br />
                                                <asp:Dropdownlist ID="ddlOverAllScore" runat="server"> 
                                                     <asp:ListItem Text="" Value="" />
                                                     <asp:ListItem Text="Passed" Value="True" />
                                                     <asp:ListItem Text="Failed" Value="False" />
                                                    </asp:Dropdownlist> 
                                                </td>
                                                <td  width="33%" valign="top">                                               
                                                    <strong>Escalation Issue</strong><br />
                                                     <asp:Dropdownlist ID="ddlEscalationIssue" runat="server"> 
                                                     <asp:ListItem Text="" Value="" />
                                                     <asp:ListItem Text="Yes" Value="True" />
                                                     <asp:ListItem Text="No" Value="False" />
                                                    </asp:Dropdownlist>
                                                </td>
                                                <td  width="33%" valign="top">&nbsp;</td>
                                             </tr>
                                                                                  
                                          </table>

                                                <table width="100%" cellpadding="2" cellspacing="2" border="0">                                                 
                                                <tr>
                                                    <td colspan="3"><strong>Comments:</strong>
                                                    <br />
                                                    <asp:TextBox ID="txtComments" runat="server" TextMode="SingleLine" Width="750" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="3" align="center">
                                                        <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnSearch_Click" />
                                                        <asp:Button ID="btnSearchAgain" runat="server" CssClass="button" Text="Search Again" OnClick="btnSearchAgain_Click" Visible="false" />
                                                        
                                                    </td>
                                                </tr>
                                                
                                        </table>
                                        </div>
                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />

    <div align="center">
    <asp:Panel ID="pnlGridViewStats" runat="server" Visible="false" Width="90%" HorizontalAlign="Center">
    <table border="0" width="100%">
    <tr>
        <td align="left">Filter these results: <input id="id_search" type="text" placeholder="Search" /></td>
        <td align="center" width="33%"><asp:Label ID="lblRowCount" runat="server" CssClass="warning" /></td>
        <td align="right" width="33%"><asp:ImageButton ID="btnExportExcel" runat="server" CausesValidation="false" ImageUrl="images/btnExportExcel.gif" onclick="btnExportExcel_Click" CssClass="btnExportExcel" /></td>
     </tr>
    </table>
   </asp:Panel>
   </div>
    
    <div id="dvGrid" class="grid" align="center">
              <asp:GridView ID="GridView1" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="true" 
                        OnSorting="GridView1_Sorting"
                        AllowPaging="true" 
                        OnPageIndexChanging="GridView1_PageIndexChanging" 
                        PageSize="50"                        
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            DataKeyNames="ReviewID"
			            BackColor="White" 
                        OnPreRender="GridView1_PreRender" 
			            GridLines="Horizontal"
                        CellPadding="3" 
                        BorderColor="#E7E7FF"
			            Width="90%" 
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
                            <asp:TemplateField HeaderText="Escalated?" SortExpression="OverallScore">
                            <ItemTemplate>
                                <asp:Label id="lblEscalationIssue" runat="server" text='<%# IIF(Eval("EscalationIssue"),"Yes","No") %>'></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Issue1" HeaderText="Issue1" SortExpression="Issue1" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Issue2" HeaderText="Issue2" SortExpression="Issue2" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Issue3" HeaderText="Issue3" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />
                            <asp:BoundField DataField="Concern1" HeaderText="Concern1" SortExpression="Concern1" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Concern2" HeaderText="Concern2" SortExpression="Concern2" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Concern3" HeaderText="Concern3" HeaderStyle-CssClass="hideColumn" ItemStyle-CssClass="hideColumn" />                            
                            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />     
                            
                           
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
        </asp:GridView><br />     
        </div>      
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
    </form>
</body>
</html>
