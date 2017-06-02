Imports System.Data
Imports System.Data.SqlClient
Imports IssueHistory
Imports System.IO
Imports FormatParagraph

Partial Class Issues_Issue_Update
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
        cmd = New SqlCommand("p_IssueDetail", strSQLConn)
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
        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
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

            If strIssueType = "Liaisons" Then
                lblIssueType.Text = "Update Liaison Issue"
            ElseIf strIssueType = "Call Center" Then
                lblIssueType.Text = "Update Call Center Branch Issue"
            ElseIf strIssueType = "Escalated" Then
                lblIssueType.Text = "Update Escalated Issue"
            Else
                lblIssueType.Text = "Select Issue Type"
            End If
        Next
    End Sub

    Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim IssueID As Integer
        Dim IssueType As String = ""
        Dim DateReceived As Date
        Dim IssueStatus As String = ""
        Dim ValidationRequired As String = ""
        Dim ValidationAccounts As String = ""
        Dim UserID As String = ""
        Dim DateResolved As String = ""
        Dim DueDate As String = ""
        Dim FollowupDate As String = ""
        Dim CategoryID As String = ""
        Dim SubCategoryID As String = ""
        Dim FSAGroup As String = ""
        Dim IssueDescription As String = ""
        Dim Comments As String = ""
        Dim Resolution As String = ""
        Dim SourceOrgType As String = ""
        Dim SourceOrgID As String = ""
        Dim RootCause As String = ""
        Dim SubRootCause As String = ""
        Dim AffectedOrgID As String = ""
        Dim SourceContactInfo As String = ""
        Dim SourceName As String = ""
        Dim Owner As String = ""
        Dim BorrowerNumber As String = ""
        Dim BorrowerName As String = ""
        Dim BorrowerEmail As String = ""
        Dim SchoolName As String = ""
        Dim BorrowerSchoolPhone As String = ""
        Dim ResponsibleArea As String = ""
        Dim CRNumber As String = ""
        Dim UltimateSourceType As String = ""
        Dim UltimateSourceName As String = ""
        Dim RatingBorrowers As String = ""
        Dim BorrowersAffected As String = ""
        Dim RatingLoans As String = ""
        Dim LoansAffected As String = ""
        Dim RatingFinancial As String = ""
        Dim FinancialImpact As String = ""
        Dim AffectFFEL As String = ""
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
            IssueType = CType(dataItem.FindControl("ddlIssueType"), DropDownList).SelectedValue
            DateReceived = CType(dataItem.FindControl("txtDateReceived"), TextBox).Text
            IssueStatus = CType(dataItem.FindControl("ddlIssueStatus"), DropDownList).SelectedValue
            ValidationRequired = CType(dataItem.FindControl("ddlValidationRequired"), DropDownList).SelectedValue
            ValidationAccounts = CType(dataItem.FindControl("txtValidationAccounts"), TextBox).Text
            UserID = CType(dataItem.FindControl("ddlUserID"), DropDownList).SelectedValue
            DateResolved = CType(dataItem.FindControl("txtDateResolved"), TextBox).Text
            DueDate = CType(dataItem.FindControl("txtDueDate"), TextBox).Text
            FollowupDate = CType(dataItem.FindControl("txtFollowupDate"), TextBox).Text
            CategoryID = TryCast(dataItem.FindControl("ddlCategoryID"), DropDownList).SelectedValue
            SubCategoryID = CType(dataItem.FindControl("ddlSubCategoryID"), DropDownList).SelectedValue
            FSAGroup = CType(dataItem.FindControl("ddlFSAGroup"), DropDownList).SelectedValue
            IssueDescription = CType(dataItem.FindControl("txtIssueDescription"), TextBox).Text
            Comments = CType(dataItem.FindControl("txtComments"), TextBox).Text
            Resolution = CType(dataItem.FindControl("txtResolution"), TextBox).Text
            SourceOrgType = CType(dataItem.FindControl("ddlSourceOrgType"), DropDownList).SelectedValue
            SourceOrgID = CType(dataItem.FindControl("ddlSourceOrgID"), DropDownList).SelectedValue
            RootCause = CType(dataItem.FindControl("ddlRootCause"), DropDownList).SelectedValue
            SubRootCause = CType(dataItem.FindControl("ddlSubRootCause"), DropDownList).SelectedValue
            AffectedOrgID = CType(dataItem.FindControl("ddlAffectedOrgID"), DropDownList).SelectedValue
            SourceContactInfo = CType(dataItem.FindControl("txtSourceContactInfo"), TextBox).Text
            SourceName = CType(dataItem.FindControl("txtSourceName"), TextBox).Text
            Owner = CType(dataItem.FindControl("txtOwner"), TextBox).Text
          
            BorrowerNumber = CType(dataItem.FindControl("txtBorrowerNumber"), TextBox).Text
            BorrowerName = CType(dataItem.FindControl("txtBorrowerName"), TextBox).Text
            BorrowerEmail = CType(dataItem.FindControl("txtBorrowerEmail"), TextBox).Text
            SchoolName = CType(dataItem.FindControl("txtSchoolName"), TextBox).Text
            BorrowerSchoolPhone = CType(dataItem.FindControl("txtBorrowerSchoolPhone"), TextBox).Text
            ResponsibleArea = CType(dataItem.FindControl("ddlResponsibleArea"), DropDownList).SelectedValue
            CRNumber = CType(dataItem.FindControl("txtCRNumber"), TextBox).Text
            UltimateSourceType = CType(dataItem.FindControl("ddlUltimateSourceType"), DropDownList).SelectedValue
            UltimateSourceName = CType(dataItem.FindControl("txtUltimateSourceName"), TextBox).Text
            RatingBorrowers = CType(dataItem.FindControl("ddlRatingBorrowers"), DropDownList).SelectedValue
            BorrowersAffected = CType(dataItem.FindControl("txtBorrowersAffected"), TextBox).Text
            RatingLoans = CType(dataItem.FindControl("ddlRatingLoans"), DropDownList).SelectedValue
            LoansAffected = CType(dataItem.FindControl("txtLoansAffected"), TextBox).Text
            RatingFinancial = CType(dataItem.FindControl("ddlRatingFinancial"), DropDownList).SelectedValue
            FinancialImpact = CType(dataItem.FindControl("txtFinancialImpact"), TextBox).Text
            AffectFFEL = CType(dataItem.FindControl("ddlAffectFFEL"), DropDownList).SelectedValue
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
        cmd = New SqlCommand("p_IssueDetail_Update", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IssueID", IssueID)

        If Len(IssueType) > 0 Then
            cmd.Parameters.Add("@IssueType", SqlDbType.VarChar).Value = IssueType
        Else
            cmd.Parameters.Add("@IssueType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(DateReceived) > 0 Then
            cmd.Parameters.Add("@DateReceived", SqlDbType.SmallDateTime).Value = DateReceived
        Else
            cmd.Parameters.Add("@DateReceived", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(IssueStatus) > 0 Then
            cmd.Parameters.Add("@IssueStatus", SqlDbType.VarChar).Value = IssueStatus
        Else
            cmd.Parameters.Add("@IssueStatus", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ValidationRequired) > 0 Then
            cmd.Parameters.Add("@ValidationRequired", SqlDbType.VarChar).Value = ValidationRequired
        Else
            cmd.Parameters.Add("@ValidationRequired", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ValidationAccounts) > 0 Then
            cmd.Parameters.Add("@ValidationAccounts", SqlDbType.VarChar).Value = ValidationAccounts
        Else
            cmd.Parameters.Add("@ValidationAccounts", SqlDbType.VarChar).Value = DBNull.Value
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

        If FollowupDate <> "" Then
            cmd.Parameters.Add("@FollowupDate", SqlDbType.SmallDateTime).Value = FollowupDate
        Else
            cmd.Parameters.Add("@FollowupDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(CategoryID) > 0 Then
            cmd.Parameters.Add("@CategoryID", SqlDbType.Int).Value = CategoryID
        Else
            cmd.Parameters.Add("@CategoryID", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(SubCategoryID) > 0 Then
            cmd.Parameters.Add("@SubCategoryID", SqlDbType.Int).Value = SubCategoryID
        Else
            cmd.Parameters.Add("@SubCategoryID", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(FSAGroup) > 0 Then
            cmd.Parameters.Add("@FSAGroup", SqlDbType.VarChar).Value = FSAGroup
        Else
            cmd.Parameters.Add("@FSAGroup", SqlDbType.VarChar).Value = DBNull.Value
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

        If Len(SourceOrgType) > 0 Then
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = SourceOrgType
        Else
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(SourceOrgID) > 0 Then
            cmd.Parameters.Add("@SourceOrgID", SqlDbType.Int).Value = SourceOrgID
        Else
            cmd.Parameters.Add("@SourceOrgID", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(RootCause) > 0 Then
            cmd.Parameters.Add("@RootCause", SqlDbType.VarChar).Value = RootCause
        Else
            cmd.Parameters.Add("@RootCause", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(SubRootCause) > 0 Then
            cmd.Parameters.Add("@SubRootCause", SqlDbType.VarChar).Value = SubRootCause
        Else
            cmd.Parameters.Add("@SubRootCause", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(AffectedOrgID) > 0 Then
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = AffectedOrgID
        Else
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(SourceContactInfo) > 0 Then
            cmd.Parameters.Add("@SourceContactInfo", SqlDbType.VarChar).Value = SourceContactInfo
        Else
            cmd.Parameters.Add("@SourceContactInfo", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(SourceName) > 0 Then
            cmd.Parameters.Add("@SourceName", SqlDbType.VarChar).Value = SourceName
        Else
            cmd.Parameters.Add("@SourceName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(Owner) > 0 Then
            cmd.Parameters.Add("@Owner", SqlDbType.VarChar).Value = Owner
        Else
            cmd.Parameters.Add("@Owner", SqlDbType.VarChar).Value = DBNull.Value
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

        If Len(BorrowerEmail) > 0 Then
            cmd.Parameters.Add("@BorrowerEmail", SqlDbType.VarChar).Value = BorrowerEmail
        Else
            cmd.Parameters.Add("@BorrowerEmail", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(SchoolName) > 0 Then
            cmd.Parameters.Add("@SchoolName", SqlDbType.VarChar).Value = SchoolName
        Else
            cmd.Parameters.Add("@SchoolName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(BorrowerSchoolPhone) > 0 Then
            cmd.Parameters.Add("@BorrowerSchoolPhone", SqlDbType.VarChar).Value = BorrowerSchoolPhone
        Else
            cmd.Parameters.Add("@BorrowerSchoolPhone", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ResponsibleArea) > 0 Then
            cmd.Parameters.Add("@ResponsibleArea", SqlDbType.VarChar).Value = ResponsibleArea
        Else
            cmd.Parameters.Add("@ResponsibleArea", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(CRNumber) > 0 Then
            cmd.Parameters.Add("@CRNumber", SqlDbType.VarChar).Value = CRNumber
        Else
            cmd.Parameters.Add("@CRNumber", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(UltimateSourceType) > 0 Then
            cmd.Parameters.Add("@UltimateSourceType", SqlDbType.VarChar).Value = UltimateSourceType
        Else
            cmd.Parameters.Add("@UltimateSourceType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(UltimateSourceName) > 0 Then
            cmd.Parameters.Add("@UltimateSourceName", SqlDbType.VarChar).Value = UltimateSourceName
        Else
            cmd.Parameters.Add("@UltimateSourceName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(RatingBorrowers) > 0 Then
            cmd.Parameters.Add("@RatingBorrowers", SqlDbType.Int).Value = RatingBorrowers
        Else
            cmd.Parameters.Add("@RatingBorrowers", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(BorrowersAffected) > 0 Then
            cmd.Parameters.Add("@BorrowersAffected", SqlDbType.VarChar).Value = BorrowersAffected
        Else
            cmd.Parameters.Add("@BorrowersAffected", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(RatingLoans) > 0 Then
            cmd.Parameters.Add("@RatingLoans", SqlDbType.Int).Value = RatingLoans
        Else
            cmd.Parameters.Add("@RatingLoans", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(LoansAffected) > 0 Then
            cmd.Parameters.Add("@LoansAffected", SqlDbType.VarChar).Value = LoansAffected
        Else
            cmd.Parameters.Add("@LoansAffected", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(RatingFinancial) > 0 Then
            cmd.Parameters.Add("@RatingFinancial", SqlDbType.Int).Value = RatingFinancial
        Else
            cmd.Parameters.Add("@RatingFinancial", SqlDbType.Int).Value = DBNull.Value
        End If

        If Len(FinancialImpact) > 0 Then
            cmd.Parameters.Add("@FinancialImpact", SqlDbType.VarChar).Value = FinancialImpact
        Else
            cmd.Parameters.Add("@FinancialImpact", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(AffectFFEL) > 0 Then
            cmd.Parameters.Add("@AffectFFEL", SqlDbType.VarChar).Value = AffectFFEL
        Else
            cmd.Parameters.Add("@AffectFFEL", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Attachment 1
        Dim strFileNameOnly As String = ImageUpload1.PostedFile.FileName
        If strFileNameOnly.Length > 0 Then

            Dim strSaveLocation As String
            Dim rndNumber As Integer = CInt(Math.Ceiling(Rnd() * 100000))

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt|csv|png|7z)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly
            ImageUpload1.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = rndNumber & "_" & strFileNameOnly

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
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt|csv|png|7z)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly2.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly2
            'strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly2
            ImageUpload2.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = rndNumber & "_" & strFileNameOnly2

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
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt|csv|png|7z)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly3.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly3
            'strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly3
            ImageUpload3.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = rndNumber & "_" & strFileNameOnly3

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
            lblInsertConfirm2.Text = "Your issue was successfully updated"
            'Set temporary text for file uploads

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

    Protected Sub btnUpdateComments_Click(sender As Object, e As EventArgs)
        'When the comments field in the modal popup changes we want the change saved automatically
        Dim IssueID As Integer
        Dim Comments As String = ""
        Dim Resolution As String = ""
        Dim lblInsertConfirm As Label
        Dim lblUpdateCommentsStatus As Label

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
            IssueID = CType(dataItem.FindControl("lblIssueID"), Label).Text
            Comments = CType(dataItem.FindControl("txtComments"), TextBox).Text
            Resolution = CType(dataItem.FindControl("txtResolution"), TextBox).Text
            lblInsertConfirm = CType(dataItem.FindControl("lblInsertConfirm"), Label)
            lblUpdateCommentsStatus = CType(dataItem.FindControl("lblUpdateCommentsStatus"), Label)
        Next

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssueDetail_Update_Comments", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IssueID", IssueID)
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

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateCommentsStatus.Text = "Your comments were updated"
        Catch ex As Exception
            lblUpdateCommentsStatus.Text = ex.ToString()

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
End Class

