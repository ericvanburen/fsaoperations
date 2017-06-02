
Partial Class Account_RecoverPassword
    Inherits System.Web.UI.Page
    ' Set the field label background color if the user name is not found. 
    Sub PasswordRecovery1_UserLookupError(ByVal sender As Object, ByVal e As System.EventArgs)
        PasswordRecovery1.LabelStyle.ForeColor = System.Drawing.Color.Red
    End Sub

    ' Reset the field label background color. 
    Sub PasswordRecovery1_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        PasswordRecovery1.LabelStyle.ForeColor = System.Drawing.Color.Black
    End Sub

    Sub PasswordRecovery1_SendingMail(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MailMessageEventArgs)

        e.Message.IsBodyHtml = False
        e.Message.Subject = "New password on Web site."

    End Sub
End Class
