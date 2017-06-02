<%@ Page Language="VB" EnableEventValidation = "false" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
        End If
    End Sub


    'Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
    '    GridView1.AllowSorting = False
    '    GridView1.AllowPaging = False
    '    Response.Clear()
    '    Response.AddHeader("content-disposition", "attachment;filename=GA.Contacts.xls")
    '    Response.Charset = ""
    '    Response.ContentType = "application/vnd.xls"
    '    Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
    '    Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
    '    GridView1.RenderControl(htmlWrite)
    '    Response.Write(stringWrite.ToString())
    '    Response.End()
    'End Sub
    
    Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Export("GA.Contacts.xls", GridView1)
    End Sub

    Public Shared Sub Export(ByVal fileName As String, ByVal gv As GridView)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As StringWriter = New StringWriter
        Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        '  Create a form to contain the grid
        Dim table As Table = New Table
        table.GridLines = gv.GridLines
        '  add the header row to the table
        If (Not (gv.HeaderRow) Is Nothing) Then
            PrepareControlForExport(gv.HeaderRow)
            table.Rows.Add(gv.HeaderRow)
        End If
        '  add each of the data rows to the table
        For Each row As GridViewRow In gv.Rows
            PrepareControlForExport(row)
            table.Rows.Add(row)
        Next
        '  add the footer row to the table
        If (Not (gv.FooterRow) Is Nothing) Then
            PrepareControlForExport(gv.FooterRow)
            table.Rows.Add(gv.FooterRow)
        End If
            
        '  render the table into the htmlwriter
        table.RenderControl(htw)
        '  render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString)
        HttpContext.Current.Response.End()
    End Sub

    ' Replace any of the contained controls with literals
    Private Shared Sub PrepareControlForExport(ByVal control As Control)
        Dim i As Integer = 0
        Do While (i < control.Controls.Count)
            Dim current As Control = control.Controls(i)
            If (TypeOf current Is LinkButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
            ElseIf (TypeOf current Is ImageButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
            ElseIf (TypeOf current Is HyperLink) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
            ElseIf (TypeOf current Is DropDownList) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
            ElseIf (TypeOf current Is CheckBox) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
                'TODO: Warning!!!, inline IF is not supported ?
            End If
            If current.HasControls Then
                PrepareControlForExport(current)
            End If
            i = (i + 1)
        Loop
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GA Contacts</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
   <script language="javascript" type="text/javascript" src="js/default.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
                    <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsGAContacts" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_GA_Contacts" SelectCommandType="StoredProcedure" />
                      
                       <div class="grid" align="center"> 
                       <asp:Button ID="btnExportExcel2" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" Visible="True" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                       <br /><br />
                       <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" AutoGenerateColumns="false" CellPadding="4"  DataSourceID="dsGAContacts"
                            Width="95%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" AllowSorting="true" 
                            PageSize="15">
                            <RowStyle CssClass="row" />
                            <Columns>                               

                                    <asp:BoundField 
                                    DataField="GA_Name" 
                                    HeaderText="Agency" 
                                    SortExpression="GA_Name" 
                                    ItemStyle-CssClass="first" />
                                    
                                    <asp:BoundField 
                                    DataField="Contact_Name" 
                                    HeaderText="Contact Name" 
                                    SortExpression="Contact_Name" />
                                    
                                    <asp:BoundField 
                                    DataField="Contact_Email" 
                                    HeaderText="Contact Email" 
                                    SortExpression="Contact_Email" />
                                    
                                    <asp:BoundField 
                                    DataField="Contact_Telephone" 
                                    HeaderText="Contact Telephone"
                                    SortExpression="Contact_Telephone" />  
                                   
                                </Columns>                
                            </asp:GridView>
                            <br />
                            <asp:Button ID="btnExportExcel" CssClass="button" runat="server" OnClick="btnExportExcel_Click" Text="Export to Excel" Visible="True" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                            </div>                             
    
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblEDUserName" runat="server" Visible="false" />
    </form>
</body>
</html>
