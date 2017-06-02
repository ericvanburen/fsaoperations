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
        strSQL = "p_PCAEmployee_FFEL_Requests2"
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
        Response.AddHeader("content-disposition", "attachment;filename=FFEL.Requests.xls")
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
        If ddlAgencies.SelectedValue = "%" Then
            GridView1.DataSourceID = "dsFFELRequests2"
            GridView1.DataBind()
        Else
            GridView1.DataSourceID = "dsFFELRequests"
            GridView1.DataBind()
        End If
    End Sub
    
    Protected Sub btnUpdateFFEL_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            Dim chkApproved As CheckBox = CType(row.FindControl("chkApproved"), CheckBox)
            
            'Retreive the FFEL ID
            Dim FFEL_ID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
            'Pass the value of the selected FFEL_ID to the Update command.
            dsUpdateFFEL.UpdateParameters("FFEL_ID").DefaultValue = FFEL_ID
            If chkApproved.Checked Then
                dsUpdateFFEL.UpdateParameters("Approved").DefaultValue = 1
            Else
                dsUpdateFFEL.UpdateParameters("Approved").DefaultValue = 0
                dsUpdateFFEL.UpdateParameters("UserID").DefaultValue = ""
            End If
            
            'Add Approved By value if the request is approved
            If chkApproved.Checked Then
                dsUpdateFFEL.UpdateParameters("UserID").DefaultValue = lblEDUserID.Text
            End If
            
            dsUpdateFFEL.Update()
        Next row
        
        lblFFELUpdate_Status.Text = "These FFEL Requests have been approved"
        GridView1.DataBind()
    End Sub

    Protected Sub chkApproved_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkApproved.Checked = True Then
            dsFFELRequests2.SelectCommand = "p_PCAEmployee_FFEL_Requests_Approved"
            GridView1.DataBind()
        Else
            dsFFELRequests2.SelectCommand = "p_PCAEmployee_FFEL_Requests2"
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
                            
               <asp:SqlDataSource ID="dsFFELRequests" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_PCAEmployee_FFEL_Requests" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                    <SelectParameters>
                        <asp:FormParameter Name="AG" FormField="ddlAgencies" Type="String" />
                    </SelectParameters>                     
                </asp:SqlDataSource>            
                
                <asp:SqlDataSource ID="dsFFELRequests2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_PCAEmployee_FFEL_Requests2" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">                              
                </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="dsUpdateFFEL" Runat="server" UpdateCommand="p_PCAEmployee_FFEL_Approved" UpdateCommandType="StoredProcedure"
                   ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" >
                    <UpdateParameters>
                        <asp:Parameter Name="FFEL_ID" />
                        <asp:Parameter Name="Approved" />
                        <asp:Parameter Name="UserID" ConvertEmptyStringToNull="true" />
                    </UpdateParameters>
                </asp:SqlDataSource>         
                   
                                                     
                  <div align="center">     
                      <h2>FFEL Login Requests</h2>
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
                                <asp:CheckBox ID="chkApproved" runat="server" CssClass="formLabel" 
                                        Text="Show Approved Requests Only?" AutoPostBack="true" Checked="false" 
                                        oncheckedchanged="chkApproved_CheckedChanged" />
                                </td>
                                <td><asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" /></td>
                            </tr>
                           </table> 
                            </div>
                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="FFEL_ID" DataSourceID="dsFFELRequests2" AutoGenerateColumns="false" CellPadding="4" 
                            Width="98%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20" PagerSettings-Position="TopAndBottom"> 
                            
                            <EmptyDataTemplate>
                                    This agency has not submitted any FFEL requests
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
                                    DataField="Date_Submitted" 
                                    HeaderText="Date Submitted" 
                                    SortExpression="Date_Submitted" 
                                    DataFormatString="{0:d}"
                                    ItemStyle-HorizontalAlign="Right" />
                                    
                                   <asp:BoundField 
                                    DataField="ActionTaken" 
                                    HeaderText="Action Taken"
                                    SortExpression="ActionTaken"
                                    ItemStyle-HorizontalAlign="Left" />                                   
                                   
                                    <asp:TemplateField HeaderText="Attachments">
                                        <ItemTemplate>  
                                           <ul>                                                                      
                                            <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("FFEL_Login_Attachment")%>' runat="server">FFEL Form</asp:HyperLink></li>     
                                           </ul>                                         
                                        </ItemTemplate>                                                                       
                                    </asp:TemplateField> 
                                 
                                 <asp:TemplateField HeaderText="Approved?" SortExpression="Approved">
                                    <ItemTemplate>
                                        <asp:Checkbox ID="chkApproved" runat="server" Checked='<%# Eval("Approved") %>' />			                                      
                                    </ItemTemplate>
                                 </asp:TemplateField>                             

                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnUpdateFFEL" OnClick="btnUpdateFFEL_Click" runat="server" Text="Update FFEL Requests" CssClass="button" />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            <br /><br />
                            <asp:Label ID="lblFFELUpdate_Status" runat="server" CssClass="warningMessage" />
                            </div>                     
                   </asp:Panel>
                   </div>  
 <asp:Label ID="lblID" runat="server" Visible="false" />   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
 </form>
</body>
</html>
