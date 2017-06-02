<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'First check for a valid, logged in user
        Dim chkLogin As New CheckLogin
        lblUserID.Text = chkLogin.CheckLogin()
             
        If Not Request.Cookies("ATB") Is Nothing Then
            lblUserAdmin.Text = Request.Cookies("ATB")("Admin").ToString()
        End If
        
        If Not Request.QueryString("OPEID") Is Nothing Then
            lblOPEID.Text = Request.QueryString("OPEID").ToString()
            BindGridView()
        End If
        
        'Hide the Administrator links if the user is not an administrator
        If lblUserAdmin.Text = "True" Then
            hypAddSchool.Enabled = True
            hypUserManager.Enabled = True
        Else
            hypAddSchool.Enabled = False
            hypUserManager.Enabled = False
        End If
    End Sub
       
    Sub BindGridView()
        dsSearchOPEID.SelectParameters.Item("OPEID").DefaultValue = lblOPEID.Text
        GridView1.DataBind()
    End Sub
    
   
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ability to Benefit All Schools For a Given OPE ID</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

     <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
     <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
     <script src="Scripts/menu.js" type="text/javascript"></script>
         
     <script type="text/javascript">
            $(function () {
                $("#tabs").tabs();
            });
	</script>	
        
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
		                 <img src="images/fSA_logo.gif" alt="Federal Student Aid - Ability to Benefit (ATB)" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">All Schools For a Given OPE ID</a></li>                                
                            </ul>
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="logout.aspx">Log Out</a></li>
                                    <li><a href="#">Administration</a>
                                <ul>
                                    <li><asp:HyperLink ID="hypAddSchool" runat="server" Text="Add School ATB Findings" NavigateUrl="admin/add.school.aspx" /></li>
                                    <li><asp:HyperLink ID="hypUserManager" runat="server" Text="User Manager" NavigateUrl="admin/user.manager.aspx" /></li>
                                </ul></li>                       
                                    <li><a href="search.OPEID.aspx">Search For OPE IDs</a></li>
                                    <li><a href="search.ATB.aspx">Search ATB Findings</a></li>  
                          </ul>
                            </div>
                            <br /><br />

                            <asp:UpdatePanel ID="pnl1" runat="server">
                            <ContentTemplate>
                               <div id="Div1">   

                                    <div align="left" style="padding-top: 10px" id="tabs-1"> 
                                    <p> </p>                                   
                                        

                                         <!--GridView1-->
                                        <asp:SqlDataSource ID="dsSearchOPEID" runat="server" ConnectionString="<%$ ConnectionStrings:ATBConnectionString %>"
                                            SelectCommand="p_AllScholsOPEID" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:Parameter Name="OPEID" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <!--GridView1 here-->
                                        <h3>All Locations For OPE ID: <asp:Label ID="lblOPEID" runat="server" Visible="true" /></h3>
                                        <div id="dvGrid" class="grid" align="center">               
                                            <asp:GridView ID="GridView1" runat="server" 
                                            AutoGenerateColumns="false" 
                                            AllowSorting="true" 
                                            DataSourceID="dsSearchOPEID" 
                                            AllowPaging="true" 
                                            PageSize="25"                       
                                            CssClass="datatable" 
			                                BorderWidth="1px" 
			                                DataKeyNames="OPEID"
			                                BackColor="White" 
			                                GridLines="Horizontal"
                                            CellPadding="3" 
                                            BorderColor="#E7E7FF"
			                                Width="875px"
			                                BorderStyle="None" 
			                                ShowFooter="false">
			                                <EmptyDataTemplate>
			                                    No school names match your search
			                                </EmptyDataTemplate>
                                            <Columns>                                                                                 
                                                <asp:TemplateField HeaderText="OPE ID" SortExpression="OPEID">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="lnkOPEID" runat="server" NavigateUrl='<%# Eval("OPEID", "search.ATB.aspx?OPEID={0}") %>' Text='<%# Eval("OPEID") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="SchName" HeaderText="School Name" SortExpression="SchName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="LocName" HeaderText="Location" SortExpression="LocName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Line1Adr" HeaderText="Address Line 1" SortExpression="Line1Adr" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Line2Adr" HeaderText="Address Line 2" SortExpression="Line2Adr" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="Zip" HeaderText="Zip" SortExpression="Zip" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                            </Columns>
                                            <RowStyle CssClass="row" />
                                            <AlternatingRowStyle CssClass="rowalternate" />
                                            <FooterStyle CssClass="gridcolumnheader" />
                                            <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                                            <HeaderStyle CssClass="gridcolumnheader" />
                                            <EditRowStyle CssClass="gridEditRow" />       
                                        </asp:GridView>
                                        </div>

                                        </div>
                            </div>
                            </ContentTemplate>
                            </asp:UpdatePanel>
                            
                            
                    
      </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />
    
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblUserAdmin" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
   
    </form>
</body>
</html>
