<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and VA page - Call Check Login Status
            CheckVALogin()
            
            If Not IsNothing(Request.Cookies("IMF")("GA_ID")) Then
                lblGA_ID.Text = (Request.Cookies("IMF")("GA_ID").ToString())
            End If
            If (lblGA_ID.Text Is Nothing AndAlso lblGA_ID.Text.Length = 0) Then
                Response.Redirect("not.logged.in.aspx")
            End If
            
            'Bind the Status dropdown in the search form
            lbStatus.Items.Add("")
            lbStatus.AppendDataBoundItems = True
            lbStatus.DataSource = dsStatus()
            lbStatus.DataTextField = "Status"
            lbStatus.DataValueField = "ID_Status"
            lbStatus.DataBind()
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
               
    Sub btnSearchVAApp_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'PreventSQLInjection(txtID.Text)
        
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SearchVA"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        'This passes the GA_ID value to the sproc to ensure that they only can see their own VA Apps
        cmd.Parameters.AddWithValue("@GA_ID", SqlDbType.VarChar).Value = lblGA_ID.Text
        
        If txtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@id", SqlDbType.VarChar).Value = txtID.Text
        End If
        
        If txtSSN.Text <> "" Then
            cmd.Parameters.AddWithValue("@SSN", SqlDbType.VarChar).Value = PreventSQLInjection(txtSSN.Text)
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
               
        If txtGA_Employee.Text <> "" Then
            cmd.Parameters.AddWithValue("@GA_Employee", SqlDbType.VarChar).Value = PreventSQLInjection(txtGA_Employee.Text)
        End If
        
        If txtDateSubmitted.Text <> "" Then
            cmd.Parameters.AddWithValue("@DateSubmitted", SqlDbType.VarChar).Value = PreventSQLInjection(txtDateSubmitted.Text)
        End If
        
        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = PreventSQLInjection(txtComments.Text)
        End If
        
        If txtED_Response.Text <> "" Then
            cmd.Parameters.AddWithValue("@ED_Response", SqlDbType.VarChar).Value = PreventSQLInjection(txtED_Response.Text)
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
        End If
    End Sub
    
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)   
       ' Confirms that an HtmlForm control is rendered for the   
       ' specified ASP.NET server control at run time.   
       ' No code required here.   
	End Sub


    Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
				GridView1.AllowSorting = False 
				Response.Clear() 
        Response.AddHeader("content-disposition", "attachment;filename=VA.Search.Results.xls")
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



    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advanced VA App Search</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="js/default.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
                    <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllStatus_VA" SelectCommandType="StoredProcedure" />                   
    
                        <asp:Panel ID="pnlSearchForm" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Advanced VA Application Search- Search Your Agency's VA Discharge Applications</legend><br />

                        <a href="#" id="triggerDescription">+/- Hide/Show Search Form</a>

                        <div align="center" id="searchForm">
                        <table border="0" width="95%">
                        <tr>
                            <td valign="top">
                         <!--First column here-->
                         <table width="100%" border="0">
                        <tr>
                            <td align="right" width="50%" class="formLabel">VA ID: </td>
                            <td align="left" width="50%" valign="middle">
                            <asp:Textbox id="txtID" Runat="Server"  CssClass="formLabel" Columns="5" /></td>
                        </tr> 
                        <tr>
                                <td align="right" width="50%" class="formLabel">SSN:</td>
                                <td align="left" width="50%">
                                <asp:TextBox ID="txtSSN" runat="server" MaxLength="16" CssClass="formLabel" /></td>
                        </tr>                           
                         <tr>
                            <td align="right" width="50%" class="formLabel">Status: </td>
                            <td align="left" width="50%" valign="middle">
                            <asp:Listbox id="lbStatus" Runat="Server" 
                            SelectionMode="Multiple"  
                            Rows="3" Width="425px" 
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
                                <td align="right" width="50%" class="formLabel">Agency Employee Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtGA_Employee" runat="server" CssClass="formLabel" /></td>
                            </tr>
                           <tr>
                                <td align="right" width="50%" class="formLabel">Date Submitted</td>
                                <td align="left" width="50%" class="smallText"><asp:Textbox ID="txtDateSubmitted" runat="server" CssClass="formLabel" />  (greater than)</td>
                            </tr>                                                                         
                            <tr>
                                <td align="right" width="50%" class="formLabel">VA Comments:</td>
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
                            <td align="center" colspan="2"><br /><asp:Button ID="btnSearchVAApp" runat="server" Text="Search VA Apps" OnClick="btnSearchVAApp_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
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
                            Width="95%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="true" 
                            PageSize="20" OnSorting="Gridview1_Sorting">
                            <RowStyle CssClass="row" />
                            <Columns>
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="VA ID" 
                                    DataNavigateUrlFields="Id" 
                                    ItemStyle-CssClass="first" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="va.app.detail.aspx?Id={0}" >
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
                                    DataField="Borrower_FName" 
                                    HeaderText="Borrower First Name" 
                                    SortExpression="Borrower_FName" />

                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />
                                    
                                    <asp:BoundField 
                                    DataField="GA_Employee" 
                                    HeaderText=" GA Employee Name" />
                                    
                                     <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />                           
                                    
                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="Assigned To" 
                                    SortExpression="Username" />
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="DateClosed" />    
                                    
                                                                 
                              </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" Visible="False" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>                             
    
    <asp:Label ID="lblGA_ID" runat="server" Visible="false" />
    </form>
</body>
</html>
