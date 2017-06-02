<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Dim intId_Team As Integer
    Dim strUserName, strPassword, strTeam_Name As String
    Dim blnIsActive As Boolean
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            Dim intUserID As Integer = Request.QueryString("UserID")
            lblUserID.Text = intUserID
            
            'Set the ddlAllUsers dropdown selected value to the value selected passed to this page
            ddlAllUsers.SelectedValue = intUserID
                    
            'Bind the individual user details
            BindUserName()
            
            'Bind the associated IMF Types for this user
            BindIMFTypes()
            
            'Bind the teams assigned to this user
            BindTeams_Assigned()
            
        End If
    End Sub
    
    Protected Sub ddlAllUsers_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        
        Dim intUserID As Integer = ddlAllUsers.SelectedValue
        lblUserID.Text = intUserID
        
        'Bind the individual user details
        BindUserName()
        
        'Bind the associated IMF Types for this user
        BindIMFTypes()
        
        lblUpdateStatus.Visible = False
        lblError.Visible = False
    End Sub
    
    Sub BindUserName()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                
                If IsDBNull(dr("UserName")) = False Then
                    'strUserName = dr("UserName")
                    ddlAllUsers.SelectedIndex = ddlAllUsers.Items.IndexOf(ddlAllUsers.Items.FindByValue(dr("UserID")))
                End If
                
                If IsDBNull(dr("IsActive")) = False Then
                    blnIsActive = dr("IsActive")
                End If
                
                If IsDBNull(dr("Password")) = False Then
                    strPassword = dr("Password")
                End If
            	           	
            End While
				
            Page.DataBind()
        
        Finally
            dr.Close()
            strConnection.Close()
        End Try
    End Sub
    
  
    Public Sub BindIMFTypes()
        
        'This section binds the Checkboxlist, cblIMFTypes with all of the IMF Types
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_IMFTypes"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
      
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cblIMFTypes.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            cblIMFTypes.DataTextField = "IMF_Type"
            cblIMFTypes.DataValueField = "IMF_ID"
            cblIMFTypes.DataBind()
        Finally
            strConnection.Close()
        End Try
        
        'After all of the IMF Types have been bound to the checkboxlist, cblIMFTypes, we now bind the IMF Types assigned to the user
        BindIMFTYpes_Assigned()
    End Sub
    
    Sub BindIMFTYpes_Assigned()
        'This part binds the selected IMF Types that have been selected from  v_EDUsers_IMFTypes assigned to the ED user    
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_EDUserIMFTypes"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()

            While dr.Read()
                Dim currentCheckBox As ListItem = cblIMFTypes.Items.FindByValue(dr("IMF_ID").ToString())
                If Not (currentCheckBox Is Nothing) Then
                    currentCheckBox.Selected = True
                End If
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    Sub BindTeams_Assigned()
        'This part binds the selected Teams that have been selected from v_EDUsers_Teams assigned to the ED user    
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_EDUsers_Teams"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()

            While dr.Read()
                Dim currentCheckBox As ListItem = cblTeam_Name.Items.FindByValue(dr("ID_Team").ToString())
                If Not (currentCheckBox Is Nothing) Then
                    currentCheckBox.Selected = True
                End If
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub

    Protected Sub btnUpdateUser_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This updates the ED users password and team assignment
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Update_EDUser_UserDetail"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Password", txtPassword.Text)
        cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked)
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        'Delete the users selected IMF Types
        btnUpdateUserIMFTypeDelete_Click()
    End Sub
    
    Sub btnUpdateUserIMFTypeDelete_Click()
        'This updates the ED users selected IMF Types
        'The first step is to delete all of the selected records for the user from table EDUsers_IMFTypes        
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Update_EDUser_IMFTypes_Delete"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        'Add/Insert the users selected IMF Types
        btnUpdateUserIMFTypeInsert_Click()
    End Sub
    
    Sub btnUpdateUserIMFTypeInsert_Click()
        'This updates the ED users selected IMF Types
        'The second step to loop through all of the checked IMF Types in cblIMFTypes
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim ctr As Integer
        
        Try
            For ctr = 0 To cblIMFTypes.Items.Count - 1
                If cblIMFTypes.Items(ctr).Selected Then
                    strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
                    strSql = "p_Update_EDUser_IMFTypes_Insert"
                    cmd = New SqlCommand(strSql)
                    cmd.CommandType = CommandType.StoredProcedure
                    
                    strConnection.Open()
                    cmd.Connection = strConnection
                    cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
                    cmd.Parameters.AddWithValue("@IMF_ID", cblIMFTypes.Items(ctr).Value)
                    cmd.ExecuteNonQuery()
                    strConnection.Close()
                End If
            Next
        Catch
            lblError.Visible = True
            lblError.Text = "There was an error updating the IMF Types.  Please try updating them again."
        Finally
            lblUpdateStatus.Visible = True
            lblUpdateStatus.Text = "Update successful!"
           
            'Now delete all of the user's team assignments
            UpdateUserTeamAssignmentDelete()
        End Try
    End Sub
    
    Sub UpdateUserTeamAssignmentDelete()
        'This updates the ED users assigned Teams
        'The first step is to delete all of the selected records for the user from table EDUsers_Teams
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Update_EDUser_Teams_Delete"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        'Add/Insert the users selected Team assignment
        btnUpdateUserTeamInsert_Click()
    End Sub
    
    Sub btnUpdateUserTeamInsert_Click()
        'This updates the ED users selected Team assignments
        'The second step to loop through all of the checked Teams in cblTeam_Name
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim ctr As Integer
        
        Try
            For ctr = 0 To cblTeam_Name.Items.Count - 1
                If cblTeam_Name.Items(ctr).Selected Then
                    strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
                    strSql = "p_Update_EDUser_Teams_Insert"
                    cmd = New SqlCommand(strSql)
                    cmd.CommandType = CommandType.StoredProcedure
                    
                    strConnection.Open()
                    cmd.Connection = strConnection
                    cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
                    cmd.Parameters.AddWithValue("@ID_Team", cblTeam_Name.Items(ctr).Value)
                    cmd.ExecuteNonQuery()
                    strConnection.Close()
                End If
            Next
        Catch
            lblError.Visible = True
            lblError.Text = "There was an error updating the Team assignments.  Please try updating them again."
        Finally
            lblUpdateStatus.Visible = True
            lblUpdateStatus.Text = "Update successful!"
            'strConnection.Close()           
        End Try
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ED User IMF Assignments</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <!--This one populates the ddlAllUsers dropdown-->
                      <asp:SqlDataSource ID="dsAllUsers" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllUsers" SelectCommandType="StoredProcedure" />
     <fieldset>
    <legend class="fieldsetLegend">ED User IMF Assignments</legend><br />    
    <div align="left">
    <table border="0">
    <tr>
            <td class ="formLabelForm">User name:</td>
            <td>  <asp:DropDownList id="ddlAllUsers" Runat="Server"
                                DataSourceID="dsAllUsers"
                                DataTextField="UserName" 
                                DataValueField="UserID" 
                                CssClass="formLabel" AppendDataBoundItems="true" 
                                AutoPostBack="true" 
                                onselectedindexchanged="ddlAllUsers_SelectedIndexChanged">                            
                                <asp:ListItem Value=""></asp:ListItem>
       </asp:DropDownList></td>            
        </tr>
        <tr>
            <td class ="formLabelForm">User Is Active?</td>
            <td><asp:CheckBox ID="chkIsActive" runat="server" Checked='<%# blnIsActive %>' /></td>            
        </tr>
        <tr>
            <td class ="formLabelForm">Password:</td>
            <td><asp:Textbox ID="txtPassword" runat="server" Text='<%# strPassword %>' /></td>            
        </tr>
         
        <tr>
            <td class ="formLabelForm">Team Assignment(s):</td>
            <td><asp:CheckboxList ID="cblTeam_Name" runat="server">
                          <asp:ListItem Text="Team 1" Value="1" />
                          <asp:ListItem Text="Team 2" Value="2" />
                          <asp:ListItem Text="Team 3" Value="3" />
                 </asp:CheckboxList>                      
            </td>            
        </tr>  
         
        <tr>
            <td class ="formLabelForm" valign="top">Assigned IMF Types:</td>
            <td>     
                    <asp:CheckBoxList ID="cblIMFTypes" runat="server"
                       CssClass="formLabel" RepeatColumns="2" >                    
                    </asp:CheckBoxList>
               </td>              
            </tr>
      
        <tr>
            <td colspan="2" align="center">
                <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" /><br />
                <asp:Label ID="lblError" runat="server" /></td>
        </tr>   
        <tr>
            <td colspan="2" align="center"><asp:Button ID="btnUpdateUser" runat="server" Text="Update User" onclick="btnUpdateUser_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
        </tr> 
        </table>
         </div>
         </fieldset>
    <asp:Label ID="lblUserID" runat="server" Visible="false" />
    </form>
</body>
</html>
