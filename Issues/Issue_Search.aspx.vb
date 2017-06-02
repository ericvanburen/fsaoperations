Imports System.Data
Imports System.Data.SqlClient

Partial Class Issues_Issue_Search_Liaisons
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            ddlUserID.DataSource = Roles.GetUsersInRole("Issues")
            ddlUserID.DataBind()

            ''Get current user name
            'lblUserID.Text = HttpContext.Current.User.Identity.Name

            'If Roles.IsUserInRole("Issues_Admins") = False Then
            '    ddlUserID.Items.FindByValue(lblUserID.Text).Selected = True
            '    ddlUserID.Enabled = False
            'End If
        End If
    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        btnSearch.PostBackUrl = "Issue_Search.aspx#SearchResults"
        BindGridView()
    End Sub

    Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim intIssueID As Integer = GridView1.DataKeys(e.Row.RowIndex).Value
            Dim strIssueType As String = e.Row.Cells(1).Text

            Dim link = DirectCast(e.Row.FindControl("HyperLink1"), HyperLink)
            link.Text = intIssueID

            If strIssueType = "PCA" Then
                link.NavigateUrl = "Issue_Update_PCA.aspx?IssueID=" & intIssueID
            Else
                link.NavigateUrl = "Issue_Update.aspx?IssueID=" & intIssueID
            End If

            If ddlIssueType.SelectedValue = "PCA" Then
                'Hide the Liaison Columns
                GridView1.Columns(76).Visible = False
                GridView1.Columns(77).Visible = False
                GridView1.Columns(78).Visible = False
                GridView1.Columns(79).Visible = False
                GridView1.Columns(80).Visible = False
                GridView1.Columns(81).Visible = False
                GridView1.Columns(82).Visible = False
                GridView1.Columns(83).Visible = False
                GridView1.Columns(84).Visible = False
                GridView1.Columns(85).Visible = False
                GridView1.Columns(89).Visible = False
                GridView1.Columns(90).Visible = False
                GridView1.Columns(91).Visible = False

            ElseIf ddlIssueType.SelectedValue = "Liaisons" Then
                'Hide the PCA columns
                GridView1.Columns(17).Visible = False
                GridView1.Columns(18).Visible = False
                GridView1.Columns(19).Visible = False
                GridView1.Columns(20).Visible = False
                GridView1.Columns(21).Visible = False
                GridView1.Columns(22).Visible = False
                GridView1.Columns(23).Visible = False
                GridView1.Columns(24).Visible = False
                GridView1.Columns(25).Visible = False
                GridView1.Columns(26).Visible = False
                GridView1.Columns(27).Visible = False
                GridView1.Columns(28).Visible = False
                GridView1.Columns(29).Visible = False
                GridView1.Columns(30).Visible = False
                GridView1.Columns(31).Visible = False
                GridView1.Columns(32).Visible = False
                GridView1.Columns(33).Visible = False
                GridView1.Columns(34).Visible = False
                GridView1.Columns(35).Visible = False
                GridView1.Columns(36).Visible = False
                GridView1.Columns(37).Visible = False
                GridView1.Columns(38).Visible = False
                GridView1.Columns(39).Visible = False
                GridView1.Columns(40).Visible = False
                GridView1.Columns(41).Visible = False
                GridView1.Columns(42).Visible = False
                GridView1.Columns(43).Visible = False
                GridView1.Columns(44).Visible = False
                GridView1.Columns(45).Visible = False
                GridView1.Columns(46).Visible = False
                GridView1.Columns(47).Visible = False
                GridView1.Columns(48).Visible = False
                GridView1.Columns(49).Visible = False
                GridView1.Columns(50).Visible = False
                GridView1.Columns(51).Visible = False
                GridView1.Columns(52).Visible = False
                GridView1.Columns(53).Visible = False
                GridView1.Columns(54).Visible = False
                GridView1.Columns(55).Visible = False
                GridView1.Columns(56).Visible = False
                GridView1.Columns(57).Visible = False
                GridView1.Columns(58).Visible = False
                GridView1.Columns(59).Visible = False
                GridView1.Columns(60).Visible = False
                GridView1.Columns(61).Visible = False
                GridView1.Columns(62).Visible = False
                GridView1.Columns(63).Visible = False
                GridView1.Columns(64).Visible = False
                GridView1.Columns(65).Visible = False
                GridView1.Columns(66).Visible = False
                GridView1.Columns(67).Visible = False
                GridView1.Columns(68).Visible = False
                GridView1.Columns(69).Visible = False
                GridView1.Columns(70).Visible = False
                GridView1.Columns(71).Visible = False
                GridView1.Columns(72).Visible = False
                GridView1.Columns(73).Visible = False
                GridView1.Columns(74).Visible = False
                GridView1.Columns(75).Visible = False

                'Hide the Borrower Details columns
                GridView1.Columns(86).Visible = False
                GridView1.Columns(87).Visible = False
                GridView1.Columns(88).Visible = False

            ElseIf ddlIssueType.SelectedValue = "Call Center" Then

                'Hide the Liaison Columns
                GridView1.Columns(76).Visible = False
                GridView1.Columns(77).Visible = False
                GridView1.Columns(78).Visible = False
                GridView1.Columns(79).Visible = False
                GridView1.Columns(80).Visible = False
                GridView1.Columns(81).Visible = False
                GridView1.Columns(82).Visible = False
                GridView1.Columns(83).Visible = False
                GridView1.Columns(84).Visible = False
                GridView1.Columns(85).Visible = False

                'Hide the PCA columns
                GridView1.Columns(17).Visible = False
                GridView1.Columns(18).Visible = False
                GridView1.Columns(19).Visible = False
                GridView1.Columns(20).Visible = False
                GridView1.Columns(21).Visible = False
                GridView1.Columns(22).Visible = False
                GridView1.Columns(23).Visible = False
                GridView1.Columns(24).Visible = False
                GridView1.Columns(25).Visible = False
                GridView1.Columns(26).Visible = False
                GridView1.Columns(27).Visible = False
                GridView1.Columns(28).Visible = False
                GridView1.Columns(29).Visible = False
                GridView1.Columns(30).Visible = False
                GridView1.Columns(31).Visible = False
                GridView1.Columns(32).Visible = False
                GridView1.Columns(33).Visible = False
                GridView1.Columns(34).Visible = False
                GridView1.Columns(35).Visible = False
                GridView1.Columns(36).Visible = False
                GridView1.Columns(37).Visible = False
                GridView1.Columns(38).Visible = False
                GridView1.Columns(39).Visible = False
                GridView1.Columns(40).Visible = False
                GridView1.Columns(41).Visible = False
                GridView1.Columns(42).Visible = False
                GridView1.Columns(43).Visible = False
                GridView1.Columns(44).Visible = False
                GridView1.Columns(45).Visible = False
                GridView1.Columns(46).Visible = False
                GridView1.Columns(47).Visible = False
                GridView1.Columns(48).Visible = False
                GridView1.Columns(49).Visible = False
                GridView1.Columns(50).Visible = False
                GridView1.Columns(51).Visible = False
                GridView1.Columns(52).Visible = False
                GridView1.Columns(53).Visible = False
                GridView1.Columns(54).Visible = False
                GridView1.Columns(55).Visible = False
                GridView1.Columns(56).Visible = False
                GridView1.Columns(57).Visible = False
                GridView1.Columns(58).Visible = False
                GridView1.Columns(59).Visible = False
                GridView1.Columns(60).Visible = False
                GridView1.Columns(61).Visible = False
                GridView1.Columns(62).Visible = False
                GridView1.Columns(63).Visible = False
                GridView1.Columns(64).Visible = False
                GridView1.Columns(65).Visible = False
                GridView1.Columns(66).Visible = False
                GridView1.Columns(67).Visible = False
                GridView1.Columns(68).Visible = False
                GridView1.Columns(69).Visible = False
                GridView1.Columns(70).Visible = False
                GridView1.Columns(71).Visible = False
                GridView1.Columns(72).Visible = False
                GridView1.Columns(73).Visible = False
                GridView1.Columns(74).Visible = False
                GridView1.Columns(75).Visible = False
                GridView1.Columns(89).Visible = False
                GridView1.Columns(90).Visible = False
                GridView1.Columns(91).Visible = False

            ElseIf ddlIssueType.SelectedValue = "Escalated" Then

                'Hide the Liaison Columns
                GridView1.Columns(76).Visible = False
                GridView1.Columns(77).Visible = False
                GridView1.Columns(78).Visible = False
                GridView1.Columns(79).Visible = False
                GridView1.Columns(80).Visible = False
                GridView1.Columns(81).Visible = False
                GridView1.Columns(82).Visible = False
                GridView1.Columns(83).Visible = False
                GridView1.Columns(84).Visible = False
                GridView1.Columns(85).Visible = False
                GridView1.Columns(89).Visible = False
                GridView1.Columns(90).Visible = False
                GridView1.Columns(91).Visible = False

                'Hide the PCA columns
                GridView1.Columns(17).Visible = False
                GridView1.Columns(18).Visible = False
                GridView1.Columns(19).Visible = False
                GridView1.Columns(20).Visible = False
                GridView1.Columns(21).Visible = False
                GridView1.Columns(22).Visible = False
                GridView1.Columns(23).Visible = False
                GridView1.Columns(24).Visible = False
                GridView1.Columns(25).Visible = False
                GridView1.Columns(26).Visible = False
                GridView1.Columns(27).Visible = False
                GridView1.Columns(28).Visible = False
                GridView1.Columns(29).Visible = False
                GridView1.Columns(30).Visible = False
                GridView1.Columns(31).Visible = False
                GridView1.Columns(32).Visible = False
                GridView1.Columns(33).Visible = False
                GridView1.Columns(34).Visible = False
                GridView1.Columns(35).Visible = False
                GridView1.Columns(36).Visible = False
                GridView1.Columns(37).Visible = False
                GridView1.Columns(38).Visible = False
                GridView1.Columns(39).Visible = False
                GridView1.Columns(40).Visible = False
                GridView1.Columns(41).Visible = False
                GridView1.Columns(42).Visible = False
                GridView1.Columns(43).Visible = False
                GridView1.Columns(44).Visible = False
                GridView1.Columns(45).Visible = False
                GridView1.Columns(46).Visible = False
                GridView1.Columns(47).Visible = False
                GridView1.Columns(48).Visible = False
                GridView1.Columns(49).Visible = False
                GridView1.Columns(50).Visible = False
                GridView1.Columns(51).Visible = False
                GridView1.Columns(52).Visible = False
                GridView1.Columns(53).Visible = False
                GridView1.Columns(54).Visible = False
                GridView1.Columns(55).Visible = False
                GridView1.Columns(56).Visible = False
                GridView1.Columns(57).Visible = False
                GridView1.Columns(58).Visible = False
                GridView1.Columns(59).Visible = False
                GridView1.Columns(60).Visible = False
                GridView1.Columns(61).Visible = False
                GridView1.Columns(62).Visible = False
                GridView1.Columns(63).Visible = False
                GridView1.Columns(64).Visible = False
                GridView1.Columns(65).Visible = False
                GridView1.Columns(66).Visible = False
                GridView1.Columns(67).Visible = False
                GridView1.Columns(68).Visible = False
                GridView1.Columns(69).Visible = False
                GridView1.Columns(70).Visible = False
                GridView1.Columns(71).Visible = False
                GridView1.Columns(72).Visible = False
                GridView1.Columns(73).Visible = False
                GridView1.Columns(74).Visible = False
                GridView1.Columns(75).Visible = False

            ElseIf ddlIssueType.SelectedValue = "All Types" Then
                'Hide Nothing
            End If

        End If
    End Sub


    Sub BindGridView()

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssuesSearch", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        If txtIssueID.Text <> "" Then
            cmd.Parameters.Add("@IssueID", SqlDbType.Int).Value = txtIssueID.Text
        End If

        If ddlIssueType.SelectedValue <> "" Then
            cmd.Parameters.Add("@IssueType", SqlDbType.VarChar).Value = ddlIssueType.SelectedValue
        End If

        If txtDateReceivedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateReceivedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateReceivedGreaterThan.Text
        End If

        If txtDateReceivedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateReceivedLessThan", SqlDbType.SmallDateTime).Value = txtDateReceivedLessThan.Text
        End If

        'This one passes a comma-delimited string for @IssueStatus which is used in the split function
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

        'This one passes a comma-delimited string for @UserID which is used in the split function
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

        'DateResolved
        If txtDateResolvedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateResolvedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateResolvedGreaterThan.Text
        End If

        If txtDateResolvedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateResolvedLessThan", SqlDbType.SmallDateTime).Value = txtDateResolvedLessThan.Text
        End If

        'Due Date 
        If txtDueDate.Text <> "" Then
            cmd.Parameters.Add("@DueDate", SqlDbType.SmallDateTime).Value = txtDueDate.Text
        End If

        'Follow up date
        If txtFollowupDate.Text <> "" Then
            cmd.Parameters.Add("@FollowupDate", SqlDbType.SmallDateTime).Value = txtFollowupDate.Text
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

        'SubCategory
        If ddlSubCategoryID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlSubCategoryID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@SubCategoryID", SqlDbType.VarChar).Value = strSearchValue
        End If

        'SourceOrgType
        If ddlSourceOrgType.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlSourceOrgType.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@SourceOrgType", SqlDbType.VarChar).Value = strSearchValue
        End If

        'SourceOrgID
        If ddlSourceOrgID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlSourceOrgID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@SourceOrgID", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Source Name
        If txtSourceName.Text <> "" Then
            cmd.Parameters.Add("@SourceName", SqlDbType.VarChar).Value = txtSourceName.Text
        End If

        'Owner
        If txtOwner.Text <> "" Then
            cmd.Parameters.Add("@Owner", SqlDbType.VarChar).Value = txtOwner.Text
        End If

        'RootCause
        If ddlRootCause.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlRootCause.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@RootCause", SqlDbType.VarChar).Value = strSearchValue
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

        'txtSourceContactInfo
        If txtSourceContactInfo.Text <> "" Then
            cmd.Parameters.Add("@SourceContactInfo", SqlDbType.VarChar).Value = txtSourceContactInfo.Text
        End If

        'ReceivedBy
        If ddlReceivedBy.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReceivedBy.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ReceivedBy", SqlDbType.VarChar).Value = strSearchValue
        End If

        'WrittenVerbal
        If ddlWrittenVerbal.SelectedValue <> "" Then
            cmd.Parameters.Add("@WrittenVerbal", SqlDbType.VarChar).Value = ddlWrittenVerbal.SelectedValue
        End If

        'Severity
        If ddlSeverity.SelectedValue <> "" Then
            cmd.Parameters.Add("@Severity", SqlDbType.VarChar).Value = ddlSeverity.SelectedValue
        End If

        'eIMF
        If txteIMF.Text <> "" Then
            cmd.Parameters.Add("@eIMF", SqlDbType.VarChar).Value = txteIMF.Text
        End If

        'CollectorFirstName
        If txtCollectorFirstName.Text <> "" Then
            cmd.Parameters.Add("@CollectorFirstName", SqlDbType.VarChar).Value = txtCollectorFirstName.Text
        End If

        'CollectorLastName
        If txtCollectorLastName.Text <> "" Then
            cmd.Parameters.Add("@CollectorLastName", SqlDbType.VarChar).Value = txtCollectorLastName.Text
        End If

        'ResponsibleArea
        If ddlResponsibleArea.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlResponsibleArea.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ResponsibleArea", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Ultimate Source Type
        If ddlUltimateSourceType.SelectedValue <> "" Then
            cmd.Parameters.Add("@UltimateSourceType", SqlDbType.VarChar).Value = ddlUltimateSourceType.SelectedValue
        End If

        'Ultimate Source Name
        If txtUltimateSourceName.Text <> "" Then
            cmd.Parameters.Add("@UltimateSourceName", SqlDbType.VarChar).Value = txtUltimateSourceName.Text
        End If

        'Rating Borrowers
        If ddlRatingBorrowers.SelectedValue <> "" Then
            cmd.Parameters.Add("@RatingBorrowers", SqlDbType.Int).Value = ddlRatingBorrowers.SelectedValue
        End If

        'BorrowersAffected
        If txtBorrowersAffected.Text <> "" Then
            cmd.Parameters.Add("@BorrowersAffected", SqlDbType.VarChar).Value = txtBorrowersAffected.Text
        End If

        'RatingLoans (#)
        If ddlRatingLoans.SelectedValue <> "" Then
            cmd.Parameters.Add("@RatingLoans", SqlDbType.Int).Value = ddlRatingLoans.SelectedValue
        End If

        'Loans Affected
        If txtLoansAffected.Text <> "" Then
            cmd.Parameters.Add("@LoansAffected", SqlDbType.VarChar).Value = txtLoansAffected.Text
        End If

        'RatingFinancial (#)
        If ddlRatingFinancial.SelectedValue <> "" Then
            cmd.Parameters.Add("@RatingFinancial", SqlDbType.Int).Value = ddlRatingFinancial.SelectedValue
        End If

        'FinancialImpact
        If txtFinancialImpact.Text <> "" Then
            cmd.Parameters.Add("@FinancialImpact", SqlDbType.VarChar).Value = txtFinancialImpact.Text
        End If

        'AffectFFEL
        If ddlAffectFFEL.SelectedValue <> "" Then
            cmd.Parameters.Add("@AffectFFEL", SqlDbType.VarChar).Value = ddlAffectFFEL.SelectedValue
        End If

        'BorrowerNumber
        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        End If

        'BorrowerName
        If txtBorrowerName.Text <> "" Then
            cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = txtBorrowerName.Text
        End If

        'SchoolName
        If txtSchoolName.Text <> "" Then
            cmd.Parameters.Add("@SchoolName", SqlDbType.VarChar).Value = txtSchoolName.Text
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Reviews")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            GridView1.DataSource = ds.Tables("Reviews").DefaultView
            GridView1.DataBind()

            'Make search again button visible
            btnSearchAgain.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, e As EventArgs)
        Response.Redirect("Issue_Search.aspx")
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Issue_Search_Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

    

End Class
