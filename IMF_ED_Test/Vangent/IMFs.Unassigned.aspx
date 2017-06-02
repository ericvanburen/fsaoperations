<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" EnableEventValidation = "false"   %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
--%><%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckVangentLogin()
        End If
    End Sub
 
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " IMFs"
    End Sub
    
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        '**** Do not remove ****
        ' Confirms that an HtmlForm control is rendered for the   
        ' specified ASP.NET server control at run time.   
        ' No code required here.   
    End Sub
    
    Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        GridView1.AllowSorting = False
        GridView1.AllowPaging = False
        GridView1.DataSourceID = "dsIMFsUnassigned"
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Unassigned.IMFs.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
       
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Unassigned IMFs</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../js/default.js"></script>
       
</head>
<body>
    <form id="form1" runat="server">                
    
         <asp:SqlDataSource ID="dsIMFsUnassigned" runat="server" OnSelected="OnSelectedHandler" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_IMFsUnassigned_Vangent" SelectCommandType="StoredProcedure">                                         
       </asp:SqlDataSource>   
       
              
                
                            
                              
                  <div align="center"> 
                  <fieldset>
                  <legend class="fieldsetLegend">Unassigned IMFs</legend><br />    
                   <asp:Panel ID="pnlIMFsUnassigned" runat="server">
                  
                            <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                            <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsIMFsUnassigned" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20">                           
                            
                            <EmptyDataTemplate>
                                    There are no unassigned IMFs
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>                           
                                
                                 <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="IMF ID" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="imf.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>

                                    <asp:BoundField 
                                    DataField="AgencyID" 
                                    HeaderText="AG" 
                                    SortExpression="AgencyID" />
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    SortExpression="DateSubmitted" />
                                    
                                    <asp:BoundField 
                                    DataField="IMF_Type" 
                                    HeaderText="Type" 
                                    SortExpression="IMF_Type" />
                                    
                                    <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID" />
                                                                   
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />
                                                                        
                                    <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" SortExpression="Status" />
                                    
                                     <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" SortExpression="DateClosed" />
                                    
                                                                       
                                    <asp:BoundField 
                                    DataField="DaysSinceSubmitted" 
                                    HeaderText="Days Since Submitted" 
                                    ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-HorizontalAlign="Right" 
                                    SortExpression="DaysSinceSubmitted" />
                                                       
                                 
                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                        </div>  
                        </fieldset>                
                   </asp:Panel>
                   </div>   
                        
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />    
 </form>
</body>
</html>
