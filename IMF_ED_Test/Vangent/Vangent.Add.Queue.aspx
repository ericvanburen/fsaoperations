<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

       
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckVangentLogin()
                       
        End If
    End Sub
    
    
   
    Protected Sub btnAddQueue_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This adds a new queue to Vangent_Queues
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Vangent_Add_Queue"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QueueName", txtQueueName.Text)
        
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
            lblUpdateStatus.Text = "This queue has been added"
        End Try
       
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DRG Add New Queue</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" 
        src="../js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        
    <fieldset>
    <legend class="fieldsetLegend">DRG Add New Queue</legend><br />    
    <div align="left">
    <table border="0">
    <tr>
            <td class ="formLabelForm">New Queue Name:</td>
            <td><asp:TextBox ID="txtQueueName" runat="server" /><br />
            <asp:RequiredFieldValidator ID="Validator1" runat="server" ControlToValidate="txtQueueName" ErrorMessage="You must provide a Queue Name" CssClass="warningMessage" />
            </td>            
        </tr>
                   
        <tr>
            <td colspan="2" align="center"><asp:Button ID="btnAddQueue" runat="server" Text="Add New Queue" onclick="btnAddQueue_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
        </tr> 
        <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" /></td>
        </tr>
        </table>
         </div>
         </fieldset>
    </form>
</body>
</html>
