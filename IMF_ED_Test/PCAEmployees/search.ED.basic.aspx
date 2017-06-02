<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" %>
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
                ddlAllEDUsers.SelectedValue = lblEDUserID.Text
            
                'Bind the Status dropdown in the search form
                lbStatus.Items.Add("")
                lbStatus.AppendDataBoundItems = True
                lbStatus.DataSource = dsStatus()
                lbStatus.DataTextField = "Status"
                lbStatus.DataValueField = "StatusID"
                lbStatus.DataBind()
                
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
        
        Sub btnSearchIMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
            BindGridView()
        End Sub
               
    Sub BindGridView()
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SearchED_PCAEmployee"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        If txtID.Text <> "" Then
            cmd.Parameters.AddWithValue("@id", SqlDbType.Int).Value = txtID.Text
        End If
        
        If txtSSN.Text <> "" Then
            cmd.Parameters.AddWithValue("@SSN", SqlDbType.VarChar).Value = PreventSQLInjection(txtSSN.Text)
        End If
        
        If txtDate_Employee_Added.Text <> "" Then
            cmd.Parameters.AddWithValue("@Date_Employee_Added", SqlDbType.VarChar).Value = PreventSQLInjection(txtDate_Employee_Added.Text)
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
            cmd.Parameters.AddWithValue("@StatusID", SqlDbType.VarChar).Value = strSearchValue
        End If
        
        If ddlPAT_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@PAT_Attachment_Accepted_By_ED", SqlDbType.VarChar).Value = PreventSQLInjection(ddlPAT_Attachment_Accepted_By_ED.SelectedValue)
        End If
        
        If txtFirst_Name.Text <> "" Then
            cmd.Parameters.AddWithValue("@First_Name", SqlDbType.VarChar).Value = PreventSQLInjection(txtFirst_Name.Text)
        End If
        
        If txtLast_Name.Text <> "" Then
            cmd.Parameters.AddWithValue("@Last_Name", SqlDbType.VarChar).Value = PreventSQLInjection(txtLast_Name.Text)
        End If
        
        If ddlTitle.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Title", SqlDbType.VarChar).Value = PreventSQLInjection(ddlTitle.SelectedValue)
        End If
        
        If ddlEmployeeFunction.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@EmployeeFunction", SqlDbType.VarChar).Value = PreventSQLInjection(ddlEmployeeFunction.SelectedValue)
        End If
        
        If txtEAUserID.Text <> "" Then
            cmd.Parameters.AddWithValue("@EAUserID", SqlDbType.VarChar).Value = PreventSQLInjection(txtEAUserID.Text)
        End If
        
        If chkSixC.Checked Then
            cmd.Parameters.AddWithValue("@SixC", SqlDbType.Bit).Value = PreventSQLInjection(chkSixC.Checked)
        End If
        
        If chkLVCCoordinator.Checked Then
            cmd.Parameters.AddWithValue("@LVCCoordinator", SqlDbType.Bit).Value = PreventSQLInjection(chkLVCCoordinator.Checked)
        End If
        
        If txtPAT_Date_Original.Text <> "" Then
            cmd.Parameters.AddWithValue("@PAT_Date_Original", SqlDbType.SmallDateTime).Value = PreventSQLInjection(txtPAT_Date_Original.Text)
        End If
        
        If txtPAT_Date_Last.Text <> "" Then
            cmd.Parameters.AddWithValue("@PAT_Date_Last", SqlDbType.SmallDateTime).Value = PreventSQLInjection(txtPAT_Date_Last.Text)
        End If
        
        If txtSAT_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@SAT_Date", SqlDbType.SmallDateTime).Value = PreventSQLInjection(txtSAT_Date.Text)
        End If
        
        If txtIRT_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@IRT_Date", SqlDbType.SmallDateTime).Value = PreventSQLInjection(txtIRT_Date.Text)
        End If
        
        If chkRemoved_From_Contract.Checked Then
            cmd.Parameters.AddWithValue("@Removed_From_Contract", SqlDbType.Bit).Value = PreventSQLInjection(chkRemoved_From_Contract.Checked)
        End If

        If txtRemoved_From_Contract_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@Removed_From_Contract_Date", SqlDbType.SmallDateTime).Value = PreventSQLInjection(txtRemoved_From_Contract_Date.Text)
        End If
        
        If txtContract_Start_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@Contract_Start_Date", SqlDbType.SmallDateTime).Value = PreventSQLInjection(txtContract_Start_Date.Text)
        End If
        
        If ddlAllEDUsers.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = PreventSQLInjection(ddlAllEDUsers.SelectedValue)
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
        Response.AddHeader("content-disposition", "attachment;filename=PCA.Employee.Search.Results.xls")
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
    <title>Advanced PCA Employee Search</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="../js/default.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
                    <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllStatus_PCAEmployees" SelectCommandType="StoredProcedure" />

                   <!--This one populates the ED Users dropdown-->
                      <asp:SqlDataSource ID="dsAllEDUsers" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllUsersActive" SelectCommandType="StoredProcedure" />
                    
                    <!--This one populates the Agency dropdown-->
                      <asp:SqlDataSource ID="dsAgencies" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllAgencies" SelectCommandType="StoredProcedure" />
                   
                        <asp:Panel ID="pnlSearchForm" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Advanced PCA Employee Search</legend><br />

                        <a href="#" id="triggerDescription">+/- Hide/Show Search Form</a>

                        <div align="center" id="searchForm">
                        <table border="0" width="95%">
                        <tr>
                            <td valign="top">
                         <!--First column here-->
                         <table width="100%" border="0">
                        <tr>
                            <td align="right" width="50%" class="formLabel">Employee ID: </td>
                            <td align="left" width="50%" valign="middle"><asp:Textbox id="txtID" Runat="Server"  CssClass="formLabel" Columns="5" /></td>
                        </tr> 
                        <tr>
                                <td align="right" width="50%" class="formLabel">SSN:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtSSN" runat="server" MaxLength="16" CssClass="formLabel" /></td>
                        </tr>    
                        <tr>
                                <td align="right" width="50%" class="formLabel">Date Employee Submitted:</td>
                                <td align="left" width="50%"><asp:Textbox ID="txtDate_Employee_Added" runat="server" CssClass="formLabel" /></td>
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
                         <tr>
                                <td align="right" width="50%" class="formLabel">6c Employee?</td>
                                <td align="left" width="50%" class="smallText"><asp:Checkbox ID="chkSixC" runat="server" CssClass="formLabel" /> </td>
                            </tr> 
                        <tr>
                                <td align="right" width="50%" class="formLabel">LVC Coordinator?</td>
                                <td align="left" width="50%" class="smallText"><asp:Checkbox ID="chkLVCCoordinator" runat="server" CssClass="formLabel" /> </td>
                            </tr>
                                                           
                             <tr>
                                 <td align="right" class="formLabel" width="50%">
                                     Privacy Act Attachment Accepted By ED?</td>
                                 <td align="left" class="smallText" width="50%">
                                     <asp:DropDownList ID="ddlPAT_Attachment_Accepted_By_ED" Runat="Server" 
                                         CssClass="formLabel" Width="75px">
                                         <asp:ListItem Text="" Value="" />
                                         <asp:ListItem Text="Yes" Value="Yes" />
                                         <asp:ListItem Text="No" Value="No" />
                                     </asp:DropDownList>
                                 </td>
                             </tr>
                             <tr>
                                 <td align="right" class="formLabel" width="50%">
                                     Date Original Privacy Act Training (PAT) Completed:</td>
                                 <td align="left" class="smallText" width="50%">
                                     <asp:TextBox ID="txtPAT_Date_Original" runat="server"></asp:TextBox>
                                     &nbsp;(greater than)</td>
                             </tr>
                             <tr>
                                 <td align="right" class="formLabel" width="50%">
                                     Date Last Privacy Act Training (PAT) Completed:</td>
                                 <td align="left" class="smallText" width="50%">
                                     <asp:TextBox ID="txtPAT_Date_Last" runat="server"></asp:TextBox>
                                     &nbsp;(greater than)</td>
                             </tr>
                             <tr>
                                 <td align="right" class="formLabel" width="50%">
                                     Date Security Awareness Training (SAT) Completed:</td>
                                 <td align="left" class="smallText" width="50%">
                                     <asp:TextBox ID="txtSAT_Date" runat="server"></asp:TextBox>
                                     &nbsp;(greater than)</td>
                             </tr>
                                                           
                             <tr>
                                 <td align="right" class="formLabel" width="50%">
                                     Date Incidence Response Training (IRT) Completed:</td>
                                 <td align="left" class="smallText" width="50%">
                                     <asp:TextBox ID="txtIRT_Date" runat="server"></asp:TextBox>
                                     &nbsp;(greater than)</td>
                             </tr>
                                                           
                         </table>
                            
                            </td>
                            <td valign="top">
                            <!--second column here-->
                            <table width="100%" border="0">
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee First Name:</td>
                                <td align="left" width="50%"><asp:Textbox ID="txtFirst_Name" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee Last Name:</td>
                                <td align="left" width="50%"><asp:Textbox ID="txtLast_Name" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee Function:</td>
                                <td align="left" width="50%">
                                <asp:Dropdownlist ID="ddlEmployeeFunction" runat="server" CssClass="formLabel">
                                    <asp:ListItem Text="" Value="" />
                                    <asp:ListItem Text="Clerk" Value="Clerk" />
                                    <asp:ListItem Text="PCA IT" Value="PCA IT" />
                                    <asp:ListItem Text="PCA Manager" Value="PCA Manager" />
                                    <asp:ListItem Text="PCA Rep" Value="PCA Rep" />
                                </asp:Dropdownlist></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee Title:</td>
                                <td align="left" width="50%">
                                <asp:Dropdownlist ID="ddlTitle" runat="server" CssClass="formLabel">
                                    <asp:ListItem Text="" Value="" /> 
                                    <asp:ListItem Text="AWG Coordinator" Value="AWG Coordinator" />
                                    <asp:ListItem Text="Contract Administrator" Value="Contract Administrator" />
                                    <asp:ListItem Text="Deputy Contract Administrator" Value="Deputy Contract Administrator" />
                                    <asp:ListItem Text="President or CEO" Value="President or CEO" />
                                    <asp:ListItem Text="Vice President" Value="Vice President" />
                                    <asp:ListItem Text="Other" Value="Other" />
                                </asp:Dropdownlist></td>
                            </tr>
                           <tr>
                                <td align="right" width="50%" class="formLabel">Employee User ID Assigned:</td>
                                <td align="left" width="50%" class="smallText"><asp:Textbox ID="txtEAUserID" runat="server" CssClass="formLabel" /></td>
                            </tr>                            
                            <tr>
                            <td align="right" width="50%" class="formLabel">Status: </td>
                            <td align="left" width="50%" valign="middle">
                            <asp:Listbox id="lbStatus" Runat="Server" 
                            SelectionMode="Multiple" 
                            Rows="3" Width="150px" 
                            CssClass="formLabel">
                            </asp:Listbox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="50%" class="formLabel">Contract Start Date:</td>
                            <td align="left" width="50%" valign="middle">
                                <asp:TextBox ID="txtContract_Start_Date" runat="server"></asp:TextBox>
                            </td>
                        </tr>             
                                          
                                <tr>
                                    <td align="right" class="formLabel" width="50%">
                                        Removed From Contract?</td>
                                    <td align="left" valign="middle" width="50%">
                                        <asp:CheckBox ID="chkRemoved_From_Contract" runat="server" />
                                    </td>
                                </tr>
                                          
                                <tr>
                                    <td align="right" class="formLabel" width="50%">
                                        Removed From Contract Start Date:</td>
                                    <td align="left" valign="middle" width="50%">
                                        <asp:TextBox ID="txtRemoved_From_Contract_Date" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                          
                                <tr>
                                    <td align="right" class="formLabel" width="50%">
                                        Assigned To:</td>
                                    <td align="left" valign="middle" width="50%">
                                       <asp:DropDownList id="ddlAllEDUsers" Runat="Server" CssClass="formLabel"
                                         DataSourceID="dsAllEDUsers" 
                                          Enabled="false"
                                          DataTextField="UserName"
                                          DataValueField="UserID"
                                          AppendDataBoundItems="true">
                                          <asp:ListItem Text="" Value="" />                             
                                    </asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td align="right" class="formLabel" width="50%">
                                        &nbsp;</td>
                                    <td align="left" valign="middle" width="50%">
                                        &nbsp;</td>
                                </tr>
                                          
                            </table>                 
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2"><br /><asp:Button ID="btnSearchIMF" runat="server" Text="Search PCA Employees" OnClick="btnSearchIMF_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
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
                            PageSize="20" OnSorting="Gridview1_Sorting" PagerSettings-Position="TopAndBottom">
                            <RowStyle CssClass="row" />
                            <Columns>
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="Employee ID" 
                                    DataNavigateUrlFields="Id" 
                                    ItemStyle-CssClass="first" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="employee.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>

                                    
                                    <asp:BoundField 
                                    DataField="SSN" 
                                    HeaderText="SSN" 
                                    SortExpression="SSN" />
                                    
                                    <asp:BoundField 
                                    DataField="First_Name" 
                                    HeaderText="First Name" 
                                    SortExpression="First_Name" />
                                    
                                    <asp:BoundField 
                                    DataField="Last_Name" 
                                    HeaderText="Last_Name" 
                                    SortExpression="Last_Name" />
                                    
                                    <asp:BoundField 
                                    DataField="EmployeeFunction" 
                                    HeaderText="Function" 
                                    SortExpression="EmployeeFunction" />
                                    
                                    <asp:BoundField 
                                    DataField="Title" 
                                    HeaderText="Title" 
                                    SortExpression="Title" />  
                                    
                                    <asp:BoundField 
                                    DataField="AG" 
                                    HeaderText="PCA" 
                                    SortExpression="AG" />                          
                                    
                                     <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />                           
                                    
                                    <asp:BoundField 
                                    DataField="SixC" 
                                    HeaderText="6C?" 
                                    SortExpression="SixC" /> 
                                    
                                     <asp:BoundField 
                                    DataField="LVCCoordinator" 
                                    HeaderText="LVC Coordinator?" 
                                    SortExpression="LVCCoordinator" />
                                    
                                     <asp:BoundField 
                                    DataField="PAT_Date_Original" 
                                    HeaderText="Date Original Privacy Act Training (PAT) Completed" 
                                    SortExpression="PAT_Date_Original" 
                                    DataFormatString="{0:d}" /> 
                                    
                                    <asp:BoundField 
                                    DataField="PAT_Date_Last" 
                                    HeaderText="Date Last Privacy Act Training (PAT) Completed" 
                                    SortExpression="PAT_Date_Last" 
                                    DataFormatString="{0:d}" />
                                    
                                    <asp:BoundField 
                                    DataField="SAT_Date" 
                                    HeaderText="Date Security Awareness Training (SAT) Completed" 
                                    SortExpression="SAT_Date" 
                                    DataFormatString="{0:d}" /> 
                                    
                                     <asp:BoundField 
                                    DataField="IRT_Date" 
                                    HeaderText="Date Incidence Response Training (IRT) Completed" 
                                    SortExpression="IRT_Date" 
                                    DataFormatString="{0:d}" />    
                                    
                                     <asp:BoundField 
                                    DataField="Removed_From_Contract" 
                                    HeaderText="Removed From Contract?" 
                                    SortExpression="Removed_From_Contract" /> 
                                                   

                                     <asp:BoundField 
                                    DataField="Removed_From_Contract_Date" 
                                    HeaderText="Removed From Contract Start Date" 
                                    SortExpression="Removed_From_Contract_Date" 
                                    DataFormatString="{0:d}" />

                                     <asp:BoundField 
                                    DataField="Contract_Start_Date" 
                                    HeaderText="Contract Start Date" 
                                    SortExpression="Contract_Start_Date" 
                                    DataFormatString="{0:d}" />
                                                                          
                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="Assigned To" 
                                    SortExpression="Username" />            

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
