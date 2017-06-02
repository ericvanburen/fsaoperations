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
    
    Protected Sub ddlAgencies_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'Bind the agency info
        BindAgency()
    End Sub
    
  
    Public Sub BindAgency()

        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_AG_Lookup"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@AG", ddlAgencies.SelectedValue)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            
            While dr.Read
                txtAG_Name.Text = dr("AG_Name")
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub
      
    
    Sub btnUpdateAgency_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This updates the AG information
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_AG_Update"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@AG", ddlAgencies.SelectedValue)
        cmd.Parameters.AddWithValue("@AG_Name", txtAG_Name.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            lblUpdateStatus.Text = "This agency was successfully updated"
        Finally
            strConnection.Close()
        End Try
        
        'We need to run this section in addition to the above
        'The PCA logins are in both tables GA and Agencies. The GA table also needs to be updated
            UpdatePCAAgency()
    End Sub
    
    Sub UpdatePCAAgency()
        'This updates the GA information
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_GA_Update_ByName"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@GA_Name", txtAG_Name.Text)
        
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
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
                      <asp:SqlDataSource ID="dsAgencies" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllAgencies" SelectCommandType="StoredProcedure" />
                     
    <fieldset>
    <legend class="fieldsetLegend">Agency Maintenance</legend><br />
    <div align="left">
    <table border="0">
    <tr>
            <td class ="formLabelForm">Agency Code:</td>
            <td><asp:DropDownList id="ddlAgencies" Runat="Server"
                            DataSourceID="dsAgencies"
                            DataTextField="AG" 
                            DataValueField="AG"
                            AppendDataBoundItems="true"  
                            CssClass="formLabel" 
                            onselectedindexchanged="ddlAgencies_SelectedIndexChanged" 
                            AutoPostBack="true">                            
                             <asp:ListItem Value=""></asp:ListItem>
                        </asp:DropDownList>                             
           </td>            
        </tr>          
        <tr>
            <td class ="formLabelForm" >AG Name: </td>
            <td><asp:Textbox ID="txtAG_Name" runat="server" /></td>              
        </tr>
        
        <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatus" runat="server" Visible="true" CssClass="warningMessage" /></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><br /><asp:Button ID="btnUpdateAgency" runat="server" Text="Update Agency" OnClick="btnUpdateAgency_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
        </tr> 
        
        </table>           
    </div>
    </fieldset>
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
    </form>
</body>
</html>
