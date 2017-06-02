﻿<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"  MaintainScrollPositionOnPostback="true" %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Dim intId_Team As Integer
    Dim strTeam_Name As String
    Dim blnIsActive, blnIsAdmin, blnProcessVAApps As Boolean
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            'If we pass a userID and username to this page, then use those to look up the individuals IMFs
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
            
            'Bind the individual user details
            BindUserName()
            
            'Bind the associated IMF Types for this user
            BindIMFTypes()
            
            'Bind the all agencies
            BindAllAgencies()
            
        End If
    End Sub
    
    Sub BindUserName()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblEDUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                
                If IsDBNull(dr("IsActive")) = False Then
                    blnIsActive = dr("IsActive")
                End If
                
                If IsDBNull(dr("IsAdmin")) = False Then
                    blnIsAdmin = dr("IsAdmin")
                End If
                
                If IsDBNull(dr("ProcessVAApps")) = False Then
                    blnProcessVAApps = dr("ProcessVAApps")
                End If
                         		
                If IsDBNull(dr("Id_Team")) = False Then
                    ddlTeam_Name.SelectedIndex = ddlTeam_Name.Items.IndexOf(ddlTeam_Name.Items.FindByValue(dr("Id_Team")))
                End If
           	
            End While
				
            Page.DataBind()
        
        Finally
            dr.Close()
            strConnection.Close()
        End Try
    End Sub
    
  
    Public Sub BindIMFTypes()
        
        'This section binds the Checkboxlist, cblIMFTypes with all of the IMF Types
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_IMFTypes"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
      
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cblIMFTypes.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            cblIMFTypes.DataTextField = "IMF_Type"
            cblIMFTypes.DataValueField = "IMF_ID"
            cblIMFTypes.DataBind()
        Finally
            strConnection.Close()
        End Try
        
        'After all of the IMF Types have been bound to the checkboxlist, cblIMFTypes, we now bind the IMF Types assigned to the user
        BindIMFTYpes_Assigned()
    End Sub
    
    Sub BindIMFTYpes_Assigned()
        'This part binds the selected IMF Types that have been selected from  v_EDUsers_IMFTypes assigned to the ED user    
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_EDUserIMFTypes"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblEDUserID.Text)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()

            While dr.Read()
                Dim currentCheckBox As ListItem = cblIMFTypes.Items.FindByValue(dr("IMF_ID").ToString())
                If Not (currentCheckBox Is Nothing) Then
                    currentCheckBox.Selected = True
                End If
            End While
        Finally
            strConnection.Close()
        End Try
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
        strSQL = "p_MyIMFs"
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
        strSQL = "p_MyIMFs_NoCompleted"
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
    
    Public Sub BindAllAgencies()
        
        'This section binds the Checkboxlist, cblAgencies, with all of the Agencies
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_AllAgencies"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
      
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cblAgencies.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            cblAgencies.DataTextField = "AG_Name"
            cblAgencies.DataValueField = "AG"
            cblAgencies.DataBind()
        Finally
            strConnection.Close()
        End Try
        
        'After all of the agencies have been bound to the checkboxlist, cblAgencies, we now bind the agencies assigned to the team
        BindAgencies_Assigned()
    End Sub
    
    Sub BindAgencies_Assigned()
        'This part binds the selected agencies that have been selected from  v_EDTeams_Agencies to the ED team    
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_EDTeamAgencies"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Id_Team", ddlTeam_Name.SelectedValue)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()

            While dr.Read()
                Dim currentCheckBox As ListItem = cblAgencies.Items.FindByValue(dr("AG").ToString())
                If Not (currentCheckBox Is Nothing) Then
                    currentCheckBox.Selected = True
                End If
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub
    
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MY IMFs - ED</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/default.js"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function() {
            $("#myStatus").hide();
        });
    </script>
    
    
</head>
<body>
    <form id="form1" runat="server">                
                
                <fieldset>
                <legend class="fieldsetLegend">IMFs Assigned To (<%=lblEDUserName.Text%>)</legend><br />        
                <a href="#" id="triggerMyStatus">+/- Hide/Show My Account Details</a>
                
                <div id="myStatus">
                               
              <table border="0">             
        <tr>
            <td class ="formLabelForm">Is your  account active?</td>
            <td><asp:CheckBox ID="chkIsActive" runat="server" Checked='<%# blnIsActive %>' onclick="return false;" /></td>            
        </tr>
        <tr>
            <td class ="formLabelForm">Are you an administrator?</td>
            <td><asp:CheckBox ID="chkIsAdmin" runat="server" Checked='<%# blnIsAdmin %>' onclick="return false;" /></td>            
        </tr>
         <tr>
            <td class ="formLabelForm">Are you able to process VA Discharge Apps?</td>
            <td><asp:CheckBox ID="chkProcessVAApps" runat="server" Checked='<%# blnProcessVAApps %>' onclick="return false;" /></td>            
        </tr>                
        <tr>
            <td class ="formLabelForm">Your team assignment:</td>
            <td><asp:Dropdownlist ID="ddlTeam_Name" runat="server" onclick="return false;">
                          <asp:ListItem Text="Team 1" Value="1" />
                          <asp:ListItem Text="Team 2" Value="2" />
                          <asp:ListItem Text="Team 3" Value="3" />
                 </asp:Dropdownlist>                      
            </td>            
        </tr>       
         
        <tr>
            <td class ="formLabelForm" valign="top">Your assigned IMF types:</td>
            <td>     
                    <asp:CheckBoxList ID="cblIMFTypes" runat="server" onclick="return false;"  
                       CssClass="formLabel" RepeatColumns="2">                    
                    </asp:CheckBoxList>                    
               </td>              
            </tr>
            <tr>
            <td class ="formLabelForm" valign="top">Assigned Agencies:</td>
            <td>     
                    <asp:CheckBoxList ID="cblAgencies" runat="server" onclick="return false;" 
                       CssClass="formLabel" RepeatColumns="2">                    
                    </asp:CheckBoxList>
               </td>              
            </tr>          
        </table>    
        <hr />
       </div>         
     
     <!--Begin List of IMFs here -->
     <asp:SqlDataSource ID="dsMyIMFs" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyIMFs" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblEDUserID" Name="UserID" DefaultValue="0" />                            
                      </SelectParameters>                      
                </asp:SqlDataSource>   
                
                <asp:SqlDataSource ID="dsMyIMFs_NoCompleted" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_MyIMFs_NoCompleted" SelectCommandType="StoredProcedure" OnSelected="OnSelectedHandler">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblEDUserID" Name="UserID" DefaultValue="0" />                            
                      </SelectParameters>
                </asp:SqlDataSource> 
                
                  <div align="center"> 
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
                                    There are no IMFs assigned to this Analyst
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
                                    
                                    <asp:BoundField 
                                    DataField="DaysSinceReAssigned" 
                                    HeaderText="Days Since ReAssigned"
                                    ItemStyle-HorizontalAlign="Right" 
                                    HeaderStyle-HorizontalAlign="Right" 
                                    SortExpression="DaysSinceReAssigned" />                                    
                                    
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
                        </fieldset>                
                   </asp:Panel>
                   </div></div>         
                        
   
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserName" runat="server" Visible="false" />    
 </form>
</body>
</html>
