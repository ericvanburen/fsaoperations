<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'Call Check Vangent Login Status
            CheckVangentLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblVangent.Text = (Request.Cookies("IMF")("Vangent").ToString())
            End If
            
            BindUserID()
        End If
    End Sub
    
    Sub BindUserID()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail_Vangent_Email"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Username", lblVangent.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                If IsDBNull(dr("IsAdmin")) = False Then
                    lblIsAdmin.Text = dr("IsAdmin")
                    lblQueueID.Text = dr("QueueID")
                Else
                    lblIsAdmin.Text = "False"
                End If
            End While
                        
        Finally
            'dr.Close()
            strConnection.Close()
        End Try
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vangent IMF Administration</title>
</head>
     <frameset border="0" frameborder="0" framespacing="0" rows="100,*">
	<frame name="banner" noresize="noresize" scrolling="no" src="../header.aspx" target="contents">
	<frameset cols="190,*">
		<frame name="contents" src="left.menu.Vangent.aspx" target="main">       
        <% If lblIsAdmin.Text = "True" Then%>
        <frame name="main" src="IMFs.Vangent.aspx">
        <% Else%>
            <%  If lblQueueID.Text = "1"  Then %>
                <frame name="main" src="IMF.Detail.Queue.aspx?QueueID=1&Lock=Lock">
            <% ElseIf lblQueueID.Text = "2" Then%>
                <frame name="main" src="IMF.Detail.Queue.aspx?QueueID=2&Lock=Lock">
            <% Else %>
                <frame name="main" src="IMF.Detail.Queue.aspx?QueueID=3&Lock=Lock">
            <% End If %>     
        <% End If%>
	</frameset>
</frameset>

<body>  
   <form id="form1" runat="server">
        <asp:Label ID="lblVangent" runat="server" Visible="True" />
        <asp:Label ID="lblIsAdmin" runat="server" Visible="true" />
        <asp:Label ID="lblQueueID" runat="server" Visible="false" />

   </form>
</body>
</html>
