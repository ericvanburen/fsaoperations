<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" Debug="true" %>
<%--<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            'If Not IsNothing(Request.Cookies("IMF")) Then
            '      lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
            '  End If

            '  If lblAgency.Text Is Nothing OrElse lblAgency.Text.Length = 0 Then
            '  Response.Redirect("/not.logged.in.aspx")
            '  End If
            
        End If
    End Sub
   
    Sub btnSubmitFeedback_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_InsertFeedback"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        cmd.Parameters.AddWithValue("@Name", SqlDbType.VarChar).Value = txtName.Text
        cmd.Parameters.AddWithValue("@Agency", SqlDbType.VarChar).Value = txtAgency.Text
        cmd.Parameters.AddWithValue("@Email", SqlDbType.VarChar).Value = txtEmail.Text
        cmd.Parameters.AddWithValue("@Type", SqlDbType.VarChar).Value = ddlType.SelectedValue
        cmd.Parameters.AddWithValue("@Product", SqlDbType.VarChar).Value = ddlProduct.SelectedValue
        cmd.Parameters.AddWithValue("@Issue", SqlDbType.VarChar).Value = txtIssue.Text

        Try
            con.Open()
            cmd.Connection = con
            
            cmd.ExecuteScalar()
            lblStatus.Text = "Your submission has been received. Thank you."
            
        Finally
            con.Close()
        End Try      
        
    End Sub  
    
        
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Feedback and Bug Report</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">         
                                                    
                  <div align="center">
                   <asp:Panel ID="pnlFeedbackEntry" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Submit a Bug or Offer Feedback</legend>
                        <table border="0" width="600">
                            <tr>
                                <td align="right" width="50%" class="formLabel">Your Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtName" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" Display="Dynamic" ErrorMessage="* Your Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            
                           <tr>
                                <td align="right" width="50%" class="formLabel">Your Dept/Agency:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtAgency" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAgency" Display="Dynamic" ErrorMessage="* Your Dept or Agency is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            
                            <tr>
                                <td align="right" width="50%" class="formLabel">Your Email Address:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtEmail" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="* Your Email is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Issue Type:</td>
                                <td align="left" width="50%">
                                <asp:Dropdownlist ID="ddlType" runat="server" CssClass="formLabel">
                                     <asp:ListItem Text="Comments/Feedback" Value="Comments/Feedback" />
                                    <asp:ListItem Text="Product Bug" Value="Product Bug" />                                   
                                    <asp:ListItem Text="Technical Issue" Value="Technical Issue" />
                                </asp:Dropdownlist>
                            </tr>   
                            
                            <tr>
                                <td align="right" width="50%" class="formLabel">Product:</td>
                                <td align="left" width="50%">
                                <asp:Dropdownlist ID="ddlProduct" runat="server" CssClass="formLabel">
                                    <asp:ListItem Text="IMF" Value="IMF" />
                                    <asp:ListItem Text="VA Discharge Application" Value="VA App" />
                                </asp:Dropdownlist>
                            </tr>                          
                                                              
                            <tr>
                                <td align="right" width="50%" class="formLabel">Bug/Feedback (please be specific):</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtIssue" runat="server" TextMode="MultiLine" CssClass="formLabel" Rows="5" Columns="40" /></td>
                            </tr>                           
                             <tr>
                                <td align="center" colspan="2"><br /><asp:Button ID="btnSubmitFeedback" runat="server" Text="Submit Feedback" OnClick="btnSubmitFeedback_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"><asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" /></td>
                            </tr>                        
                        </table>
                        </fieldset>                    
                   </asp:Panel>
                   </div>
                  
<asp:Label ID="lblAgency" runat="server" Visible="false" />
 </form>
</body>
</html>
