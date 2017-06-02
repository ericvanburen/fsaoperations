﻿Imports System.Data
Imports System.Data.SqlClient

Partial Class PCACalls_AttachmentManager
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim SavedReviewID As Integer
            Dim Action As String

            If Not Request.QueryString("SavedReviewID") Is Nothing Then
                SavedReviewID = Request.QueryString("SavedReviewID")
            Else
                SavedReviewID = 0
            End If

            lblSavedReviewID.Text = SavedReviewID.ToString()

            'Action has 2 possible values Upload and Delete
            If Not Request.QueryString("Action") Is Nothing Then
                Action = Request.QueryString("Action")
            Else
                Action = "Upload"
            End If

            AttachmentAction(Action)
        End If
    End Sub

    Sub AttachmentAction(ByVal Action As String)
        If Action = "Upload" Then
            pnlUploadAttachment.Visible = True
        ElseIf Action = "Delete" Then
            pnlDeleteAttachment.Visible = True
        End If
    End Sub

    Sub btnDeleteAttachment_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteAttachment2", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SavedReviewID", SqlDbType.VarChar).Value = lblSavedReviewID.Text

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblDeleteConfirm.Text = "Your attachment was successfully deleted"

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnUploadAttachment_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strInsert As String
        Dim cmdInsert As SqlCommand
        Dim con As SqlConnection

        Dim UploadFileControl As Object
        Dim UploadMessage As Label

        UploadFileControl = Image1Upload
        UploadMessage = lblUploadMessage1

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        strInsert = "p_UploadAttachment2"
        cmdInsert = New SqlCommand(strInsert)
        cmdInsert.CommandType = CommandType.StoredProcedure
        cmdInsert.Connection = con

        cmdInsert.Parameters.AddWithValue("@SavedReviewID", SqlDbType.VarChar).Value = lblSavedReviewID.Text

        Dim strFileNamePath As String = UploadFileControl.PostedFile.FileName

        If strFileNamePath.Length > 0 Then

            Dim strFileNameOnly As String
            Dim strSaveLocation As String

            'Append the agency value before the file name
            strFileNameOnly = System.IO.Path.GetFileName(UploadFileControl.PostedFile.FileName)

            'This checks for a valid file name and type
            Dim Filename1Regex As New Regex("(doc|docx|xls|xlsx|pdf|zip|zipx)$")
            If Not Filename1Regex.IsMatch(strFileNameOnly.ToLower(), RegexOptions.IgnoreCase) Then
                Response.Redirect("invalid.filetype.aspx")
            End If

            strSaveLocation = "C:\Users\ericv_000\Dropbox\fsaoperations\PCAReviews\ReviewAttachments\" & strFileNameOnly
            'strSaveLocation = "D:\DCS\fsaoperations\internal\PCAReviews\ReviewAttachments\" & strFileNameOnly
            UploadFileControl.PostedFile.SaveAs(strSaveLocation)
            cmdInsert.Parameters.Add("@Attachment", SqlDbType.VarChar).Value = strFileNameOnly
        Else
            cmdInsert.Parameters.Add("@Attachment", SqlDbType.VarChar).Value = DBNull.Value
        End If
        Try
            con.Open()
            cmdInsert.ExecuteNonQuery()
            If strFileNamePath.Length > 0 Then
                UploadMessage.Text = "Your attachment was successfully uploaded"
            End If

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnDeleteAttachmentCancel_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("Reports2.aspx")
    End Sub

End Class
