Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports Csv

Partial Class CCM2_admin_QCReview
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            ddlUserID.DataSource = Roles.GetUsersInRole("CCM")
            ddlUserID.DataBind()
        End If
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        If grdReviews.Rows.Count > 0 Then
            grdReviews.UseAccessibleHeader = True
            grdReviews.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("QCReview_Search.aspx")
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_QCSearch", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_QCSearch uses dynamic SQL so we pass a value to it only when there is one
        If txtReviewID.Text <> "" Then
            cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = Convert.ToInt32(txtReviewID.Text)
        End If

        If txtDateofReview.Text <> "" Then
            cmd.Parameters.Add("@DateofReview", SqlDbType.SmallDateTime).Value = txtDateofReview.Text
        End If

        If txtDateofReviewLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateofReviewLessThan", SqlDbType.SmallDateTime).Value = txtDateofReviewLessThan.Text
        End If

        If txtDateAdded.Text <> "" Then
            cmd.Parameters.Add("@DateAdded", SqlDbType.SmallDateTime).Value = txtDateAdded.Text
        End If

        If txtDateAddedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateAddedLessThan", SqlDbType.SmallDateTime).Value = txtDateAddedLessThan.Text
        End If

        'This one passes a comma-delimited string for @CallCenterID which is used in the split function
        If ddlCallCenterID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlCallCenterID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@CallCenterID", SqlDbType.VarChar).Value = strSearchValue
        End If

        If ddlUserID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlUserID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
        End If

        If txtQCScoreStart.Text <> "" Then
            cmd.Parameters.Add("@QCScoreStart", SqlDbType.Int).Value = txtQCScoreStart.Text
        End If

        If txtQCScoreEnd.Text <> "" Then
            cmd.Parameters.Add("@QCScoreEnd", SqlDbType.Int).Value = txtQCScoreEnd.Text
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            grdReviews.DataSource = ds.Tables("Requests").DefaultView
            grdReviews.DataBind()

            'Make search again and Excel buttons visible
            btnSearchAgain.Visible = True
            btnExportExcel.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnExportExcel_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_QCSearch", MyConnection)

        With cmd
            .CommandType = CommandType.StoredProcedure

            'p_QCSearch uses dynamic SQL so we pass a value to it only when there is one
            If txtReviewID.Text <> "" Then
                cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = Convert.ToInt32(txtReviewID.Text)
            End If

            If txtDateofReview.Text <> "" Then
                cmd.Parameters.Add("@DateofReview", SqlDbType.SmallDateTime).Value = txtDateofReview.Text
            End If

            If txtDateofReviewLessThan.Text <> "" Then
                cmd.Parameters.Add("@DateofReviewLessThan", SqlDbType.SmallDateTime).Value = txtDateofReviewLessThan.Text
            End If

            If txtDateAdded.Text <> "" Then
                cmd.Parameters.Add("@DateAdded", SqlDbType.SmallDateTime).Value = txtDateAdded.Text
            End If

            If txtDateAddedLessThan.Text <> "" Then
                cmd.Parameters.Add("@DateAddedLessThan", SqlDbType.SmallDateTime).Value = txtDateAddedLessThan.Text
            End If

            'This one passes a comma-delimited string for @CallCenterID which is used in the split function
            If ddlCallCenterID.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlCallCenterID.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@CallCenterID", SqlDbType.VarChar).Value = strSearchValue
            End If

            If ddlUserID.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlUserID.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
            End If

            If txtQCScoreStart.Text <> "" Then
                cmd.Parameters.Add("@QCScoreStart", SqlDbType.Int).Value = txtQCScoreStart.Text
            End If

            If txtQCScoreEnd.Text <> "" Then
                cmd.Parameters.Add("@QCScoreEnd", SqlDbType.Int).Value = txtQCScoreEnd.Text
            End If

        End With

        Dim da As New SqlDataAdapter(cmd)
        Dim myDataTable As DataTable = New DataTable()
        da.Fill(myDataTable)

        Try
            MyConnection.Open()
            Response.Clear()
            Response.ClearHeaders()
            Dim writer As New CsvWriter(Response.OutputStream, ","c, Encoding.Default)
            writer.WriteAll(myDataTable, True)
            writer.Close()

            Dim FileDate As String = Replace(FormatDateTime(Now(), DateFormat.ShortDate), "/", "")
            Response.AddHeader("Content-Disposition", "attachment;filename=QCSearch_" & FileDate & ".csv")
            Response.ContentType = "application/vnd.ms-excel"
            Response.End()
        Finally
            If MyConnection.State <> ConnectionState.Closed Then MyConnection.Close()
            MyConnection.Dispose()
            MyConnection = Nothing
            myDataTable.Dispose()
            myDataTable = Nothing
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


End Class
