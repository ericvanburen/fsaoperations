<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
        End If
    End Sub
 
          
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " Duplicate VA Apps"
    End Sub
    
    Sub BindGridView()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_VAApps_Duplicates"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        Try
            con.Open()
            dr = cmd.ExecuteReader()
            GridView1.DataSource = dr
            GridView1.DataBind()
        Finally
            con.Close()
        End Try
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
        
        GridView1.DataSourceID = Nothing
        BindGridView()
       
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Duplicate.VA.Apps.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As SqlDataSource = CType(e.Row.FindControl("SqlDataSource2"), SqlDataSource)
            s.SelectParameters(0).DefaultValue = e.Row.Cells(2).Text
        End If


    End Sub


    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Duplicate VA Apps - ED</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
  
            <div id="MyVAApps">
                <asp:SqlDataSource ID="dsMyVAApps" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_VAApps_Duplicates" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">                                           
                </asp:SqlDataSource>                
                
                <fieldset>
                <legend class="fieldsetLegend">Duplicate VA Apps</legend><br />        
                             
                  <div align="center"> 
                   <asp:Panel ID="pnlMyIMFs" runat="server">
                  <div align="center" width="90%">
                            <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                  </div>
                            <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMyVAApps" 
                                    AutoGenerateColumns="False" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" 
                                    BackColor="White" GridLines="Horizontal" 
                            AllowPaging="True" AllowSorting="True" PageSize="20" EnableModelValidation="True" OnRowDataBound="GridView2_RowDataBound">                           
                            
                            <EmptyDataTemplate>
                                    There are no VA Apps 
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>                           
                                    
                                    <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="VA ID" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="va.app.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>                                  
                                    
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />

                                    <asp:BoundField 
                                    DataField="SSN" 
                                    HeaderText="SSN"
                                    SortExpression="SSN" />                                                                                 
                                    
                                   <%--  <asp:BoundField 
                                    DataField="VACount" 
                                    HeaderText="Count"
                                    SortExpression="VACount" /> --%>     
                                   
                                    <asp:TemplateField HeaderText="Details">
                                        <ItemTemplate>
                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                                                SelectCommand="SELECT [Username], dbo.Decrypt([SSN]) AS SSN, [Status], [DateSubmitted], [GA_Name] FROM [v_MyVAApps] WHERE (dbo.Decrypt([SSN]) = @SSN)">
                                                <SelectParameters>
                                                    <asp:Parameter Name="SSN" Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                                DataSourceID="SqlDataSource2" EnableModelValidation="True" Width="100%">
                                                <Columns>
                                                    <asp:BoundField DataField="Username" HeaderText="Assigned To"   />
                                                   <asp:BoundField DataField="DateSubmitted" HeaderText="Date" DataFormatString="{0:d}"  />
                                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                                    <asp:BoundField DataField="GA_Name" HeaderText="GA Name" />
                                                </Columns>
                                            </asp:GridView>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                   
                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Visible="false" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                         
                        </fieldset>                
                      </asp:Panel>
                   </div> 
                   </div>         
                        
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />    
 </form>
</body>
</html>
