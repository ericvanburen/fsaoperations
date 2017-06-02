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
        .style1
        {
            width: 100%;
        }
        .style2
        {
            font-size: large;
        }
        .style3
        {
            width: 582px;
            text-align: left;
        }
        .style4
        {
            width: 582px;
            text-align: center;
            height: 28px;
            font-weight: bold;
            text-decoration: underline;
        }
        .style5
        {
            height: 28px;
            font-weight: bold;
            text-decoration: underline;
            text-align: center;
            width: 86px;
        }
        .style6
        {
            font-size: medium;
        }
        .style7
        {
            font-size: xx-large;
        }
        .style8
        {
            height: 28px;
            font-weight: bold;
            text-decoration: underline;
        }
        .style9
        {
            width: 86px;
        }
        .style10
        {
            width: 250px;
            height: 145px;
        }
        .style11
        {
            width: 256px;
            height: 63px;
        }
        .style12
        {
            width: 202px;
            height: 83px;
        }
        .style13
        {
            width: 582px;
            text-align: left;
            height: 28px;
        }
        .style14
        {
            width: 86px;
            height: 28px;
        }
        .style15
        {
            height: 28px;
        }
        .style16
        {
            width: 247px;
            height: 201px;
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
                                <li><a href="#tabs-1">TIVA Dashboard</a></li>                               
                            </ul>
                                <span class="style7">
                                <br />
                                Servicer Report Card</span><span class="style2"><br />
                                </span>
                            <br />
                                <table class="style1" cellpadding="4" cellspacing="4">
                                    <tr>
                                        <td colspan="3">
                                        Select Servicer: 
                                        <asp:DropDownList ID="ddlServicer" runat="server">
                                            <asp:ListItem Text="ACS" Value="ACS" />
                                            <asp:ListItem Text="SallieMae" Value="SallieMae" />
                                        </asp:DropDownList>
                                        Select 
                                            Report Date:
                                        <asp:DropDownList ID="ddlBeginDate" runat="server" Width="100px">
                                            <asp:ListItem Text="02/03/12" Value="11/20/11" Selected="True" />
                                            <asp:ListItem Text="11/27/11" Value="11/27/11" />
                                            <asp:ListItem Text="12/04/11" Value="12/04/11" />
                                            <asp:ListItem Text="12/11/11" Value="12/11/11" />
                                            <asp:ListItem Text="12/18/11" Value="12/18/11" />
                                            <asp:ListItem Text="12/25/11" Value="12/25/11" />
                                            <asp:ListItem Text="01/01/12" Value="01/01/12" />
                                        </asp:DropDownList>
                                            &nbsp;</td>
                                    </tr>
                                    <tr class="style6">
                                        <td class="style4">
                                            Report by Servicer<br />
                                            <img alt="" class="style10" src="images/byservicer.png" /></td>
                                        <td class="style5">
                                            &nbsp;</td>
                                        <td class="style8">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                        Select 
                                            Measure: 
                                        <asp:DropDownList ID="ddlServicer0" runat="server" Width="183px">
                                            <asp:ListItem Text="Quarterly Reviews" Value="Quarterly Reviews" />
                                        </asp:DropDownList>
                                        &nbsp;Select 
                                            Report Date:
                                        <asp:DropDownList ID="ddlBeginDate0" runat="server" Width="100px">
                                            <asp:ListItem Text="11/20/11" Value="11/20/11" Selected="True" />
                                            <asp:ListItem Text="11/27/11" Value="11/27/11" />
                                            <asp:ListItem Text="12/04/11" Value="12/04/11" />
                                            <asp:ListItem Text="12/11/11" Value="12/11/11" />
                                            <asp:ListItem Text="12/18/11" Value="12/18/11" />
                                            <asp:ListItem Text="12/25/11" Value="12/25/11" />
                                            <asp:ListItem Text="01/01/12" Value="01/01/12" />
                                        </asp:DropDownList>
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            <img alt="" class="style11" src="images/bymeasure.png" />&nbsp;
                                            <img alt="" class="style12" src="images/bymeasure2.png" /></td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style13">
                                            <img alt="" class="style16" src="images/byservicergroup.png" /></td>
                                        <td class="style14">
                                        </td>
                                        <td class="style15">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            &nbsp;</td>
                                        <td class="style9">
                                            &nbsp;</td>
                                        <td>
                                            &nbsp;</td>
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
