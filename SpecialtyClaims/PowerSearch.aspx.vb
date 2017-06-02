Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class SpecialtyClaims_PowerSearch
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            ddlLoanAnalyst.DataSource = Roles.GetUsersInRole("SpecialityClaims")
            ddlLoanAnalyst.DataBind()
        End If
    End Sub

    Sub btnSearch_Click(sender As Object, e As EventArgs)
        BindGridView()
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Public Shared Function HideNumber(ByVal number As String) As String
        Dim strUser As String = HttpContext.Current.User.Identity.Name
        Dim hiddenString As String
        If strUser = "eric.vanburen" Then
            hiddenString = number
            Return hiddenString
        Else
            hiddenString = number.Substring(number.Length - 4).PadLeft(number.Length, "*")
            Return hiddenString
        End If
    End Function

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one

        'AccountNumber
        If txtAccountNumber.Text <> "" Then
            cmd.Parameters.Add("@AccountNumber", SqlDbType.VarChar).Value = txtAccountNumber.Text
        End If

        'BorrowerName
        If txtBorrowerName.Text <> "" Then
            cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = txtBorrowerName.Text
        End If

        'DischargeType
        'This one passes a comma-delimited string for @DischargeType which is used in the split function
        If ddlDischargeType.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlDischargeType.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@DischargeType", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Servicer
        If ddlServicer.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlServicer.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Servicer", SqlDbType.VarChar).Value = strSearchValue
        End If

        'DateReceivedGreaterThan
        If txtDateReceivedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateReceivedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateReceivedGreaterThan.Text
        End If

        'DateReceivedLessThan
        If txtDateReceivedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateReceivedLessThan", SqlDbType.SmallDateTime).Value = txtDateReceivedLessThan.Text
        End If

        'DateCompletedGreaterThan
        If txtDateCompletedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateCompletedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateCompletedGreaterThan.Text
        End If

        'DateCompletedLessThan
        If txtDateCompletedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateCompletedLessThan", SqlDbType.SmallDateTime).Value = txtDateCompletedLessThan.Text
        End If

        'DateLoadedGreaterThan
        If txtDateLoadedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateLoadedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateLoadedGreaterThan.Text
        End If

        'DateLoadedLessThan
        If txtDateLoadedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateLoadedLessThan", SqlDbType.SmallDateTime).Value = txtDateLoadedLessThan.Text
        End If

        'Approve
        If ddlApprove.SelectedValue <> "" Then
            cmd.Parameters.Add("@Approve", SqlDbType.Bit).Value = ddlApprove.SelectedValue
        End If

        'ServicerInformedDateGreaterThan
        If txtServicerInformedDateGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@ServicerInformedDateGreaterThan", SqlDbType.SmallDateTime).Value = txtServicerInformedDateGreaterThan.Text
        End If

        'ServicerInformedDateLessThan
        If txtServicerInformedDateLessThan.Text <> "" Then
            cmd.Parameters.Add("@ServicerInformedDateLessThan", SqlDbType.SmallDateTime).Value = txtServicerInformedDateLessThan.Text
        End If

        'Loan Analyst
        If ddlLoanAnalyst.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlLoanAnalyst.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@LoanAnalyst", SqlDbType.VarChar).Value = strSearchValue
        End If

        'Incomplete Claims
        If ddlIsNotComplete.SelectedValue <> "" Then
            cmd.Parameters.Add("@IsNotComplete", SqlDbType.VarChar).Value = ddlIsNotComplete.SelectedValue
        End If

        'Comments
        If txtComments.Text <> "" Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            GridView1.DataSource = ds.Tables("Requests").DefaultView
            GridView1.DataBind()

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=SpecialtyClaims_Search_Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
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
