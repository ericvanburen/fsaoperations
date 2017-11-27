Imports System.Data
Imports System.Data.SqlClient

Partial Class IBRReviews_MyAssignments
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            dsMyAssignments.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name

            'Only managers can update the QC Worksheet Date and QC Final Date fields
            If Roles.IsUserInRole("IBRReviews_Admins") = False Then
                'User is not an admin
                txtQCWorksheetDate.Enabled = False
                txtQCFinalDate.Enabled = False
                'Set a PCAAdmin user flag
                lblPCAAdmin.Text = "False"
            Else
                'User is an Admin
                lblPCAAdmin.Text = "True"

                txtQCWorksheetDate.Enabled = True
                txtQCFinalDate.Enabled = True
            End If
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            'This is for the Work Review Link - Hyperlink1
            Dim link = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
            Dim strReviewDate As String = e.Row.Cells(2).Text
            Dim strPCA As String = e.Row.Cells(3).Text
            Dim strPCAID As String = e.Row.Cells(4).Text
            Dim strReportMonth As String = e.Row.Cells(5).Text
            Dim strReportQuarter As String = e.Row.Cells(6).Text
            Dim strReportYear As String = e.Row.Cells(7).Text
            Dim strRecordingDeliveryDate As String = e.Row.Cells(8).Text
            Dim strNewAssignmentID As String = e.Row.Cells(11).Text

            link.Text = "Enter New IBR Review"
            link.NavigateUrl = "EnterNewReview.aspx?PCAID=" & strPCAID & "&ReportQuarter=" & strReportQuarter & "&ReportYear=" & strReportYear & "&ReportMonth=" & strReportMonth & "&NewAssignmentID=" & strNewAssignmentID

            'This is for the Review Calls link - Hyperlink2
            Dim link2 = DirectCast(e.Row.FindControl("HyperLink2"), HyperLink)
            link2.Text = "Review Calls"
            link2.NavigateUrl = "MyReviews.aspx?PCA=" & Server.UrlEncode(strPCA) & "&PCAID=" & strPCAID & "&NewAssignmentID=" & strNewAssignmentID

        End If

    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim intNewAssignmentID As Integer = GridView1.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(intNewAssignmentID)

        End If
    End Sub

    Protected Sub LoadModal(NewAssignmentID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim isPCAAdmin As String = lblPCAAdmin.Text.ToString()

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IBRAssignment", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@NewAssignmentID", SqlDbType.Int).Value = NewAssignmentID
        lblNewAssignmentID.Text = NewAssignmentID
        'Clear the update confirm label
        lblUpdateConfirm.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    lblPCA.Text = dr("PCA").ToString()
                    txtWorksheetPCADate.Text = dr("WorksheetPCADate").ToString()
                    txtQCWorksheetDate.Text = dr("QCWorksheetDate").ToString()
                    txtFinalPCADate.Text = dr("FinalPCADate").ToString()
                    txtQCFinalDate.Text = dr("QCFinalDate").ToString()
                    txtComments.Text = dr("Comments").ToString()

                    'PCA Admins can update all of these fields at any time. Other users can update only the WorksheetPCADate and FinalPCADate fields and only when there
                    'isn't already an existing value there
                    If isPCAAdmin = "False" Then
                        'ordinal 5 is Worksheet PCA Date
                        If dr.IsDBNull(5) Then
                            txtWorksheetPCADate.Enabled = True
                        Else
                            txtWorksheetPCADate.Enabled = False
                        End If

                        'ordinal 6 is Final PCA Date
                        If dr.IsDBNull(6) Then
                            txtFinalPCADate.Enabled = True
                        Else
                            txtFinalPCADate.Enabled = False
                        End If

                        'Non-admins can never update these two fields
                        txtQCWorksheetDate.Enabled = False
                        txtQCFinalDate.Enabled = False
                    End If
                End While
            End Using
        Finally
            con.Close()
        End Try
    End Sub


    Protected Sub btnSaveChanges_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IBRReviews_Assignments_Update_LA", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@NewAssignmentID", SqlDbType.Int).Value = lblNewAssignmentID.Text
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name

        If Len(txtWorksheetPCADate.Text) > 0 Then
            cmd.Parameters.Add("@WorksheetPCADate", SqlDbType.SmallDateTime).Value = txtWorksheetPCADate.Text
        Else
            cmd.Parameters.Add("@WorksheetPCADate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtQCWorksheetDate.Text) > 0 Then
            cmd.Parameters.Add("@QCWorksheetDate", SqlDbType.SmallDateTime).Value = txtQCWorksheetDate.Text
        Else
            cmd.Parameters.Add("@QCWorksheetDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtFinalPCADate.Text) > 0 Then
            cmd.Parameters.Add("@FinalPCADate", SqlDbType.SmallDateTime).Value = txtFinalPCADate.Text
        Else
            cmd.Parameters.Add("@FinalPCADate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtQCFinalDate.Text) > 0 Then
            cmd.Parameters.Add("@QCFinalDate", SqlDbType.SmallDateTime).Value = txtQCFinalDate.Text
        Else
            cmd.Parameters.Add("@QCFinalDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtComments.Text) > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "Your review was updated"
            lblUpdateConfirm.Visible = True
            GridView1.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

End Class
