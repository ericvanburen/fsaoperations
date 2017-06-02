Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class TOPLog_MyTOPRecords
    Inherits System.Web.UI.Page

    Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            BindGridView()
        End If
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        cmd = New SqlCommand("p_MyTOPLog", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'UserID
        cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = lblUserID.Text

        'Approval Status
        'We want the default approval status to be Received unless specified otherwise
        cmd.Parameters.AddWithValue("@ApprovalStatus", SqlDbType.VarChar).Value = ddlApprovalStatus.SelectedValue

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "TOPLog")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Showing " & intRecordCount & " TOP records"

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text
            GridView1.DataSource = ds.Tables("TOPLog").DefaultView
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

    'Public Sub btnExportExcel_Click(sender As Object, e As EventArgs)
    '    Export("MyTOPLog" & ".xls", GridView1)
    'End Sub


    'Public Shared Sub Export(ByVal fileName As String, ByVal gv As GridView)
    '    HttpContext.Current.Response.Clear()
    '    HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
    '    HttpContext.Current.Response.ContentType = "application/ms-excel"
    '    Dim sw As StringWriter = New StringWriter
    '    Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
    '    '  Create a form to contain the grid
    '    Dim table As Table = New Table
    '    table.GridLines = gv.GridLines
    '    '  add the header row to the table
    '    If (Not (gv.HeaderRow) Is Nothing) Then
    '        PrepareControlForExport(gv.HeaderRow)
    '        table.Rows.Add(gv.HeaderRow)
    '    End If
    '    '  add each of the data rows to the table
    '    For Each row As GridViewRow In gv.Rows
    '        PrepareControlForExport(row)
    '        table.Rows.Add(row)
    '    Next
    '    '  add the footer row to the table
    '    If (Not (gv.FooterRow) Is Nothing) Then
    '        PrepareControlForExport(gv.FooterRow)
    '        table.Rows.Add(gv.FooterRow)
    '    End If

    '    '  render the table into the htmlwriter
    '    table.RenderControl(htw)
    '    '  render the htmlwriter into the response
    '    HttpContext.Current.Response.Write(sw.ToString)
    '    HttpContext.Current.Response.End()
    'End Sub

    '' Replace any of the contained controls with literals
    'Private Shared Sub PrepareControlForExport(ByVal control As Control)
    '    Dim i As Integer = 0
    '    Do While (i < control.Controls.Count)
    '        Dim current As Control = control.Controls(i)
    '        If (TypeOf current Is LinkButton) Then
    '            control.Controls.Remove(current)
    '            control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
    '        ElseIf (TypeOf current Is ImageButton) Then
    '            control.Controls.Remove(current)
    '            control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
    '        ElseIf (TypeOf current Is HyperLink) Then
    '            control.Controls.Remove(current)
    '            control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
    '        ElseIf (TypeOf current Is DropDownList) Then
    '            control.Controls.Remove(current)
    '            control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
    '        ElseIf (TypeOf current Is CheckBox) Then
    '            control.Controls.Remove(current)
    '            control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
    '            'TODO: Warning!!!, inline IF is not supported ?
    '        End If
    '        If current.HasControls Then
    '            PrepareControlForExport(current)
    '        End If
    '        i = (i + 1)
    '    Loop
    'End Sub

    'Protected Sub ddlApprovalStatus_SelectedIndexChanged(sender As Object, e As System.EventArgs)
    '    BindGridView()
    'End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim intTOPLogID As Integer = GridView1.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(intTOPLogID)

        End If
    End Sub


    Protected Sub LoadModal(TOPLogID As Integer)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        cmd = New SqlCommand("p_TOPLogLoadModal", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@TOPLogID", SqlDbType.Int).Value = TOPLogID
        lblTOPLogID.Text = TOPLogID
        'Clear the update confirm label
        lblUpdateConfirm.Text = ""

        'Clear all of the fields before assigning new values to them
        lblLogDate.Text = ""
        lblBorrowerNumber.Text = ""
        lblActionModal.Text = ""
        txtFSAComments.Text = ""
        txtPICComments.Text = ""
        lblApprovalStatusBeforeUpdate.Text = ""
        ddlApprovalStatusModal.SelectedValue = ""
        lblNewOffsetAmount.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    lblTOPLogID.Text = TOPLogID.ToString()

                    If Not dr("LogDate").Equals(DBNull.Value) Then
                        lblLogDate.Text = dr("LogDate")
                    End If

                    If Not dr("BorrowerNumber").Equals(DBNull.Value) Then
                        lblBorrowerNumber.Text = dr("BorrowerNumber")
                    End If

                    If Not lblActionModal.Text <> "" Then
                        lblActionModal.Text = dr("Action").ToString()
                    End If

                    If Not txtFSAComments.Text <> "" Then
                        txtFSAComments.Text = dr("FSAComments").ToString()
                    End If

                    If Not txtPICComments.Text <> "" Then
                        txtPICComments.Text = dr("PICComments").ToString()
                    End If

                    If Not lblApprovalStatusBeforeUpdate.Text <> "" Then
                        lblApprovalStatusBeforeUpdate.Text = dr("ApprovalStatus").ToString()
                    End If

                    If Not ddlApprovalStatusModal.SelectedValue <> "" Then
                        ddlApprovalStatusModal.SelectedValue = dr("ApprovalStatus").ToString()
                    End If

                    If Not dr("NewOffsetAmount").Equals(DBNull.Value) Then
                        lblNewOffsetAmount.Text = dr("NewOffsetAmount")
                    End If

                    If Not dr("DateApproved").Equals(DBNull.Value) Then
                        lblDateApproved.Text = dr("DateApproved")
                    End If

                    'Now bind the errors list 
                    BindErrorsList(dr("Action").ToString())

                End While
            End Using
        Finally
            con.Close()
        End Try
    End Sub

    Public Sub BindErrorsList(ByVal ErrorCategory As String) 'Errorcategory is the same thing as Action

        'This creates the list of checkboxes for all of the errors. We show only the errors from the Errors table based on the specified ErrorCategory 
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim objReader As SqlDataReader
        Dim strErrorCategory As String = ErrorCategory
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        cmd = New SqlCommand("p_BindErrors", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@ErrorCategory", SqlDbType.VarChar).Value = ErrorCategory

        strSQLConn.Open()
        cblErrors.DataSource = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        cblErrors.DataTextField = "Error"
        cblErrors.DataValueField = "ErrorID"
        cblErrors.DataBind()

        'Dim cmd As SqlCommmand
        cmd = New SqlCommand("SELECT TOPLogID, ErrorID FROM TOPLog_Errors WHERE TOPLogID=" & lblTOPLogID.Text, strSQLConn)
        strSQLConn.Open()
        objReader = cmd.ExecuteReader()
        While objReader.Read()
            Dim currentCheckBox As ListItem = cblErrors.Items.FindByValue(objReader("ErrorID").ToString())
            If Not (currentCheckBox Is Nothing) Then
                currentCheckBox.Selected = True
            End If
        End While
        strSQLConn.Close()
    End Sub

    Sub DeleteErrors(ByVal TOPLogID As Integer)
        'The first step in the save errors process is to delete all of the exising ones from the TOPLog_Errors table
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String
        Dim intTOPLogID As Integer = TOPLogID
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        SqlText = "p_DeleteSavedErrors"
        cmd = New SqlCommand(SqlText)
        cmd.Connection = strSQLConn
        cmd.CommandType = CommandType.StoredProcedure
        'input parameters for the sproc
        cmd.Parameters.Add("@TOPLogID", SqlDbType.Int).Value = TOPLogID
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Finally
            strSQLConn.Close()
        End Try
        'Now that the existing errors are deleted, we can add the new ones
        SaveErrors(TOPLogID)
    End Sub

    Sub SaveErrors(ByVal TOPLogID As Integer)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim SqlText As String
        Dim intTOPLogID As Integer = TOPLogID

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        SqlText = "p_SaveErrors"
        Try
            strSQLConn.Open()
            For Each Item As ListItem In cblErrors.Items
                If (Item.Selected) Then
                    cmd = New SqlCommand(SqlText)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Connection = strSQLConn
                    'input parameters for the sproc
                    cmd.Parameters.Add("@TOPLogID", SqlDbType.Int).Value = TOPLogID
                    cmd.Parameters.Add("@ErrorID", SqlDbType.Int).Value = Item.Value
                    cmd.ExecuteNonQuery()
                End If
            Next
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub SaveChanges()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("TOPLogConnectionString").ConnectionString)
        cmd = New SqlCommand("p_TOPLogUpdateModal", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        Dim TOPLogID As Integer = lblTOPLogID.Text
        Dim strAction As String = lblActionModal.Text
        Dim strFSAComments As String = txtFSAComments.Text
        Dim strPICComments As String = txtPICComments.Text
        'Errors Go Here
        Dim strApprovalStatusBeforeUpdate As String = lblApprovalStatusBeforeUpdate.Text
        Dim strApprovalStatus As String = ddlApprovalStatusModal.SelectedValue
        Dim strDateApproved As String = lblDateApproved.Text

        cmd.Parameters.AddWithValue("@TOPLogID", TOPLogID)

        If Len(strAction) > 0 Then
            cmd.Parameters.Add("@Action", SqlDbType.VarChar).Value = strAction
        Else
            cmd.Parameters.Add("@Action", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(strApprovalStatus) > 0 Then
            cmd.Parameters.Add("@ApprovalStatus", SqlDbType.VarChar).Value = strApprovalStatus
        Else
            cmd.Parameters.Add("@ApprovalStatus", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'FSA Comments
        If Len(strFSAComments) > 0 Then
            cmd.Parameters.Add("@FSAComments", SqlDbType.VarChar).Value = strFSAComments
        Else
            cmd.Parameters.Add("@FSAComments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'PIC Comments
        If Len(strPICComments) > 0 Then
            cmd.Parameters.Add("@PICComments", SqlDbType.VarChar).Value = strPICComments
        Else
            cmd.Parameters.Add("@PICComments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Date Approved
        If Len(strDateApproved) = 0 Then
            If strApprovalStatus = "Completed" Or strApprovalStatus = "Pending" Or strApprovalStatus = "Rejected" Or strApprovalStatus = "Revised" Then
                cmd.Parameters.Add("@DateApproved", SqlDbType.SmallDateTime).Value = DateTime.Now()
            Else
                cmd.Parameters.Add("@DateApproved", SqlDbType.SmallDateTime).Value = DBNull.Value
            End If
        ElseIf Len(strDateApproved) > 0 Then
            'If strApprovalStatusBeforeUpdate = "Completed" And strApprovalStatus = "Completed" Then
            '    cmd.Parameters.Add("@DateApproved", SqlDbType.SmallDateTime).Value = strDateApproved
            'ElseIf (((strApprovalStatusBeforeUpdate = "Pending") Or (strApprovalStatusBeforeUpdate = "Rejected") Or (strApprovalStatusBeforeUpdate = "Revised")) And (strApprovalStatus = "Completed")) Then
            '    cmd.Parameters.Add("@DateApproved", SqlDbType.SmallDateTime).Value = DateTime.Now()
            'Else
            '    cmd.Parameters.Add("@DateApproved", SqlDbType.SmallDateTime).Value = strDateApproved
            'End If
            If strApprovalStatusBeforeUpdate = strApprovalStatus Then
                cmd.Parameters.Add("@DateApproved", SqlDbType.SmallDateTime).Value = strDateApproved
            Else
                cmd.Parameters.Add("@DateApproved", SqlDbType.SmallDateTime).Value = DateTime.Now()
            End If
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Visible = True
            lblUpdateConfirm.Text = "Your TOP log was successfully updated"

            'We need to update the errors section separately
            DeleteErrors(TOPLogID)

            'Now bind the gridview with the results
            BindGridView()

        Catch ex As Exception
            lblUpdateConfirm.Text = ex.ToString
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnSaveChanges_Click(sender As Object, e As EventArgs)
        SaveChanges()
    End Sub

    Protected Sub ddlApprovalStatus_SelectedIndexChanged(sender As Object, e As EventArgs)
        BindGridView()
    End Sub
End Class
