<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblEDUserName.Text = (Request.Cookies("IMF")("EDUserName").ToString())
            End If
        End If
    End Sub
      
    Sub BindGridView_Completed()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_VAApps_ED"
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
    
    Sub BindGridView_NoCompleted()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_VAApps_ED_NoCompleted"
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
        Response.AddHeader("content-disposition", "attachment;filename=VA.Apps.Search.Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
    
    Protected Sub chkIncludeCompleted_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all IMFs
            GridView1.DataSourceID = "dsVAApps"
            'BindGridView_Completed()
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = "dsVAApps_NoCompleted"
            'BindGridView_NoCompleted()
        End If
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " discharge applications"
    End Sub
    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>VA Discharge Applications</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
                                   
                 <fieldset>
                <legend class="fieldsetLegend">All VA Discharge Applications</legend><br />       
                   <div align="center"> 
                   
                   <!--This one populates the Gridview-->
                             <asp:SqlDataSource ID="dsVAApps" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_VAApps_ED_Admin_Queue" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler" />
                            
                            <asp:SqlDataSource ID="dsVAApps_NoCompleted" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_VAApps_ED_Admin_Queue_NoCompleted" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler" />                        
                            
                            <div align="center" width="90%">
                            <asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include approved VA discharge apps? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                            </div>
                            <div class="grid"> 
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsVAApps_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="true" 
                            PageSize="20">
                            <RowStyle CssClass="row" />
                            <Columns>
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="VA ID" 
                                    DataNavigateUrlFields="Id" 
                                    ItemStyle-CssClass="first" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="va.app.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>

                                    <asp:BoundField 
                                    DataField="GA_Name" 
                                    HeaderText="GA" 
                                    SortExpression="GA_Name" />
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    SortExpression="DateSubmitted" />
                                              
                                    <asp:BoundField 
                                    DataField="SSN" 
                                    HeaderText="SSN"
                                    SortExpression="SSN" />
                                                                    
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName" />
                                    
                                    <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="DateClosed" />
                                    
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
                              </Columns>                
                            </asp:GridView>
                             <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>       
                            </fieldset>                                       
                                    
            
 
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />    
 </form>
</body>
</html>
