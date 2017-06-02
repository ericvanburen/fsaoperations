<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'Vangent Only page - Call Check Vangent Login Status
            CheckVangentLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                               
                'Bind the AG dropdown in the search form
                ddlAgencies.Items.Add("")
                ddlAgencies.AppendDataBoundItems = True
                ddlAgencies.DataSource = dsAgencies()
                ddlAgencies.DataTextField = "AG"
                ddlAgencies.DataValueField = "AG"
                ddlAgencies.DataBind()
                               
            End If
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
        
    Sub btnSearchPNote_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        BindGridView()
    End Sub
               
    Sub BindGridView()
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SearchPNotesVangent"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        If txtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@id", SqlDbType.VarChar).Value = txtID.Text
        End If
        
        If txtDate_Entered.Text <> "" Then
            cmd.Parameters.AddWithValue("@Date_Entered", SqlDbType.VarChar).Value = PreventSQLInjection(txtDate_Entered.Text)
        End If
        
        If txtDate_Closed.Text <> "" Then
            cmd.Parameters.AddWithValue("@Date_Closed", SqlDbType.VarChar).Value = PreventSQLInjection(txtDate_Closed.Text)
        End If
        
        If txtDebtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = PreventSQLInjection(txtDebtID.Text)
        End If
        
        If txtBorrower_FName.Text <> "" Then
            cmd.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = PreventSQLInjection(txtBorrower_FName.Text)
        End If
        
        If txtBorrower_LName.Text <> "" Then
            cmd.Parameters.AddWithValue("@Borrower_LName", SqlDbType.VarChar).Value = PreventSQLInjection(txtBorrower_LName.Text)
        End If
                
        If ddlAgencies.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlAgencies.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Text & "#"
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, "#", ",")
            cmd.Parameters.AddWithValue("@AG", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        If chkRejected.Checked Then
            cmd.Parameters.AddWithValue("@Rejected", SqlDbType.Bit).Value = True
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
                GridView1.Visible = True
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
        
        'Hide the gridview search results if present
        GridView1.Visible = False
        
        'Reset label status
        lblRowCount.Text = ""
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
        Response.AddHeader("content-disposition", "attachment;filename=PNote.Search.Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Sub Gridview1_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        'GridView1.SortExpression
  
    End Sub
       
    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        BindGridView()
    End Sub
            
       
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Missing PNote Search</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="../js/default.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
                                        
                    <!--This one populates the Agency dropdown-->
                      <asp:SqlDataSource ID="dsAgencies" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllAgencies" SelectCommandType="StoredProcedure" />                
    
                        <asp:Panel ID="pnlSearchForm" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Advanced Missing PNote Search</legend><br />

                        <a href="#" id="triggerDescription">+/- Hide/Show Search Form</a>

                        <div align="center" id="searchForm">
                        <table border="0" width="95%">
                        <tr>
                            <td valign="top">
                         <!--First column here-->
                         <table width="100%" border="0">
                             <tr>
                                <td align="right" width="50%" class="formLabel">PNote ID: </td>
                                <td align="left" width="50%" valign="middle">
                                <asp:Textbox id="txtID" Runat="Server"  CssClass="formLabel" Columns="5" /></td>
                            </tr> 
                            <tr>
                                    <td align="right" width="50%" class="formLabel">Debt ID:</td>
                                    <td align="left" width="50%">
                                    <asp:TextBox ID="txtDebtID" runat="server" MaxLength="16" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Agency: </td>
                                <td align="left" width="50%" valign="middle">
                                <asp:Listbox id="ddlAgencies" Runat="Server" 
                                SelectionMode="Multiple" 
                                Rows="3" Width="75px" 
                                CssClass="formLabel" />
                                </td>
                            </tr> 
                               
                         </table>
                            
                            </td>
                            <td valign="top">
                            <!--second column here-->
                            <table width="100%" border="0">                           
                            
                           <tr>
                                <td align="right" width="50%" class="formLabel">Date Submitted</td>
                                <td align="left" width="50%" class="smallText">: 
                                <asp:Textbox ID="txtDate_Entered" runat="server" CssClass="formLabel" />  (greater than)</td>
                            </tr>
                                                
                            <tr>
                                <td align="right" width="50%" class="formLabel">Date Closed</td>
                                <td align="left" width="50%" class="smallText">:
                                <asp:Textbox ID="txtDate_Closed" runat="server" CssClass="formLabel" /> (greater than)</td>
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
                            <tr>
                                    <td align="right" width="50%" class="formLabel">Rejected By Vangent:</td>
                                    <td align="left" width="50%"><asp:CheckBox ID="chkRejected" CssClass="formLabel" runat="server" /></td>
                            </tr>                                                           
                                                                       
                            </table>                 
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2"><br /><asp:Button ID="btnSearchNote" runat="server" Text="Search PNotes" OnClick="btnSearchPNote_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
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
                            Width="95%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="false" 
                            PageSize="15" OnSorting="Gridview1_Sorting" PagerSettings-Position="TopAndBottom">
                            <RowStyle CssClass="row" />
                            <Columns>
                                 <asp:BoundField 
                                    DataField="ID" 
                                    HeaderText="ID" 
                                    SortExpression="ID" 
                                    ReadOnly="true" />

                                    <asp:BoundField 
                                    DataField="AG" 
                                    HeaderText="AG" 
                                    SortExpression="AG"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="Date_Entered" 
                                    HeaderText="Submitted" 
                                    SortExpression="Date_Entered" 
                                    DataFormatString="{0:d}"
                                    ReadOnly="true" /> 
                                    
                                    <asp:BoundField 
                                    DataField="Date_Closed" 
                                    HeaderText="Date Closed" 
                                    SortExpression="Date_Closed" 
                                    DataFormatString="{0:d}"
                                    ReadOnly="true" />                                   
                                                                      
                                    <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID"
                                    ReadOnly="true" />
                                                                    
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="Borrower_FName" 
                                    HeaderText="Borrower First Name" 
                                    SortExpression="Borrower_FName"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="Rejected" 
                                    HeaderText="Rejected?" 
                                    SortExpression="Rejected" />
                                              
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
