<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" Debug="true" %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            If Not IsNothing(Request.QueryString("AgencyID")) Then
                Dim intAG As String = Request.QueryString("AgencyID").ToString()
                lblAgency.Text = intAG
            Else
                If Not IsNothing(Request.Cookies("IMF")) Then
                    lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
                End If
            End If
            
            'lblAgency.Text = "537"           
             
            If lblAgency.Text Is Nothing OrElse lblAgency.Text.Length = 0 Then
                Response.Redirect("/not.logged.in.aspx")
            End If
            
            Dim strStatusID As String = Request.QueryString("StatusID")
            lblStatusID.Text = strStatusID
            ddlStatus.SelectedValue = strStatusID
            UpdateGrid()
            
        End If
    End Sub
        
    Sub BindGridView()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyEmployees_PCA_Status"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@AG", SqlDbType.VarChar).Value = lblAgency.Text
        cmd.Parameters.AddWithValue("@StatusID", SqlDbType.Int).Value = ddlStatus.SelectedValue
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
        'If its checked, then show all IMFs
        GridView1.DataSourceID = Nothing
        BindGridView()
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=My.Employees.xls")
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
        lblRecordCount.Text = "Showing " & recordCount & " employees"
    End Sub
    
    Sub UpdateGrid()
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SearchED_PCAEmployee"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
            
        If lblStatusID.Text <> "All" Then
            Try
                cmd.Parameters.AddWithValue("@StatusID", SqlDbType.VarChar).Value = lblStatusID.Text
                cmd.Parameters.AddWithValue("@AG", SqlDbType.VarChar).Value = lblAgency.Text
                'Remove the old SqlDataSource
                GridView1.DataSource = String.Empty
                GridView1.DataSourceID = String.Empty
                con.Open()
                Dim MyAdapter As New SqlDataAdapter(cmd)

                ds = New DataSet()
                MyAdapter.Fill(ds, "SearchResults")

                Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
                lblRecordCount.Text = "Your search returned " & intRecordCount & " records"

                GridView1.DataSource = ds.Tables("SearchResults").DefaultView
                GridView1.DataBind()
                GridView1.Visible = True
                lblRecordCount.Visible = True

                If intRecordCount > 0 Then
                    btnExportExcel.Visible = True
                Else
                    btnExportExcel.Visible = False
                End If
        	
            Finally
                con.Close()
            End Try
        Else
            GridView1.DataSourceID = "dsMyEmployees"
            GridView1.DataBind()
        End If
        
    End Sub
    
    Protected Sub ddlStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SearchED_PCAEmployee"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
            
        If ddlStatus.SelectedValue <> "All" Then
            Try
                cmd.Parameters.AddWithValue("@StatusID", SqlDbType.VarChar).Value = ddlStatus.SelectedValue
                cmd.Parameters.AddWithValue("@AG", SqlDbType.VarChar).Value = lblAgency.Text
                'Remove the old SqlDataSource
                GridView1.DataSource = String.Empty
                GridView1.DataSourceID = String.Empty
                con.Open()
                Dim MyAdapter As New SqlDataAdapter(cmd)

                ds = New DataSet()
                MyAdapter.Fill(ds, "SearchResults")

                Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
                lblRecordCount.Text = "Your search returned " & intRecordCount & " records"

                GridView1.DataSource = ds.Tables("SearchResults").DefaultView
                GridView1.DataBind()
                GridView1.Visible = True
                lblRecordCount.Visible = True

                If intRecordCount > 0 Then
                    btnExportExcel.Visible = True
                Else
                    btnExportExcel.Visible = False
                End If
        	
            Finally
                con.Close()
            End Try
        Else
            GridView1.DataSourceID = "dsMyEmployees"
            GridView1.DataBind()
        End If
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PCA Employees</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
  
                <asp:SqlDataSource ID="dsMyEmployees" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyEmployees_PCA" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblAgency" Name="AG" />                            
                        </SelectParameters>
                     </asp:SqlDataSource>    

                     <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllStatus_PCAEmployees" SelectCommandType="StoredProcedure" />             
                  
                  <div align="center">     
                      <h2>My Employees (<%=lblAgency.Text%>)</h2>
                        <asp:Panel ID="pnlMyEmployees" runat="server">                                        
                           <div align="center" width="90%">
                            <table width="90%">
                                <tr>
                                    <td><asp:DropdownList id="ddlStatus" Runat="Server"                              
                                            Rows="3" Width="150px" AutoPostBack="true" 
                                            DataSourceID="dsStatus" DataTextField="Status" DataValueField="StatusID"
                                            CssClass="formLabel" AppendDataBoundItems="true" 
                                            onselectedindexchanged="ddlStatus_SelectedIndexChanged">
                                            <asp:ListItem Text="All" Value="All" />
                                            </asp:DropdownList></td>
                                    <td><asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" /></td>
                                </tr>
                            </table>                            
                            </div>

                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="false" AllowSorting="false" PageSize="20" PagerSettings-Position="TopAndBottom"> 
                            
                            <EmptyDataTemplate>
                                    You have not submitted any employees
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                              		                    
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="Employee ID" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id"  
                                    ItemStyle-CssClass="first"
                                    DataNavigateUrlFormatString="employee.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>
                                                                        
                                     <asp:BoundField 
                                    DataField="Last_Name" 
                                    HeaderText="Last Name" 
                                    SortExpression="Last_Name" />
                                                                       
                                     <asp:BoundField 
                                    DataField="First_Name" 
                                    HeaderText="First Name" 
                                    SortExpression="First_Name" />                                 
                                    
                                    <asp:BoundField 
                                    DataField="Date_Employee_Added" 
                                    HeaderText="Date Added" 
                                    SortExpression="Date_Employee_Added" 
                                    DataFormatString="{0:d}"
                                    ItemStyle-HorizontalAlign="Right" />
                                                                     
                                   <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status"
                                    SortExpression="Status"
                                    ItemStyle-HorizontalAlign="Left" />                         

                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>                     
                   </asp:Panel>
                   </div>  
   
<asp:Label ID="lblAgency" runat="server" Visible="false" />
<asp:Label ID="lblStatusID" runat="server" Visible="false" />
 </form>
</body>
</html>
