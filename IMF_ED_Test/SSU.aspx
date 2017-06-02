<%@ Page Language="VB" Inherits="MyBaseClass" EnableEventValidation="false" src="classes/MyBaseClass.vb" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
            End If
            
            Dim dteBeginDate As String = Request.QueryString("BeginDate")
            If dteBeginDate IsNot Nothing Then
                txtBeginDate.Text = dteBeginDate.ToString()
            End If
            
            Dim dteEndDate As String = Request.QueryString("EndDate")
            If dteEndDate IsNot Nothing Then
                txtEndDate.Text = dteEndDate.ToString()
            End If
                        
            'If begindate, endate have a value passed to this page, then we know its from the PDF page
            If dteBeginDate <> "" OrElse dteEndDate <> "" Then
                Search()
                btnSearch.Visible = False
                'btnExportPDF.Visible = False
            End If
                       
        End If
    End Sub
        
    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        Search()
    End Sub
    
    Sub Search()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_SSU"
        
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Int).Value = lblAgency.Text
        cmd.Parameters.AddWithValue("@BeginDate", SqlDbType.DateTime).Value = txtBeginDate.Text
        cmd.Parameters.AddWithValue("@EndDate", SqlDbType.DateTime).Value = txtEndDate.Text
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            rptSSU.DataSource = dr
            rptSSU.DataBind()
            pnlSSU.Visible = True
        Finally
            con.Close()
        End Try
    End Sub
    
        
        
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " records"
    End Sub
    
    Sub btnExportPDF_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("https://www.fsacollections.ed.gov/secure/imf_ed/pdf/SSU.aspx?AG=" & lblAgency.Text & "&BeginDate=" & txtBeginDate.Text & "&EndDate=" & txtEndDate.Text)
    End Sub

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SINGLE SHEET UPDATE (SSU)</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .title 
        {
            font-family: Calibri;
            font-size: larger;
            font-weight: bold;
        }
    </style> 
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:SqlDataSource ID="dsVA_Discharge_Approval_Letter" runat="server" 
              ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
              SelectCommand="p_SSU" SelectCommandType="StoredProcedure">
         <SelectParameters>
                <asp:ControlParameter ControlID="lblAgency" Name="AgencyID" />
                <asp:FormParameter FormField="txtBeginDate" DbType="DateTime" />
                <asp:FormParameter FormField="txtEndDate" DbType="DateTime" />

         </SelectParameters>
        </asp:SqlDataSource>
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

                   <div align="center">
                  <table>
                  <tr>
                    <td align="right">Name:</td>
                    <td align="left">Mark Scanlan</td>
                    <td align="right">Phone #:</td>
                    <td align="left">(404) 974-9439</td>
                  </tr>
                  <tr>
                    <td align="right">User ID:</td>
                    <td align="left">ED4368</td>
                    <td align="right">Agency #/Date:</td>
                    <td align="left"> <asp:Label ID="lblAgency" runat="server" /></td>
                  </tr>
                  </table> 
                  </div>
           <div align="center">
                  <table>
              <tr>
               <td>Begin Date:</td>
               <td><asp:TextBox ID="txtBeginDate" runat="server" /></td>
               <td>End Date:</td>
               <td><asp:TextBox ID="txtEndDate" runat="server" /></td>
           </tr>
           <tr>
            <td colspan="4"><asp:Button ID="btnSearch" OnClick="btnSearch_Click" Text="Search" CssClass="button" runat="server" /></td>
           </tr>
       </table>
       </div>
                                                     
                 <asp:Panel ID="pnlSSU" runat="server" Visible="false">
                     <div align="center" width="90%">
                         <table>
                             <tr>
                                 <td>
                                     <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                                 </td>
                             </tr>
                         </table>
                     </div>
                     
                     <asp:Repeater ID="rptSSU" runat="server">
                     <HeaderTemplate>
                     <table width="800px" style="border-collapse:collapse;" border="1">
                     <tr>
                        <td> </td>
                        <td align="left">Name</td>
                        <td align="left">Debt ID</td>
                        <td align="left">SSN</td>
                     </tr>           
                     </HeaderTemplate>
                     <ItemTemplate>
                     <tr>
                        <td><span style="margin-right:20px;"><%# Container.ItemIndex + 1 %></span></td>
                        <td align="left"><asp:Label ID="lblName" Text='<%# Eval("Name") %>' runat="server" /></td>
                        <td align="left"><asp:Label ID="lblDebtID" Text='<%# Eval("DebtID") %>' runat="server" /></td>
                        <td align="left" style="width:100px"> </td>
                     </tr>
                     </ItemTemplate>

                     <FooterTemplate>
                     <tr>
                        <td colspan="5"> <asp:Button ID="btnExportPDF" CssClass="button" runat="server" OnClick="btnExportPDF_Click"
                             Text="Export to PDF" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
                     </tr>
                     </table>  
                     </FooterTemplate>                     
                     </asp:Repeater>
                 </asp:Panel>
                  <br />
                   
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
 </form>
</body>
</html>
