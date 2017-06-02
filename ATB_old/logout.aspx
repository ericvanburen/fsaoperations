<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Response.Cookies("ATB").Expires = DateTime.Now.AddDays(-1)
        End If
    End Sub
    
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Call Center Monitoring Log out</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />	
		<script type="text/javascript">
		    $(function () {

		        // Tabs
		        $('#tabs').tabs();
		        $('#tabs').tabs({ selected: 0 });

		        //hover states on the static widgets
		        $('#dialog_link, ul#icons li').hover(
					function () { $(this).addClass('ui-state-hover'); },
					function () { $(this).removeClass('ui-state-hover'); }
				);
		    });
		</script>

        
</head>
<body>
    <form id="form1" runat="server">
    
    <fieldset class="fieldset">
    <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                <img src="images/fSA_logo.gif" alt="Federal Student Aid - Call Center Monitoring" /> 
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Login</a></li>
                            </ul>
                              <div id="tabs-1">                                             
                           
                                <p>You have been successfully logged out.  <a href="default.aspx">Click here</a> to log back in.</p>                                                                 
                           
                              </div>                                                        
                          </div>                
                            
                           <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        <p>&nbsp;</p>
                        
                         </td>
                </tr>
            </table>
             </div>
                
              </fieldset>
    </form>
</body>
</html>
