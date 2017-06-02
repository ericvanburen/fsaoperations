Imports System.Data
Imports System.Data.SqlClient

Partial Class PCAReviews_Tracking_default
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Make sure only admins can access this page
            If Roles.IsUserInRole("PCAReviews_Admins") = False Then
                Response.Redirect("/Account/Login.aspx")
            End If

            ddlUserID.DataSource = Roles.GetUsersInRole("PCAReviews")
            ddlUserID.DataBind()
        End If
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_LetterReview_Insert", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@ReviewPeriodMonth", SqlDbType.VarChar).Value = ddlReviewPeriodMonth.SelectedValue
        cmd.Parameters.Add("@ReviewPeriodDay", SqlDbType.VarChar).Value = ddlReviewPeriodDay.SelectedValue
        cmd.Parameters.Add("@ReviewPeriodYear", SqlDbType.VarChar).Value = ddlReviewPeriodYear.SelectedValue
        cmd.Parameters.Add("@EDPASPeriod", SqlDbType.VarChar).Value = ddlEDPASPeriod.SelectedValue
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = ddlUserID.SelectedValue
        cmd.Parameters.Add("@Supervisor", SqlDbType.VarChar).Value = ddlSupervisorName.SelectedValue
        cmd.Parameters.Add("@TeamLeader", SqlDbType.VarChar).Value = ddlTeamLeader.SelectedValue

        'Attachment
        Dim strFileNameOnly As String = ImageUpload1.PostedFile.FileName
        If strFileNameOnly.Length > 0 Then

            Dim strSaveLocation As String
            Dim rndNumber As Integer = CInt(Math.Ceiling(Rnd() * 100000))

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx|gif|jpg|txt|csv|png|mp3|wav)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("InvalidFiletype.aspx")
            End If

            'strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\PCAReviews\LetterReviewAttachments\" & rndNumber & "_" & ValidFileName(strFileNameOnly)
            strSaveLocation = "D:\DCS\fsaoperations\internal\PCAReviews\LetterReviewAttachments\" & rndNumber & "_" & ValidFileName(strFileNameOnly)
            ImageUpload1.PostedFile.SaveAs(strSaveLocation)
            cmd.Parameters.Add("@Attachment", SqlDbType.VarChar).Value = rndNumber & "_" & strFileNameOnly
            lblAttachment1.Text = "Your file was uploaded"
        Else
            cmd.Parameters.Add("@Attachment", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "Your review was successfully submitted"
            btnSubmit.Visible = False
            btnSubmitAgain.Visible = True
            'Rebind the GridView below the table
            GridView1.DataBind()

        Finally
            strSQLConn.Close()
        End Try
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

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Dim FilterExpression As String = String.Concat(ddlSearchType.SelectedValue, " LIKE '%{0}%'")
        dsLALetters.FilterParameters.Clear()
        dsLALetters.FilterParameters.Add(New ControlParameter(ddlSearchType.SelectedValue, "txtSearchPhrase", "Text"))
        dsLALetters.FilterExpression = FilterExpression
        btnShowAll.Visible = True
    End Sub

    Protected Sub btnShowAll_Click(sender As Object, e As EventArgs)
        Response.Redirect("LetterReviews.aspx")
    End Sub

    Protected Sub btnSubmitAgain_Click(sender As Object, e As EventArgs)
        Response.Redirect("LetterReviews.aspx")
    End Sub

    Sub btnDeleteSavedLetter_Click(ByVal sender As Object, ByVal e As EventArgs)
        For Each row As GridViewRow In GridView1.Rows
            Dim checkbox As CheckBox = CType(row.FindControl("cbRows"), CheckBox)

            'Check if the checkbox is checked. 
            If checkbox.Checked Then
                'Retreive the LetterReviewID
                Dim LetterReviewID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected Letter Review ID to the Delete command.
                dsLALetters.DeleteParameters("LetterReviewID").DefaultValue = LetterReviewID
                dsLALetters.Delete()
            End If
        Next row

        GridView1.DataBind()
    End Sub
End Class
