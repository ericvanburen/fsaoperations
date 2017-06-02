<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
--%><%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED only page - Call Check ED Login Status
            CheckEDLogin()
            
            'If we pass a userID and username to this page, then use those to look up the individuals IMFs
            'Otherwise use the cookie values set when the ED employee logged in
            If Not IsNothing(Request.QueryString("UserID")) Then
                Dim intEDUserID As String = Request.QueryString("UserID").ToString()
                Dim strUsername As String = Request.QueryString("Username").ToString()
                
                lblEDUserID.Text = intEDUserID
                lblEDUserName.Text = strUsername
            Else
                If Not IsNothing(Request.Cookies("IMF")) Then
                    lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                    lblEDUserName.Text = (Request.Cookies("IMF")("EDUserName").ToString())
                End If
            End If
        End If
    End Sub
    
    Protected Sub ddlIMF_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        
        GridView1.DataSourceID = "dsEDUsers_IMFTypes_ByOneType"
        GridView1.DataBind()
        
    End Sub
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ED Users IMF Types By Type</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
  
            <div id="MyIMFs">
            
            <!--This one populates the IMF Type dropdown-->
                    <asp:SqlDataSource ID="dsIMFTypes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_IMFTypes" SelectCommandType="StoredProcedure" />    
                            
                            <asp:SqlDataSource ID="dsEDUsers_IMFTypes_ByOneType" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                                SelectCommand="p_EDUsers_IMFTypes_ByOneType" SelectCommandType="StoredProcedure"> 
                                    <SelectParameters>
                                        <asp:ControlParameter Name="IMF_ID" ControlID="ddlIMF_Type" DefaultValue="1" />
                                    </SelectParameters>                       
                                </asp:SqlDataSource>   
            
                <asp:SqlDataSource ID="dsEDUsers_IMFTypes_ByType" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_EDUsers_IMFTypes_ByType" SelectCommandType="StoredProcedure">                        
                </asp:SqlDataSource>   
                
                <fieldset>
                <legend class="fieldsetLegend">Users Assigned to Work Each IMF Type</legend><br />        
                             
                  <div align="center"> 
                   <asp:Panel ID="pnlMyIMFs" runat="server">
                 
                                    <asp:DropDownList id="ddlIMF_Type" Runat="Server"
                                        DataSourceID="dsIMFTypes"
                                        DataTextField="IMF_Type" 
                                        DataValueField="IMF_ID" 
                                        AppendDataBoundItems="true" AutoPostBack="true" 
                                        CssClass="formLabel" onselectedindexchanged="ddlIMF_Type_SelectedIndexChanged"> 
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                                        ControlToValidate="ddlIMF_Type" Display="Dynamic" CssClass="warningMessage"
                                        Text="Please select an IMF type"
                                        Runat="Server" />
                            
                            <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsEDUsers_IMFTypes_ByOneType" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                           AllowSorting="true">                           
                            
                            <EmptyDataTemplate>
                                    There are no IMFs types assigned to anyone
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                                                                
                                    
                                    <asp:HyperLinkField 
                                    DataTextField="Username" 
                                    HeaderText="User Name" 
                                    DataNavigateUrlFields="UserID" 
                                    SortExpression="Username" 
                                    DataNavigateUrlFormatString="Maintenance.ED.Users.aspx?UserID={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>
                                    
                                    <asp:BoundField 
                                    DataField="IsActive" 
                                    HeaderText="Is Active User?" 
                                    SortExpression="IsActive" />  
                                    
                                    <asp:BoundField 
                                    DataField="Team_Name" 
                                    HeaderText="Team Name" 
                                    SortExpression="Team_Name" />     
                                    
                                    <asp:BoundField 
                                    DataField="AG" 
                                    HeaderText="AG" 
                                    SortExpression="AG" />                                    
                                    
                                </Columns>                
                            </asp:GridView>
                        </div>  
                        </fieldset>                
                   </asp:Panel>
                   </div>         
                        
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />    
 </form>
</body>
</html>
