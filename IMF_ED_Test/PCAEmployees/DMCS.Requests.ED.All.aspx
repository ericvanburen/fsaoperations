<%@ Page Language="VB" Inherits="MyBaseClass" EnableEventValidation="false" src="../classes/MyBaseClass.vb" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckEDLogin()
      
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
        strSQL = "p_PCAEmployee_DMCS_Requests"
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
        Response.AddHeader("content-disposition", "attachment;filename=DMCS.Requests.xls")
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
        lblRecordCount.Text = "Showing " & recordCount & " records"
    End Sub
   
    Protected Sub ddlAgencies_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'If ddlAgencies.SelectedValue = "%" Then
        GridView1.DataSourceID = "dsDMCSRequests"
        GridView1.DataBind()
        'Else
        'GridView1.DataSourceID = "dsDMCSRequests"
        'GridView1.DataBind()
        'End If
    End Sub
    
    Protected Sub btnUpdateDMCS_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            Dim ddlDMCS_Access_Attachment_Accepted_By_ED As DropDownList = CType(row.FindControl("ddlDMCS_Access_Attachment_Accepted_By_ED"), DropDownList)
            
            'Retreive the Employee ID
            Dim ID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
            'Pass the value of the selected ID to the Update command.
            dsUpdateDMCS.UpdateParameters("ID").DefaultValue = ID
            dsUpdateDMCS.UpdateParameters("DMCS_Access_Attachment_Accepted_By_ED").DefaultValue = ddlDMCS_Access_Attachment_Accepted_By_ED.SelectedValue
            dsUpdateDMCS.Update()
        Next row
        
        lblDMCSUpdate_Status.Text = "These DMCS Requests have been approved"
        GridView1.DataBind()
    End Sub

    Protected Sub chkShowAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkShowAll.Checked = True Then
            GridView1.DataSourceID = "dsDMCSRequests_Pending"
            'dsDMCSRequests_Pending.SelectCommand = "p_PCAEmployee_DMCS_Requests_Pending"
            GridView1.DataBind()
        Else
            GridView1.DataSourceID = "dsDMCSRequests"
            GridView1.DataBind()
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>DMCS Access Form Requests</title>
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
                            
               <!--These two datasources are just for pending requests-->
               <asp:SqlDataSource ID="dsDMCSRequests" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_PCAEmployee_DMCS_Requests" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                    <SelectParameters>
                        <asp:FormParameter Name="AG" FormField="ddlAgencies" Type="String" />
                    </SelectParameters>                     
                </asp:SqlDataSource>  
                
                <asp:SqlDataSource ID="dsDMCSRequests_All_Pending" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_PCAEmployee_DMCS_Requests_All_Pending" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">                                   
                </asp:SqlDataSource>  
                <!-- End Pending requests-->     
                
                <asp:SqlDataSource ID="dsDMCSRequests_Pending" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_PCAEmployee_DMCS_Requests_Pending" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">                              
                    <SelectParameters>
                        <asp:FormParameter Name="AG" FormField="ddlAgencies" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="dsUpdateDMCS" Runat="server" UpdateCommand="p_PCAEmployee_DMCS_Requests_Update" UpdateCommandType="StoredProcedure"
                   ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" >
                    <UpdateParameters>
                        <asp:Parameter Name="ID" />
                        <asp:Parameter Name="DMCS_Access_Attachment_Accepted_By_ED" ConvertEmptyStringToNull="true" />
                    </UpdateParameters>
                </asp:SqlDataSource>         
                   
                                                     
                  <div align="center">     
                      <h2>DMCS Access Form Requests</h2>
                        <asp:Panel ID="pnlMyEmployees" runat="server">                                        
                           <div align="center" width="90%">
                           <table>
                            <tr>
                                <td align="left">
                                <asp:Dropdownlist id="ddlAgencies" Runat="Server" 
                                        DataSourceID="dsAgencies" AutoPostBack="true" 
                                        DataTextField="AG_Name" DataValueField="AG" 
                                        Width="210px" 
                                        CssClass="formLabel" AppendDataBoundItems="true" 
                                        onselectedindexchanged="ddlAgencies_SelectedIndexChanged">
                                        <asp:ListItem Text="All" Value="%"></asp:ListItem>
                                </asp:Dropdownlist>
                                <asp:CheckBox ID="chkShowAll" runat="server" CssClass="formLabel" 
                                        Text="Show All Requests" AutoPostBack="true" Checked="false" 
                                        oncheckedchanged="chkShowAll_CheckedChanged" />
                                </td>
                                <td><asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" /></td>
                            </tr>
                           </table> 
                            </div>
                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="ID" DataSourceID="dsDMCSRequests_All_Pending" AutoGenerateColumns="false" CellPadding="4" 
                            Width="98%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20" PagerSettings-Position="TopAndBottom"> 
                            
                            <EmptyDataTemplate>
                                    This agency has not submitted any DMCS requests
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
                                    DataField="AG" 
                                    HeaderText="Agency" 
                                    SortExpression="AG" 
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
                                    DataField="DMCS_Access_Date" 
                                    HeaderText="Date Submitted" 
                                    SortExpression="DMCS_Access_Date" />
                           
                                    <asp:TemplateField HeaderText="Access Form">
                                        <ItemTemplate>  
                                           <ul>                                                                      
                                            <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("DMCS_Access_Attachment")%>' runat="server">DMCS Access Form</asp:HyperLink></li>     
                                           </ul>                                         
                                        </ItemTemplate>                                                                       
                                    </asp:TemplateField> 
                                    
                                    <asp:TemplateField HeaderText="Approved?" SortExpression="DMCS_Access_Attachment_Accepted_By_ED">
                                    <ItemTemplate>
                                        <asp:Dropdownlist ID="ddlDMCS_Access_Attachment_Accepted_By_ED" runat="server" SelectedValue='<%# Eval("DMCS_Access_Attachment_Accepted_By_ED") %>'>
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="Yes" Value="Yes" />
                                            <asp:ListItem Text="No" Value="No" />
                                        </asp:Dropdownlist>			                                      
                                    </ItemTemplate>
                                 </asp:TemplateField> 

                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnUpdateDMCS" OnClick="btnUpdateDMCS_Click" runat="server" Text="Update DMCS Requests" CssClass="button" />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            <br /><br />
                            <asp:Label ID="lblDMCSUpdate_Status" runat="server" CssClass="warningMessage" />
                            </div>                     
                   </asp:Panel>
                   </div>  
 <asp:Label ID="lblID" runat="server" Visible="false" />   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
 </form>
</body>
</html>
