<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"   %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'Vangent Only page - Call Check Vangent Login Status
            CheckVangentLogin()
        End If
    End Sub
      
    Sub BindGridView_Completed()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_PNotes_Vangent"
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
        strSQL = "p_PNotes_Vangent_NoCompleted"
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
        Response.AddHeader("content-disposition", "attachment;filename=Pnotes.xls")
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
            GridView1.DataSourceID = "dsPNotes"
            'BindGridView_Completed()
        Else
            'Only show those IMFs which has not been completed
            GridView1.DataSourceID = "dsPNotes_NoCompleted"
            'BindGridView_NoCompleted()
        End If
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " PNote Requests"
    End Sub
    
    Protected Sub btnMultipleRowUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            Dim checkbox As CheckBox = CType(row.FindControl("cbRows"), CheckBox)

            'Check if the checkbox is checked 
            If checkbox.Checked Then

                'Retreive the IMF ID
                Dim IMFID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected IMF ID to the Delete command.
                dsPNotes_NoCompleted.UpdateParameters("ID").DefaultValue = IMFID.ToString()
                dsPNotes_NoCompleted.UpdateParameters("Date_Closed").DefaultValue = Date.Today
                dsPNotes_NoCompleted.Update()
                GridView1.DataBind()
            End If
        Next row
        lblStatus.Text = "Your checked records have been marked as closed"
    End Sub
    
    Protected Sub btnRejectPnotes_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            Dim checkbox As CheckBox = CType(row.FindControl("cbRows"), CheckBox)

            'Check if the checkbox is checked 
            If checkbox.Checked Then

                'Retreive the IMF ID
                Dim IMFID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected IMF ID to the Delete command.
                dsPNotes_NoCompleted.UpdateParameters("ID").DefaultValue = IMFID.ToString()
                dsPNotes_NoCompleted.UpdateParameters("Rejected").DefaultValue = True
                dsPNotes_NoCompleted.Update()
                GridView1.DataBind()
            End If
        Next row
        lblStatus.Text = "Your checked records have been marked for rejection"
    End Sub
    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Missing PNote Requests - Vangent</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="/js/jquery-1.3.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
                                   
                 <fieldset>
                <legend class="fieldsetLegend">All PNote Requests</legend><br />       
                   <div align="center"> 
                   
                   <!--This one populates the Gridview-->
                             <asp:SqlDataSource ID="dsPNotes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_PNotes_Vangent" SelectCommandType="StoredProcedure" 
                            UpdateCommand="p_PNotes_Vangent_Update" UpdateCommandType="StoredProcedure"
                            DeleteCommand="p_PNotes_Vangent_Delete" DeleteCommandType="StoredProcedure"                           
                            OnSelected="OnSelectedHandler">
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="Date_Closed" Type="DateTime" />
                                <asp:Parameter Name="Rejected" Type="Boolean" />
                             </UpdateParameters>
                             <DeleteParameters>
                                     <asp:Parameter Name="ID" Type="Int32" />
                            </DeleteParameters>
                             </asp:SqlDataSource>
                            
                            <asp:SqlDataSource ID="dsPNotes_NoCompleted" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_PNotes_Vangent_NoCompleted" SelectCommandType="StoredProcedure"
                            UpdateCommand="p_PNotes_Vangent_Update" UpdateCommandType="StoredProcedure"
                            OnSelected="OnSelectedHandler">
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32" />
                                <asp:Parameter Name="Date_Closed" Type="DateTime" />
                                <asp:Parameter Name="Rejected" Type="Boolean" />
                             </UpdateParameters>
                             <DeleteParameters>
                                     <asp:Parameter Name="ID" Type="Int32" />
                            </DeleteParameters>
                             </asp:SqlDataSource>                        
                            
                            <div align="center" width="90%">
                            <asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include Completed PNote Requests? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                            </div>
                            <div class="grid"> 
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsPNotes_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowPaging="true" AllowSorting="true" 
                            PageSize="50">
                            <RowStyle CssClass="row" />
                            <EmptyDataTemplate>
                                  <h3>Your PNotes queue is empty</h3>                                      
                            </EmptyDataTemplate>

                            <Columns>
                                 
                                 <asp:TemplateField>
                                      <ItemTemplate>
                                        <asp:CheckBox ID="cbRows" runat="server"/>
                                      </ItemTemplate>
                                </asp:TemplateField>
                                
                                 <asp:BoundField 
                                    DataField="ID" 
                                    HeaderText="ID" 
                                    SortExpression="ID" />                                 
                                    
                                    <asp:BoundField 
                                    DataField="Date_Entered" 
                                    HeaderText="Submitted" 
                                    SortExpression="Date_Entered" 
                                    DataFormatString="{0:d}" />
                                    
                                     <asp:BoundField 
                                    DataField="AG_Name" 
                                    HeaderText="AG" 
                                    SortExpression="AG_Name" />
                                    
                                    <asp:BoundField 
                                    DataField="Employee" 
                                    HeaderText="Employee" 
                                    SortExpression="Employee" />
                                                                        
                                    <asp:BoundField 
                                    DataField="Borrower_LName" 
                                    HeaderText="Last Name" 
                                    SortExpression="Borrower_LName" />
                                    
                                    <asp:BoundField 
                                    DataField="Borrower_FName" 
                                    HeaderText="First Name" 
                                    SortExpression="Borrower_FName" />
                                    
                                     <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID" />
                                    
                                    <asp:BoundField 
                                    DataField="Debts" 
                                    HeaderText="Debts"
                                    SortExpression="Debts" />
                                    
                                    <asp:BoundField 
                                    DataField="Checked_Images" 
                                    HeaderText="Checked Images"
                                    SortExpression="Checked_Images" />
                                    
                                    <asp:BoundField 
                                    DataField="Checked_DImages" 
                                    HeaderText="Checked DImages"
                                    SortExpression="Checked_DImages" />
                                    
                                    <asp:BoundField 
                                    DataField="Checked_Microfiche" 
                                    HeaderText="Checked Microfiche"
                                    SortExpression="Checked_Microfiche" />
                                    
                                    <asp:BoundField 
                                    DataField="DesiredAction" 
                                    HeaderText="Desired Action"
                                    SortExpression="DesiredAction" />
                                    
                                     <asp:BoundField 
                                    DataField="Comments" 
                                    HeaderText="Comments" 
                                    SortExpression="Comments" />
                                    
                                    <asp:BoundField 
                                    DataField="Date_Closed" 
                                    HeaderText="Date Completed" 
                                    SortExpression="Date_Closed"
                                    DataFormatString="{0:d}" />
                                    
                                    <asp:BoundField 
                                    DataField="Rejected" 
                                    HeaderText="Rejected By Vangent?" 
                                    SortExpression="Rejected" />                                                                           
                    				                                    
                               </Columns>                
                            </asp:GridView>
                             <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /> 
                             <asp:Button ID="btnMultipleRowUpdate" OnClick="btnMultipleRowUpdate_Click" runat="server" Text="Close Checked Records" CssClass="button" />
                            <asp:Button ID="btnRejectPnotes" OnClick="btnRejectPnotes_Click" runat="server" Text="Reject Checked Records" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" OnClientClick='return confirm("Are you sure that you want to reject the checked pNote requests?");' /><br /><br />
                            <asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" />
                            </div>       
                            </fieldset>                                       

<asp:Label ID="lblVangent" runat="server" Visible="true" />
 </form>
</body>
</html>
