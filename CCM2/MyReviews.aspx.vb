Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class CCM_New_MyReviews
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name

            BindGridView()
        End If
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_MyReviews", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = lblUserID.Text

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your list contains " & intRecordCount & " records"

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            GridView1.DataSource = ds.Tables("Requests").DefaultView
            GridView1.DataBind()

            'Make the Excel export button visible
            pnlGridViewStats.Visible = True
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
            cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = lblUserID.Text
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
