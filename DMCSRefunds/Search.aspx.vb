Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Telerik.Web.UI
Imports Csv

Partial Class DMCSRefunds_Search
    Inherits System.Web.UI.Page

    Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            RadMenu1.LoadContentFile("~/DMCSRefunds/Menu.xml")

            'Bind the UserID dropdownlist with users in the DCMS Refunds role
            ddlUserID.DataSource = Roles.GetUsersInRole("DMCSRefunds")
            ddlUserID.DataBind()

            'Assign users to the reassignment dropdownlist
            ddlUserIDAssign.DataSource = Roles.GetUsersInRole("DMCSRefunds")
            ddlUserIDAssign.DataBind()

            'Check what role the user is in because only DMCSRefunds_Admins can reassign refunds to other LAs
            'We need to disable to reassignment buttons if user is not in this role
            If Roles.IsUserInRole("DMCSRefunds_Admins") = True Then
                btnAssignRefunds.Enabled = True
                ddlUserIDAssign.Enabled = True
            Else
                btnAssignRefunds.Enabled = False
                ddlUserIDAssign.Enabled = False
            End If
        End If
    End Sub

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

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtRefundID.Text <> "" Then
            cmd.Parameters.Add("@RefundID", SqlDbType.Int).Value = Convert.ToInt32(txtRefundID.Text)
        End If

        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        End If

        If txtTagDate.Text <> "" Then
            cmd.Parameters.Add("@TagDate", SqlDbType.DateTime).Value = CDate(txtTagDate.Text)
        End If

        If txtTagDateEnd.Text <> "" Then
            cmd.Parameters.Add("@TagDateEnd", SqlDbType.DateTime).Value = CDate(txtTagDateEnd.Text)
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

        If ddlFirstLineApprovalStatus.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlFirstLineApprovalStatus.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@FirstLineApprovalStatus", SqlDbType.VarChar).Value = strSearchValue
        End If

        If txtFirstLineDateApproved.Text <> "" Then
            cmd.Parameters.Add("@FirstLineDateApproved", SqlDbType.DateTime).Value = txtFirstLineDateApproved.Text
        End If

        If txtFirstLineDateApprovedEnd.Text <> "" Then
            cmd.Parameters.Add("@FirstLineDateApprovedEnd", SqlDbType.DateTime).Value = txtFirstLineDateApprovedEnd.Text
        End If

        If txtSecondLineDateApproved.Text <> "" Then
            cmd.Parameters.Add("@SecondLineDateApproved", SqlDbType.DateTime).Value = txtSecondLineDateApproved.Text
        End If

        If txtSecondLineDateApprovedEnd.Text <> "" Then
            cmd.Parameters.Add("@SecondLineDateApprovedEnd", SqlDbType.DateTime).Value = txtSecondLineDateApprovedEnd.Text
        End If

        If ddlSecondLineApprovalStatus.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlSecondLineApprovalStatus.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@SecondLineApprovalStatus", SqlDbType.VarChar).Value = strSearchValue
        End If

        If ddlSecondLineApprovedBy.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlSecondLineApprovedBy.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@SecondLineApprovedBy", SqlDbType.VarChar).Value = strSearchValue
        End If

        If txtRefundAmount.Text <> "" Then
            cmd.Parameters.Add("@RefundAmount", SqlDbType.Float).Value = txtRefundAmount.Text
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            'ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            GridView1.DataSource = ds.Tables("Requests").DefaultView
            GridView1.DataBind()

            'Make the excel button visible
            btnExportToExcel.Visible = True
            btnExportToExcel2.Visible = True

            'Make the reassignment buttons visible
            pnlReassignmentSection.Visible = True

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        GridView1.PageIndex = e.NewPageIndex
        FindCheckedRows()
    End Sub

    Protected Sub btnExportToExcel_Click(sender As Object, e As EventArgs)
        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_Search", MyConnection)
        With cmd
            'p_Search uses dynamic SQL so we pass a value to it only when there is one
            .CommandType = CommandType.StoredProcedure
            '.Parameters.Add("@RefundID", SqlDbType.Int)
            '.Parameters("@pdata").Value = "Whatever"

            If txtRefundID.Text <> "" Then
                cmd.Parameters.Add("@RefundID", SqlDbType.Int).Value = Convert.ToInt32(txtRefundID.Text)
            End If

            If txtBorrowerNumber.Text <> "" Then
                cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
            End If

            If txtTagDate.Text <> "" Then
                cmd.Parameters.Add("@TagDate", SqlDbType.DateTime).Value = CDate(txtTagDate.Text)
            End If

            If txtTagDateEnd.Text <> "" Then
                cmd.Parameters.Add("@TagDateEnd", SqlDbType.DateTime).Value = CDate(txtTagDateEnd.Text)
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

            If ddlFirstLineApprovalStatus.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlFirstLineApprovalStatus.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@FirstLineApprovalStatus", SqlDbType.VarChar).Value = strSearchValue
            End If

            If txtFirstLineDateApproved.Text <> "" Then
                cmd.Parameters.Add("@FirstLineDateApproved", SqlDbType.DateTime).Value = txtFirstLineDateApproved.Text
            End If

            If txtFirstLineDateApprovedEnd.Text <> "" Then
                cmd.Parameters.Add("@FirstLineDateApprovedEnd", SqlDbType.DateTime).Value = txtFirstLineDateApprovedEnd.Text
            End If

            If txtSecondLineDateApproved.Text <> "" Then
                cmd.Parameters.Add("@SecondLineDateApproved", SqlDbType.DateTime).Value = txtSecondLineDateApproved.Text
            End If

            If txtSecondLineDateApprovedEnd.Text <> "" Then
                cmd.Parameters.Add("@SecondLineDateApprovedEnd", SqlDbType.DateTime).Value = txtSecondLineDateApprovedEnd.Text
            End If

            If ddlSecondLineApprovalStatus.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlSecondLineApprovalStatus.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@SecondLineApprovalStatus", SqlDbType.VarChar).Value = strSearchValue
            End If

            If ddlSecondLineApprovedBy.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlSecondLineApprovedBy.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@SecondLineApprovedBy", SqlDbType.VarChar).Value = strSearchValue
            End If

            If txtRefundAmount.Text <> "" Then
                cmd.Parameters.Add("@RefundAmount", SqlDbType.Float).Value = txtRefundAmount.Text
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
            Response.AddHeader("Content-Disposition", "attachment;filename=DMCSRefunds_" & FileDate & ".csv")
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


    'Protected Sub btnExportToExcel_Click(sender As Object, e As EventArgs)
    '    FindCheckedRows()
    '    GridView1.ShowHeader = True
    '    GridView1.GridLines = GridLines.Both
    '    GridView1.AllowPaging = False
    '    GridView1.AllowSorting = False
    '    BindGridView()
    '    GridView1.HeaderRow.Cells.RemoveAt(0)
    '    'grdMyRefundQueue.HeaderRow.Cells.RemoveAt(1)
    '    'grdMyRefundQueue.Columns.RemoveAt(0)
    '    'grdMyRefundQueue.Columns.RemoveAt(1)

    '    If ViewState("checkedRowsList") IsNot Nothing Then
    '        Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

    '        For Each gvRow As GridViewRow In GridView1.Rows
    '            gvRow.Visible = False
    '            If gvRow.RowType = DataControlRowType.DataRow Then
    '                Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("RefundID"))
    '                If checkedRowsList.Contains(rowIndex) Then
    '                    gvRow.Visible = True
    '                    gvRow.Cells(0).Visible = False
    '                End If
    '            End If
    '        Next
    '    End If
    '    'ChangeControlsToValue(gvdetails)
    '    Response.ClearContent()
    '    Response.AddHeader("content-disposition", "attachment; filename=Refund_Requests_" & Today() & ".xls")
    '    Response.ContentType = "application/excel"
    '    Dim sWriter As New StringWriter()
    '    Dim hTextWriter As New HtmlTextWriter(sWriter)
    '    Dim hForm As New HtmlForm()
    '    GridView1.Parent.Controls.Add(hForm)
    '    hForm.Attributes("runat") = "server"
    '    hForm.Controls.Add(GridView1)
    '    hForm.RenderControl(hTextWriter)
    '    Response.Write(sWriter.ToString())
    '    Response.End()

    'End Sub

    Private Sub FindCheckedRows()
        Dim checkedRowsList As ArrayList
        If ViewState("checkedRowsList") IsNot Nothing Then
            checkedRowsList = DirectCast(ViewState("checkedRowsList"), ArrayList)
        Else
            checkedRowsList = New ArrayList()
        End If

        For Each gvRow As GridViewRow In GridView1.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("RefundID"))
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)

                If (chkSelect.Checked) AndAlso (Not checkedRowsList.Contains(rowIndex)) Then
                    checkedRowsList.Add(rowIndex)
                ElseIf (Not chkSelect.Checked) AndAlso (checkedRowsList.Contains(rowIndex)) Then
                    checkedRowsList.Remove(rowIndex)
                End If
            End If
        Next

        ViewState("checkedRowsList") = checkedRowsList
    End Sub

    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)
            Dim gvRow As GridViewRow = e.Row
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim chkSelect As CheckBox = DirectCast(gvRow.FindControl("chkSelect"), CheckBox)
                Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("RefundID"))

                If checkedRowsList.Contains(rowIndex) Then
                    chkSelect.Checked = True
                End If
            End If
        End If
    End Sub

    Protected Sub MasterCheck_Click(ByVal sender As Object, ByVal e As CommandEventArgs)
        'Enumerate each GridViewRow
        For Each gvr As GridViewRow In GridView1.Rows
            'Programmatically access the CheckBox from the TemplateField
            Dim cb As CheckBox = CType(gvr.FindControl("chkSelect"), CheckBox)

            Select Case e.CommandName
                Case "Check"
                    'Check all of the checkboxes
                    cb.Checked = True
                    'Change the CommandName, CommandArgument and Text of the button
                    btnMasterCheck.CommandName = "Uncheck"
                    btnMasterCheck.CommandArgument = "Uncheck"
                    btnMasterCheck.Text = "Uncheck All Refunds"
                Case "Uncheck"
                    'Uncheck all of the checkboxes
                    cb.Checked = False
                    'Change the CommandName, CommandArgument and Text of the button
                    btnMasterCheck.CommandName = "Check"
                    btnMasterCheck.CommandArgument = "Check"
                    btnMasterCheck.Text = "Check All Refunds"
                Case Else
                    '
            End Select
        Next
    End Sub

    Sub btnAssignRefunds_Click(ByVal sender As Object, ByVal e As EventArgs)
        FindCheckedRows()
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        'BindGridView()
        GridView1.AllowPaging = True
        GridView1.AllowSorting = True
        If ViewState("checkedRowsList") IsNot Nothing Then
            Dim checkedRowsList As ArrayList = DirectCast(ViewState("checkedRowsList"), ArrayList)

            For Each gvRow As GridViewRow In GridView1.Rows
                gvRow.Visible = False
                If gvRow.RowType = DataControlRowType.DataRow Then
                    Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("RefundID"))
                    If checkedRowsList.Contains(rowIndex) Then
                        'Pass the RefundID and UserID values to update the reassignment value
                        UpdateRefundAssignment(rowIndex, ddlUserIDAssign.SelectedValue)
                    End If
                End If
            Next
        End If

        'Show the GridView with the next set of refunds in Received status
        BindGridView()

        'Put the Check All/Uncheck All button back to a Check All status
        btnMasterCheck.CommandName = "Check"
        btnMasterCheck.CommandArgument = "Check"
        btnMasterCheck.Text = "Check All Refunds"

    End Sub

    Sub UpdateRefundAssignment(ByVal RefundID As Integer, ByVal UserID As String)

        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString)
        strSql = "p_RefundAssign"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@RefundID", SqlDbType.Int).Value = RefundID
        cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = UserID

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
    End Sub

End Class
