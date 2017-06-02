<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" Debug="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            'This page is shared by both ED and the PCAs so we have to know who is looking at it.            
            If Not IsNothing(Request.Cookies("IMF")("AG")) Then
                'PCA is looking at the IMF
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString()) 'This contains their agency number code
                lblED_AG_Security.Text = "AG"
            End If
            
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                'ED employee is looking at the IMF
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblED_AG_Security.Text = "ED"
            End If
            
            lblUploadPath.Text = System.Configuration.ConfigurationManager.AppSettings("UploadPath").ToString
                        
            'See whether a ED or PCA user is completing this form
            CheckFields()
           
        End If
    End Sub
    
    Sub CheckFields()
                        
        If lblED_AG_Security.Text = "AG" Then
            'These fields cannot be edited by any PCA
            'ddlAgencyID.Enabled = False
            'ddlAllEDUsers.Enabled = False
            txtED_Comments.Enabled = False
            Attachment6_ED.Disabled = True
            Attachment7_ED.Disabled = True
            
            'Set the selected value in the agency dropdownlist to the value of the agency
            ddlAgencyID.SelectedValue = lblAgency.Text
        End If
        
        'Set the selected value in the ED users dropdownlist to the value of the person logged in
        If lblED_AG_Security.Text = "ED" Then
            ddlAllEDUsers.SelectedValue = lblEDUserID.Text
        End If
       
    End Sub
   
    Sub btnSubmitComplaint_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        Dim myList As New ArrayList
        Dim count As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_CheckDuplicateDebtID_Complaints"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        cmd.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = txtDebtID.Text
        
        Try
            con.Open()
            cmd.Connection = con
            dr = cmd.ExecuteReader()
            
            'If an ED analyst is already assigned to a DebtID we need to assign this additional one to him/her
            With dr
                If .HasRows Then
                    While .Read
                        myList.Add(dr("UserId"))
                        myList.Add(dr("ComplaintID"))
                        count += 1
                    End While
                    
                    'We found a user to assign this new Complaint to so we'll assign the UserID and DateAssigned to these labels
                    lblExistingUserID.Text = myList(0)
                    lblExistingComplaintID.Text = myList(1)
                    lblDateAssigned.Text = DateTime.Now
                               
                    'Insert the new Complaint
                    InsertNewComplaint()
                Else
                    'This DebtID isn't already assigned to another ED analyst so we'll call the Random UserID function
                    'Now we have a randomly generated UserID to assign the Complaint to
                    GetRandom_EDUser()
                End If
            End With
            
        Finally
            con.Close()
        End Try

    End Sub
    
    
    Sub GetRandom_EDUser()
        'This sub gets called only if the debtID being submitted isn't already assigned to another ED analyst
        'Run p_LookupEDUser_Complaint to get available ED users assigned to complaints
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        Dim myList As New ArrayList
        Dim count As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_LookupEDUser_Complaints"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        
        Try
            con.Open()
            cmd.Connection = con
            dr = cmd.ExecuteReader()
            
            'Sometimes there may not be an ED Analyst assigned to work complaints
            'If there isn't one, we cannot assign a Complaint at random or else this section will fail
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
                    
                    'We found a user to assign this new Complaint to so we'll assign the UserID and DateAssigned to these labels
                    lblRandomUserID.Text = myList(0)
                    lblDateAssigned.Text = DateTime.Now
                End If
            End With
            
        Finally
            con.Close()
        End Try
        
        'Now we have a randomly generated UserID to assign the Complaint to
        InsertNewComplaint()
        
    End Sub
    
    Sub InsertNewComplaint()
        
        'Clear any old values in the status label
        lblStatus.Text = ""
        
        Dim strInsert As String
        Dim cmdInsert As SqlCommand
        Dim con As SqlConnection
        Dim intReturnComplaintID As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strInsert = "p_InsertComplaint"
        cmdInsert = New SqlCommand(strInsert)
        cmdInsert.CommandType = CommandType.StoredProcedure
        cmdInsert.Connection = con
        
        cmdInsert.Parameters.AddWithValue("@Complaint_Receipt_Date", SqlDbType.SmallDateTime).Value = txtComplaint_Receipt_Date.Text
        cmdInsert.Parameters.AddWithValue("@Agency_Receipt_Date", SqlDbType.SmallDateTime).Value = txtAgency_Receipt_Date.Text
        cmdInsert.Parameters.AddWithValue("@Agency_Submission_Date", SqlDbType.SmallDateTime).Value = Date.Now()
        cmdInsert.Parameters.AddWithValue("@PCA_Employee_FName", SqlDbType.VarChar).Value = txtPCA_Employee_FName.Text
        cmdInsert.Parameters.AddWithValue("@PCA_Employee_LName", SqlDbType.VarChar).Value = txtPCA_Employee_LName.Text
        cmdInsert.Parameters.AddWithValue("@PCA_Employee_Phone", SqlDbType.VarChar).Value = txtPCA_Employee_Phone.Text
        cmdInsert.Parameters.AddWithValue("@PCA_Employee_Email", SqlDbType.VarChar).Value = txtPCA_Employee_Email.Text
        cmdInsert.Parameters.AddWithValue("@Collector_Name", SqlDbType.VarChar).Value = txtCollector_Name.Text
        cmdInsert.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = txtBorrower_FName.Text
        cmdInsert.Parameters.AddWithValue("@Borrower_LName", SqlDbType.VarChar).Value = txtBorrower_LName.Text
        cmdInsert.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = txtDebtID.Text
        cmdInsert.Parameters.AddWithValue("@Complaint_Source", SqlDbType.VarChar).Value = ddlComplaint_Source.SelectedValue
        'cmdInsert.Parameters.AddWithValue("@Complaint_Type", SqlDbType.VarChar).Value = ddlComplaint_Type.SelectedValue
        cmdInsert.Parameters.AddWithValue("@PCA_Comments", SqlDbType.VarChar).Value = txtPCA_Comments.Text
        cmdInsert.Parameters.AddWithValue("@ED_Comments", SqlDbType.VarChar).Value = txtED_Comments.Text
        cmdInsert.Parameters.AddWithValue("@Archived", SqlDbType.Bit).Value = 0
        
        'New complaints will intially receive a Status value of 1 which is Received
        cmdInsert.Parameters.AddWithValue("@StatusID", SqlDbType.Int).Value = 1
              
        'For the userID parameter, we first need to assign the new complaint to someone who may already have another complaint with the same debtID
        'which we looked for in btnSubmitComplaint_Click.  If a userID exists in lblExistingUserID then we use that value
        'otherwise, we use the value in lblRandomUserID
        If lblExistingUserID.Text <> "" AndAlso lblExistingUserID.Text.Length > 0 Then
            cmdInsert.Parameters.AddWithValue("@UserID", SqlDbType.Int).Value = Convert.ToInt32(lblExistingUserID.Text)
            'Randomly assign UserID from values found in p_LookupEDUser_Complaint above if there is one        
        ElseIf lblRandomUserID.Text <> "" AndAlso lblRandomUserID.Text.Length > 0 Then
            cmdInsert.Parameters.AddWithValue("@UserID", SqlDbType.Int).Value = Convert.ToInt32(lblRandomUserID.Text)
        End If
        
              
        'Attachment1_PCA URL
        Dim strFileNamePath As String = Attachment1_PCA.PostedFile.FileName
        If strFileNamePath.Length > 0 Then
        
            Dim strFileNameOnly As String
            Dim strSaveLocation As String
            
            'Append the agency value before the file name
            strFileNameOnly = lblED_AG_Security.Text & "_" & GenerateRandomFileName(8) & "_" & System.IO.Path.GetFileName(Attachment1_PCA.PostedFile.FileName)
                                
            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly = ReplaceIllegalChars(strFileNameOnly)
            strSaveLocation = lblUploadPath.Text & strFileNameOnly
                                   
            Attachment1_PCA.PostedFile.SaveAs(strSaveLocation)
            cmdInsert.Parameters.Add("@Attachment1_PCA", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            cmdInsert.Parameters.Add("@Attachment1_PCA", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'Attachment2_PCA URL
        Dim strFileNamePath2 As String = Attachment2_PCA.PostedFile.FileName
        If strFileNamePath2.Length > 0 Then
        
            Dim strFileNameOnly2 As String
            Dim strSaveLocation2 As String
            
            'Append the agency value before the file name       
            strFileNameOnly2 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment2_PCA.PostedFile.FileName)
            
            'This checks for a valid file name and type
            Dim Filename2Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
            If Not Filename2Regex.IsMatch(strFileNameOnly2.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly2 = ReplaceIllegalChars(strFileNameOnly2)
            strFileNameOnly2 = GenerateRandomFileName(8) & "." & strFileNameOnly2

            strSaveLocation2 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly2
            Attachment2_PCA.PostedFile.SaveAs(strSaveLocation2)
            cmdInsert.Parameters.Add("@Attachment2_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly2
        Else
            cmdInsert.Parameters.Add("@Attachment2_PCA", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'Attachment3_PCA URL
        Dim strFileNamePath3 As String = Attachment3_PCA.PostedFile.FileName
        If strFileNamePath3.Length > 0 Then
        
            Dim strFileNameOnly3 As String
            Dim strSaveLocation3 As String
            
            'Append the agency value before the file name       
            strFileNameOnly3 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment3_PCA.PostedFile.FileName)
           
            'This checks for a valid file name and type
            Dim Filename3Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
            If Not Filename3Regex.IsMatch(strFileNameOnly3.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly3 = ReplaceIllegalChars(strFileNameOnly3)
            strFileNameOnly3 = GenerateRandomFileName(8) & "." & strFileNameOnly3

            strSaveLocation3 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly3
            Attachment3_PCA.PostedFile.SaveAs(strSaveLocation3)
            cmdInsert.Parameters.Add("@Attachment3_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly3
        Else
            cmdInsert.Parameters.Add("@Attachment3_PCA", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'Attachment4_PCA URL
        Dim strFileNamePath4 As String = Attachment4_PCA.PostedFile.FileName
        If strFileNamePath4.Length > 0 Then
        
            Dim strFileNameOnly4 As String
            Dim strSaveLocation4 As String
            
            'Append the agency value before the file name       
            strFileNameOnly4 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment4_PCA.PostedFile.FileName)
           
            'This checks for a valid file name and type
            Dim Filename4Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
            If Not Filename4Regex.IsMatch(strFileNameOnly4.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly4 = ReplaceIllegalChars(strFileNameOnly4)
            strFileNameOnly4 = GenerateRandomFileName(8) & "." & strFileNameOnly4

            strSaveLocation4 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly4
            Attachment3_PCA.PostedFile.SaveAs(strSaveLocation4)
            cmdInsert.Parameters.Add("@Attachment4_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly4
        Else
            cmdInsert.Parameters.Add("@Attachment4_PCA", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'Attachment5_PCA URL
        Dim strFileNamePath5 As String = Attachment5_PCA.PostedFile.FileName
        If strFileNamePath5.Length > 0 Then
        
            Dim strFileNameOnly5 As String
            Dim strSaveLocation5 As String
            
            'Append the agency value before the file name       
            strFileNameOnly5 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment5_PCA.PostedFile.FileName)
           
            'This checks for a valid file name and type
            Dim Filename5Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
            If Not Filename5Regex.IsMatch(strFileNameOnly5.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly5 = ReplaceIllegalChars(strFileNameOnly5)
            strFileNameOnly5 = GenerateRandomFileName(8) & "." & strFileNameOnly5

            strSaveLocation5 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly5
            Attachment5_PCA.PostedFile.SaveAs(strSaveLocation5)
            cmdInsert.Parameters.Add("@Attachment5_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly5
        Else
            cmdInsert.Parameters.Add("@Attachment5_PCA", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        'Now the 2 ED attachments. We want to pass these 2 parameters only if its an ED user
        If lblED_AG_Security.Text = "ED" Then
            'Attachment1_ED URL
            Dim strFileNamePath6 As String = Attachment6_ED.PostedFile.FileName
               
            If strFileNamePath6.Length > 0 Then
        
                Dim strFileNameOnly6 As String
                Dim strSaveLocation6 As String
            
                'Append the agency value before the file name       
                strFileNameOnly6 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment6_ED.PostedFile.FileName)
           
                'This checks for a valid file name and type
                Dim Filename6Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
                If Not Filename6Regex.IsMatch(strFileNameOnly6.ToLower(), RegexOptions.IgnoreCase) Then
                    Response.Redirect("../invalid.filetype.aspx")
                End If
            
                'Function to remove illegal URL characters
                strFileNameOnly6 = ReplaceIllegalChars(strFileNameOnly6)
                strFileNameOnly6 = GenerateRandomFileName(8) & "." & strFileNameOnly6

                strSaveLocation6 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly6
                Attachment6_ED.PostedFile.SaveAs(strSaveLocation6)
                cmdInsert.Parameters.Add("@Attachment1_ED", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly6
            Else
                cmdInsert.Parameters.Add("@Attachment1_ED", SqlDbType.VarChar).Value = DBNull.Value
            End If
        
            'Attachment2_ED URL
            Dim strFileNamePath7 As String = Attachment7_ED.PostedFile.FileName
            If strFileNamePath7.Length > 0 Then
        
                Dim strFileNameOnly7 As String
                Dim strSaveLocation7 As String
            
                'Append the agency value before the file name       
                strFileNameOnly7 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment7_ED.PostedFile.FileName)
           
                'This checks for a valid file name and type
                Dim Filename7Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
                If Not Filename7Regex.IsMatch(strFileNameOnly7.ToLower(), RegexOptions.IgnoreCase) Then
                    Response.Redirect("../invalid.filetype.aspx")
                End If
            
                'Function to remove illegal URL characters
                strFileNameOnly7 = ReplaceIllegalChars(strFileNameOnly7)
                strFileNameOnly7 = GenerateRandomFileName(8) & "." & strFileNameOnly7

                strSaveLocation7 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly7
                Attachment7_ED.PostedFile.SaveAs(strSaveLocation7)
                cmdInsert.Parameters.Add("@Attachment2_ED", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly7
            Else
                cmdInsert.Parameters.Add("@Attachment2_ED", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If
        
        Try
            con.Open()
            intReturnComplaintID = cmdInsert.ExecuteScalar()
            lblStatus.Text = "Your Complaints has been received by ED. Your request number is " & intReturnComplaintID
            lblReturnComplaintID.Text = intReturnComplaintID.ToString()
                      
            'Finally disable to Submit complaint button
            btnSubmitComplaint.Visible = False
            
            'Make the Submit Another complaint button visible
            btnSubmitAnotherComplaint.Visible = True
            
            'Saved the checked values in DCS Complaint Type
            InsertDCSComplaintTypes()
            
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub InsertDCSComplaintTypes()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String
        Dim intComplaintID As Integer = CInt(lblReturnComplaintID.Text)
      
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        SqlText = "p_Complaints_Insert"
        Try
            strSQLConn.Open()
            For Each Item As ListItem In cblDCSComplaint_Type.Items
                If (Item.Selected) Then
                    cmd = New SqlCommand(SqlText)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Connection = strSQLConn
                    'input parameters for the sproc
                    cmd.Parameters.Add("@ComplaintID", SqlDbType.Int).Value = intComplaintID
                    cmd.Parameters.Add("@ComplaintTypeID", SqlDbType.Int).Value = Item.Value
                    cmd.Parameters.Add("@Violation_Type", SqlDbType.VarChar).Value = "DCS"
                    cmd.ExecuteNonQuery()
                End If
            Next
            
            'Saved the checked values in DCS Complaint Type
            InsertFDCPAComplaintTypes()
            
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Sub InsertFDCPAComplaintTypes()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String
        Dim intComplaintID As Integer = CInt(lblReturnComplaintID.Text)
      
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        SqlText = "p_Complaints_Insert"
        Try
            strSQLConn.Open()
            For Each Item As ListItem In cblFDCPAComplaint_Type.Items
                If (Item.Selected) Then
                    cmd = New SqlCommand(SqlText)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Connection = strSQLConn
                    'input parameters for the sproc
                    cmd.Parameters.Add("@ComplaintID", SqlDbType.Int).Value = intComplaintID
                    cmd.Parameters.Add("@ComplaintTypeID", SqlDbType.Int).Value = Item.Value
                    cmd.Parameters.Add("@Violation_Type", SqlDbType.VarChar).Value = "FDCPA"
                    cmd.ExecuteNonQuery()
                End If
            Next
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
    Sub btnSubmitAnotherComplaint_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("Add.Complaint.aspx")
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
        'If ddlIMF_Type.SelectedValue = "33" OrElse _
        '    ddlIMF_Type.SelectedValue = "34" OrElse _
        '    ddlIMF_Type.SelectedValue = "35" OrElse _
        '    ddlIMF_Type.SelectedValue = "36" OrElse _
        '    ddlIMF_Type.SelectedValue = "40" OrElse _
        '    ddlIMF_Type.SelectedValue = "41" OrElse _
        '    ddlIMF_Type.SelectedValue = "42" OrElse _
        '    ddlIMF_Type.SelectedValue = "43" Then
        '    lblIMF_Owner.Text = "Vangent"
        '    'Disable the upload file attachment boxes
        '    Filebox.Disabled = True
        '    Filebox2.Disabled = True
        '    'Locate missing pnote requests redirect to missing pnote page
        '    If ddlIMF_Type.SelectedValue = "41" Then
        '        Response.Redirect("Vangent/Missing.PNote.Request.Add.PCA.aspx")
        '    End If
        'Else
        '    lblIMF_Owner.Text = "ED"
        '    'Enable the upload file attachment boxes
        '    Filebox.Disabled = False
        '    Filebox2.Disabled = False
        'End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add Borrower Complaint</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">  
                
                    <!--This one populates the Agency dropdown-->
                      <asp:SqlDataSource ID="dsAgencies" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllAgencies" SelectCommandType="StoredProcedure" /> 
                            
                      <!--This one populates the ED Users dropdown-->
                      <asp:SqlDataSource ID="dsAllEDUsers" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllUsersActive" SelectCommandType="StoredProcedure" /> 
                            
                        <!--This one populates the DCS complaint types checboxlist-->
                      <asp:SqlDataSource ID="dsComplaintTypes_DCS" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_ComplaintTypes_DCS" SelectCommandType="StoredProcedure" />
                            
                        <!--This one populates the FDCPA complaint types checboxlist-->
                      <asp:SqlDataSource ID="dsComplaintTypes_FDCPA" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_ComplaintTypes_FDCPA" SelectCommandType="StoredProcedure" />        
                                                    
                  <div align="center">
                   <asp:Panel ID="pnlComplaintEntry" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Submit a New Complaint</legend>
                        <table border="0" width="100%">
                            <tr>
		                    <td class ="formSeparator" colspan="4">Submitted By</td>		
	                    </tr>
	                    <tr>
		                    <td class="formLabelForm">Agency:</td>
                            <td align="left"><asp:DropDownList ID="ddlAgencyID" runat="server" CssClass="formLabel"
                                  DataSourceID="dsAgencies"
                                  DataTextField="AG_Name"
                                  DataValueField="AG" AppendDataBoundItems="true"
                                  Enabled="false">
                                  <asp:ListItem Text="" Value="" />                              
                             </asp:DropDownList>                
                             </td>
		                    <td class="formLabelForm">ED Employee:</td>
		                    <td align="left"><asp:DropDownList id="ddlAllEDUsers" Runat="Server" CssClass="formLabel"
                                  DataSourceID="dsAllEDUsers"
                                  DataTextField="UserName"
                                  DataValueField="UserID"
                                  AppendDataBoundItems="true" 
                                  Enabled="false">
                                  <asp:ListItem Text="" Value="" />                             
                          </asp:DropDownList></td>
	                    </tr>
	<tr>
		<td class ="formSeparator" colspan="4">Complaint Dates</td>		
	</tr>
	<tr>
		<td class="formLabelForm">Complaint Receipt Date:</td>
		<td align="left"><asp:Textbox id="txtComplaint_Receipt_Date" runat="server" /></td>
		<td class="formLabelForm">Agency Receipt Date:</td>
		<td align="left"><asp:Textbox id="txtAgency_Receipt_Date" runat="server" /></td>
	</tr>
	<tr>
		<td class ="formSeparator" colspan="4">PCA Information</td>		
	</tr>

	<tr>
		<td class="formLabelForm">PCA Employee:</td>
		<td align="left"><asp:Textbox id="txtPCA_Employee_FName" runat="server" Text="First Name" onFocus="this.value=''" /> <asp:Textbox id="txtPCA_Employee_LName" runat="server" Text="Last Name" onFocus="this.value=''" /></td>
		<td class="formLabelForm">PCA Employee Phone:</td>
		<td align="left"><asp:Textbox id="txtPCA_Employee_Phone" runat="server" /></td>
	</tr>	
    <tr>
		<td class="formLabelForm">PCA Employee Email:</td>
		<td align="left"><asp:Textbox id="txtPCA_Employee_Email" runat="server" /></td>
		<td class="formLabelForm"></td>
		<td align="left"></td>
	</tr>
	<tr>
		<td class ="formSeparator" colspan="4">Complaint Details</td>		
	</tr>
    <tr>
		<td class="formLabelForm">Borrower Name:</td>
		<td align="left"><asp:Textbox id="txtBorrower_FName" runat="server" Text="First Name" onFocus="this.value=''" /> <asp:Textbox id="txtBorrower_LName" runat="server" Text="Last Name" onFocus="this.value=''" /><br />
        <asp:RequiredFieldValidator ID="rfdBorrower_FName" runat="server" ErrorMessage="* Borrower First Name is a required field *" CssClass="warningMessage" ControlToValidate="txtBorrower_FName" /><br />
        <asp:RequiredFieldValidator ID="rfdBorrower_LName" runat="server" ErrorMessage="* Borrower Last Name is a required field *" CssClass="warningMessage" ControlToValidate="txtBorrower_LName" />                
        </td>
		<td class="formLabelForm">Complaint Source:</td>
		<td align="left">
            <asp:Dropdownlist id="ddlComplaint_Source" runat="server">
                    <asp:ListItem Text="Written" Value="Written" />
                    <asp:ListItem Text="Verbal" Value="Verbal" />
            </asp:Dropdownlist>
            </td>
	</tr>	
	<tr>
		<td class="formLabelForm">Debt ID:</td>
		<td align="left"><asp:Textbox id="txtDebtID" runat="server" /><br />
        <asp:RequiredFieldValidator ID="rfdDebtID" runat="server" ErrorMessage="* Debt ID is a required field *" CssClass="warningMessage" ControlToValidate="txtDebtID" />        
        </td>
		<td class="formLabelForm">Collector Name:</td>
		<td align="left"><asp:Textbox id="txtCollector_Name" runat="server" /></td>
	</tr>	
	<tr>
		<td class="formLabelForm">DCS Complaint Type:</td>
		<td align="left" valign="top">
                <asp:Checkboxlist id="cblDCSComplaint_Type" runat="server" 
                DataSourceID="dsComplaintTypes_DCS" 
                DataTextField="Complaint_Type" 
                DataValueField="ComplaintTypeID" 
                RepeatDirection="Vertical" TextAlign="Right" />
        
        </td>
		<td class="formLabelForm">FDCPA Complaint Type:</td>
		<td align="left" valign="top">
            <asp:Checkboxlist id="cblFDCPAComplaint_Type" runat="server"
             DataSourceID="dsComplaintTypes_FDCPA" 
             DataTextField="Complaint_Type" 
             DataValueField="ComplaintTypeID" /></td>		
	</tr>    
	<tr>
		<td class ="formSeparator" colspan="4">Comments</td>		
	</tr>	
	<tr>
		<td class="formLabelForm">PCA Comments:</td>
		<td align="left"><asp:Textbox ID="txtPCA_Comments" runat="server" TextMode="MultiLine" Columns="55" Rows="10" /></td>
		<td class="formLabelForm">ED Comments:</td>
		<td align="left"><asp:Textbox ID="txtED_Comments" runat="server" TextMode="MultiLine" Columns="55" Rows="10" /></td>		
	</tr>
	<tr>
		<td class ="formSeparator" colspan="4">Attachments</td>		
	</tr>
	<tr>
		<td class="formLabelForm">PCA Attachments:</td>
		<td align="left">
			<input id="Attachment1_PCA" type="File" runat="server" size="35" /><br />
			<input id="Attachment2_PCA" type="File" runat="server" size="35" /><br />
			<input id="Attachment3_PCA" type="File" runat="server" size="35" /><br />
			<input id="Attachment4_PCA" type="File" runat="server" size="35" /><br />
			<input id="Attachment5_PCA" type="File" runat="server" size="35" />
		</td>
		<td class="formLabelForm">ED Attachments:</td>
		<td align="left">
			<input id="Attachment6_ED" type="File" runat="server" size="35" /><br />
			<input id="Attachment7_ED" type="File" runat="server" size="35" />
		</td>
	</tr>
        <tr>
        <td align="center" colspan="4"><br />
            <asp:Button ID="btnSubmitComplaint" runat="server" Text="Submit Complaint" OnClick="btnSubmitComplaint_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
            <asp:Button ID="btnSubmitAnotherComplaint" runat="server" Text="Submit Another Complaint" OnClick="btnSubmitAnotherComplaint_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" Visible="false" /></td>
    </tr>
        <tr>
            <td colspan="4" align="center"><asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" /></td>
        </tr>                        
                        </table>
                        </fieldset>                    
                   </asp:Panel>
                   </div>
                  
<asp:Label ID="lblAgency" runat="server" Visible="true" />
<asp:Label ID="lblRandomUserID" runat="server" Visible="false" />
<asp:Label ID="lblExistingUserID" runat="server" Visible="false" />
<asp:Label ID="lblExistingComplaintID" runat="server" Visible="false" />
<asp:Label ID="lblDateAssigned" runat="server" Visible="false" />
<asp:Label ID="lblIsAdmin" runat="server" Visible="False" />
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
<asp:Label ID="lblReturnComplaintID" runat="server" Visible="false" />
<asp:Label ID="lblUploadPath" runat="server" Visible="false" />
 </form>
</body>
</html>
