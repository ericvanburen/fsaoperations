<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and VA page - Call Check Login Status
            CheckVALogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblGA_ID.Text = (Request.Cookies("IMF")("GA_ID").ToString())
            End If
        End If
    End Sub
   
    Sub btnSubmitVAApp_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        
        'Run p_LookupEDUser_VAApp to get available ED users assigned to work VA apps
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        Dim myList As New ArrayList
        Dim count As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_LookupEDUser_VAApp"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con

        Try
            con.Open()
            cmd.Connection = con
            dr = cmd.ExecuteReader()
            
            'Sometimes there may not be an ED Analyst assigned to a VA App
            'If there isn't one, we cannot assign a VA App at random or else this section will fail
            With dr
                If .HasRows Then
                    While .Read
                        myList.Add(dr("UserId"))
                        count += 1
                    End While
                    
                    Dim r As Random = New Random()
                    Dim cnt As Integer
                    For cnt = 0 To myList.Count - 1 Step cnt + 1
                        Dim tmp As Object = myList(cnt)
                        Dim idx As Integer = r.Next(myList.Count - cnt) + cnt
                        myList(cnt) = myList(idx)
                        myList(idx) = tmp
                    Next
                    
                    'We found a user to assign this new VA App to so we'll assign the UserID and DateAssigned to these labels
                    lblRandomUserID.Text = myList(0)
                    lblDateAssigned.Text = DateTime.Now
                End If
            End With
        Finally
            con.Close()
        End Try
        
        'We first need to see if there is already an application for this veteran which has been processed and has been processed (in ID_Status = 1,2,3,14 Completed)
        DupeRecord_Completed()
        
    End Sub
    
    Sub DupeRecord_Completed()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim RecordCount As Integer = 0
        Dim ID As Integer = 0
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_VAAPP_DupeRecord_Completed"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SSN", Trim(txtSSN.Text))
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                RecordCount += RecordCount + 1
                ID = dr("ID")
            End While
            
            If RecordCount > 0 Then
                'We found a duplicate SSN for this person in a ID_Status of 1,2,3,14 which are meets criteria for discharge or returned - Redirect to the Discharge Letter
                Response.Redirect("VA.Discharge.Letter.aspx?code=r45gh98212accd3459CD340q1&ID=" & ID)
            Else 'No records matched
                'We also need to check and see if there are any other VA applications submitted under this same SSN.  If there are, this new VA app 
                'should be assigned to this person rather than the random one we found above
                SSNLookup()
            End If
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    Sub SSNLookup()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_VAAPP_SSNLookup_SSN"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SSN", Trim(txtSSN.Text))
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                If IsDBNull(dr("UserID")) = False Then
                    'We found another VA application in the system under the same SSN so we are going to assign this new one to that person
                    'rather than the random one we found above.  We will overwrite any existing values in lblRandomUserID with this value
                    lblRandomUserID.Text = dr("UserID")
                End If
            End While
        Finally
            strConnection.Close()
        End Try
        
        'Now we have a randomly generated UserID or one found in SSNLookup to assign the VA App to
        InsertNewVAApp()
        
    End Sub
    
    
    Sub InsertNewVAApp()
        
        'Clear any old values in the status label
        lblStatus.Text = ""
        
        Dim strInsert As String
        Dim cmdInsert As SqlCommand
        Dim con As SqlConnection
        Dim intReturnVA_ID As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strInsert = "p_InsertVAApp"
        cmdInsert = New SqlCommand(strInsert)
        cmdInsert.CommandType = CommandType.StoredProcedure
        cmdInsert.Connection = con
        
        cmdInsert.Parameters.AddWithValue("@SSN", SqlDbType.VarChar).Value = txtSSN.Text
        cmdInsert.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = txtBorrower_FName.Text
        cmdInsert.Parameters.AddWithValue("@Borrower_LName", SqlDbType.SmallDateTime).Value = txtBorrower_LName.Text
        cmdInsert.Parameters.AddWithValue("@GA_ID", SqlDbType.VarChar).Value = lblGA_ID.Text
        cmdInsert.Parameters.AddWithValue("@GA_Employee", SqlDbType.VarChar).Value = txtGA_Employee.Text
        cmdInsert.Parameters.AddWithValue("@GA_Phone", SqlDbType.VarChar).Value = txtGA_Phone.Text
        cmdInsert.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        cmdInsert.Parameters.AddWithValue("@Disability_Type1", SqlDbType.Bit).Value = chkDisability_Type1.Checked
        cmdInsert.Parameters.AddWithValue("@Disability_Type2", SqlDbType.Bit).Value = chkDisability_Type2.Checked
        If txtDisability_Effective_Date.Text <> "" Then
            cmdInsert.Parameters.AddWithValue("@Disability_Effective_Date", SqlDbType.VarChar).Value = txtDisability_Effective_Date.Text
        Else
            cmdInsert.Parameters.AddWithValue("@Disability_Effective_Date", SqlDbType.VarChar).Value = DBNull.Value
        End If
        'Randomly assign UserID from values found in p_LookupEDUser_VAApp above if there is one
        If lblRandomUserID.Text <> "" AndAlso lblRandomUserID.Text.Length > 0 Then
            cmdInsert.Parameters.AddWithValue("@UserID", SqlDbType.Int).Value = Convert.ToInt32(lblRandomUserID.Text)
        End If
        
        'New VA Apps will intially receive a Status value of 9 which is Received
        cmdInsert.Parameters.AddWithValue("@ID_Status", SqlDbType.Int).Value = 9
        
        'Attachment1 URL
        Dim strFileNamePath As String = Filebox.PostedFile.FileName
        If strFileNamePath.Length > 0 Then
        
            Dim strFileNameOnly As String
            Dim strSaveLocation As String
            
            strFileNameOnly = lblGA_ID.Text & "." & System.IO.Path.GetFileName(Filebox.PostedFile.FileName)
            strFileNameOnly = ReplaceIllegalChars(strFileNameOnly)
            strFileNameOnly = GenerateRandomFileName(8) & "." & strFileNameOnly
            
            'This checks for a valid file name and type
            Dim Filename2Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
            If Not Filename2Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("invalid.filetype.aspx")
            End If
            
            strSaveLocation = "D:\DCS\secure\IMF_ED\x49g\vaapps\" & strFileNameOnly
            Filebox.PostedFile.SaveAs(strSaveLocation)
            cmdInsert.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/vaapps/" & strFileNameOnly
        Else
            cmdInsert.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'If we found a random user to assign this VA App to, the DateAssigned date should be today. Otherwise, it should be null 
        If lblDateAssigned.Text <> "" AndAlso lblDateAssigned.Text.Length > 0 Then
            cmdInsert.Parameters.AddWithValue("@DateAssigned", SqlDbType.DateTime).Value = lblDateAssigned.Text
        Else
            cmdInsert.Parameters.AddWithValue("@DateAssigned", SqlDbType.DateTime).Value = DBNull.Value
        End If
         
        Try
            con.Open()
            intReturnVA_ID = cmdInsert.ExecuteScalar()
            lblStatus.Text = "Your VA Discharge Application has been received. Your request number is " & intReturnVA_ID
        Finally
            con.Close()
        End Try
    End Sub
    
    Public Function GenerateRandomFileName(ByVal PwdLength As Integer) As String
        Dim _allowedChars As String = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789"
        Dim rndNum As New Random()
        Dim chars(PwdLength - 1) As Char
        Dim strLength As Integer = _allowedChars.Length
        For i As Integer = 0 To PwdLength - 1
            chars(i) = _allowedChars.Chars(CInt(Fix((_allowedChars.Length) * rndNum.NextDouble())))
        Next i
        Return New String(chars)
    End Function
    
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
        
   </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add VA Discharge Application</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">  
                                                                    
                  <div align="center">
                   <asp:Panel ID="pnlVAAppEntry" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Submit a New VA Disability Discharge Application</legend>
                        <table border="0" width="90%">
                           
                            <tr>
                                 <td align="right" width="25%" class="formLabel" colspan="1">SSN:</td>
                                <td align="left" colspan="3">
                                <asp:TextBox ID="txtSSN" runat="server" MaxLength="9" CssClass="formLabel" /><br />
                                <asp:RequiredFieldValidator ID="rf_SSN" runat="server" ControlToValidate="txtSSN" Display="Dynamic" ErrorMessage="* A SSN is Required *" SetFocusOnError="true" CssClass="warningMessage" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ControlToValidate="txtSSN" ErrorMessage="* Please enter a valid 9 digit SSN ######### (no dashes) *" CssClass="warningMessage" ValidationExpression="\d{9}" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="25%" class="formLabel">Borrower First Name:</td>
                                <td align="left" width="25%">
                                <asp:Textbox ID="txtBorrower_FName" runat="server" CssClass="formLabel" /><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtBorrower_FName" Display="Dynamic" ErrorMessage="* A Borrower First Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                                <td align="right" width="25%" class="formLabel">Borrower Last Name:</td>
                                <td align="left" width="25%">
                                <asp:Textbox ID="txtBorrower_LName" runat="server" CssClass="formLabel" /><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtBorrower_LName" Display="Dynamic" ErrorMessage="* A Borrower Last Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                             <tr>                               
                                <td align="right" width="25%" class="formLabel">Disability Type:</td>
                                <td align="left" width="25%">
                                     <asp:Checkbox ID="chkDisability_Type1" runat="server"  Text="The veteran has a service-connected disability that is 100% disabling" CssClass="formLabel"  /><br />
                                     <asp:Checkbox ID="chkDisability_Type2" runat="server" Text="The veteran is totally disabled based on an individual unemployability determination" CssClass="formLabel"  />
                                </td>
                                <td align="right" width="25%" class="formLabel">Effective Date of Disability: (mm/dd/yyyy)</td>
                                <td align="left" width="25%"><asp:Textbox ID="txtDisability_Effective_Date" runat="server" CssClass="formLabel" /><br />
                                <span class="smallText">If both types of disability are selected enter the earliest effective date</span></td>
                            </tr>                      
                            <tr>                                
                                <td align="right" width="25%" class="formLabel">GA Employee Name:</td>
                                <td align="left" width="25%">
                                <asp:Textbox ID="txtGA_Employee" runat="server" CssClass="formLabel" /><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtGA_Employee" Display="Dynamic" ErrorMessage="* A GA Employee Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                                 <td align="right" width="25%" class="formLabel">GA Employee Email:</td>
                                <td align="left" width="25%"><asp:Textbox ID="txtGA_Email" runat="server" CssClass="formLabel" /></td>
                            </tr>                           
                            <tr>
                                <td align="right" width="25%" class="formLabel">GA Employee Phone:</td>
                                <td align="left" width="25%"><asp:Textbox ID="txtGA_Phone" runat="server" CssClass="formLabel" /></td>
                                <td align="right" width="25%"> </td>
                                <td align="left" width="25%"> </td>
                            </tr>     
                                                       
                            <tr>
                                <td align="right" width="25%" class="formLabel">Comments:</td>
                                <td align="left" colspan="3"><asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" CssClass="formLabel" Rows="5" Columns="40" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="25%" class="formLabel">Attachment:</td>
                                <td align="left" colspan="3"><input id="Filebox" type="File" runat="server" size="35" /><br />
                                <span class="warningMessage">* If submitting an attachment, please ensure that 
                                    your file name has a <a href="file.types.htm" target="name" onclick="window.open('file.types.htm','name','height=255, width=250,toolbar=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no'); return false;">valid file extension</a>.</span><br />
                                <asp:RequiredFieldValidator ID="rf_Filebox" runat="server" ControlToValidate="Filebox" Display="Dynamic" ErrorMessage="* You must upload supporting documentation with this request *" CssClass="warningMessage" /></td>
                            </tr>                            
                             <tr>
                                <td align="center" colspan="4"><br /><asp:Button ID="btnSubmitVAApp" runat="server" Text="Submit VA Discharge App" OnClick="btnSubmitVAApp_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /></td>
                            </tr>
                            <tr>
                                <td colspan="4" align="center"><asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" /></td>
                            </tr>                        
                        </table>
                        </fieldset>                    
                   </asp:Panel>
                   </div>
                  
<asp:Label ID="lblGA_ID" runat="server" Visible="false" />
<asp:Label ID="lblRandomUserID" runat="server" Visible="false" />
<asp:Label ID="lblDateAssigned" runat="server" Visible="false" />
 </form>
</body>
</html>
