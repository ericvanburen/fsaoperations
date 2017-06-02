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
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
            End If
            
            'If lblAgency.Text Is Nothing OrElse lblAgency.Text.Length = 0 Then
            'Response.Redirect("/not.logged.in.aspx")
            'End If
            
            lblUploadPath.Text = System.Configuration.ConfigurationManager.AppSettings("UploadPath").ToString
            
        End If
    End Sub
   
    Sub btnSubmitIMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'We first need to check whether this is an ED IMF or Vangent IMF
        'If its vangent then we jump right to GetRandom_DRGUser()
        If lblIMF_Owner.Text = "Vangent" Then
            LookupVangentQueue()
        Else
            Dim strSQL As String
            Dim cmd As SqlCommand
            Dim con As SqlConnection
            Dim dr As SqlDataReader
            Dim myList As New ArrayList
            Dim count As Integer
        
            con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
            strSQL = "p_CheckDuplicateDebtID"
            cmd = New SqlCommand(strSQL)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
        
            cmd.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = txtDebtID.Text
            cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.Int).Value = ddlIMF_Type.SelectedValue

            Try
                con.Open()
                cmd.Connection = con
                dr = cmd.ExecuteReader()
            
                'If an ED analyst is already assigned to a DebtID we need to assign this additional one to him/her
                With dr
                    If .HasRows Then
                        While .Read
                            'We found a user to assign this new IMF to so we'll assign the UserID and DateAssigned to these labels  
                            'If dr("UserID").ToString.Length > 1 Then
                            'myList.Add(dr("UserId"))
                            'lblExistingUserID.Text = myList(0)
                            'End If
                            'If dr("IMF_ID").ToString.Length > 1 Then
                            'myList.Add(dr("IMF_ID"))
                            'lblExistingIMF_ID.Text = myList(1)
                            'End If
                            If IsDBNull(dr("UserID")) = False Then
                                lblExistingUserID.Text = dr("UserID")
                            End If
                            If IsDBNull(dr("IMF_ID")) = False Then
                                lblExistingIMF_ID.Text = dr("IMF_ID")
                            End If
                            
                            count += 1
                        End While
                                       
                        lblDateAssigned.Text = DateTime.Now
                               
                        'Insert the new IMF
                        InsertNewIMF()
                    Else
                        'This DebtID isn't already assigned to another ED analyst so we'll call the Random UserID function
                        'Now we have a randomly generated UserID to assign the IMF to based on AG and IMF Type
                        GetRandom_EDUser()
                    End If
                End With
            
            Finally
                con.Close()
            End Try
        End If
    End Sub
    
    
    Sub GetRandom_EDUser()
        'This sub gets called only if the debtID being submitted isn't already assigned to another ED analyst
        'Run p_LookupEDUser_AG_IMFType to get available ED users assigned to this AG and IMF Type
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        Dim myList As New ArrayList
        Dim count As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_LookupEDUser_AG_IMFType"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = ddlIMF_Type.SelectedValue
        cmd.Parameters.AddWithValue("@AG", SqlDbType.Int).Value = lblAgency.Text
        Try
            con.Open()
            cmd.Connection = con
            dr = cmd.ExecuteReader()
            
            'Sometimes there may not be an ED Analyst assigned to a specific IMF Type
            'If there isn't one, we cannot assign an IMF at random or else this section will fail
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
                    
                    'We found a user to assign this new IMF to so we'll assign the UserID and DateAssigned to these labels
                    'This little hack was added to accomodate the long-term absence of Quincey McDaniel.
                    'Doug wants these imf types to go to Don Kimble or Pam Wright
                    'don = 35
                    'pam = 37
                    'not on file = 16
                    'privacy act certification letter = 24
                    'death verification requests = 27
                    'w-32 requests 30
                    
                    Dim intIMF_TypeValue As Integer = ddlIMF_Type.SelectedValue
                    If intIMF_TypeValue = 16 OrElse intIMF_TypeValue = 24 Then
                        'Assign these 2 IMF types to Don - 35
                        lblRandomUserID.Text = "35"
                    ElseIf intIMF_TypeValue = 27 OrElse intIMF_TypeValue = 30 Then
                        'Assign these 2 IMF types to Pam - 37
                        lblRandomUserID.Text = "37"
                    Else
                        'Just use the values found in the random function
                        lblRandomUserID.Text = myList(0)
                        lblDateAssigned.Text = DateTime.Now
                    End If
                End If
            End With
            
        Finally
            con.Close()
        End Try
        
        'Now we have a randomly generated UserID to assign the IMF to based on AG and IMF Type
        InsertNewIMF()
        
    End Sub
    
    Sub InsertNewIMF()
        
        If Page.IsValid Then
        
            'Clear any old values in the status label
            lblStatus.Text = ""
        
            Dim strInsert As String
            Dim cmdInsert As SqlCommand
            Dim con As SqlConnection
            Dim intReturnIMF_ID As Integer
        
            con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
            strInsert = "p_InsertIMF"
            cmdInsert = New SqlCommand(strInsert)
            cmdInsert.CommandType = CommandType.StoredProcedure
            cmdInsert.Connection = con
        
            cmdInsert.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = ddlIMF_Type.SelectedValue
            cmdInsert.Parameters.AddWithValue("@SSN", SqlDbType.VarChar).Value = txtSSN.Text
            cmdInsert.Parameters.AddWithValue("@DateSubmitted", SqlDbType.DateTime).Value = Now()
            cmdInsert.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = txtDebtID.Text
            cmdInsert.Parameters.AddWithValue("@DMCS2ID", SqlDbType.VarChar).Value = txtDMCS2ID.Text
            cmdInsert.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = txtBorrower_FName.Text
            cmdInsert.Parameters.AddWithValue("@Borrower_LName", SqlDbType.SmallDateTime).Value = txtBorrower_LName.Text
            cmdInsert.Parameters.AddWithValue("@AgencyID", SqlDbType.VarChar).Value = lblAgency.Text
            cmdInsert.Parameters.AddWithValue("@PCA_Employee", SqlDbType.VarChar).Value = txtPCA_Employee.Text
            cmdInsert.Parameters.AddWithValue("@PCA_Phone", SqlDbType.VarChar).Value = txtPCA_Phone.Text
            cmdInsert.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = txtComments.Text
            'For the userID parameter, we first need to assign the new IMF to someone who may already have another IMF with the same debtID
            'which we looked for in btnSubmitIMF_Click.  If a userID exists in lblExistingUserID then we use that value
            'otherwise, we use the value in lblRandomUserID
            If lblExistingUserID.Text <> "" AndAlso lblExistingUserID.Text.Length > 0 Then
                cmdInsert.Parameters.AddWithValue("@UserID", SqlDbType.Int).Value = Convert.ToInt32(lblExistingUserID.Text)
                'Randomly assign UserID from values found in p_LookupEDUser_AG_IMFType above if there is one        
            ElseIf lblRandomUserID.Text <> "" AndAlso lblRandomUserID.Text.Length > 0 Then
                cmdInsert.Parameters.AddWithValue("@UserID", SqlDbType.Int).Value = Convert.ToInt32(lblRandomUserID.Text)
            End If
        
            'New IMFs will intially receive a Status value of 1 which is Received
            cmdInsert.Parameters.AddWithValue("@ID_Status", SqlDbType.Int).Value = 1
        
            'Attachment1 URL
            Dim strFileNamePath As String = Filebox.PostedFile.FileName
            If strFileNamePath.Length > 0 Then
        
                Dim strFileNameOnly As String
                Dim strSaveLocation As String
                      
                'Append the agency value before the file name
                strFileNameOnly = lblAgency.Text & "_" & GenerateRandomFileName(8) & "_" & System.IO.Path.GetFileName(Filebox.PostedFile.FileName)
                                  
                'This checks for a valid file name and type
                Dim Filename1Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|jpg|txt|gif|png)$")
                If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                    Response.Redirect("invalid.filetype.aspx")
                End If
            
                'Generate random file name
                strFileNameOnly = ReplaceIllegalChars(strFileNameOnly)
                strSaveLocation = lblUploadPath.Text & strFileNameOnly
                                   
                Filebox.PostedFile.SaveAs(strSaveLocation)
                cmdInsert.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = strFileNameOnly
            Else
                cmdInsert.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = DBNull.Value
            End If
        
            'Attachment2 URL
            Dim strFileNamePath2 As String = Filebox2.PostedFile.FileName
            If strFileNamePath2.Length > 0 Then
        
                Dim strFileNameOnly2 As String
                Dim strSaveLocation2 As String
            
                'Append the agency value before the file name
                strFileNameOnly2 = lblAgency.Text & "_" & GenerateRandomFileName(8) & "_" & System.IO.Path.GetFileName(Filebox2.PostedFile.FileName)
                                  
                'This checks for a valid file name and type
                Dim Filename1Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|jpg|txt|gif|png)$")
                If Not Filename1Regex.IsMatch(strFileNameOnly2.ToLower(), RegexOptions.IgnoreCase) Then
                    Response.Redirect("invalid.filetype.aspx")
                End If
            
                'Generate random file name
                strFileNameOnly2 = ReplaceIllegalChars(strFileNameOnly2)
                strSaveLocation2 = lblUploadPath.Text & strFileNameOnly2
                                   
                Filebox.PostedFile.SaveAs(strSaveLocation2)
                cmdInsert.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = strFileNameOnly2
            Else
                cmdInsert.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = DBNull.Value
            End If
        
            'If we found a random user to assign this IMF to, the DateAssigned date should be today. Otherwise, it should be null 
            If lblDateAssigned.Text <> "" AndAlso lblDateAssigned.Text.Length > 0 Then
                cmdInsert.Parameters.AddWithValue("@DateAssigned", SqlDbType.DateTime).Value = lblDateAssigned.Text
            Else
                cmdInsert.Parameters.AddWithValue("@DateAssigned", SqlDbType.DateTime).Value = DBNull.Value
            End If
        
            cmdInsert.Parameters.AddWithValue("@LocationCode", SqlDbType.VarChar).Value = DBNull.Value
            cmdInsert.Parameters.AddWithValue("@Archived", SqlDbType.Bit).Value = False
         
            Try
                con.Open()
                intReturnIMF_ID = cmdInsert.ExecuteScalar()
                lblStatus.Text = "Your IMF has been received by ED. Your request number is " & intReturnIMF_ID
            
                'Clear all of the label values in case they submit another IMF
                lblRandomUserID.Text = ""
                lblExistingUserID.Text = ""
                lblExistingIMF_ID.Text = ""
                lblDateAssigned.Text = ""
            
                'Finally disable to Submit IMF button
                btnSubmitIMF.Visible = False
            
                'Make the Submit Another IMF button visible
                btnSubmitAnotherIMF.Visible = True
            
                'Make the SSN panel invisible
                pnlSSN.Visible = False
            
            Finally
                'con.Close()
            End Try
        Else
            lblStatus.Text = "Please correct the data entry errors above"
        End If
    End Sub
    
    'Sub LookupVangentQueue()
    '    'This looks up a random DRG user based on QueueID value
    '    Dim strSQL As String
    '    Dim cmd As SqlCommand
    '    Dim con As SqlConnection
    '    Dim dr As SqlDataReader
    '    Dim myList As New ArrayList
    '    Dim count As Integer
        
    '    con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
    '    strSQL = "p_Vangent_Queues"
    '    cmd = New SqlCommand(strSQL)
    '    cmd.CommandType = CommandType.StoredProcedure
    '    cmd.Connection = con
        
    '    cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = ddlIMF_Type.SelectedValue
    '    Try
    '        con.Open()
    '        cmd.Connection = con
    '        dr = cmd.ExecuteReader()
            
    '        'Sometimes there may not be an DRG Analyst assigned to a specific IMF Type
    '        'If there isn't one, we cannot assign an IMF at random or else this section will fail
    '        With dr
    '            If .HasRows Then
    '                While .Read
    '                    myList.Add(dr("UserId"))
    '                    count += 1
    '                End While
                    
    '                Dim r As Random = New Random()
    '                Dim cnt As Integer
    '                For cnt = 0 To myList.Count - 1 Step cnt + 1
    '                    Dim tmp As Object = myList(cnt)
    '                    Dim idx As Integer = r.Next(myList.Count - cnt) + cnt
    '                    myList(cnt) = myList(idx)
    '                    myList(idx) = tmp
    '                Next
                    
    '                'Just use the values found in the random function
    '                lblRandomUserID.Text = myList(0)
    '                lblDateAssigned.Text = DateTime.Now
    '            End If
    '        End With
            
    '    Finally
    '        con.Close()
    '    End Try
        
    'Now we have a randomly generated UserID to assign the IMF to user based on Queue value
    'InsertNewIMF_Vangent()
        
    'End Sub
    
    Sub LookupVangentQueue()
        'This looks up a random DRG user based on QueueID value
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
               
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_Vangent_Queue_Lookup"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = ddlIMF_Type.SelectedValue
        Try
            con.Open()
            cmd.Connection = con
            dr = cmd.ExecuteReader()
           
            With dr
                If .HasRows Then
                    While .Read
                        lblQueueID.Text = dr("QueueID")
                    End While
                    lblDateAssigned.Text = DateTime.Now
                End If
            End With
            
        Finally
            con.Close()
        End Try
        
        'Now we have the QueueID to assign the IMF to user based on IMF_ID
        InsertNewIMF_Vangent()
    End Sub
    
    Sub InsertNewIMF_Vangent()
        If Page.IsValid Then
        
            'Clear any old values in the status label
            lblStatus.Text = ""
        
            Dim strInsert As String
            Dim cmdInsert As SqlCommand
            Dim con As SqlConnection
            Dim intReturnIMF_ID As Integer
        
            con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
            strInsert = "p_InsertIMF_Vangent"
            cmdInsert = New SqlCommand(strInsert)
            cmdInsert.CommandType = CommandType.StoredProcedure
            cmdInsert.Connection = con
        
            cmdInsert.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = ddlIMF_Type.SelectedValue
            cmdInsert.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = txtDebtID.Text
            If lblQueueID.Text <> "" Then
                cmdInsert.Parameters.AddWithValue("@QueueID", SqlDbType.VarChar).Value = Convert.ToInt32(lblQueueID.Text)
            Else
                cmdInsert.Parameters.AddWithValue("@QueueID", SqlDbType.VarChar).Value = DBNull.Value
            End If
            cmdInsert.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = txtBorrower_FName.Text
            cmdInsert.Parameters.AddWithValue("@Borrower_LName", SqlDbType.SmallDateTime).Value = txtBorrower_LName.Text
            cmdInsert.Parameters.AddWithValue("@AgencyID", SqlDbType.VarChar).Value = lblAgency.Text
            cmdInsert.Parameters.AddWithValue("@PCA_Employee", SqlDbType.VarChar).Value = txtPCA_Employee.Text
            cmdInsert.Parameters.AddWithValue("@PCA_Phone", SqlDbType.VarChar).Value = txtPCA_Phone.Text
            cmdInsert.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = txtComments.Text
            cmdInsert.Parameters.AddWithValue("@DateSubmitted", SqlDbType.DateTime).Value = Now()
            cmdInsert.Parameters.AddWithValue("@DateAssigned", SqlDbType.DateTime).Value = Now()
            cmdInsert.Parameters.AddWithValue("@SchoolContact", SqlDbType.VarChar).Value = txtSchoolContact.Text
            cmdInsert.Parameters.AddWithValue("@SchoolFax", SqlDbType.VarChar).Value = txtSchoolFax.Text
            cmdInsert.Parameters.AddWithValue("@SchoolAddress", SqlDbType.VarChar).Value = txtSchoolAddress.Text
        
            'New IMFs will intially receive a Status value of 1 which is Received
            cmdInsert.Parameters.AddWithValue("@ID_Status", SqlDbType.Int).Value = 1
        
            cmdInsert.Parameters.AddWithValue("@Rejected", SqlDbType.Bit).Value = False
            cmdInsert.Parameters.AddWithValue("@Archived", SqlDbType.Bit).Value = False
                
            Try
                con.Open()
                intReturnIMF_ID = cmdInsert.ExecuteScalar()
                lblStatus.Text = "Your IMF has been received by DRG. Your request number is " & intReturnIMF_ID
            
                'Clear all of the label values in case they submit another IMF
                lblRandomUserID.Text = ""
                lblExistingUserID.Text = ""
                lblExistingIMF_ID.Text = ""
                lblDateAssigned.Text = ""
            
                'Finally disable to Submit IMF button
                btnSubmitIMF.Visible = False
            
                'Make the Submit Another IMF button visible
                btnSubmitAnotherIMF.Visible = True
            Finally
                con.Close()
            End Try
        Else
            lblStatus.Text = "Please correct the data entry errors above"
        End If
    End Sub
    
    Sub btnSubmitAnotherIMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("IMFs.Add.PCA.aspx")
        
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
   
    Protected Sub ddlIMF_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'These are the IMF types that Vangent/DRG can work
        '33 - Paid In Full Letter
        '34 - Settled In Full Letter (Compromise)
        '35 - Title IV Reinstatement Letter
        '42 - Request New PNote For NDSL w/Judgment  
        
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        Dim strIMF_Owner As String = ""
               
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_IMF_Owner"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        cmd.Parameters.AddWithValue("@IMF_ID", SqlDbType.VarChar).Value = ddlIMF_Type.SelectedValue
        Try
            con.Open()
            cmd.Connection = con
            dr = cmd.ExecuteReader()
           
            With dr
                If .HasRows Then
                    While .Read
                        strIMF_Owner = dr("IMF_Owner")
                    End While
                    lblDateAssigned.Text = DateTime.Now
                End If
            End With
            
        Finally
            con.Close()
        End Try
        
        If strIMF_Owner = "Vangent" Then
            lblIMF_Owner.Text = "Vangent"
            'Disable the upload file attachment boxes
            Filebox.Disabled = True
            Filebox2.Disabled = True
            
            'If the IMF_Type = 35 which is Title IV Reinstatment Letter, then we need to 
            'display the panel which asks for school contact information
            If ddlIMF_Type.SelectedValue = 35 Then
                pnlSchoolContact.Visible = True
            Else
                pnlSchoolContact.Visible = False
            End If
            pnlLocationCode.Visible = False
            pnlAttachments.Visible = False
        Else
            lblIMF_Owner.Text = "ED"
            'Enable the upload file attachment boxes
            Filebox.Disabled = False
            Filebox2.Disabled = False
            
            pnlLocationCode.Visible = True
            pnlAttachments.Visible = True
        End If
        
        'The SSN panel should be visible only when the IMF Type "Administrative Resolution - Total and Permanent Disability (53) is selected
        If ddlIMF_Type.SelectedValue = "53" Then
            pnlSSN.Visible = True
            'At least one attachment is required for this IMF Type so we make the required field validator enabled
            rfd_SSN.Enabled = True
        Else
            pnlSSN.Visible = False
            rfd_SSN.Enabled = False
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add IMF - PCA</title>
    <link href="style.css" rel="stylesheet" type="text/css" />    
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $("#btnSubmitIMF").click(function () {
                var DebtID = $("#txtDebtID").val();
                var DMCS2ID = $("#txtDMCS2ID").val();
                
                if (DebtID != '' && DMCS2ID != '') {
                    alert("Please provide either a DebtID or a DMCS ID - not both");
                    return false;
                } else if (DebtID == '' && DMCS2ID == '') {
                    alert("Please provide either a DebtID or a DMCS ID");
                    return false;
                }         

            });


        });
    </script>
</head>
<body>
    <form id="form1" runat="server">  
                
                    <!--This one populates the IMF Type dropdown-->
                    <asp:SqlDataSource ID="dsIMFTypes" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_IMFTypes_All" SelectCommandType="StoredProcedure" />          
                                                    
                  <div align="left">                  
                   <asp:Panel ID="pnlIMFEntry" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Submit a New IMF</legend>
                        <br /><br />
                        <table border="0" width="900" style="padding-left: 15px">
                            <tr>
                                <td align="right" width="50%" class="formLabel"><a href="IMF.Types.Definitions.aspx" target="name" onclick="window.open('IMF.Types.Definitions.aspx','name','height=500, width=800,toolbar=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes'); return false;">
                                    <img src="images/info.gif" border="0" alt="More information available on this topic" /></a> IMF Type:</td>
                                <td align="left" width="50%">
                                <asp:DropDownList id="ddlIMF_Type" Runat="Server"
                                        DataSourceID="dsIMFTypes"
                                        DataTextField="IMF_Type" 
                                        DataValueField="IMF_ID" 
                                        CssClass="formLabel" AutoPostBack="true"
                                        AppendDataBoundItems="true" OnSelectedIndexChanged="ddlIMF_Type_SelectedIndexChanged">
                                        <asp:ListItem Text="" Value="" />
                                        </asp:DropDownList> 
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                                        ControlToValidate="ddlIMF_Type" Display="Dynamic" CssClass="warningMessage"
                                        Text="Please select an IMF type"
                                        Runat="Server" /></td>
                            </tr>
                            <asp:Panel ID="pnlSSN" runat="server" Visible="false">
                            <tr>
                                <td align="right" width="50%" class="formLabel">SSN:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtSSN" runat="server" MaxLength="12" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="rfd_SSN" runat="server" ControlToValidate="txtSSN" Display="Dynamic" ErrorMessage="* A SSN is Required *" SetFocusOnError="true" CssClass="warningMessage" Enabled="false" />
                                 <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ControlToValidate="txtSSN" ErrorMessage="* Please enter a valid 9 digit SSN ######### (no dashes) *" CssClass="warningMessage" ValidationExpression="\d{9}" />
                                </td>
                            </tr>
                            </asp:Panel>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Debt ID:</td>
                                <td align="left" width="50%">
                                <asp:TextBox ID="txtDebtID" runat="server" MaxLength="16" CssClass="formLabel" /> - <u>OR</u> -
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ControlToValidate="txtDebtID" ErrorMessage="* A debt ID is a letter followed by 15 digits *" CssClass="warningMessage" ValidationExpression="([a-z]|[A-Z])[0-9]{15}" />
                                 DMCS ID:
                                <asp:TextBox ID="txtDMCS2ID" runat="server" MaxLength="10" CssClass="formLabel" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic" ControlToValidate="txtDMCS2ID" ErrorMessage="* A DMCS ID is 10 digits *" CssClass="warningMessage" ValidationExpression="\d{10}" />
                                </td>
                            </tr>
                            <tr>
                                
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Borrower First Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtBorrower_FName" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtBorrower_FName" Display="Dynamic" ErrorMessage="* A Borrower First Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Borrower Last Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtBorrower_LName" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtBorrower_LName" Display="Dynamic" ErrorMessage="* A Borrower Last Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">PCA Employee Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtPCA_Employee" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtPCA_Employee" Display="Dynamic" ErrorMessage="* A PCA Employee Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">PCA Employee Phone:</td>
                                <td align="left" width="50%"><asp:Textbox ID="txtPCA_Phone" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <asp:Panel ID="pnlLocationCode" runat="server">
                            <tr>
                               <td align="right" width="50%" class="formLabel">Location Code:</td>
                                <td align="left" width="50%"><asp:Textbox ID="txtLocationCode" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            </asp:Panel>
                                                       
                            <asp:Panel ID="pnlSchoolContact" runat="server" Visible="false">
                            <tr>
                                <td align="right" width="50%" class="formLabel">School Contact Name:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtSchoolContact" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">School Fax Number:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtSchoolFax" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">School Address:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtSchoolAddress" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            </asp:Panel>                       
                            <tr>
                                <td align="right" width="50%" class="formLabel">Comments:</td>
                                <td align="left" width="50%"><asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" CssClass="formLabel" Rows="10" Columns="55" /></td>
                            </tr>
                            <asp:Panel ID="pnlAttachments" runat="server">  
                            <tr>
                                <td align="right" width="50%" class="formLabel">Attachment 1:</td>
                                <td align="left" width="50%"><input id="Filebox" type="File" runat="server" size="35" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Attachment 2:</td>
                                <td align="left" width="50%"><input id="Filebox2" type="File" runat="server" size="35" /><br />
                                    <span class="warningMessage">* If submitting an attachment, please ensure that 
                                    your file name has a <a href="file.types.htm" target="name" onclick="window.open('file.types.htm','name','height=255, width=250,toolbar=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no'); return false;">valid file extension</a>.</span></td>
                            </tr>
                            </asp:Panel>
                             <tr>
                                <td align="center" colspan="2"><br />
                                    <asp:Button ID="btnSubmitIMF" runat="server" Text="Submit IMF" OnClick="btnSubmitIMF_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                                    <asp:Button ID="btnSubmitAnotherIMF" runat="server" Text="Submit Another IMF" OnClick="btnSubmitAnotherIMF_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" Visible="false" /></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"><asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" /></td>
                            </tr>                        
                        </table>
                        </fieldset>                    
                   </asp:Panel>
                   </div>
                  
<asp:Label ID="lblAgency" runat="server" Visible="false" />
<asp:Label ID="lblIMF_Owner" runat="server" Visible="false" />
<asp:Label ID="lblRandomUserID" runat="server" Visible="false" />
<asp:Label ID="lblExistingUserID" runat="server" Visible="false" />
<asp:Label ID="lblExistingIMF_ID" runat="server" Visible="false" />
<asp:Label ID="lblDateAssigned" runat="server" Visible="false" />
<asp:Label ID="lblQueueID" runat="server" Visible="false" />
<asp:Label ID="lblUploadPath" runat="server" Visible="false" />
 </form>
</body>
</html>
