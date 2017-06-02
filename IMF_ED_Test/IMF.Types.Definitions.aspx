<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
                       
            'Bind IMF Type Dropdownlist
            BindIMFTypes()
           
        End If
    End Sub
    
    Public Sub BindIMFTypes()
        
        'This section binds the Checkboxlist, cblIMFTypes with all of the IMF Types
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_IMFTypes_All"
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
    
    Protected Sub ddlIMF_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
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
                If IsDBNull(dr("ToolTip")) = False Then
                    lblToolTip.Text = dr("ToolTip")
                Else
                    lblToolTip.Text = ""
                End If
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IMF Type Descriptions</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <fieldset>
    <legend class="fieldsetLegend">IMF Type Descriptions</legend><br />
    <div align="left">
    
    <table border="0" width="95%">
    <tr>
            <td class ="formLabelForm" align="right">Select an IMF Type:</td>
            <td align="left"><asp:DropDownList id="ddlIMF_Type" Runat="Server"
                            DataTextField="IMF_Type" 
                            DataValueField="IMF_ID"
                            AppendDataBoundItems="true"  
                            CssClass="formLabel" 
                            onselectedindexchanged="ddlIMF_Type_SelectedIndexChanged" 
                            AutoPostBack="true">                            
                            <asp:ListItem Value=""></asp:ListItem>
                </asp:DropDownList>                             
           </td>            
        </tr> 
        <tr>
            <td colspan="2" align="left"><br /><b><u>IMF Type Description</u></b></td>            
        </tr>    
        <tr>
            <td colspan="2"><asp:Label ID="lblToolTip" runat="server" /></td></td>
        </tr>
        </table>
    
    </div>
    </fieldset>
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
    </form>
</body>
</html>
