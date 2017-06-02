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
            width: 322px;
            text-align: right;
        }
        .style4
        {
            width: 322px;
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
                                ACS Report Card</span><span class="style2"><br />
                                </span>
                            <br />
                                <table class="style1" cellpadding="4" cellspacing="4">
                                    <tr>
                                        <td class="style3">
                                            Report Date:</td>
                                        <td class="style9">
                                            <asp:TextBox ID="TextBox1" runat="server">02/03/12</asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;</td>
                                    </tr>
                                    <tr class="style6">
                                        <td class="style4">
                                            Measure</td>
                                        <td class="style5">
                                            Status</td>
                                        <td class="style8">
                                            Comments</td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Quarterly Surveys
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList1" runat="server">
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox13" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            MMR 
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList2" runat="server">
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox14" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Audit Results
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList3" runat="server">
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox15" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Call Monitoring 
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList4" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox16" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Process Monitoring
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList5" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox17" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Weekly meeting</td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList6" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox18" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
&nbsp;Liaison calls with Servicer
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList7" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox19" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Special Consolidations
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList8" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox20" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Change Management/Responses
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList9" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox21" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            Tracker Items</td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList10" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox22" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
&nbsp;BLOG comments
                                        </td>
                                        <td class="style9">
                                            <asp:DropDownList ID="DropDownList11" runat="server" 
                                                >
                                                <asp:ListItem>Green</asp:ListItem>
                                                <asp:ListItem>Yellow</asp:ListItem>
                                                
                                                <asp:ListItem>Red</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox23" runat="server" Width="400px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                            etc.</td>
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
