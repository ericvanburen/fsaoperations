<%@ Page Language="VB" Inherits="MyBaseClass" EnableEventValidation="false" src="../classes/MyBaseClass.vb" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        'If Not IsPostBack Then
        'ED and PCA page - Call Check Login Status
        'CheckPCALogin()
        
        Dim strAgency As String = Request.QueryString("AG")
        If strAgency IsNot Nothing Then
            lblAgency.Text = strAgency.ToString()
            lblAgencyNo.Text = strAgency.ToString()
        End If
       
        Dim dteBeginDate As String = Request.QueryString("BeginDate")
        If dteBeginDate IsNot Nothing Then
            txtBeginDate.Text = Server.UrlDecode(dteBeginDate.ToString())
        End If
            
        Dim dteEndDate As String = Request.QueryString("EndDate")
        If dteEndDate IsNot Nothing Then
            txtEndDate.Text = Server.UrlDecode(dteEndDate.ToString())
        End If
                
        lblFileTransmissionDate.Text = Date.Today
        lblCreationDate.Text = Date.Today()
        lblSignatureDate.Text = Date.Today()
        lblTodaysDate.Text = Date.Today()
        
        RecordCount()
            
        SSU_Page1()
       
        lblDEACount.Text = RecordCount_DEA(strAgency, txtBeginDate.Text, txtEndDate.Text).ToString()
        
    End Sub
    
    Sub RecordCount()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SSU_Count_DEA"
        
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Int).Value = lblAgency.Text
        cmd.Parameters.AddWithValue("@BeginDate", SqlDbType.DateTime).Value = txtBeginDate.Text
        cmd.Parameters.AddWithValue("@EndDate", SqlDbType.DateTime).Value = txtEndDate.Text
        
        Try
            Dim intSSU_Count As Integer = 0
            con.Open()
            dr = cmd.ExecuteReader()
            While dr.Read()
                intSSU_Count = dr("SSU_Count")
            End While
            
            If intSSU_Count >= 51 Then
                SSU_Page2()
            End If
        
            If intSSU_Count >= 101 Then
                SSU_Page3()
            End If
            
            If intSSU_Count >= 151 Then
                SSU_Page4()
            End If
            
            lblEFTApprovedCount.Text = intSSU_Count.ToString()
            
        Finally
            dr.Close()
            con.Close()
        End Try
    End Sub
    
    Public Shared Function RecordCount_DEA(ByVal Agency As String, ByVal BeginDate As Date, ByVal EndDate As Date) As String
        Dim result As String = String.Empty
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)

        Dim cmd As New SqlCommand("p_SSU_Count_DEA", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Int).Value = Agency
        cmd.Parameters.AddWithValue("@BeginDate", SqlDbType.DateTime).Value = BeginDate
        cmd.Parameters.AddWithValue("@EndDate", SqlDbType.DateTime).Value = EndDate
        Using con
            con.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                result = CType(reader("SSU_Count"), String)
            End If
        End Using
        Return result
    End Function
           
       
    Sub SSU_Page1()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SSU_Paging_DEA"
        
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@StartRow", SqlDbType.Int).Value = 0
        cmd.Parameters.AddWithValue("@EndRow", SqlDbType.Int).Value = 51
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Int).Value = lblAgency.Text
        cmd.Parameters.AddWithValue("@BeginDate", SqlDbType.DateTime).Value = txtBeginDate.Text
        cmd.Parameters.AddWithValue("@EndDate", SqlDbType.DateTime).Value = txtEndDate.Text
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            rptSSU1.DataSource = dr
            rptSSU1.DataBind()
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub SSU_Page2()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        'strSQL = "p_SSU"
        strSQL = "p_SSU_Paging_DEA"
        
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@StartRow", SqlDbType.Int).Value = 50
        cmd.Parameters.AddWithValue("@EndRow", SqlDbType.Int).Value = 101
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Int).Value = lblAgency.Text
        cmd.Parameters.AddWithValue("@BeginDate", SqlDbType.DateTime).Value = txtBeginDate.Text
        cmd.Parameters.AddWithValue("@EndDate", SqlDbType.DateTime).Value = txtEndDate.Text
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            rptSSU2.DataSource = dr
            rptSSU2.DataBind()
            rptSSU2.Visible = True
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub SSU_Page3()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        'strSQL = "p_SSU"
        strSQL = "p_SSU_Paging_DEA"
        
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@StartRow", SqlDbType.Int).Value = 100
        cmd.Parameters.AddWithValue("@EndRow", SqlDbType.Int).Value = 151
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Int).Value = lblAgency.Text
        cmd.Parameters.AddWithValue("@BeginDate", SqlDbType.DateTime).Value = txtBeginDate.Text
        cmd.Parameters.AddWithValue("@EndDate", SqlDbType.DateTime).Value = txtEndDate.Text
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            rptSSU3.DataSource = dr
            rptSSU3.DataBind()
            rptSSU3.Visible = True
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub SSU_Page4()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SSU_Paging_DEA"
        
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@StartRow", SqlDbType.Int).Value = 150
        cmd.Parameters.AddWithValue("@EndRow", SqlDbType.Int).Value = 201
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Int).Value = lblAgency.Text
        cmd.Parameters.AddWithValue("@BeginDate", SqlDbType.DateTime).Value = txtBeginDate.Text
        cmd.Parameters.AddWithValue("@EndDate", SqlDbType.DateTime).Value = txtEndDate.Text
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            rptSSU4.DataSource = dr
            rptSSU4.DataBind()
            rptSSU4.Visible = True
        Finally
            con.Close()
        End Try
    End Sub
    
        
    Protected Sub rptSSU2_OnItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)
        Dim lblAgency2 As Label = rptSSU2.Controls(0).Controls(0).FindControl("lblAgency2")
        lblAgency2.Text = lblAgency.Text
        
        Dim lblTodaysDate2 As Label = rptSSU2.Controls(0).Controls(0).FindControl("lblTodaysDate2")
        lblTodaysDate2.Text = Date.Today()
    End Sub
    
    Protected Sub rptSSU3_OnItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)
        Dim lblAgency3 As Label = rptSSU3.Controls(0).Controls(0).FindControl("lblAgency3")
        lblAgency3.Text = lblAgency.Text
        
        Dim lblTodaysDate3 As Label = rptSSU3.Controls(0).Controls(0).FindControl("lblTodaysDate3")
        lblTodaysDate3.Text = Date.Today()
    End Sub
    
    Protected Sub rptSSU4_OnItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)
        Dim lblAgency4 As Label = rptSSU4.Controls(0).Controls(0).FindControl("lblAgency4")
        lblAgency4.Text = lblAgency.Text
        
        Dim lblTodaysDate4 As Label = rptSSU4.Controls(0).Controls(0).FindControl("lblTodaysDate4")
        lblTodaysDate4.Text = Date.Today()
    End Sub
    
    Dim intRowNumber1 As Integer = 0
    Dim intRowNumber2 As Integer = 50
    Dim intRowNumber3 As Integer = 100
    Dim intRowNumber4 As Integer = 150
    
    Protected Function RowNumber1() As String
        intRowNumber1 += 1
        Return intRowNumber1.ToString()
    End Function
    
    Protected Function RowNumber2() As String
        intRowNumber2 += 1
        Return intRowNumber2.ToString()
    End Function
    
    Protected Function RowNumber3() As String
        intRowNumber3 += 1
        Return intRowNumber3.ToString()
    End Function
    
    Protected Function RowNumber4() As String
        intRowNumber4 += 1
        Return intRowNumber4.ToString()
    End Function


    
     </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SINGLE SHEET UPDATE (SSU)</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .title 
        {
            font-family: Calibri;
            font-size: larger;
            font-weight: bold;
        }

        thead
        {
            display: table-header-group;
        }

        .repeater {
            border-collapse:collapse;
            border: 1; 
            font-family: Calibri; 
            font-size: 9pt;             
        }
    </style> 
    
</head>
<body>
    <form id="form1" runat="server">
    
    <div align="center">
       <table>
           <tr>
               <td class="title" colspan="4">
                   SINGLE SHEET UPDATE (SSU)
               </td>
           </tr>
           <tr>
               <td class="title" colspan="4">
                   FFEL OPTICAL IMAGING DATABASE
               </td>
           </tr>
           <tr>
                    <td class="title" colspan="4">SLPC, GREENVILLE, TEXAS</td>
                  </tr>
                  <tr>
                    <td colspan="4"><br />REGIONAL OFFICE:  4 - ASC</td>
                  </tr>
                </table>
  </div>
                   <div align="center">
                  <table style="width: 800px; border-collapse: collapse; border: 1px solid #000000">
                  <tr>
                    <td align="left">Name:</td>
                    <td align="left">Mark Scanlan</td>
                    <td align="left">Phone #:</td>
                    <td align="left">(404) 974-9439</td>
                  </tr>
                  <tr>
                    <td align="left">User ID:</td>
                    <td align="right" style="text-align: left">ED4368</td>
                    <td align="left">Agency #:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblAgency" runat="server" /></td>
                  </tr>
                  <tr>
                    <td align="left">&nbsp;</td>
                    <td align="right" style="text-align: left">&nbsp;</td>
                    <td align="left">Date:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblTodaysDate" runat="server" /></td>
                  </tr>
                  </table> 
                  </div>
           <asp:Panel ID="pnlDateRange" runat="server" Visible="false">           
           <table>
              <tr>
               <td>Begin Date:</td>
               <td><asp:TextBox ID="txtBeginDate" runat="server" /></td>
               <td>End Date:</td>
               <td><asp:TextBox ID="txtEndDate" runat="server" /></td>
           </tr>          
       </table>       
       </asp:Panel>
       <br />

       <div align="center">                                                 
          <asp:Repeater ID="rptSSU1" runat="server">
                     <HeaderTemplate>
                     <table width="800px" class="repeater" border="1">
                     <thead> 
                        <th> </th>
                        <th align="left">Name</th>
                        <th align="left">Debt ID</th>
                        <th align="left">SSN</th>                      
                     </thead>           
                     </HeaderTemplate>
                     <ItemTemplate>
                     <tbody>
                     <tr>
                        <!--
                        <td style="padding-bottom: 4px;"><span style="margin-right:20px;"><%# Container.ItemIndex + 1 %></span></td>
                        -->
                        <td align="left"><asp:Label ID="lblRowNumber" runat="server" Text='<%# RowNumber1().ToString() %>' /></td>
                        <td align="left"><asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" /></td>
                        <td align="left"><asp:Label ID="lblDebtID" Text='<%# Eval("DebtID") %>' runat="server" /></td>
                        <td align="left" style="width:100px"> </td>
                     </tr>
                     </tbody>
                     </ItemTemplate>

                     <FooterTemplate>                     
                     </table>  
                     </FooterTemplate>                     
                     </asp:Repeater>
       </div>

        <div align="center">
          <asp:Repeater ID="rptSSU2" runat="server" OnItemDataBound="rptSSU2_OnItemDataBound" Visible="false">                 
                     <HeaderTemplate>
                     <!--New Page-->
                     <p style="page-break-before:always">&nbsp;</p>
                     <div align="center">
       <table>
           <tr>
               <td class="title" colspan="4">
                   SINGLE SHEET UPDATE (SSU)
               </td>
           </tr>
           <tr>
               <td class="title" colspan="4">
                   FFEL OPTICAL IMAGING DATABASE
               </td>
           </tr>
           <tr>
                    <td class="title" colspan="4">SLPC, GREENVILLE, TEXAS</td>
                  </tr>
                  <tr>
                    <td colspan="4"><br />REGIONAL OFFICE:  4 - ASC</td>
                  </tr>
                </table>
  </div>
                     <div align="center">
                  <table style="width: 800px; border-collapse: collapse; border: 1px solid #000000">
                  <tr>
                    <td align="left">Name:</td>
                    <td align="left">Mark Scanlan</td>
                    <td align="left">Phone #:</td>
                    <td align="left">(404) 974-9439</td>
                  </tr>
                  <tr>
                    <td align="left">User ID:</td>
                    <td align="right" style="text-align: left">ED4368</td>
                    <td align="left">Agency #:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblAgency2" runat="server" /></td>
                  </tr>
                  <tr>
                    <td align="left">&nbsp;</td>
                    <td align="right" style="text-align: left">&nbsp;</td>
                    <td align="left">Date:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblTodaysDate2" runat="server" /></td>
                  </tr>
                  </table> 
                  </div>
                     <table width="800px" class="repeater" border="1">
                     <thead> 
                        <th> </th>
                        <th align="left">Name</th>
                        <th align="left">Debt ID</th>
                        <th align="left">SSN</th>                        
                     </thead>           
                     </HeaderTemplate>
                     <ItemTemplate>
                     <tbody>
                     <tr> 
                        <!--                       
                        <td style="padding-bottom: 4px;"><span style="margin-right:20px;"><%# Container.ItemIndex + 1%></span></td>
                        -->
                        <td align="left"><asp:Label ID="lblRowNumber" runat="server" Text='<%# RowNumber2().ToString() %>' /></td>                       
                        <td align="left"><asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" /></td>
                        <td align="left"><asp:Label ID="lblDebtID" Text='<%# Eval("DebtID") %>' runat="server" /></td>
                        <td align="left" style="width:100px"> </td>
                     </tr>
                     </tbody>
                     </ItemTemplate>

                     <FooterTemplate>                     
                     </table>  
                     </FooterTemplate>                     
                     </asp:Repeater>
        </div>                   
                  
        <div align="center">
          <asp:Repeater ID="rptSSU3" runat="server" Visible="false" OnItemDataBound="rptSSU3_OnItemDataBound">
                     <HeaderTemplate>
                        <!--New Page-->
                        <p style="page-break-before:always">&nbsp;</p>
                        <div align="center">
       <table>
           <tr>
               <td class="title" colspan="4">
                   SINGLE SHEET UPDATE (SSU)
               </td>
           </tr>
           <tr>
               <td class="title" colspan="4">
                   FFEL OPTICAL IMAGING DATABASE
               </td>
           </tr>
           <tr>
                    <td class="title" colspan="4">SLPC, GREENVILLE, TEXAS</td>
                  </tr>
                  <tr>
                    <td colspan="4"><br />REGIONAL OFFICE:  4 - ASC</td>
                  </tr>
                </table>
  </div>
                        <div align="center">
                  <table style="width: 800px; border-collapse: collapse; border: 1px solid #000000">
                  <tr>
                    <td align="left">Name:</td>
                    <td align="left">Mark Scanlan</td>
                    <td align="left">Phone #:</td>
                    <td align="left">(404) 974-9439</td>
                  </tr>
                  <tr>
                    <td align="left">User ID:</td>
                    <td align="right" style="text-align: left">ED4368</td>
                    <td align="left">Agency #:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblAgency3" runat="server" /></td>
                  </tr>
                  <tr>
                    <td align="left">&nbsp;</td>
                    <td align="right" style="text-align: left">&nbsp;</td>
                    <td align="left">Date:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblTodaysDate3" runat="server" /></td>
                  </tr>
                  </table> 
                  </div>

                     <table width="800px" class="repeater" border="1">
                     <!--
                     <thead style="display: table-header-group;"> 
                     -->                    
                     <thead> 
                        <th> </th>
                        <th align="left">Name</th>
                        <th align="left">Debt ID</th>
                        <th align="left">SSN</th>
                     </thead>           
                     </HeaderTemplate>
                     <ItemTemplate>
                     <tbody>
                     <tr>                         
                        <td align="left"><asp:Label ID="lblRowNumber" runat="server" Text='<%# RowNumber3().ToString() %>' /></td>                       
                        <td align="left"><asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" /></td>
                        <td align="left"><asp:Label ID="lblDebtID" Text='<%# Eval("DebtID") %>' runat="server" /></td>
                        <td align="left" style="width:100px"> </td>
                     </tr>
                     </tbody>
                     </ItemTemplate>

                     <FooterTemplate>                     
                     </table>  
                     </FooterTemplate>                     
                     </asp:Repeater>
        </div>    
        
        <div align="center">
          <asp:Repeater ID="rptSSU4" runat="server" Visible="false" OnItemDataBound="rptSSU4_OnItemDataBound">
                     <HeaderTemplate>
                        <!--New Page-->
                        <p style="page-break-before:always">&nbsp;</p>
                        <div align="center">
       <table>
           <tr>
               <td class="title" colspan="4">
                   SINGLE SHEET UPDATE (SSU)
               </td>
           </tr>
           <tr>
               <td class="title" colspan="4">
                   FFEL OPTICAL IMAGING DATABASE
               </td>
           </tr>
           <tr>
                    <td class="title" colspan="4">SLPC, GREENVILLE, TEXAS</td>
                  </tr>
                  <tr>
                    <td colspan="4"><br />REGIONAL OFFICE:  4 - ASC</td>
                  </tr>
                </table>
  </div>
                        <div align="center">
                  <table style="width: 800px; border-collapse: collapse; border: 1px solid #000000">
                  <tr>
                    <td align="left">Name:</td>
                    <td align="left">Mark Scanlan</td>
                    <td align="left">Phone #:</td>
                    <td align="left">(404) 974-9439</td>
                  </tr>
                  <tr>
                    <td align="left">User ID:</td>
                    <td align="right" style="text-align: left">ED4368</td>
                    <td align="left">Agency #:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblAgency4" runat="server" /></td>
                  </tr>
                  <tr>
                    <td align="left">&nbsp;</td>
                    <td align="right" style="text-align: left">&nbsp;</td>
                    <td align="left">Date:</td>
                    <td align="right" style="text-align: left"><asp:Label ID="lblTodaysDate4" runat="server" /></td>
                  </tr>
                  </table> 
                  </div>

                     <table width="800px" class="repeater" border="1">
                                       
                     <thead> 
                        <th> </th>
                        <th align="left">Name</th>
                        <th align="left">Debt ID</th>
                        <th align="left">SSN</th>
                     </thead>           
                     </HeaderTemplate>
                     <ItemTemplate>
                     <tbody>
                     <tr>                         
                        <td align="left"><asp:Label ID="lblRowNumber" runat="server" Text='<%# RowNumber4().ToString() %>' /></td>                       
                        <td align="left"><asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" /></td>
                        <td align="left"><asp:Label ID="lblDebtID" Text='<%# Eval("DebtID") %>' runat="server" /></td>
                        <td align="left" style="width:100px"> </td>
                     </tr>
                     </tbody>
                     </ItemTemplate>

                     <FooterTemplate>                     
                     </table>  
                     </FooterTemplate>                     
                     </asp:Repeater>
        </div>
        
             
                  
                  <!--New Page-->
                  <p style="page-break-before:always">&nbsp;</p>
                  
                  <div align="center">
                  <table>                  
                  <tr>
                    <td colspan="10"><h1>EFT TRANSMITTAL FORM</h1></td>
                  </tr>
                  <tr>
                        <td align="right">File Transmission Date:</td>
                        <td align="left" colspan="9"><asp:Label ID="lblFileTransmissionDate" runat="server" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">To: EFT PROCESSING AREA</td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">US DEPARTMENT OF EDUCATION</td>
                   </tr>
                   <tr>
                        <td align="left" colspan="10">FAX: (903) 454-5398</td>
                  </tr>
                  <tr>
                    <td colspan="10">&nbsp;</td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">CREATION DATE: <asp:Label ID="lblCreationDate" runat="server" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                    <td colspan="10" align="left">TAPE NUMBER OF VOLSER</td>
                  </tr>
                  <tr>
                        <td colspan="10" align="left">SHOULD EQUAL INTERNAL LABEL:</td>
                  </tr>
                  <tr>
                    <td colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                        <td align="left">DATA SET NAME:  GSL CARRET</td>
                        <td colspan="9" align="left">AGENCY NO: <asp:Label ID="lblAgencyNo" runat="server" /></td>
                  </tr>
                  <tr>
                        <td colspan="10">
                            <table width="100%">
                                 <tr>
                    <td style="text-align: center;">BAN</td>
                    <td style="text-align: center;">BNK</td>
                    <td style="text-align: center;">CAN</td>
                    <td style="text-align: center; background-color: #C0C0C0;">DEA</td>
                    <td style="text-align: center;">INC</td>
                    <td style="text-align: center;">INW</td>
                    <td style="text-align: center;">INA/UNL</td>
                    <td style="text-align: center;">CPR/</td>
                    <td style="text-align: center;">PIF/</td>
                    <td style="text-align: center;">CER</td>
                  </tr>
                  <tr>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td style="text-align: center;"><b><asp:Label ID="lblDEACount" runat="server" /></b></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                    <td valign="bottom"><hr noshade="noshade" style="height: 1px; width: 45px; color: #000000" /></td>
                  </tr>
                            </table>
                        </td>
                  </tr>
                 
                  <tr>
                        <td><asp:Label ID="lblIMFType" runat="server" /></td>
                        <td colspan="9"><asp:Label ID="lblIMFCount" runat="server" /></td>
                  </tr>
                  <tr>
                        <td>Signature and Date of ED Regional Contract Monitor: </td>
                        <td><img src="signature.doug.laine.jpg" /></td>
                        <td><asp:Label ID="lblSignatureDate" runat="server" /></td>
                  </tr>
                  <tr>
                        <td align="left">EFT APPROVED: <b><asp:Label ID="lblEFTApprovedCount" runat="server" /></b></td>
                        <td align="left" colspan="9">EFT REJECTED: <b>0</b></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10"># OF RECORDS:</td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">STANDARD LABEL:</td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">LRECL:</td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">BLOCK SIZE:</td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">BPI:</td>
                  </tr>
                   <tr>
                        <td align="left" colspan="10"><hr noshade="noshade" style="height: 1px; color: #000000" /></td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">RETURN EFT TO:</td>
                  </tr>
                  <tr>
                        <td align="left" colspan="10">
                            <table>
                                <tr>
                                    <td valign="top">CONTACT PERSON:</td>
                                    <td valign="bottom" align="left"><hr noshade="noshade" style="height: 1px; width: 300px; color: #000000" /></td>
                                </tr>
                                 <tr>
                                    <td valign="top">TELEPHONE NUMBER:</td>
                                    <td valign="bottom" align="left"><hr noshade="noshade" style="height: 1px; width: 300px; color: #000000" /></td>
                                </tr>
                                <tr>
                                    <td valign="top">FAX:</td>
                                    <td valign="bottom" align="left"><hr noshade="noshade" style="height: 1px; width: 300px; color: #000000" /></td>
                                </tr>
                            </table>
                        </td>
                  </tr>
                  </table>
                  </div>
    
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
<asp:Label ID="lblRecordCount" runat="server" />
 </form>
</body>
</html>
