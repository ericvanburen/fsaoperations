<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED only page - Call Check ED Login Status
            CheckEDLogin()
        End If
    End Sub
    
    Protected Sub ddlUserList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        
        GridView1.DataSourceID = "dsLogins_ByUser"
        GridView1.DataBind()
        
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " Logins"
    End Sub
    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Login Totals</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
            
            <!--This one populates the All Users dropdown-->
            <asp:SqlDataSource ID="dsLogins_UserList" runat="server" OnSelected="OnSelectedHandler" 
             ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
             SelectCommand="p_Logins_UserList" SelectCommandType="StoredProcedure" />    
                            
            <asp:SqlDataSource ID="dsLogins_ByUser" runat="server" OnSelected="OnSelectedHandler" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
            SelectCommand="p_Logins_ByUser" SelectCommandType="StoredProcedure"> 
            <SelectParameters>
                 <asp:ControlParameter Name="Username" ControlID="ddlUserList" DefaultValue="578" />
            </SelectParameters>                       
            </asp:SqlDataSource>   
            
            <asp:SqlDataSource ID="dsLoginsAll" runat="server" OnSelected="OnSelectedHandler"
            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
            SelectCommand="p_LoginsAll" SelectCommandType="StoredProcedure">                        
            </asp:SqlDataSource>   
                
                <fieldset>
                <legend class="fieldsetLegend">User Logins</legend><br />        
                             
                  <div align="center"> 
                   <asp:Panel ID="pnlMyIMFs" runat="server">
                 
                                    <asp:DropDownList id="ddlUserList" Runat="Server"
                                        DataSourceID="dsLogins_UserList"
                                        DataTextField="Username" 
                                        DataValueField="Username" 
                                        AppendDataBoundItems="true" AutoPostBack="true" 
                                        CssClass="formLabel" onselectedindexchanged="ddlUserList_SelectedIndexChanged"> 
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                                        ControlToValidate="ddlUserList" Display="Dynamic" CssClass="warningMessage"
                                        Text="Please select an User"
                                        Runat="Server" />
                            
                            <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                            <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsLoginsAll" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                           AllowSorting="true">                           
                            
                            <EmptyDataTemplate>
                                    There are no logins for this user
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                                                                
                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="Username"
                                    ItemStyle-CssClass="first" 
                                    SortExpression="Username" />                           
                                  
                                    <asp:BoundField 
                                    DataField="LoginDate" 
                                    HeaderText="Login Date" 
                                    SortExpression="LoginDate" />
                                    
                                    <asp:BoundField 
                                    DataField="LoginSuccessful" 
                                    HeaderText="Login Successful?" 
                                    SortExpression="LoginSuccessful" />  
                                    
                                    <asp:BoundField 
                                    DataField="IP" 
                                    HeaderText="IP Address" 
                                    SortExpression="IP" />                                  
                                    
                                </Columns>                
                            </asp:GridView>
                        </div>  
                        </fieldset>                
                   </asp:Panel>
                        
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />    
 </form>
</body>
</html>
