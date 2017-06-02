<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            If Not IsNothing(Request.QueryString("AgencyID")) Then
                Dim intAG As String = Request.QueryString("AgencyID").ToString()
                lblAgency.Text = intAG
            Else
                If Not IsNothing(Request.Cookies("IMF")) Then
                    lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
                End If
            End If
            
            'If lblAgency.Text Is Nothing OrElse lblAgency.Text.Length = 0 Then
            'Response.Redirect("/not.logged.in.aspx")
            'End If
            
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PCA IMF Administration</title>
</head>
     <frameset border="0" frameborder="0" framespacing="0" rows="100,*">
	<frame name="banner" noresize="noresize" scrolling="no" src="header.aspx" target="contents">
	<frameset cols="170,*">
		<frame name="contents" src="left.menu.PCA.aspx" target="main">
		<frame name="main" src="IMFs.Add.PCA.aspx">
	</frameset>
</frameset>

<body>  
<form runat="server" id="form1">
<asp:Label ID="lblAgency" runat="server" Visible="false" />
</form>
</body>
</html>
