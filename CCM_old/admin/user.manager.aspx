<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace = "CSV" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
        End If
    End Sub
    
    Protected Sub grdUsers_OnRowCommand1(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandArgument = "Insert" Then
            Dim txtUsername As TextBox = grdUsers.FooterRow.FindControl("txtUsername")
            Dim txtPassword As TextBox = grdUsers.FooterRow.FindControl("txtPassword")
            Dim ddlAdmin As DropDownList = grdUsers.FooterRow.FindControl("ddlAdmin")
            Dim ddlEnabled As DropDownList = grdUsers.FooterRow.FindControl("ddlEnabled")
            dsUserID.InsertParameters("Username").DefaultValue = txtUsername.Text
            dsUserID.InsertParameters("Password").DefaultValue = txtPassword.Text
            dsUserID.InsertParameters("Admin").DefaultValue = ddlAdmin.SelectedValue
            dsUserID.InsertParameters("Enabled").DefaultValue = ddlEnabled.SelectedValue
            dsUserID.Insert()
        End If
    End Sub
        
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Center Monitor Search</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>        
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
		                <img src="../images/fSA_logo.gif" alt="Federal Student Aid - Call Center Monitoring" /> 
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Administration</a></li>                                
                            </ul>
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="../logout.aspx">Log Out</a></li> 
                                    <li><a href="#">Reports</a>
                                    <ul>
                                       <li><a href="../report.calls.monitored.aspx">Calls Monitored</a></li> 
                                       <li><a href="../report.failed.calls.aspx">Failed Calls</a></li>
                                       <li><a href="../report.accuracy.report.aspx">Accuracy Report</a></li>
                                    </ul>
                                    </li>                                                          
                                    <li><a href="../search.aspx">Search</a></li>
                                 <li><a href="#">Administration</a>
                                <ul>
                                    <li><a href="call.centers.aspx">Call Centers</a></li>
                                    <li><a href="call.reasons.aspx">Call Reasons</a></li>
                                    <li><a href="concerns.aspx">Concerns</a></li>
                                    <li><a href="user.manager.aspx">User Manager</a></li>
                                </ul></li>
                                
                                <li><a href="#">Monitoring</a>
                                <ul>
                                    <li><a href="../formB.aspx">Form</a></li>
                                    <li><a href="../my.reviews.aspx">My Reviews</a></li>
                                </ul></li>                           
                          </ul>
                            </div>
                            <br /><br />                            
                            <div id="Div1">   
                            
                            <div class="pageSubHeader" align="left" style="padding-left: 20px">
                              <span>User Manager</span> 
                            </div>                       
                                                                                                              
                                  <!--Call Centers-->
                                    <asp:SqlDataSource ID="dsCallCenters" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />

                                    <!--Call Reason / Issues-->
                                    <asp:SqlDataSource ID="dsReasonCode" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_CallReasons" SelectCommandType="StoredProcedure" />

                                    <!--Concerns-->
                                    <asp:SqlDataSource ID="dsConcerns" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" />

                                   <!--Users/Evaluators-->
                                    <asp:SqlDataSource ID="dsUserID" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>" 
                                        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure"
                                        InsertCommand="INSERT INTO Users (Username, Password, Admin, Enabled) VALUES (@Username, @Password, @Admin, @Enabled)"
                                        UpdateCommand="UPDATE Users SET Username = @Username, Password = @Password, Admin = @Admin, Enabled = @Enabled WHERE UserID = @UserID">
                                        <InsertParameters>
                                            <asp:Parameter Name="UserName" Type="String" />
                                            <asp:Parameter Name="Password" Type="String" />
                                            <asp:Parameter Name="Admin" Type="Boolean" />
                                            <asp:Parameter Name="Enabled" Type="Boolean" />
                                            <asp:Parameter Name="UserID" Type="Int32" />
                                        </InsertParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="UserName" Type="String" />
                                            <asp:Parameter Name="Password" Type="String" />
                                            <asp:Parameter Name="Admin" Type="Boolean" DefaultValue="False" />
                                            <asp:Parameter Name="Enabled" Type="Boolean" DefaultValue="False" />
                                            <asp:Parameter Name="UserID" Type="Int32" />
                                        </UpdateParameters>
                                        </asp:SqlDataSource>

                                        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                        <ContentTemplate>                                        
                                        
                                        <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        <div id="divUsers" class="grid" align="center">
                                         <asp:GridView ID="grdUsers" runat="server" 
                                                AutoGenerateColumns="false" 
                                                DataKeyNames="UserID"  
                                                DataSourceID="dsUserID"
                                                OnRowCommand="grdUsers_OnRowCommand1"
                                                AllowSorting="true"                         
                                                CssClass="datatable" 
			                                    BorderWidth="1px" 
			                                    BackColor="White" 
			                                    GridLines="Horizontal"
                                                CellPadding="3" 
                                                BorderColor="#E7E7FF"
			                                    Width="900px" 
			                                    BorderStyle="None" 
			                                    ShowFooter="true">
			                                    <EmptyDataTemplate>
			                                        No records matched your search
			                                    </EmptyDataTemplate>
                                                <Columns>    
                                                    <asp:CommandField ButtonType="Image" ShowDeleteButton="False"  CancelImageUrl="~/images/cancel.gif" EditImageUrl="~/images/pencil.gif"
                                                    ShowEditButton="True" UpdateImageUrl="~/images/save.gif" CausesValidation="false" HeaderText=" " ItemStyle-HorizontalAlign="Left" />                                                                      
                                                   
                                                   <asp:TemplateField HeaderText="User Name" SortExpression="Username" ItemStyle-HorizontalAlign="Left">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblUsername" runat="server" Text='<%#Eval("Username") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:TextBox ID="txtUsername" runat="server" Text='<%#Bind("Username") %>' Width="175px" Font-Size="Small">
                                                </asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>                                                    
                                                    <asp:Button ID="btnInsert" runat="Server" Text="Add New User" CommandName="Insert" CommandArgument="Insert" UseSubmitBehavior="False" />  
                                                    User name: <asp:TextBox ID="txtUserName" runat="Server"  /><br />
                                                    <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtUsername" ErrorMessage="* Please enter a new user name" CssClass="warning" Display="Dynamic" />                                                    
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Password" SortExpression="Password" ItemStyle-HorizontalAlign="Left">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblPassword" runat="server" Text='<%#Eval("Password") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:TextBox ID="txtPassword" runat="server" Text='<%#Bind("Password") %>' Font-Size="Small" />                                               
                                                </EditItemTemplate>
                                                 <FooterTemplate>
                                                    Password: <asp:TextBox ID="txtPassword" runat="Server"  /><br />
                                                    <asp:RequiredFieldValidator ID="rf2" runat="server" ControlToValidate="txtPassword" ErrorMessage="* Please enter a new password" CssClass="warning" Display="Dynamic" />
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Admin?" SortExpression="Admin" ItemStyle-HorizontalAlign="Center">
                                                   <ItemTemplate>
                                                      <asp:DropDownList ID="ddlAdmin" runat="server" SelectedValue='<%#Bind("Admin")%>' Enabled="false">
                                                        <asp:ListItem Text="Yes" Value="True" />
                                                        <asp:ListItem Text="No" Value="False" />
                                                      </asp:DropDownList>                                                       
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlAdmin" runat="server" SelectedValue='<%#Bind("Admin")%>' Font-Size="Small">
                                                        <asp:ListItem Text="Yes" Value="True" />
                                                        <asp:ListItem Text="No" Value="False" />
                                                      </asp:DropDownList>                                           
                                                </EditItemTemplate>
                                                 <FooterTemplate>
                                                    <asp:DropDownList ID="ddlAdmin" runat="server" Font-Size="Small">
                                                        <asp:ListItem Text="Yes" Value="True" />
                                                        <asp:ListItem Text="No" Value="False" />
                                                      </asp:DropDownList>
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Enabled?" SortExpression="Enabled" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                      <asp:DropDownList ID="ddlEnabled" runat="server" SelectedValue='<%#Bind("Enabled")%>' Enabled="false">
                                                        <asp:ListItem Text="Yes" Value="True" />
                                                        <asp:ListItem Text="No" Value="False" />
                                                      </asp:DropDownList>                                                       
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlEnabled" runat="server" SelectedValue='<%#Bind("Enabled")%>' Font-Size="Small">
                                                        <asp:ListItem Text="Yes" Value="True" />
                                                        <asp:ListItem Text="No" Value="False" />
                                                      </asp:DropDownList>                                           
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlEnabled" runat="server" Font-Size="Small">
                                                        <asp:ListItem Text="Yes" Value="True" />
                                                        <asp:ListItem Text="No" Value="False" />
                                                      </asp:DropDownList>                                                      
                                                </FooterTemplate>
                                                </asp:TemplateField> 

                                                </Columns>
                                                <RowStyle CssClass="row" />
                                                <AlternatingRowStyle CssClass="rowalternate" />
                                                
                                                <HeaderStyle CssClass="gridcolumnheader" />
                                                <EditRowStyle CssClass="gridEditRow" />       
                                </asp:GridView><br />       
                            </div>
                         </div>

                                        </ContentTemplate>
                                        </asp:UpdatePanel>
                    </div>
                    
                    </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />
    
          
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
    </form>
</body>
</html>
