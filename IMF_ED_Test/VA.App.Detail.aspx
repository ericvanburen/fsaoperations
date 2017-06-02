<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb" ValidateRequest="false" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        
        If Not Page.IsPostBack Then
            'ED and VA page - Call Check Login Status
            CheckVALogin()
            
            Dim intID As Integer = Request.QueryString("ID")
            lblID.Text = intID
            Dim strSSN As String = Request.QueryString("SSN")
            lblSSN.Text = strSSN
                
            'This page is shared by both ED and the GAs so we have to know who is looking at it.            
            If Not IsNothing(Request.Cookies("IMF")("GA_ID")) Then
                'GA is looking at the VA app
                lblGA_ID.Text = (Request.Cookies("IMF")("GA_ID").ToString()) 'This contains their agency number code
                lblED_GA_Security.Text = "GA"
            End If
            
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                'ED employee is looking at the IMF
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblED_GA_Security.Text = "ED"
            End If
                      
            'Bind the user info for this user
            BindUserID()
            
        End If
    End Sub
    
    Sub BindUserID()
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
                If IsDBNull(dr("IsAdmin")) = False Then
                    lblIsAdmin.Text = dr("IsAdmin")
                End If
            End While
            
            Page.DataBind()
        
        Finally
            dr.Close()
            strConnection.Close()
        End Try
    End Sub
    
    Sub CheckFields()
        Dim dataItem As RepeaterItem
        For Each dataItem In rptVAAppDetails.Items
            Dim lblSSNRpt As Label = CType(dataItem.FindControl("lblSSN"), Label)
            Dim ddlID_Status As DropDownList = CType(dataItem.FindControl("ddlID_Status"), DropDownList)
            Dim ddlGA_ID As DropDownList = CType(dataItem.FindControl("ddlGA_ID"), DropDownList)
            Dim ddlAllEDUsers As DropDownList = CType(dataItem.FindControl("ddlAllEDUsers"), DropDownList)
            Dim txtED_Response As TextBox = CType(dataItem.FindControl("txtED_Response"), TextBox)
            Dim txtComments As TextBox = CType(dataItem.FindControl("txtComments"), TextBox)
            Dim txtRefund_Amount As TextBox = CType(dataItem.FindControl("txtRefund_Amount"), TextBox)
            Dim chkRefund_Approved As CheckBox = CType(dataItem.FindControl("chkRefund_Approved"), CheckBox)
            Dim chkArchived As CheckBox = CType(dataItem.FindControl("chkArchived"), CheckBox)
            Dim Filebox As HtmlControls.HtmlInputFile = CType(dataItem.FindControl("Filebox"), HtmlInputFile)
            Dim Filebox2 As HtmlControls.HtmlInputFile = CType(dataItem.FindControl("Filebox2"), HtmlInputFile)
            Dim Filebox3 As HtmlControls.HtmlInputFile = CType(dataItem.FindControl("Filebox3"), HtmlInputFile)
            Dim Filebox4 As HtmlControls.HtmlInputFile = CType(dataItem.FindControl("Filebox4"), HtmlInputFile)
            Dim btnSendDischargeApprovalLetter As Button = CType(dataItem.FindControl("btnSendDischargeApprovalLetter"), Button)
            Dim btnSendDischargeNotApprovalLetter As Button = CType(dataItem.FindControl("btnSendDischargeNotApprovalLetter"), Button)
            Dim hypGA_ID As HyperLink = CType(dataItem.FindControl("hypGA_ID"), HyperLink)
            hypGA_ID.NavigateUrl = "ED.ga.contact.aspx?GA_ID=" & ddlGA_ID.SelectedValue
            Dim rblDenialReason As RadioButtonList = CType(dataItem.FindControl("rblDenialReason"), RadioButtonList)
            rblDenialReason.Items.RemoveAt(0)


            
            'We need to record the value of who the IMF is assigned to when the page first loads
            'This will be compared to the new Assigned To value to record a Date Reassigned value
            lblAssignedTo.Text = ddlAllEDUsers.SelectedValue
                   
            If lblED_GA_Security.Text = "GA" Then
                'We need an additional check here for GAs to make sure that they are looking at only their own VA Apps
                'We will make sure that their GA code matches the GA_ID in the ddlddlGA_ID dropdown            
                'Dim ddlGA_ID As DropDownList = CType(dataItem.FindControl("ddlGA_ID"), DropDownList)
                
                'If the user is a GA, then we want to hide the full SSN field
                lblSSNRpt.Text = lblSSN.Text

                If lblGA_ID.Text <> ddlGA_ID.SelectedValue Then
                    Response.Redirect("not.authorized.aspx")
                Else
                    'These fields cannot be edited by any GA
                    ddlID_Status.Enabled = False
                    ddlAllEDUsers.Enabled = False
                    txtED_Response.Enabled = False
                    txtRefund_Amount.Enabled = False
                    chkRefund_Approved.Enabled = False
                    chkArchived.Enabled = False
                    Filebox.Disabled = True
                    Filebox2.Disabled = True
                    Filebox3.Disabled = True
                    Filebox4.Disabled = True
                    btnSendDischargeApprovalLetter.Enabled = False
                    btnSendDischargeNotApprovalLetter.Enabled = False
                    rblDenialReason.Enabled = False
                End If
            End If
            
            'Only Admins should be able to update the Assigned To dropdownbox , GA Comment, Refund amount and Refund approved boxes 
            'everyone else will be able to update the Current Status and ED Comments boxes
            If lblIsAdmin.Text = "False" Then
                txtComments.Enabled = False
                ddlAllEDUsers.Enabled = False
                txtRefund_Amount.Enabled = False
                chkRefund_Approved.Enabled = False
            End If
                       
            'Once an Analyst moves an VA app to status 3 (completed) or status 7(returned to GA) or status 6 (retracted) they
            'should not be able to edit it again so we disable ddlID_status.
            'Only admins can change the status from that point
            'If ddlID_Status.SelectedValue = 3 And lblIsAdmin.Text <> "True" Then
            '    ddlID_Status.Enabled = False
            'ElseIf ddlID_Status.SelectedValue = 7 And lblIsAdmin.Text <> "True" Then
            '    ddlID_Status.Enabled = False
            'ElseIf ddlID_Status.SelectedValue = 6 And lblIsAdmin.Text <> "True" Then
            '    ddlID_Status.Enabled = False
            'End If
            
            'They also want ED Analysts to be able to update/edit their own VA Apps
            'First establish they they are a non-admin ED user and not a GA
            If lblED_GA_Security.Text = "ED" And lblIsAdmin.Text <> "True" Then
                'ddlAllEDUsers contains the UserID value of the Analyst the VA App is assigned to
                'If this value does not equal the userID value of the person logged in and is also not an admin, then
                'should not able to update anything 
                If ddlAllEDUsers.SelectedValue <> lblEDUserID.Text And lblIsAdmin.Text <> "True" Then
                    ddlAllEDUsers.Enabled = False
                    txtRefund_Amount.Enabled = False
                    chkRefund_Approved.Enabled = False
                End If
            End If
            
            
        Next
    End Sub
    
    Sub Edit_Record(ByVal Src As Object, ByVal e As RepeaterCommandEventArgs)
        'Sub Edit_Record (Src As Object, Args As RepeaterCommandEventArgs)
        'This updates the ED users password and team assignment
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        Dim ddlGA_ID As DropDownList = e.Item.FindControl("ddlGA_ID")
        Dim ddlAllEDUsers As DropDownList = e.Item.FindControl("ddlAllEDUsers")
        Dim lblDateAssigned As Label = e.Item.FindControl("lblDateAssigned")
        Dim lblDateReAssigned As Label = e.Item.FindControl("lblDateReAssigned")
        Dim lblDateClosed As Label = e.Item.FindControl("lblDateClosed")
        Dim txtDisability_Effective_Date As TextBox = e.Item.FindControl("txtDisability_Effective_Date")
        Dim chkDisability_Type1 As CheckBox = e.Item.FindControl("chkDisability_Type1")
        Dim chkDisability_Type2 As CheckBox = e.Item.FindControl("chkDisability_Type2")
        Dim ddlID_Status As DropDownList = e.Item.FindControl("ddlID_Status")
        Dim txtComments As TextBox = e.Item.FindControl("txtComments")
        Dim txtED_Response As TextBox = e.Item.FindControl("txtED_Response")
        Dim Filebox As HtmlControls.HtmlInputFile = e.Item.FindControl("Filebox")
        Dim Filebox2 As HtmlControls.HtmlInputFile = e.Item.FindControl("Filebox2")
        Dim Filebox3 As HtmlControls.HtmlInputFile = e.Item.FindControl("Filebox3")
        Dim Filebox4 As HtmlControls.HtmlInputFile = e.Item.FindControl("Filebox4")
        Dim lblID_Status As Label = e.Item.FindControl("lblID_Status")
        Dim txtRefund_Amount As TextBox = e.Item.FindControl("txtRefund_Amount")
        Dim chkRefund_Approved As CheckBox = e.Item.FindControl("chkRefund_Approved")
        Dim chkArchived As CheckBox = e.Item.FindControl("chkArchived")
        Dim hypLinkED1 As HyperLink = DirectCast(e.Item.FindControl("Hyperlink2"), HyperLink)
        Dim hypLinkED2 As HyperLink = DirectCast(e.Item.FindControl("Hyperlink3"), HyperLink)
        Dim hypLinkED3 As HyperLink = DirectCast(e.Item.FindControl("Hyperlink4"), HyperLink)
        Dim hypLinkED4 As HyperLink = DirectCast(e.Item.FindControl("Hyperlink5"), HyperLink)
        Dim rblDenialReason As RadioButtonList = DirectCast(e.Item.FindControl("rblDenialReason"), RadioButtonList)
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UpdateVAApp"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("@GA_ID", ddlGA_ID.SelectedValue)
        If ddlAllEDUsers.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@UserID", ddlAllEDUsers.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@UserID", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If
        
        If ddlAllEDUsers.SelectedValue <> "" AndAlso lblDateAssigned.Text = "" Then
            cmd.Parameters.Add("@DateAssigned", SqlDbType.SmallDateTime).Value = DateTime.Now
        ElseIf ddlAllEDUsers.SelectedValue <> "" AndAlso lblDateAssigned.Text <> "" Then
            cmd.Parameters.Add("@DateAssigned", SqlDbType.SmallDateTime).Value = lblDateAssigned.Text
        Else
            cmd.Parameters.Add("@DateAssigned", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If
        
        If ddlAllEDUsers.SelectedValue.ToString() <> lblAssignedTo.Text.ToString() Then
            'The assigned to value has changed since the page was loaded so we need to update the DateReassigned value
            cmd.Parameters.Add("@DateReAssigned", SqlDbType.SmallDateTime).Value = DateTime.Now
        End If
                   
        'Putting an account into one of these status codes closes the account and populates the DateClosed field with 
        'the todays date
        '1	Meets Criteria for Discharge - No DMCS account affected 
        '3	Meets Criteria for Discharge – DMCS account dischargeable with no refund 
        '4	Denied - Does not Meet Criteria for Discharge 
        '7 Pending Refund Posting 
        '10 - Returned - See Comments
        '14 Meets Criteria for Discharge – DMCS Refund Paid
        
        If lblDateClosed.Text = "" Then
            If ddlID_Status.SelectedValue = 1 Then 'Meets Criteria for Discharge - No DMCS account affected 
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            If ddlID_Status.SelectedValue = 3 Then 'Meets Criteria for Discharge – DMCS account dischargeable with no refund 
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            If ddlID_Status.SelectedValue = 4 Then 'Denied - Does not Meet Criteria for Discharge 
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            If ddlID_Status.SelectedValue = 10 Then 'Returned - See Comments
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            If ddlID_Status.SelectedValue = 14 Then 'Meets Criteria for Discharge – DMCS Refund Paid 
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DateTime.Now
            End If
            
        ElseIf lblDateClosed.Text <> "" Then
            If ddlID_Status.SelectedValue <> 1 And ddlID_Status.SelectedValue <> 3 And ddlID_Status.SelectedValue <> 4 And ddlID_Status.SelectedValue <> 14 Then 'Remove Completed Status or Returned to GA Status or Retracted Status
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = lblDateClosed.Text
            End If
        Else
            cmd.Parameters.Add("@DateClosed", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If
        
        If txtDisability_Effective_Date.Text <> "" Then
            cmd.Parameters.Add("@Disability_Effective_Date", SqlDbType.SmallDateTime).Value = txtDisability_Effective_Date.Text
        Else
            cmd.Parameters.Add("@Disability_Effective_Date", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If
        
        cmd.Parameters.AddWithValue("@ID_Status", ddlID_Status.SelectedValue)
        cmd.Parameters.AddWithValue("@Disability_Type1", chkDisability_Type1.Checked)
        cmd.Parameters.AddWithValue("@Disability_Type2", chkDisability_Type2.Checked)
              
        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        Else
            cmd.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        If txtED_Response.Text <> "" Then
            cmd.Parameters.AddWithValue("@ED_Response", txtED_Response.Text)
        Else
            cmd.Parameters.AddWithValue("@ED_Response", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        If txtRefund_Amount.Text <> "" Then
            cmd.Parameters.AddWithValue("@Refund_Amount", txtRefund_Amount.Text)
        Else
            cmd.Parameters.AddWithValue("@Refund_Amount", SqlDbType.VarChar).Value = DBNull.Value
        End If
        
        cmd.Parameters.AddWithValue("@Refund_Approved", chkRefund_Approved.Checked)
        cmd.Parameters.AddWithValue("@Archived", chkArchived.Checked)
        If rblDenialReason.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@DenialReason", rblDenialReason.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@DenialReason", SqlDbType.Int).Value = DBNull.Value
        End If
        
        
        'ED Attachment URL
        'This entire section @Attachment_ED parameter should get passed to the sproc only if the user is an ED user
        If lblED_GA_Security.Text = "ED" Then
            Dim strFileNamePath As String = Filebox.PostedFile.FileName
            If strFileNamePath.Length > 0 Then
        
                Dim strFileNameOnly As String
                Dim strSaveLocation As String
            
                strFileNameOnly = lblID.Text & ".ED." & System.IO.Path.GetFileName(Filebox.PostedFile.FileName)
                strFileNameOnly = ReplaceIllegalChars(strFileNameOnly)
                
                'This checks for a valid file name and type
                Dim FilenameRegex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif||tiff|jpg|txt|gif|png)$")
                If Not FilenameRegex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                    Response.Redirect("invalid.filetype.aspx")
                End If
                
                strSaveLocation = "D:\DCS\secure\IMF_ED\x49g\vaapps\" & strFileNameOnly
                
                Filebox.PostedFile.SaveAs(strSaveLocation)
                cmd.Parameters.Add("@Attachment_ED", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/vaapps/" & strFileNameOnly
            Else
                If String.IsNullOrEmpty(hypLinkED1.NavigateUrl) Then
                    cmd.Parameters.Add("@Attachment_ED", SqlDbType.VarChar).Value = DBNull.Value
                End If
            
                'ED2 Attachment URL          
                Dim strFileNamePath2 As String = Filebox2.PostedFile.FileName
                If strFileNamePath2.Length > 0 Then

                    Dim strFileNameOnly2 As String
                    Dim strSaveLocation2 As String

                    strFileNameOnly2 = lblID.Text & ".ED." & System.IO.Path.GetFileName(Filebox2.PostedFile.FileName)
                    strFileNameOnly2 = ReplaceIllegalChars(strFileNameOnly2)
                
                    'This checks for a valid file name and type
                    Dim Filename2Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
                    If Not Filename2Regex.IsMatch(strFileNameOnly2.ToLower(), RegexOptions.IgnoreCase) Then
                        Response.Redirect("invalid.filetype.aspx")
                    End If
                
                    strSaveLocation2 = "D:\DCS\secure\IMF_ED\x49g\vaapps\" & strFileNameOnly2
                    Filebox2.PostedFile.SaveAs(strSaveLocation2)
                    cmd.Parameters.Add("@Attachment_ED2", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/vaapps/" & strFileNameOnly2
                Else
                    If String.IsNullOrEmpty(hypLinkED2.NavigateUrl) Then
                        cmd.Parameters.Add("@Attachment_ED2", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                End If
                
                'ED3 Attachment URL          
                Dim strFileNamePath3 As String = Filebox3.PostedFile.FileName
                If strFileNamePath3.Length > 0 Then

                    Dim strFileNameOnly3 As String
                    Dim strSaveLocation3 As String

                    strFileNameOnly3 = lblID.Text & ".ED." & System.IO.Path.GetFileName(Filebox3.PostedFile.FileName)
                    strFileNameOnly3 = ReplaceIllegalChars(strFileNameOnly3)
                
                    'This checks for a valid file name and type
                    Dim Filename3Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
                    If Not Filename3Regex.IsMatch(strFileNameOnly3.ToLower(), RegexOptions.IgnoreCase) Then
                        Response.Redirect("invalid.filetype.aspx")
                    End If
                
                    strSaveLocation3 = "D:\DCS\secure\IMF_ED\x49g\vaapps\" & strFileNameOnly3
                    Filebox3.PostedFile.SaveAs(strSaveLocation3)
                    cmd.Parameters.Add("@Attachment_ED3", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/vaapps/" & strFileNameOnly3
                Else
                    If String.IsNullOrEmpty(hypLinkED3.NavigateUrl) Then
                        cmd.Parameters.Add("@Attachment_ED3", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                End If
                
                'ED4 Attachment URL          
                Dim strFileNamePath4 As String = Filebox4.PostedFile.FileName
                If strFileNamePath4.Length > 0 Then

                    Dim strFileNameOnly4 As String
                    Dim strSaveLocation4 As String

                    strFileNameOnly4 = lblID.Text & ".ED." & System.IO.Path.GetFileName(Filebox4.PostedFile.FileName)
                    strFileNameOnly4 = ReplaceIllegalChars(strFileNameOnly4)
                
                    'This checks for a valid file name and type
                    Dim Filename4Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
                    If Not Filename4Regex.IsMatch(strFileNameOnly4.ToLower(), RegexOptions.IgnoreCase) Then
                        Response.Redirect("invalid.filetype.aspx")
                    End If
                
                    strSaveLocation4 = "D:\DCS\secure\IMF_ED\x49g\vaapps\" & strFileNameOnly4
                    Filebox4.PostedFile.SaveAs(strSaveLocation4)
                    cmd.Parameters.Add("@Attachment_ED4", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/vaapps/" & strFileNameOnly4
                Else
                    If String.IsNullOrEmpty(hypLinkED4.NavigateUrl) Then
                        cmd.Parameters.Add("@Attachment_ED4", SqlDbType.VarChar).Value = DBNull.Value
                    End If
                End If
            End If
        End If
        
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        rptVAAppDetails.DataBind()
        
        lblUpdateStatus.Text = "Your discharge application has been updated"
        
        'Now call UpdateApprovalStatus() to insert a new approval status history record if the new status value differs from the previous one (if any)
        If ddlID_Status.SelectedValue <> lblID_Status.Text Then
            UpdateApprovalStatus(ddlID_Status.SelectedValue)
        End If
    End Sub
    
    Protected Sub rptVAAppDetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Then
            Dim link1 As HyperLink = DirectCast(e.Item.FindControl("HyperLink1"), HyperLink)
            Dim link2 As HyperLink = DirectCast(e.Item.FindControl("HyperLink2"), HyperLink)
            Dim link3 As HyperLink = DirectCast(e.Item.FindControl("HyperLink3"), HyperLink)
            Dim link4 As HyperLink = DirectCast(e.Item.FindControl("HyperLink4"), HyperLink)
            Dim link5 As HyperLink = DirectCast(e.Item.FindControl("HyperLink5"), HyperLink)
            Dim lblSSN As Label = DirectCast(e.Item.FindControl("lblSSN"), Label)
            lblSSN2.Text = lblSSN.Text
            
            'Link GA
            If String.IsNullOrEmpty(link1.NavigateUrl) Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l1"), HtmlGenericControl)
                li.Visible = False
            End If
            'Link ED
            If String.IsNullOrEmpty(link2.NavigateUrl) Then
                Dim li2 As HtmlGenericControl = CType(e.Item.FindControl("l2"), HtmlGenericControl)
                li2.Visible = False
            End If
            'Link ED2
            If String.IsNullOrEmpty(link3.NavigateUrl) Then
                Dim li3 As HtmlGenericControl = CType(e.Item.FindControl("l3"), HtmlGenericControl)
                li3.Visible = False
            End If
            'Link ED3
            If String.IsNullOrEmpty(link4.NavigateUrl) Then
                Dim li4 As HtmlGenericControl = CType(e.Item.FindControl("l4"), HtmlGenericControl)
                li4.Visible = False
            End If
            'Link ED4
            If String.IsNullOrEmpty(link5.NavigateUrl) Then
                Dim li5 As HtmlGenericControl = CType(e.Item.FindControl("l5"), HtmlGenericControl)
                li5.Visible = False
            End If
        End If
        CheckFields()
    End Sub
    
       
    Protected Sub UpdateApprovalStatus(ByVal ID_Status As Integer)
        'This inserts a new approval status record into Requests_VA_Approval_Status
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Requests_VA_Approval_Status_Insert"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("@ID_Status", ID_Status)
        cmd.Parameters.AddWithValue("@DateSubmitted", DateTime.Now())
        cmd.Parameters.AddWithValue("@UserID", lblEDUserID.Text)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            lblUpdateStatus.Text = "This VA Discharge App has been updated"
            'Rebind the history gridview
            GridView1.DataBind()
            dsVAAppDetail.DataBind()
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
        Return NewFileName
    End Function
    
    Function PCase(ByVal strInput As String) As String
        Dim I As Integer
        Dim CurrentChar, PrevChar As String
        Dim strOutput As String

        PrevChar = ""
        strOutput = ""

        For I = 1 To Len(strInput)
            CurrentChar = Mid(strInput, I, 1)

            Select Case PrevChar
                Case "", " ", ".", "-", ",", """", "'"
                    strOutput = strOutput & UCase(CurrentChar)
                Case Else
                    strOutput = strOutput & LCase(CurrentChar)
            End Select

            PrevChar = CurrentChar
        Next I

        PCase = strOutput
    End Function

    
    Sub btnSendDischargeApprovalLetter_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("https://www.fsacollections.ed.gov/secure/imf_ed/pdf/default.aspx?ID=" & lblID.Text & "&ApprovalType=Approved")
    End Sub
    
    Sub btnSendDischargeNotApprovalLetter_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("https://www.fsacollections.ed.gov/secure/imf_ed/pdf/default.aspx?ID=" & lblID.Text & "&ApprovalType=NotApproved")
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script src="js/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            var selected = $('#rptVAAppDetails_ctl01_ddlID_Status').val();
            $("#spnPreviousID_Status").text('').append(selected);
            $("#rptVAAppDetails_ctl01_ddlID_Status").change(onSelectChange);

            $('#rptVAAppDetails_ctl01_txtRefund_Amount').blur(function () {
                var str = $('#rptVAAppDetails_ctl01_txtRefund_Amount').val();
                var newstr = str.replace("$", "");
                $('#rptVAAppDetails_ctl01_txtRefund_Amount').val(newstr);
            });
        }
    );

        function onSelectChange() {
            var IsAdmin = $('#lblIsAdmin').text();

            // display the output of the item selected for ddlID_Status
            var selected = $("#rptVAAppDetails_ctl01_ddlID_Status option:selected");

            //User should provide a Denial Reason for this status code
            if (selected.val() == 4) {
                alert("Please specify a Denial Reason below");
            }


            if (IsAdmin != "True") {
                // working with non admin here
                if (selected.val() == 1 || selected.val() == 2 || selected.val() == 3 || selected.val() == 7) {
                    alert("This status code is available only to system administrators");

                    //set the ddlID_Status dropdown box back to its original value
                    $("#rptVAAppDetails_ctl01_ddlID_Status").val($("#spnPreviousID_Status").text());
                    return false;
                }
                //If pending refund approval is selected, the analyst must upload a refund worksheet as an attachment
                if (selected.val() == 6) {
                    alert("Please be sure to upload a refund worksheet if you have not already done so");
                }

            } else {
                //working with an admin here                    
                if (selected.val() == 2 || selected.val() == 7) {
                    //If one of the refund codes is selected (2,7) make sure refund amount has a value
                    var refundAmount = $('#rptVAAppDetails_ctl01_txtRefund_Amount').val().length;
                    if (refundAmount == 0) {
                        alert("The Refund Amount box must contain a value to select this status");
                        //set the ddlID_Status dropdown box back to its original value
                        $("#rptVAAppDetails_ctl01_ddlID_Status").val($("#spnPreviousID_Status").text());
                        return false;
                    }


                    //Make sure refund approved box is checked
                    var refundApproved = $('#rptVAAppDetails_ctl01_chkRefund_Approved').attr('checked');
                    if (refundApproved == false) {
                        alert("The Refund Approved box must first be checked to select this status");
                        //set the ddlID_Status dropdown box back to its original value
                        $("#rptVAAppDetails_ctl01_ddlID_Status").val($("#spnPreviousID_Status").text());
                        return false;
                    }
                }
            }
        } 
    </script>     

</head>
<body>
    <form id="form1" runat="server">
      <!--This one populates the IMF details form-->
                     <asp:SqlDataSource ID="dsVAAppDetail" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_VAApp_Details" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                    <asp:ControlParameter ControlID="lblID" Name="ID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                            
                      <!--This one populates the GAs dropdown-->
                      <asp:SqlDataSource ID="dsGAs" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllGAs" SelectCommandType="StoredProcedure" />
                            
                       <!--This one populates the ED Users dropdown-->
                      <asp:SqlDataSource ID="dsAllEDUsers" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllUsersActive" SelectCommandType="StoredProcedure" />
                            
                         <!--This one populates the Status dropdown-->
                      <asp:SqlDataSource ID="dsAllStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllStatus_VA" SelectCommandType="StoredProcedure" />     
                      
    <fieldset>
    <legend class="fieldsetLegend">VA Discharge Details</legend><br />    
    <div align="left">
    
    <asp:Repeater id="rptVAAppDetails" Runat="Server" DataSourceID="dsVAAppDetail" OnItemCommand="Edit_Record" OnItemDataBound="rptVAAppDetails_ItemDataBound">
<HeaderTemplate>
    <table border="0" cellpadding="6" cellspacing="3" style="border-collapse:collapse;" >
    </HeaderTemplate>
    <ItemTemplate>        
    <tr>
            <td class ="formLabelForm">SSN:</td>
            <td><asp:Label ID="lblSSN" runat="server" Text='<%# Eval("SSN") %>' /></td>
            <td class ="formLabelForm">VA App ID:</td>
            <td><asp:Label ID="lblID2" runat="server" Text='<%# lblID.Text %>' /></td>         
     </tr>                    
      <tr>
        <td class ="formLabelForm">Current Status:</td>
            <td><asp:DropDownList id="ddlID_Status" Runat="Server" CssClass="formLabel"
                          DataSourceID="dsAllStatus"
                          DataTextField="Status"
                          DataValueField="ID_Status" AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("ID_Status") %>'> 
                          <asp:ListItem Text="" Value="" />  
                </asp:DropDownList></td>

            <td class ="formLabelForm">Date Submitted:</td>
            <td><asp:Label ID="lblDateSubmitted" runat="server" Text='<%# Eval("DateSubmitted") %>' /></td>

      </tr>
      
     <tr>
            <td class ="formLabelForm">Borrower First Name:</td>
            <td><asp:Label ID="lblBorrower_FName" runat="server" Text='<%# PCase(Eval("Borrower_FName")) %>' /></td> 
            <td class ="formLabelForm">Borrower Last Name:</td>
            <td><asp:Label ID="lblBorrower_LName" runat="server" Text='<%# PCase(Eval("Borrower_LName")) %>' /></td>               
        </tr>     
         <tr>
            <td class="formLabelForm">Disability Type:</td>
            <td> <asp:Checkbox ID="chkDisability_Type1" runat="server" Checked='<%# Eval("Disability_Type1") %>'  Text="The veteran has a service-connected disability that is 100% disabling" CssClass="formLabel"  /><br />
                    <asp:Checkbox ID="chkDisability_Type2" runat="server" Checked='<%# Eval("Disability_Type2") %>' Text="The veteran is totally disabled based on an individual unemployability determination" CssClass="formLabel"  />
        </td>
           <td class ="formLabelForm">Effective Date of Disability:</td>
            <td><asp:Textbox ID="txtDisability_Effective_Date" runat="server" Text='<%# Eval("Disability_Effective_Date", "{0:d}") %>' /></td>                                 
        </tr>
        <tr>
            <td class ="formLabelForm">Date Assigned to Analyst:</td>
            <td><asp:Label ID="lblDateAssigned" runat="server" Text='<%# Eval("DateAssigned") %>' /></td>
            <td class ="formLabelForm">Date ReAssigned to Analyst:</td>
            <td><asp:Label ID="lblDateReAssigned" runat="server" Text='<%# Eval("DateReAssigned") %>' /></td>                                     
        </tr>   
        
        <tr>
            <td class ="formLabelForm">Assigned To:</td>
            <td><asp:DropDownList id="ddlAllEDUsers" Runat="Server" CssClass="formLabel"
                         DataSourceID="dsAllEDUsers"
                          DataTextField="UserName"
                          DataValueField="UserID"
                          AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("UserID") %>'>
                          <asp:ListItem Text="" Value="" />                             
                  </asp:DropDownList></td> 
            <td class ="formLabelForm">Date Closed:</td>
            <td><asp:Label ID="lblDateClosed" runat="server" Text='<%# Eval("DateClosed") %>' /></td>             	
           </tr>  
         <tr>
            <td class="formLabelForm">Guaranty Agency: <asp:HyperLink ID="hypGA_ID" runat="server" Text="(agency contact information)" NavigateUrl="~/IMF_ED/ED.ga.contact.aspx" CssClass="smallText" /></td>
            <td colspan="3"><asp:DropDownList ID="ddlGA_ID" runat="server" CssClass="formLabel"
                         DataSourceID="dsGAs"
                          DataTextField="GA_Name"
                          DataValueField="GA_ID" AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("GA_ID") %>' Enabled="false">
                          <asp:ListItem Text="" Value="" />                              
                </asp:DropDownList>                
            </td>            
                      
        </tr>
        <tr>
             <td class ="formLabelForm">GA Employee:</td>
            <td><asp:Label ID="lblGA_Employee" runat="server" Text='<%# Eval("GA_Employee") %>' /></td>
            <td class ="formLabelForm">GA Phone:</td>
            <td><asp:Label ID="lblGA_Phone" runat="server" Text='<%# Eval("GA_Phone") %>' /></td> 
        </tr>
        <tr>
           <td class ="formLabelForm">Refund Amount:</td>
            <td><asp:Textbox ID="txtRefund_Amount" runat="server" Text='<%# Eval("Refund_Amount") %>' /><br />
          </td>  
            <td class ="formLabelForm">Refund Approved?</td>
            <td><asp:Checkbox ID="chkRefund_Approved" runat="server" Checked='<%# Eval("Refund_Approved") %>' /></td>                              
        </tr>     
           
          <tr>
            <td class ="formLabelForm">GA Comments:</td>
            <td><asp:Textbox ID="txtComments" runat="server" Text='<%# Eval("Comments") %>' TextMode="MultiLine" Columns="45" Rows="15" /></td> 
            <td class ="formLabelForm">ED Comments:</td>
            <td><asp:Textbox ID="txtED_Response" runat="server" Text='<%# Eval("ED_Response") %>' TextMode="MultiLine" Columns="45" Rows="15" /></td>           
        </tr>    
        <tr>
        	<td> </td>
        	<td> </td>
        	<td class ="formLabelForm">Archived?</td>
        	<td><asp:Checkbox ID="chkArchived" runat="server" Checked='<%# Eval("Archived") %>' /></td>
        </tr>  
        <tr>
        <td class ="formLabelForm" width="25%" valign="top">Denial Reason:</td>
        <td colspan="3">
        <asp:RadioButtonList runat="server" ID="rblDenialReason" RepeatDirection="Horizontal" SelectedValue='<%# Eval("DenialReason") %>'>
        <asp:ListItem Value="" Text="" />
        <asp:ListItem Value="1" Text="Based on the information you provided, you have not been determined by the Veterans Administration to have a service connected disability, or service connected disabilities, that are 100% disabling or determined to be totally disabled based on individual unemployability" />
        <asp:ListItem Value="2" Text="The Veterans Administration has informed us that you have not been determined to have a service connected disability, or service connected disabilities, that are 100% disabling or are totally disabled based on individual unemployability.  This information needs to be pulled into the query results when we do a search" />
        </asp:RadioButtonList></td>
        </tr>
         <tr>
              <td class ="formLabelForm" align="left">Add Attachment:</td>
              <td colspan="2"><input id="Filebox" type="File" runat="server" size="35" /></td>
         </tr>
         <tr>
              <td class ="formLabelForm" align="left">Add Attachment 2:</td>
              <td colspan="2"><input id="Filebox2" type="File" runat="server" size="35" /></td>
         </tr>
         <tr>
              <td class ="formLabelForm" align="left">Add Attachment 3:</td>
              <td colspan="2"><input id="Filebox3" type="File" runat="server" size="35" /></td>
         </tr>
         <tr>
              <td class ="formLabelForm" align="left">Add Attachment 4:</td>
              <td colspan="2"><input id="Filebox4" type="File" runat="server" size="35" /></td>
         </tr>
        <tr>
            <td colspan="4" align="center"><u><b>Attachments</b></u> <br /><span class="warningMessage">* If submitting an attachment, please ensure that 
                                    your file name has a <a href="file.types.htm" target="name" onclick="window.open('file.types.htm','name','height=255, width=250,toolbar=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no'); return false;">valid file extension</a>.</span><br /></td>
        </tr>
        <tr>
        <td colspan="4">
            <ul>                                                                      
                   <li id="l1" runat="server"><b>GA Attachment:</b> <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("Attachment1")%>' runat="server" Target="_blank">Attachment1</asp:HyperLink></li> 
                   <li id="l2" runat="server"><b>ED Attachment:</b> <asp:HyperLink ID="HyperLink2" NavigateUrl='<%# Eval("Attachment_ED")%>' runat="server" Target="_blank">Attachment ED</asp:HyperLink></li> 
                   <li id="l3" runat="server"><b>ED Attachment 2:</b> <asp:HyperLink ID="HyperLink3" NavigateUrl='<%# Eval("Attachment_ED2")%>' runat="server" Target="_blank">Attachment ED</asp:HyperLink></li>
                   <li id="l4" runat="server"><b>ED Attachment 3:</b> <asp:HyperLink ID="HyperLink4" NavigateUrl='<%# Eval("Attachment_ED3")%>' runat="server" Target="_blank">Attachment ED</asp:HyperLink></li>     
                   <li id="l5" runat="server"><b>ED Attachment 4:</b> <asp:HyperLink ID="HyperLink5" NavigateUrl='<%# Eval("Attachment_ED4")%>' runat="server" Target="_blank">Attachment ED</asp:HyperLink></li>
            </ul> 
        </td>
        </tr>        
                
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnUpdateVAApp" runat="server" Text="Update VA App" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                <asp:Button ID="btnSendDischargeApprovalLetter" runat="server" Text="Send Discharge Approval Letter" OnClick="btnSendDischargeApprovalLetter_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                <asp:Button ID="btnSendDischargeNotApprovalLetter" runat="server" Text="Send Discharge Not Approved Letter" OnClick="btnSendDischargeNotApprovalLetter_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'"  />
            </td>
        </tr> 
        <tr>
        <td><asp:Label ID="lblID_Status" runat="server" Visible="False" Text='<%# Eval("ID_Status") %>' /></td>
        </tr>
        </ItemTemplate>
              
        <FooterTemplate>        
        </table>
        </FooterTemplate>
        </asp:Repeater>
        <div align="center" style="width: 90%">
                <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" /><br />
                <asp:Label ID="lblError" runat="server" />      
         </div>
         </fieldset>
     
     <asp:SqlDataSource ID="dsRequests_VA_Approval_Status_All" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_Requests_VA_Approval_Status_All" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblID" Name="ID" DefaultValue="0" />                            
                      </SelectParameters>                      
     </asp:SqlDataSource>       
           

<!--Discharge approval history-->
      <div class="grid">                          
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="id" DataSourceID="dsRequests_VA_Approval_Status_All" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" HeaderStyle-HorizontalAlign="Left" 
                            AllowPaging="true" AllowSorting="true" PageSize="20" PagerSettings-Position="TopAndBottom" Caption="Discharge Approval Status History">                           
                            
                            <EmptyDataTemplate>
                                    There is no VA discharge approval history for this account
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>                           
                                                                                                     
                                    <asp:BoundField 
                                    DataField="Status" 
                                    HeaderText="Status" 
                                    SortExpression="Status" />
                                    
                                    <asp:BoundField 
                                    DataField="DateSubmitted" 
                                    HeaderText="Date" DataFormatString="{0:d}" 
                                    SortExpression="DateSubmitted" />
                                    
                                    <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="User name" 
                                    SortExpression="Username" />
                                                                        
                          </Columns>                
                          </asp:GridView>
       </div>
       <br />
       <!--Duplicate IMFs-->
    <asp:SqlDataSource ID="dsDuplicateApps" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>"
        SelectCommand="SELECT Id, [Username], dbo.Decrypt([SSN]) AS SSN, [Status], [DateSubmitted], [GA_Name] FROM [v_MyVAApps] WHERE (dbo.Decrypt([SSN]) = @SSN)">
        <SelectParameters>
            <asp:ControlParameter Name="SSN" ControlID="lblSSN2" />
        </SelectParameters>
    </asp:SqlDataSource>

       <div class="grid">                          
                            <asp:GridView ID="grdDuplicateApps" runat="server" DataSourceID="dsDuplicateApps" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" HeaderStyle-HorizontalAlign="Left" 
                            Caption="All VA Apps for this SSN/Potential Duplicates"> 
                                <EmptyDataTemplate>
                                    There are no duplicate VA records for this SSN
                                </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                                <Columns>
                                <asp:HyperLinkField 
                                    DataTextField="id" 
                                    HeaderText="VA ID" 
                                    DataNavigateUrlFields="Id" 
                                    ItemStyle-CssClass="first" 
                                    SortExpression="Id" 
                                    DataNavigateUrlFormatString="va.app.detail.aspx?Id={0}" >
                                        <HeaderStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>
                                    <asp:BoundField DataField="Username" HeaderText="Assigned To" />
                                    <asp:BoundField DataField="DateSubmitted" HeaderText="Date" DataFormatString="{0:d}" />
                                    <asp:BoundField DataField="Status" HeaderText="Status" />
                                    <asp:BoundField DataField="GA_Name" HeaderText="GA Name" />
                                </Columns>
                            </asp:GridView>
        </div>
      
         
    <asp:Label ID="lblID" runat="server" Visible="false" />
    <asp:Label ID="lblSSN" runat="server" Visible="false" />
    <asp:Label ID="lblSSN2" runat="server" Visible="false" />
    <asp:Label ID="lblIsAdmin" runat="server" Visible="True" CssClass="hiddenField" />
    <asp:Label ID="lblID_Status" runat="server" Visible="False" />
    <asp:Label ID="lblGA_ID" runat="server" Visible="False" />
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
     <asp:Label ID="lblED_GA_Security" runat="server" Visible="false" />
      <asp:Label ID="lblAssignedTo" runat="server" Visible="false" />
     <span id="spnPreviousID_Status" class="hiddenField"></span>
    </form>
</body>
</html>
