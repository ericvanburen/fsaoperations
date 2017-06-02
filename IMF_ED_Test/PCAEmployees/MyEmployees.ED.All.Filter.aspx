<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckEDLogin()
            
            'If Not IsNothing(Request.QueryString("AgencyID")) Then
            '    Dim intAG As String = Request.QueryString("AgencyID").ToString()
            '    lblAgency.Text = intAG
            'Else
            '    If Not IsNothing(Request.Cookies("IMF")) Then
            '        lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
            '    End If
            'End If

            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
            End If
            
        End If
    End Sub
        
    Sub BindGridView()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyEmployees_ED"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
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
       
    Protected Sub ddlEmployeeStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If ddlEmployeeStatus.SelectedValue = "%" Then
            Response.Redirect("MyEmployees.ED.All.aspx")
        Else
            GridView1.DataSourceID = "dsMyEmployees2"
            dsMyEmployees2.SelectParameters("StatusID").DefaultValue = ddlEmployeeStatus.SelectedValue
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
  
                <!--This one populates the Agency dropdown-->
                      <asp:SqlDataSource ID="dsAgencies" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllAgencies_Employees" SelectCommandType="StoredProcedure" />

                 <!--This one populates the employee Status dropdown-->
                      <asp:SqlDataSource ID="dsEmployeeStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_PCAEmployeeStatusValues" SelectCommandType="StoredProcedure" />
                            
                <!--This one populates the Gridview-->
                <asp:SqlDataSource ID="dsMyEmployees" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyEmployees_ED" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">                             
                </asp:SqlDataSource>       
                
                <asp:SqlDataSource ID="dsMyEmployees2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyEmployees_ED2" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                    <SelectParameters>
                        <asp:FormParameter Name="StatusID" FormField="ddlEmployeeStatus" Type="Int32" />
                    </SelectParameters>                     
                </asp:SqlDataSource>                
                                                     
                  <div align="center">     
                      <h2>PCA Employees</h2>
                        <asp:Panel ID="pnlMyEmployees" runat="server">                                        
                           <div align="center" width="90%">
                           <table>
                           <tr>
                           <td colspan="2"><a href="MyEmployees.ED.All.aspx">Show All Employees</a></td>
                           </tr>
                            <tr>
                                 <td>Employee Status: <asp:Dropdownlist id="ddlEmployeeStatus" Runat="Server" 
                                        DataSourceID="dsEmployeeStatus"  
                                        DataTextField="Status" DataValueField="StatusID" 
                                        Width="210px"  
                                        CssClass="formLabel" AutoPostBack="true" AppendDataBoundItems="true" 
                                        onselectedindexchanged="ddlEmployeeStatus_SelectedIndexChanged">
                                        <asp:ListItem Text="" Value="" />                                                                         
                                </asp:Dropdownlist></td>
                                <td> <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" /></td>
                            </tr>
                           </table> 
                            </div>
                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsMyEmployees" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20" PagerSettings-Position="TopAndBottom"> 
                            
                            <EmptyDataTemplate>
                                    This agency has not submitted any employees
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
                                    DataField="Username" 
                                    HeaderText="Assigned To" 
                                    SortExpression="UserName" 
                                    ItemStyle-HorizontalAlign="Right" />

                                    <asp:BoundField 
                                    DataField="AG_Name" 
                                    HeaderText="Agency" 
                                    SortExpression="AG_Name" 
                                    ItemStyle-HorizontalAlign="Right" />
                                    
                                     <asp:BoundField 
                                    DataField="SSN" 
                                    HeaderText="SSN"
                                    SortExpression="SSN"
                                    ItemStyle-HorizontalAlign="Right" />
                                                                       
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
                                    
                                    <asp:BoundField 
                                    DataField="SixC" 
                                    HeaderText="6C?" 
                                    SortExpression="SixC" />

                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>                     
                   </asp:Panel>
                   </div>  
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="true" />
 </form>
</body>
</html>
