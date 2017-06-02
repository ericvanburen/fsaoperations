<%@ Page Language="VB" ValidateRequest="false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
   
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckVangentLogin()
                      
            'Bind IMF Type Dropdownlist
            BindIMFTypes()
           
        End If
    End Sub
    
    Protected Sub ddlIMF_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'Clear any possible status value labels
        lblUpdateStatus.Text = ""
        lblUpdateStatusAdd.Text = ""
        
        'Bind the IMF info
        BindIMF()
    End Sub
    
  
    Public Sub BindIMF()

        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_IMF_Lookup"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@IMF_ID", ddlIMF_Type.SelectedValue)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            
            While dr.Read
                txtIMF_Type.Text = dr("IMF_Type")
                If IsDBNull(dr("Tooltip")) = False Then
                    txtToolTip.Text = dr("Tooltip")
                Else
                    txtToolTip.Text = ""
                End If
            End While
        Finally
            strConnection.Close()
        End Try
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
            ddlIMF_Type.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            ddlIMF_Type.DataTextField = "IMF_Type"
            ddlIMF_Type.DataValueField = "IMF_ID"
            ddlIMF_Type.DataBind()
        Finally
            strConnection.Close()
        End Try

    End Sub
    
    
    Sub btnUpdateIMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Page.IsValid Then
       
            'This updates the IMF information
            Dim strConnection As SqlConnection
            Dim strSql As String
            Dim cmd As SqlCommand

            strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
            strSql = "p_IMF_Update"
            cmd = New SqlCommand(strSql)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@IMF_ID", ddlIMF_Type.SelectedValue)
            cmd.Parameters.AddWithValue("@IMF_Type", txtIMF_Type.Text)
            cmd.Parameters.AddWithValue("@ToolTip", txtToolTip.Text)
            Try
                strConnection.Open()
                cmd.Connection = strConnection
                cmd.ExecuteNonQuery()
                lblUpdateStatus.Text = "This IMF type was successfully updated"
            Finally
                strConnection.Close()
            End Try
        
            'Clear all values from ddlIMF_Type to reflect the changes
            ddlIMF_Type.Items.Clear()
        
            'Clear the textboxes
            txtIMF_Type.Text = ""
            txtIMF_TypeAdd.Text = ""
            txtToolTip.Text = ""
            txtTooltip_Add.Text = ""
        
            'Rebind ddlIMF_Type
            BindIMFTypes()
        End If
        
    End Sub
    
    
    Sub btnAddIMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Page.IsValid Then
            'This updates the IMF information
            Dim strConnection As SqlConnection
            Dim strSql As String
            Dim cmd As SqlCommand

            strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
            strSql = "p_IMF_Add"
            cmd = New SqlCommand(strSql)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@IMF_Type", txtIMF_TypeAdd.Text)
            cmd.Parameters.AddWithValue("@ToolTip", txtTooltip_Add.Text)
            cmd.Parameters.AddWithValue("@IMF_Owner", "Vangent")
            Try
                strConnection.Open()
                cmd.Connection = strConnection
                cmd.ExecuteNonQuery()
                lblUpdateStatusAdd.Text = "This IMF type was successfully added"
            Finally
                strConnection.Close()
            End Try
        
            'Clear all values from ddlIMF_Type to reflect the changes
            ddlIMF_Type.Items.Clear()
        
            'Clear the textboxes
            txtIMF_Type.Text = ""
            txtIMF_TypeAdd.Text = ""
            txtToolTip.Text = ""
            txtTooltip_Add.Text = ""
        
            'Rebind ddlIMF_Type
            BindIMFTypes()
        End If
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
                     
    <fieldset>
    <legend class="fieldsetLegend">Edit Existing IMF Type</legend><br />
    <div align="left">
    <table border="0">
    <tr>
            <td class ="formLabelForm">IMF Type:</td>
            <td><asp:DropDownList id="ddlIMF_Type" Runat="Server"
                            DataTextField="IMF_Type" 
                            DataValueField="IMF_ID"
                            AppendDataBoundItems="true"  
                            CssClass="formLabel" 
                            onselectedindexchanged="ddlIMF_Type_SelectedIndexChanged" 
                            AutoPostBack="true">                            
                             <asp:ListItem Value=""></asp:ListItem>
                        </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfd1" runat="server" ControlToValidate="ddlIMF_Type" ErrorMessage="IMF Type is required" CssClass="warningMessage" ValidationGroup="Edit" />                             
           </td>            
        </tr>          
        <tr>
            <td class ="formLabelForm" >IMF Type: </td>
            <td><asp:Textbox ID="txtIMF_Type" runat="server" Columns="60" />                                    
            </td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >IMF Type Description: </td>
            <td><asp:Textbox ID="txtToolTip" runat="server" Columns="60" Rows="5" TextMode="MultiLine"  /> (1,000 characters max)</td>              
        </tr>
         <tr>
            <td colspan="2" align="center"><br />
            <asp:Button ID="btnUpdateIMF" runat="server" Text="Update IMF Type" OnClick="btnUpdateIMF_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" ValidationGroup="Edit" />
            </td>
        </tr> 
        <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatus" runat="server" Visible="true" CssClass="warningMessage" /></td>
        </tr>
        </table>           
    </div>
    </fieldset>
    <br />
    
    <fieldset>
    <legend class="fieldsetLegend">Add New IMF Type</legend><br />
    <div align="left">
    <table border="0">
       <tr>
            <td class ="formLabelForm" >IMF Type: </td>
            <td><asp:Textbox ID="txtIMF_TypeAdd" runat="server" Columns="60" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIMF_TypeAdd" ErrorMessage="IMF Type is required" CssClass="warningMessage" ValidationGroup="New" />
            </td>              
        </tr>
        <tr>
            <td class ="formLabelForm" >IMF Type Description: </td>
            <td><asp:Textbox ID="txtTooltip_Add" runat="server" Columns="60" Rows="5" TextMode="MultiLine" /> (1,000 characters max)</td>              
        </tr>
         <tr>
            <td colspan="2" align="center"><br /><asp:Button ID="btnAddIMD" runat="server" Text="Add New IMF Type" OnClick="btnAddIMF_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" ValidationGroup="New" /></td>
        </tr> 
        <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatusAdd" runat="server" Visible="true" CssClass="warningMessage" /></td>
        </tr>
        </table>           
    </div>
    </fieldset>
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblVangent_AG_Security" runat="server" Visible="false" />
    </form>
</body>
</html>
