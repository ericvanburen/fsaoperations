<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" Debug="true" %>
<%@ Import Namespace="System.Data" %> 
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            If Not IsNothing(Request.Cookies("IMF")("AG")) Then
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
            End If
            If (lblAgency.Text Is Nothing AndAlso lblAgency.Text.Length = 0) Then
                Response.Redirect("../not.logged.in.aspx")
            End If
            
            'Bind the Status dropdown in the search form
            lbStatus.Items.Add("")
            lbStatus.AppendDataBoundItems = True
            lbStatus.DataSource = dsStatus()
            lbStatus.DataTextField = "Status"
            lbStatus.DataValueField = "ID_Status"
            lbStatus.DataBind()
            
            'Bind the IMFType dropdown in the search form
            ddlIMF_Type.Items.Add("")
            ddlIMF_Type.AppendDataBoundItems = True
            ddlIMF_Type.DataSource = dsIMFTypes()
            ddlIMF_Type.DataTextField = "IMF_Type"
            ddlIMF_Type.DataValueField = "IMF_ID"
            ddlIMF_Type.DataBind()
        End If
    End Sub
    
    'Removing some potentially malicious characters from the search input
    Private Function PreventSQLInjection(ByVal s As String) As String
        s = Replace(s, "'", "''").ToString()
        s = Replace(s, ";", "").ToString()
        s = Replace(s, "--", "").ToString()
        s = Replace(s, "xp_", "").ToString()
        Return s
    End Function
               
    Sub btnSearchIMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        BindGridView()
    End Sub
    
    Sub BindGridView()
        
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SearchPCA_Vangent"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.VarChar).Value = lblAgency.Text
        
        If txtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@id", SqlDbType.VarChar).Value = txtID.Text
        End If
        
        If txtDebtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = PreventSQLInjection(txtDebtID.Text)
        End If
                
        If ddlIMF_Type.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlIMF_Type.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & "#"
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            'Change delimiter to # sign since many IMFTypes contain commas which get stripped out
            strSearchValue = Replace(strSearchValue, "#", ",")
            cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        If lbStatus.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In lbStatus.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & "#"
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, "#", ",")
            cmd.Parameters.AddWithValue("@ID_Status", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        If txtBorrower_FName.Text <> "" Then
            cmd.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = PreventSQLInjection(txtBorrower_FName.Text)
        End If
        
        If txtBorrower_LName.Text <> "" Then
            cmd.Parameters.AddWithValue("@Borrower_LName", SqlDbType.VarChar).Value = PreventSQLInjection(txtBorrower_LName.Text)
        End If
        
        If txtPCA_Employee.Text <> "" Then
            cmd.Parameters.AddWithValue("@PCA_Employee", SqlDbType.VarChar).Value = PreventSQLInjection(txtPCA_Employee.Text)
        End If
        
        If txtDateSubmitted.Text <> "" Then
            cmd.Parameters.AddWithValue("@DateSubmitted", SqlDbType.VarChar).Value = PreventSQLInjection(txtDateSubmitted.Text)
        End If
        
        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = PreventSQLInjection(txtComments.Text)
        End If
                       
        Try
            con.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "SearchResults")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            GridView1.DataSource = ds.Tables("SearchResults").DefaultView
            GridView1.DataBind()

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
                btnArchiveIMF.Visible = True
            Else
                btnExportExcel.Visible = False
                btnArchiveIMF.Visible = False
            End If
        	
        Finally
            con.Close()
        End Try
        
    End Sub
    
    Protected Sub btnClearFields_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'First clear all form fields of any existing values
        EmptyTextBoxValues(Me)
    End Sub

    Private Sub EmptyTextBoxValues(ByVal parent As Control)
        For Each c As Control In parent.Controls
            If (c.Controls.Count > 0) Then
                EmptyTextBoxValues(c)
            Else
                If TypeOf c Is TextBox Then
                    CType(c, TextBox).Text = ""
                End If
            
                If TypeOf c Is DropDownList Then
                    CType(c, DropDownList).SelectedValue = ""
                End If
                
                If TypeOf c Is ListBox Then
                    CType(c, ListBox).SelectedValue = ""
                End If
                
                If TypeOf c Is CheckBox Then
                    CType(c, CheckBox).Checked = False
                End If
            End If
        Next
    End Sub

    
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        ' Confirms that an HtmlForm control is rendered for the   
        ' specified ASP.NET server control at run time.   
        ' No code required here.   
    End Sub


    Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=IMF.Search.Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Sub Gridview1_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
  
    End Sub
    
    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        BindGridView()
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
<head runat="server">
    <title>IMF Search</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../js/default.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#chkAll').click(
             function () {
                 $("INPUT[type='checkbox']").attr('checked', $('#chkAll').is(':checked'));
             });
        });
     </script>
</head>
<body>
    <form id="form1" runat="server">                     
                            
                     <asp:SqlDataSource ID="dsMyIMFs_NoCompleted" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    UpdateCommand="p_MyIMFs_PCA_Archive" UpdateCommandType="StoredProcedure">
                        <UpdateParameters>
                            <asp:Parameter Name="ID" />
                        </UpdateParameters>
                     </asp:SqlDataSource>
                    
                    <!--This one populates the IMF Type dropdown-->
                    <asp:SqlDataSource ID="dsIMFTypes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                             SelectCommand="p_IMFTypes_Vangent" SelectCommandType="StoredProcedure" />
    
                    <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllStatus" SelectCommandType="StoredProcedure" />


                        <asp:Panel ID="pnlSearchForm" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Advanced IMF Search- Search Your Agency's IMFs Assigned to DRG</legend><br />

                        <a href="#" id="triggerDescription">+/- Hide/Show Search Form</a>

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
                                <td align="right" width="50%" class="formLabel">Status:</td>
                            <td align="left" width="50%"><asp:Listbox id="lbStatus" Runat="Server" 
                            SelectionMode="Multiple" 
                            Rows="3" Width="150px" 
                            CssClass="formLabel" /></td>
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
               
                         </fieldset>
                       </asp:Panel>
                       <br />
                      
                       <div class="grid" align="center"> 
                       <asp:Label ID="lblRowCount" runat="server" />
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" AutoGenerateColumns="false" CellPadding="4" 
                            Width="100%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="false" 
                            PageSize="15" OnSorting="Gridview1_Sorting" PagerSettings-Position="TopAndBottom">
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
                                    DataNavigateUrlFormatString="Imf.Detail.aspx?Id={0}" >
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
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" Visible="False" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            <asp:Button ID="btnArchiveIMF" CssClass="button" runat="server" OnClick="btnArchiveIMF_Click" Text="Archive Selected IMFs" Visible="false" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /><br />
                            <asp:Label ID="lblArchiveStatus" CssClass="warningMessage" runat="server" />
                            </div>
                                              
    
    <asp:Label ID="lblAgency" runat="server" Visible="false" />
    </form>
</body>
</html>
