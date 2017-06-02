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
            End If
            
            lblUploadPath.Text = System.Configuration.ConfigurationManager.AppSettings("UploadPath").ToString
        End If
    End Sub
    
    Protected Sub btnUploadForm_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_PCAEmployeeUploadPATForm"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        
        'PAT Attachment
        Dim strFileNamePath As String = Filebox.PostedFile.FileName
        If strFileNamePath.Length > 0 Then
        
            Dim strFileNameOnly As String
            Dim strSaveLocation As String
            
            'Sometimes ED uploads a form for the agency so the lblAgency value might be null
            If lblAgency.Text.Length = 0 Then
                strFileNameOnly = "ED_" & System.IO.Path.GetFileName(Filebox.PostedFile.FileName)
            Else
                strFileNameOnly = lblAgency.Text & "_" & System.IO.Path.GetFileName(Filebox.PostedFile.FileName)
            End If
           
            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|jpg|txt|gif|png)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly = ReplaceIllegalChars(strFileNameOnly)
            'strSaveLocation = "d:\DCS\secure\IMF_ED\x49g\pca\employees\pat\" & strFileNameOnly
            strSaveLocation = lblUploadPath.Text & "pca\employees\pat\" & strFileNameOnly
            Filebox.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@PAT_Attachment", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            cmd.Parameters.Add("@PAT_Attachment", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'This is the date the original PAT training was completed which may be different from the date that the form was uploaded
        cmd.Parameters.Add("@Pat_Date_Original", SqlDbType.SmallDateTime).Value = txtPAT_Date_Original.Text
        
        'This is the date subsequent (annual) PAT trainings were completed.  
        cmd.Parameters.Add("@Pat_Date_Last", SqlDbType.SmallDateTime).Value = txtPAT_Date_Last.Text
        
        cmd.Parameters.Add("@Contract_Start_Date", SqlDbType.SmallDateTime).Value = txtContract_Start_Date.Text
        
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        btnUploadForm.Visible = False
        lblUpdateStatus.Text = "Your PAT form has been received. Please click the Close Window button to return to the Employee Details screen."
        btnRedirect.Visible = True
        
        'Now reset the Accept form by ED value
        ResetAcceptFormValue()
    End Sub
    
    Sub ResetAcceptFormValue()
        'Sometimes the PCAs need to resubmit a PAT form because a previous one was rejected or not approved by ED and there may be an old
        'value in the field PAT_Attachment_Accepted_By_ED so we need to set that back to it's original value = NULL
        
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_PCAEmployeeResetAcceptFormValue"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("@FormType", "PAT")
        
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
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
        NewFileName = Replace(NewFileName, ",", ".")
        Return NewFileName
    End Function
    
    Protected Sub btnRedirect_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("employee.detail.aspx?ID=" & lblID.Text)
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Privacy Act Training  (PAT) Form</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script src="../js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        $(document).ready(function() {
            $('#btnUploadForm').click(
                function() {
                    var ContractStartDate = new Date($('#txtContract_Start_Date').val());
                    var PATDate = new Date($('#txtPAT_Date_Original').val());

                    if (ContractStartDate < PATDate) {
                        alert("The Contract Start Date must be the same or later than the date the Privacy Act Training was completed");
                        return false;
                    }
                });
        });        
</script>
    <script src="js/scripts.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">

     <fieldset>
    <legend class="fieldsetLegend">Upload Privacy Act Training  (PAT) Form</legend><br />    
    <div align="left">
    <table>
     <tr>
            <td align="right" width="50%" class="formLabel">Date Original Privacy Act Training (PAT) Completed:</td>
             <td align="left" width="50%"><asp:Textbox ID="txtPAT_Date_Original" runat="server" /> (mm/dd/yyyy)<br />
             <asp:RequiredFieldValidator ID="rfPAT_Date_Original" runat="server" ErrorMessage="* Please enter the date the original Privacy Act Training (PAT) was completed *" CssClass="warningMessage" Display="Dynamic" ControlToValidate="txtPAT_Date_Original" />
             <asp:CompareValidator ID="dateValidator" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtPAT_Date_Original" ErrorMessage="* Please enter a valid date (mm/dd/yyyy) *" CssClass="warningMessage" Display="Dynamic" /></td>
     </tr>
     <tr>
            <td align="right" width="50%" class="formLabel">Date LAst Privacy Act Training (PAT) Completed:</td>
             <td align="left" width="50%"><asp:Textbox ID="txtPAT_Date_Last" runat="server" /> (mm/dd/yyyy)<br />
             <asp:RequiredFieldValidator ID="rfPAT_Date_Last" runat="server" ErrorMessage="* Please enter the date the last Privacy Act Training (PAT) was completed *" CssClass="warningMessage" Display="Dynamic" ControlToValidate="txtPAT_Date_Last" />
             <asp:CompareValidator ID="CompareValidator2" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtPAT_Date_Last" ErrorMessage="* Please enter a valid date (mm/dd/yyyy) *" CssClass="warningMessage" Display="Dynamic" /></td>
     </tr>
     <tr>
            <td align="right" width="50%" class="formLabel">Contract Start Date:</td>
             <td align="left" width="50%"><asp:Textbox ID="txtContract_Start_Date" runat="server" /> (mm/dd/yyyy)<br />
             <asp:RequiredFieldValidator ID="rfContract_Start_Date" runat="server" ErrorMessage="* Please enter the Contract Start Date *" CssClass="warningMessage" Display="Dynamic" ControlToValidate="txtContract_Start_Date" />
             <asp:CompareValidator ID="CompareValidator1" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtContract_Start_Date" ErrorMessage="* Please enter a valid date (mm/dd/yyyy) *" CssClass="warningMessage" Display="Dynamic" /></td>
     </tr>
    <tr>
            <td align="right" width="50%" class="formLabel">Click Browse to Upload Form:</td>
             <td align="left" width="50%"><input id="Filebox" type="File" runat="server" size="35" class="button" /><br />
             <asp:RequiredFieldValidator ID="rf_Filebox" runat="server" ControlToValidate="Filebox" Display="Dynamic" ErrorMessage="* You must upload a completed PAT form with this request *" CssClass="warningMessage" /></td>
     </tr>
     <tr>
            <td colspan="2" align="center"><br />
            <asp:Button ID="btnUploadForm" runat="server" Text="Upload Form" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" OnClick="btnUploadForm_Click" />
            <asp:Button ID="btnRedirect" runat="server" Text="Close Window" Visible="false" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'"  OnClientClick="refreshParent()" /></td>
     </tr>
     <tr>
            <td colspan="2" align="center"><asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" /></td>
     </tr>
    </table>    
    </div>
    </fieldset>
    
    <asp:Label ID="lblID" runat="server" Visible="false" />
    <asp:Label ID="lblAgency" runat="server" Visible="True" />
    <asp:Label ID="lblUploadPath" runat="server" Visible="false" />
  </form>
</body>
</html>
