Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class PNoteTracker_Search
    Inherits System.Web.UI.Page

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("Search.aspx")
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PNoteTrackerConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtRequestID.Text <> "" Then
            cmd.Parameters.Add("@RequestID", SqlDbType.Int).Value = Convert.ToInt32(txtRequestID.Text)
        End If

        If txtReportDate.Text <> "" Then
            cmd.Parameters.Add("@ReportDate", SqlDbType.DateTime).Value = CDate(txtReportDate.Text)
        End If

        If txtReportDateLessThan.Text <> "" Then
            cmd.Parameters.Add("@ReportDateLessThan", SqlDbType.DateTime).Value = CDate(txtReportDateLessThan.Text)
        End If

        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.BigInt).Value = txtBorrowerNumber.Text
        End If

        If txtAccountID.Text <> "" Then
            cmd.Parameters.Add("@AccountID", SqlDbType.VarChar).Value = txtAccountID.Text
        End If

        If ddlFileHolder.SelectedValue <> "" Then
            cmd.Parameters.Add("@FileHolder", SqlDbType.VarChar).Value = ddlFileHolder.SelectedValue
        End If

        If ddlStatus.SelectedValue <> "" Then
            cmd.Parameters.Add("@Status", SqlDbType.VarChar).Value = ddlStatus.SelectedValue
        End If

        If txtDate_Request_Sent.Text <> "" Then
            cmd.Parameters.Add("@Date_Request_Sent", SqlDbType.DateTime).Value = txtDate_Request_Sent.Text
        End If

        If txtDate_Request_Sent_LessThan.Text <> "" Then
            cmd.Parameters.Add("@Date_Request_Sent_LessThan", SqlDbType.DateTime).Value = txtDate_Request_Sent_LessThan.Text
        End If


        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            GridView1.DataSource = ds.Tables("Requests").DefaultView
            GridView1.DataBind()

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub GridView1_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim strSortString = Convert.ToString(e.SortExpression) & " " & GetSortDirection(e.SortDirection)
        lblSortExpression.Text = strSortString.ToString
        'Now bind the gridview with the results
        BindGridView()
    End Sub

    Private Function GetSortDirection(ByVal column As String) As String
        ' By default, set the sort direction to ascending. 
        Dim sortDirection = "ASC"
        ' Retrieve the last column that was sorted. 
        Dim sortExpression = TryCast(ViewState("SortExpression"), String)
        If sortExpression IsNot Nothing Then
            ' Check if the same column is being sorted. 
            ' Otherwise, the default value can be returned. 
            If sortExpression = column Then
                Dim lastDirection = TryCast(ViewState("SortDirection"), String)
                If lastDirection IsNot Nothing _
                AndAlso lastDirection = "ASC" Then
                    sortDirection = "DESC"
                End If
            End If
        End If
        ' Save new values in ViewState. 
        ViewState("SortDirection") = sortDirection
        ViewState("SortExpression") = column
        Return sortDirection
    End Function

    Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        GridView1.PageIndex = e.NewPageIndex
        BindGridView()
    End Sub


End Class
