﻿Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class CCM_New_Search
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name

            ddlUserID.DataSource = Roles.GetUsersInRole("CCM")
            ddlUserID.DataBind()
        End If
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        If GridView1.Rows.Count > 0 Then
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("search.aspx")
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtReviewID.Text <> "" Then
            cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = Convert.ToInt32(txtReviewID.Text)
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

        If txtDateofReview.Text <> "" Then
            cmd.Parameters.Add("@DateofReview", SqlDbType.SmallDateTime).Value = txtDateofReview.Text
        End If

        If txtDateofReviewLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateofReviewLessThan", SqlDbType.SmallDateTime).Value = txtDateofReviewLessThan.Text
        End If

        If txtAgentID.Text <> "" Then
            cmd.Parameters.Add("@AgentID", SqlDbType.VarChar).Value = txtAgentID.Text
        End If

        If txtBorrowerAccountNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerAccountNumber", SqlDbType.VarChar).Value = txtBorrowerAccountNumber.Text
        End If

        If txtCallID.Text <> "" Then
            cmd.Parameters.Add("@CallID", SqlDbType.VarChar).Value = txtCallID.Text
        End If

        If ddlEscalated.SelectedValue <> "" Then
            cmd.Parameters.Add("@Escalated", SqlDbType.VarChar).Value = ddlEscalated.SelectedValue
        End If

        If ddlSpecialtyLine.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlSpecialtyLine.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@SpecialtyLine", SqlDbType.VarChar).Value = strSearchValue
        End If

        If txtComments.Text <> "" Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
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

        If ddlOverallScore.SelectedValue <> "" Then
            cmd.Parameters.Add("@OverallScore", SqlDbType.VarChar).Value = ddlOverallScore.SelectedValue
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

            'Make search again button visible
            btnSearchAgain.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    'Private Sub btnExcelExport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
    Protected Sub btnExportExcel_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_Search", MyConnection)

        With cmd
            .CommandType = CommandType.StoredProcedure
            If txtReviewID.Text <> "" Then
                .Parameters.Add("@ReviewID", SqlDbType.Int).Value = Convert.ToInt32(txtReviewID.Text)
            End If

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

            If txtDateofReview.Text <> "" Then
                cmd.Parameters.Add("@DateofReview", SqlDbType.SmallDateTime).Value = txtDateofReview.Text
            End If

            If txtDateofReviewLessThan.Text <> "" Then
                cmd.Parameters.Add("@DateofReviewLessThan", SqlDbType.SmallDateTime).Value = txtDateofReviewLessThan.Text
            End If

            If txtAgentID.Text <> "" Then
                cmd.Parameters.Add("@AgentID", SqlDbType.VarChar).Value = txtAgentID.Text
            End If

            If txtBorrowerAccountNumber.Text <> "" Then
                cmd.Parameters.Add("@BorrowerAccountNumber", SqlDbType.VarChar).Value = txtBorrowerAccountNumber.Text
            End If

            If txtCallID.Text <> "" Then
                cmd.Parameters.Add("@CallID", SqlDbType.VarChar).Value = txtCallID.Text
            End If

            If ddlEscalated.SelectedValue <> "" Then
                cmd.Parameters.Add("@Escalated", SqlDbType.VarChar).Value = ddlEscalated.SelectedValue
            End If

            If ddlSpecialtyLine.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlSpecialtyLine.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@SpecialtyLine", SqlDbType.VarChar).Value = strSearchValue
            End If

            If txtComments.Text <> "" Then
                cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
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
                .Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
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
            Response.AddHeader("Content-Disposition", "attachment;filename=Call_Monitoring_" & FileDate & ".csv")
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

    Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        GridView1.PageIndex = e.NewPageIndex
        BindGridView()
    End Sub
End Class
