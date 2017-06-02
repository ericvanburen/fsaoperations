<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
        End If

    End Sub
    Protected Sub ddlAllTeams_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim intId_Team As Integer = ddlAllTeams.SelectedValue
        lblId_Team.Text = intId_Team
        
        'Bind the all agencies
        BindAllAgencies()
        
        lblUpdateStatus.Visible = False
        lblError.Visible = False
    End Sub
    
  
    Public Sub BindAllAgencies()
        
        'This section binds the Checkboxlist, cblAgencies, with all of the Agencies
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_AllAgencies"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
      
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cblAgencies.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            cblAgencies.DataTextField = "AG_Name"
            cblAgencies.DataValueField = "AG"
            cblAgencies.DataBind()
        Finally
            strConnection.Close()
        End Try
        
        'After all of the agencies have been bound to the checkboxlist, cblAgencies, we now bind the agencies assigned to the team
        BindAgencies_Assigned()
    End Sub
    
    Sub BindAgencies_Assigned()
        'This part binds the selected agencies that have been selected from  v_EDTeams_Agencies to the ED team    
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_EDTeamAgencies"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Id_Team", lblId_Team.Text)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()

            While dr.Read()
                Dim currentCheckBox As ListItem = cblAgencies.Items.FindByValue(dr("AG").ToString())
                If Not (currentCheckBox Is Nothing) Then
                    currentCheckBox.Selected = True
                End If
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    
    Sub btnUpdateTeamAgenciesDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This updates the ED teams assigned agencies
        'The first step is to delete all of the selected records for the user from table EDTeams_Agencies        
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Update_EDTeam_Agencies_Delete"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Id_Team", lblId_Team.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        'Add/Insert the users selected assigned agencies
        btnUpdateTeamAgenciesInsert()
    End Sub
    
    Sub btnUpdateTeamAgenciesInsert()
        'This updates the ED teams selected assigned agencies
        'The second step to loop through all of the checked agencies in cblAgencies
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim ctr As Integer
        
        Try
            For ctr = 0 To cblAgencies.Items.Count - 1
                If cblAgencies.Items(ctr).Selected Then
                    strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
                    strSql = "p_Update_EDTeam_Agencies_Insert"
                    cmd = New SqlCommand(strSql)
                    cmd.CommandType = CommandType.StoredProcedure
                    
                    strConnection.Open()
                    cmd.Connection = strConnection
                    cmd.Parameters.AddWithValue("@Id_Team", lblId_Team.Text)
                    cmd.Parameters.AddWithValue("@AG", cblAgencies.Items(ctr).Value)
                    cmd.ExecuteNonQuery()
                    strConnection.Close()
                End If
            Next
        Catch
            lblError.Visible = True
            lblError.Text = "There was an error updating the assigned agencies.  Please try updating them again."
        Finally
            lblUpdateStatus.Visible = True
            lblUpdateStatus.Text = "Update successful!"
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
    <!--This one populates the ddlAllTeams dropdown-->
                      <asp:SqlDataSource ID="dsAllTeams" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllTeams" SelectCommandType="StoredProcedure" />
    <fieldset>
    <legend class="fieldsetLegend">Team Agency Assignments</legend><br />
    <div align="left">
    <table border="0">
    <tr>
            <td class ="formLabelForm">Team name:</td>
            <td>  <asp:DropDownList id="ddlAllTeams" Runat="Server"
                                DataSourceID="dsAllTeams"
                                DataTextField="Team_Name" 
                                DataValueField="Id_Team" 
                                CssClass="formLabel" AppendDataBoundItems="true" 
                                AutoPostBack="true" 
                                onselectedindexchanged="ddlAllTeams_SelectedIndexChanged">                            
                                <asp:ListItem Value=""></asp:ListItem>
       </asp:DropDownList></td>            
        </tr>          
        <tr>
            <td class ="formLabelForm" valign="top">Assigned Agencies:</td>
            <td>     
                    <asp:CheckBoxList ID="cblAgencies" runat="server"
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
            <td colspan="2" align="center"><asp:Button ID="btnUpdateTeam" runat="server" Text="Update Team" OnClick="btnUpdateTeamAgenciesDelete_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
        </tr> 
        </table>           
    </div>
    </fieldset>
    <asp:Label ID="lblId_Team" runat="server" Visible="false" />
    </form>
</body>
</html>
