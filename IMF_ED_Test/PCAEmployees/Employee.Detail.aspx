<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" MaintainScrollPositionOnPostback="true" %>
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
                
            'This page is shared by both ED and the PCAs so we have to know who is looking at it.            
            If Not IsNothing(Request.Cookies("IMF")("AG")) Then
                'PCA is looking at the IMF
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString()) 'This contains their agency number code
                'lblAgency.Text = "537"
                lblED_AG_Security.Text = "AG"
            End If
            
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                'ED employee is looking at the IMF
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
                lblED_AG_Security.Text = "ED"
            End If
            
            'Bind the ED user info for this user
            BindEDUserInfo()
            
        End If
    End Sub
    
    Sub BindEDUserInfo()
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
        For Each dataItem In rptEmployeeDetails.Items
            Dim lblSSN As Label = CType(dataItem.FindControl("lblSSN"), Label)
            Dim ddlAllEDUsers As DropDownList = CType(dataItem.FindControl("ddlAllEDUsers"), DropDownList)
            Dim txtFirst_Name As TextBox = CType(dataItem.FindControl("txtFirst_Name"), TextBox)
            Dim txtLast_Name As TextBox = CType(dataItem.FindControl("txtLast_Name"), TextBox)
            Dim txtEmail As TextBox = CType(dataItem.FindControl("txtEmail"), TextBox)
            Dim ddlTitle As DropDownList = CType(dataItem.FindControl("ddlTitle"), DropDownList)
            Dim ddlEmployeeFunction As DropDownList = CType(dataItem.FindControl("ddlEmployeeFunction"), DropDownList)
            Dim txtAG_Employee_Name As TextBox = CType(dataItem.FindControl("txtAG_Employee_Name"), TextBox)
            Dim ddlAgencyID As DropDownList = CType(dataItem.FindControl("ddlAgencyID"), DropDownList)
            Dim lblDate_Employee_Added As Label = CType(dataItem.FindControl("lblDate_Employee_Added"), Label)
            Dim chkSixC As CheckBox = CType(dataItem.FindControl("chkSixC"), CheckBox)
            Dim chkReceiveEmail As CheckBox = CType(dataItem.FindControl("chkReceiveEmail"), CheckBox)
            Dim chkLVCCoordinator As CheckBox = CType(dataItem.FindControl("chkLVCCoordinator"), CheckBox)
            Dim ddlNSLDS_Checked As DropDownList = CType(dataItem.FindControl("ddlNSLDS_Checked"), DropDownList)
            Dim ddlDMCS_Checked As DropDownList = CType(dataItem.FindControl("ddlDMCS_Checked"), DropDownList)
            Dim ddlStatus As DropDownList = CType(dataItem.FindControl("ddlStatus"), DropDownList)
            'Training/Attachments
            Dim txtPAT_Date_Original As TextBox = CType(dataItem.FindControl("txtPAT_Date_Original"), TextBox)
            Dim txtPAT_Date_Last As TextBox = CType(dataItem.FindControl("txtPAT_Date_Last"), TextBox)
            Dim txtSAT_Date As TextBox = CType(dataItem.FindControl("txtSAT_Date"), TextBox)
            Dim txtROB_Date As TextBox = CType(dataItem.FindControl("txtROB_Date"), TextBox)
            Dim txtIRT_Date As TextBox = CType(dataItem.FindControl("txtIRT_Date"), TextBox)
            Dim ddlIRT_Attachment_Accepted_By_ED As DropDownList = CType(dataItem.FindControl("ddlIRT_Attachment_Accepted_By_ED"), DropDownList)
            Dim ddlSAT_Attachment_Accepted_By_ED As DropDownList = CType(dataItem.FindControl("ddlSAT_Attachment_Accepted_By_ED"), DropDownList)
            Dim ddlROB_Attachment_Accepted_By_ED As DropDownList = CType(dataItem.FindControl("ddlROB_Attachment_Accepted_By_ED"), DropDownList)
            Dim ddlPAT_Attachment_Accepted_By_ED As DropDownList = CType(dataItem.FindControl("ddlPAT_Attachment_Accepted_By_ED"), DropDownList)
            Dim ddlLVC_Attachment_Accepted_By_ED As DropDownList = CType(dataItem.FindControl("ddlLVC_Attachment_Accepted_By_ED"), DropDownList)
            Dim ddlDMCS_ROB_Attachment_Accepted_By_ED As DropDownList = CType(dataItem.FindControl("ddlDMCS_ROB_Attachment_Accepted_By_ED"), DropDownList)
            Dim ddlDMCS_Access_Attachment_Accepted_By_ED As DropDownList = CType(dataItem.FindControl("ddlDMCS_Access_Attachment_Accepted_By_ED"), DropDownList)
            
            Dim txtUserID_Request_Date As TextBox = CType(dataItem.FindControl("txtUserID_Request_Date"), TextBox)
            Dim txtEAUserID As TextBox = CType(dataItem.FindControl("txtEAUserID"), TextBox)
            
            Dim txtContract_Start_Date As TextBox = CType(dataItem.FindControl("txtContract_Start_Date"), TextBox)
            Dim chkRemoved_From_Contract As CheckBox = CType(dataItem.FindControl("chkRemoved_From_Contract"), CheckBox)
            Dim txtRemoved_From_Contract_Date As TextBox = CType(dataItem.FindControl("txtRemoved_From_Contract_Date"), TextBox)
            Dim listLinks As HtmlGenericControl = CType(dataItem.FindControl("listLinks"), HtmlGenericControl)
            Dim link1 As HyperLink = CType(dataItem.FindControl("HyperLink1"), HyperLink) 'PAT Attachment
            Dim link2 As HyperLink = CType(dataItem.FindControl("HyperLink2"), HyperLink) 'SAT Attachment
            Dim link3 As HyperLink = CType(dataItem.FindControl("HyperLink3"), HyperLink) 'IRT Attachment
            Dim link4 As HyperLink = CType(dataItem.FindControl("HyperLink4"), HyperLink) 'ROB Attachment
            Dim link5 As HyperLink = CType(dataItem.FindControl("HyperLink5"), HyperLink) 'FFEL Attachment
            Dim link6 As HyperLink = CType(dataItem.FindControl("HyperLink6"), HyperLink) 'LVC_Attachment
            Dim link7 As HyperLink = CType(dataItem.FindControl("HyperLink7"), HyperLink) 'DMCS_ROB_Attachment
            Dim link8 As HyperLink = CType(dataItem.FindControl("HyperLink8"), HyperLink) 'DMCS_Access_Attachment
            Dim txtComments_PCA As TextBox = CType(dataItem.FindControl("txtComments_PCA"), TextBox)
            Dim txtComments_ED As TextBox = CType(dataItem.FindControl("txtComments_ED"), TextBox)
            Dim ddlAcceptAllTrainingForms As DropDownList = CType(dataItem.FindControl("ddlAcceptAllTrainingForms"), DropDownList)
            
            '*** AG Security fields ***
            If lblED_AG_Security.Text = "AG" Then
                'We need an additional check here for PCA to make sure that they are looking at only their own employees
                'We will make sure that their AG code matches the AgencyID in the ddlAgencyID dropdown            
                'Dim ddlAgencyID As DropDownList = CType(dataItem.FindControl("ddlAgencyID"), DropDownList)
                
                If lblAgency.Text <> ddlAgencyID.SelectedValue Then
                    Response.Redirect("../not.authorized.aspx")
                Else
                    'These fields cannot be edited by any PCA for any reason
                    ddlNSLDS_Checked.Enabled = False
                    ddlAllEDUsers.Enabled = False
                    ddlDMCS_Checked.Enabled = False
                    txtEAUserID.Enabled = False
                    'Training/Attachments fields
                    ddlPAT_Attachment_Accepted_By_ED.Enabled = False
                    ddlIRT_Attachment_Accepted_By_ED.Enabled = False
                    ddlSAT_Attachment_Accepted_By_ED.Enabled = False
                    ddlROB_Attachment_Accepted_By_ED.Enabled = False
                    ddlLVC_Attachment_Accepted_By_ED.Enabled = False
                    ddlDMCS_ROB_Attachment_Accepted_By_ED.Enabled = False
                    ddlDMCS_Access_Attachment_Accepted_By_ED.Enabled = False
                    
                    txtPAT_Date_Original.Enabled = False
                    'Doug asked that PCAs be able to edit these fields on their own 
                    'effective 2011/04/05
                    'txtIRT_Date.Enabled = False
                    'txtPAT_Date_Last.Enabled = False
                    'txtSAT_Date.Enabled = False
                    'txtROB_Date.Enabled = False
                    txtComments_ED.Enabled = False
                    ddlAcceptAllTrainingForms.Enabled = False
                    'AGs cannot see the SSNs
                    lblSSN.Visible = False
                    btnUpdateFFEL.Visible = False
                End If
                
                'AG cannot update any of their fields if the ddlStatus does not equal 'approved' (3) or employed(6)
                '3 = approved
                If ddlStatus.SelectedValue <> 3 And ddlStatus.SelectedValue <> 6 Then
                    txtFirst_Name.Enabled = False
                    txtLast_Name.Enabled = False
                    ddlTitle.Enabled = False
                    ddlEmployeeFunction.Enabled = False
                    txtAG_Employee_Name.Enabled = False
                    chkSixC.Enabled = False
                    txtPAT_Date_Original.Enabled = False
                    txtPAT_Date_Last.Enabled = False
                    txtSAT_Date.Enabled = False
                    txtIRT_Date.Enabled = False
                    txtContract_Start_Date.Enabled = False
                    chkRemoved_From_Contract.Enabled = False
                    txtRemoved_From_Contract_Date.Enabled = False
                    txtComments_PCA.Enabled = False
                    'List of upload attachments links
                    listLinks.Visible = False
                End If
                
                'The PAT, SAT, IRT and ROB forms must all be accepted by ED before a FFEL Login Form Request can be uploaded
                'If ddlAcceptAllTrainingForms.SelectedValue = "True" Then
                link5.Enabled = True
                'Else
                'link5.Enabled = False
                'End If
               
            End If
            
            '*** ED Security fields ***
            If lblED_AG_Security.Text = "ED" Then
                ddlNSLDS_Checked.Enabled = True
                ddlAllEDUsers.Enabled = True
                ddlDMCS_Checked.Enabled = True
                ddlStatus.Enabled = True
                txtEAUserID.Enabled = True
                listLinks.Visible = True
                
                'The field PAT_Attachment_Accepted_By_ED should only be enabled if the PCA uploaded a PAT form. If
                'HyperLink1 has a value, then we know the PAT form has been uploaded
                If link1.Text = "* Upload * Privacy Act Training  (PAT) Form" Then
                    ddlPAT_Attachment_Accepted_By_ED.Enabled = False
                Else
                    ddlPAT_Attachment_Accepted_By_ED.Enabled = True
                End If
                
                'The field SAT_Attachment_Accepted_By_ED should only be enabled if the PCA uploaded a SAT form. If
                'HyperLink2 has a value, then we know the SAT form has been uploaded
                If link2.Text = "* Upload * Security Awareness Training  (SAT) Form" Then
                    ddlSAT_Attachment_Accepted_By_ED.Enabled = False
                Else
                    ddlSAT_Attachment_Accepted_By_ED.Enabled = True
                End If
                
                'The field IRT_Attachment_Accepted_By_ED should only be enabled if the PCA uploaded a IRT form. If
                'HyperLink3 has a value, then we know the IRT form has been uploaded
                If link3.Text = "* Upload * Incidence Response Training  (IRT) Form" Then
                    ddlIRT_Attachment_Accepted_By_ED.Enabled = False
                Else
                    ddlIRT_Attachment_Accepted_By_ED.Enabled = True
                End If
                
                'The field ROB_Attachment_Accepted_By_ED should only be enabled if the PCA uploaded a ROB form. If
                'HyperLink4 has a value, then we know the ROB form has been uploaded
                If link4.Text = "* Upload * Rules of Behavior (ROB) Form" Then
                    ddlROB_Attachment_Accepted_By_ED.Enabled = False
                Else
                    ddlROB_Attachment_Accepted_By_ED.Enabled = True
                End If
                
                'The PAT, SAT, IRT and ROB forms must all be accepted by ED before a FFEL Login Form Request can be uploaded
                If ddlAcceptAllTrainingForms.SelectedValue = "True" Then
                    link5.Enabled = True
                Else
                    link5.Enabled = False
                End If
                
                'The field LVC_Attachment_Accepted_By_ED should only be enabled if the PCA uploaded a LVC form. If
                'HyperLink6 has a value, then we know the LVC form has been uploaded
                If link6.Text = "* Upload * LVC Form" Then
                    ddlLVC_Attachment_Accepted_By_ED.Enabled = False
                Else
                    ddlLVC_Attachment_Accepted_By_ED.Enabled = True
                End If
                
                'The field DMCS_ROB_Attachment_Accepted_By_ED should only be enabled if the PCA uploaded a DMCS ROB. If
                'HyperLink7 has a value, then we know the DMCS ROB form has been uploaded
                If link7.Text = "* Upload * DMCS Rules of Behavior (ROB) Form" Then
                    ddlDMCS_ROB_Attachment_Accepted_By_ED.Enabled = False
                Else
                    ddlDMCS_ROB_Attachment_Accepted_By_ED.Enabled = True
                End If
                
                'The field DMCS_Access_Attachment_Accepted_By_ED should only be enabled if the PCA uploaded a DMCS Access. If
                'HyperLink8 has a value, then we know the DMCS Access form has been uploaded
                If link8.Text = "* Upload * DMCS Access Form" Then
                    ddlDMCS_Access_Attachment_Accepted_By_ED.Enabled = False
                Else
                    ddlDMCS_Access_Attachment_Accepted_By_ED.Enabled = True
                End If
            
            End If
            
        Next
    End Sub
    
    Sub Edit_Record(ByVal Src As Object, ByVal e As RepeaterCommandEventArgs)
          
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
               
        Dim lblSSN As Label = CType(e.Item.FindControl("lblSSN"), Label)
        Dim ddlAllEDUsers As DropDownList = e.Item.FindControl("ddlAllEDUsers")
        Dim txtFirst_Name As TextBox = CType(e.Item.FindControl("txtFirst_Name"), TextBox)
        Dim txtLast_Name As TextBox = CType(e.Item.FindControl("txtLast_Name"), TextBox)
        Dim txtEmail As TextBox = CType(e.Item.FindControl("txtEmail"), TextBox)
        Dim ddlTitle As DropDownList = CType(e.Item.FindControl("ddlTitle"), DropDownList)
        Dim ddlEmployeeFunction As DropDownList = CType(e.Item.FindControl("ddlEmployeeFunction"), DropDownList)
        Dim txtAG_Employee_Name As TextBox = CType(e.Item.FindControl("txtAG_Employee_Name"), TextBox)
        Dim ddlAgencyID As DropDownList = CType(e.Item.FindControl("ddlAgencyID"), DropDownList)
        Dim lblDate_Employee_Added As Label = CType(e.Item.FindControl("lblDate_Employee_Added"), Label)
        Dim ddlNSLDS_Checked As DropDownList = CType(e.Item.FindControl("ddlNSLDS_Checked"), DropDownList)
        Dim ddlDMCS_Checked As DropDownList = CType(e.Item.FindControl("ddlDMCS_Checked"), DropDownList)
        Dim ddlStatus As DropDownList = CType(e.Item.FindControl("ddlStatus"), DropDownList)
        Dim txtPAT_Date_Original As TextBox = CType(e.Item.FindControl("txtPAT_Date_Original"), TextBox)
        Dim txtPAT_Date_Last As TextBox = CType(e.Item.FindControl("txtPAT_Date_Last"), TextBox)
        Dim txtSAT_Date As TextBox = CType(e.Item.FindControl("txtSAT_Date"), TextBox)
        Dim txtIRT_Date As TextBox = CType(e.Item.FindControl("txtIRT_Date"), TextBox)
        Dim txtROB_Date As TextBox = CType(e.Item.FindControl("txtROB_Date"), TextBox)
        Dim txtUserID_Request_Date As TextBox = CType(e.Item.FindControl("txtUserID_Request_Date"), TextBox)
        Dim txtEAUserID As TextBox = CType(e.Item.FindControl("txtEAUserID"), TextBox)
        Dim txtContract_Start_Date As TextBox = CType(e.Item.FindControl("txtContract_Start_Date"), TextBox)
        Dim chkRemoved_From_Contract As CheckBox = CType(e.Item.FindControl("chkRemoved_From_Contract"), CheckBox)
        Dim chkSixC As CheckBox = CType(e.Item.FindControl("chkSixC"), CheckBox)
        Dim chkReceiveEmail As CheckBox = CType(e.Item.FindControl("chkReceiveEmail"), CheckBox)
        Dim chkLVCCoordinator As CheckBox = CType(e.Item.FindControl("chkLVCCoordinator"), CheckBox)
        Dim txtRemoved_From_Contract_Date As TextBox = CType(e.Item.FindControl("txtRemoved_From_Contract_Date"), TextBox)
        Dim ddlPAT_Attachment_Accepted_By_ED As DropDownList = CType(e.Item.FindControl("ddlPAT_Attachment_Accepted_By_ED"), DropDownList)
        Dim ddlSAT_Attachment_Accepted_By_ED As DropDownList = CType(e.Item.FindControl("ddlSAT_Attachment_Accepted_By_ED"), DropDownList)
        Dim ddlIRT_Attachment_Accepted_By_ED As DropDownList = CType(e.Item.FindControl("ddlIRT_Attachment_Accepted_By_ED"), DropDownList)
        Dim ddlROB_Attachment_Accepted_By_ED As DropDownList = CType(e.Item.FindControl("ddlROB_Attachment_Accepted_By_ED"), DropDownList)
        Dim ddlLVC_Attachment_Accepted_By_ED As DropDownList = CType(e.Item.FindControl("ddlLVC_Attachment_Accepted_By_ED"), DropDownList)
        Dim ddlDMCS_ROB_Attachment_Accepted_By_ED As DropDownList = CType(e.Item.FindControl("ddlDMCS_ROB_Attachment_Accepted_By_ED"), DropDownList)
        Dim ddlDMCS_Access_Attachment_Accepted_By_ED As DropDownList = CType(e.Item.FindControl("ddlDMCS_Access_Attachment_Accepted_By_ED"), DropDownList)
      
        Dim txtComments_PCA As TextBox = CType(e.Item.FindControl("txtComments_PCA"), TextBox)
        Dim txtComments_ED As TextBox = CType(e.Item.FindControl("txtComments_ED"), TextBox)
        Dim ddlAcceptAllTrainingForms As DropDownList = CType(e.Item.FindControl("ddlAcceptAllTrainingForms"), DropDownList)
                
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_PCAEmployeeUpdate"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        If ddlAllEDUsers.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@UserID", ddlAllEDUsers.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@UserID", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If
        If txtFirst_Name.Text <> "" Then
            cmd.Parameters.AddWithValue("@First_Name", txtFirst_Name.Text)
        Else
            cmd.Parameters.AddWithValue("@First_Name", txtFirst_Name.Text).Value = DBNull.Value
        End If
        
        If txtLast_Name.Text <> "" Then
            cmd.Parameters.AddWithValue("@Last_Name", txtLast_Name.Text)
        Else
            cmd.Parameters.AddWithValue("@Last_Name", txtLast_Name.Text).Value = DBNull.Value
        End If
        
        If txtEmail.Text <> "" Then
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text)
        Else
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text).Value = DBNull.Value
        End If
        
        If ddlTitle.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@Title", ddlTitle.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@Title", ddlTitle.SelectedValue).Value = DBNull.Value
        End If
        
        If ddlEmployeeFunction.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@EmployeeFunction", ddlEmployeeFunction.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@EmployeeFunction", ddlEmployeeFunction.SelectedValue).Value = DBNull.Value
        End If
        
        If txtAG_Employee_Name.Text <> "" Then
            cmd.Parameters.AddWithValue("@AG_Employee_Name", txtAG_Employee_Name.Text)
        Else
            cmd.Parameters.AddWithValue("@AG_Employee_Name", txtAG_Employee_Name.Text).Value = DBNull.Value
        End If
        
        cmd.Parameters.AddWithValue("@NSLDS_Checked", ddlNSLDS_Checked.SelectedValue)
        cmd.Parameters.AddWithValue("@DMCS_Checked", ddlDMCS_Checked.SelectedValue)
        cmd.Parameters.AddWithValue("@StatusID", ddlStatus.SelectedValue)
       
        If txtPAT_Date_Original.Text <> "" Then
            cmd.Parameters.AddWithValue("@PAT_Date_Original", txtPAT_Date_Original.Text)
        Else
            cmd.Parameters.AddWithValue("@PAT_Date_Original", txtPAT_Date_Original.Text).Value = DBNull.Value
        End If
        
        If txtPAT_Date_Last.Text <> "" Then
            cmd.Parameters.AddWithValue("@PAT_Date_Last", txtPAT_Date_Last.Text)
        Else
            cmd.Parameters.AddWithValue("@PAT_Date_Last", txtPAT_Date_Last.Text).Value = DBNull.Value
        End If
        
        If txtEAUserID.Text <> "" Then
            cmd.Parameters.AddWithValue("@EAUserID", txtEAUserID.Text)
        Else
            cmd.Parameters.AddWithValue("@EAUserID", txtEAUserID.Text).Value = DBNull.Value
        End If
       
        If txtUserID_Request_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@User_ID_Request_Date", txtUserID_Request_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@User_ID_Request_Date", txtUserID_Request_Date.Text).Value = DBNull.Value
        End If
        
        cmd.Parameters.AddWithValue("@Removed_From_Contract", chkRemoved_From_Contract.Checked)
        cmd.Parameters.AddWithValue("@SixC", chkSixC.Checked)
        cmd.Parameters.AddWithValue("@ReceiveEmail", chkSixC.Checked)
        cmd.Parameters.AddWithValue("@LVCCoordinator", chkLVCCoordinator.Checked)
        
        If txtRemoved_From_Contract_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@Removed_From_Contract_Date", txtRemoved_From_Contract_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@Removed_From_Contract_Date", txtRemoved_From_Contract_Date.Text).Value = DBNull.Value
        End If
        
        If txtContract_Start_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@Contract_Start_Date", txtContract_Start_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@Contract_Start_Date", txtContract_Start_Date.Text).Value = DBNull.Value
        End If
        
        If txtIRT_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@IRT_Date", txtIRT_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@IRT_Date", txtIRT_Date.Text).Value = DBNull.Value
        End If
        
        If txtSAT_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@SAT_Date", txtSAT_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@SAT_Date", txtSAT_Date.Text).Value = DBNull.Value
        End If
        
        If txtROB_Date.Text <> "" Then
            cmd.Parameters.AddWithValue("@ROB_Date", txtROB_Date.Text)
        Else
            cmd.Parameters.AddWithValue("@ROB_Date", txtROB_Date.Text).Value = DBNull.Value
        End If
        
        If ddlPAT_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@PAT_Attachment_Accepted_By_ED", ddlPAT_Attachment_Accepted_By_ED.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@PAT_Attachment_Accepted_By_ED", ddlPAT_Attachment_Accepted_By_ED.SelectedValue).Value = DBNull.Value
        End If
        
        If ddlSAT_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@SAT_Attachment_Accepted_By_ED", ddlSAT_Attachment_Accepted_By_ED.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@SAT_Attachment_Accepted_By_ED", ddlSAT_Attachment_Accepted_By_ED.SelectedValue).Value = DBNull.Value
        End If
        
        If ddlIRT_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@IRT_Attachment_Accepted_By_ED", ddlIRT_Attachment_Accepted_By_ED.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@IRT_Attachment_Accepted_By_ED", ddlIRT_Attachment_Accepted_By_ED.SelectedValue).Value = DBNull.Value
        End If
        
        If ddlROB_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@ROB_Attachment_Accepted_By_ED", ddlROB_Attachment_Accepted_By_ED.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@ROB_Attachment_Accepted_By_ED", ddlROB_Attachment_Accepted_By_ED.SelectedValue).Value = DBNull.Value
        End If
        
        If ddlLVC_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@LVC_Attachment_Accepted_By_ED", ddlLVC_Attachment_Accepted_By_ED.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@LVC_Attachment_Accepted_By_ED", ddlLVC_Attachment_Accepted_By_ED.SelectedValue).Value = DBNull.Value
        End If
        
        If ddlDMCS_ROB_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@DMCS_ROB_Attachment_Accepted_By_ED", ddlDMCS_ROB_Attachment_Accepted_By_ED.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@DMCS_ROB_Attachment_Accepted_By_ED", ddlDMCS_ROB_Attachment_Accepted_By_ED.SelectedValue).Value = DBNull.Value
        End If
        
        If ddlDMCS_Access_Attachment_Accepted_By_ED.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@DMCS_Access_Attachment_Accepted_By_ED", ddlDMCS_Access_Attachment_Accepted_By_ED.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@DMCS_Access_Attachment_Accepted_By_ED", ddlDMCS_Access_Attachment_Accepted_By_ED.SelectedValue).Value = DBNull.Value
        End If
        
        If txtComments_PCA.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments_PCA", txtComments_PCA.Text)
        Else
            cmd.Parameters.AddWithValue("@Comments_PCA", txtComments_PCA.Text).Value = DBNull.Value
        End If
        
        If txtComments_ED.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments_ED", txtComments_ED.Text)
        Else
            cmd.Parameters.AddWithValue("@Comments_ED", txtComments_ED.Text).Value = DBNull.Value
        End If
        
        cmd.Parameters.AddWithValue("@AcceptAllTrainingForms", ddlAcceptAllTrainingForms.SelectedValue)
              
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
        
        rptEmployeeDetails.DataBind()
        
        lblUpdateStatus.Text = "This employee record has been updated"
        
    End Sub
           
    
    Protected Sub rptEmployeeDetails_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Then
            Dim link1 As HyperLink = DirectCast(e.Item.FindControl("HyperLink1"), HyperLink)
            Dim ddlPAT_Attachment_Accepted_By_ED As DropDownList = DirectCast(e.Item.FindControl("ddlPAT_Attachment_Accepted_By_ED"), DropDownList)
            If String.IsNullOrEmpty(link1.NavigateUrl) OrElse ddlPAT_Attachment_Accepted_By_ED.SelectedValue = "No" Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l1"), HtmlGenericControl)
                'link1.NavigateUrl = "upload.PAT.form.aspx?ID=" & lblID.Text
                link1.NavigateUrl = "javascript: openWindowPAT('" & lblID.Text & "');"
                link1.Text = "* Upload * Privacy Act Training  (PAT) Form"
            End If

            Dim link2 As HyperLink = DirectCast(e.Item.FindControl("HyperLink2"), HyperLink)
            Dim ddlSAT_Attachment_Accepted_By_ED As DropDownList = DirectCast(e.Item.FindControl("ddlSAT_Attachment_Accepted_By_ED"), DropDownList)
            If String.IsNullOrEmpty(link2.NavigateUrl) OrElse ddlSAT_Attachment_Accepted_By_ED.SelectedValue = "No" Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l2"), HtmlGenericControl)
                'link2.NavigateUrl = "upload.SAT.form.aspx?ID=" & lblID.Text
                link2.NavigateUrl = "javascript: openWindowSAT('" & lblID.Text & "');"
                link2.Text = "* Upload * Security Awareness Training  (SAT) Form"
            End If
            
            Dim link3 As HyperLink = DirectCast(e.Item.FindControl("HyperLink3"), HyperLink)
            Dim ddlIRT_Attachment_Accepted_By_ED As DropDownList = DirectCast(e.Item.FindControl("ddlIRT_Attachment_Accepted_By_ED"), DropDownList)
            If String.IsNullOrEmpty(link3.NavigateUrl) OrElse ddlIRT_Attachment_Accepted_By_ED.SelectedValue = "No" Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l3"), HtmlGenericControl)
                'link3.NavigateUrl = "upload.IRT.form.aspx?ID=" & lblID.Text
                link3.NavigateUrl = "javascript: openWindowIRT('" & lblID.Text & "');"
                link3.Text = "* Upload * Incidence Response Training  (IRT) Form"
            End If
            
            Dim link4 As HyperLink = DirectCast(e.Item.FindControl("HyperLink4"), HyperLink)
            Dim ddlROB_Attachment_Accepted_By_ED As DropDownList = DirectCast(e.Item.FindControl("ddlROB_Attachment_Accepted_By_ED"), DropDownList)
            If String.IsNullOrEmpty(link4.NavigateUrl) OrElse ddlROB_Attachment_Accepted_By_ED.SelectedValue = "No" Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l4"), HtmlGenericControl)
                'link4.NavigateUrl = "upload.ROB.form.aspx?ID=" & lblID.Text
                link4.NavigateUrl = "javascript: openWindowROB('" & lblID.Text & "');"
                link4.Text = "* Upload * Rules of Behavior (ROB) Form"
            End If
            
            Dim link5 As HyperLink = DirectCast(e.Item.FindControl("HyperLink5"), HyperLink)
            If String.IsNullOrEmpty(link5.NavigateUrl) Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l5"), HtmlGenericControl)
                'link5.NavigateUrl = "upload.FFEL.request.form.aspx?ID=" & lblID.Text
                link5.NavigateUrl = "javascript: openWindowFFEL('" & lblID.Text & "');"
                link5.Text = "* Upload * FFEL Login Form"
            End If
            
            Dim link6 As HyperLink = DirectCast(e.Item.FindControl("HyperLink6"), HyperLink)
            Dim ddlLVC_Attachment_Accepted_By_ED As DropDownList = DirectCast(e.Item.FindControl("ddlLVC_Attachment_Accepted_By_ED"), DropDownList)
            If String.IsNullOrEmpty(link6.NavigateUrl) OrElse ddlLVC_Attachment_Accepted_By_ED.SelectedValue = "No" Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l6"), HtmlGenericControl)
                link6.NavigateUrl = "javascript: openWindowLVC('" & lblID.Text & "');"
                link6.Text = "* Upload * LVC Form"
            End If
            
            Dim link7 As HyperLink = DirectCast(e.Item.FindControl("HyperLink7"), HyperLink)
            Dim ddlDMCS_ROB_Attachment_Accepted_By_ED As DropDownList = DirectCast(e.Item.FindControl("ddlDMCS_ROB_Attachment_Accepted_By_ED"), DropDownList)
            If String.IsNullOrEmpty(link7.NavigateUrl) OrElse ddlDMCS_ROB_Attachment_Accepted_By_ED.SelectedValue = "No" Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l7"), HtmlGenericControl)
                link7.NavigateUrl = "javascript: openWindowDMCSROB('" & lblID.Text & "');"
                link7.Text = "* Upload * DMCS Rules of Behavior (ROB) Form"
            End If
            
            Dim link8 As HyperLink = DirectCast(e.Item.FindControl("HyperLink8"), HyperLink)
            Dim ddlDMCS_Access_Attachment_Accepted_By_ED As DropDownList = DirectCast(e.Item.FindControl("ddlDMCS_Access_Attachment_Accepted_By_ED"), DropDownList)
            If String.IsNullOrEmpty(link8.NavigateUrl) OrElse ddlDMCS_Access_Attachment_Accepted_By_ED.SelectedValue = "No" Then
                Dim li As HtmlGenericControl = CType(e.Item.FindControl("l8"), HtmlGenericControl)
                link8.NavigateUrl = "javascript: openWindowDMCSAccess('" & lblID.Text & "');"
                link8.Text = "* Upload * DMCS Access Form"
            End If
            
        End If
        
        CheckFields()
    End Sub
    
    Protected Sub chkRemoved_From_Contract_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim dataItem As RepeaterItem
        For Each dataItem In rptEmployeeDetails.Items
            Dim chkRemoved_From_Contract As CheckBox = CType(dataItem.FindControl("chkRemoved_From_Contract"), CheckBox)
            Dim txtRemoved_From_Contract_Date As TextBox = CType(dataItem.FindControl("txtRemoved_From_Contract_Date"), TextBox)
            Dim rfRemoved_From_Contract_Date As RequiredFieldValidator = CType(dataItem.FindControl("rfRemoved_From_Contract_Date"), RequiredFieldValidator)
         
            If chkRemoved_From_Contract.Checked = True Then
                txtRemoved_From_Contract_Date.Enabled = True
                rfRemoved_From_Contract_Date.Enabled = True
            Else
                txtRemoved_From_Contract_Date.Enabled = False
                rfRemoved_From_Contract_Date.Enabled = False
            End If
            
        Next
    End Sub
    
    Protected Sub btnUpdateFFEL_Click(ByVal sender As Object, ByVal e As EventArgs)
        ' Looping through all the rows in the GridView
        For Each row As GridViewRow In GridView1.Rows
            Dim chkApproved As CheckBox = CType(row.FindControl("chkApproved"), CheckBox)
            
                'Retreive the FFEL ID
                Dim FFEL_ID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected FFEL_ID to the Update command.
                dsUpdateFFEL.UpdateParameters("FFEL_ID").DefaultValue = FFEL_ID
                If chkApproved.Checked Then
                dsUpdateFFEL.UpdateParameters("Approved").DefaultValue = 1
                dsUpdateFFEL.UpdateParameters("UserID").DefaultValue = lblEDUserID.Text
            Else
                dsUpdateFFEL.UpdateParameters("Approved").DefaultValue = 0
                dsUpdateFFEL.UpdateParameters("UserID").DefaultValue = ""
            End If
           
            
            dsUpdateFFEL.Update()
            GridView1.DataBind()
        Next row
        
        lblFFELUpdate_Status.Text = "These FFEL Requests have been approved"
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            var selected = $('#rptEmployeeDetails_ctl01_ddlStatus').val();
            $("#spnPreviousID_Status").text('').append(selected);
            $("#rptEmployeeDetails_ctl01_ddlStatus").change(onSelectChange);
        }
    );

        function onSelectChange() {
            var IsED = $('#lblED_AG_Security').text();
            var NSLDS = $('#rptEmployeeDetails_ctl01_ddlNSLDS_Checked').val();
            var DMCS = $('#rptEmployeeDetails_ctl01_ddlDMCS_Checked').val();


            // display the output of the item selected for ddlID_Status
            var selected = $("#rptEmployeeDetails_ctl01_ddlStatus option:selected");
            if (IsED != "ED") {
                // working with PCA here
                if (selected.val() == 1 || selected.val() == 2 || selected.val() == 3) {
                    alert("This status code is available only to ED employees");

                    //set the ddlID_Status dropdown box back to its original value
                    $("#rptEmployeeDetails_ctl01_ddlStatus").val($("#spnPreviousID_Status").text());
                    return false;
                }

                // Doug does not want agencies to be able to change the employee status to No Longer Employed(5)
                // from Not Hired(4)
                if (selected.val() == 4 && $("#spnPreviousID_Status").text() == '5') {
                    alert("You cannot change this status code to Not Hired from No Longer Employed");

                    //set the ddlID_Status dropdown box back to its original value
                    $("#rptEmployeeDetails_ctl01_ddlStatus").val($("#spnPreviousID_Status").text());
                    return false;
                }

                // Doug does not want agencies to be able to change the employee status to Not Hired(4)
                // from No Longer Employed (5)
                if (selected.val() == 5 && $("#spnPreviousID_Status").text() == '4') {
                    alert("You cannot change this status code to No Longer Employed from Not Hired");

                    //set the ddlID_Status dropdown box back to its original value
                    $("#rptEmployeeDetails_ctl01_ddlStatus").val($("#spnPreviousID_Status").text());
                    return false;
                }

                // we want to prompt the agencies to submit a FFEL login deletion request if the employee is no longer employed there
                if (selected.val() == 5) {
                    alert("Please remember to submit a FFEL login delete request if this employee is no longer employed with your agency");
                }


            } else {
                // working with an ED employee here
                // user cannot place an account into status code 3 unless both NSLDS checked and DMCS checked != No
                if (selected.val() == 3) {
                    if (NSLDS == 'No' || DMCS == 'No') {
                        alert("You cannot approve an account unless both the NSLDS and DMCS have been checked");

                        //set the ddlID_Status dropdown box back to its original value
                        $("#rptEmployeeDetails_ctl01_ddlStatus").val($("#spnPreviousID_Status").text());
                        return false;
                    }
                }
            }
        }
    </script>
    
    <script type="text/javascript" language="javascript">
        function openWindowPAT(ID) {
            window.open("upload.PAT.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=480,height=325");
        }

        function openWindowSAT(ID) {
            window.open("upload.SAT.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=460,height=240");
        }

        function openWindowIRT(ID) {
            window.open("upload.IRT.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=460,height=240");
        }

        function openWindowROB(ID) {
            window.open("upload.ROB.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=460,height=240");
        }

        function openWindowFFEL(ID) {
            window.open("upload.FFEL.request.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=460,height=240");
        }

        function openWindowLVC(ID) {
            window.open("upload.LVC.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=510,height=220");
        }

        function openWindowDMCSROB(ID) {
            window.open("upload.DMCSROB.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=530,height=220");
        }

        function openWindowDMCSAccess(ID) {
            window.open("upload.DMCSAccess.form.aspx?ID=" + ID, "mywindow", "location=1,status=1,scrollbars=1,width=530,height=220");
        }

    </script>   
</head>
<body>
    <form id="form1" runat="server">
      <!--This one populates thedsPCA Employee Detail form-->
                     <asp:SqlDataSource ID="dsPCAEmployeeDetail" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_PCAEmployee_Details" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                    <asp:ControlParameter ControlID="lblID" Name="ID" />
                            </SelectParameters>
                        </asp:SqlDataSource>                                                
                           
                      <!--This one populates the Agency dropdown-->
                      <asp:SqlDataSource ID="dsAgencies" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllAgencies" SelectCommandType="StoredProcedure" />
                            
                       <!--This one populates the employee status values dropdown-->
                      <asp:SqlDataSource ID="dsStatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_PCAEmployeeStatusValues" SelectCommandType="StoredProcedure" />
                       
                     <!--This one populates the FFEL Requests grid-->
                       <asp:SqlDataSource ID="dsFFELRequests_ID" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                    SelectCommand="p_PCAEmployee_FFEL_Requests_ID" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Id" QueryStringField="Id" />
                    </SelectParameters>                     
                </asp:SqlDataSource> 

                <asp:SqlDataSource ID="dsUpdateFFEL" Runat="server" UpdateCommand="p_PCAEmployee_FFEL_Approved" UpdateCommandType="StoredProcedure"
                   ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" >
                    <UpdateParameters>
                        <asp:Parameter Name="FFEL_ID" />
                        <asp:Parameter Name="Approved" />
                        <asp:Parameter Name="UserID" />                        
                    </UpdateParameters>
                </asp:SqlDataSource>

                   <!--This one populates the ED Users dropdown-->
                      <asp:SqlDataSource ID="dsAllEDUsers" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
                            SelectCommand="p_AllUsersActive" SelectCommandType="StoredProcedure" />
                      
    <fieldset>
    <legend class="fieldsetLegend"></legend>
        <br />
    <div align="left">
    
<asp:Repeater id="rptEmployeeDetails" Runat="Server"  DataSourceID="dsPCAEmployeeDetail" OnItemCommand="Edit_Record" OnItemDataBound="rptEmployeeDetails_ItemDataBound">
<HeaderTemplate>
    <table border="0" cellpadding="6" cellspacing="3" style="border-collapse:collapse;" >
    
    </HeaderTemplate>
    <ItemTemplate>
    <tr>
		<td class ="formLabelForm" style="width: 25%">Employee ID:</td>
        <td style="width: 25%"><asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") %>' /></td>
        <td style="width: 25%"> </td>
        <td style="width: 25%"> </td>		
	</tr>
   <tr>
            <td class ="formLabelForm" style="width: 25%">Agency:</td>
            <td style="width: 25%"><asp:DropDownList ID="ddlAgencyID" runat="server" CssClass="formLabel"
                         DataSourceID="dsAgencies"
                          DataTextField="AG_Name"
                          DataValueField="AG" AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("AG") %>' Enabled="false">
                          <asp:ListItem Text="" Value="" />                              
                </asp:DropDownList>                
            </td>
            <td class ="formLabelForm" style="width: 25%">SSN:</td>
            <td style="width: 25%"><asp:Label ID="lblSSN" runat="server" Text='<%# Eval("SSN") %>' /></td>            
    </tr>
    <tr>
        <td class ="formLabelForm" style="width: 25%">Employee First Name:</td>
        <td style="width: 25%"><asp:TextBox ID="txtFirst_Name" runat="server" Text='<%# Eval("First_Name") %>' /></td>
        <td class ="formLabelForm" style="width: 25%">Employee Last Name:</td>
        <td style="width: 25%"><asp:Textbox ID="txtLast_Name" runat="server" Text='<%# Eval("Last_Name") %>' /></td>
    </tr>
    <tr>
        <td class ="formLabelForm" style="width: 25%">Employee Email:</td>
        <td style="width: 25%"><asp:Textbox ID="txtEmail" runat="server" Text='<%# Eval("Email") %>' CssClass="formLabel" Columns="30" /></td>
        <td class ="formLabelForm" style="width: 25%">Employee Title: </td>
             <td style="width: 25%"><asp:DropDownList ID="ddlTitle" runat="server" CssClass="formLabel" SelectedValue='<%# Eval("Title") %>'>
                    <asp:ListItem Text="" Value="" /> 
                   <asp:ListItem Text="AWG Coordinator" Value="AWG Coordinator" />
                   <asp:ListItem Text="Contract Administrator" Value="Contract Administrator" />
                    <asp:ListItem Text="Deputy Contract Administrator" Value="Deputy Contract Administrator" />
                    <asp:ListItem Text="President or CEO" Value="President or CEO" />
                    <asp:ListItem Text="Vice President" Value="Vice President" />
                    <asp:ListItem Text="Other" Value="Other" />                           
            </asp:DropDownList></td>    
    </tr>    
    <tr>
        <td class ="formLabelForm" style="width: 25%">Submitted By:</td>
        <td style="width: 25%"><asp:Textbox ID="txtAG_Employee_Name" runat="server" Text='<%# Eval("AG_Employee_Name") %>' CssClass="formLabel" Columns="30" /></td>
        <td class ="formLabelForm">Assigned To:</td>
        <td><asp:DropDownList id="ddlAllEDUsers" Runat="Server" CssClass="formLabel"
                         DataSourceID="dsAllEDUsers"
                          DataTextField="UserName"
                          DataValueField="UserID"
                          AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("UserID") %>'>
                          <asp:ListItem Text="" Value="" />                             
                  </asp:DropDownList></td>        
    </tr>
    <tr>
        <td class ="formLabelForm" style="width: 25%">6C Employee?</td>
        <td style="width: 25%"><asp:Checkbox ID="chkSixC" runat="server" CssClass="formLabel" Checked='<%# Eval("SixC") %>' /></td>
        <td class ="formLabelForm" style="width: 25%">Employee Should Receive Email?</td>
        <td><asp:Checkbox ID="chkReceiveEmail" runat="server" CssClass="formLabel" Checked='<%# Eval("ReceiveEmail") %>' /></td></td>
    </tr>
    <tr>
        <td class ="formLabelForm" style="width: 25%">Employee Function:</td>
        <td style="width: 25%">
            <asp:DropDownList ID="ddlEmployeeFunction" runat="server" CssClass="formLabel" SelectedValue='<%# Eval("EmployeeFunction") %>'>
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Clerk" Value="Clerk" />
                    <asp:ListItem Text="PCA IT" Value="PCA IT" />
                    <asp:ListItem Text="PCA Manager" Value="PCA Manager" />
                    <asp:ListItem Text="PCA Rep" Value="PCA Rep" />                           
            </asp:DropDownList>             
            </td>
            <td style="width: 25%"> </td>
            <td style="width: 25%"> </td>
                                
    </tr>
    <tr>
		<td class ="formSeparator" colspan="4">Preemployment Status Checks</td>		
	</tr>
    <tr>
            <td class ="formLabelForm" style="width: 25%">Pre-Employment Submitted Date:</td>
            <td style="width: 25%"><asp:Label ID="lblDate_Employee_Added" runat="server" Text='<%# Eval("Date_Employee_Added", "{0:d}") %>' /></td>
            <td style="width: 25%" class="formLabelForm">Current Status:</td>
             <td>
             <asp:DropDownList ID="ddlStatus" runat="server" CssClass="formLabel"
                         DataSourceID="dsStatus"
                          DataTextField="Status"
                          DataValueField="StatusID" AppendDataBoundItems="true"
                          SelectedValue='<%# Eval("StatusID") %>'>
                          <asp:ListItem Text="" Value="" />                              
                </asp:DropDownList>
              </td>
       </tr>
       <tr>      
            <td class="formLabelForm" style="width: 25%">NSLDS Checked? </td>
            <td style="width: 25%">
            <asp:DropDownList ID="ddlNSLDS_Checked" runat="server" CssClass="formLabel"
                          SelectedValue='<%# Eval("NSLDS_Checked") %>' Enabled="false">
                          <asp:ListItem Text="" Value="" />  
                          <asp:ListItem Text="No" Value="No" />
                          <asp:ListItem Text="Yes" Value="Yes" />                            
                </asp:DropDownList>               
            </td> 
            <td class="formLabelForm" style="width: 25%">DMCS Checked? </td>
                <td style="width: 25%">
                <asp:DropDownList ID="ddlDMCS_Checked" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("DMCS_Checked") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
                    </asp:DropDownList>
                </td>                       
            </tr>       
        </tr>
        <tr>
		    <td class ="formSeparator" colspan="4">User ID</td>		
	    </tr>
        <tr>              
           <td class ="formLabelForm" style="width: 25%">Date User ID Requested:</td>
            <td style="width: 25%"><asp:Textbox ID="txtUserID_Request_Date" runat="server" Text='<%# Eval("UserID_Request_Date", "{0:d}") %>' Enabled="false" /></td> 
           <td class ="formLabelForm" style="width: 25%">User ID Asssigned:</td>
           <td style="width: 25%"><asp:Textbox ID="txtEAUserID" runat="server" Text='<%# Eval("EAUserID") %>' /></td>          
        </tr> 
         <tr>
		    <td class ="formSeparator" colspan="4">LVC Coordinator</td>		
	    </tr>
         <tr>
        <td class ="formLabelForm" style="width: 25%">LVC Coordinator?</td>
        <td style="width: 25%"><asp:Checkbox ID="chkLVCCoordinator" runat="server" CssClass="formLabel" Checked='<%# Eval("LVCCoordinator") %>' /></td>
         <td class ="formLabelForm"  style="width: 25%">LVC Form Accepted By ED?</td>
        <td style="width: 25%"><asp:DropDownList ID="ddlLVC_Attachment_Accepted_By_ED" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("LVC_Attachment_Accepted_By_ED") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
            </asp:DropDownList></td>       
    </tr>
    <tr>
		    <td class ="formSeparator" colspan="4">DMCS</td>		
	    </tr>
         <tr>
        <td class ="formLabelForm" style="width: 25%">DMCS Rules of Behavior (New System Only)  Accepted?</td>
        <td style="width: 25%"><asp:DropDownList ID="ddlDMCS_ROB_Attachment_Accepted_By_ED" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("DMCS_ROB_Attachment_Accepted_By_ED") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
            </asp:DropDownList></td>
         <td class ="formLabelForm"  style="width: 25%">DMCS Access Request Form (New System Only) Accepted ?</td>
        <td style="width: 25%"><asp:DropDownList ID="ddlDMCS_Access_Attachment_Accepted_By_ED" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("DMCS_Access_Attachment_Accepted_By_ED") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
            </asp:DropDownList></td>       
    </tr>

        <tr>
		    <td class ="formSeparator" colspan="4">Training</td>		
	    </tr>   
         <tr>
            <td style="width: 25%" class ="formLabelForm">Privacy Act Training 
			(PAT) Form </td>
            <td style="width: 25%">
            &nbsp;</td>                
           <td class ="formLabelForm" style="width: 25%">Incidence Response 
		   Training (IRT) Form</td>
          <td style="width: 25%">&nbsp;</td>          
        </tr>     
         <tr>
            <td style="width: 25%" class ="formLabelForm">PAT Form Accepted?</td>
            <td style="width: 25%">
            <asp:DropDownList ID="ddlPAT_Attachment_Accepted_By_ED" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("PAT_Attachment_Accepted_By_ED") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
            </asp:DropDownList></td>                
           <td class ="formLabelForm" style="width: 25%">IRT Form Accepted?</td>
          <td style="width: 25%">
            <asp:DropDownList ID="ddlIRT_Attachment_Accepted_By_ED" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("IRT_Attachment_Accepted_By_ED") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
            </asp:DropDownList></td>          
        </tr>     
        <tr>
           <td class ="formLabelForm" style="width: 25%">Date Original PAT Completed:</td>
            <td style="width: 25%"><asp:Textbox ID="txtPAT_Date_Original" runat="server" Text='<%# Eval("PAT_Date_Original", "{0:d}") %>' /></td> 
             <td class ="formLabelForm" style="width: 25%">Date Last IRT Completed:</td>
           <td style="width: 25%"><asp:Textbox ID="txtIRT_Date" runat="server" Text='<%# Eval("IRT_Date", "{0:d}") %>' /></td>            
        </tr>
           
        <tr>
           <td class ="formLabelForm" style="width: 25%">Date Last PAT Completed:</td>
            <td style="width: 25%"><asp:Textbox ID="txtPAT_Date_Last" runat="server" Text='<%# Eval("PAT_Date_Last", "{0:d}") %>' /></td> 
             <td class ="formLabelForm" style="width: 25%">&nbsp;</td>
           <td style="width: 25%">&nbsp;</td>            
        </tr>
        <tr>
           <td class ="formLabelForm" colspan="4">
		   <hr noshade="noshade" style="height: 1px; color: #C0C0C0" /></td>
        </tr>
           
        <tr>
           <td class ="formLabelForm" style="width: 25%">Security Awareness Training (SAT) Form </td>
            <td style="width: 25%">&nbsp;</td> 
             <td class ="formLabelForm" style="width: 25%">Rules of Behavior (ROB) Form</td>
           <td style="width: 25%">&nbsp;</td>            
        </tr>
           
        <tr>
           <td class ="formLabelForm" style="width: 25%">SAT Form Accepted?</td>
            <td style="width: 25%">
            <asp:DropDownList ID="ddlSAT_Attachment_Accepted_By_ED" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("SAT_Attachment_Accepted_By_ED") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
            </asp:DropDownList></td> 
             <td class ="formLabelForm" style="width: 25%">ROB Form Accepted?</td>
           <td style="width: 25%">
            <asp:DropDownList ID="ddlROB_Attachment_Accepted_By_ED" runat="server" CssClass="formLabel"
                              SelectedValue='<%# Eval("ROB_Attachment_Accepted_By_ED") %>' Enabled="false">
                              <asp:ListItem Text="" Value="" />  
                              <asp:ListItem Text="No" Value="No" />
                              <asp:ListItem Text="Yes" Value="Yes" />                            
            </asp:DropDownList></td>            
        </tr>
           
        <tr>
           <td class ="formLabelForm" style="width: 25%">Date Last SAT Completed:</td>
            <td style="width: 25%"><asp:Textbox ID="txtSAT_Date" runat="server" Text='<%# Eval("SAT_Date", "{0:d}") %>' /></td> 
             <td class ="formLabelForm" style="width: 25%">Date Last ROB Completed:</td>
             <td style="width: 25%"><asp:Textbox ID="txtROB_Date" runat="server" Text='<%# Eval("ROB_Date", "{0:d}") %>' /></td>            
        </tr>
         <tr>
           <td class ="formLabelForm" colspan="4">
		   <hr noshade="noshade" style="height: 1px; color: #C0C0C0" /></td>
        </tr>
        <tr>
            <td colspan="2" class="formLabelForm">Accept All Employee Training Forms and PCA May Upload FFEL Login Form:
            <asp:DropDownList ID="ddlAcceptAllTrainingForms" runat="server" CssClass="formLabel"
               SelectedValue='<%# Eval("AcceptAllTrainingForms") %>'>
               <asp:ListItem Text="" Value="" />  
               <asp:ListItem Text="No" Value="False" />
               <asp:ListItem Text="Yes" Value="True" />                            
            </asp:DropDownList> </td>
            <td></td>
        </tr>
        <tr>
		    <td class ="formSeparator" colspan="4">Contract Start</td>	
	    </tr>               
         <tr>
            <td class ="formLabelForm" style="width: 25%">Contract Start Date:</td>
            <td style="width: 25%"><asp:Textbox ID="txtContract_Start_Date" runat="server" Text='<%# Eval("Contract_Start_Date", "{0:d}") %>' /></td>
            <td style="width: 25%" class ="formLabelForm"></td>
            <td style="width: 25%"></td>            
        </tr>
        <tr>
		    <td class ="formSeparator" colspan="4">Contract Removal</td>	
	    </tr>         
        <tr>
            <td class="formLabelForm" style="width: 25%">Removed From Contract ?</td>
            <td style="width: 25%"><asp:CheckBox ID="chkRemoved_From_Contract" runat="server" Checked='<%# Eval("Removed_From_Contract") %>' OnCheckedChanged="chkRemoved_From_Contract_CheckedChanged" AutoPostBack="true" /></td>
            <td class ="formLabelForm" style="width: 25%">Removed From Contract Start Date:</td>
           <td style="width: 25%"><asp:Textbox ID="txtRemoved_From_Contract_Date" runat="server" Text='<%# Eval("Removed_From_Contract_Date", "{0:d}") %>' Enabled="false" />
            <asp:RequiredFieldValidator ID="rfRemoved_From_Contract_Date" runat="server" CssClass="warningMessage" ControlToValidate="txtRemoved_From_Contract_Date" Display="Dynamic" Enabled="false" ErrorMessage=" * Removed From Contract Start Date is required if the Removed From Contract field has been checked"  /></td>          
        </tr>         
        <tr>
		    <td class ="formSeparator" colspan="4">Comments</td>		
	    </tr>
        <tr>
            <td class ="formLabelForm" style="width: 25%">Agency Comments:</td>
            <td style="width: 25%"><asp:Textbox ID="txtComments_PCA" runat="server" Text='<%# Eval("Comments_PCA") %>' TextMode="MultiLine" Rows="5" Columns="30" /></td>
            <td class ="formLabelForm" style="width: 25%">ED Comments:</td>
           <td style="width: 25%"><asp:Textbox ID="txtComments_ED" runat="server" Text='<%# Eval("Comments_ED") %>' TextMode="MultiLine" Rows="5" Columns="30" /></td>            
        </tr>
        <tr>
		    <td class ="formSeparator" colspan="4">Attachments</td>		
	    </tr>                
        <tr>
        <td colspan="4">
            <ul id="listLinks" runat="server">                                                                      
                   <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("PAT_Attachment")%>' runat="server">Privacy Act Training Form (PAT) </asp:HyperLink></li>     
                   <li id="l2" runat="server"><asp:HyperLink ID="HyperLink2" NavigateUrl='<%# Eval("SAT_Attachment")%>' runat="server">Security Awareness Training (SAT) Form</asp:HyperLink></li>
                   <li id="l3" runat="server"><asp:HyperLink ID="HyperLink3" NavigateUrl='<%# Eval("IRT_Attachment")%>' runat="server">Incidence Response Training (IRT) Form</asp:HyperLink></li>
                   <li id="l4" runat="server"><asp:HyperLink ID="HyperLink4" NavigateUrl='<%# Eval("ROB_Attachment")%>' runat="server">Rules of Behavior (ROB) Form</asp:HyperLink></li>      
                   <li id="l5" runat="server"><asp:HyperLink ID="HyperLink5" NavigateUrl='<%# Eval("FFEL_Login_Request_Attachment")%>' runat="server">FFEL Login Form</asp:HyperLink></li> 
                   <li id="l6" runat="server"><asp:HyperLink ID="HyperLink6" NavigateUrl='<%# Eval("LVC_Attachment")%>' runat="server">LVC Form</asp:HyperLink></li> 
                   <li id="l7" runat="server"><asp:HyperLink ID="HyperLink7" NavigateUrl='<%# Eval("DMCS_ROB_Attachment")%>' runat="server">DMCS ROB Form</asp:HyperLink></li>
                   <li id="l8" runat="server"><asp:HyperLink ID="HyperLink8" NavigateUrl='<%# Eval("DMCS_Access_Attachment")%>' runat="server">DMCS Access Form</asp:HyperLink></li> 
            </ul> 
        </td>
        </tr>        
        <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnUpdateEmployee" runat="server" Text="Update Employee" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" /><br />
                </td>
        </tr> 
        </ItemTemplate>
              
        <FooterTemplate>        
        </table>
        </FooterTemplate>
        </asp:Repeater>
        <div align="center" style="width: 100%">
                <asp:Label ID="lblError" runat="server" />
                 <asp:Label ID="lblUpdateStatus" runat="server" CssClass="warningMessage" />      
         </div>
         </fieldset>
         <br />
         <div class="grid">
                            <asp:GridView ID="GridView1" runat="server" DataKeyNames="FFEL_ID" DataSourceID="dsFFELRequests_ID" AutoGenerateColumns="false" CellPadding="4" 
                            Width="90%" CssClass="datatable" BorderStyle="Solid" BorderWidth="2px" BackColor="White" GridLines="Horizontal" 
                            AllowPaging="true" AllowSorting="true" PageSize="20" PagerSettings-Position="TopAndBottom" Caption="FFEL Requests"> 
                            
                            <EmptyDataTemplate>
                                    This agency has not submitted any FFEL requests
                            </EmptyDataTemplate>
                            <RowStyle CssClass="row" />
                            <Columns>	                    
                                   
                                    <asp:BoundField 
                                    DataField="FFEL_ID" 
                                    HeaderText="FFEL ID"
                                    SortExpression="FFEL_ID"
                                    ItemStyle-HorizontalAlign="Left" />
                                    
                                    <asp:BoundField 
                                    DataField="Date_Submitted" 
                                    HeaderText="Date Submitted" 
                                    SortExpression="Date_Submitted" 
                                    DataFormatString="{0:d}"
                                    ItemStyle-HorizontalAlign="Right" />
                                    
                                   <asp:BoundField 
                                    DataField="ActionTaken" 
                                    HeaderText="Action Taken"
                                    SortExpression="ActionTaken"
                                    ItemStyle-HorizontalAlign="Left" />                                   
                                   
                                    <asp:TemplateField HeaderText="Attachments">
                                        <ItemTemplate>  
                                           <ul>                                                                      
                                            <li id="l1" runat="server"><asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("FFEL_Login_Attachment")%>' runat="server">FFEL Form</asp:HyperLink></li>     
                                           </ul>                                         
                                        </ItemTemplate>                                                                       
                                    </asp:TemplateField> 
                                 
                                 <asp:TemplateField HeaderText="Pending Approval?">
                                    <ItemTemplate>
                                        <asp:Checkbox ID="chkApproved" runat="server" Checked='<%# Eval("Approved") %>' Enabled="false" />			                                      
                                    </ItemTemplate>
                                    </asp:TemplateField>

                                <asp:BoundField 
                                    DataField="Username" 
                                    HeaderText="Approved By"
                                    SortExpression="Username"
                                    ItemStyle-HorizontalAlign="Left" />

                                </Columns>                
                            </asp:GridView>
                            <br />
                            <div align="center">
                                <asp:Button ID="btnUpdateFFEL" OnClick="btnUpdateFFEL_Click" runat="server" Text="Update FFEL Requests" CssClass="button" Visible="false" /><br /><br />
                                <asp:Label ID="lblFFELUpdate_Status" runat="server" CssClass="warningMessage" />
                            </div>
                            </div>    

        <asp:Label ID="lblID" runat="server" Visible="false" />
        <asp:Label ID="lblIsAdmin" runat="server" CssClass="hiddenField"  />
        <asp:Label ID="lblAgency" runat="server" Visible="False" />
        <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
        <asp:Label ID="lblED_AG_Security" runat="server" CssClass="hiddenField" />
       <span id="spnPreviousID_Status" class="hiddenField"></span>

    </form>
</body>
</html>
