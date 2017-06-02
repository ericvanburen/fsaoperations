<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb"  MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Dim intId_Team As Integer
        
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            'If we pass a userID and username to this page, then use those to look up the individuals Complaints
            'Otherwise use the cookie values set when the ED employee logged in
            If Not IsNothing(Request.QueryString("UserID")) Then
            
                Dim intEDUserID As String = Request.QueryString("UserID").ToString()
                lblEDUserID.Text = intEDUserID
           
                If Not IsNothing(Request.QueryString("Username")) Then
                    Dim strUsername As String = Request.QueryString("Username").ToString()
                    lblEDUserName.Text = strUsername
                End If
            
            Else
                If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                    lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                    lblEDUserName.Text = (Request.Cookies("IMF")("EDUserName").ToString())
                End If
            End If
                               
        End If
    End Sub
    
   
    
    Protected Sub chkIncludeCompleted_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkIncludeCompleted.Checked Then
            'If its checked, then show all Complaints
            GridView1.DataSourceID = "dsMyComplaints"
        Else
            'Only show those Complaints which has not been completed
            GridView1.DataSourceID = "dsMyComplaints_NoCompleted"
        End If
    End Sub
    
    Private Sub OnSelectedHandler(ByVal source As Object, ByVal e As SqlDataSourceStatusEventArgs)
        Dim cmd As IDbCommand
        cmd = e.Command
        Dim recordCount As Integer = e.AffectedRows()
        lblRecordCount.Text = "Showing " & recordCount & " Complaints"
    End Sub
    
    Sub BindGridView_Completed()
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_MyComplaints"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = lblEDUserID.Text
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
        strSQL = "p_MyComplaints_NoCompleted"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = lblEDUserID.Text
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
            'If its checked, then show all Complaints
            GridView1.DataSourceID = Nothing
            BindGridView_Completed()
        Else
            'Only show those Complaints which has not been completed
            GridView1.DataSourceID = Nothing
            BindGridView_NoCompleted()
        End If
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Complaints.Search.Results.xls")
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
    <title>MY Complaints - ED</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../js/default.js"></script>
</head>
<body>
    <form id="form1" runat="server">                
                
                <fieldset>
                <legend class="fieldsetLegend">IMFs Assigned To (<%=lblEDUserName.Text%>)</legend><br />        
                    
     
     <!--Begin List of complaints here -->
     <asp:SqlDataSource ID="dsMyComplaints" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyComplaints" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblEDUserID" Name="UserID" DefaultValue="0" />                            
                      </SelectParameters>                      
                </asp:SqlDataSource>   
                
                <asp:SqlDataSource ID="dsMyComplaints_NoCompleted" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyComplaints_NoCompleted" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblEDUserID" Name="UserID" DefaultValue="0" />                            
                      </SelectParameters>
                </asp:SqlDataSource> 
                
                  <div align="center"> 
                   <asp:Panel ID="pnlMyComplaints" runat="server">
                  <div align="center" width="90%">
                            <asp:CheckBox ID="chkIncludeCompleted" runat="server" AutoPostBack="true" 
                                    oncheckedchanged="chkIncludeCompleted_CheckedChanged" /> Include Completed Complaints? - <asp:Label ID="lblRecordCount" runat="server" CssClass="warningMessage" />
                  </div>
                            <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="ComplaintID" DataSourceID="dsMyComplaints_NoCompleted" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20" PagerSettings-Position="TopAndBottom">                           
                            
                            <EmptyDataTemplate>
                                    There are no borrower complaints assigned to you
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>                           
                                
                                 <asp:HyperLinkField 
                                    DataTextField="ComplaintID" 
                                    HeaderText="Complaint ID" 
                                    DataNavigateUrlFields="ComplaintID" 
                                    SortExpression="ComplaintID"  
                                    ItemStyle-CssClass="first"
                                    DataNavigateUrlFormatString="complaint.detail.aspx?ComplaintID={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>                                 
                                    
                                    <asp:BoundField 
                                    DataField="Agency_Submission_Date" 
                                    HeaderText="Submitted" 
                                    SortExpression="Agency_Submission_Date" />
                                    
                                    <asp:BoundField 
                                    DataField="Complaint_Type" 
                                    HeaderText="Complaint Type" 
                                    SortExpression="Complaint_Type" />
                                    
                                    <asp:BoundField 
                                    DataField="DebtID" 
                                    HeaderText="Debt ID"
                                    SortExpression="DebtID" />                                                                      
                                                                   
                                    <asp:BoundField 
                                    DataField="PCA_Employee_LName" 
                                    HeaderText="PCA Employee" 
                                    SortExpression="PCA_Employee_LName" />
                                    
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

                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                        </div>  
                        </fieldset>                
                   </asp:Panel>
                   </div></div>         
                        
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />    
 </form>
</body>
</html>
