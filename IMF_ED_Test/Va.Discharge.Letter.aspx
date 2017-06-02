<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" Debug="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and VA page - Call Check Login Status
            CheckVALogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblGA_ID.Text = (Request.Cookies("IMF")("GA_ID").ToString())
            End If
            
            Dim intID As Integer = Request.QueryString("ID")
            lblID.Text = intID
            
            'We are going to put this extra security measure for safety which makes sure that the only way to get to this page is from the the 
            'VA.App.VA.aspx page which passes this code to this page
            Dim code As String = Request.QueryString("code")
            If code <> "r45gh98212accd3459CD340q1" Then
                Response.Redirect("not.authorized.aspx")
            End If
            
            DupeRecord_Completed()
            
        End If
    End Sub
    
    Sub DupeRecord_Completed()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_VAAPP_DupeRecord_Completed_ID"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", Trim(lblID.Text))
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
           
            With dr
                If .HasRows Then
                    While .Read
                        'Make the letter visible
                        lblSSN.Text = dr("SSN")
                        lblDisability_Effective_Date.Text = dr("Disability_Effective_Date").ToString()
                    End While
                End If
            End With
            
            'Set the date of the letter
            lblTodaysDate.Text = Date.Today()
                        
        Finally
            strConnection.Close()
        End Try
    End Sub

    Protected Sub btnExportWord_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Image1.Visible = True
        btnExportWord.Visible = False
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=Discharge.Letter.doc")
        Response.Charset = ""
        Response.ContentType = "application/vnd.word"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        Me.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">

<table width="90%">
<tr>
    <td align="left"> <p><asp:Image ID="Image1" runat="server" ImageUrl="https://www.fsacollections.ed.gov/secure/imf_ed/images/fsa_logo.plain.gif" Visible="false" /></p>
   <p align="center"><asp:Label ID="lblTodaysDate" runat="server" 
           style="font-family: Arial, Helvetica, sans-serif; font-weight: 700" /></p>
  
   <p><span class="style1">The Department has previously concluded a review of a 
       Veteran's Discharge Application submitted under this social security number. The 
       Department has concluded that the individual with SSN </span> 
       <asp:Label ID="lblSSN" runat="server" CssClass="style1" /> <span class="style1">
       meets the criteria for discharge under the Section 437(a) of the Higher 
       Education Act of 1965. The effective date of the applicant's condition is </span> 
       <asp:Label ID="lblDisability_Effective_Date" runat="server" CssClass="style1" />
       <span class="style1">. You may print this screen and use as documentation for 
       your records that the individual meets the criteria for loan discharge.</span></p>

<p align="center"><asp:Button ID="btnExportWord" runat="server" Text="Export to Microsoft Word" onclick="btnExportWord_Click" /></p></td>
</tr>
</table>
 
    </div>
    <asp:Label ID="lblGA_ID" runat="server" Visible="false" />
    <asp:Label ID="lblID" runat="server" Visible="false" />
 
  </form>
</body>
</html>
