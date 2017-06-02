<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>
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
            
            If lblAgency.Text Is Nothing OrElse lblAgency.Text.Length = 0 Then
                Response.Redirect("/not.logged.in.aspx")
            End If
            
        End If
    End Sub
    
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim link1 As HyperLink = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
            If String.IsNullOrEmpty(link1.NavigateUrl) Then
                Dim li As HtmlGenericControl = CType(e.Row.FindControl("l1"), HtmlGenericControl)
                li.Visible = False
            End If
            
            Dim link2 As HyperLink = DirectCast(e.Row.FindControl("HyperLink2"), HyperLink)
            If String.IsNullOrEmpty(link2.NavigateUrl) Then
                Dim li As HtmlGenericControl = CType(e.Row.FindControl("l2"), HtmlGenericControl)
                li.Visible = False
            End If
        End If
    End Sub
    
        
    'Sub BindGridView_Completed()
    '    Dim strSQL As String
    '    Dim cmd As SqlCommand
    '    Dim con As SqlConnection
    '    Dim dr As SqlDataReader
        
    '    con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
    '    strSQL = "p_MyIMFs_PCA"
    '    cmd = New SqlCommand(strSQL)
    '    cmd.CommandType = CommandType.StoredProcedure
    '    cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Varchar).Value = lblAgency.Text
    '    cmd.Connection = con
        
    '    Try
    '        con.Open()
    '        dr = cmd.ExecuteReader()
    '        GridView1.DataSource = dr
    '        GridView1.DataBind()
    '    Finally
    '        con.Close()
    '    End Try
    'End Sub
    
    'Sub BindGridView_NoCompleted()
    '    Dim strSQL As String
    '    Dim cmd As SqlCommand
    '    Dim con As SqlConnection
    '    Dim dr As SqlDataReader
        
    '    con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
    '    strSQL = "p_MyIMFs_PCA_NoCompleted"
    '    cmd = New SqlCommand(strSQL)
    '    cmd.CommandType = CommandType.StoredProcedure
    '    cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Varchar).Value = lblAgency.Text
    '    cmd.Connection = con
        
    '    Try
    '        con.Open()
    '        dr = cmd.ExecuteReader()
    '        GridView1.DataSource = dr
    '        GridView1.DataBind()
    '    Finally
    '        con.Close()
    '    End Try
    'End Sub
    
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
        lblRecordCount.Text = "Showing " & recordCount & " IMFs"
    End Sub
    
    Protected Sub btnArchiveIMF_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            Dim checkbox As CheckBox = CType(row.FindControl("cbRows"), CheckBox)

            'Check if the checkbox is checked. 
            If checkbox.Checked Then

                'Retreive the IMF ID
                Dim ID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected IMF ID to the Update command.
                dsMyIMFs_NoCompleted.UpdateParameters("Id").DefaultValue = ID
                dsMyIMFs_NoCompleted.Update()
            End If
        Next row
        
        lblArchiveStatus.Text = "Your selected IMFs have been archived"
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Archive PCA IMFs</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
    <script type="text/javascript">
    $(document).ready(function() {            
            $('#chkAll').click(
             function() {                
                $("INPUT[type='checkbox']").attr('checked', $('#chkAll').is(':checked'));
            });     
     });
     </script>

</head>
<body>
    <form id="form1" runat="server">
  
                <!--Populates the Gridview-->
                <asp:SqlDataSource ID="dsMyIMFs_NoCompleted" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyIMFs_PCA_NoCompleted" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler" 
                    UpdateCommand="p_MyIMFs_PCA_Archive" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblAgency" Name="AgencyID" />                            
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="ID" />
                        </UpdateParameters>
                     </asp:SqlDataSource>  

                      <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllStatus" SelectCommandType="StoredProcedure" /> 
                            
                   <div align="center" id="searchForm">
                        <table border="0" width="95%">
                        <tr>
                            <td valign="top">
                         <!--First column here-->
                         <table width="100%" border="0">
                        <tr>
                            <td align="right" width="50%" class="formLabel">IMF ID: </td>
                            <td align="left" width="50%" valign="middle">
                            <asp:Textbox id="txtID" Runat="Server"  CssClass="formLabel" Columns="5" /></td>
                        </tr> 
                        <tr>
                                <td align="right" width="50%" class="formLabel">Debt ID:</td>
                                <td align="left" width="50%">
                                <asp:TextBox ID="txtDebtID" runat="server" MaxLength="16" CssClass="formLabel" /></td>
                        </tr>  
                        <tr>
                                <td align="right" width="50%" class="formLabel">Location Code:</td>
                                <td align="left" width="50%">
                                <asp:TextBox ID="txtLocationCode" runat="server" Columns="5" MaxLength="3" CssClass="formLabel" /></td>
                        </tr>                         
                         <tr>
                            <td align="right" width="50%" class="formLabel">Status: </td>
                            <td align="left" width="50%" valign="middle">
                            <asp:Listbox id="lbStatus" Runat="Server" 
                            SelectionMode="Multiple" 
                            Rows="3" Width="150px" 
                            CssClass="formLabel" />
                            </td>
                        </tr>                      
                        <tr>
                             <td align="right" width="50%" class="formLabel">IMF Type:</td>
                                <td align="left" width="50%">
                                <asp:Listbox id="ddlIMF_Type" Runat="Server"  
                                SelectionMode="Multiple" Rows="5" 
                                CssClass="formLabel" /> 
                                </td>
                            </tr> 
                             <tr>
                                <td align="right" width="50%" class="formLabel">Borrower First Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtBorrower_FName" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Borrower Last Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtBorrower_LName" runat="server" CssClass="formLabel" /></td>
                            </tr>                        
                         </table>
                            
                            </td>
                            <td valign="top">
                            <!--second column here-->
                            <table width="100%" border="0">
                           
                            <tr>
                                <td align="right" width="50%" class="formLabel">PCA Employee Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtPCA_Employee" runat="server" CssClass="formLabel" /></td>
                            </tr>
                           <tr>
                                <td align="right" width="50%" class="formLabel">Date Submitted</td>
                                <td align="left" width="50%" class="smallText"><asp:Textbox ID="txtDateSubmitted" runat="server" CssClass="formLabel" />  (greater than)</td>
                            </tr>                                                                         
                            <tr>
                                <td align="right" width="50%" class="formLabel">PCA Comments:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" CssClass="formLabel" Rows="5" Columns="40" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">ED  Response:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtED_Response" runat="server" TextMode="MultiLine" CssClass="formLabel" Rows="5" Columns="40" /></td>
                            </tr>                         
                            </table>                 
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2"><br /><asp:Button ID="btnSearchIMF" runat="server" Text="Search IMFs" OnClick="btnSearchIMF_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            <asp:Button ID="btnClearForm" runat="server" Text="Clear Form" OnClick="btnClearFields_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                           </td>
                            
                            </tr> 
                        </table>
                        </div>    
                     
                                     
                  <div align="center">     
                      <h2>Archive My IMFs (<%=lblAgency.Text%>)</h2>
                        <asp:Panel ID="pnlMyIMFs" runat="server">                                        
                            <div align="center" width="90%">
                            <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                            </div>
                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsMyIMFs_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="false" AllowSorting="true" OnRowDataBound="GridView1_RowDataBound"> 
                            
                            <EmptyDataTemplate>
                                    You have not submitted any IMFs
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                                <asp:TemplateField ItemStyle-CssClass="first">
                                    <HeaderTemplate>
                                        <input name="chkAll" id="chkAll" type="checkbox" style="padding-left: 9px"  />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbRows" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                              		                    
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="IMF ID" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id"                                      
                                    DataNavigateUrlFormatString="imf.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>                                 
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    SortExpression="DateSubmitted" />
                                    
                                    <asp:BoundField 
                                    DataField="IMF_Type" 
                                    HeaderText="Type" 
                                    SortExpression="IMF_Type" />
                                    
                                    <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID" />
                                                                       
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />
                                    
                                    <asp:BoundField 
                                    DataField="PCA_Employee" 
                                    HeaderText="PCA Name" />
                                    
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
                                    
                                    <asp:TemplateField HeaderText="Attachments">
                                        <ItemTemplate>  
                                           <ul>                                                                      
                                            <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("Attachment1")%>' runat="server" Target="_blank">Attachment1</asp:HyperLink></li>     
                                            <li id="l2" runat="server"><asp:HyperLink ID="HyperLink2" NavigateUrl='<%# Eval("Attachment2")%>' runat="server" Target="_blank">Attachment2</asp:HyperLink></li>     
                                           </ul>                                         
                                        </ItemTemplate>                                                                       
                                    </asp:TemplateField>
                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnArchiveIMF" CssClass="button" runat="server" OnClick="btnArchiveIMF_Click" Text="Archive Selected IMFs" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            <asp:Label ID="lblArchiveStatus" CssClass="warningMessage" runat="server" />
                            </div>                     
                   </asp:Panel>
                   </div>  
   
<asp:Label ID="lblAgency" runat="server" Visible="false" />
 </form>
</body>
</html>
