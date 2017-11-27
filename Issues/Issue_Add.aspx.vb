Imports System.Data
Imports System.Data.SqlClient
Imports IssueHistory
Imports System.IO

Partial Class Issues_Issue_Add
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            'Grab the previously submitted Issue Type, if any
            'If Not Request.QueryString("IssueType") Is Nothing Then
            'Dim strIssueType As String = Request.QueryString(0)
            'ddlIssueType.SelectedValue = strIssueType.ToString()
            'End If

            'Dim strLoanAnalyst As String = HttpContext.Current.User.Identity.Name
            ddlUserID.DataSource = Roles.GetUsersInRole("Issues")
            ddlUserID.DataBind()

            'Assign the issue to the person logged in by default
            If User.Identity.IsAuthenticated Then
                ddlUserID.SelectedValue = User.Identity.Name
            End If

            'Set the Date Received field to current date + 1
            Dim DateReceived As Date = Date.Now.ToShortDateString()    ' Current date and time.
            'txtDateReceived.Text = DateReceived.AddDays(1)  ' Increment by 1 days.
            txtDateReceived.Text = Date.Now.ToShortDateString()

        End If
    End Sub

    Protected Sub ddlIssueType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlIssueType.SelectedIndexChanged
        'If ddlIssueType.SelectedValue = "PCA" Then
        '    Dim DateReceived As Date = Date.Now.ToShortDateString()    ' Current date and time.
        '    txtDateReceived.Text = DateReceived.AddDays(1)  ' Increment by 1 days.

        '    Dim DateEntered As Date = txtDateReceived.Text 'Get the date entered by the user
        '    DateEntered = DateEntered.AddDays(1)           'Increment by 1 day.

        '    Dim DueDate As Date = DateEntered       'Get the current date
        '    DueDate = DateEntered.AddDays(20)       'Increment by 20 days
        '    txtDueDate.Text = DueDate

        '    'Change datasource for ddlAffectedOrg
        '    ddlAffectedOrgID.DataSourceID = "dsAffectedOrgPCA"
        '    ddlAffectedOrgID.DataBind()
        'End If

    End Sub


    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strIssueType As String
        strIssueType = ddlIssueType.SelectedValue

        Dim DateEntered As Date = txtDateReceived.Text 'Get the date entered by the user
        DateEntered = DateEntered.AddDays(1)           'Increment by 1 day.

        Dim DueDate As Date = DateEntered       'Get the current date
        DueDate = DateEntered.AddDays(20)       'Increment by 20 days

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssueInsertNew", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IssueType", strIssueType)
        cmd.Parameters.AddWithValue("@DateEntered", DateEntered)
        cmd.Parameters.AddWithValue("@DateReceived", txtDateReceived.Text)
        cmd.Parameters.AddWithValue("@EnteredBy", User.Identity.Name.ToString())
        cmd.Parameters.AddWithValue("@IssueStatus", ddlIssueStatus.SelectedValue)

        If ddlValidationRequired.SelectedValue <> "" Then
            cmd.Parameters.Add("@ValidationRequired", SqlDbType.VarChar).Value = ddlValidationRequired.SelectedValue
        Else
            cmd.Parameters.Add("@ValidationRequired", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtValidationAccounts.Text <> "" Then
            cmd.Parameters.Add("@ValidationAccounts", SqlDbType.VarChar).Value = txtValidationAccounts.Text
        Else
            cmd.Parameters.Add("@ValidationAccounts", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@UserID", ddlUserID.SelectedValue) '<!--Assigned To-->

        If txtDateResolved.Text <> "" Then
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = txtDateResolved.Text
        Else
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@DueDate", DueDate)

        If txtFollowupDate.Text <> "" Then
            cmd.Parameters.Add("@FollowupDate", SqlDbType.SmallDateTime).Value = txtFollowupDate.Text
        Else
            cmd.Parameters.Add("@FollowupDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If ddlCategoryID.SelectedValue <> "" Then
            cmd.Parameters.Add("@CategoryID", SqlDbType.Int).Value = ddlCategoryID.SelectedValue
        Else
            cmd.Parameters.Add("@CategoryID", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlSubCategoryID.SelectedValue <> "" Then
            cmd.Parameters.Add("@SubCategoryID", SqlDbType.Int).Value = ddlSubCategoryID.SelectedValue
        Else
            cmd.Parameters.Add("@SubCategoryID", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddlFSAGroup.SelectedValue <> "" Then
            cmd.Parameters.Add("@FSAGroup", SqlDbType.VarChar).Value = ddlFSAGroup.SelectedValue
        Else
            cmd.Parameters.Add("@FSAGroup", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Issue Description
        If txtIssueDescription.Text <> "" Then
            cmd.Parameters.Add("@IssueDescription", SqlDbType.VarChar).Value = txtIssueDescription.Text
        Else
            cmd.Parameters.Add("@IssueDescription", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Comments
        If txtComments.Text <> "" Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Resolution
        If txtResolution.Text <> "" Then
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = txtResolution.Text
        Else
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Source Org Type
        If ddlSourceOrgType.SelectedValue <> "" Then
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = ddlSourceOrgType.SelectedValue
        Else
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Source Org Name (ID)
        If ddlSourceOrgID.SelectedValue <> "" Then
            cmd.Parameters.Add("@SourceOrgID", SqlDbType.VarChar).Value = ddlSourceOrgID.SelectedValue
        Else
            cmd.Parameters.Add("@SourceOrgID", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Source Name
        If txtSourceName.Text <> "" Then
            cmd.Parameters.Add("@SourceName", SqlDbType.VarChar).Value = txtSourceName.Text
        Else
            cmd.Parameters.Add("@SourceName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Owner
        If txtOwner.Text <> "" Then
            cmd.Parameters.Add("@Owner", SqlDbType.VarChar).Value = txtOwner.Text
        Else
            cmd.Parameters.Add("@Owner", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Root Cause
        If ddlRootCause.SelectedValue <> "" Then
            cmd.Parameters.Add("@RootCause", SqlDbType.VarChar).Value = ddlRootCause.SelectedValue
        Else
            cmd.Parameters.Add("@RootCause", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Sub Root Cause 
        If ddlSubRootCause.SelectedValue <> "" Then
            cmd.Parameters.Add("@SubRootCause", SqlDbType.VarChar).Value = ddlSubRootCause.SelectedValue
        Else
            cmd.Parameters.Add("@SubRootCause", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Affected Org
        If ddlAffectedOrgID.SelectedValue <> "" Then
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = ddlAffectedOrgID.SelectedValue
        Else
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = DBNull.Value
        End If

        'Source Contact Info
        If txtSourceContactInfo.Text <> "" Then
            cmd.Parameters.Add("@SourceContactInfo", SqlDbType.VarChar).Value = txtSourceContactInfo.Text
        Else
            cmd.Parameters.Add("@SourceContactInfo", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Borrower Number
        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        Else
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Borrower Name
        If txtBorrowerName.Text <> "" Then
            cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = txtBorrowerName.Text
        Else
            cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Borrower Email
        If txtBorrowerEmail.Text <> "" Then
            cmd.Parameters.Add("@BorrowerEmail", SqlDbType.VarChar).Value = txtBorrowerEmail.Text
        Else
            cmd.Parameters.Add("@BorrowerEmail", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'School Name
        If txtBorrowerName.Text <> "" Then
            cmd.Parameters.Add("@SchoolName", SqlDbType.VarChar).Value = txtSchoolName.Text
        Else
            cmd.Parameters.Add("@SchoolName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Borrower/School Name
        If txtBorrowerSchoolPhone.Text <> "" Then
            cmd.Parameters.Add("@BorrowerSchoolPhone", SqlDbType.VarChar).Value = txtBorrowerSchoolPhone.Text
        Else
            cmd.Parameters.Add("@BorrowerSchoolPhone", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Responsible Area
        If ddlResponsibleArea.SelectedValue <> "" Then
            cmd.Parameters.Add("@ResponsibleArea", SqlDbType.VarChar).Value = ddlResponsibleArea.SelectedValue
        Else
            cmd.Parameters.Add("@ResponsibleArea", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'CR Number
        If txtCRNumber.Text <> "" Then
            cmd.Parameters.Add("@CRNumber", SqlDbType.VarChar).Value = txtCRNumber.Text
        Else
            cmd.Parameters.Add("@CRNumber", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Ultimate Source Type
        If ddlUltimateSourceType.SelectedValue <> "" Then
            cmd.Parameters.Add("@UltimateSourceType", SqlDbType.VarChar).Value = ddlUltimateSourceType.SelectedValue
        Else
            cmd.Parameters.Add("@UltimateSourceType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Ultimate Source Name
        If txtUltimateSourceName.Text <> "" Then
            cmd.Parameters.Add("@UltimateSourceName", SqlDbType.VarChar).Value = txtUltimateSourceName.Text
        Else
            cmd.Parameters.Add("@UltimateSourceName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        '# Borrowers Rating
        If ddlRatingBorrowers.SelectedValue <> "" Then
            cmd.Parameters.Add("@RatingBorrowers", SqlDbType.Int).Value = ddlRatingBorrowers.SelectedValue
        Else
            cmd.Parameters.Add("@RatingBorrowers", SqlDbType.Int).Value = DBNull.Value
        End If

        'Borrowers Affected
        If txtBorrowersAffected.Text <> "" Then
            cmd.Parameters.Add("@BorrowersAffected", SqlDbType.Int).Value = txtBorrowersAffected.Text
        Else
            cmd.Parameters.Add("@BorrowersAffected", SqlDbType.Int).Value = DBNull.Value
        End If

        '# Loans Rating
        If ddlRatingLoans.SelectedValue <> "" Then
            cmd.Parameters.Add("@RatingLoans", SqlDbType.Int).Value = ddlRatingLoans.SelectedValue
        Else
            cmd.Parameters.Add("@RatingLoans", SqlDbType.Int).Value = DBNull.Value
        End If

        'Loans Affected
        If txtLoansAffected.Text <> "" Then
            cmd.Parameters.Add("@LoansAffected", SqlDbType.Int).Value = txtLoansAffected.Text
        Else
            cmd.Parameters.Add("@LoansAffected", SqlDbType.Int).Value = DBNull.Value
        End If

        'Financial Rating
        If ddlRatingFinancial.SelectedValue <> "" Then
            cmd.Parameters.Add("@RatingFinancial", SqlDbType.Int).Value = ddlRatingFinancial.SelectedValue
        Else
            cmd.Parameters.Add("@RatingFinancial", SqlDbType.Int).Value = DBNull.Value
        End If

        'Financial Impact
        If txtFinancialImpact.Text <> "" Then
            cmd.Parameters.Add("@FinancialImpact", SqlDbType.VarChar).Value = txtFinancialImpact.Text
        Else
            cmd.Parameters.Add("@FinancialImpact", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'AffectFFEL
        If ddlAffectFFEL.SelectedValue <> "" Then
            cmd.Parameters.Add("@AffectFFEL", SqlDbType.VarChar).Value = ddlAffectFFEL.SelectedValue
        Else
            cmd.Parameters.Add("@AffectFFEL", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'SMETopic
        If ddlSMETopic.SelectedValue <> "" Then
            cmd.Parameters.Add("@SMETopic", SqlDbType.VarChar).Value = ddlSMETopic.SelectedValue
        Else
            cmd.Parameters.Add("@SMETopic", SqlDbType.VarChar).Value = DBNull.Value
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

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\fsaoperations\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly
            ImageUpload1.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = strFileNameOnly
            lblAttachment1.Text = "Your file was uploaded"
        Else
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = DBNull.Value
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

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\fsaoperations\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly2
            'strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly2
            ImageUpload2.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = strFileNameOnly2
            lblAttachment2.Text = "Your file was uploaded"
        Else
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = DBNull.Value
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

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\fsaoperations\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly3
            strSaveLocation = "D:\DCS\fsaoperations\internal\Issues\Attachments\" & rndNumber & "_" & strFileNameOnly3
            ImageUpload3.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = strFileNameOnly3
            lblAttachment3.Text = "Your file was uploaded"
        Else
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.Add("@IssueID", SqlDbType.Int).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            Dim IssueID As String = cmd.Parameters("@IssueID").Value.ToString()
            lblInsertConfirm.Text = "Your issue was successfully submitted. Your Issue ID is " & IssueID.ToString()

            btnSubmit.Visible = False
            btnAddAnother.Visible = True

            'Add the call to the IssueHistory table
            Dim newIssueHistory As New IssueHistory
            newIssueHistory.IssueID = IssueID
            newIssueHistory.Comments = txtComments.Text

            'Add new record to IssueHistory table
            newIssueHistory.InsertIssueHistory(IssueID, txtComments.Text, "Issue Added")

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnAddAnother_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("Issue_Add.aspx?IssueType=" & ddlIssueType.SelectedValue)
    End Sub

    Sub ChangeAffectedOrgDataSource()
        Dim strIssueType As String = ddlIssueType.SelectedValue
        If strIssueType = "PCA" Then
            'lblIssueType.Text = "Enter New PCA Issue"
            dsAffectedOrg.SelectCommand = "p_AllAffectedOrg_PCA"
            'dsAffectedOrg.DataBind()
            'ddlAffectedOrgID.DataBind()
        ElseIf strIssueType = "Liaisons" Then
            'lblIssueType.Text = "Enter New Liaison Issue"
            dsAffectedOrg.SelectCommand = "p_AllAffectedOrg_Servicer"
            'dsAffectedOrg.DataBind()
            'ddlAffectedOrgID.DataBind()
        ElseIf strIssueType = "Call Center" Then
            'lblIssueType.Text = "Enter New Call Center Branch Issue"
            dsAffectedOrg.SelectCommand = "p_AllAffectedOrg"
            'dsAffectedOrg.DataBind()
            'ddlAffectedOrgID.DataBind()
        ElseIf strIssueType = "Escalated" Then
            'lblIssueType.Text = "Enter New Escalated Issue"
            dsAffectedOrg.SelectCommand = "p_AllAffectedOrg"
            'dsAffectedOrg.DataBind()
            'ddlAffectedOrgID.DataBind()
        Else
            dsAffectedOrg.SelectCommand = "p_AllAffectedOrg"
            'dsAffectedOrg.DataBind()
            'ddlAffectedOrgID.DataBind()
        End If
    End Sub

End Class