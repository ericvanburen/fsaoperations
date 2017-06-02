Imports System.Data
Imports System.Data.SqlClient

Partial Class Issues_PCAComplaint_Add
    Inherits System.Web.UI.Page


    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Dim strLoanAnalyst As String = HttpContext.Current.User.Identity.Name
            ddlUserID.DataSource = Roles.GetUsersInRole("Issues_PCAComplaints")
            ddlUserID.DataBind()

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
        cmd = New SqlCommand("p_PCAComplaintInsertNew", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@DateEntered", DateEntered)
        cmd.Parameters.AddWithValue("@DateReceived", txtDateReceived.Text)
        cmd.Parameters.AddWithValue("@PCAID", ddlPCAID.SelectedValue)
        cmd.Parameters.AddWithValue("@UserID", ddlUserID.SelectedValue)
        cmd.Parameters.AddWithValue("@BorrowerNumber", txtBorrowerNumber.Text)
        cmd.Parameters.AddWithValue("@BorrowerName", txtBorrowerName.Text)
        cmd.Parameters.AddWithValue("@ReceivedBy", ddlReceivedBy.SelectedValue)
        cmd.Parameters.AddWithValue("@Source", ddlSource.SelectedValue)
        cmd.Parameters.AddWithValue("@WrittenVerbal", ddlWrittenVerbal.SelectedValue)

        If chkDCSViolationCode1.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode1", chkDCSViolationCode1.Checked)
        End If

        If chkDCSViolationCode2.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode2", chkDCSViolationCode2.Checked)
        End If

        If chkDCSViolationCode3.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode3", chkDCSViolationCode3.Checked)
        End If

        If chkDCSViolationCode4.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode4", chkDCSViolationCode4.Checked)
        End If

        If chkDCSViolationCode5.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode5", chkDCSViolationCode5.Checked)
        End If

        If chkDCSViolationCode6.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode6", chkDCSViolationCode6.Checked)
        End If

        If chkFDCPAViolationCodeA.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeA", chkFDCPAViolationCodeA.Checked)
        End If

        If chkFDCPAViolationCodeB.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeB", chkFDCPAViolationCodeB.Checked)
        End If

        If chkFDCPAViolationCodeC.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeC", chkFDCPAViolationCodeC.Checked)
        End If

        If chkFDCPAViolationCodeD.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeD", chkFDCPAViolationCodeD.Checked)
        End If
        
        If chkFDCPAViolationCodeE.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeE", chkFDCPAViolationCodeE.Checked)
        End If

        If chkFDCPAViolationCodeF.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeF", chkFDCPAViolationCodeF.Checked)
        End If

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

        If ddlSeverity.SelectedValue <> "" Then
            cmd.Parameters.Add("@Severity", SqlDbType.VarChar).Value = ddlSeverity.SelectedValue
        Else
            cmd.Parameters.Add("@Severity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlValidity.SelectedValue <> "" Then
            cmd.Parameters.Add("@Validity", SqlDbType.VarChar).Value = ddlValidity.SelectedValue
        Else
            cmd.Parameters.Add("@Validity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtCollectorName.Text <> "" Then
            cmd.Parameters.Add("@CollectorName", SqlDbType.VarChar).Value = txtCollectorName.Text
        Else
            cmd.Parameters.Add("@CollectorName", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtDateResolved.Text <> "" Then
            cmd.Parameters.Add("@DateResolved", SqlDbType.VarChar).Value = txtDateResolved.Text
        Else
            cmd.Parameters.Add("@DateResolved", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If ddlComplaintSource.SelectedValue <> "" Then
            cmd.Parameters.Add("@ComplaintSource", SqlDbType.VarChar).Value = ddlComplaintSource.SelectedValue
        Else
            cmd.Parameters.Add("@ComplaintSource", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtComments.Text <> "" Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If
       
        cmd.Parameters.AddWithValue("@DueDate", DueDate)

        'Attachment 1
        Dim strFileNameOnly As String = ImageUpload1.PostedFile.FileName
        If strFileNameOnly.Length > 0 Then

            Dim strSaveLocation As String

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\Eric\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PCACalls\ReviewAttachments\" & strFileNameOnly
            ImageUpload1.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Attachment 2
        Dim strFileNameOnly2 As String = ImageUpload2.PostedFile.FileName
        If strFileNameOnly2.Length > 0 Then

            Dim strSaveLocation As String

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\Eric\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly2
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PCACalls\ReviewAttachments\" & strFileNameOnly2
            ImageUpload2.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = strFileNameOnly2
        Else
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Attachment 3
        Dim strFileNameOnly3 As String = ImageUpload3.PostedFile.FileName
        If strFileNameOnly3.Length > 0 Then

            Dim strSaveLocation As String

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\Eric\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly3
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PCACalls\ReviewAttachments\" & strFileNameOnly3
            ImageUpload3.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = strFileNameOnly3
        Else
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblInsertConfirm.Text = "Your complaint was successfully submitted"
            btnSubmit.Visible = False
            btnAddAnother.Visible = True

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnAddAnother_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("PCAComplaint_Add.aspx")
    End Sub

End Class
