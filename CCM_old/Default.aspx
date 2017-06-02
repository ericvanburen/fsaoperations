<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Retrieve username and password cookie values, if any
            If Not Request.Cookies("CCM") Is Nothing Then
                txtUsername.Text = Request.Cookies("CCM")("Username").ToString()
            End If
            If Not Request.Cookies("CCM") Is Nothing Then
                Dim strPassword As String
                strPassword = Request.Cookies("CCM")("Password").ToString()
                txtPassword.Attributes.Add("value", strPassword)
            End If
            
            lblRecordStatus.Text = ""
        End If
    End Sub
    
    Sub btnLogin_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UserLogin", con)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@Username", txtUsername.Text)
        cmd.Parameters.AddWithValue("@Password", txtPassword.Text)
        
        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                'Login was succesful                
                If dr.Read() Then
                    'Thread.CurrentThread.Sleep(3000)
                    If chkRememberMe.Checked Then
                        'Save login values as a cookie for future visits
                        Response.Cookies("CCM")("Username") = txtUsername.Text.ToString()
                        Response.Cookies("CCM")("Password") = txtPassword.Text.ToString()
                        'Cookie expires in 1 year
                        Response.Cookies("CCM").Expires = DateTime.Now.AddDays(365)
                    End If
                    
                    Response.Redirect("formB.aspx")
                Else
                    'Login failed
                    lblRecordStatus.Text = "You have entered an incorrect login"
                End If
            End Using
           
            'Catch ex As Exception
        Finally
            con.Close()
        End Try
                   
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Call Center Monitoring Login</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />	
		<script type="text/javascript">
		    $(function () {
		        // Tabs
		        $('#tabs').tabs();
		        $('#tabs').tabs({ selected: 0 });		       
		    });
		</script>
        
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
    <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		               <img src="images/fSA_logo.png" alt="Federal Student Aid - Call Center Monitoring" />
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Login</a></li>
                            </ul>
                            <div id="tabs-1">
                            <asp:UpdatePanel ID="pnlUpdate1" runat="server">
                            <ContentTemplate>
                                <div align="center" style="padding-top: 35px">
                                    <table>
                                        <tr>
                                            <td align="right">User name:</td>
                                            <td>
                                                <asp:TextBox ID="txtUsername" runat="server" Width="150px" /><br />
                                                <asp:RequiredFieldValidator ID="rfdUsername" runat="server" CssClass="warning" ErrorMessage="* Please enter a valid user name *" ControlToValidate="txtUsername" Display="Dynamic" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Password:</td>
                                            <td>
                                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="150px" /><br />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" ErrorMessage="* Please enter a password *" ControlToValidate="txtPassword" Display="Dynamic" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Remember Me?</td>
                                            <td align="left"><asp:CheckBox ID="chkRememberMe" runat="server" TextMode="Password" Checked="true" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center"><br />
                                                <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" CssClass="button" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="2"><asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" /></td>
                                        </tr>
                                    </table>
                                </div>                                
                            </ContentTemplate>
                            </asp:UpdatePanel>
                                <div id="updateProgress" align="center">
                                <asp:UpdateProgress runat="server" ID="PageUpdateProgress" AssociatedUpdatePanelID="pnlUpdate1"
                                    DynamicLayout="true">
                                    <ProgressTemplate>
                                        <img src="images/ajax-loader.gif" alt="logging in" /> Please wait while your are signed in
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                </div>
                            </div>                                                        
                          </div>                           
                           
                         </td>
                </tr>
            </table>
             </div>
             <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
              </fieldset>
    </form>
</body>
</html>
