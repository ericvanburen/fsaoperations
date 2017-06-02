﻿<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" Debug="true" %>
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
            
        End If
    End Sub
      
    Sub BindGridView_Completed()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyIMFs_Vangent"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@Email", SqlDbType.Int).Value = lblVangent.Text
        
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
        strSQL = "p_MyIMFs_Vangent_NoCompleted"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@Email", SqlDbType.Int).Value = lblVangent.Text
        
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
                <legend class="fieldsetLegend">IMFs Assigned to <asp:Label ID="lblVangent" runat="server" Visible="true" /></legend><br />       
                   <div align="center"> 
                   
                   <!--This one populates the Gridview-->
                             <asp:SqlDataSource ID="dsIMFs" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_MyIMFs_Vangent" SelectCommandType="StoredProcedure" 
                            UpdateCommand="p_IMFs_Vangent_Update" UpdateCommandType="StoredProcedure"
                            DeleteCommand="p_IMFs_Vangent_Delete" DeleteCommandType="StoredProcedure"                           
                            OnSelected="OnSelectedHandler">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblVangent" Name="Email" />
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
                            
                            <asp:SqlDataSource ID="dsIMFs_NoCompleted" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_MyIMFs_Vangent_NoCompleted" SelectCommandType="StoredProcedure"
                            UpdateCommand="p_IMFs_Vangent_Update" UpdateCommandType="StoredProcedure"
                            DeleteCommand="p_IMFs_Vangent_Delete" DeleteCommandType="StoredProcedure"                           
                            OnSelected="OnSelectedHandler">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblVangent" Name="Email" />
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
                            <asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include Completed IMFs? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
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
                                    DataField="QueueName" 
                                    HeaderText="Queue" 
                                    SortExpression="QueueName" />

                                    <asp:BoundField 
                                    DataField="Email" 
                                    HeaderText="Assigned To" 
                                    SortExpression="Email" />
                                    
                                    <asp:TemplateField HeaderText="Rejected By DRG?" SortExpression="Rejected">
                                    <ItemTemplate>
                                              <asp:Label ID="lblRejected" runat="server" Text='<%# TrueFalse(Eval("Rejected"))%>' />                         
                                    </ItemTemplate>                                    
                                    </asp:TemplateField>                                                                       
                    				                    
                                    <asp:TemplateField ShowHeader="False" HeaderText=" " Visible="false">
                                    <ItemTemplate> 
                                        <asp:LinkButton ID="lbDeleteIMF" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick='return confirm("Are you sure that you want to delete this IMF? This operation cannot be undone.");' Text="Delete" />
				                    </ItemTemplate>
				                    </asp:TemplateField>
                                    
                               </Columns>                
                            </asp:GridView>
                            </div>
                             <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /> 
                            <asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" />
                            </div>       
                            </fieldset>                                       



 </form>
</body>
</html>
