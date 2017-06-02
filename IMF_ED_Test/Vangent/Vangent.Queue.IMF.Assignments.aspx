<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'DRG Only page - Call Check Vangent Login Status
            CheckVangentLogin()
            
            Dim strQueueID As String = Request.QueryString("QueueID")
            lblQueueID.Text = strQueueID.ToString()
            
            BindIMFTypes()
            BindEmployees()
            
        End If
    End Sub
    
    Protected Sub ddlQueueID_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim intQueueID As Integer = ddlQueueID.SelectedValue
        lblQueueID.Text = intQueueID
        
        BindIMFTypes()
        BindEmployees()
        
        lblUpdateStatus.Visible = False
        lblError.Visible = False
    End Sub
        
    Public Sub BindIMFTypes()
        
        'This section binds the Checkboxlist, cblIMFTypes with all of the IMF Types
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_IMFTypes_Vangent"
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
                    
        'After all of the IMF Types have been bound to the checkboxlist, cblIMFTypes, we now bind the IMF Types assigned to the Queue
        BindIMFTYpes_Assigned()
    End Sub
    
    Sub BindIMFTYpes_Assigned()
        
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_VangentQueueIMFTypes"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QueueID", lblQueueID.Text)

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
    
    Sub btnUpdateQueue_Click(ByVal sender As Object, ByVal e As EventArgs)
        'When updating the IMFs assigned to each queue we first need to delete them all in Vangent_Queues       
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_VangentQueueIMF_Delete"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QueueID", ddlQueueID.SelectedValue)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        'Now we need to update the Queue/IMF Assignments
        UpdateQueueIMFTypeInsert()
    End Sub
    
    
    Sub UpdateQueueIMFTypeInsert()
        'This updates the Queue's selected IMF Types
        'The second step to loop through all of the checked IMF Types in cblIMFTypes
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim ctr As Integer
        
        Try
            For ctr = 0 To cblIMFTypes.Items.Count - 1
                If cblIMFTypes.Items(ctr).Selected Then
                    strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
                    strSql = "p_Update_Vangent_IMFTypes_Insert"
                    cmd = New SqlCommand(strSql)
                    cmd.CommandType = CommandType.StoredProcedure
                    
                    strConnection.Open()
                    cmd.Connection = strConnection
                    cmd.Parameters.AddWithValue("@QueueID", ddlQueueID.SelectedValue)
                    cmd.Parameters.AddWithValue("@IMF_ID", cblIMFTypes.Items(ctr).Value)
                    cmd.ExecuteNonQuery()
                    strConnection.Close()
                End If
            Next
            'Catch
            'lblError.Visible = True
            ' lblError.Text = "There was an error updating the IMF Types.  Please try updating them again."
        Finally
            lblUpdateStatus.Visible = True
            lblUpdateStatus.Text = "Update successful!"
           
        End Try
        
    End Sub
    
    Sub BindEmployees()
        'This shows all Vangent employees in cblUserID
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_AllUsers_Vangent"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
             
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cblUserID.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            cblUserID.DataTextField = "Email"
            cblUserID.DataValueField = "UserID"
            cblUserID.DataBind()
        Finally
            strConnection.Close()
        End Try
                    
        'After all of the employees have been bound to the checkboxlist, cblUserID, we now bind the employees assigned to the Queue
        BindEmployees_Assigned()
    End Sub
    
    Sub BindEmployees_Assigned()
        'This part binds the selected IMF Types that have been selected from  v_EDUsers_IMFTypes assigned to the ED user    
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_VangentQueue_Employees"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QueueID", lblQueueID.Text)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()

            While dr.Read()
                Dim currentCheckBox As ListItem = cblUserID.Items.FindByValue(dr("UserID").ToString())
                If Not (currentCheckBox Is Nothing) Then
                    currentCheckBox.Selected = True
                End If
                
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    Sub btnUpdateEmployees_Click(ByVal sender As Object, ByVal e As EventArgs)
        'This updates the Queue's assigned employees
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim ctr As Integer
        
        Try
            For ctr = 0 To cblUserID.Items.Count - 1
                If cblUserID.Items(ctr).Selected Then
                    strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
                    strSql = "p_Update_Vangent_Queue_Employees"
                    cmd = New SqlCommand(strSql)
                    cmd.CommandType = CommandType.StoredProcedure
                    
                    strConnection.Open()
                    cmd.Connection = strConnection
                    cmd.Parameters.AddWithValue("@QueueID", lblQueueID.Text)
                    cmd.Parameters.AddWithValue("@UserID", cblUserID.Items(ctr).Value)
                    cmd.ExecuteNonQuery()
                    strConnection.Close()
                End If
            Next
            'Catch
            'lblError.Visible = True
            'lblError.Text = "There was an error updating the IMF Types.  Please try updating them again."
        Finally
            lblUpdateStatusEmployees.Visible = True
            lblErrorEmployees.Text = "Update successful!"
           
        End Try
        
    End Sub
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DRG Queue IMF Administration</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" 
        src="../js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    
    <!--This one populates the Queue dropdown-->
    <asp:SqlDataSource ID="dsAllQueues" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>"
        SelectCommand="p_AllQueues_Vangent" SelectCommandType="StoredProcedure" /> 
    
    <fieldset>
    <legend class="fieldsetLegend">DRG Queue IMF Administration</legend><br />    
    <div align="left">
    <table border="0" width="600px">            
        <tr>
            <td align="left"><b>Queue Assignment:</b>
            <asp:DropDownList id="ddlQueueID" Runat="Server"
                                DataSourceID="dsAllQueues"
                                DataTextField="QueueName" 
                                DataValueField="QueueID" 
                                OnSelectedIndexChanged="ddlQueueID_SelectedIndexChanged" 
                                AutoPostBack="true" 
                                CssClass="formLabel"> 
                </asp:DropDownList>
            </td>                      
        </tr> 
        <tr>
        <td>
         <asp:CheckBoxList ID="cblIMFTypes" runat="server" 
                       CssClass="formLabel">                    
                    </asp:CheckBoxList>
        </td>       
        </tr>
        <tr>
            <td colspan="2" align="center"><br /><asp:Button ID="btnUpdateQueue" runat="server" Text="Update Queue IMF Assignments" onclick="btnUpdateQueue_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
        </tr> 
        <tr>
            <td align="center">
                <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" /><br />
                <asp:Label ID="lblError" runat="server" /></td>
        </tr>
        <tr>
                <td><b>Employees Assigned to this Queue:</b><br /><br /> 
                    <asp:CheckBoxList ID="cblUserID" runat="server" 
                       CssClass="formLabel" RepeatColumns="2" CellPadding="2" CellSpacing="4">                    
                    </asp:CheckBoxList>
                </td>
            </tr>
             <tr>
                <td align="center"><br /><br /><asp:Button ID="btnUpdateEmployees" runat="server" Text="Update Employee Assignments" onclick="btnUpdateEmployees_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
            </tr>
            <tr>
            <td align="center">
                <asp:Label ID="lblUpdateStatusEmployees" runat="server" CssClass="warningMessage" /><br />
                <asp:Label ID="lblErrorEmployees" runat="server" /></td>
            </tr> 
          </table>
          </div>
         </fieldset>
    <asp:Label ID="lblQueueID" runat="server" Visible="false" />
    </form>
</body>
</html>
