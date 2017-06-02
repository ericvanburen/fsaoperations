<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Dim intId_Team As Integer
    Dim strUserName, strPassword, strTeam_Name As String
    Dim blnIsActive, blnIsAdmin As Boolean
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckVangentLogin()
            
            Dim intUserID As Integer = Request.QueryString("UserID")
            lblUserID.Text = intUserID
            
            'Set the ddlAllUsers dropdown selected value to the value selected passed to this page
            ddlAllUsers.SelectedValue = intUserID
                    
            'Bind the individual user details
            BindUserName()
                       
        End If
    End Sub
    
    Protected Sub ddlAllUsers_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        
        Dim intUserID As Integer = ddlAllUsers.SelectedValue
        lblUserID.Text = intUserID
        
        'Bind the individual user details
        BindUserName()
               
        lblUpdateStatus.Visible = False
        lblError.Visible = False
    End Sub
    
    Sub BindUserName()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail_Vangent"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                
                If IsDBNull(dr("UserID")) = False Then
                    'strUserName = dr("UserName")
                    ddlAllUsers.SelectedIndex = ddlAllUsers.Items.IndexOf(ddlAllUsers.Items.FindByValue(dr("UserID")))
                End If
                               
                If IsDBNull(dr("IsAdmin")) = False Then
                    chkIsAdmin.Checked = dr("IsAdmin")
                End If
                
                If IsDBNull(dr("QueueID")) = False Then
                    ddlQueueID.SelectedIndex = ddlQueueID.Items.IndexOf(ddlQueueID.Items.FindByValue(dr("QueueID")))
                End If
                           	           	
            End While
			        
        Finally
            dr.Close()
            strConnection.Close()
        End Try
    End Sub
   
    Protected Sub btnUpdateUser_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This updates the Vangent IsActive, IsAdmin, Queue Assignment
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Update_VangentUser"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@IsAdmin", chkIsAdmin.Checked)
        cmd.Parameters.AddWithValue("@IsActive", True)
        cmd.Parameters.AddWithValue("@QueueID", ddlQueueID.SelectedValue)
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
            lblUpdateStatus.Text = "This user has been updated"
        End Try
       
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DRG User Administration</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" 
        src="../js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <!--This one populates the ddlAllUsers dropdown-->
    <asp:SqlDataSource ID="dsAllUsers" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>"
        SelectCommand="p_AllUsers_Vangent" SelectCommandType="StoredProcedure" />
    
    <!--This one populates the Queue dropdown-->
    <asp:SqlDataSource ID="dsAllQueues" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>"
        SelectCommand="p_AllQueues_Vangent" SelectCommandType="StoredProcedure" /> 
    
    <fieldset>
    <legend class="fieldsetLegend">DRG User Administration</legend><br />    
    <div align="left">
    <table border="0">
    <tr>
            <td class ="formLabelForm">User name:</td>
            <td>  <asp:DropDownList id="ddlAllUsers" Runat="Server"
                                DataSourceID="dsAllUsers"
                                DataTextField="Email" 
                                DataValueField="UserID" 
                                CssClass="formLabel" AppendDataBoundItems="true" 
                                AutoPostBack="true" 
                                onselectedindexchanged="ddlAllUsers_SelectedIndexChanged">                        
       </asp:DropDownList></td>            
        </tr>
            <tr>
            <td class ="formLabelForm">User Is Administrator?</td>
            <td><asp:CheckBox ID="chkIsAdmin" runat="server" /></td>            
        </tr>                    
        <tr>
            <td class ="formLabelForm">Queue Assignment:</td>
            <td>         
                 <asp:DropDownList id="ddlQueueID" Runat="Server"
                                DataSourceID="dsAllQueues"
                                DataTextField="QueueName" 
                                DataValueField="QueueID" 
                                CssClass="formLabel"> 
                </asp:DropDownList>                   
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
