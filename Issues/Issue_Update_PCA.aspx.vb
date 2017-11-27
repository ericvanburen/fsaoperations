Imports System.Data
Imports System.Data.SqlClient
Imports IssueHistory
Imports System.IO

Partial Class Issues_Issue_Update_PCA
    Inherits System.Web.UI.Page

    Protected Function GetRoleUsers() As String()
        Return Roles.GetUsersInRole("Issues")
    End Function

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            'Grab the previously submitted Issue Type, if any
            'If Not Request.QueryString("IssueType") Is Nothing Then
            'Dim strIssueType As String = Request.QueryString(0)
            'ddlIssueType.SelectedValue = strIssueType.ToString()
            'End If
            Dim IssueID As Integer
            If Not Request.QueryString("IssueID") Is Nothing Then
                IssueID = Request.QueryString("IssueID")
            Else
                IssueID = 0
            End If

            'Load the form data
            LoadForm(IssueID)

        End If
    End Sub

    Sub LoadForm(ByVal IssueID As Integer)

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim da As SqlDataAdapter
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssueDetail_PCA", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@IssueID", IssueID)
        da = New SqlDataAdapter(cmd)
        strSQLConn.Open()
        ds = New DataSet()
        da.Fill(ds)

        Repeater1.DataSource = ds
        Repeater1.DataBind()

        'Load Issue History
        Dim GridView1 As GridView
        Dim ddlQCDMCSUpdated As DropDownList
        Dim ddlQCFSAOperations As DropDownList
        Dim ddlQCeIMF As DropDownList
        Dim txtQCSupervisorComments As TextBox
        Dim txtQCEmployeeComments As TextBox

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
            'These are the QC fields
            ddlQCDMCSUpdated = CType(dataItem.FindControl("ddlQCDMCSUpdated"), DropDownList)
            ddlQCFSAOperations = CType(dataItem.FindControl("ddlQCFSAOperations"), DropDownList)
            ddlQCeIMF = CType(dataItem.FindControl("ddlQCeIMF"), DropDownList)
            txtQCSupervisorComments = CType(dataItem.FindControl("txtQCSupervisorComments"), TextBox)
            txtQCEmployeeComments = CType(dataItem.FindControl("txtQCEmployeeComments"), TextBox)

            If Roles.IsUserInRole("Issues_Admins") Then
                ddlQCDMCSUpdated.Enabled = True
                ddlQCFSAOperations.Enabled = True
                ddlQCeIMF.Enabled = True
                txtQCSupervisorComments.Enabled = True
                'This one is always enabled regardless of role
                txtQCEmployeeComments.Enabled = True
            Else
                ddlQCDMCSUpdated.Enabled = False
                ddlQCFSAOperations.Enabled = False
                ddlQCeIMF.Enabled = False
                txtQCSupervisorComments.Enabled = False
                'This one is always enabled regardless of role
                txtQCEmployeeComments.Enabled = True
            End If
            'This is for the issue history
            GridView1 = CType(dataItem.FindControl("GridView1"), GridView)
            dsIssueHistory.SelectParameters("IssueID").DefaultValue = IssueID
            GridView1.DataBind()
        Next


    End Sub

    Protected Sub ddlIssueType_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        Dim strIssueType As String
        Dim lblIssueType As Label

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items

            strIssueType = CType(dataItem.FindControl("ddlIssueType"), DropDownList).SelectedValue
            lblIssueType = CType(dataItem.FindControl("lblIssueType"), Label)
            lblIssueType.Text = "Update PCA Issue"
        Next
    End Sub

    Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim IssueID As Integer
        Dim eIMF As String = ""
        Dim IssueType As String = ""
        Dim IssueStatus As String = ""
        Dim UserID As String = ""
        Dim DateResolved As String = ""
        Dim DueDate As String = ""
        Dim IssueDescription As String = ""
        Dim Comments As String = ""
        Dim Resolution As String = ""
        Dim PCACorrectiveAction As String = ""
        Dim SourceOrgType As String = ""
        Dim AffectedOrgID As String = ""
        'Dim SourceContactInfo As String = ""
        'Dim SourceName As String = ""
        'Dim Owner As String = ""
        Dim ReceivedBy As String = ""
        Dim WrittenVerbal As String = ""
        Dim Severity As String = ""
        Dim CollectorFirstName As String = ""
        Dim CollectorLastName As String = ""
        Dim ComplaintTypeA As Boolean
        Dim ComplaintTypeB As Boolean
        Dim ComplaintTypeC As Boolean
        Dim ComplaintTypeD As Boolean
        Dim ComplaintTypeE As Boolean
        Dim ComplaintTypeF As Boolean
        Dim ComplaintTypeG As Boolean
        Dim ComplaintTypeH As Boolean
        Dim ComplaintTypeI As Boolean
        Dim ComplaintTypeJ As Boolean
        Dim ComplaintTypeK As Boolean
        Dim ComplaintTypeL As Boolean
        Dim ComplaintTypeM As Boolean
        Dim ComplaintTypeN As Boolean
        Dim ComplaintTypeO As Boolean
        Dim ComplaintTypeP As Boolean
        Dim ComplaintTypeQ As Boolean
        Dim ComplaintTypeR As Boolean
        Dim ComplaintTypeS As Boolean
        Dim ComplaintTypeT As Boolean
        Dim ComplaintTypeU As Boolean
        Dim ComplaintTypeV As Boolean
        Dim ComplaintTypeW As Boolean
        Dim ComplaintTypeX As Boolean
        Dim ComplaintTypeY As Boolean
        Dim ComplaintTypeZ As Boolean
        Dim ComplaintTypeZZ As Boolean
        Dim ComplaintTypeA_Validity As String = ""
        Dim ComplaintTypeB_Validity As String = ""
        Dim ComplaintTypeC_Validity As String = ""
        Dim ComplaintTypeD_Validity As String = ""
        Dim ComplaintTypeE_Validity As String = ""
        Dim ComplaintTypeF_Validity As String = ""
        Dim ComplaintTypeG_Validity As String = ""
        Dim ComplaintTypeH_Validity As String = ""
        Dim ComplaintTypeI_Validity As String = ""
        Dim ComplaintTypeJ_Validity As String = ""
        Dim ComplaintTypeK_Validity As String = ""
        Dim ComplaintTypeL_Validity As String = ""
        Dim ComplaintTypeM_Validity As String = ""
        Dim ComplaintTypeN_Validity As String = ""
        Dim ComplaintTypeO_Validity As String = ""
        Dim ComplaintTypeP_Validity As String = ""
        Dim ComplaintTypeQ_Validity As String = ""
        Dim ComplaintTypeR_Validity As String = ""
        Dim ComplaintTypeS_Validity As String = ""
        Dim ComplaintTypeT_Validity As String = ""
        Dim ComplaintTypeU_Validity As String = ""
        Dim ComplaintTypeV_Validity As String = ""
        Dim ComplaintTypeW_Validity As String = ""
        Dim ComplaintTypeX_Validity As String = ""
        Dim ComplaintTypeY_Validity As String = ""
        Dim ComplaintTypeZ_Validity As String = ""
        Dim ComplaintTypeZZ_Validity As String = ""
        Dim BorrowerNumber As String = ""
        Dim BorrowerName As String = ""
        Dim QCDecisionCorrect As String = ""
        Dim QCDMCSUpdated As String = ""
        Dim QCFSAOperations As String = ""
        Dim QCeIMF As String = ""
        Dim QCSupervisorComments As String = ""
        Dim QCEmployeeComments As String = ""
        Dim Attachment1 As String = ""
        Dim Attachment2 As String = ""
        Dim Attachment3 As String = ""
        Dim ImageUpload1 As FileUpload
        Dim ImageUpload2 As FileUpload
        Dim ImageUpload3 As FileUpload
        Dim HyperLink1 As HyperLink
        Dim HyperLink2 As HyperLink
        Dim HyperLink3 As HyperLink
        Dim lblInsertConfirm As Label
        Dim lblInsertConfirm2 As Label

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
            IssueID = CType(dataItem.FindControl("lblIssueID"), Label).Text
            eIMF = CType(dataItem.FindControl("txteIMF"), TextBox).Text
            IssueStatus = CType(dataItem.FindControl("ddlIssueStatus"), DropDownList).SelectedValue
            UserID = CType(dataItem.FindControl("ddlUserID"), DropDownList).SelectedValue
            DateResolved = CType(dataItem.FindControl("txtDateResolved"), TextBox).Text
            DueDate = CType(dataItem.FindControl("txtDueDate"), TextBox).Text
            IssueDescription = CType(dataItem.FindControl("txtIssueDescription"), TextBox).Text
            Comments = CType(dataItem.FindControl("txtComments"), TextBox).Text
            Resolution = CType(dataItem.FindControl("txtResolution"), TextBox).Text
            PCACorrectiveAction = CType(dataItem.FindControl("txtPCACorrectiveAction"), TextBox).Text
            SourceOrgType = CType(dataItem.FindControl("ddlSourceOrgType"), DropDownList).SelectedValue
            AffectedOrgID = CType(dataItem.FindControl("ddlAffectedOrgID"), DropDownList).SelectedValue
            ReceivedBy = CType(dataItem.FindControl("ddlReceivedBy"), DropDownList).SelectedValue
            WrittenVerbal = CType(dataItem.FindControl("ddlWrittenVerbal"), DropDownList).SelectedValue
            Severity = CType(dataItem.FindControl("ddlSeverity"), DropDownList).SelectedValue
            CollectorFirstName = CType(dataItem.FindControl("txtCollectorFirstName"), TextBox).Text
            CollectorLastName = CType(dataItem.FindControl("txtCollectorLastName"), TextBox).Text
            ComplaintTypeA = CType(dataItem.FindControl("chkComplaintTypeA"), CheckBox).Checked
            ComplaintTypeB = CType(dataItem.FindControl("chkComplaintTypeB"), CheckBox).Checked
            ComplaintTypeC = CType(dataItem.FindControl("chkComplaintTypeC"), CheckBox).Checked
            ComplaintTypeD = CType(dataItem.FindControl("chkComplaintTypeD"), CheckBox).Checked
            ComplaintTypeE = CType(dataItem.FindControl("chkComplaintTypeE"), CheckBox).Checked
            ComplaintTypeF = CType(dataItem.FindControl("chkComplaintTypeF"), CheckBox).Checked
            ComplaintTypeG = CType(dataItem.FindControl("chkComplaintTypeG"), CheckBox).Checked
            ComplaintTypeH = CType(dataItem.FindControl("chkComplaintTypeH"), CheckBox).Checked
            ComplaintTypeI = CType(dataItem.FindControl("chkComplaintTypeI"), CheckBox).Checked
            ComplaintTypeJ = CType(dataItem.FindControl("chkComplaintTypeJ"), CheckBox).Checked
            ComplaintTypeK = CType(dataItem.FindControl("chkComplaintTypeK"), CheckBox).Checked
            ComplaintTypeL = CType(dataItem.FindControl("chkComplaintTypeL"), CheckBox).Checked
            ComplaintTypeM = CType(dataItem.FindControl("chkComplaintTypeM"), CheckBox).Checked
            ComplaintTypeN = CType(dataItem.FindControl("chkComplaintTypeN"), CheckBox).Checked
            ComplaintTypeO = CType(dataItem.FindControl("chkComplaintTypeO"), CheckBox).Checked
            ComplaintTypeP = CType(dataItem.FindControl("chkComplaintTypeP"), CheckBox).Checked
            ComplaintTypeQ = CType(dataItem.FindControl("chkComplaintTypeQ"), CheckBox).Checked
            ComplaintTypeR = CType(dataItem.FindControl("chkComplaintTypeR"), CheckBox).Checked
            ComplaintTypeS = CType(dataItem.FindControl("chkComplaintTypeS"), CheckBox).Checked
            ComplaintTypeT = CType(dataItem.FindControl("chkComplaintTypeT"), CheckBox).Checked
            ComplaintTypeU = CType(dataItem.FindControl("chkComplaintTypeU"), CheckBox).Checked
            ComplaintTypeV = CType(dataItem.FindControl("chkComplaintTypeV"), CheckBox).Checked
            ComplaintTypeW = CType(dataItem.FindControl("chkComplaintTypeW"), CheckBox).Checked
            ComplaintTypeX = CType(dataItem.FindControl("chkComplaintTypeX"), CheckBox).Checked
            ComplaintTypeY = CType(dataItem.FindControl("chkComplaintTypeY"), CheckBox).Checked
            ComplaintTypeZ = CType(dataItem.FindControl("chkComplaintTypeZ"), CheckBox).Checked
            ComplaintTypeZZ = CType(dataItem.FindControl("chkComplaintTypeZZ"), CheckBox).Checked

            ComplaintTypeA_Validity = CType(dataItem.FindControl("ddlComplaintTypeA_Validity"), DropDownList).SelectedValue
            ComplaintTypeB_Validity = CType(dataItem.FindControl("ddlComplaintTypeB_Validity"), DropDownList).SelectedValue
            ComplaintTypeC_Validity = CType(dataItem.FindControl("ddlComplaintTypeC_Validity"), DropDownList).SelectedValue
            ComplaintTypeD_Validity = CType(dataItem.FindControl("ddlComplaintTypeD_Validity"), DropDownList).SelectedValue
            ComplaintTypeE_Validity = CType(dataItem.FindControl("ddlComplaintTypeE_Validity"), DropDownList).SelectedValue
            ComplaintTypeF_Validity = CType(dataItem.FindControl("ddlComplaintTypeF_Validity"), DropDownList).SelectedValue
            ComplaintTypeG_Validity = CType(dataItem.FindControl("ddlComplaintTypeG_Validity"), DropDownList).SelectedValue
            ComplaintTypeH_Validity = CType(dataItem.FindControl("ddlComplaintTypeH_Validity"), DropDownList).SelectedValue
            ComplaintTypeI_Validity = CType(dataItem.FindControl("ddlComplaintTypeI_Validity"), DropDownList).SelectedValue
            ComplaintTypeJ_Validity = CType(dataItem.FindControl("ddlComplaintTypeJ_Validity"), DropDownList).SelectedValue
            ComplaintTypeK_Validity = CType(dataItem.FindControl("ddlComplaintTypeK_Validity"), DropDownList).SelectedValue
            ComplaintTypeL_Validity = CType(dataItem.FindControl("ddlComplaintTypeL_Validity"), DropDownList).SelectedValue
            ComplaintTypeM_Validity = CType(dataItem.FindControl("ddlComplaintTypeM_Validity"), DropDownList).SelectedValue
            ComplaintTypeN_Validity = CType(dataItem.FindControl("ddlComplaintTypeN_Validity"), DropDownList).SelectedValue
            ComplaintTypeO_Validity = CType(dataItem.FindControl("ddlComplaintTypeO_Validity"), DropDownList).SelectedValue
            ComplaintTypeP_Validity = CType(dataItem.FindControl("ddlComplaintTypeP_Validity"), DropDownList).SelectedValue
            ComplaintTypeQ_Validity = CType(dataItem.FindControl("ddlComplaintTypeQ_Validity"), DropDownList).SelectedValue
            ComplaintTypeR_Validity = CType(dataItem.FindControl("ddlComplaintTypeR_Validity"), DropDownList).SelectedValue
            ComplaintTypeS_Validity = CType(dataItem.FindControl("ddlComplaintTypeS_Validity"), DropDownList).SelectedValue
            ComplaintTypeT_Validity = CType(dataItem.FindControl("ddlComplaintTypeT_Validity"), DropDownList).SelectedValue
            ComplaintTypeU_Validity = CType(dataItem.FindControl("ddlComplaintTypeU_Validity"), DropDownList).SelectedValue
            ComplaintTypeV_Validity = CType(dataItem.FindControl("ddlComplaintTypeV_Validity"), DropDownList).SelectedValue
            ComplaintTypeW_Validity = CType(dataItem.FindControl("ddlComplaintTypeW_Validity"), DropDownList).SelectedValue
            ComplaintTypeX_Validity = CType(dataItem.FindControl("ddlComplaintTypeX_Validity"), DropDownList).SelectedValue
            ComplaintTypeY_Validity = CType(dataItem.FindControl("ddlComplaintTypeY_Validity"), DropDownList).SelectedValue
            ComplaintTypeZ_Validity = CType(dataItem.FindControl("ddlComplaintTypeZ_Validity"), DropDownList).SelectedValue
            ComplaintTypeZZ_Validity = CType(dataItem.FindControl("ddlComplaintTypeZZ_Validity"), DropDownList).SelectedValue

            BorrowerNumber = CType(dataItem.FindControl("txtBorrowerNumber"), TextBox).Text
            BorrowerName = CType(dataItem.FindControl("txtBorrowerName"), TextBox).Text

            QCDecisionCorrect = CType(dataItem.FindControl("ddlQCDecisionCorrect"), DropDownList).SelectedValue
            QCDMCSUpdated = CType(dataItem.FindControl("ddlQCDMCSUpdated"), DropDownList).SelectedValue
            QCFSAOperations = CType(dataItem.FindControl("ddlQCFSAOperations"), DropDownList).SelectedValue
            QCeIMF = CType(dataItem.FindControl("ddlQCeIMF"), DropDownList).SelectedValue
            QCSupervisorComments = CType(dataItem.FindControl("txtQCSupervisorComments"), TextBox).Text
            QCEmployeeComments = CType(dataItem.FindControl("txtQCEmployeeComments"), TextBox).Text
            Attachment1 = CType(dataItem.FindControl("ImageUpload1"), FileUpload).PostedFile.FileName
            Attachment2 = CType(dataItem.FindControl("ImageUpload2"), FileUpload).PostedFile.FileName
            Attachment3 = CType(dataItem.FindControl("ImageUpload3"), FileUpload).PostedFile.FileName
            ImageUpload1 = CType(dataItem.FindControl("ImageUpload1"), FileUpload)
            ImageUpload2 = CType(dataItem.FindControl("ImageUpload2"), FileUpload)
            ImageUpload3 = CType(dataItem.FindControl("ImageUpload3"), FileUpload)
            HyperLink1 = CType(dataItem.FindControl("HyperLink1"), HyperLink)
            HyperLink2 = CType(dataItem.FindControl("HyperLink2"), HyperLink)
            HyperLink3 = CType(dataItem.FindControl("HyperLink3"), HyperLink)
            lblInsertConfirm = CType(dataItem.FindControl("lblInsertConfirm"), Label)
            lblInsertConfirm2 = CType(dataItem.FindControl("lblInsertConfirm2"), Label)
        Next

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssueDetailPCA_Update", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IssueID", IssueID)

        If Len(eIMF) > 0 Then
            cmd.Parameters.Add("@eIMF", SqlDbType.VarChar).Value = eIMF
        Else
            cmd.Parameters.Add("@eIMF", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(IssueStatus) > 0 Then
            cmd.Parameters.Add("@IssueStatus", SqlDbType.VarChar).Value = IssueStatus
        Else
            cmd.Parameters.Add("@IssueStatus", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(UserID) > 0 Then
            cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = UserID
        Else
            cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(DateResolved) > 0 Then
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = DateResolved
        Else
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If DueDate <> "" Then
            cmd.Parameters.Add("@DueDate", SqlDbType.SmallDateTime).Value = DueDate
        Else
            cmd.Parameters.Add("@DueDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(IssueDescription) > 0 Then
            cmd.Parameters.Add("@IssueDescription", SqlDbType.VarChar).Value = IssueDescription
        Else
            cmd.Parameters.Add("@IssueDescription", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(Comments) > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = Comments
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(Resolution) > 0 Then
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = Resolution
        Else
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(PCACorrectiveAction) > 0 Then
            cmd.Parameters.Add("@PCACorrectiveAction", SqlDbType.VarChar).Value = PCACorrectiveAction
        Else
            cmd.Parameters.Add("@PCACorrectiveAction", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(SourceOrgType) > 0 Then
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = SourceOrgType
        Else
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(AffectedOrgID) > 0 Then
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = AffectedOrgID
        Else
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = DBNull.Value
        End If

        'If Len(SourceContactInfo) > 0 Then
        '    cmd.Parameters.Add("@SourceContactInfo", SqlDbType.VarChar).Value = SourceContactInfo
        'Else
        '    cmd.Parameters.Add("@SourceContactInfo", SqlDbType.VarChar).Value = DBNull.Value
        'End If

        'If Len(SourceName) > 0 Then
        '    cmd.Parameters.Add("@SourceName", SqlDbType.VarChar).Value = SourceName
        'Else
        '    cmd.Parameters.Add("@SourceName", SqlDbType.VarChar).Value = DBNull.Value
        'End If

        'If Len(Owner) > 0 Then
        '    cmd.Parameters.Add("@Owner", SqlDbType.VarChar).Value = Owner
        'Else
        '    cmd.Parameters.Add("@Owner", SqlDbType.VarChar).Value = DBNull.Value
        'End If

        If Len(ReceivedBy) > 0 Then
            cmd.Parameters.Add("@ReceivedBy", SqlDbType.VarChar).Value = ReceivedBy
        Else
            cmd.Parameters.Add("@ReceivedBy", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(WrittenVerbal) > 0 Then
            cmd.Parameters.Add("@WrittenVerbal", SqlDbType.VarChar).Value = WrittenVerbal
        Else
            cmd.Parameters.Add("@WrittenVerbal", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(Severity) > 0 Then
            cmd.Parameters.Add("@Severity", SqlDbType.VarChar).Value = Severity
        Else
            cmd.Parameters.Add("@Severity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(CollectorFirstName) > 0 Then
            cmd.Parameters.Add("@CollectorFirstName", SqlDbType.VarChar).Value = CollectorFirstName
        Else
            cmd.Parameters.Add("@CollectorFirstName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(CollectorLastName) > 0 Then
            cmd.Parameters.Add("@CollectorLastName", SqlDbType.VarChar).Value = CollectorLastName
        Else
            cmd.Parameters.Add("@CollectorLastName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@ComplaintTypeA", ComplaintTypeA)
        cmd.Parameters.AddWithValue("@ComplaintTypeB", ComplaintTypeB)
        cmd.Parameters.AddWithValue("@ComplaintTypeC", ComplaintTypeC)
        cmd.Parameters.AddWithValue("@ComplaintTypeD", ComplaintTypeD)
        cmd.Parameters.AddWithValue("@ComplaintTypeE", ComplaintTypeE)
        cmd.Parameters.AddWithValue("@ComplaintTypeF", ComplaintTypeF)
        cmd.Parameters.AddWithValue("@ComplaintTypeG", ComplaintTypeG)
        cmd.Parameters.AddWithValue("@ComplaintTypeH", ComplaintTypeH)
        cmd.Parameters.AddWithValue("@ComplaintTypeI", ComplaintTypeI)
        cmd.Parameters.AddWithValue("@ComplaintTypeJ", ComplaintTypeJ)
        cmd.Parameters.AddWithValue("@ComplaintTypeK", ComplaintTypeK)
        cmd.Parameters.AddWithValue("@ComplaintTypeL", ComplaintTypeL)
        cmd.Parameters.AddWithValue("@ComplaintTypeM", ComplaintTypeM)
        cmd.Parameters.AddWithValue("@ComplaintTypeN", ComplaintTypeN)
        cmd.Parameters.AddWithValue("@ComplaintTypeO", ComplaintTypeO)
        cmd.Parameters.AddWithValue("@ComplaintTypeP", ComplaintTypeP)
        cmd.Parameters.AddWithValue("@ComplaintTypeQ", ComplaintTypeQ)
        cmd.Parameters.AddWithValue("@ComplaintTypeR", ComplaintTypeR)
        cmd.Parameters.AddWithValue("@ComplaintTypeS", ComplaintTypeS)
        cmd.Parameters.AddWithValue("@ComplaintTypeT", ComplaintTypeT)
        cmd.Parameters.AddWithValue("@ComplaintTypeU", ComplaintTypeU)
        cmd.Parameters.AddWithValue("@ComplaintTypeV", ComplaintTypeV)
        cmd.Parameters.AddWithValue("@ComplaintTypeW", ComplaintTypeW)
        cmd.Parameters.AddWithValue("@ComplaintTypeX", ComplaintTypeX)
        cmd.Parameters.AddWithValue("@ComplaintTypeY", ComplaintTypeY)
        cmd.Parameters.AddWithValue("@ComplaintTypeZ", ComplaintTypeZ)
        cmd.Parameters.AddWithValue("@ComplaintTypeZZ", ComplaintTypeZZ)

        If Len(ComplaintTypeA_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeA_Validity", SqlDbType.VarChar).Value = ComplaintTypeA_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeA_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeB_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeB_Validity", SqlDbType.VarChar).Value = ComplaintTypeB_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeB_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeC_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeC_Validity", SqlDbType.VarChar).Value = ComplaintTypeC_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeC_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeD_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeD_Validity", SqlDbType.VarChar).Value = ComplaintTypeD_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeD_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeE_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeE_Validity", SqlDbType.VarChar).Value = ComplaintTypeE_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeE_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeF_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeF_Validity", SqlDbType.VarChar).Value = ComplaintTypeF_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeF_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeG_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeG_Validity", SqlDbType.VarChar).Value = ComplaintTypeG_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeG_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeH_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeH_Validity", SqlDbType.VarChar).Value = ComplaintTypeH_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeH_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeI_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeI_Validity", SqlDbType.VarChar).Value = ComplaintTypeI_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeI_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeJ_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeJ_Validity", SqlDbType.VarChar).Value = ComplaintTypeJ_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeJ_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeK_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeK_Validity", SqlDbType.VarChar).Value = ComplaintTypeK_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeK_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeL_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeL_Validity", SqlDbType.VarChar).Value = ComplaintTypeL_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeL_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeM_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeM_Validity", SqlDbType.VarChar).Value = ComplaintTypeM_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeM_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeN_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeN_Validity", SqlDbType.VarChar).Value = ComplaintTypeN_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeN_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeO_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeO_Validity", SqlDbType.VarChar).Value = ComplaintTypeO_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeO_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeP_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeP_Validity", SqlDbType.VarChar).Value = ComplaintTypeP_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeP_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeQ_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeQ_Validity", SqlDbType.VarChar).Value = ComplaintTypeQ_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeQ_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeR_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeR_Validity", SqlDbType.VarChar).Value = ComplaintTypeR_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeR_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeS_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeS_Validity", SqlDbType.VarChar).Value = ComplaintTypeS_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeS_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeT_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeT_Validity", SqlDbType.VarChar).Value = ComplaintTypeT_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeT_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeU_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeU_Validity", SqlDbType.VarChar).Value = ComplaintTypeU_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeU_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeV_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeV_Validity", SqlDbType.VarChar).Value = ComplaintTypeV_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeV_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeW_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeW_Validity", SqlDbType.VarChar).Value = ComplaintTypeW_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeW_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeX_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeX_Validity", SqlDbType.VarChar).Value = ComplaintTypeX_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeX_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeY_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeY_Validity", SqlDbType.VarChar).Value = ComplaintTypeY_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeY_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeZ_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeZ_Validity", SqlDbType.VarChar).Value = ComplaintTypeZ_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeZ_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ComplaintTypeZZ_Validity) > 0 Then
            cmd.Parameters.Add("@ComplaintTypeZZ_Validity", SqlDbType.VarChar).Value = ComplaintTypeZZ_Validity
        Else
            cmd.Parameters.Add("@ComplaintTypeZZ_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(BorrowerNumber) > 0 Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = BorrowerNumber
        Else
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(BorrowerName) > 0 Then
            cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = BorrowerName
        Else
            cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'QC Fields

        'QCDecisionCorrect
        If Len(QCDecisionCorrect) > 0 Then
            cmd.Parameters.Add("@QCDecisionCorrect", SqlDbType.VarChar).Value = QCDecisionCorrect
        Else
            cmd.Parameters.Add("@QCDecisionCorrect", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'QCDMCSUpdated
        If Len(QCDMCSUpdated) > 0 Then
            cmd.Parameters.Add("@QCDMCSUpdated", SqlDbType.VarChar).Value = QCDMCSUpdated
        Else
            cmd.Parameters.Add("@QCDMCSUpdated", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'QCFSAOperations
        If Len(QCFSAOperations) > 0 Then
            cmd.Parameters.Add("@QCFSAOperations", SqlDbType.VarChar).Value = QCFSAOperations
        Else
            cmd.Parameters.Add("@QCFSAOperations", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'QCeIMF
        If Len(QCeIMF) > 0 Then
            cmd.Parameters.Add("@QCeIMF", SqlDbType.VarChar).Value = QCeIMF
        Else
            cmd.Parameters.Add("@QCeIMF", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'QCSupervisorComments
        If Len(QCSupervisorComments) > 0 Then
            cmd.Parameters.Add("@QCSupervisorComments", SqlDbType.VarChar).Value = QCSupervisorComments
        Else
            cmd.Parameters.Add("@QCSupervisorComments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'QCEmployeeComments
        If Len(QCEmployeeComments) > 0 Then
            cmd.Parameters.Add("@QCEmployeeComments", SqlDbType.VarChar).Value = QCEmployeeComments
        Else
            cmd.Parameters.Add("@QCEmployeeComments", SqlDbType.VarChar).Value = DBNull.Value
        End If


        'Attachment 1
        Dim strFileNameOnly As String = ImageUpload1.PostedFile.FileName
        If strFileNameOnly.Length > 0 Then

            Dim strSaveLocation As String
            Dim rndNumber As Integer = CInt(Math.Ceiling(Rnd() * 100000))

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt|csv|png|mp3|wav|7z)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            'strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\fsaoperations\Issues\Attachments\" & strFileNameOnly
            strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & strFileNameOnly
            ImageUpload1.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = strFileNameOnly

            HyperLink1.Text = "Your file was uploaded"
        Else
            If HyperLink1.Text <> "" Then
                cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = HyperLink1.Text
            Else
                cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If

        'Attachment 2
        Dim strFileNameOnly2 As String = ImageUpload2.PostedFile.FileName
        If strFileNameOnly2.Length > 0 Then

            Dim strSaveLocation As String
            Dim rndNumber As Integer = CInt(Math.Ceiling(Rnd() * 100000))

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt|csv|png|mp3|wav|7z)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly2.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            'strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly2
            strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & strFileNameOnly2
            ImageUpload2.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = strFileNameOnly2

            HyperLink2.Text = "Your file was uploaded"
        Else
            If HyperLink2.Text <> "" Then
                cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = HyperLink2.Text
            Else
                cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If

        'Attachment 3
        Dim strFileNameOnly3 As String = ImageUpload3.PostedFile.FileName
        If strFileNameOnly3.Length > 0 Then

            Dim strSaveLocation As String
            Dim rndNumber As Integer = CInt(Math.Ceiling(Rnd() * 100000))

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt|csv|png|mp3|wav|7z)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly3.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            'strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly3
            strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & strFileNameOnly3
            ImageUpload3.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = strFileNameOnly3

            HyperLink3.Text = "Your file was uploaded"
        Else
            If HyperLink3.Text <> "" Then
                cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = HyperLink3.Text
            Else
                cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblInsertConfirm.Text = "Your issue was successfully updated"

            'Add the call to the IssueHistory table
            Dim newIssueHistory As New IssueHistory
            newIssueHistory.IssueID = IssueID
            newIssueHistory.Comments = Comments

            'Add new record to IssueHistory table
            newIssueHistory.InsertIssueHistory(IssueID, Comments, "Issue Updated")

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs)

    End Sub



    Sub dsIssueDetail_Updating(ByVal sender As Object, ByVal e As SqlDataSourceCommandEventArgs)
        'If e.Command.Parameters("FirstLineApprovalStatus").Value = "Approved" Then
        'If dsRefundID.UpdateParameters("FirstLineApprovalStatus").DefaultValue = "Approved" Then
        'e.Command.Parameters("FirstLineDateApproved").Value = Date.Today()
        'Response.Write("hello, approved")
    End Sub

    Sub btnAddAnother_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Response.Redirect("Issue_Add.aspx?IssueType=" & ddlIssueType.SelectedValue)
    End Sub

    Protected Sub Repeater1_DataBinding(sender As Object, e As EventArgs)
        'Dim ddlQCDMCSUpdated As DropDownList
        'Dim ddlQCFSAOperations As DropDownList
        'Dim ddlQCeIMF As DropDownList
        'Dim txtQCSupervisorComments As TextBox
        'Dim txtQCEmployeeComments As TextBox

        'Dim dataItem As RepeaterItem
        'For Each dataItem In Repeater1.Items
        '    ddlQCDMCSUpdated = CType(dataItem.FindControl("ddlQCDMCSUpdated"), DropDownList)
        '    ddlQCFSAOperations = CType(dataItem.FindControl("ddlQCFSAOperations"), DropDownList)
        '    ddlQCeIMF = CType(dataItem.FindControl("ddlQCeIMF"), DropDownList)
        '    txtQCSupervisorComments = CType(dataItem.FindControl("txtQCSupervisorComments"), TextBox)
        '    txtQCEmployeeComments = CType(dataItem.FindControl("txtQCEmployeeComments"), TextBox)
        'Next

        ''Make sure only admins can access the QC fields except the QCEmployeeComments
        'If Roles.IsUserInRole("Issues_Admins") = True Then
        '    'QC Fields
        '    ddlQCDMCSUpdated.Enabled = True
        '    ddlQCFSAOperations.Enabled = True
        '    ddlQCeIMF.Enabled = True
        '    txtQCSupervisorComments.Enabled = True
        '    'The QC employee response field is always enabled
        '    txtQCEmployeeComments.Enabled = True
        'Else
        '    'QC Fields
        '    ddlQCDMCSUpdated.Enabled = False
        '    ddlQCFSAOperations.Enabled = False
        '    ddlQCeIMF.Enabled = False
        '    txtQCSupervisorComments.Enabled = False
        '    'The QC employee response field is always enabled
        '    txtQCEmployeeComments.Enabled = True
        'End If
    End Sub

End Class




