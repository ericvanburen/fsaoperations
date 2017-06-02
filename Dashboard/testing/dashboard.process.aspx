<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Assembly="obout_Grid_NET" Namespace="Obout.Grid" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
       
    End Sub
    
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Dashboard Reporting</title>
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

        
    <style type="text/css">
        .style2
        {
            font-size: large;
        }
        .style7
        {
            font-size: xx-large;
        }
        .style8
        {
            width: 80%;
        }
        .style9
        {
            text-align: right;
            font-weight: bold;
        }
    </style>

        
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
         
    
    <fieldset class="fieldset">
    <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                <img src="images/fSA_logo_dashboard.gif" alt="Federal Student Aid - Dashboard Reports" /> 
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Dashboard Project Report Status</a></li>                               
                            </ul>
                                <span class="style7">
                               
                                <br />
                                </span>
                                <table align="center" class="style8" cellspacing="4" cellpadding="4">
                                    <tr>
                                        <td class="style9">
                                            Week Ending:</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList1" runat="server" Width="150px">
                                            <asp:ListItem Text="02/03/2012" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style9">
                                            Project:</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList2" runat="server" Width="248px">
                                                <asp:ListItem Text="AWG Top Performance Activities" />
                                                <asp:ListItem Text="IBR Statistics" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style9">
                                            Current Status:</td>
                                        <td>
                                            <asp:DropDownList ID="DropDownList3" runat="server">
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style9">
                                            Comments:</td>
                                        <td>
                                            <asp:TextBox ID="TextBox1" runat="server" Height="200px" TextMode="MultiLine" 
                                                Width="544px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td align="center">
                                            <asp:Button ID="Button1" runat="server" Text="Submit Project Update" 
                                                CssClass="button" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                </table>
                                <span class="style2"><br />
                                </span>
                            <br />
                                <br />
                                        

     </div>    
            </td>
        </tr>
      </table>
     </div>                
     </fieldset> 

    </form>
</body>
</html>
