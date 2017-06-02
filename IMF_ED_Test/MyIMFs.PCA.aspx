<%@ Page Language="VB" Debug="true" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            If Not IsNothing(Request.QueryString("AgencyID")) Then
                Dim intAG As String = Request.QueryString("AgencyID").ToString()
                lblAgency.Text = intAG
            Else
                If Not IsNothing(Request.Cookies("IMF")) Then
                    lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
                End If
            End If
            
            If lblAgency.Text Is Nothing OrElse lblAgency.Text.Length = 0 Then
                Response.Redirect("/not.logged.in.aspx")
            End If
            
        End If
    End Sub
    
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim link1 As HyperLink = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
            If String.IsNullOrEmpty(link1.NavigateUrl) Then
                Dim li As HtmlGenericControl = CType(e.Row.FindControl("l1"), HtmlGenericControl)
                li.Visible = False
            End If
            
            Dim link2 As HyperLink = DirectCast(e.Row.FindControl("HyperLink2"), HyperLink)
            If String.IsNullOrEmpty(link2.NavigateUrl) Then
                Dim li As HtmlGenericControl = CType(e.Row.FindControl("l2"), HtmlGenericControl)
                li.Visible = False
            End If
        End If
    End Sub
    
    Protected Sub chkIncludeCompleted_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all IMFs
            GridView1.DataSourceID = "dsMyIMFs"
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = "dsMyIMFs_NoCompleted"
        End If
    End Sub
    
    Sub BindGridView_Completed()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyIMFs_PCA"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Varchar).Value = lblAgency.Text
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
    
    Sub BindGridView_NoCompleted()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyIMFs_PCA_NoCompleted"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@AgencyID", SqlDbType.Varchar).Value = lblAgency.Text
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
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all IMFs
            GridView1.DataSourceID = Nothing
            BindGridView_Completed()
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = Nothing
            BindGridView_NoCompleted()
        End If
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=IMF.Search.Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " IMFs"
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PCA IMFs</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">
  
                <asp:SqlDataSource ID="dsMyIMFs_NoCompleted" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyIMFs_PCA_NoCompleted" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblAgency" Name="AgencyID" />                            
                        </SelectParameters>
                     </asp:SqlDataSource>  
                     
                     <asp:SqlDataSource ID="dsMyIMFs" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyIMFs_PCA" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblAgency" Name="AgencyID" />                            
                        </SelectParameters>
                     </asp:SqlDataSource>
                  
                  <div align="center">     
                      <h2>My IMFs (<%=lblAgency.Text%>)</h2>
                        <asp:Panel ID="pnlMyIMFs" runat="server">                                        
                            <div align="center" width="90%">
                            <asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include Completed IMFs? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                            </div>
                            <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsMyIMFs_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" OnRowDataBound="GridView1_RowDataBound" PageSize="20" PagerSettings-Position="TopAndBottom"> 
                            
                            <EmptyDataTemplate>
                                    You have not submitted any IMFs
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>
                              		                    
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="IMF ID" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id"  
                                    ItemStyle-CssClass="first"
                                    DataNavigateUrlFormatString="imf.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>                                 
                                    
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
                                    DataField="PCA_Employee" 
                                    HeaderText="PCA Name" />
                                    
                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="Assigned To" 
                                    SortExpression="Username" /> 
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="DateClosed" />   
                                    
                                    <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />                                                                  
                                    
                                    <asp:TemplateField HeaderText="Attachments">
                                        <ItemTemplate>  
                                           <ul>                                                                      
                                            <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("Attachment1")%>' runat="server" Target="_blank">Attachment1</asp:HyperLink></li>     
                                            <li id="l2" runat="server"><asp:HyperLink ID="HyperLink2" NavigateUrl='<%# Eval("Attachment2")%>' runat="server" Target="_blank">Attachment2</asp:HyperLink></li>     
                                           </ul>                                         
                                        </ItemTemplate>                                                                       
                                    </asp:TemplateField>
                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>                     
                   </asp:Panel>
                   </div>  
   
<asp:Label ID="lblAgency" runat="server" Visible="false" />
 </form>
</body>
</html>
