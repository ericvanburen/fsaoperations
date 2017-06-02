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
        
        'Hide the Administrator links if the user is not an administrator
        If lblUserAdmin.Text = "True" Then
            hypAddSchool.Enabled = True
            hypUserManager.Enabled = True
        Else
            hypAddSchool.Enabled = False
            hypUserManager.Enabled = False
        End If
    End Sub
   
    
    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub
    
    Sub BindGridView()
        dsSearchOPEID.SelectParameters.Item("SchoolName").DefaultValue = txtSchoolName.Text
        GridView1.DataBind()
    End Sub
    
    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("search.OPEID.aspx")
    End Sub
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ability to Benefit Search OPE ID</title>
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
                                <li><a href="#tabs-1">Search For School OPE ID</a></li>                                
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
                                        <table width="100%" cellpadding="4" cellspacing="5" border="0">
                                                                                   
                                            <tr>
                                                <td valign="top">   
                                                <strong>School Name: </strong><br />
                                                <asp:TextBox ID="txtSchoolName" runat="server" /> 
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" /><br />
                                                <asp:RequiredFieldValidator ID="rfdbtnSearch" runat="server" Text="Please enter a school name" ControlToValidate="txtSchoolName" CssClass="warning" />                                      
                                                </td>
                                            </tr> 
                                        </table>

                                         <!--GridView1-->
                                        <asp:SqlDataSource ID="dsSearchOPEID" runat="server" ConnectionString="<%$ ConnectionStrings:ATBConnectionString %>"
                                            SelectCommand="p_SearchOPEID" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:Parameter Name="SchoolName" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>

                                        <!--GridView1 here-->
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
                                                <asp:BoundField DataField="SchoolName" HeaderText="School Name" SortExpression="SchoolName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
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
