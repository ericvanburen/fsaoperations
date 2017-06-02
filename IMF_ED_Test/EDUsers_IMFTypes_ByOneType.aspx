<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            Dim intIMF_ID As Integer = Context.Request.QueryString("IMF_ID")
            lblIMF_ID.Text = intIMF_ID
            
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
    
       
    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ED Users IMF Types By One Type</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
  
            <div id="MyIMFs">
                <asp:SqlDataSource ID="dsEDUsers_IMFTypes_ByOneType" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_EDUsers_IMFTypes_ByOneType" SelectCommandType="StoredProcedure"> 
                    <SelectParameters>
                        <asp:ControlParameter Name="IMF_ID" ControlID="lblIMF_ID" />
                    </SelectParameters>                       
                </asp:SqlDataSource>   
                
                <fieldset>
                <legend class="fieldsetLegend">Users Assigned to Work This IMF Type</legend><br />        
                             
                  <div align="center"> 
                   <asp:Panel ID="pnlMyIMFs" runat="server">
                 
                            <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsEDUsers_IMFTypes_ByOneType" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20">                           
                            
                            <EmptyDataTemplate>
                                    There are no users assigned to work this IMF type
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>                                                    
                                
                                 <asp:BoundField 
                                    DataField="IMF_Type" 
                                    HeaderText="IMF Type" 
                                    ItemStyle-CssClass="first" 
                                    SortExpression="IMF_Type" />

                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="User name" 
                                    SortExpression="Username" />
                                    
                                    <asp:BoundField 
                                    DataField="IsActive" 
                                    HeaderText="Is Active User?" 
                                    SortExpression="IsActive" />                                    
                                    
                                </Columns>                
                            </asp:GridView>
                        </div>  
                        </fieldset>                
                   </asp:Panel>
                   </div>         
                        
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />
<asp:Label ID="lblIMF_ID" runat="server" Visible="false" />    
 </form>
</body>
</html>
