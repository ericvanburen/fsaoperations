<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                'ED employee is looking at the IMF
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
            End If
                
            If (lblEDUserID Is Nothing AndAlso lblEDUserID.Text.Length = 0) Then
                Response.Redirect("not.logged.in.aspx")
            End If
           
        End If

    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ED IMF Administration</title>
</head>
     <frameset border="0" frameborder="0" framespacing="0" rows="100,*">
	<frame name="banner" noresize="noresize" scrolling="no" src="header.aspx" target="contents">
	<frameset cols="190,*">
		<frame name="contents" src="left.menu.ED.aspx" target="main">
		<frame name="main" src="MyIMFs.ED.aspx">
	</frameset>
</frameset>

<body>  
   <form id="form1" runat="server">
   <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
   </form>
</body>
</html>
