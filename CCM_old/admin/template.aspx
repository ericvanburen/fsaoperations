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
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Call Center Monitor Search</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>        
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
                    <td>
		                <h2 class="demoHeaders">Call Center Monitoring User Manager</h2>
                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Search</a></li>                                
                            </ul>
                            <div id="menu" align="right" style="padding-right: 10px; padding-top: 5px; color: Blue; font-size: small">
                                 <a href="formB.aspx">Call Monitoring B</a> | <a href="formC.aspx">Call Monitoring C</a> | <a href="#">Reports</a> | <a href="logout.aspx">Log Out</a>
                            </div>                            
                            <div id="Div1">                          
                                                                                                              
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
                                        InsertCommand="INSERT INTO Users (Usename, Password, Admin, Enabled) VALUES (@Username, @Password, @Admin, @Enabled)"
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
                                            <asp:Parameter Name="Admin" Type="Boolean" />
                                            <asp:Parameter Name="Enabled" Type="Boolean" />
                                            <asp:Parameter Name="UserID" Type="Int32" />
                                        </UpdateParameters>
                                        </asp:SqlDataSource>

                                    <div align="left" style="padding-top: 10px" id="tabs-1">
                                        
                                        <div id="divUsers" class="grid" align="center">
                                         <asp:GridView ID="grdVariablePeriod" runat="server" 
                                                AutoGenerateColumns="false" 
                                                DataKeyNames="UserID"  
                                                DataSourceID="dsUserID"
                                                AllowSorting="false"                         
                                                CssClass="datatable" 
			                                    BorderWidth="1px" 
			                                    BackColor="White" 
			                                    GridLines="Horizontal"
                                                CellPadding="3" 
                                                BorderColor="#E7E7FF"
			                                    Width="900px" 
			                                    BorderStyle="None" 
			                                    ShowFooter="false">
			                                    <EmptyDataTemplate>
			                                        No records matched your search
			                                    </EmptyDataTemplate>
                                                <Columns>       
                                                   <asp:CommandField ShowDeleteButton="False" ShowEditButton="True" />                                                                      
                                                    <asp:BoundField DataField="Username" HeaderText="User name" SortExpression="Username" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="Password" HeaderText="Password" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:BoundField DataField="Admin" HeaderText="Admin?" SortExpression="Admin" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" /> 
                                                    <asp:BoundField DataField="Enabled" HeaderText="Enabled?" SortExpression="Enabled" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />                            
                                                <asp:TemplateField>
                                                <EditItemTemplate>
                                                    
                                                </EditItemTemplate>
                                                </asp:TemplateField>
                                                </Columns>
                                                <RowStyle CssClass="row" />
                                                <AlternatingRowStyle CssClass="rowalternate" />
                                                <FooterStyle CssClass="gridcolumnheader" />
                                                <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                                                <HeaderStyle CssClass="gridcolumnheader" />
                                                <EditRowStyle CssClass="gridEditRow" />       
                                </asp:GridView><br />
       
        </div>
                                        
                                    </div>
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
