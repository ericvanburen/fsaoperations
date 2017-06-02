Imports System.Data
Imports System.Data.SqlClient
Imports CallHistory

Partial Class CCM_New_FormB
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            lblUserID.Text = HttpContext.Current.User.Identity.Name

            'txtDateofReview.Text = Today()
            lblRecordStatus.Text = ""

            'Grab the previously submitted CallCenterID, if any
            If Not Request.QueryString("CallCenterID") Is Nothing Then
                Dim strCallCenterID As String = Request.QueryString("CallCenterID")
                ddlCallCenterID.SelectedValue = strCallCenterID.ToString()
                CallCenterFunction_Lookup(CInt(strCallCenterID))
            End If

            'Set the form focus to Call Center Location to get ready for the first call
            ddlCallCenterID.Focus()
        End If

    End Sub
   

    Sub btnAddCheck_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddPhoneCheck", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.AddWithValue("@DateSubmitted", Now())
        cmd.Parameters.AddWithValue("@CheckType", ddlCheckType.SelectedValue)
        cmd.Parameters.AddWithValue("@BeginTime", Today() & " " & txtBeginTime.Text)
        cmd.Parameters.AddWithValue("@EndTime", Today() & " " & txtEndTime.Text)
        cmd.Parameters.AddWithValue("@HoldTime", txtHoldTime.Text)

        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@Comments", txtComments.Text)
        Else
            cmd.Parameters.AddWithValue("@Comments", DBNull.Value)
        End If
        cmd.Parameters.AddWithValue("@Escalated", ddlEscalated.SelectedValue)
        cmd.Parameters.Add("@CheckID", SqlDbType.Int).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            Dim CheckID As String = cmd.Parameters("@CheckID").Value.ToString()
            lblRecordStatus.Text = "Your call check was successfully added.  Your Check ID is " & CheckID.ToString()
            btnAddCheck.Visible = False
            btnAddAnotherCheck.Visible = True

        Finally
            strSQLConn.Close()
        End Try

        'Rebind the page
        Page.DataBind()

    End Sub

    Sub btnAddAnotherCheck_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("Checks.aspx?CallCenterID=" & ddlCallCenterID.SelectedValue)
    End Sub

    Protected Sub CallCenterFunction_Lookup(Optional ByVal CallCenterID As Integer = 0)
        'This looks up the CallCenterFunction value from the CallCenters table based on the selected CallCenterID value
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim strCallCenterFunction As String = ""

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CallCenterFunction_Lookup", con)
        cmd.CommandType = CommandType.StoredProcedure
        If CallCenterID > 0 Then
            cmd.Parameters.AddWithValue("@CallCenterID", CallCenterID)
        Else
            cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        End If

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()

                While dr.Read()
                    strCallCenterFunction = dr("CallCenterFunction").ToString()
                    lblCallCenterFunction.Text = strCallCenterFunction
                End While
            End Using

            'set the form focus to Begin Time of Review
            txtBeginTime.Focus()
        Finally
            dr.Close()
            con.Close()
        End Try
    End Sub

End Class
