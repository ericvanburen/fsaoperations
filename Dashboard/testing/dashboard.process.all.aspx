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
        .style7
        {
            font-size: xx-large;
        }
        </style>

        <style type="text/css">
.ui-widget-content a { color: #222222; }
.auto-style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: small;
}
.auto-style2 {
	color: white;
}
.auto-style3 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: small;
	text-align: left;
}
            .style8
            {
                width: 16px;
                height: 16px;
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
                               <table id="Grid2" border="0" cellPadding="4" cellSpacing="0" style="WIDTH: 670px; BORDER-COLLAPSE: collapse; COLOR: #333333">
	<tr style="BACKGROUND-COLOR: #507cd1; COLOR: white; FONT-WEIGHT: bold">
		<th class="auto-style1" scope="col">
		<a href="javascript:__doPostBack('Grid2','Sort$Ending_Inventory')">
		<span class="auto-style2">Details</span></a></th>
		<th class="auto-style1" scope="col">
		<a href="javascript:__doPostBack('Grid2','Sort$Ending_Inventory')">
		<span class="auto-style2">Project</span></a></th>
		<th class="auto-style1" scope="col">
		<a href="javascript:__doPostBack('Grid2','Sort$Status')" style="COLOR: white">
		Status</a></th>
	</tr>
	<tr style="BACKGROUND-COLOR: #eff3fb">
		<td class="auto-style1" align="center">
            <img alt="" class="style8" src="images/page_find.gif" /></td>
		<td class="auto-style3">AWG TOP Activities</td>
		<td align="right" class="auto-style1" style="BACKGROUND-COLOR: green">
		Green</td>
	</tr>
	<tr style="BACKGROUND-COLOR: white">
		<td class="auto-style1" align="center">
            <img alt="" class="style8" src="images/page_find.gif" /></td>
		<td class="auto-style3">IBR Statistics</td>
		<td align="right" class="auto-style1" style="BACKGROUND-COLOR: green">
		Green</td>
	</tr>
	<tr style="BACKGROUND-COLOR: #eff3fb">
		<td class="auto-style1" align="center">
            <img alt="" class="style8" src="images/page_find.gif" /></td>
		<td class="auto-style3">DMCS2 Implementation</td>
		<td align="right" class="auto-style1" style="BACKGROUND-COLOR: yellow">
		Yellow</td>
	</tr>
	<tr style="BACKGROUND-COLOR: white">
		<td class="auto-style1" align="center">
            <img alt="" class="style8" src="images/page_find.gif" /></td>
		<td class="auto-style3">Business Applications Inventory</td>
		<td align="right" class="auto-style1" style="BACKGROUND-COLOR: red">Red</td>
	</tr>
	<tr style="BACKGROUND-COLOR: #eff3fb">
		<td class="auto-style1" align="center">
            <img alt="" class="style8" src="images/page_find.gif" /></td>
		<td class="auto-style3">Servicer Recognition Program</td>
		<td align="right" class="auto-style1" style="BACKGROUND-COLOR: red">Red</td>
	</tr>
</table>


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
