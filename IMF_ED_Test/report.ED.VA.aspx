<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            lblTotalVAIMFs.Text = GetTotalVAIMFs().ToString()
            lblTotalOpenVAIMFs.Text = GetTotalOpenVAIMFs().ToString()
            lblTotalClosedVAIMFs.Text = GetTotalClosedVAIMFs().ToString()
            lblTotalUnassigned.Text = GetTotalUnassignedVAIMFs().ToString()
            
        End If
    End Sub
    
    Private Function GetTotalVAIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalVAIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalOpenVAIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalOpenVAIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalClosedVAIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalClosedVAIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalUnassignedVAIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalUnassignedVAIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VA App Summary</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">

                      
                      <!--This one populates GetTotalAssignedByEDUser-->
                      <asp:SqlDataSource ID="dsGetTotalAssignedEDUser_VA" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalAssignedEDUser_VA" SelectCommandType="StoredProcedure" /> 
                            
                      <!--This one populates GetTotalOpenEDUser-->
                      <asp:SqlDataSource ID="dsGetTotalOpenEDUser_VA" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalOpenEDUser_VA" SelectCommandType="StoredProcedure" />
                            
                      <!--This one populates GetTotalByAgency-->
                            <asp:SqlDataSource ID="dsGetTotalByAgency_VA" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalByAgency_VA" SelectCommandType="StoredProcedure" />      
                            
                      <!--This one populates GetTotalByIMFType-->
                            <asp:SqlDataSource ID="dsGetTotalByIMFType_VA" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalByIMFType_VA" SelectCommandType="StoredProcedure" /> 
                            
                        <!--This one populates GetTotalAssignedByTeam-->
                            <asp:SqlDataSource ID="dsGetTotalAssignedByTeam_VA" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalAssignedByTeam_VA" SelectCommandType="StoredProcedure" />                            
                                      
                        <table>
					     <tr>
					        <td class="formLabelForm">Total Received: </td>
					        <td><asp:Label ID="lblTotalVAIMFs" runat="server" /></td>
					     </tr>
					      <tr>
					        <td class="formLabelForm">Total Open: </td>
					        <td><asp:Label ID="lblTotalOpenVAIMFs" runat="server" /></td>
					     </tr>
					     <tr>
					        <td class="formLabelForm">Total Closed: </td>
					        <td><asp:Label ID="lblTotalClosedVAIMFs" runat="server" /></td>
					     </tr>		
					     <tr>
					        <td class="formLabelForm">Total Unassigned: </td>
					        <td><asp:Label ID="lblTotalUnassigned" runat="server" /></td>
					     </tr>						     
					     </table> 
					     <br />                     
                       
                      <fieldset>
                        <legend class="fieldsetLegend">VA App Summary</legend><br />	
                       
                       <table cellspacing="7" cellpadding="7">
                            <tr>
                                <td valign="top">
                                <!--First column ED Stats-->                                   			     
					     
					     <h4 class="pageHeader">Total By ED Employee</h4>		
							<table Width="500px" border="0">
							<tr>
							   <td align="left" valign="top">
							   <!--TotalAssignedEDUser-->
							   <asp:Repeater id="rptGetTotalAssignedEDUser" runat="server" DataSourceID="dsGetTotalAssignedEDUser_VA">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>User name</b></td>
								         	<td><b>Total Assigned</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><a href="MyVAApps.ED.aspx?UserID=<%# Eval("UserID") %>&Username=<%# Eval("UserName") %>"><%# Eval("UserName") %></a></td>								               
								               <td align="center"><%# Eval("TotalAssignedByEDUser") %></td>
                          	                </tr>
                          	            <tr>
                          	                <td colspan="2"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                          	            </tr>
								      </ItemTemplate>
								      <FooterTemplate>
								         </table>
								      </FooterTemplate>
							</asp:Repeater>
							  
							 <br />
							<!--TotalOpenByEDUser-->								     							
							<asp:Repeater id="rptGetTotalOpenEDUser" runat="server" DataSourceID="dsGetTotalOpenEDUser_VA">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>User name</b></td>
								         	<td><b>Open VA Apps</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><a href="MyVAApps.ED.aspx?UserID=<%# Eval("UserID") %>&Username=<%# Eval("UserName") %>"><%# Eval("UserName") %></a></td>								               
								               <td align="center"><%# Eval("TotalOpenByEDUser") %></td>
                          	                </tr>
                          	            <tr>
                          	                <td colspan="2"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                          	            </tr>
								      </ItemTemplate>
								      <FooterTemplate>
								         </table>
								      </FooterTemplate>
							</asp:Repeater>
				
							    </td>    
							</tr>
							</table>                                            
                                </td>
                                
                                <td valign="top" width="1" style="border-left: 1px solid black; padding: 5px;">
                                <!--2nd column - spacer column-->
                                <br />                                                       
                                </td>                               
                              <td valign="top">
                                <!--Third column PCA Stats-->                       
					     
					     <h4>Total By PCA</h4>		
							<table Width="200px" border="0">
							<tr>
							   <td align="left" valign="top">
							   <!--TotalAssignedEDUser-->
							   <asp:Repeater id="rptGetTotalByAgency" runat="server" DataSourceID="dsGetTotalByAgency_VA">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>Agency</b></td>
								         	<td><b>Total Submitted</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><%# Eval("GA_Name")%></td>								               
								               <td align="center"><%#Eval("TotalByAgency")%></td>
                          	            </tr>
                          	            <tr>
                          	                <td colspan="2"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                          	            </tr>
								      </ItemTemplate>
								      <FooterTemplate>
								         </table>
								      </FooterTemplate>
							</asp:Repeater>
							    </td>							    
							</tr>
							</table>                     
                           </td>
                           
                           <td valign="top" width="1" style="border-left: 1px solid black; padding: 5px;">
                                <!--4th column - spacer column-->
                                <br />                                                       
                           </td> 
                           
                           <td valign="top">
                            <!--5th column Total by Status-->
                            <h4>Total By Status</h4>
							<table border="0">
							<tr>
							   <td align="left" valign="top">
							   <!--TotalByIMFType-->
							   <asp:Repeater id="rptGeTTotalByIMFType" runat="server" DataSourceID="dsGeTTotalByIMFType_VA">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>Status</b></td>
								         	<td><b>Total Submitted</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><%#Eval("Status")%></td>								               
								               <td align="center"><%#Eval("TotalByIMFType")%></td>
                          	            </tr>
                          	            <tr>
                          	                <td colspan="2"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                          	            </tr>
								      </ItemTemplate>
								      <FooterTemplate>
								         </table>
								      </FooterTemplate>
							</asp:Repeater>
							    </td>							    
							</tr>
							</table>		
							
							<td valign="top" width="1" style="border-left: 1px solid black; padding: 5px;">
                                <!--6th column - spacer column-->
                                <br />                                                       
                           </td> 
                           
                           <td valign="top">
                            <!--7th column Total by IMF Type-->
                            <h4>Total By Team</h4>
							<table border="0">
							<tr>
							   <td align="left" valign="top">
							   <!--TotalByTeam-->
							   <asp:Repeater id="rptGetTotalAssignedByTeam" runat="server" DataSourceID="dsGetTotalAssignedByTeam_VA">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>Team Name</b></td>
								         	<td><b>Total Assigned</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><%#Eval("Team_Name")%></a></td>								               
								               <td align="center"><%#Eval("TotalAssignedByTeam")%></td>
                          	            </tr>
                          	            <tr>
                          	                <td colspan="2"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                          	            </tr>
								      </ItemTemplate>
								      <FooterTemplate>
								         </table>
								      </FooterTemplate>
							</asp:Repeater>
							    </td>							    
							</tr>
							</table>				
                                
                                                                
                           </td>      
                            </tr>
                       </table>
                     </fieldset>
                       
                    
                       
    
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblEDUserName" runat="server" Visible="false" />
    </form>
</body>
</html>
