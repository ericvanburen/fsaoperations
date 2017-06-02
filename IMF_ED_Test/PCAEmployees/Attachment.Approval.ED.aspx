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
          
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
            End If
            
            Dim strAttachmentType As String
            strAttachmentType = Request.QueryString("AttachmentType")
            
            BindGridView(strAttachmentType)
            
            If strAttachmentType = "IRT" Then
                lblAttachmentType.Text = "Unapproved IRT Attachments"
            ElseIf strAttachmentType = "PAT" Then
                lblAttachmentType.Text = "Unapproved PAT Attachments"
            ElseIf strAttachmentType = "SAT" Then
                lblAttachmentType.Text = "Unapproved SAT Attachments"
            ElseIf strAttachmentType = "ROB" Then
                lblAttachmentType.Text = "Unapproved ROB Attachments"
            End If
            
        End If
    End Sub
        
    Sub BindGridView(ByVal AttachmentType As String)
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_UnApprovedAttachments"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = lblEDUserID.Text
        cmd.Parameters.Add("@AttachmentType", SqlDbType.VarChar).Value = AttachmentType.ToString()
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
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " employees"
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>UnApproved Attachments</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
                                                                     
                  <div align="center">     
                      <h2>PCA Employees</h2>
                      <span>(<asp:Label ID="lblAttachmentType" runat="server" />)</span><br />
                        <asp:Panel ID="pnlMyEmployees" runat="server">                                        
                           <div align="center" width="90%">
                           <table>
                           <tr>                                 
                                <td> <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" /></td>
                            </tr>
                           </table> 
                            </div>
                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal"> 
                            
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
                            </div>                     
                   </asp:Panel>
                   </div>  
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="true" />
 </form>
</body>
</html>
