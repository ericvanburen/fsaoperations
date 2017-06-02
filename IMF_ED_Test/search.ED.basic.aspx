<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()

            If Not IsNothing(Request.Cookies("IMF")) Then
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblEDUserName.Text = (Request.Cookies("IMF")("EDUserName").ToString())
            End If
            
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
        lblStatus.Text = ""
        If (txtDebtID.Text = "" And txtID.Text = "" And txtDMCS2ID.Text = "" And ddlIMF_Type.SelectedValue = "") Then
            lblStatus.Text = "You must enter at least one search criteria perform a search"
        Else
            BindGridView()
        End If
        End Sub
               
    Sub BindGridView()
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SearchED"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        If txtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@id", SqlDbType.VarChar).Value = txtID.Text
        End If
        
        If txtDebtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = PreventSQLInjection(txtDebtID.Text)
        End If
        
        If txtDMCS2ID.Text <> "" Then
            cmd.Parameters.AddWithValue("@DMCS2ID", SqlDbType.VarChar).Value = PreventSQLInjection(txtDMCS2ID.Text)
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
            Else
                btnExportExcel.Visible = False
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
            
                If TypeOf c Is Dropdownlist Then
                    CType(c, Dropdownlist).SelectedValue = ""
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
    
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)   
       ' Confirms that an HtmlForm control is rendered for the   
       ' specified ASP.NET server control at run time.   
       ' No code required here.   
	End Sub


    Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        GridView1.AllowSorting = False
            GridView1.AllowPaging = False
            BindGridView()
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

    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Basic IMF Search</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="js/default.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">                    
    
                        <asp:Panel ID="pnlSearchForm" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Basic IMF Search</legend><br />

                        <a href="#" id="triggerDescription">+/- Hide/Show Search Form</a>

                        <div align="center" id="searchForm">
                        <table border="0" width="95%">
                        <tr>
                            <td align="right" width="50%" class="formLabel">IMF ID: </td>
                            <td align="left" width="50%" valign="middle"><asp:Textbox id="txtID" Runat="Server"  CssClass="formLabel" Columns="5" /></td>
                        </tr> 
                        <tr>
                                <td align="right" width="50%" class="formLabel">Debt ID:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtDebtID" runat="server" MaxLength="16" CssClass="formLabel" /></td>
                        </tr>    
                         <tr>
                                <td align="right" width="50%" class="formLabel">DMCS ID:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtDMCS2ID" runat="server" MaxLength="10" CssClass="formLabel" /></td>
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
                                <td colspan="2" align="center"><asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" /></td>
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

                       <!--This one populates the IMF Type dropdown-->
                    <asp:SqlDataSource ID="dsIMFTypes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                             SelectCommand="p_IMFTypes" SelectCommandType="StoredProcedure" />
                      
                       <div class="grid" align="center"> 
                       <asp:Label ID="lblRowCount" runat="server" />
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" AutoGenerateColumns="false" CellPadding="4" 
                            Width="95%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="false" 
                            OnRowDataBound="GridView1_RowDataBound" PageSize="15" OnSorting="Gridview1_Sorting">
                            <RowStyle CssClass="row" />
                            <Columns>
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="IMF ID" 
                                    DataNavigateUrlFields="Id" 
                                    ItemStyle-CssClass="first" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="imf.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>

                                    <asp:BoundField 
                                    DataField="AgencyID" 
                                    HeaderText="AG" 
                                    SortExpression="AgencyID" />
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    DataFormatString="{0:d}"
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
                                    DataField="DMCS2ID" 
                                    HeaderText="DMCS ID"
                                    SortExpression="DMCS2ID" />                             
                                    
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />
                                    
                                    <asp:BoundField 
                                    DataField="PCA_Employee" 
                                    HeaderText="PCA Name" />
                                    
                                     <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed"
                                    DataFormatString="{0:d}" 
                                    SortExpression="DateClosed" />                                                             
                                    
                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="Assigned To" 
                                    SortExpression="Username" />                                                         
                     
                                    <asp:TemplateField HeaderText="Attachments">
                                        <ItemTemplate>  
                                           <ul>                                                                      
                                            <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("Attachment1")%>' runat="server">Attachment1</asp:HyperLink></li>     
                                            <li id="l2" runat="server"><asp:HyperLink ID="HyperLink2" NavigateUrl='<%# Eval("Attachment2")%>' runat="server">Attachment2</asp:HyperLink></li>     
                                           </ul>                                         
                                        </ItemTemplate>                                                                       
                                    </asp:TemplateField>
                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" Visible="False" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>                             
    
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblEDUserName" runat="server" Visible="false" />
    </form>
</body>
</html>
