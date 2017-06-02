<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        
        If Not Page.IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            Dim intID As Integer = Request.QueryString("ID")
            lblID.Text = intID
            
            If Not IsNothing(Request.Cookies("IMF")("AG")) Then
                'PCA is looking at the employee
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString()) 'This contains their agency number code
                'lblAgency.Text = "537"
            End If
            
            lblUploadPath.Text = System.Configuration.ConfigurationManager.AppSettings("UploadPath").ToString
        End If
    End Sub
    
    Protected Sub btnUploadForm_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_PCAEmployeeUploadFFEL_Login_RequestForm"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("AG", lblAgency.Text)
        cmd.Parameters.AddWithValue("@AG_Employee_Name", txtAG_Employee_Name.Text)
        cmd.Parameters.AddWithValue("@ActionTaken", ddlActionTaken.SelectedValue)
        
        'FFEL Login Request Attachment
        Dim strFileNamePath As String = Filebox.PostedFile.FileName
        If strFileNamePath.Length > 0 Then
        
            Dim strFileNameOnly As String
            Dim strSaveLocation As String
            
            strFileNameOnly = lblAgency.Text & "_" & System.IO.Path.GetFileName(Filebox.PostedFile.FileName)
            
            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|jpg|txt|gif|png)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly = ReplaceIllegalChars(strFileNameOnly)
            'strSaveLocation = "D:\DCS\secure\IMF_ED\x49g\pca\employees\ffel\" & strFileNameOnly
            strSaveLocation = lblUploadPath.Text & "pca\employees\ffel\" & strFileNameOnly
            Filebox.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@FFEL_Login_Attachment", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            cmd.Parameters.Add("@FFEL_Login_Attachment", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'If the ActionTaken dropdown equals one of these values, then this field needs to be populated with todays date:
        'UserID_Request_Date (Date User ID Requested)
        If ddlActionTaken.SelectedValue = "Add" OrElse ddlActionTaken.SelectedValue = "Assign – New" Then
            cmd.Parameters.Add("@UserID_Request_Date", SqlDbType.SmallDateTime).Value = DateTime.Now()
        End If
              
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        btnUploadForm.Visible = False
        lblUpdateStatus.Text = "Your FFEL Login Request form has been received.  Please click the Close Window button to return to the Employee Details screen."
        btnRedirect.Visible = True

    End Sub
    
    Private Function ReplaceIllegalChars(ByVal NewFileName As String) As String
        NewFileName = Replace(NewFileName, "#", "")
        NewFileName = Replace(NewFileName, "%", "")
        NewFileName = Replace(NewFileName, "%", "")
        NewFileName = Replace(NewFileName, "&", "")
        NewFileName = Replace(NewFileName, "*", "")
        NewFileName = Replace(NewFileName, "{", "")
        NewFileName = Replace(NewFileName, "}", "")
        NewFileName = Replace(NewFileName, "\", "")
        NewFileName = Replace(NewFileName, ":", "")
        NewFileName = Replace(NewFileName, "<", "")
        NewFileName = Replace(NewFileName, ">", "")
        NewFileName = Replace(NewFileName, "?", "")
        NewFileName = Replace(NewFileName, "/", "")
        NewFileName = Replace(NewFileName, " ", "")
        Return NewFileName
    End Function
    
    Protected Sub btnRedirect_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("employee.detail.aspx?ID=" & lblID.Text)
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FFEL Login Form</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script src="js/scripts.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
     <fieldset>
    <legend class="fieldsetLegend">FFEL Login Form</legend><br />    
    <div align="left">
    <table>
    <tr>
            <td align="right" width="50%" class="formLabel">PCA Employee Name (your name)</td>
             <td align="left" width="50%"><asp:TextBox ID="txtAG_Employee_Name" runat="server" /></td>
     </tr>
    <tr>
            <td align="right" width="50%" class="formLabel">Request Type:</td>
             <td align="left" width="50%">
             <asp:DropDownList ID="ddlActionTaken" runat="server" class="formLabel">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Add" Value="Add" />
                    <asp:ListItem Text="Assign – New" Value="Assign – New" />
                    <asp:ListItem Text="Change" Value="Change" />
                    <asp:ListItem Text="Delete" Value="Delete" />
                    <asp:ListItem Text="Reinstate" Value="Reinstate" />               
             </asp:DropDownList>
             </td>
     </tr>
    <tr>
            <td align="right" width="50%" class="formLabel">Click Browse to Upload Form:</td>
             <td align="left" width="50%"><input id="Filebox" type="File" runat="server" size="35" class="button" /><br />
             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Please click Browse to upload yourFFEL Login Request form *" Display="Dynamic" CssClass="warningMessage" ControlToValidate="Filebox" /></td>
     </tr>
     <tr>
            <td colspan="2" align="center"><br /><asp:Button ID="btnUploadForm" runat="server" Text="Upload Form" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" OnClick="btnUploadForm_Click" />
            <asp:Button ID="btnRedirect" runat="server" Text="Close Window" Visible="false" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button" OnClientClick="refreshParent()" />
</td>
     </tr>
     <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" /></td>
     </tr>
    </table>    
    </div>
    </fieldset>
    
    <asp:Label ID="lblID" runat="server" Visible="false" />
    <asp:Label ID="lblAgency" runat="server" Visible="True" />
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblUploadPath" runat="server" Visible="false" />
    </form>
</body>
</html>
