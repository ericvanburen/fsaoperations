<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckVALogin()
            
            If Not IsNothing(Request.QueryString("GA_ID")) Then
                Dim intGA_ID As String = Request.QueryString("GA_ID").ToString()
                lblGA_ID.Text = intGA_ID
            Else
                If Not IsNothing(Request.Cookies("IMF")) Then
                    lblGA_ID.Text = (Request.Cookies("IMF")("GA_ID").ToString())
                End If
            End If
            
            If lblGA_ID.Text Is Nothing OrElse lblGA_ID.Text.Length = 0 Then
                Response.Redirect("/not.logged.in.aspx")
            End If
            
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VA Discharge Application Administration</title>
</head>
     <frameset border="0" frameborder="0" framespacing="0" rows="100,*">
	<frame name="banner" noresize="noresize" scrolling="no" src="header.aspx" target="contents">
	<frameset cols="170,*">
		<frame name="contents" src="left.menu.VA.aspx" target="main">
		<frame name="main" src="IMFs.Add.VA.aspx">
	</frameset>
</frameset>

<body>  
<form runat="server" id="form1">
<asp:Label ID="lblGA_ID" runat="server" Visible="false" />
</form>
</body>
</html>
