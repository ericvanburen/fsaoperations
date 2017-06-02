<%@ Page Language="VB" Debug="true" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.DirectoryServices" %>
<%@ Import Namespace="System.Web.Security" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        'Hide two login panels on page load
        If Not IsPostBack Then
            'IMF Login Panels
            pnlAgencyLogin.Visible = False
            pnlEDLogin.Visible = False
            pnlDRGLogin.Visible = False
        End If
    End Sub
    
       
    'Encrypts the user entered password to match the LDAP encryption
    Function HashUserPassword(ByVal pass As String) As String
        Dim SHA1 As SHA1CryptoServiceProvider
        Dim bytHash As Byte()
        Dim bytValue As Byte()
        SHA1 = New SHA1CryptoServiceProvider
        bytValue = System.Text.Encoding.UTF8.GetBytes(pass)
        bytHash = SHA1.ComputeHash(bytValue)
        SHA1.Clear()
        Return "{SHA}" & (Convert.ToBase64String(bytHash))
    End Function
       
    Function AuthenticateUser(ByVal user As String, ByVal pass As String) As Boolean
       
        Dim objEntry As DirectoryEntry
        Dim objSearcher As DirectorySearcher
        Dim objSearchResult As SearchResult
        Dim LDAPServer As String = System.Configuration.ConfigurationManager.AppSettings("LDAPServer").ToString
        Dim LDAPUsername As String = System.Configuration.ConfigurationManager.AppSettings("LDAPUsername").ToString
        Dim LDAPPassword As String = System.Configuration.ConfigurationManager.AppSettings("LDAPPassword").ToString
        Dim LDAPPasswordEncryption As String = System.Configuration.ConfigurationManager.AppSettings("LDAPPasswordEncryption").ToString.ToLower()
              
        'objEntry = New DirectoryEntry("LDAP://localhost/ou=users,ou=dmcs,dc=ed,dc=gov", "cn=Manager,dc=ed,dc=gov", "secret", AuthenticationTypes.ServerBind)
        objEntry = New DirectoryEntry(LDAPServer, LDAPUsername, LDAPPassword, AuthenticationTypes.ServerBind)
        
        'Set up to search for UserMan on the Users node
        objSearcher = New DirectorySearcher(objEntry, "(uid=" & user & ")")
       
        'Find the user
        objSearchResult = objSearcher.FindOne()
		
        If Not objSearchResult Is Nothing Then
            Dim strUserName As String = ""
            Dim strUserPassword As String = ""
            
            Try
                strUserName = objSearchResult.GetDirectoryEntry().Properties("uid").Value.ToString()
                Dim userPassword As Byte() = DirectCast(objSearchResult.GetDirectoryEntry().Properties("userPassword")(0), Byte())
               
                Dim a As ASCIIEncoding
                a = New ASCIIEncoding

                strUserPassword = a.GetString(userPassword)
                
                'Use LDAP password encryption passed on web.config settiing
                Dim strHashpass As String = ""
                If LDAPPasswordEncryption = "true" Then
                    strHashpass = HashUserPassword(pass)
                Else
                    strHashpass = pass
                End If
                'Response.Write("ED user: " & user & "<br>")
                'Response.Write("LDAP user: " & strUserName & "<br>")
                'Response.Write("user password: " & strHashpass & "<br>")
                'Response.Write("LDAP password: " & strUserPassword & "<br>")
                'Response.Write(cblLoginType.SelectedValue)
                'Response.Write(strUserPassword)
                
                If Trim(user.ToString()) = Trim(strUserName.ToString()) Then
                    If Trim(strHashpass.ToString()) = Trim(strUserPassword.ToString()) Then
                        If cblLoginType.SelectedValue = "ED" Then
                            LoginED()
                        ElseIf cblLoginType.SelectedValue = "PCA" Then
                            LoginPCA()
                        ElseIf cblLoginType.SelectedValue = "DRG" Then
                            LoginDRG()
                        End If
                    Else
                        If cblLoginType.SelectedValue = "ED" Then
                            lblEDLoginStatus.Text = "You have entered an incorrect login. Please try again."
                        ElseIf cblLoginType.SelectedValue = "PCA" Then
                            lblPCALoginStatus.Text = "You have entered an incorrect login. Please try again."
                        ElseIf cblLoginType.SelectedValue = "DRG" Then
                            lblDRGLoginStatus.Text = "You have entered an incorrect login. Please try again."
                        End If
                        Return False
                    End If
                End If
               
            Finally
            End Try
        End If
		
    End Function
   
          
    'login routine for ED users
    Sub btnAuthenticateED_Click(ByVal sender As Object, ByVal e As EventArgs)
        AuthenticateUser(txtEDUsername.Text, txtEDPassword.Text)
    End Sub
           
    'login routine for PCA users
    Sub btnAuthenticatePCA_Click(ByVal sender As Object, ByVal e As EventArgs)
        AuthenticateUser(txtAgencies.Text, txtPCAPassword.Text)
    End Sub
           
    'login routine for DRG users
    Sub btnAuthenticateDRG_Click(ByVal sender As Object, ByVal e As EventArgs)
        AuthenticateUser(txtDRGUsername.Text, txtDRGPassword.Text)
    End Sub
    
    Sub LoginED()
        Try
            'We need the ED user ID
            lblEDUserID.Text = GetEDUserID().ToString()

            'Track user login
            InsertLogin(txtEDUsername.Text, True)

            'Set login cookies for ED users            
            If lblEDUserID.Text = "0" Then
                lblEDLoginStatus.Text = "You have entered an incorrect login. Please try again."
            Else
                Response.Cookies("IMF")("EDUserID") = lblEDUserID.Text.ToString()
                Response.Cookies("IMF")("EDUserName") = txtEDUsername.Text.ToString()
                Response.Redirect("IMF.ED.Main.aspx")
            End If
        Finally
            
        End Try
    End Sub
    
    Sub LoginPCA()
        Try
            lblAgency.Text = txtAgencies.Text
               
            'Track user login
            InsertLogin(txtAgencies.Text, True)
                
            Response.Cookies("IMF")("AG") = lblAgency.Text
            Response.Redirect("IMF.PCA.Main.aspx")
        Finally
        End Try
    End Sub
    
    'There is only one login routine for DRG users
    Sub LoginDRG()
        Try
            'We need the Vangent user ID
            lblVangentUserID.Text = GetVangentUserID().ToString()
               
            'Track user login
            InsertLogin(txtDRGUsername.Text, True)

            'Set login cookies for DRG users                   
            If lblVangentUserID.Text = "0" Then
                lblDRGLoginStatus.Text = "You have entered an incorrect login. Please try again."
            Else
                Response.Cookies("IMF")("VangentUserID") = lblVangentUserID.Text.ToString()
                Response.Cookies("IMF")("Vangent") = txtDRGUsername.Text.ToString()
                Response.Redirect("Vangent/IMF.Vangent.Main.aspx")
            End If
        Finally
            
        End Try
    End Sub
        
    Private Function GetEDUserID() As Integer
        Dim UserID As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("p_GetEDUserID", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Username", SqlDbType.VarChar).Value = txtEDUsername.Text
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            'UserID = CType(cmd.Parameters("@UserID").Value, Integer)            
            If Not IsDBNull(cmd.Parameters("@UserID").Value) Then
                UserID = CType(cmd.Parameters("@UserID").Value, Integer)
            Else
                UserID = 0
            End If
        End Using
        Return UserID
    End Function
    
    Private Function GetVangentUserID() As Integer
        Dim UserID As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("p_GetVangentUserID", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Username", SqlDbType.VarChar).Value = txtDRGUsername.Text
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            'UserID = CType(cmd.Parameters("@UserID").Value, Integer)
            If Not IsDBNull(cmd.Parameters("@UserID").Value) Then
                UserID = CType(cmd.Parameters("@UserID").Value, Integer)
            Else
                UserID = 0
            End If
        End Using
        Return UserID
    End Function
       
    Protected Sub cblLoginType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If cblLoginType.SelectedValue = "PCA" Then
            pnlAgencyLogin.Visible = True
            pnlEDLogin.Visible = False
            pnlDRGLogin.Visible = False
        ElseIf cblLoginType.SelectedValue = "ED" Then
            pnlAgencyLogin.Visible = False
            pnlEDLogin.Visible = True
            pnlDRGLogin.Visible = False
        ElseIf cblLoginType.SelectedValue = "DRG" Then
            pnlAgencyLogin.Visible = False
            pnlEDLogin.Visible = False
            pnlDRGLogin.Visible = True
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
    
    Sub InsertLogin(ByVal strUsername As String, ByVal LoginSuccessful As Boolean)
        
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim SQLString As String
        Dim strIP As String = Request.UserHostAddress

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        SQLString = "p_InsertLogin"
        cmd = New SqlCommand(SQLString)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@Username", strUsername)
        cmd.Parameters.AddWithValue("@LoginSuccessful", LoginSuccessful)
        cmd.Parameters.AddWithValue("@IP", strIP)
        
        Try
            con.Open()
            cmd.Connection = con
            cmd.ExecuteNonQuery()
        Finally
            con.Close()
        End Try
    
    End Sub
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMF Login</title>
   <link type="text/css" href="ui.all.css" rel="stylesheet" />
	<link type="text/css" href="ui.tabs.css" rel="stylesheet" />
	<link type="text/css" href="style.css" rel="stylesheet" />
	<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
	<script type="text/javascript" src="js/ui.core.js"></script>
	<script type="text/javascript" src="js/ui.tabs.js"></script>
	<script type="text/javascript">	    
    $(function() { 
        $("#tabs").tabs({ 
            show: function() { 
                var sel = $('#tabs').tabs('option', 'selected'); 
                $("#<%= hidLastTab.ClientID %>").val(sel); 
            }, 
            selected: <%= hidLastTab.Value %> 
        }); 
    }); 
</script> 
    
</head>
<body>
    <form id="form1" runat="server">
    <p><img src="images/fsa_logo.gif" alt="FSA Logo" width="657" height="66" /></p>
    <div class="demo">

    <div id="tabs">
            <ul>
                <li><a href="#tabs-1">Submit an IMF</a></li>
                <li><a href="#tabs-2">VA Disability Discharge Application</a></li>               
            </ul>   
      
            <!--IMF-->
           <div id="tabs-1">
                                            
                   <asp:Panel ID="pnlIMFLogin" runat="server">
                   <div align="center">                     
                   <table border="0" cellpadding="3" cellspacing="2" style="border-collapse: collapse" width="650" id="table1">
                    <tr>
                        <td class="formLabel"><br />
                        <fieldset>
                        <legend class="fieldsetLegend">Step 1: Specify Your Login Type</legend><br />
                       <asp:Radiobuttonlist ID="cblLoginType" runat="server" onselectedindexchanged="cblLoginType_SelectedIndexChanged" RepeatDirection="Horizontal" AutoPostBack="true">        
                              <asp:ListItem Text="PCA" Value="PCA" />
                              <asp:ListItem Text="ED" Value="ED" />  
                              <asp:ListItem Text="DRG" Value="DRG" />                             
                        </asp:Radiobuttonlist>
                       </fieldset>
                     </td>
                    </tr>

                      <tr>
                        <td align="center"><br />
                        <asp:Panel ID="pnlAgencyLogin" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Step 2: Enter your PCA login information</legend><br />
                        
                        <table width="600" border="0">
                        <tr>
                            <td align="right" width="50%">Agency: </td>
                            <td align="left" width="50%" valign="middle"><asp:Textbox id="txtAgencies" Runat="Server" /><img src="images/padlock_ssl.gif" width="27" height="13" alt="SSL padlock"/>
                            <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                            ControlToValidate="txtAgencies" Display="Dynamic" CssClass="warningMessage"
                            Text="Please enter your agency code"
                            Runat="Server" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right" width="50%">Password: </td>
                            <td align="left" width="50%"><asp:TextBox ID="txtPCAPassword"
                                    Textmode="Password"
                                    Runat="Server" /><img src="images/padlock_ssl.gif" width="27" height="13"  alt="SSL padlock"/>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                    ControlToValidate="txtPCAPassword" CssClass="warningMessage" Display="Dynamic"
                                    Text="Please enter your password"
                                    Runat="Server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><br /><asp:Button ID="btnLoginPCA" Text="Login" OnClick="btnAuthenticatePCA_Click" Runat="Server" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
                        </tr>    
                        <tr>
                            <td colspan="2" align="center"><asp:Label ID="lblPCALoginStatus" CssClass="warningMessage" Runat="Server" /></td>
                        </tr>          
                        </table>
                         </fieldset></asp:Panel>
                       
                       <asp:Panel ID="pnlEDLogin" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Step 2: Enter your ED login information</legend><br />
                        
                        <table width="700" border="0">
                        <tr>
                            <td align="right" width="50%">ED User name: </td>
                            <td align="left" width="50%" valign="middle">
                            <asp:Textbox id="txtEDUsername" Runat="Server" /><img src="images/padlock_ssl.gif" width="27" height="13" alt="SSL padlock"/>
                            <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                            ControlToValidate="txtEDUsername" Display="Dynamic" CssClass="warningMessage"
                            Text="Please enter your ED user name"
                            Runat="Server" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right" width="50%">Password: </td>
                            <td align="left" width="50%"><asp:TextBox
                                    ID="txtEDPassword"
                                    Textmode="Password"
                                    Runat="Server" /><img src="images/padlock_ssl.gif" width="27" height="13"  alt="SSL padlock"/>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4"
                                    ControlToValidate="txtEDPassword" CssClass="warningMessage" Display="Dynamic"
                                    Text="Please enter your password"
                                    Runat="Server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><br /><asp:Button ID="btnLoginED" Text="Login" OnClick="btnAuthenticateED_Click" Runat="Server" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
                        </tr>    
                        <tr>
                            <td colspan="2" align="center"><asp:Label ID="lblEDLoginStatus" CssClass="warningMessage" Runat="Server" /></td>
                        </tr>       
                        </table>
                         </fieldset></asp:Panel>

                       <asp:Panel ID="pnlDRGLogin" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Step 2: Enter your DRG login information</legend><br />
                        
                        <table width="700" border="0">
                        <tr>
                            <td align="right" width="50%">DRG User name: </td>
                            <td align="left" width="50%" valign="middle">
                            <asp:Textbox id="txtDRGUsername" Runat="Server" /><img src="images/padlock_ssl.gif" width="27" height="13" alt="SSL padlock"/>
                            <br /><asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                            ControlToValidate="txtDRGUsername" Display="Dynamic" CssClass="warningMessage"
                            Text="Please enter your DRG user name"
                            Runat="Server" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right" width="50%">Password: </td>
                            <td align="left" width="50%"><asp:TextBox
                                    ID="txtDRGPassword"
                                    Textmode="Password"
                                    Runat="Server" /><img src="images/padlock_ssl.gif" width="27" height="13"  alt="SSL padlock"/>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6"
                                    ControlToValidate="txtDRGPassword" CssClass="warningMessage" Display="Dynamic"
                                    Text="Please enter your password"
                                    Runat="Server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><br /><asp:Button ID="btnLoginDRG" Text="Login" OnClick="btnAuthenticateDRG_Click" Runat="Server" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
                        </tr>    
                        <tr>
                            <td colspan="2" align="center"><asp:Label ID="lblDRGLoginStatus" CssClass="warningMessage" Runat="Server" /></td>
                        </tr>       
                        </table>
                         </fieldset></asp:Panel>
                    </td>
                      </tr>
                    </table>
                    </div>
                   </asp:Panel>
              </div>
        </div>  
        
        </div>
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />  
<asp:Label ID="lblVangentUserID" runat="server" Visible="false" />  
<asp:Label ID="lblAgency" runat="server" Visible="false" />
<asp:Label ID="lblGA_ID" runat="server" Visible="false" />
<asp:Label ID="lblLogin" runat="server" />
<asp:HiddenField runat="server" ID="hidLastTab" Value="0" />
    
 </form>
</body>
</html>
