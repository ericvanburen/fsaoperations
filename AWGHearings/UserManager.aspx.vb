Imports System.Data
Imports System.Data.SqlClient

Partial Class AWGHearings_UserManager
    Inherits System.Web.UI.Page

    'Dim u As MembershipUser
    Dim u As MembershipUser = Membership.GetUser()

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Bind the UserID dropdownlist with users in the DCMS Refunds role
            'cblUsers.DataSource = Roles.GetUsersInRole("AWGHearings")
            'cblUsers.DataBind()

            'u = Membership.GetUser(User.Identity.Name)
            ''lblUserKey.Text = u.ProviderUserKey
            'lblUserKey.Text = u.UserName

            'Bind All Users to the checkboxlist
            BindAllUsers()
        End If
    End Sub

    Public Sub BindAllUsers()

        'This section binds the Checkboxlist, cblUsers with all of the AWG Hearings users
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AWGHearingsConnectionString").ConnectionString)
        strSql = "p_AllUsers"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cblUsers.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            cblUsers.DataTextField = "UserID"
            cblUsers.DataValueField = "UserID"
            cblUsers.DataBind()
        Finally
            strConnection.Close()
        End Try

        'After all of the users have been bound to the checkboxlist, cblUsers, we now bind the IsActive status to the user
        BindUserIsActiveStatus()
    End Sub

    Sub BindUserIsActiveStatus()
        'This binds all AWG Hearings users to the checkboxlist cblUsers and their IsActive status for each    
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AWGHearingsConnectionString").ConnectionString)
        strSql = "p_AllUsers"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()

            While dr.Read()
                Dim currentCheckBox As ListItem = cblUsers.Items.FindByValue(dr("UserID"))
                If dr("IsActive") = True Then
                    currentCheckBox.Selected = True
                Else
                    currentCheckBox.Selected = False
                End If
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub

    Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs)
        'First clear the IsActive status for every user regardless if they are checked
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AWGHearingsConnectionString").ConnectionString)
        strSql = "p_ClearUserStatus"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure

        strConnection.Open()
        cmd.Connection = strConnection
        cmd.ExecuteNonQuery()
        strConnection.Close()

        'Now update the IsActive status for all users if they are checked
        For ctr = 0 To cblUsers.Items.Count - 1
            If cblUsers.Items(ctr).Selected Then
                UpdateUser(cblUsers.SelectedValue, 1)
            End If
        Next
    End Sub


    

    Sub UpdateUser(ByVal UserID As String, ByVal IsActive As Boolean)

        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("AWGHearingsConnectionString").ConnectionString)
        strSql = "p_UpdateUserStatus"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure

        strConnection.Open()
        cmd.Connection = strConnection
        cmd.Parameters.AddWithValue("@UserID", UserID)
        cmd.Parameters.AddWithValue("@IsActive", IsActive)
        cmd.ExecuteNonQuery()
        strConnection.Close()
    End Sub

End Class
