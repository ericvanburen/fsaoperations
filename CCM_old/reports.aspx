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
            'Dim chkLogin As New CheckLogin
            'lblUserID.Text = chkLogin.CheckLogin()
        End If
    End Sub
    
    Sub btnReportVariablePeriod_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView_VariablePeriod()
    End Sub
    
    Sub btnReportFailedCalls_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView_FailedCalls()
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
            
            'Hide the other report(s) if visible
            grdFailedCalls.Visible = False
            btnExcelExport_FailedCalls.Visible = False
            lblRowCountFailedCalls.Visible = False
            grdVariablePeriod.Visible = True
            
            'Make the Excel export button visible
            btnExportExcel_VariablePeriod.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Sub BindGridView_FailedCalls()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Report_FailedCalls", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@DateofReviewBegin", SqlDbType.VarChar).Value = txtDateofReviewBeginFailedCalls.Text
        cmd.Parameters.Add("@DateofReviewEnd", SqlDbType.VarChar).Value = txtDateofReviewEndFailedCalls.Text
               
        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)
            
            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
              
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCountFailedCalls.Text = "Your search returned " & intRecordCount & " records"
                       
            grdFailedCalls.DataSource = ds.Tables("Requests").DefaultView
            grdFailedCalls.DataBind()
            
            'Hide the other report(s) if visible
            grdVariablePeriod.Visible = False
            btnExportExcel_VariablePeriod.Visible = False
            lblRowCountVariablePeriod.Visible = False
            grdFailedCalls.Visible = True
            
            'Make the Excel export button visible
            btnExcelExport_FailedCalls.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Private Sub btnExportExcel_VariablePeriod_Click(ByVal sender As Object, ByVal e As EventArgs)
        Export("Calls.Monitored.by.Call.Center.xls", grdVariablePeriod)
    End Sub
    
    Private Sub btnExportExcel_FailedCalls_Click(ByVal sender As Object, ByVal e As EventArgs)
        Export("Failed.Calls.xls", grdFailedCalls)
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
    
    Protected Sub grdFailedCalls_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim strSortString = Convert.ToString(e.SortExpression) & " " & GetSortDirection(e.SortDirection)
        lblSortExpression.Text = strSortString.ToString
        'Now bind the gridview with the results
        BindGridView_FailedCalls()
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
  

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Center Monitor Reports</title>
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
                                    <li><a href="#">Reports</a></li>                                                          
                                    <li><a href="search.aspx">Search</a></li>
                                 <li><a href="#">Administration</a>
                                <ul>
                                    <li><a href="admin/call.reasons.aspx">Call Reasons</a></li>
                                    <li><a href="admin/concerns.aspx">Concerns</a></li>
                                    <li><a href="admin/user.manager.aspx">User Manager</a></li>
                                </ul></li>
                                
                                <li><a href="#">Monitor Forms</a>
                                <ul>
                                    <li><a href="formB.aspx">Form B</a></li>
                                    <li><a href="formC.aspx">Form C</a></li>
                                </ul></li>                           
                          </ul>
                            </div>
                            <p>&nbsp;</p>
                            
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
                                                <td  valign="top" colspan="3">   
                                                <p><strong>Calls Monitored by Call Center for a Variable Period</strong></p>
                                                  <br /></td>
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
                                                <hr />
                                                <table cellpadding="2" cellspacing="2" border="0" width="100%">                                                
                                                <tr>
                                                <td  valign="top" colspan="3">   
                                                <p><strong>Failed Calls</strong></p><br />
                                                  </td>
                                                 </tr>  
                                                   
                                                <tr>
                                                <td valign="top">   
                                                <strong>Begin Date of Review:</strong><br />  
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender3" runat="server" targetcontrolid="txtDateofReviewBeginFailedCalls" />
                                                            <asp:TextBox ID="txtDateofReviewBeginFailedCalls" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateofReviewBeginFailedCalls" ErrorMessage="* Begin Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="FailedCalls" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    </td>

                                                    <td valign="top">
                                                    <strong>End Date of Review:</strong><br />
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>
                                                            <cc1:calendarextender id="CalendarExtender4" runat="server" targetcontrolid="txtDateofReviewEndFailedCalls" />
                                                            <asp:TextBox ID="txtDateofReviewEndFailedCalls" runat="server" /><br />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateofReviewEndFailedCalls" ErrorMessage="* End Date is reqired" CssClass="warning" Display="Dynamic" ValidationGroup="FailedCalls" /> 
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>                                
                                                </td> 
                                                 <td valign="bottom">
                                                        <asp:Button ID="btnReportFailedCalls" runat="server" CssClass="button" Text="Search" OnClick="btnReportFailedCalls_Click" ValidationGroup="FailedCalls" />                                                        
                                                    </td>
                                                </tr>                                                
                                        </table>
                                                                                
                                        
                                        <hr />

                                        </div>
                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />

    <div id="divVariablePeriod" class="grid" align="center">
    <asp:Label ID="lblRowCountVariablePeriod" runat="server" CssClass="warning" />
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
        <div align="center">
            <asp:Button ID="btnExportExcel_VariablePeriod" runat="server" CssClass="button" Text="Export to Excel" OnClick="btnExportExcel_VariablePeriod_Click" Visible="false" />
        </div>
        </div>
    
    <div id="dvGrid" class="grid" align="center">
    <asp:Label ID="lblRowCountFailedCalls" runat="server" CssClass="warning" />
               <asp:GridView ID="grdFailedCalls" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="true" 
                        OnSorting="grdFailedCalls_Sorting"
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            DataKeyNames="ReviewID"
			            BackColor="White" 
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
                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" SortExpression="CallCenter" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="AgentID" HeaderText="AgentID" SortExpression="AgentID" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="DateofReview" HeaderText="Date of Review" SortExpression="DateofReview" DataFormatString="{0:d}" HtmlEncode="false" />
                             <asp:TemplateField HeaderText="Passed?" SortExpression="OverallScore">
                            <ItemTemplate>
                                <asp:Label id="lblOverallScore" runat="server" text='<%# IIF(Eval("OverallScore"),"Yes","No") %>'></asp:Label>
                            </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Issue1" HeaderText="Issue1" ItemStyle-HorizontalAlign="Left"   />
                            <asp:BoundField DataField="Issue2" HeaderText="Issue2" ItemStyle-HorizontalAlign="Left"  />
                            <asp:BoundField DataField="Issue3" HeaderText="Issue3" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Concern1" HeaderText="Concern1" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Concern2" HeaderText="Concern2"  ItemStyle-HorizontalAlign="Left"/>
                            <asp:BoundField DataField="Concern3" HeaderText="Concern3" ItemStyle-HorizontalAlign="Left" />
                        </Columns>
                        <RowStyle CssClass="row" />
                        <AlternatingRowStyle CssClass="rowalternate" />
                        <FooterStyle CssClass="gridcolumnheader" />
                        <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                        <HeaderStyle CssClass="gridcolumnheader" />
                        <EditRowStyle CssClass="gridEditRow" />       
        </asp:GridView><br />
        <div align="center">
            <asp:Button ID="btnExcelExport_FailedCalls" runat="server" CssClass="button" Text="Export to Excel" OnClick="btnExportExcel_FailedCalls_Click" Visible="false" />
        </div>
        </div>  
        
      
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
    </form>
</body>
</html>
