<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"  MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            'Get the IMF_ID values passed to this page
            If Not IsNothing(Request.QueryString("IMF_ID")) Then
                lblIMF_ID.Text = Request.QueryString("IMF_ID")
                
                'Set the value of the IMF dropdownlist equal to the selected IMF type passed here
                ddlIMF_Type.SelectedValue = lblIMF_ID.Text
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
            GridView1.DataSourceID = "dsIMFs_ByType"
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = "dsIMFs_ByType_NoCompleted"
        End If
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " IMFs"
    End Sub
    
    Sub BindGridView_Completed()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_IMFs_ByType"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = lblIMF_ID.Text
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
        strSQL = "p_IMFs_ByType_NoCompleted"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = lblIMF_ID.Text
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
    
    Protected Sub ddlIMF_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        lblIMF_ID.Text = ddlIMF_Type.SelectedValue
        GridView1.DataBind()
    End Sub
    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>IMFs By Type - ED</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
        
</head>
<body>
    <form id="form1" runat="server">                
                
  <fieldset>
     <!--Begin List of IMFs here -->
     <asp:SqlDataSource ID="dsIMFs_ByType" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_IMFs_ByType" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblIMF_ID" Name="IMF_ID" DefaultValue="0" />                            
                      </SelectParameters>                      
                </asp:SqlDataSource>   
                
                <asp:SqlDataSource ID="dsIMFs_ByType_NoCompleted" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_IMFs_ByType_NoCompleted" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblIMF_ID" Name="IMF_ID" DefaultValue="0" />                            
                      </SelectParameters>
                </asp:SqlDataSource> 
                
                  <!--This one populates the IMF Type dropdown-->
                    <asp:SqlDataSource ID="dsIMFTypes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_IMFTypes" SelectCommandType="StoredProcedure" />    
                            
                            <asp:SqlDataSource ID="dsEDUsers_IMFTypes_ByOneType" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                                SelectCommand="p_EDUsers_IMFTypes_ByOneType" SelectCommandType="StoredProcedure"> 
                                    <SelectParameters>
                                        <asp:ControlParameter Name="IMF_ID" ControlID="ddlIMF_Type" DefaultValue="0" />
                                    </SelectParameters>                       
                                </asp:SqlDataSource>   
                
                  <div align="center"> 
                  <div align="center" width="90%">
                  <asp:DropDownList id="ddlIMF_Type" Runat="Server"
                                        DataSourceID="dsIMFTypes"
                                        DataTextField="IMF_Type" 
                                        DataValueField="IMF_ID" 
                                        AppendDataBoundItems="true" AutoPostBack="true" 
                                        CssClass="formLabel" onselectedindexchanged="ddlIMF_Type_SelectedIndexChanged"> 
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                        <br />
                                        
                            <asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include Completed IMFs? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                  </div>
                   
                                        
                            <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsIMFs_ByType_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" OnRowDataBound="GridView1_RowDataBound" PageSize="20" PagerSettings-Position="TopAndBottom">                           
                            
                            <EmptyDataTemplate>
                                    There are no IMFs with this IMF type
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
                                    DataField="Username" 
                                    HeaderText="Assigned To" 
                                    SortExpression="Username" />
                                    
                                    <asp:BoundField 
                                    DataField="DaysSinceSubmitted" 
                                    HeaderText="Days Since Submitted" 
                                    ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-HorizontalAlign="Right" 
                                    SortExpression="DaysSinceSubmitted" />
                                    
                                    <asp:BoundField 
                                    DataField="DaysSinceAssigned" 
                                    HeaderText="Days Since Assigned"
                                    ItemStyle-HorizontalAlign="Right" 
                                    HeaderStyle-HorizontalAlign="Right" 
                                    SortExpression="DaysSinceAssigned" />                                    
                                    
                                    <asp:TemplateField HeaderText="Attachments">
                                        <ItemTemplate>  
                                           <ul>                                                                      
                                            <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("Attachment1")%>' runat="server">Attachment1</asp:HyperLink></li>     
                                            <li id="l2" runat="server"><asp:HyperLink ID="HyperLink2" NavigateUrl='<%# Eval("Attachment2")%>' runat="server">Attachment2</asp:HyperLink></li>     
                                           </ul>                                         
                                        </ItemTemplate>                                                                       
                                    </asp:TemplateField>
                                </Columns>                
                            </asp:GridView>
                             </div>  
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                        </fieldset>                
                   </div>        
                        
   
<asp:Label ID="lblIMF_ID" runat="server" Visible="false" />
 </form>
</body>
</html>
