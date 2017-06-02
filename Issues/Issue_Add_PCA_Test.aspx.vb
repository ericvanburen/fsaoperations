Imports System.Data
Imports System.Data.SqlClient

Partial Class Issues_Issue_Add_PCA
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
            txtDateReceived.Text = DateReceived.AddDays(1)  ' Increment by 1 days.

        End If
    End Sub

    Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim DateEntered As Date = txtDateReceived.Text 'Get the date entered by the user
        DateEntered = DateEntered.AddDays(1)           'Increment by 1 day.

        Dim DueDate As Date = DateEntered       'Get the current date
        DueDate = DateEntered.AddDays(20)       'Increment by 20 days

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssueInsertNew", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IssueType", "PCA")
        cmd.Parameters.AddWithValue("@DateEntered", DateEntered)
        cmd.Parameters.AddWithValue("@DateReceived", txtDateReceived.Text)
        cmd.Parameters.AddWithValue("@EnteredBy", User.Identity.Name.ToString())
        cmd.Parameters.AddWithValue("@IssueStatus", ddlIssueStatus.SelectedValue)
        cmd.Parameters.AddWithValue("@UserID", ddlUserID.SelectedValue) '<!--Assigned To-->

        If txteIMF.Text <> "" Then
            cmd.Parameters.Add("@eIMF", SqlDbType.VarChar).Value = txteIMF.Text
        Else
            cmd.Parameters.Add("@eIMF", SqlDbType.VarChar).Value = DBNull.Value
        End If

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

        'Value 106 is PCA Complaint
        cmd.Parameters.Add("@CategoryID", SqlDbType.Int).Value = 108

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

        'PCA Corrective Action
        If txtPCACorrectiveAction.Text <> "" Then
            cmd.Parameters.Add("@PCACorrectiveAction", SqlDbType.VarChar).Value = txtPCACorrectiveAction.Text
        Else
            cmd.Parameters.Add("@PCACorrectiveAction", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Source Org Type
        If ddlSourceOrgType.SelectedValue <> "" Then
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = ddlSourceOrgType.SelectedValue
        Else
            cmd.Parameters.Add("@SourceOrgType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Affected Org
        If ddlAffectedOrgID.SelectedValue <> "" Then
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = ddlAffectedOrgID.SelectedValue
        Else
            cmd.Parameters.Add("@AffectedOrgID", SqlDbType.Int).Value = DBNull.Value
        End If

        'Received By
        If ddlReceivedBy.SelectedValue <> "" Then
            cmd.Parameters.Add("@ReceivedBy", SqlDbType.VarChar).Value = ddlReceivedBy.SelectedValue
        Else
            cmd.Parameters.Add("@ReceivedBy", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Written-Verbal
        If ddlWrittenVerbal.SelectedValue <> "" Then
            cmd.Parameters.Add("@WrittenVerbal", SqlDbType.VarChar).Value = ddlWrittenVerbal.SelectedValue
        Else
            cmd.Parameters.Add("@WrittenVerbal", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Severity
        If ddlSeverity.SelectedValue <> "" Then
            cmd.Parameters.Add("@Severity", SqlDbType.VarChar).Value = ddlSeverity.SelectedValue
        Else
            cmd.Parameters.Add("@Severity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Collector First Name
        If txtCollectorFirstName.Text <> "" Then
            cmd.Parameters.Add("@CollectorFirstName", SqlDbType.VarChar).Value = txtCollectorFirstName.Text
        Else
            cmd.Parameters.Add("@CollectorFirstName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Collector Last Name
        If txtCollectorFirstName.Text <> "" Then
            cmd.Parameters.Add("@CollectorLastName", SqlDbType.VarChar).Value = txtCollectorLastName.Text
        Else
            cmd.Parameters.Add("@CollectorLastName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'PCA Complaint Types
        If chkComplaintTypeA.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeA", chkComplaintTypeA.Checked)
        End If

        If chkComplaintTypeB.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeB", chkComplaintTypeB.Checked)
        End If

        If chkComplaintTypeC.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeC", chkComplaintTypeC.Checked)
        End If

        If chkComplaintTypeD.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeD", chkComplaintTypeD.Checked)
        End If

        If chkComplaintTypeE.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeE", chkComplaintTypeE.Checked)
        End If

        If chkComplaintTypeF.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeF", chkComplaintTypeF.Checked)
        End If

        If chkComplaintTypeG.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeG", chkComplaintTypeG.Checked)
        End If

        If chkComplaintTypeH.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeH", chkComplaintTypeH.Checked)
        End If

        If chkComplaintTypeI.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeI", chkComplaintTypeI.Checked)
        End If

        If chkComplaintTypeJ.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeJ", chkComplaintTypeJ.Checked)
        End If

        If chkComplaintTypeK.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeK", chkComplaintTypeK.Checked)
        End If

        If chkComplaintTypeL.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeL", chkComplaintTypeL.Checked)
        End If

        If chkComplaintTypeM.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeM", chkComplaintTypeM.Checked)
        End If

        If chkComplaintTypeN.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeN", chkComplaintTypeN.Checked)
        End If

        If chkComplaintTypeO.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeO", chkComplaintTypeO.Checked)
        End If

        If chkComplaintTypeP.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeP", chkComplaintTypeP.Checked)
        End If

        If chkComplaintTypeQ.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeQ", chkComplaintTypeQ.Checked)
        End If

        If chkComplaintTypeR.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeR", chkComplaintTypeR.Checked)
        End If

        If chkComplaintTypeS.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeS", chkComplaintTypeS.Checked)
        End If

        If chkComplaintTypeT.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeT", chkComplaintTypeT.Checked)
        End If

        If chkComplaintTypeU.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeU", chkComplaintTypeU.Checked)
        End If

        If chkComplaintTypeV.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeV", chkComplaintTypeV.Checked)
        End If

        If chkComplaintTypeW.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeW", chkComplaintTypeW.Checked)
        End If

        If chkComplaintTypeX.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeX", chkComplaintTypeX.Checked)
        End If

        If chkComplaintTypeY.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeY", chkComplaintTypeY.Checked)
        End If

        If chkComplaintTypeZ.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeZ", chkComplaintTypeZ.Checked)
        End If

        If chkComplaintTypeZZ.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeZZ", chkComplaintTypeZZ.Checked)
        End If

        'Complaint Validity Values
        If ddlComplaintTypeA_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeA_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeA_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeA_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeB_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeB_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeB_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeB_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeC_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeC_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeC_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeC_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeD_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeD_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeD_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeD_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeE_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeE_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeE_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeE_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeF_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeF_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeF_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeF_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeG_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeG_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeG_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeG_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeH_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeH_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeH_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeH_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeI_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeI_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeI_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeI_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeJ_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeJ_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeJ_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeJ_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeK_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeK_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeK_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeK_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeL_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeL_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeL_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeL_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeM_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeM_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeM_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeM_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeN_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeN_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeN_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeN_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeO_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeO_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeO_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeO_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeP_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeP_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeP_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeP_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeQ_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeQ_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeQ_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeQ_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeR_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeR_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeR_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeR_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeS_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeS_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeS_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeS_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeT_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeT_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeT_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeT_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeU_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeU_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeU_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeU_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeV_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeV_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeV_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeV_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeW_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeW_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeW_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeW_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeX_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeX_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeX_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeX_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeY_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeY_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeY_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeY_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeZ_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeZ_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeZ_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeZ_Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintTypeZZ_Validity.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintTypeZZ_Validity", SqlDbType.VarChar).Value = ddlComplaintTypeZZ_Validity.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintTypeZZ_Validity", SqlDbType.VarChar).Value = DBNull.Value
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

        'Attachment 1
        Dim strFileNameOnly As String = ImageUpload1.PostedFile.FileName
        If strFileNameOnly.Length > 0 Then
            Dim strFileNumber1 As String = lblAttachment1Number.Value
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = strFileNumber1 & "_" & strFileNameOnly
        Else
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Attachment 2
        Dim strFileNameOnly2 As String = ImageUpload2.PostedFile.FileName
        If strFileNameOnly2.Length > 0 Then
            Dim strFileNumber2 As String = lblAttachment2Number.Value
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = strFileNumber2 & "_" & strFileNameOnly2
        Else
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Attachment 3
        Dim strFileNameOnly3 As String = ImageUpload3.PostedFile.FileName
        If strFileNameOnly3.Length > 0 Then
            Dim strFileNumber3 As String = lblAttachment3Number.Value
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = strFileNumber3 & "_" & strFileNameOnly3
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
        Response.Redirect("Issue_Add_PCA.aspx")
    End Sub

    Public Function ValidFileName(name As String) As String
        Dim builder = New StringBuilder()
        Dim invalid = System.IO.Path.GetInvalidFileNameChars()
        For Each lett As Char In name
            If Not invalid.Contains(lett) Then
                builder.Append(lett)
            End If
        Next
        Return builder.ToString()
    End Function

    
    Function FormatHTML(sText)
        Dim strReturn = ""
        strReturn = Replace(strReturn, ">", "")
        strReturn = Replace(strReturn, "<", "")
        strReturn = Replace(strReturn, "'", "")
        strReturn = Replace(strReturn, "&", "")
        strReturn = Replace(strReturn, "", "")
        FormatHTML = strReturn
    End Function


End Class
