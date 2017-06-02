Imports System.Data
Imports System.Data.SqlClient

Partial Class Issues_PCAComplaintDetail
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            ddlUserID.DataSource = Roles.GetUsersInRole("Issues_PCAComplaints")
            ddlUserID.DataBind()

            Dim ComplaintID As Integer
            If Not Request.QueryString("ComplaintID") Is Nothing Then
                ComplaintID = Request.QueryString("ComplaintID")
            Else
                ComplaintID = 0
            End If
            lblComplaintID.Text = ComplaintID.ToString()
            LoadForm(ComplaintID)
        End If
    End Sub

    Sub LoadForm(ByVal ComplaintID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCAComplaintID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ComplaintID", SqlDbType.Int).Value = ComplaintID

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    If Not dr("DateReceived") Is DBNull.Value Then
                        txtDateReceived.Text = dr("DateReceived").ToString()
                    End If

                    If Not dr("Source") Is DBNull.Value Then
                        ddlSource.SelectedValue = dr("Source")
                    End If

                    If Not dr("PCAID") Is DBNull.Value Then
                        ddlPCAID.SelectedValue = dr("PCAID")
                    End If

                    If Not dr("ReceivedBy") Is DBNull.Value Then
                        ddlReceivedBy.SelectedValue = dr("ReceivedBy")
                    End If

                    If Not dr("BorrowerNumber") Is DBNull.Value Then
                        txtBorrowerNumber.Text = dr("BorrowerNumber").ToString()
                    End If

                    If Not dr("BorrowerName") Is DBNull.Value Then
                        txtBorrowerName.Text = dr("BorrowerName").ToString()
                    End If

                    If Not dr("ComplaintSource") Is DBNull.Value Then
                        ddlComplaintSource.SelectedValue = dr("ComplaintSource")
                    End If

                    If Not dr("WrittenVerbal") Is DBNull.Value Then
                        ddlWrittenVerbal.SelectedValue = dr("WrittenVerbal")
                    End If

                    If Not dr("Severity") Is DBNull.Value Then
                        ddlSeverity.SelectedValue = dr("Severity")
                    End If

                    If Not dr("CollectorName") Is DBNull.Value Then
                        txtCollectorName.Text = dr("CollectorName").ToString()
                    End If

                    If Not dr("UserID") Is DBNull.Value Then
                        ddlUserID.SelectedValue = dr("UserID")
                    End If

                    If Not dr("Validity") Is DBNull.Value Then
                        ddlValidity.SelectedValue = dr("Validity")
                    End If

                    If Not dr("DueDate") Is DBNull.Value Then
                        lblDueDate.Text = dr("DueDate").ToString()
                    End If

                    If Not dr("DateResolved") Is DBNull.Value Then
                        txtDateResolved.Text = dr("DateResolved").ToString()
                    End If

                    If Not dr("DCSViolationCode1") Is DBNull.Value Then
                        chkDCSViolationCode1.Checked = dr("DCSViolationCode1")
                    End If

                    If Not dr("DCSViolationCode2") Is DBNull.Value Then
                        chkDCSViolationCode2.Checked = dr("DCSViolationCode2")
                    End If

                    If Not dr("DCSViolationCode3") Is DBNull.Value Then
                        chkDCSViolationCode3.Checked = dr("DCSViolationCode3")
                    End If

                    If Not dr("DCSViolationCode4") Is DBNull.Value Then
                        chkDCSViolationCode4.Checked = dr("DCSViolationCode4")
                    End If

                    If Not dr("DCSViolationCode5") Is DBNull.Value Then
                        chkDCSViolationCode5.Checked = dr("DCSViolationCode5")
                    End If

                    If Not dr("DCSViolationCode6") Is DBNull.Value Then
                        chkDCSViolationCode6.Checked = dr("DCSViolationCode6")
                    End If

                    If Not dr("FDCPAViolationCodeA") Is DBNull.Value Then
                        chkFDCPAViolationCodeA.Checked = dr("FDCPAViolationCodeA")
                    End If

                    If Not dr("FDCPAViolationCodeB") Is DBNull.Value Then
                        chkFDCPAViolationCodeB.Checked = dr("FDCPAViolationCodeB")
                    End If

                    If Not dr("FDCPAViolationCodeC") Is DBNull.Value Then
                        chkFDCPAViolationCodeC.Checked = dr("FDCPAViolationCodeC")
                    End If

                    If Not dr("FDCPAViolationCodeD") Is DBNull.Value Then
                        chkFDCPAViolationCodeD.Checked = dr("FDCPAViolationCodeD")
                    End If

                    If Not dr("FDCPAViolationCodeE") Is DBNull.Value Then
                        chkFDCPAViolationCodeE.Checked = dr("FDCPAViolationCodeE")
                    End If

                    If Not dr("FDCPAViolationCodeF") Is DBNull.Value Then
                        chkFDCPAViolationCodeF.Checked = dr("FDCPAViolationCodeF")
                    End If

                    If Not dr("ComplaintTypeA") Is DBNull.Value Then
                        chkComplaintTypeA.Checked = dr("ComplaintTypeA")
                    End If

                    If Not dr("ComplaintTypeB") Is DBNull.Value Then
                        chkComplaintTypeB.Checked = dr("ComplaintTypeB")
                    End If

                    If Not dr("ComplaintTypeC") Is DBNull.Value Then
                        chkComplaintTypeC.Checked = dr("ComplaintTypeC")
                    End If

                    If Not dr("ComplaintTypeD") Is DBNull.Value Then
                        chkComplaintTypeD.Checked = dr("ComplaintTypeD")
                    End If

                    If Not dr("ComplaintTypeE") Is DBNull.Value Then
                        chkComplaintTypeE.Checked = dr("ComplaintTypeE")
                    End If

                    If Not dr("ComplaintTypeF") Is DBNull.Value Then
                        chkComplaintTypeF.Checked = dr("ComplaintTypeF")
                    End If

                    If Not dr("ComplaintTypeG") Is DBNull.Value Then
                        chkComplaintTypeG.Checked = dr("ComplaintTypeG")
                    End If

                    If Not dr("ComplaintTypeH") Is DBNull.Value Then
                        chkComplaintTypeH.Checked = dr("ComplaintTypeH")
                    End If

                    If Not dr("ComplaintTypeI") Is DBNull.Value Then
                        chkComplaintTypeI.Checked = dr("ComplaintTypeI")
                    End If

                    If Not dr("ComplaintTypeJ") Is DBNull.Value Then
                        chkComplaintTypeJ.Checked = dr("ComplaintTypeJ")
                    End If

                    If Not dr("ComplaintTypeK") Is DBNull.Value Then
                        chkComplaintTypeK.Checked = dr("ComplaintTypeK")
                    End If

                    If Not dr("ComplaintTypeL") Is DBNull.Value Then
                        chkComplaintTypeL.Checked = dr("ComplaintTypeL")
                    End If

                    If Not dr("ComplaintTypeM") Is DBNull.Value Then
                        chkComplaintTypeM.Checked = dr("ComplaintTypeM")
                    End If

                    If Not dr("ComplaintTypeN") Is DBNull.Value Then
                        chkComplaintTypeN.Checked = dr("ComplaintTypeN")
                    End If

                    If Not dr("ComplaintTypeO") Is DBNull.Value Then
                        chkComplaintTypeO.Checked = dr("ComplaintTypeO")
                    End If

                    If Not dr("ComplaintTypeP") Is DBNull.Value Then
                        chkComplaintTypeP.Checked = dr("ComplaintTypeP")
                    End If

                    If Not dr("ComplaintTypeQ") Is DBNull.Value Then
                        chkComplaintTypeQ.Checked = dr("ComplaintTypeQ")
                    End If

                    If Not dr("ComplaintTypeR") Is DBNull.Value Then
                        chkComplaintTypeR.Checked = dr("ComplaintTypeR")
                    End If

                    If Not dr("ComplaintTypeS") Is DBNull.Value Then
                        chkComplaintTypeS.Checked = dr("ComplaintTypeS")
                    End If

                    If Not dr("ComplaintTypeT") Is DBNull.Value Then
                        chkComplaintTypeT.Checked = dr("ComplaintTypeT")
                    End If

                    If Not dr("ComplaintTypeU") Is DBNull.Value Then
                        chkComplaintTypeU.Checked = dr("ComplaintTypeU")
                    End If

                    If Not dr("Comments") Is DBNull.Value Then
                        txtComments.Text = dr("Comments").ToString()
                    End If

                    hypAttachment1.NavigateUrl = "/Issues/FileHandler.ashx?fileName=" & dr("Attachment1").ToString()
                    hypAttachment1.Text = dr("Attachment1").ToString()

                    hypAttachment2.NavigateUrl = "/Issues/FileHandler.ashx?fileName=" & dr("Attachment2").ToString()
                    hypAttachment2.Text = dr("Attachment2").ToString()

                    hypAttachment3.NavigateUrl = "/Issues/FileHandler.ashx?fileName=" & dr("Attachment3").ToString()
                    hypAttachment3.Text = dr("Attachment3").ToString()

                End While
            End Using

            Page.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim DateEntered As Date = txtDateReceived.Text 'Get the date entered by the user
        DateEntered = DateEntered.AddDays(1)           'Increment by 1 day.

        Dim DueDate As Date = DateEntered       'Get the current date
        DueDate = DateEntered.AddDays(20)       'Increment by 20 days

        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdatePCAComplaintID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ComplaintID", SqlDbType.Int).Value = lblComplaintID.Text
        cmd.Parameters.Add("@DateReceived", SqlDbType.SmallDateTime).Value = txtDateReceived.Text
        cmd.Parameters.Add("@Source", SqlDbType.VarChar).Value = ddlSource.SelectedValue

        If ddlPCAID.SelectedValue <> "" Then
            cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        Else
            cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = DBNull.Value
        End If

        cmd.Parameters.Add("@ReceivedBy", SqlDbType.VarChar).Value = ddlReceivedBy.SelectedValue
        cmd.Parameters.AddWithValue("@BorrowerNumber", txtBorrowerNumber.Text)
        cmd.Parameters.AddWithValue("@BorrowerName", txtBorrowerName.Text)
        cmd.Parameters.Add("@ComplaintSource", SqlDbType.VarChar).Value = ddlComplaintSource.SelectedValue
        cmd.Parameters.AddWithValue("@WrittenVerbal", ddlWrittenVerbal.SelectedValue)
        cmd.Parameters.AddWithValue("@Severity", ddlSeverity.SelectedValue)
        cmd.Parameters.AddWithValue("@Validity", ddlValidity.SelectedValue)
        cmd.Parameters.AddWithValue("@CollectorName", txtCollectorName.Text)
        cmd.Parameters.AddWithValue("@UserID", ddlUserID.SelectedValue)

        If txtDateResolved.Text <> "" Then
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = txtDateResolved.Text
        Else
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If chkDCSViolationCode1.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode1", chkDCSViolationCode1.Checked)
        Else
            cmd.Parameters.AddWithValue("@DCSViolationCode1", False)
        End If

        If chkDCSViolationCode2.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode2", chkDCSViolationCode2.Checked)
        Else
            cmd.Parameters.AddWithValue("@DCSViolationCode2", False)
        End If

        If chkDCSViolationCode3.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode3", chkDCSViolationCode3.Checked)
        Else
            cmd.Parameters.AddWithValue("@DCSViolationCode3", False)
        End If

        If chkDCSViolationCode4.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode4", chkDCSViolationCode4.Checked)
        Else
            cmd.Parameters.AddWithValue("@DCSViolationCode4", False)
        End If

        If chkDCSViolationCode5.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode5", chkDCSViolationCode5.Checked)
        Else
            cmd.Parameters.AddWithValue("@DCSViolationCode5", False)
        End If

        If chkDCSViolationCode6.Checked = True Then
            cmd.Parameters.AddWithValue("@DCSViolationCode6", chkDCSViolationCode6.Checked)
        Else
            cmd.Parameters.AddWithValue("@DCSViolationCode6", False)
        End If

        If chkFDCPAViolationCodeA.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeA", chkFDCPAViolationCodeA.Checked)
        Else
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeA", False)
        End If

        If chkFDCPAViolationCodeB.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeB", chkFDCPAViolationCodeB.Checked)
        Else
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeB", False)
        End If

        If chkFDCPAViolationCodeC.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeC", chkFDCPAViolationCodeC.Checked)
        Else
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeC", False)
        End If

        If chkFDCPAViolationCodeD.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeD", chkFDCPAViolationCodeD.Checked)
        Else
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeD", False)
        End If

        If chkFDCPAViolationCodeE.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeE", chkFDCPAViolationCodeE.Checked)
        Else
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeE", False)
        End If

        If chkFDCPAViolationCodeF.Checked = True Then
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeF", chkFDCPAViolationCodeF.Checked)
        Else
            cmd.Parameters.AddWithValue("@FDCPAViolationCodeF", False)
        End If

        If chkComplaintTypeA.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeA", chkComplaintTypeA.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeA", False)
        End If

        If chkComplaintTypeB.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeB", chkComplaintTypeB.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeB", False)
        End If

        If chkComplaintTypeC.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeC", chkComplaintTypeC.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeC", False)
        End If

        If chkComplaintTypeD.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeD", chkComplaintTypeD.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeD", False)
        End If

        If chkComplaintTypeE.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeE", chkComplaintTypeE.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeE", False)
        End If

        If chkComplaintTypeF.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeF", chkComplaintTypeF.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeF", False)
        End If

        If chkComplaintTypeG.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeG", chkComplaintTypeG.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeG", False)
        End If

        If chkComplaintTypeH.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeH", chkComplaintTypeH.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeH", False)
        End If

        If chkComplaintTypeI.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeI", chkComplaintTypeI.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeI", False)
        End If

        If chkComplaintTypeJ.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeJ", chkComplaintTypeJ.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeJ", False)
        End If

        If chkComplaintTypeK.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeK", chkComplaintTypeK.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeK", False)
        End If

        If chkComplaintTypeL.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeL", chkComplaintTypeL.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeL", False)
        End If

        If chkComplaintTypeM.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeM", chkComplaintTypeM.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeM", False)
        End If

        If chkComplaintTypeN.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeN", chkComplaintTypeN.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeN", False)
        End If

        If chkComplaintTypeO.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeO", chkComplaintTypeO.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeO", False)
        End If

        If chkComplaintTypeP.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeP", chkComplaintTypeP.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeP", False)
        End If

        If chkComplaintTypeQ.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeQ", chkComplaintTypeQ.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeQ", False)
        End If

        If chkComplaintTypeR.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeR", chkComplaintTypeR.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeR", False)
        End If

        If chkComplaintTypeS.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeS", chkComplaintTypeS.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeS", False)
        End If

        If chkComplaintTypeT.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeT", chkComplaintTypeT.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeT", False)
        End If

        If chkComplaintTypeU.Checked = True Then
            cmd.Parameters.AddWithValue("@ComplaintTypeU", chkComplaintTypeU.Checked)
        Else
            cmd.Parameters.AddWithValue("@ComplaintTypeU", False)
        End If

        cmd.Parameters.AddWithValue("@Comments", txtComments.Text)

        cmd.Parameters.AddWithValue("@DueDate", DueDate)

        Dim UploadFileControl1 As Object
        UploadFileControl1 = ImageUpload1

        Dim UploadFileControl2 As Object
        UploadFileControl2 = ImageUpload2

        Dim UploadFileControl3 As Object
        UploadFileControl3 = ImageUpload3

        'Attachment 1
        Dim strFileNamePath As String = UploadFileControl1.PostedFile.FileName

        If strFileNamePath.Length > 0 Then

            Dim strFileNameOnly As String
            Dim strSaveLocation As String

            strFileNameOnly = System.IO.Path.GetFileName(UploadFileControl1.PostedFile.FileName)

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|gif|jpg|txt)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\Eric\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PNoteTracker\ImageUploads\" & strFileNameOnly
            UploadFileControl1.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            If hypAttachment1.Text <> "" Then
                cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = hypAttachment1.Text
            Else
                cmd.Parameters.Add("@Attachment1", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If

        'Attachment 2
        Dim strFileNamePath2 As String = UploadFileControl2.PostedFile.FileName

        If strFileNamePath2.Length > 0 Then

            Dim strFileNameOnly As String
            Dim strSaveLocation As String

            strFileNameOnly = System.IO.Path.GetFileName(UploadFileControl2.PostedFile.FileName)

            'This checks for a valid file name and type
            Dim Filename2Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|gif|jpg|txt)$")
            If Not Filename2Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\Eric\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PNoteTracker\ImageUploads\" & strFileNameOnly
            UploadFileControl2.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            If hypAttachment2.Text <> "" Then
                cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = hypAttachment2.Text
            Else
                cmd.Parameters.Add("@Attachment2", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If

        'Attachment 3
        Dim strFileNamePath3 As String = UploadFileControl3.PostedFile.FileName

        If strFileNamePath3.Length > 0 Then

            Dim strFileNameOnly As String
            Dim strSaveLocation As String

            strFileNameOnly = System.IO.Path.GetFileName(UploadFileControl3.PostedFile.FileName)

            'This checks for a valid file name and type
            Dim Filename3Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|gif|jpg|txt)$")
            If Not Filename3Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            strSaveLocation = "C:\Users\Eric\Dropbox\fsaoperations\Issues\Attachments\" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PNoteTracker\ImageUploads\" & strFileNameOnly
            UploadFileControl3.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            If hypAttachment3.Text <> "" Then
                cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = hypAttachment3.Text
            Else
                cmd.Parameters.Add("@Attachment3", SqlDbType.VarChar).Value = DBNull.Value
            End If
        End If

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your review was successfully updated"
        Finally
            con.Close()
        End Try
    End Sub
End Class
