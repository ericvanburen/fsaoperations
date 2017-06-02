<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        
        If Not Page.IsPostBack Then
            'Vangent Only page - Call Check Vangent Login Status
            CheckVangentLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblVangent.Text = (Request.Cookies("IMF")("Vangent").ToString())
                lblVangentUserID.Text = (Request.Cookies("IMF")("VangentUserID").ToString())
            End If
                      
            Dim intQueueID As Integer = Request.QueryString("QueueID")
            lblQueueID.Text = intQueueID
            
            Dim strLock As String = Request.QueryString("Lock")
            lblLock.Text = strLock
            'Response.Write(strLock)
            
            'Bind the user info for this user
            BindUserID()
            
        End If
    End Sub
    
    'Sub btnUnlockRecord_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '   LockRecord("Unlock")
    '  Response.Redirect("IMF.Detail.Queue.aspx?Lock=Unlock&QueueID=" & lblQueueID.Text)
    'End Sub
    
    Sub btnUnlockRecord_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_IMF_Details_Vangent_Queue_Next"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("@QueueID", lblQueueID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
        Finally
            'dr.Close()
            strConnection.Close()
        End Try
        
        LockRecord("Unlock")
        Response.Redirect("IMF.Detail.Queue.aspx?Lock=Unlock&QueueID=" & lblQueueID.Text)
    End Sub
    
        
    Sub BindUserID()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail_Vangent"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblVangentUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                If IsDBNull(dr("IsAdmin")) = False Then
                    lblIsAdmin.Text = dr("IsAdmin")
                End If
            End While
            
            Page.DataBind()
            BindGridView()
        
        Finally
            'dr.Close()
            strConnection.Close()
        End Try
    End Sub
    
    Protected Sub BindGridView()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_IMF_Details_Vangent_Queue"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QueueID", lblQueueID.Text)
        cmd.Connection = strConnection
        Try
            strConnection.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "SearchResults")

            rptIMFDetails.DataSource = ds.Tables("SearchResults").DefaultView
            rptIMFDetails.DataBind()
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    
    Sub CheckFields()
        Dim dataItem As RepeaterItem
        For Each dataItem In rptIMFDetails.Items
            Dim lblID2 As Label = CType(dataItem.FindControl("lblID2"), Label)
            lblID.Text = lblID2.Text
            Dim ddlID_Status As DropDownList = CType(dataItem.FindControl("ddlID_Status"), DropDownList)
            Dim ddlAllDRGQueues As DropDownList = CType(dataItem.FindControl("ddlAllDRGQueues"), DropDownList)
            Dim ddlIMFType As DropDownList = CType(dataItem.FindControl("ddlIMFType"), DropDownList)
            Dim txtComments As TextBox = CType(dataItem.FindControl("txtComments"), TextBox)
            Dim txtVangentComments As TextBox = CType(dataItem.FindControl("txtVangentComments"), TextBox)
            Dim chkArchived As CheckBox = CType(dataItem.FindControl("chkArchived"), CheckBox)
            Dim btnUpdateIMF As Button = CType(dataItem.FindControl("btnUpdateIMF"), Button)
            Dim btnRetractIMF As Button = CType(dataItem.FindControl("btnRetractIMF"), Button)
            Dim btnRetractIMFRemove As Button = CType(dataItem.FindControl("btnRetractIMFRemove"), Button)
                       
            'We need to record the value of the current status when the page first loads
            'this will be compared to the new Status (if any) to record in the Status Audit table (IMF_Audit)
            lblID_Status.Text = ddlID_Status.SelectedValue
                        
            'Only AGs or Admins can retract an IMF
            If lblIsAdmin.Text = "True" Then
                'btnRetractIMF.Enabled = True
                btnRetractIMF.Enabled = False
            Else
                btnRetractIMF.Enabled = False
                'ddlID_Status.SelectedValue = "6"
                'ddlID_Status.Items.FindByValue("6").Enabled = False
            End If
            
            'If an IMF is in a retracted status, then we need to provide the user with a button to unretract it
            If ddlID_Status.SelectedValue = 6 Then
                btnRetractIMFRemove.Visible = True
                btnUpdateIMF.Visible = False
                btnRetractIMF.Visible = False
            Else
                btnRetractIMFRemove.Visible = False
            End If
            
            'Only Admins should be able to update the Assigned To, IMF Type dropdownboxes, PCA Comments textbox
            'everyone else will be able to update the Current Status and Comments boxes
            If lblIsAdmin.Text = "False" Then
                ddlAllDRGQueues.Enabled = False
                txtComments.ReadOnly = True
                ddlIMFType.Enabled = False
                chkArchived.Enabled = False
            End If
            
            'Only DRG Admins can update their Archived checkbox
            If lblIsAdmin.Text = "True" Then
                chkArchived.Enabled = True
            End If
                     
            'They also want DRG Analysts to be able to update/edit their own IMFs
            If lblIsAdmin.Text <> "True" Then
                ddlAllDRGQueues.Enabled = False
                ddlIMFType.Enabled = False
            End If
        Next
                
        'Now lock the record so no one else can edit it       
        If lblLock.Text = "Lock" Then
            LockRecord("Lock")
        Else
            LockRecord("Unlock")
        End If
               
    End Sub
    
    Sub LockRecord(ByVal LockStatus As String)
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        If LockStatus = "Lock" Then
            strSql = "p_Lock_Vangent_Queue"
        Else
            strSql = "p_Unlock_Vangent_Queue"
        End If
        
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    Sub Edit_Record(ByVal Src As Object, ByVal e As RepeaterCommandEventArgs)
        
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        Dim lblID2 As Label = e.Item.FindControl("lblID2")
        lblID.Text = lblID2.Text
        Dim ddlIMFType As DropDownList = e.Item.FindControl("ddlIMFType")
        Dim ddlAgencyID As DropDownList = e.Item.FindControl("ddlAgencyID")
        Dim ddlAllDRGQueues As DropDownList = e.Item.FindControl("ddlAllDRGQueues")
        Dim lblDateAssigned As Label = e.Item.FindControl("lblDateAssigned")
        Dim lblDateClosed As Label = e.Item.FindControl("lblDateClosed")
        Dim ddlID_Status As DropDownList = e.Item.FindControl("ddlID_Status")
        Dim lblDebtID As Label = e.Item.FindControl("lblDebtID")
        Dim txtPCA_Employee As TextBox = e.Item.FindControl("txtPCA_Employee")
        Dim txtComments As TextBox = e.Item.FindControl("txtComments")
        Dim txtVangentComments As TextBox = e.Item.FindControl("txtVangentComments")
        Dim chkArchived As CheckBox = e.Item.FindControl("chkArchived")
        Dim chkRejected As CheckBox = e.Item.FindControl("chkRejected")
        Dim txtSchoolContact As TextBox = e.Item.FindControl("txtSchoolContact")
        Dim txtSchoolFax As TextBox = e.Item.FindControl("txtSchoolFax")
        Dim txtSchoolAddress As TextBox = e.Item.FindControl("txtSchoolAddress")
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UpdateIMF_Vangent"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID2.Text)
        cmd.Parameters.AddWithValue("@IMF_ID", ddlIMFType.SelectedValue)
        cmd.Parameters.AddWithValue("@AgencyID", ddlAgencyID.SelectedValue)
        cmd.Parameters.AddWithValue("@QueueID", ddlAllDRGQueues.SelectedValue)
        
        'If the Queue assignment has changed then we need to update the Date Assigned
        If ddlAllDRGQueues.SelectedValue <> lblQueueID.Text Then
            cmd.Parameters.Add("@DateAssigned", SqlDbType.SmallDateTime).Value = DateTime.Now
        ElseIf lblDateAssigned.Text <> "" Then
            cmd.Parameters.Add("@DateAssigned", SqlDbType.SmallDateTime).Value = lblDateAssigned.Text
        Else
            cmd.Parameters.Add("@DateAssigned", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If
                         
        If lblDateClosed.Text = "" Then
            If ddlID_Status.SelectedValue = 3 Then 'Completed Status
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            If ddlID_Status.SelectedValue = 5 Then 'Returned to PCA Status
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            If ddlID_Status.SelectedValue = 6 Then 'Retracted
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            
        ElseIf lblDateClosed.Text <> "" Then
            If ddlID_Status.SelectedValue <> 3 And ddlID_Status.SelectedValue <> 5 And ddlID_Status.SelectedValue <> 6 Then 'Remove Completed Status or Returned to PCA Status or Retracted Status
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = lblDateClosed.Text
            End If
        Else
            cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If
        
        cmd.Parameters.AddWithValue("@ID_Status", ddlID_Status.SelectedValue)
        If ddlID_Status.SelectedValue <> lblID_Status.Text Then
            'We know the Status value has changed since the page first loaded so we need to update the IMF_Audit table with a new record                      
            dsIMFStatusHistory.InsertParameters("ID").DefaultValue = lblID2.Text
            dsIMFStatusHistory.InsertParameters("ID_Status").DefaultValue = ddlID_Status.SelectedValue
            dsIMFStatusHistory.Insert()
        End If
        
        If txtPCA_Employee.Text <> "" Then
            cmd.Parameters.AddWithValue("@PCA_Employee", txtPCA_Employee.Text)
        Else
            cmd.Parameters.AddWithValue("@PCA_Employee", SqlDbType.VarChar).Value = DBNull.Value
        End If
               
        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        Else
            cmd.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        If txtVangentComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@VangentComments", txtVangentComments.Text)
        Else
            cmd.Parameters.AddWithValue("@VangentComments", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        If txtSchoolContact.Text <> "" Then
            cmd.Parameters.AddWithValue("@SchoolContact", txtSchoolContact.Text)
        Else
            cmd.Parameters.AddWithValue("@SchoolContact", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        If txtSchoolFax.Text <> "" Then
            cmd.Parameters.AddWithValue("@SchoolFax", txtSchoolContact.Text)
        Else
            cmd.Parameters.AddWithValue("@SchoolFax", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        If txtSchoolAddress.Text <> "" Then
            cmd.Parameters.AddWithValue("@SchoolAddress", txtSchoolAddress.Text)
        Else
            cmd.Parameters.AddWithValue("@SchoolAddress", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        cmd.Parameters.AddWithValue("@Archived", SqlDbType.Bit).Value = chkArchived.Checked
        cmd.Parameters.AddWithValue("@Rejected", SqlDbType.Bit).Value = chkRejected.Checked
        
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
            
            'Now unlock the record so it can be edited
            LockRecord("Unlock")
        End Try
        
        rptIMFDetails.DataBind()
        grdIMFStatusHistory.DataBind()
        grdIMFStatusHistory.Visible = True
        lblUpdateStatus.Text = "Your IMF has been updated"
        
    End Sub
           
    
    Protected Sub rptIMFDetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        CheckFields()
    End Sub
    
    Protected Sub btnRetractMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UpdateIMF_Retract"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("@ID_Status", SqlDbType.Int).Value = 6
        cmd.Parameters.AddWithValue("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
       
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        rptIMFDetails.DataBind()
        
        lblUpdateStatus.Text = "Your IMF has been retracted"
    End Sub
    
    Protected Sub btnRetractIMFRemove_Click(ByVal sender As Object, ByVal e As EventArgs)
        'This places a retracted IMF back into a Received status
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UpdateIMF_Retract"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("@ID_Status", SqlDbType.Int).Value = 1
        cmd.Parameters.AddWithValue("@DateClosed", SqlDbType.SmallDateTime).Value = DBNull.Value

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        rptIMFDetails.DataBind()
        
        lblUpdateStatus.Text = "Your retracted IMF has been resubmitted"
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
      <!--This one populates the IMF details form-->
                     <asp:SqlDataSource ID="dsEDUsers" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_IMF_Details_Vangent_Queue" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                    <asp:ControlParameter ControlID="lblQueueID" Name="QueueID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                      <!--This one populates the IMF Type dropdown-->
                    <asp:SqlDataSource ID="dsIMFTypes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_IMFTypes_Vangent" SelectCommandType="StoredProcedure" />
                            
                      <!--This one populates the Agency dropdown-->
                      <asp:SqlDataSource ID="dsAgencies" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllAgencies" SelectCommandType="StoredProcedure" />
                            
                       <!--This one populates the DRG Queues dropdown-->
                      <asp:SqlDataSource ID="dsAllDRGQueues" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllQueues_Vangent" SelectCommandType="StoredProcedure" />
                            
                         <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsAllStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllStatus" SelectCommandType="StoredProcedure" />     
    <div align="right">                  
    <asp:Button ID="btnUnlockRecord" runat="server" Text="Next in Queue" OnClick="btnUnlockRecord_click" />
    </div>

    <fieldset>
    <legend class="fieldsetLegend">IMF Details</legend><br />    
    <div align="left">
    
    <asp:Repeater id="rptIMFDetails" Runat="Server" OnItemCommand="Edit_Record" OnItemDataBound="rptIMFDetails_ItemDataBound">
<HeaderTemplate>
    <table border="0" cellpadding="3" cellspacing="2" style="border-collapse:collapse;" >
    </HeaderTemplate>
    <ItemTemplate>
    <tr>
        <td colspan="4" align="right"></td>
    </tr>
    <tr>
            <td class ="formLabelForm"><span class="smallText">(<a href="../imf.processing.html#<%# Eval("IMF_ID") %>" target="tips" onclick="window.open('../imf.processing.html#<%# Eval("IMF_ID") %>','tips','height=255, width=450,toolbar=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes'); return false;">processing tips</a>) </span> IMF Type:</td>
            </td>
            <td colspan="3"><asp:DropDownList id="ddlIMFType" Runat="Server" CssClass="formLabel"
                          DataSourceID="dsIMFTypes"
                          DataTextField="IMF_Type"
                          DataValueField="IMF_ID" AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("IMF_ID") %>'>
                          <asp:ListItem Text="" Value="" />  
                </asp:DropDownList></td> 
        </tr>
    <tr>
            <td class ="formLabelForm">IMF ID:</td>
            <td><asp:Label ID="lblID2" runat="server" Text='<%# Eval("ID") %>' /></td> 
            <td class ="formLabelForm">Date Submitted:</td>
            <td><asp:Label ID="lblDateSubmitted" runat="server" Text='<%# Eval("DateSubmitted") %>' /></td>             
        </tr>
        <tr>
            <td class ="formLabelForm">Borrower First Name:</td>
            <td><asp:Label ID="lblBorrower_FName" runat="server" Text='<%# Eval("Borrower_FName") %>' /></td>
            <td class ="formLabelForm">Borrower Last Name:</td>
            <td><asp:Label ID="lblBorrower_LName" runat="server" Text='<%# Eval("Borrower_LName") %>' /></td>             
        </tr> 
        
        <tr>
            <td class ="formLabelForm">Date Closed:</td>
            <td><asp:Label ID="lblDateClosed" runat="server" Text='<%# Eval("DateClosed") %>' /></td>
            <td class ="formLabelForm">Submitted In Error?</td>
            <td><asp:CheckBox ID="chkRejected" runat="server" Checked='<%# Eval("Rejected") %>' /> </td>             
        </tr> 
                
         <tr>
            <td class ="formLabelForm">PCA Employee:</td>
            <td><asp:Textbox ID="txtPCA_Employee" runat="server" Text='<%# Eval("PCA_Employee") %>' /></td> 
            <td class ="formLabelForm">Archived?</td>
            <td><asp:CheckBox ID="chkArchived" runat="server" Checked='<%# Eval("Archived") %>' /></td>            
        </tr>            
        <tr>
            <td class ="formLabelForm">Current Status:</td>
            <td><asp:DropDownList id="ddlID_Status" Runat="Server" CssClass="formLabel"
                          DataSourceID="dsAllStatus"
                          DataTextField="Status"
                          DataValueField="ID_Status" AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("ID_Status") %>'> 
                          <asp:ListItem Text="" Value="" />  
                </asp:DropDownList>
             <br />
             <asp:RequiredFieldValidator ID="rfdID_Status" runat="server" ControlToValidate="ddlID_Status" ErrorMessage="Current Status is required" CssClass="warningMessage" Display="Dynamic" /> 
             
             </td> 
                <td class ="formLabelForm">Queue Assignment:</td>
            <td>  <asp:DropDownList id="ddlAllDRGQueues" Runat="Server" CssClass="formLabel"
                         DataSourceID="dsAllDRGQueues"
                          DataTextField="QueueName"
                          DataValueField="QueueID"
                          AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("QueueID") %>'>
                          <asp:ListItem Text="" Value="" />                             
                  </asp:DropDownList>
              <br />
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlAllDRGQueues" ErrorMessage="Queue is required" CssClass="warningMessage" Display="Dynamic" />
                  </td>             
        </tr>
       
        <tr>
            <td class ="formLabelForm">Debt ID:</td>
            <td><asp:Label ID="lblDebtID" runat="server" Text='<%# Eval("DebtID") %>' /></td>
            <td class ="formLabelForm">Date Assigned To Queue:</td>
            <td><asp:Label ID="lblDateAssigned" runat="server" Text='<%# Eval("DateAssigned") %>' /> </td>                  
        </tr>
        <tr>            
             <td class ="formLabelForm">Agency:</td>
            <td colspan="3"><asp:DropDownList ID="ddlAgencyID" runat="server" CssClass="formLabel"
                         DataSourceID="dsAgencies"
                          DataTextField="AG_Name"
                          DataValueField="AG" AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("AG") %>' Enabled="false">
                          <asp:ListItem Text="" Value="" />                              
                </asp:DropDownList>                
            </td>     
                          
        </tr>
        <tr>
            <td class ="formLabelForm">School Contact Name (Title IV):</td>
            <td><asp:Textbox ID="txtSchoolContact" runat="server" Text='<%# Eval("SchoolContact") %>' /></td>
            <td class ="formLabelForm">School Fax # (Title IV):</td>
            <td><asp:Textbox ID="txtSchoolFax" runat="server" Text='<%# Eval("SchoolFax") %>' /></td>
        </tr>
        <tr>
            <td class ="formLabelForm" valign="top">School Address (Title IV):</td>
            <td colspan="3"><asp:Textbox ID="txtSchoolAddress" runat="server" Text='<%# Eval("SchoolAddress") %>' TextMode="MultiLine" Columns="55" Rows="10" /></td>
        </tr>
                      
          <tr>
            <td class ="formLabelForm" valign="top">PCA Comments:</td>
            <td colspan="3"><asp:Textbox ID="txtComments" runat="server" Text='<%# Eval("Comments") %>' TextMode="MultiLine" Columns="55" Rows="10" /></td>                               
        </tr> 
        <tr>
             <td class ="formLabelForm" valign="top">DRG Comments:</td>
            <td colspan="3"><asp:Textbox ID="txtVangentComments" runat="server" Text='<%# Eval("VangentComments") %>' TextMode="MultiLine" Columns="55" Rows="10" /> </td> 
        </tr>                   
             
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnUpdateIMF" runat="server" Text="Update IMF" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                <asp:Button ID="btnRetractIMF" runat="server" Text="Retract IMF" CssClass="button" OnClientClick="return confirm('Are you sure that you want retract this IMF?  This operation cannot be undone.')" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" OnClick="btnRetractMF_Click" />
                <asp:Button ID="btnRetractIMFRemove" runat="server" Text="Resubmit Retracted IMF" CssClass="button" OnClientClick="return confirm('Are you sure that you want resubmit this retracted IMF?  This operation cannot be undone.')" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" OnClick="btnRetractIMFRemove_Click" Visible="false" />
            </td>
        </tr> 
        </ItemTemplate>
              
        <FooterTemplate>        
        </table>
        </FooterTemplate>
        </asp:Repeater>
        <div align="center" style="width: 650px">
                <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" /><br />
                <asp:Label ID="lblError" runat="server" />      
         </div>

         <br /><br />
        <!--This one populates the IMF Status History Gridview-->
        <asp:SqlDataSource ID="dsIMFStatusHistory" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>"
            SelectCommand="p_IMFAudit_Select_Vangent" SelectCommandType="StoredProcedure" InsertCommand="p_IMFAudit_Insert_Vangent"
            InsertCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblID" Name="ID" DefaultValue="0" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="ID" />
                <asp:Parameter Name="ID_Status" />
            </InsertParameters>
            
        </asp:SqlDataSource>

        <br />
        <div class="grid">                          
                            <asp:GridView ID="grdIMFStatusHistory" runat="server" DataKeyNames="AuditID" DataSourceID="dsIMFStatusHistory" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" HeaderStyle-HorizontalAlign="Left" 
                            AllowPaging="false" AllowSorting="true" PageSize="20" PagerSettings-Position="TopAndBottom" Caption="<b>IMF Status History</b>">                           
                            
                            <EmptyDataTemplate>
                                    There is no status history for this IMF
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>                           
                                                                                                     
                                    <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />
                                    
                                    <asp:BoundField 
                                    DataField="DateUpdated" 
                                    HeaderText="Date"
                                    SortExpression="DateUpdated" />
                                    
                                                                        
                          </Columns>                
                          </asp:GridView>
       </div>
         </fieldset>
    <asp:Label ID="lblID" runat="server" Visible="false" />
    <asp:Label ID="lblIsAdmin" runat="server" Visible="False" />
    <asp:Label ID="lblAgency" runat="server" Visible="False" />
    <asp:Label ID="lblVangent_AG_Security" runat="server" Visible="false" />
    <asp:Label ID="lblAssignedTo" runat="server" Visible="false" />
    <asp:Label ID="lblID_Status" runat="server" Visible="false" />
    <asp:Label ID="lblVangent" runat="server" Visible="False" />
    <asp:Label ID="lblVangentUserID" runat="server" Visible="False" />
    <asp:Label ID="lblQueueID" runat="server" Visible="false" />
    <asp:Label ID="lblLock" runat="server" Visible="false" />
    </form>
</body>
</html>
