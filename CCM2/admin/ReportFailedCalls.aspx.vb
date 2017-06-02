Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Csv

Partial Class CCM_New_ReportFailedCalls
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            txtDateofReviewEndFailedCalls.Text = Now.ToShortDateString()
        End If
    End Sub

    Sub btnReportFailedCalls_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView_FailedCalls()
    End Sub

    Sub BindGridView_FailedCalls()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Report_FailedCalls", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@DateofReviewBegin", SqlDbType.VarChar).Value = txtDateofReviewBeginFailedCalls.Text
        cmd.Parameters.Add("@DateofReviewEnd", SqlDbType.VarChar).Value = txtDateofReviewEndFailedCalls.Text

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            grdFailedCalls.DataSource = ds.Tables("Requests").DefaultView
            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text
            grdFailedCalls.DataBind()

            grdFailedCalls.Visible = True

            'Make the Excel export button visible
            pnlGridViewStats.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Public Sub btnExportExcel_FailedCalls_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs)
        Export("Failed.Calls.xls", grdFailedCalls)
    End Sub

    Public Shared Sub Export(ByVal fileName As String, ByVal gv As GridView)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As StringWriter = New StringWriter
        Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        '  Create a form to contain the grid
        Dim table As Table = New Table
        table.GridLines = gv.GridLines
        '  add the header row to the table
        If (Not (gv.HeaderRow) Is Nothing) Then
            PrepareControlForExport(gv.HeaderRow)
            table.Rows.Add(gv.HeaderRow)
        End If
        '  add each of the data rows to the table
        For Each row As GridViewRow In gv.Rows
            PrepareControlForExport(row)
            table.Rows.Add(row)
        Next
        '  add the footer row to the table
        If (Not (gv.FooterRow) Is Nothing) Then
            PrepareControlForExport(gv.FooterRow)
            table.Rows.Add(gv.FooterRow)
        End If

        '  render the table into the htmlwriter
        table.RenderControl(htw)
        '  render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString)
        HttpContext.Current.Response.End()
    End Sub

    ' Replace any of the contained controls with literals
    Private Shared Sub PrepareControlForExport(ByVal control As Control)
        Dim i As Integer = 0
        Do While (i < control.Controls.Count)
            Dim current As Control = control.Controls(i)
            If (TypeOf current Is LinkButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
            ElseIf (TypeOf current Is ImageButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
            ElseIf (TypeOf current Is HyperLink) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
            ElseIf (TypeOf current Is DropDownList) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
            ElseIf (TypeOf current Is CheckBox) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
                'TODO: Warning!!!, inline IF is not supported ?
            End If
            If current.HasControls Then
                PrepareControlForExport(current)
            End If
            i = (i + 1)
        Loop
    End Sub

    Protected Sub grdFailedCalls_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Dim strSortString = Convert.ToString(e.SortExpression) & " " & GetSortDirection(e.SortDirection)
        lblSortExpression.Text = strSortString.ToString
        'Now bind the gridview with the results
        BindGridView_FailedCalls()
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
