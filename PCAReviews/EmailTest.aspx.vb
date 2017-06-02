Imports System.Configuration.ConfigurationManager
Imports System.Net.Mail
Imports System.Net

Partial Class PCAReviews_EmailTest
    Inherits System.Web.UI.Page


    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)


    End Sub

    Sub SendSimpleMail()

        Try
            Dim fromEmailAddress = ConfigurationManager.AppSettings("FromEmailAddress").ToString()
            Dim fromEmailDisplayName = ConfigurationManager.AppSettings("FromEmailDisplayName").ToString()
            Dim fromEmailPassword = ConfigurationManager.AppSettings("FromEmailPassword").ToString()
            Dim smtpHost = ConfigurationManager.AppSettings("SMTPHost").ToString()
            Dim smtpPort = ConfigurationManager.AppSettings("SMTPPort").ToString()

            Dim body As String = "Your registration has been done successfully. Thank you."
            Dim message As New MailMessage(New MailAddress(fromEmailAddress, fromEmailDisplayName), New MailAddress("eric.vanburen@ed.gov", "Eric Van Buren"))
            message.Subject = "Thank You For Your Registration"
            message.IsBodyHtml = True
            message.Body = body

            Dim client = New SmtpClient()
            client.Credentials = New NetworkCredential(fromEmailAddress, fromEmailPassword)
            client.Host = smtpHost
            client.EnableSsl = True
            client.Port = If(Not String.IsNullOrEmpty(smtpPort), Convert.ToInt32(smtpPort), 0)
            client.Send(message)
        Catch ex As Exception
            Throw (New Exception("Mail send failed to loginId"))
        End Try

    End Sub


End Class
