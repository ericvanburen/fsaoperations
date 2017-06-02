<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"   %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'Vangent Only page - Call Check Vangent Login Status
            CheckVangentLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblVangent.Text = (Request.Cookies("IMF")("Vangent").ToString())
            End If
                      
            Dim intQueueID As Integer = Request.QueryString("QueueID")
            lblQueueID.Text = intQueueID
            
            ddlQueueID.SelectedValue = intQueueID
            
            BindUserID()
        End If
    End Sub
    
    Sub BindUserID()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail_Vangent_Email"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Username", lblVangent.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                If IsDBNull(dr("IsAdmin")) = False Then
                    lblIsAdmin.Text = dr("IsAdmin")
                End If
            End While
            
            Page.DataBind()
            
            'pnlAdmin is visible only to admins
            If lblIsAdmin.Text.ToString() = "True" Then
                ddlQueueID.Enabled = True
            Else
                ddlQueueID.Enabled = False
            End If
            
        Finally
            'dr.Close()
            strConnection.Close()
        End Try
    End Sub
      
    Sub BindGridView_Completed(ByVal QueueID As Integer)
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_IMFTypes_Vangent_Queue"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QueueID", SqlDbType.Int).Value = QueueID
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
    
    Sub BindGridView_NoCompleted(ByVal QueueID As Integer)
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_IMFs_Vangent_NoCompleted_Queue"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@QueueID", SqlDbType.Int).Value = QueueID
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
            BindGridView_Completed(CInt(lblQueueID.Text))
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = Nothing
            BindGridView_NoCompleted(CInt(lblQueueID.Text))
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
    
    Protected Sub chkIncludeCompleted_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all IMFs
            GridView1.DataSourceID = "dsIMFs"
            'BindGridView_Completed()
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = "dsIMFs_NoCompleted"
            'BindGridView_NoCompleted()
        End If
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " IMFs"
    End Sub
    
    Protected Sub ddlQueueID_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        lblQueueID.Text = ddlQueueID.SelectedValue.ToString()
        
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all IMFs
            GridView1.DataSourceID = "dsIMFs"
            'BindGridView_Completed()
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = "dsIMFs_NoCompleted"
            'BindGridView_NoCompleted()
        End If
    End Sub
    
    
    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>IMFs - Vangent</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
                                   
                 <fieldset>
                <legend class="fieldsetLegend">All IMFs</legend><br />       
                   <div align="center"> 
                   
                   <!--This one populates the Gridview-->
                             <asp:SqlDataSource ID="dsIMFs" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_IMFs_Vangent_Queue" SelectCommandType="StoredProcedure" 
                            UpdateCommand="p_IMFs_Vangent_Update" UpdateCommandType="StoredProcedure"
                            DeleteCommand="p_IMFs_Vangent_Delete" DeleteCommandType="StoredProcedure"                           
                            OnSelected="OnSelectedHandler">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblQueueID" Name="QueueID" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="DateClosed" Type="DateTime" />
                                <asp:Parameter Name="Rejected" Type="Boolean" />
                             </UpdateParameters>
                             <DeleteParameters>
                                     <asp:Parameter Name="ID" Type="Int32" />
                            </DeleteParameters>
                             </asp:SqlDataSource>

                              <!--This one populates the Queue dropdown-->
                                <asp:SqlDataSource ID="dsAllQueues" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>"
                                SelectCommand="p_AllQueues_Vangent" SelectCommandType="StoredProcedure" /> 
                            
                            <asp:SqlDataSource ID="dsIMFs_NoCompleted" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_IMFs_Vangent_NoCompleted_Queue" SelectCommandType="StoredProcedure"
                            UpdateCommand="p_IMFs_Vangent_Update" UpdateCommandType="StoredProcedure"
                            DeleteCommand="p_IMFs_Vangent_Delete" DeleteCommandType="StoredProcedure"                           
                            OnSelected="OnSelectedHandler">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblQueueID" Name="QueueID" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="DateClosed" Type="DateTime" />
                                <asp:Parameter Name="Rejected" Type="Boolean" />
                             </UpdateParameters>
                             <DeleteParameters>
                                     <asp:Parameter Name="ID" Type="Int32" />
                            </DeleteParameters>
                             </asp:SqlDataSource>                        
                            
                            <div align="center" width="100%">
                            <table width="90%">
                            <tr>
                                <td align="left"> Select a Queue: <asp:DropDownList id="ddlQueueID" Runat="Server"
                                DataSourceID="dsAllQueues"
                                DataTextField="QueueName" 
                                DataValueField="QueueID" 
                                OnSelectedIndexChanged="ddlQueueID_SelectedIndexChanged" 
                                AutoPostBack="true" 
                                CssClass="formLabel"> 
                            </asp:DropDownList></td>
                                <td align="left"><asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include Completed IMFs? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" /></td>
                            </tr>
                            </table>
                            
                            </div>
                            <div class="grid"> 
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsIMFs_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="100%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="true" 
                            PageSize="50">
                            <RowStyle CssClass="row" />
                            <EmptyDataTemplate>
                                  <h3>Your IMF queue is empty</h3>                                      
                            </EmptyDataTemplate>

                            <Columns>                             
                                
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="IMF ID" 
                                    ItemStyle-CssClass="first" 
                                    DataNavigateUrlFields="Id" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="imf.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>

                                    <asp:BoundField 
                                    DataField="AgencyID" 
                                    HeaderText="AG" 
                                    SortExpression="AgencyID"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Submitted" 
                                    SortExpression="DateSubmitted" 
                                    DataFormatString="{0:d}"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="IMF_Type" 
                                    HeaderText="Type" 
                                    SortExpression="IMF_Type"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID"
                                    ReadOnly="true" />
                                                                    
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Borrower Last Name" 
                                    SortExpression="Borrower_LName"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="Borrower_FName" 
                                    HeaderText="Borrower First Name" 
                                    SortExpression="Borrower_FName"
                                    ReadOnly="true" />
                                    
                                    <asp:BoundField 
                                    DataField="DateClosed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="DateClosed"
                                    DataFormatString="{0:d}" /> 

                                    <asp:BoundField 
                                    DataField="QueueID" 
                                    HeaderText="Queue" 
                                    SortExpression="QueueID" />

                                     <asp:BoundField 
                                    DataField="Rejected" 
                                    HeaderText="Rejected?" 
                                    SortExpression="Rejected" />                
                    				                    
                                    <asp:TemplateField ShowHeader="False" HeaderText=" " Visible="false">
                                    <ItemTemplate> 
                                        <asp:LinkButton ID="lbDeleteIMF" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick='return confirm("Are you sure that you want to delete this IMF? This operation cannot be undone.");' Text="Delete" />
				                    </ItemTemplate>
				                    </asp:TemplateField>
                                    
                               </Columns>                
                            </asp:GridView>
                             <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /> 
                            <asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" />
                            </div>       
                            </fieldset>                                       

<asp:Label ID="lblVangent" runat="server" Visible="false" />
<asp:Label ID="lblQueueID" runat="server" Visible="false" />
<asp:Label ID="lblIsAdmin" runat="server" Visible="false" />
 </form>
</body>
</html>
