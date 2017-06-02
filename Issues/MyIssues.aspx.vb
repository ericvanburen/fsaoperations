Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports IssueHistory
Imports FormatParagraph

Partial Class Issues_MyIssues
    Inherits System.Web.UI.Page

    Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            BindGridView()
        End If
    End Sub


    Protected Sub dsGridView_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows > 0 Then
            btnExportExcel.Visible = True
        Else
            btnExportExcel.Visible = False
        End If
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_MyIssues", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'UserID
        cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = lblUserID.Text

        'Issue ID
        If txtIssueID.Text <> "" Then
            cmd.Parameters.Add("@IssueID", SqlDbType.Int).Value = txtIssueID.Text
        End If

        'Issue Type
        If ddlIssueType.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlIssueType.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@IssueType", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Issue Status
        If ddlIssueStatus.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlIssueStatus.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@IssueStatus", SqlDbType.VarChar).Value = strSearchValue
        End If

        'AffectedOrgID
        If ddlAffectedOrgID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlAffectedOrgID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@AffectedOrgID", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Category
        If ddlCategoryID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlCategoryID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@CategoryID", SqlDbType.VarChar).Value = strSearchValue
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Reviews")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Showing " & intRecordCount & " records"

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text
            GridView1.DataSource = ds.Tables("Reviews").DefaultView
            GridView1.DataBind()

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            'This is for the Work Review Link - Hyperlink1
            Dim link = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
            Dim intIssueID As Integer = e.Row.Cells(2).Text
            Dim strIssueType As String = e.Row.Cells(4).Text

            link.Text = intIssueID

            'We need to change the link to the update page based on Issue Type
            If strIssueType = "PCA" Then
                link.NavigateUrl = "Issue_Update_PCA.aspx?IssueID=" & intIssueID
            Else
                link.NavigateUrl = "Issue_Update.aspx?IssueID=" & intIssueID
            End If

        End If

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

    Public Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        Export("MyIssues" & ".xls", GridView1)
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

    Protected Sub txtIssueID_TextChanged(sender As Object, e As System.EventArgs) Handles txtIssueID.TextChanged
        BindGridView()
    End Sub

    Protected Sub ddlIssueType_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlIssueType.SelectedIndexChanged
        BindGridView()
    End Sub


    Protected Sub ddlIssueStatus_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlIssueStatus.SelectedIndexChanged
        BindGridView()
    End Sub


    Protected Sub ddlAffectedOrgID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlAffectedOrgID.SelectedIndexChanged
        BindGridView()
    End Sub

    Protected Sub ddlCategoryID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlCategoryID.SelectedIndexChanged
        BindGridView()
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim intIssueID As Integer = GridView1.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(intIssueID)

        End If
    End Sub


    Protected Sub LoadModal(IssueID As Integer)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssueLoadModal", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@IssueID", SqlDbType.Int).Value = IssueID
        lblIssueID.Text = IssueID
        'Clear the update confirm label
        lblUpdateConfirm.Text = ""

        'Clear all of the fields before assigning new values to them
        txtDateResolved.Text = ""
        txtComments.Text = ""
        txtResolution.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    lblIssueID.Text = IssueID.ToString()
                    ddlIssueStatusModal.SelectedValue = dr("IssueStatus").ToString()
                    If Not dr("DateResolved").Equals(DBNull.Value) Then
                        txtDateResolved.Text = dr("DateResolved")
                    End If
                    If Not dr("Comments").Equals(DBNull.Value) Then
                        txtComments.Text = dr("Comments")
                    End If
                    If Not dr("Resolution").Equals(DBNull.Value) Then
                        txtResolution.Text = dr("Resolution").ToString()
                    End If
                End While
            End Using
        Finally
            con.Close()
        End Try
    End Sub

    Sub SaveChanges()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssueUpdateModal", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        Dim IssueID As Integer = lblIssueID.Text
        Dim strIssueStatus As String = ddlIssueStatusModal.SelectedValue
        Dim dteDateResolved As String = txtDateResolved.Text
        Dim strComments As String = txtComments.Text
        Dim strResolution As String = txtResolution.Text


        cmd.Parameters.AddWithValue("@IssueID", IssueID)
        cmd.Parameters.AddWithValue("@IssueStatus", strIssueStatus)

        If Len(dteDateResolved) > 0 Then
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = dteDateResolved
        Else
            cmd.Parameters.Add("@DateResolved", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(strComments) > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = strComments
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(strResolution) > 0 Then
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = strResolution
        Else
            cmd.Parameters.Add("@Resolution", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Visible = True
            lblUpdateConfirm.Text = "Your issue was successfully updated"

            'Add the call to the IssueHistory table
            Dim newIssueHistory As New IssueHistory
            newIssueHistory.IssueID = lblIssueID.Text
            newIssueHistory.Comments = txtComments.Text

            'Add new record to IssueHistory table
            newIssueHistory.InsertIssueHistory(lblIssueID.Text, txtComments.Text, "Issue Updated")
        Catch ex As Exception
            lblUpdateConfirm.Text = ex.ToString
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnSaveChanges_Click(sender As Object, e As EventArgs)
        SaveChanges()
    End Sub

    Protected Sub ddlIssueStatusModal_SelectedIndexChanged(sender As Object, e As EventArgs)
        'When the issue status in the modal popup changes we want the change saved automatically
        SaveChanges()
    End Sub

    Protected Sub txtComments_TextChanged(sender As Object, e As EventArgs)
        'When the comments field in the modal popup changes we want the change saved automatically
        SaveChanges()
    End Sub

    Protected Sub txtResolution_TextChanged(sender As Object, e As EventArgs)
        'When the resolution field in the modal popup changes we want the change saved automatically
        SaveChanges()
    End Sub
End Class
