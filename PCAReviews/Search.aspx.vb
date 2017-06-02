﻿Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports TrueFalse

Partial Class PCAReviews_Search
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            ddlUserID.DataSource = Roles.GetUsersInRole("PCAReviews")
            ddlUserID.DataBind()

            If Roles.IsUserInRole("PCAReviews_Admins") = False Then
                'GridView1.Columns.RemoveAt(22) which is the FSA_Conclusions field
                'GridView1.Columns(22).Visible = False
            End If

        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtReviewID.Text <> "" Then
            cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = Convert.ToInt32(txtReviewID.Text)
        End If

        'This one passes a comma-delimited string for @PCAId which is used in the split function
        If ddlPCAID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlPCAID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@PCAID", SqlDbType.VarChar).Value = strSearchValue
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

        'This one passes a comma-delimited string 
        If ddlReviewPeriodMonth.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReviewPeriodMonth.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ReviewPeriodMonth", SqlDbType.VarChar).Value = strSearchValue
        End If

        'This one passes a comma-delimited string 
        If ddlReviewPeriodYear.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReviewPeriodYear.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ReviewPeriodYear", SqlDbType.VarChar).Value = strSearchValue
        End If

        If txtBorrowerLastName.Text <> "" Then
            cmd.Parameters.AddWithValue("@BorrowerLastName", SqlDbType.VarChar).Value = txtBorrowerLastName.Text
        End If

        If txtBorrowerNumber.Text <> "" Then
            cmd.Parameters.AddWithValue("@BorrowerNumber", SqlDbType.VarChar).Value = txtBorrowerNumber.Text
        End If

        If txtCallDate.Text <> "" Then
            cmd.Parameters.Add("@CallDate", SqlDbType.SmallDateTime).Value = txtCallDate.Text
        End If

        If txtCallDateGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@CallDateGreaterThan", SqlDbType.SmallDateTime).Value = txtCallDateGreaterThan.Text
        End If

        If txtCallDateLessThan.Text <> "" Then
            cmd.Parameters.Add("@CallDateLessThan", SqlDbType.SmallDateTime).Value = txtCallDateLessThan.Text
        End If

        If txtDateSubmitted.Text <> "" Then
            cmd.Parameters.Add("@DateSubmitted", SqlDbType.SmallDateTime).Value = txtDateSubmitted.Text
        End If

        If txtDateSubmittedGreaterThan.Text <> "" Then
            cmd.Parameters.Add("@DateSubmittedGreaterThan", SqlDbType.SmallDateTime).Value = txtDateSubmittedGreaterThan.Text
        End If

        If txtDateSubmittedLessThan.Text <> "" Then
            cmd.Parameters.Add("@DateSubmittedLessThan", SqlDbType.SmallDateTime).Value = txtDateSubmittedLessThan.Text
        End If

        'This one passes a comma-delimited string 
        If ddlReviewAgency.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlReviewAgency.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ReviewAgency", SqlDbType.VarChar).Value = strSearchValue
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
        Response.Redirect("Search.aspx")
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCACalls_Search_Results.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

    Public Shared Function TrueFalse(ByVal MyValue As Boolean) As String
        Dim result As String = String.Empty
        If MyValue = True Then
            Return "Yes"
        Else
            Return "No"
        End If
        Return result
    End Function

End Class
