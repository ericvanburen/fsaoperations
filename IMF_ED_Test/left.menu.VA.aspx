<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and VA page - Call Check Login Status
            CheckVALogin()
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <base target="main" />
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <fieldset>
            <legend class="fieldsetLegend">VA Apps</legend>
            <ul>
                <li><a href="MyVAApps.VA.aspx">My Applications</a></li>
                <li><a href="search.VA.aspx">Advanced Search</a></li>
                <li><a href="IMFs.Add.VA.aspx">Submit New Discharge App</a></li>            
            </ul>        
        <br /><br />        
        </fieldset>
        
        <!--Log out link-->
        <br />
        <a href="logout.aspx" target="_top">Log out</a>    
         
                  
                
    </div>
    </form>
</body>
</html>
