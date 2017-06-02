<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            lblTotalIMFs.Text = GetTotalIMFs().ToString()
            lblTotalOpenIMFs.Text = GetTotalOpenIMFs().ToString()
            lblTotalPendingIMFs.Text = GetTotalPendingIMFs().ToString()
            lblTotalClosedIMFs.Text = GetTotalClosedIMFs().ToString()
            lblTotalUnassigned.Text = GetTotalUnassignedIMFs().ToString()
            lblTotalRetracted.Text = GetTotalRetractedIMFs.ToString()
            lblTotalReturnedPCA.Text = GetTotalReturnedPCAIMFs.ToString()
        End If
    End Sub
    
    Private Function GetTotalIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalOpenIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalOpenIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalPendingIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalPendingIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
        
    Private Function GetTotalClosedIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalClosedIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalUnassignedIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalUnassignedIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalRetractedIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalRetractedIMFs", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    Private Function GetTotalReturnedPCAIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetTotalReturnedPCAIMFs", con)
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
    <title>IMF</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">

                      
                      <!--This one populates GetTotalAssignedByEDUser-->
                      <asp:SqlDataSource ID="dsGetTotalAssignedEDUser" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalAssignedEDUser" SelectCommandType="StoredProcedure" /> 
                            
                      <!--This one populates GetTotalOpenEDUser-->
                      <asp:SqlDataSource ID="dsGetTotalOpenEDUser" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalOpenEDUser" SelectCommandType="StoredProcedure" />
                            
                      <!--This one populates GetTotalByAgency-->
                            <asp:SqlDataSource ID="dsGetTotalByAgency" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalByAgency" SelectCommandType="StoredProcedure" />      
                            
                      <!--This one populates GetTotalByIMFType-->
                            <asp:SqlDataSource ID="dsGetTotalByIMFType" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalByIMFType" SelectCommandType="StoredProcedure" /> 
                            
                        <!--This one populates GetTotalAssignedByTeam-->
                            <asp:SqlDataSource ID="dsGetTotalAssignedByTeam" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="GetTotalAssignedByTeam" SelectCommandType="StoredProcedure" />                            
                                      
                        <table width="600">
					     <tr>
					        <td class="formLabelForm">Total Received: </td>
					        <td><asp:Label ID="lblTotalIMFs" runat="server" /></td>
                            <td class="formLabelForm">Total Unassigned: </td>
					        <td><a href="IMFs.Unassigned.aspx"><asp:Label ID="lblTotalUnassigned" runat="server" /></a></td>
					     </tr>
					      <tr>
					        <td class="formLabelForm">Total Open: </td>
					        <td><asp:Label ID="lblTotalOpenIMFs" runat="server" /></td>
                            <td class="formLabelForm">Total Retracted: </td>
					        <td><asp:Label ID="lblTotalRetracted" runat="server" /></td>
					     </tr>
                         <tr>
					        <td class="formLabelForm">Total Pending: </td>
					        <td><asp:Label ID="lblTotalPendingIMFs" runat="server" /></td>
                            <td class="formLabelForm">Total Returned to PCA: </td>
					        <td><asp:Label ID="lblTotalReturnedPCA" runat="server" /></td>
					     </tr>
					     <tr>
					        <td class="formLabelForm">Total Closed: </td>
					        <td colspan="3"><asp:Label ID="lblTotalClosedIMFs" runat="server" /></td>
					     </tr>		
					  						     
					     </table> 
					     <br />                     
                       
                      <fieldset>
                        <legend class="fieldsetLegend">IMF Summary</legend><br />	
                       
                       <table cellspacing="7" cellpadding="7">
                            <tr>
                                <td valign="top">
                                <!--First column ED Stats-->                                   			     
					     
					     <h4 class="pageHeader">Total By ED Employee</h4>		
							<table Width="500px" border="0">
							<tr>
							   <td align="left" valign="top">
							   <!--TotalAssignedEDUser-->
							   <asp:Repeater id="rptGetTotalAssignedEDUser" runat="server" DataSourceID="dsGetTotalAssignedEDUser">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>User name</b></td>
								         	<td><b>Total Assigned</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><a href="MyIMFs.ED.aspx?UserID=<%# Eval("UserID") %>&Username=<%# Eval("UserName") %>"><%# Eval("UserName") %></a></td>								               
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
							<asp:Repeater id="rptGetTotalOpenEDUser" runat="server" DataSourceID="dsGetTotalOpenEDUser">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>User name</b></td>
								         	<td><b>Open IMFs</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><a href="MyIMFs.ED.aspx?UserID=<%# Eval("UserID") %>&Username=<%# Eval("UserName") %>"><%# Eval("UserName") %></a></td>								               
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
							   <asp:Repeater id="rptGetTotalByAgency" runat="server" DataSourceID="dsGetTotalByAgency">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>PCA</b></td>
								         	<td><b>Total Submitted</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><a href="MyIMFs.PCA.aspx?AgencyID=<%#Eval("AgencyID")%>"><%#Eval("AgencyID")%></a></td>								               
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
                            <!--5th column Total by IMF Type-->
                            <h4>Total By IMF Type</h4>
							<table border="0">
							<tr>
							   <td align="left" valign="top">
							   <!--TotalByIMFType-->
							   <asp:Repeater id="rptGeTTotalByIMFType" runat="server" DataSourceID="dsGeTTotalByIMFType">
								      <HeaderTemplate>								         
								         <table width="100%" cellpadding="4" cellSpacing="1" border="0">
								         <tr>
								         	<td><b>IMF Type</b></td>
								         	<td><b>Total Submitted</b></td>								         	
								         </tr>           
								      </HeaderTemplate>
								      <ItemTemplate>
								            <tr>								               
								               <td><a href="IMFs.Type.ED.aspx?IMF_ID=<%#Eval("IMF_ID")%>"><%#Eval("IMF_Type")%></a></td>								               
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
							   <asp:Repeater id="rptGetTotalAssignedByTeam" runat="server" DataSourceID="dsGetTotalAssignedByTeam">
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
