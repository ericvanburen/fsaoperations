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
            
            Dim intComplaintID As Integer = Request.QueryString("ComplaintID")
            lblComplaintID.Text = intComplaintID
            
            'See whether a ED or PCA user is completing this form
            CheckFields()
            
        End If
    End Sub
    
    Sub CheckFields()
                        
        If lblED_AG_Security.Text = "AG" Then
            Dim dataItem As RepeaterItem
            For Each dataItem In rptComplaintDetails.Items
                'These fields cannot be edited by any PCA                     
                Dim ddlAgencyID As DropDownList = CType(dataItem.FindControl("ddlAgencyID"), DropDownList)
                Dim ddlAllEDUsers As DropDownList = CType(dataItem.FindControl("ddlAllEDUsers"), DropDownList)
                Dim txtComplaint_Receipt_Date As TextBox = CType(dataItem.FindControl("txtComplaint_Receipt_Date"), TextBox)
                Dim txtAgency_Receipt_Date As TextBox = CType(dataItem.FindControl("txtAgency_Receipt_Date"), TextBox)
                Dim txtPCA_Employee_FName As TextBox = CType(dataItem.FindControl("txtPCA_Employee_FName"), TextBox)
                Dim txtPCA_Employee_LName As TextBox = CType(dataItem.FindControl("txtPCA_Employee_LName"), TextBox)
                Dim txtPCA_Employee_Phone As TextBox = CType(dataItem.FindControl("txtPCA_Employee_Phone"), TextBox)
                Dim txtPCA_Employee_Email As TextBox = CType(dataItem.FindControl("txtPCA_Employee_Email"), TextBox)
                Dim txtCollector_Name As TextBox = CType(dataItem.FindControl("txtCollector_Name"), TextBox)
                Dim txtBorrower_FName As TextBox = CType(dataItem.FindControl("txtBorrower_FName"), TextBox)
                Dim txtBorrower_LName As TextBox = CType(dataItem.FindControl("txtBorrower_LName"), TextBox)
                Dim txtDebtID As TextBox = CType(dataItem.FindControl("txtDebtID"), TextBox)
                Dim txtPCA_Comments As TextBox = CType(dataItem.FindControl("txtPCA_Comments"), TextBox)
                Dim txtED_Comments As TextBox = CType(dataItem.FindControl("txtED_Comment"), TextBox)
                Dim ddlComplaint_Source As DropDownList = CType(dataItem.FindControl("ddlComplaint_Source"), DropDownList)
                Dim chkArchived As CheckBox = CType(dataItem.FindControl("chkArchived"), CheckBox)
                Dim ddlStatusID As DropDownList = CType(dataItem.FindControl("ddlStatusID"), DropDownList)
                Dim ddlUserID As DropDownList = CType(dataItem.FindControl("ddlAllEDUsers"), DropDownList)
                Dim Attachment1_PCA As HyperLink = CType(dataItem.FindControl("Attachment1_PCA"), HyperLink)
                Dim Attachment2_PCA As HyperLink = CType(dataItem.FindControl("Attachment2_PCA"), HyperLink)
                Dim Attachment3_PCA As HyperLink = CType(dataItem.FindControl("Attachment3_PCA"), HyperLink)
                Dim Attachment4_PCA As HyperLink = CType(dataItem.FindControl("Attachment4_PCA"), HyperLink)
                Dim Attachment5_PCA As HyperLink = CType(dataItem.FindControl("Attachment5_PCA"), HyperLink)
                Dim Attachment1_ED As HyperLink = CType(dataItem.FindControl("Attachment1_ED"), HyperLink)
                Dim Attachment2_ED As HyperLink = CType(dataItem.FindControl("Attachment2_ED"), HyperLink)
                
                txtComplaint_Receipt_Date.Enabled = False
                txtAgency_Receipt_Date.Enabled = False
                txtPCA_Employee_FName.Enabled = False
                txtPCA_Employee_LName.Enabled = False
                txtPCA_Employee_Phone.Enabled = False
                txtPCA_Employee_Email.Enabled = False
                txtCollector_Name.Enabled = False
                txtBorrower_FName.Enabled = False
                txtBorrower_LName.Enabled = False
                txtDebtID.Enabled = False
                txtPCA_Comments.Enabled = False
                txtED_Comments.Enabled = False
                ddlComplaint_Source.Enabled = False
                chkArchived.Enabled = False
                ddlStatusID.Enabled = False
                ddlUserID.Enabled = False
                Attachment1_ED.Enabled = False
                Attachment2_ED.Enabled = False
                          
                'Set the selected value in the agency dropdownlist to the value of the agency
                ddlAgencyID.SelectedValue = lblAgency.Text
                
                'Set the selected value in the ED users dropdownlist to the value of the person logged in
                If lblED_AG_Security.Text = "ED" Then
                    ddlAllEDUsers.SelectedValue = lblEDUserID.Text
                End If
                
            Next
        End If
    End Sub
    
    Sub Update_Complaint(ByVal Src As Object, ByVal e As RepeaterCommandEventArgs)
        'Sub UpdateComplaint_Click(ByVal src As Object, ByVal e As EventArgs)
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        Dim ddlAgencyID As DropDownList = e.Item.FindControl("ddlAgencyID")
        Dim txtComplaint_Receipt_Date As TextBox = e.Item.FindControl("txtComplaint_Receipt_Date")
        Dim txtAgency_Receipt_Date As TextBox = e.Item.FindControl("txtAgency_Receipt_Date")
        Dim txtPCA_Employee_FName As TextBox = e.Item.FindControl("txtPCA_Employee_FName")
        Dim txtPCA_Employee_LName As TextBox = e.Item.FindControl("txtPCA_Employee_LName")
        Dim txtPCA_Employee_Phone As TextBox = e.Item.FindControl("txtPCA_Employee_Phone")
        Dim txtPCA_Employee_Email As TextBox = e.Item.FindControl("txtPCA_Employee_Email")
        Dim txtCollector_Name As TextBox = e.Item.FindControl("txtCollector_Name")
        Dim txtBorrower_FName As TextBox = e.Item.FindControl("txtBorrower_FName")
        Dim txtBorrower_LName As TextBox = e.Item.FindControl("txtBorrower_LName")
        Dim txtDebtID As TextBox = e.Item.FindControl("txtDebtID")
        Dim txtPCA_Comments As TextBox = e.Item.FindControl("txtPCA_Comments")
        Dim txtED_Comments As TextBox = e.Item.FindControl("txtED_Comments")
        Dim ddlComplaint_Source As DropDownList = e.Item.FindControl("ddlComplaint_Source")
        Dim chkArchived As CheckBox = e.Item.FindControl("chkArchived")
        Dim ddlStatusID As DropDownList = e.Item.FindControl("ddlStatusID")
        Dim ddlUserID As DropDownList = e.Item.FindControl("ddlAllEDUsers")
        'PCA Attachments
        Dim Attachment1_PCA As HtmlControls.HtmlInputFile = e.Item.FindControl("Attachment1_PCA")
        Dim Attachment2_PCA As HtmlControls.HtmlInputFile = e.Item.FindControl("Attachment2_PCA")
        Dim Attachment3_PCA As HtmlControls.HtmlInputFile = e.Item.FindControl("Attachment3_PCA")
        Dim Attachment4_PCA As HtmlControls.HtmlInputFile = e.Item.FindControl("Attachment4_PCA")
        Dim Attachment5_PCA As HtmlControls.HtmlInputFile = e.Item.FindControl("Attachment5_PCA")
        Dim lnkAttachment1_PCA As HyperLink = DirectCast(e.Item.FindControl("lnkAttachment1_PCA"), HyperLink)
        Dim lnkAttachment2_PCA As HyperLink = DirectCast(e.Item.FindControl("lnkAttachment2_PCA"), HyperLink)
        Dim lnkAttachment3_PCA As HyperLink = DirectCast(e.Item.FindControl("lnkAttachment3_PCA"), HyperLink)
        Dim lnkAttachment4_PCA As HyperLink = DirectCast(e.Item.FindControl("lnkAttachment4_PCA"), HyperLink)
        Dim lnkAttachment5_PCA As HyperLink = DirectCast(e.Item.FindControl("lnkAttachment5_PCA"), HyperLink)
        'ED Attachments
        Dim Attachment1_ED As HtmlControls.HtmlInputFile = e.Item.FindControl("Attachment1_ED")
        Dim Attachment2_ED As HtmlControls.HtmlInputFile = e.Item.FindControl("Attachment2_ED")
        Dim lnkAttachment1_ED As HyperLink = DirectCast(e.Item.FindControl("lnkAttachment1_ED"), HyperLink)
        Dim lnkAttachment2_ED As HyperLink = DirectCast(e.Item.FindControl("lnkAttachment2_ED"), HyperLink)
        
                
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UpdateComplaint"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ComplaintID", SqlDbType.Int).Value =lblComplaintID.Text
        cmd.Parameters.AddWithValue("@Complaint_Receipt_Date", SqlDbType.SmallDateTime).Value = txtComplaint_Receipt_Date.Text
        cmd.Parameters.AddWithValue("@Agency_Receipt_Date", SqlDbType.SmallDateTime).Value = txtAgency_Receipt_Date.Text
        cmd.Parameters.AddWithValue("@Agency_Submission_Date", SqlDbType.SmallDateTime).Value = Date.Now()
        cmd.Parameters.AddWithValue("@PCA_Employee_FName", SqlDbType.VarChar).Value = txtPCA_Employee_FName.Text
        cmd.Parameters.AddWithValue("@PCA_Employee_LName", SqlDbType.VarChar).Value = txtPCA_Employee_LName.Text
        cmd.Parameters.AddWithValue("@PCA_Employee_Phone", SqlDbType.VarChar).Value = txtPCA_Employee_Phone.Text
        cmd.Parameters.AddWithValue("@PCA_Employee_Email", SqlDbType.VarChar).Value = txtPCA_Employee_Email.Text
        cmd.Parameters.AddWithValue("@Collector_Name", SqlDbType.VarChar).Value = txtCollector_Name.Text
        cmd.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = txtBorrower_FName.Text
        cmd.Parameters.AddWithValue("@Borrower_LName", SqlDbType.VarChar).Value = txtBorrower_LName.Text
        cmd.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = txtDebtID.Text
        cmd.Parameters.AddWithValue("@Complaint_Source", SqlDbType.VarChar).Value = ddlComplaint_Source.SelectedValue
        cmd.Parameters.AddWithValue("@PCA_Comments", SqlDbType.VarChar).Value = txtPCA_Comments.Text
        cmd.Parameters.AddWithValue("@ED_Comments", SqlDbType.VarChar).Value = txtED_Comments.Text
        cmd.Parameters.AddWithValue("@Archived", SqlDbType.Bit).Value = 0
        cmd.Parameters.AddWithValue("@UserID", SqlDbType.Int).Value = ddlUserID.SelectedValue
               
        'Attachment1_PCA URL
        Dim strFileNamePath As String = Attachment1_PCA.PostedFile.FileName
        If strFileNamePath.Length > 0 Then
        
            Dim strFileNameOnly As String
            Dim strSaveLocation As String
            
            'Append the agency value before the file name
            strFileNameOnly = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment1_PCA.PostedFile.FileName)
           
            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("../invalid.filetype.aspx")
            End If
            
            'Function to remove illegal URL characters
            strFileNameOnly = ReplaceIllegalChars(strFileNameOnly)
            strFileNameOnly = GenerateRandomFileName(8) & "." & strFileNameOnly
            
            strSaveLocation = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly
            Attachment1_PCA.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment1_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly
        Else
            If String.IsNullOrEmpty(lnkAttachment1_PCA.NavigateUrl) Then
                cmd.Parameters.Add("@Attachment1_PCA", SqlDbType.VarChar).Value = DBNull.Value
            End If
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
            cmd.Parameters.Add("@Attachment2_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly2
        Else
            If String.IsNullOrEmpty(lnkAttachment2_PCA.NavigateUrl) Then
                cmd.Parameters.Add("@Attachment2_PCA", SqlDbType.VarChar).Value = DBNull.Value
            End If
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
            cmd.Parameters.Add("@Attachment3_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly3
        Else
            If String.IsNullOrEmpty(lnkAttachment3_PCA.NavigateUrl) Then
                cmd.Parameters.Add("@Attachment3_PCA", SqlDbType.VarChar).Value = DBNull.Value
            End If
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
            cmd.Parameters.Add("@Attachment4_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly4
        Else
            If String.IsNullOrEmpty(lnkAttachment4_PCA.NavigateUrl) Then
                cmd.Parameters.Add("@Attachment4_PCA", SqlDbType.VarChar).Value = DBNull.Value
            End If
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
            cmd.Parameters.Add("@Attachment5_PCA", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly5
        Else
            If String.IsNullOrEmpty(lnkAttachment5_PCA.NavigateUrl) Then
                cmd.Parameters.Add("@Attachment5_PCA", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If
        
        'Now the 2 ED attachments. We want to pass these 2 parameters only if its an ED user
        If lblED_AG_Security.Text = "ED" Then
            'Attachment1_ED URL
            Dim strFileNamePath6 As String = Attachment1_ED.PostedFile.FileName
               
            If strFileNamePath6.Length > 0 Then
        
                Dim strFileNameOnly6 As String
                Dim strSaveLocation6 As String
            
                'Append the agency value before the file name       
                strFileNameOnly6 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment1_ED.PostedFile.FileName)
           
                'This checks for a valid file name and type
                Dim Filename6Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
                If Not Filename6Regex.IsMatch(strFileNameOnly6.ToLower(), RegexOptions.IgnoreCase) Then
                    Response.Redirect("../invalid.filetype.aspx")
                End If
            
                'Function to remove illegal URL characters
                strFileNameOnly6 = ReplaceIllegalChars(strFileNameOnly6)
                strFileNameOnly6 = GenerateRandomFileName(8) & "." & strFileNameOnly6

                strSaveLocation6 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly6
                Attachment1_ED.PostedFile.SaveAs(strSaveLocation6)
                cmd.Parameters.Add("@Attachment1_ED", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly6
            Else
                If String.IsNullOrEmpty(lnkAttachment1_ED.NavigateUrl) Then
                    cmd.Parameters.Add("@Attachment1_ED", SqlDbType.VarChar).Value = DBNull.Value
                End If
            End If
        
            'Attachment2_ED URL
            Dim strFileNamePath7 As String = Attachment2_ED.PostedFile.FileName
            If strFileNamePath7.Length > 0 Then
        
                Dim strFileNameOnly7 As String
                Dim strSaveLocation7 As String
            
                'Append the agency value before the file name       
                strFileNameOnly7 = lblED_AG_Security.Text & "." & System.IO.Path.GetFileName(Attachment2_ED.PostedFile.FileName)
           
                'This checks for a valid file name and type
                Dim Filename7Regex As New Regex("(.*?)\.(doc|docx|pdf|xls|xslt|bmp|tif|tiff|jpg|txt|gif|png)$")
                If Not Filename7Regex.IsMatch(strFileNameOnly7.ToLower(), RegexOptions.IgnoreCase) Then
                    Response.Redirect("../invalid.filetype.aspx")
                End If
            
                'Function to remove illegal URL characters
                strFileNameOnly7 = ReplaceIllegalChars(strFileNameOnly7)
                strFileNameOnly7 = GenerateRandomFileName(8) & "." & strFileNameOnly7

                strSaveLocation7 = "d:\DCS\secure\IMF_ED\x49g\complaints\" & strFileNameOnly7
                Attachment2_ED.PostedFile.SaveAs(strSaveLocation7)
                cmd.Parameters.Add("@Attachment2_ED", SqlDbType.VarChar).Value = "https://www.fsacollections.ed.gov/secure/IMF_ED/x49g/complaints/" & strFileNameOnly7
            Else
                If String.IsNullOrEmpty(lnkAttachment2_ED.NavigateUrl) Then
                    cmd.Parameters.Add("@Attachment2_ED", SqlDbType.VarChar).Value = DBNull.Value
                End If
            End If
        
            Try
                strConnection.Open()
                cmd.Connection = strConnection
                cmd.ExecuteNonQuery()
            Finally
                strConnection.Close()
            End Try
        
            rptComplaintDetails.DataBind()
        
            lblUpdateStatus.Text = "Your Complaint has been updated"
        End If
        
        'Update the DCS complaint types
        UpdateDCSComplaintTypes()
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
    
    Protected Sub rptComplaintDetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        'If e.Item.ItemType = ListItemType.Item Then
        '    Dim link1 As HyperLink = DirectCast(e.Item.FindControl("HyperLink1"), HyperLink)
        '    Dim link2 As HyperLink = DirectCast(e.Item.FindControl("HyperLink2"), HyperLink)
        '    Dim link3 As HyperLink = DirectCast(e.Item.FindControl("HyperLink3"), HyperLink)
        '    'Link GA
        '    If String.IsNullOrEmpty(link1.NavigateUrl) Then
        '        Dim li As HtmlGenericControl = CType(e.Item.FindControl("l1"), HtmlGenericControl)
        '        li.Visible = False
        '    End If
        '    'Link ED
        '    If String.IsNullOrEmpty(link2.NavigateUrl) Then
        '        Dim li2 As HtmlGenericControl = CType(e.Item.FindControl("l2"), HtmlGenericControl)
        '        li2.Visible = False
        '    End If
        '    'Link ED2
        '    If String.IsNullOrEmpty(link3.NavigateUrl) Then
        '        Dim li3 As HtmlGenericControl = CType(e.Item.FindControl("l3"), HtmlGenericControl)
        '        li3.Visible = False
        '    End If
        'End If
        'CheckFields()
        BindComplaintTypes_DCS()
        
    End Sub
    
  
    Public Sub BindComplaintTypes_DCS()
               
        Dim dataItem As RepeaterItem
        For Each dataItem In rptComplaintDetails.Items
            Dim cblDCSComplaint_Type As CheckBoxList = CType(dataItem.FindControl("cblDCSComplaint_Type"), CheckBoxList)
            'Dim cblDCSComplaint_Type As CheckBoxList = CType(FindControl("cblDCSComplaint_Type"), CheckBoxList)
                   
            'This creates the list of checkboxes for the alert events types 
            Dim strConnection As SqlConnection
            Dim strSQL As String
            Dim cmd As SqlCommand
            Dim dr As SqlDataReader
         
            strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
            strSQL = "p_ComplaintTypes_DCS"
            cmd = New SqlCommand(strSQL)
            cmd.CommandType = CommandType.StoredProcedure
            strConnection.Open()
            cmd.Connection = strConnection
        
            cblDCSComplaint_Type.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            cblDCSComplaint_Type.DataTextField = "Complaint_Type"
            cblDCSComplaint_Type.DataValueField = "ComplaintTypeID"
            cblDCSComplaint_Type.DataBind()
        
            'Dim cmd2 As SqlCommand
            ''cmd2 = New SqlCommand("SELECT * FROM Complaint_Type_Saved WHERE ComplaintTypeID=1", strConnection)
            'cmd2 = New SqlCommand("SELECT * FROM Complaint_Type_Saved WHERE Violation_Type='DCS'", strConnection)
            'strConnection.Open()
            'dr = cmd.ExecuteReader()
            'While dr.Read()
            '    Dim currentCheckBox As ListItem = cblDCSComplaint_Type.Items.FindByValue(dr("ComplaintTypeID").ToString())
            '    If Not (currentCheckBox Is Nothing) Then
            '        currentCheckBox.Selected = True
            '    End If
            'End While
            strConnection.Close()
        Next
    End Sub
    
    Sub UpdateDCSComplaintTypes()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String
        Dim intComplaintID As Integer = CInt(lblComplaintID.Text)
      
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        SqlText = "p_Complaints_Update"
        Try
            strSQLConn.Open()
            Dim dataItem As RepeaterItem
            For Each dataItem In rptComplaintDetails.Items
                Dim cblDCSComplaint_Type As CheckBoxList = CType(dataItem.FindControl("cblDCSComplaint_Type"), CheckBoxList)
                For Each Item As ListItem In cblDCSComplaint_Type.Items
                    
                    If (Item.Selected) Then
                        Response.Write("yes")
                    
                        '        cmd = New SqlCommand(SqlText)
                        '        cmd.CommandType = CommandType.StoredProcedure
                        '        cmd.Connection = strSQLConn
                        '        'input parameters for the sproc
                        '        cmd.Parameters.Add("@ComplaintID", SqlDbType.Int).Value = intComplaintID
                        '        cmd.Parameters.Add("@ComplaintTypeID", SqlDbType.Int).Value = Item.Value
                        '        cmd.Parameters.Add("@Violation_Type", SqlDbType.VarChar).Value = "DCS"
                        '        cmd.ExecuteNonQuery()
                    End If
                Next
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
        Dim intComplaintID As Integer = CInt(lblComplaintID.Text)
      
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        SqlText = "p_Complaints_Update"
        Try
            strSQLConn.Open()
            Dim dataItem As RepeaterItem
            For Each dataItem In rptComplaintDetails.Items
                Dim cblFDCPAComplaint_Type As CheckBoxList = CType(dataItem.FindControl("cblFDCPAComplaint_Type"), CheckBoxList)
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
            Next
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    


    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Update Borrower Complaint</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">  
                    <!--This one populates the Complaint details form-->
                     <asp:SqlDataSource ID="dsComplaintDetail" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_ComplaintDetail" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                    <asp:ControlParameter ControlID="lblComplaintID" Name="ComplaintID" />
                            </SelectParameters>
                        </asp:SqlDataSource>

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
                       <fieldset>
                        <legend class="fieldsetLegend">Update a Complaint</legend>
                        <asp:Repeater id="rptComplaintDetails" Runat="Server"  DataSourceID="dsComplaintDetail" OnItemCommand="Update_Complaint" OnItemDataBound="rptComplaintDetails_ItemDataBound">
                        <HeaderTemplate>
                        <table border="0" cellpadding="3" cellspacing="1" style="border-collapse:collapse;" >
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
		                    <td class ="formSeparator" colspan="4">Submitted By</td>		
	                    </tr>
	                    <tr>
		                    <td class="formLabelForm">Agency:</td>
                            <td align="left"><asp:DropDownList ID="ddlAgencyID" runat="server" CssClass="formLabel"
                                  DataSourceID="dsAgencies"
                                  DataTextField="AG_Name"
                                  DataValueField="AG" AppendDataBoundItems="true"
                                  Enabled="false" SelectedValue='<%# Eval("AG") %>'>
                                  <asp:ListItem Text="" Value="" />                              
                             </asp:DropDownList>                
                             </td>
		                    <td class="formLabelForm">Assigned To:</td>
		                    <td align="left"><asp:DropDownList id="ddlAllEDUsers" Runat="Server" CssClass="formLabel"
                                  DataSourceID="dsAllEDUsers"
                                  DataTextField="UserName"
                                  DataValueField="UserID"
                                  AppendDataBoundItems="true" 
                                  Enabled="false" SelectedValue='<%# Eval("UserID") %>'>
                                  <asp:ListItem Text="" Value="" />                             
                          </asp:DropDownList></td>
	                    </tr>
	<tr>
		<td class ="formSeparator" colspan="4">Complaint Dates</td>		
	</tr>
	<tr>
		<td class="formLabelForm">Complaint Receipt Date:</td>
		<td align="left"><asp:Textbox id="txtComplaint_Receipt_Date" runat="server" Text='<%# Eval("Complaint_Receipt_Date") %>' /></td>
		<td class="formLabelForm">Agency Receipt Date:</td>
		<td align="left"><asp:Textbox id="txtAgency_Receipt_Date" runat="server" Text='<%# Eval("Agency_Receipt_Date") %>'  /></td>
	</tr>
	<tr>
		<td class ="formSeparator" colspan="4">PCA Information</td>		
	</tr>
	<tr>
		<td class="formLabelForm">PCA Employee:</td>
		<td align="left"><asp:Textbox id="txtPCA_Employee_FName" runat="server" Text='<%# Eval("PCA_Employee_FName") %>'  /> <asp:Textbox id="txtPCA_Employee_LName" runat="server" Text='<%# Eval("PCA_Employee_LName") %>'  /></td>
		<td class="formLabelForm">PCA Employee Phone:</td>
		<td align="left"><asp:Textbox id="txtPCA_Employee_Phone" runat="server" Text='<%# Eval("PCA_Employee_Phone") %>'  /></td>
	</tr>	
    <tr>
		<td class="formLabelForm">PCA Employee Email:</td>
		<td align="left"><asp:Textbox id="txtPCA_Employee_Email" runat="server" Text='<%# Eval("PCA_Employee_Email") %>' /></td>
		<td class="formLabelForm"></td>
		<td align="left"></td>
	</tr>
	<tr>
		<td class ="formSeparator" colspan="4">Complaint Details</td>		
	</tr>
    <tr>
		<td class="formLabelForm">Borrower Name:</td>
		<td align="left"><asp:Textbox id="txtBorrower_FName" runat="server" Text='<%# Eval("Borrower_FName") %>' /> <asp:Textbox id="txtBorrower_LName" runat="server" Text='<%# Eval("Borrower_LName") %>'  /><br />
        <asp:RequiredFieldValidator ID="rfdBorrower_FName" runat="server" ErrorMessage="* Borrower First Name is a required field *" CssClass="warningMessage" ControlToValidate="txtBorrower_FName" /><br />
        <asp:RequiredFieldValidator ID="rfdBorrower_LName" runat="server" ErrorMessage="* Borrower Last Name is a required field *" CssClass="warningMessage" ControlToValidate="txtBorrower_LName" />                
        </td>
		<td class="formLabelForm">Complaint Source:</td>
		<td align="left">
            <asp:Dropdownlist id="ddlComplaint_Source" runat="server" SelectedValue='<%# Eval("Complaint_Source") %>'>
                    <asp:ListItem Text="Written" Value="Written" />
                    <asp:ListItem Text="Verbal" Value="Verbal" />
            </asp:Dropdownlist>
            </td>
	</tr>	
	<tr>
		<td class="formLabelForm">Debt ID:</td>
		<td align="left"><asp:Textbox id="txtDebtID" runat="server" Text='<%# Eval("DebtID") %>' /><br />
        <asp:RequiredFieldValidator ID="rfdDebtID" runat="server" ErrorMessage="* Debt ID is a required field *" CssClass="warningMessage" ControlToValidate="txtDebtID" />        
        </td>
		<td class="formLabelForm">Collector Name:</td>
		<td align="left"><asp:Textbox id="txtCollector_Name" runat="server" Text='<%# Eval("Collector_Name") %>' /></td>
	</tr>	
	<tr>
		<td class="formLabelForm">DCS Complaint Type:</td>
		<td align="left" valign="top">
                <asp:Checkboxlist id="cblDCSComplaint_Type" runat="server"                 
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
		<td align="left"><asp:Textbox ID="txtPCA_Comments" runat="server" TextMode="MultiLine" Columns="55" Rows="10" Text='<%# Eval("PCA_Comments") %>'  /></td>
		<td class="formLabelForm">ED Comments:</td>
		<td align="left"><asp:Textbox ID="txtED_Comments" runat="server" TextMode="MultiLine" Columns="55" Rows="10" Text='<%# Eval("ED_Comments") %>'  /></td>		
	</tr>	
    <tr>
		<td class ="formSeparator" colspan="4">PCA Attachments</td>		
	</tr>
     <tr>
        <td class="formLabelForm">Existing Attachments:</td>
		<td align="left" valign="top">
            <ul>                                                                      
                   <li id="l1" runat="server"><asp:HyperLink ID="lnkAttachment1_PCA" NavigateUrl='<%# Eval("Attachment1_PCA")%>' runat="server" Target="_blank">Complaint Cover Letter</asp:HyperLink></li>     
                   <li id="l2" runat="server"><asp:HyperLink ID="lnkAttachment2_PCA" NavigateUrl='<%# Eval("Attachment2_PCA")%>' runat="server" Target="_blank">Complaint Response</asp:HyperLink></li> 
                   <li id="l3" runat="server"><asp:HyperLink ID="lnkAttachment3_PCA" NavigateUrl='<%# Eval("Attachment3_PCA")%>' runat="server" Target="_blank">Notepads</asp:HyperLink></li>  
                   <li id="l4" runat="server"><asp:HyperLink ID="lnkAttachment4_PCA" NavigateUrl='<%# Eval("Attachment4_PCA")%>' runat="server" Target="_blank">Voice Recording</asp:HyperLink></li>
                   <li id="l5" runat="server"><asp:HyperLink ID="lnkAttachment5_PCA" NavigateUrl='<%# Eval("Attachment5_PCA")%>' runat="server" Target="_blank">Other</asp:HyperLink></li>      
            </ul> 
        </td>
        <td class="formLabelForm">Add New Attachments:</td>
		<td align="left" valign="top">
        <table>
                <tr>
                    <td align="right">Complaint Cover Letter:</td>
                    <td align="left"><input id="Attachment1_PCA" type="File" runat="server" size="35" /></td>
                </tr>
                 <tr>
                    <td  align="right">Complaint Response:</td>
                    <td align="left"><input id="Attachment2_PCA" type="File" runat="server" size="35" /></td>
                </tr>
                 <tr>
                    <td  align="right">Notepads:</td>
                    <td align="left"><input id="Attachment3_PCA" type="File" runat="server" size="35" /></td>
                </tr>
                 <tr>
                    <td  align="right">Voice Recording:</td>
                    <td align="left"><input id="Attachment4_PCA" type="File" runat="server" size="35" /></td>
                </tr>
                 <tr>
                    <td  align="right">Other</td>
                    <td align="left"><input id="Attachment5_PCA" type="File" runat="server" size="35" /></td>
                </tr>
        </table>					
		</td>
        </tr>
        <tr>
		    <td class ="formSeparator" colspan="4">ED Attachments</td>		
	    </tr>
        <tr>
        <td class="formLabelForm">Existing Attachments:</td>
		<td align="left" valign="top">
            <ul>                                                                      
                   <li id="l6" runat="server"><asp:HyperLink ID="lnkAttachment1_ED" NavigateUrl='<%# Eval("Attachment1_ED")%>' runat="server" Target="_blank">Complaint</asp:HyperLink></li>     
                   <li id="l7" runat="server"><asp:HyperLink ID="lnkAttachment2_ED" NavigateUrl='<%# Eval("Attachment2_ED")%>' runat="server" Target="_blank">Other</asp:HyperLink></li>                         
            </ul> 
        </td>
        <td class="formLabelForm">Add New Attachments:</td>
		<td align="left" valign="top">
        <table>
            <tr>
                <td align="right">Complaint:</td>
                <td align="left"><input id="Attachment1_ED" type="File" runat="server" size="35" /></td>
            </tr>
             <tr>
                <td align="right">Other:</td>
                <td align="left"><input id="Attachment2_ED" type="File" runat="server" size="35" /></td>
            </tr>
        </table>			
		</td>
        </tr>   	
        <tr>
        <td align="center" colspan="4"><br />
            <asp:Button ID="btnUpdateComplaint" runat="server" Text="Update Complaint" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
        </td>
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
                   </div>
                  
<asp:Label ID="lblComplaintID" runat="server" Visible="true" />
<asp:Label ID="lblAgency" runat="server" Visible="true" />
<asp:Label ID="lblDateAssigned" runat="server" Visible="false" />
<asp:Label ID="lblIsAdmin" runat="server" Visible="False" />
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />
<asp:Label ID="lblED_AG_Security" runat="server" Visible="false" />
 </form>
</body>
</html>
