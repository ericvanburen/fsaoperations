<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                'ED employee is looking at the IMF
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblED_AG_Security.Text = "ED"
            End If
                
            If (lblEDUserID Is Nothing AndAlso lblEDUserID.Text.Length = 0) Then
                Response.Redirect("not.logged.in.aspx")
            End If
           
        End If

    End Sub
    
    Protected Sub ddlGAs_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        lblGA_ID.Text = ddlGAs.SelectedValue
        
        GridView1.Visible = True
        
        'Bind the agency info
        BindAgency()
        
        lblUpdateStatus.Text = ""
        lblUpdateStatus_New.Text = ""
        lblAddAgencyContact_Status.Text = ""
    End Sub
    
  
    Public Sub BindAgency()

        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_GA_Lookup"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_ID", ddlGAs.SelectedValue)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            
            While dr.Read
                txtGA_Name.Text = dr("GA_Name")
                txtUserName.Text = dr("UserName")
                txtPassword.Text = dr("Password")
                'txtPassword.Text = "* hidden for security *"
                lblAgencyType.Text = dr("AgencyType")
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub
      
    
    Sub btnUpdateAgency_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This updates the GA information
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim strAgencyType As String = lblAgencyType.Text

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_GA_Update"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_ID", ddlGAs.SelectedValue)
        cmd.Parameters.AddWithValue("@GA_Name", txtGA_Name.Text)
        cmd.Parameters.AddWithValue("@UserName", txtUsername.Text)
        cmd.Parameters.AddWithValue("@Password", txtPassword.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            lblUpdateStatus.Text = "This agency was successfully updated"
        Finally
            strConnection.Close()
        End Try
        
        'We need to run this section in addition to the above only if AgencyType = 'PCA'.
        'The PCA logins are in both tables GA and Agencies.  If the user is updating a PCA login, then the 
        'Agencies table also needs to be updated
        If strAgencyType = "PCA" Then
            UpdatePCAAgency()
        End If
        
    End Sub
    
    Sub UpdatePCAAgency()
        'This updates the AG information
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_AG_Update_ByName"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@AG", txtUsername.Text)
        cmd.Parameters.AddWithValue("@AG_Name", txtGA_Name.Text)
        cmd.Parameters.AddWithValue("@Password", txtPassword.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    Protected Sub btnAddAgency_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This adds a new GA
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_GA_AddNew"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_Name", txtGA_Name_New.Text)
        cmd.Parameters.AddWithValue("@UserName", txtUsername_New.Text)
        cmd.Parameters.AddWithValue("@Password", txtPassword_New.Text)
        cmd.Parameters.AddWithValue("@AgencyType", ddlAgencyType.SelectedValue)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            lblUpdateStatus_New.Text = "This guaranty agency was successfully added"
           
            'ddlGAs.DataBind()
            'ddlGAs_NewContact.DataBind()
        Finally
            strConnection.Close()
        End Try
    End Sub

    Protected Sub btnAddAgencyContact_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This adds a new GA contact
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_GA_AddNew_Contact"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_ID", ddlGAs_NewContact.SelectedValue)
        cmd.Parameters.AddWithValue("@Contact_Name", txtContact_Name_New.Text)
        cmd.Parameters.AddWithValue("@Contact_Email", txtContact_Email_New.Text)
        cmd.Parameters.AddWithValue("@Contact_Telephone", txtContact_Telephone_New.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            lblAddAgencyContact_Status.Text = "This guaranty agency contact was successfully added"
        Finally
            strConnection.Close()
        End Try
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
<!--This one populates the Agency dropdown-->
                      <asp:SqlDataSource ID="dsGAs" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllGAs" SelectCommandType="StoredProcedure" />
                            
 <!--This one populates the GA Contacts Gridview-->
                      <asp:SqlDataSource ID="dsGAContacts" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_GAContacts" SelectCommandType="StoredProcedure"
                             UpdateCommand="p_GAContactsUpdate" UpdateCommandType="StoredProcedure"
                             DeleteCommand="p_GAContactsDelete" DeleteCommandType="StoredProcedure">
                            <SelectParameters>
                                    <asp:ControlParameter ControlID="lblGA_ID" Name="GA_ID" Type="Int32" DefaultValue="1" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="Contact_Name" Type="String" />
                                <asp:Parameter Name="Contact_Email" Type="String" />
                                <asp:Parameter Name="Contact_Telephone" Type="String" />
                            </UpdateParameters>
                            <DeleteParameters>
                                    <asp:Parameter Name="ID" Type="Int32" />
                            </DeleteParameters>   
                        </asp:SqlDataSource>                         
   
                     
    <fieldset>
    <legend class="fieldsetLegend">VA App User Maintenance</legend><br />
    <div align="left">
    
    <h3>Edit Existing User</h3>
    <table border="0">
    <tr>
            <td class ="formLabelForm">Agency:</td>
            <td><asp:DropDownList id="ddlGAs" Runat="Server"
                            DataSourceID="dsGAs"
                            DataTextField="GA_Name" 
                            DataValueField="GA_ID"
                            AppendDataBoundItems="true"  
                            CssClass="formLabel" Width="300" 
                            onselectedindexchanged="ddlGAs_SelectedIndexChanged" 
                            AutoPostBack="true">                            
                             <asp:ListItem Value=""></asp:ListItem>
                        </asp:DropDownList>                             
           </td>            
        </tr>          
        <tr>
            <td class ="formLabelForm" >Agency Name: </td>
            <td><asp:Textbox ID="txtGA_Name" runat="server"  Width="300"  /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                    ControlToValidate="txtGA_Name" ValidationGroup="Edit_GA" 
                    ErrorMessage="* You must enter an agency name *" CssClass="warningMessage" 
                    Display="Dynamic" /></td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >User Name (login): </td>
            <td><asp:Textbox ID="txtUsername" runat="server" ReadOnly="true" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                    ControlToValidate="txtUsername" ValidationGroup="Edit_GA" 
                    ErrorMessage="* You must enter an agency user name (login) *" 
                    CssClass="warningMessage" Display="Dynamic" /></td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >Password: </td>
            <td><asp:Textbox ID="txtPassword" runat="server" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                    ControlToValidate="txtPassword" ValidationGroup="Edit_GA" 
                    ErrorMessage="* You must enter an agency password *" CssClass="warningMessage" 
                    Display="Dynamic" />
             <asp:RegularExpressionValidator ID="rftxtPassword" runat="server" ControlToValidate="txtPassword" Display="Dynamic" 
            ErrorMessage="* Password must be at least 6 characters long and include at least one special character, one number, and one capital letter" 
            ValidationExpression="^.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).*$" CssClass="warningMessage" /></td>              
        </tr>   
        <tr>        
            <td><asp:Label ID="lblAgencyType" runat="server" Visible="false" /></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatus" runat="server" Visible="true" CssClass="warningMessage" /></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><br /><asp:Button ID="btnUpdateAgency" 
                    runat="server" Text="Update User" OnClick="btnUpdateAgency_Click" 
                    ValidationGroup="Edit_GA" CssClass="button" 
                    onmouseover="this.className='button buttonhover'" 
                    onmouseout="this.className='button'" /></td>
        </tr>        
        </table>
        
        <br />       
       <div class="grid" align="center"> 
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="dsGAContacts" DataKeyNames="ID" Visible="false"
        CellPadding="4" Width="95%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal">
        <RowStyle CssClass="row" />
        <Columns>		       
            <asp:BoundField DataField="ID" HeaderText="Contact Name" Visible="false" />
            <asp:BoundField DataField="Contact_Name" HeaderText="Contact Name" ItemStyle-CssClass="first" />
		    <asp:BoundField DataField="Contact_Email" HeaderText="Contact Email" />
		    <asp:BoundField DataField="Contact_Telephone" HeaderText="Contact Telephone" />         
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
        </asp:GridView>
        </div>
        <br />
        <hr />
    
        <h3>Add New User</h3>

        <table border="0">       
        <tr>
            <td class ="formLabelForm" >Agency Name: </td>
            <td><asp:Textbox ID="txtGA_Name_New" runat="server"  Width="300" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                    ControlToValidate="txtGA_Name_New" ValidationGroup="New_GA" 
                    ErrorMessage="* You must enter a new agency name *" CssClass="warningMessage" 
                    Display="Dynamic" /></td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >User Name (login): </td>
            <td><asp:Textbox ID="txtUsername_New" runat="server" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                    ControlToValidate="txtUsername_New" ValidationGroup="New_GA" 
                    ErrorMessage="* You must enter a new agency login *" CssClass="warningMessage" 
                    Display="Dynamic" /></td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >Password: </td>
            <td><asp:Textbox ID="txtPassword_New" runat="server" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                    ControlToValidate="txtPassword_New" ValidationGroup="New_GA" 
                    ErrorMessage="* You must enter a new agency password *" 
                    CssClass="warningMessage" Display="Dynamic" />
             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPassword_New" Display="Dynamic" ValidationGroup="New_GA" 
            ErrorMessage="* Password must be at least 6 characters long and include at least one special character, one number, and one capital letter" 
            ValidationExpression="^.*(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).*$" CssClass="warningMessage" /></td>              
        </tr>   
        <tr>
        <td class ="formLabelForm" >Agency Type: </td>
        <td><asp:DropDownList ID="ddlAgencyType" runat="server">
            <asp:ListItem Text="PCA" Value="PCA" />
            <asp:ListItem Text="GA" Value="GA" />
        </asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatus_New" runat="server" Visible="true" CssClass="warningMessage" /></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><br /><asp:Button ID="btnAddAgency" runat="server" 
                    Text="Add New User" ValidationGroup="New_GA" OnClick="btnAddAgency_Click" 
                    CssClass="button" onmouseover="this.className='button buttonhover'" 
                    onmouseout="this.className='button'" /></td>
        </tr>        
        </table>

        <h3>Add New Agency Contact</h3>

        <table border="0">       
        <tr>
            <td class ="formLabelForm">Agency:</td>
            <td><asp:DropDownList id="ddlGAs_NewContact" Runat="Server"
                            DataSourceID="dsGAs"
                            DataTextField="GA_Name" 
                            DataValueField="GA_ID"
                            AppendDataBoundItems="true"  
                            CssClass="formLabel" Width="300">                            
                             <asp:ListItem Value=""></asp:ListItem>
                </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlGAs_NewContact" ValidationGroup="New_GA_Contact" ErrorMessage="* You must select an agency to associate this contact with *" CssClass="warningMessage" Display="Dynamic" />                             
           </td>            
        </tr>
        <tr>
            <td class ="formLabelForm" >Contact Name: </td>
            <td><asp:Textbox ID="txtContact_Name_New" runat="server"  Width="300" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtContact_Name_New" ValidationGroup="New_GA_Contact" ErrorMessage="* You must enter a contact name *" CssClass="warningMessage" Display="Dynamic" /></td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >Contact Email: </td>
            <td><asp:Textbox ID="txtContact_Email_New" runat="server" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtContact_Email_New" ValidationGroup="New_GA_Contact" ErrorMessage="* You must enter a contact email *" CssClass="warningMessage" Display="Dynamic" /></td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >Contact Telephone: </td>
            <td><asp:Textbox ID="txtContact_Telephone_New" runat="server" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtContact_Telephone_New" ValidationGroup="New_GA_Contact" ErrorMessage="* You must enter a contact telephone *" CssClass="warningMessage" Display="Dynamic" /></td>              
        </tr>   
        <tr>
            <td colspan="2" align="center"><asp:Label ID="lblAddAgencyContact_Status" runat="server" Visible="true" CssClass="warningMessage" /></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><br /><asp:Button ID="btnAddAgencyContact" 
                    runat="server" Text="Add New Agency Contact" CssClass="button" ValidationGroup="New_GA_Contact" 
                    onmouseover="this.className='button buttonhover'" 
                    onmouseout="this.className='button'" onclick="btnAddAgencyContact_Click" /></td>
        </tr>        
        </table>


                   
    </div>
    </fieldset>
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
    <asp:Label ID="lblGA_ID" runat="server" Visible="false" />
    </form>
</body>
</html>
