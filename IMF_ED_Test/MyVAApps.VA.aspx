<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'VA and PCA page - Call Check Login Status
            CheckVALogin()
            
            If Not IsNothing(Request.QueryString("GA_ID")) Then
                Dim intGA_ID As String = Request.QueryString("GA_ID").ToString()
                lblGA_ID.Text = intGA_ID
            Else
                If Not IsNothing(Request.Cookies("IMF")) Then
                    lblGA_ID.Text = (Request.Cookies("IMF")("GA_ID").ToString())
                    lblGA_Name.Text = GetGA_Name().ToString()
                End If
            End If
        End If
    End Sub
    
    'Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        Dim link1 As HyperLink = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
    '        If String.IsNullOrEmpty(link1.NavigateUrl) Then
    '            Dim li As HtmlGenericControl = CType(e.Row.FindControl("l1"), HtmlGenericControl)
    '            li.Visible = False
    '        End If            
    '    End If
    'End Sub
    
    Protected Sub chkIncludeCompleted_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all VA Apps
            GridView1.DataSourceID = "dsMyVAApps"
        Else
            'Only show those VA Apps which has not been completed
            GridView1.DataSourceID = "dsMyVAApps_NoCompleted"
        End If
    End Sub
    
    Sub BindGridView_Completed()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyVAApps_GA"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_ID", SqlDbType.Varchar).Value = lblGA_ID.Text
        cmd.Connection = con
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            GridView1.DataSource = dr
            GridView1.DataBind()
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub BindGridView_NoCompleted()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyVAApps_GA_NoCompleted"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_ID", SqlDbType.Varchar).Value = lblGA_ID.Text
        cmd.Connection = con
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            GridView1.DataSource = dr
            GridView1.DataBind()
        Finally
            con.Close()
        End Try
    End Sub
    
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        '**** Do not remove ****
        ' Confirms that an HtmlForm control is rendered for the   
        ' specified ASP.NET server control at run time.   
        ' No code required here.   
    End Sub
    
    Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        GridView1.AllowSorting = False
        GridView1.AllowPaging = False
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all VA Apps
            GridView1.DataSourceID = Nothing
            BindGridView_Completed()
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = Nothing
            BindGridView_NoCompleted()
        End If
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=VA.App.Search.Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " VA Apps"
    End Sub
    
    Private Function GetGA_Name() As String
        Dim strGA_Name As String = ""
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "GetGA_Name"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_ID", SqlDbType.VarChar).Value = lblGA_ID.Text
        cmd.Connection = con
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            While dr.Read
                strGA_Name = dr("GA_Name")
            End While
        Finally
            con.Close()
        End Try
        Return strGA_Name
    End Function
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>GA VA Discharge Applications</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
  
                <asp:SqlDataSource ID="dsMyVAApps_NoCompleted" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyVAApps_GA_NoCompleted" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblGA_ID" Name="GA_ID" />                            
                        </SelectParameters>
                     </asp:SqlDataSource>  
                     
                     <asp:SqlDataSource ID="dsMyVAApps" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyVAApps_GA" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblGA_ID" Name="GA_ID" />                            
                        </SelectParameters>
                     </asp:SqlDataSource>
                  
                  <div align="center">     
                      <h2>My VA Apps (<%=lblGA_Name.Text%>)</h2>
                        <asp:Panel ID="pnlMyVAApps" runat="server">                                        
                            <div align="center" width="90%">
                            <asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include Completed VA Apps? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                            </div>
                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsMyVAApps_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20"> 
                            
                            <EmptyDataTemplate>
                                    You have not submitted any VA Discharge Applications
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                              		                    
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="VA App ID" 
                                    DataNavigateUrlFields="Id,SSN" 
                                    SortExpression="Id"  
                                    ItemStyle-CssClass="first"
                                    DataNavigateUrlFormatString="va.app.detail.aspx?Id={0}&SSN={1}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>                                 
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    SortExpression="DateSubmitted" />
                                                                  
                                    <asp:BoundField 
                                    DataField="SSN" 
                                    HeaderText="SSN"
                                    SortExpression="SSN" />
                                                                       
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />
                                    
                                    <asp:BoundField 
                                    DataField="GA_Employee" 
                                    HeaderText="GA Name" />
                                    
                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="Assigned To" 
                                    SortExpression="Username" /> 
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="DateClosed" />   
                                    
                                    <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />                                                                  
                                    
                                   
                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>                     
                   </asp:Panel>
                   </div>  
   
<asp:Label ID="lblGA_ID" runat="server" Visible="false" />
<asp:Label ID="lblGA_Name" runat="server" Visible="false" />
 </form>
</body>
</html>
