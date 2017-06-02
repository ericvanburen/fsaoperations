Imports System.Data
Imports System.Data.SqlClient

Partial Class PCA_Reports_SavedReports
    Inherits System.Web.UI.Page

    Protected Sub GridView1_OnRowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            'This section hides or shows the View link next to each saved review record
            'An empty Url value contains 18 characters "ReviewAttachments/" so any value greater than 18 has an associated
            'attachment so we need to display it

            'View Attachment Link
            Dim hypView As HyperLink = e.Row.FindControl("hypViewAttachment")
            If hypView.NavigateUrl.Length > 18 Then
                hypView.Visible = True
            Else
                hypView.Visible = False
            End If

            'Delete Attachment Link
            'Only members of the PCAReviews_Admins group have access to the delete function
            Dim hypDelete As HyperLink = e.Row.FindControl("hypDeleteAttachment")
            If Roles.IsUserInRole("PCAReviews_Admins") = True Then
                hypDelete.Visible = True
            Else
                hypDelete.Visible = False
            End If

        End If
    End Sub

    Protected Sub chkPCAID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles chkPCAID.SelectedIndexChanged
        BindGridView()
    End Sub


    Protected Sub BindGridView()
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_SearchSavedReviews", con)
        cmd.CommandType = CommandType.StoredProcedure

        If chkPCAID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In chkPCAID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@PCAID", SqlDbType.VarChar).Value = strSearchValue
        End If

        Try
            con.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Reviews")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            GridView1.DataSource = ds.Tables("Reviews").DefaultView
            GridView1.DataBind()
        Finally

        End Try
    End Sub


End Class
