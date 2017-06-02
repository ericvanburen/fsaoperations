Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class IBRReviews_ErrorReport
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            dsPreviousReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue

            'Only admins can see the delete saved report button
            If Roles.IsUserInRole("IBRReviews_Admins") = True Then
                btnDeleteSavedReport.Visible = True
            Else
                btnDeleteSavedReport.Visible = False
            End If

        End If
    End Sub

    Sub btnSearch_Click(sender As Object, e As EventArgs)
        
        'First we need to clear the form of any previous search results
        lblTotal_AnyErrors.Text = "0"
        lblTotal_AnyErrors_Percent.Text = "0%"

        lblScore_Agreement_Letter_Signed_Errors.Text = "0"
        lblScore_Agreement_Letter_Signed_Errors_Percent.Text = "0%"

        lblScore_Financial_Documentation_Errors.Text = "0"
        lblScore_Financial_Documentation_Errors_Percent.Text = "0%"

        lblScore_Repayment_Amount_Errors.Text = "0"
        lblScore_Repayment_Amount_Errors_Percent.Text = "0%"

        lblScore_Tag_Errors.Text = "0"
        lblScore_Tag_Errors_Percent.Text = "0%"
        
        lblPopulationSize.Text = ""

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReportSummary", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = ddlReportQuarter.SelectedValue
        cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = ddlReportYear.SelectedValue

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    If Not dr("Total_AnyErrors") Is DBNull.Value Then
                        lblTotal_AnyErrors.Text = dr("Total_AnyErrors").ToString()
                    End If
                    If Not dr("Total_AnyErrors_Percent") Is DBNull.Value Then
                        lblTotal_AnyErrors_Percent.Text = dr("Total_AnyErrors_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Agreement_Letter_Signed_Errors") Is DBNull.Value Then
                        lblScore_Agreement_Letter_Signed_Errors.Text = dr("Score_Agreement_Letter_Signed_Errors").ToString()
                    End If
                    If Not dr("Score_Agreement_Letter_Signed_Percent") Is DBNull.Value Then
                        lblScore_Agreement_Letter_Signed_Errors_Percent.Text = dr("Score_Agreement_Letter_Signed_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Financial_Documentation_Errors") Is DBNull.Value Then
                        lblScore_Financial_Documentation_Errors.Text = dr("Score_Financial_Documentation_Errors").ToString()
                    End If
                    If Not dr("Score_Financial_Documentation_Percent") Is DBNull.Value Then
                        lblScore_Financial_Documentation_Errors_Percent.Text = dr("Score_Financial_Documentation_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Repayment_Amount_Errors") Is DBNull.Value Then
                        lblScore_Repayment_Amount_Errors.Text = dr("Score_Repayment_Amount_Errors").ToString()
                    End If
                    If Not dr("Score_Repayment_Amount_Percent") Is DBNull.Value Then
                        lblScore_Repayment_Amount_Errors_Percent.Text = dr("Score_Repayment_Amount_Percent").ToString() & "%"
                    End If

                    If Not dr("Score_Tag_Errors") Is DBNull.Value Then
                        lblScore_Tag_Errors.Text = dr("Score_Tag_Errors").ToString()
                    End If
                    If Not dr("Score_Tag_Percent") Is DBNull.Value Then
                        lblScore_Tag_Errors_Percent.Text = dr("Score_Tag_Percent").ToString() & "%"
                    End If
                    If Not dr("PopulationSize") Is DBNull.Value Then
                        lblPopulationSize.Text = dr("PopulationSize").ToString()
                    End If

                End While
            End Using

            Page.DataBind()
            btnSaveReview.Visible = True
            btnExportExcel.Visible = True
            btnFinalReport.Visible = True
            lblUpdateConfirm.Text = ""

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnSaveReview_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertReview", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@DateEntered", SqlDbType.SmallDateTime).Value = Date.Now()
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name
        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@Score_Agreement_Letter_Signed_Errors", SqlDbType.Int).Value = lblScore_Agreement_Letter_Signed_Errors.Text
        cmd.Parameters.Add("@Score_Financial_Documentation_Errors", SqlDbType.Int).Value = lblScore_Financial_Documentation_Errors.Text
        cmd.Parameters.Add("@Score_Repayment_Amount_Errors", SqlDbType.Int).Value = lblScore_Repayment_Amount_Errors.Text
        cmd.Parameters.Add("@Score_Tag_Errors", SqlDbType.Int).Value = lblScore_Tag_Errors.Text
        cmd.Parameters.Add("@Total_AnyErrors", SqlDbType.Int).Value = lblTotal_AnyErrors.Text
        cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = ddlReportQuarter.SelectedValue
        cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = ddlReportYear.SelectedValue()

        Try
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()

            'Notify the user
            lblUpdateConfirm.Text = "Your report was successfully saved"

            'Refresh the Previous Reviews Gridview
            GridView1.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub ddlPCAID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlPCAID.SelectedIndexChanged
        dsPreviousReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
        dsPreviousReviews.DataBind()
    End Sub

    Sub btnExcelExport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("IBRReviewsConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("p_Report_AllAccounts", MyConnection)
        With cmd
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add("@ReportQuarter", SqlDbType.Int)
            .Parameters("@ReportQuarter").Value = ddlReportQuarter.SelectedValue

            .Parameters.Add("@ReportYear", SqlDbType.Int)
            .Parameters("@ReportYear").Value = ddlReportYear.SelectedValue

            .Parameters.Add("@PCAID", SqlDbType.Int)
            .Parameters("@PCAID").Value = ddlPCAID.SelectedValue
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
            Response.Clear()
            Response.ClearContent()
            Response.ContentType = "application/octet-stream"
            Response.AddHeader("Content-Disposition", "attachment; filename=" & ddlPCAID.SelectedItem.Text & ".xls")

            Dim excel As New GridView()
            excel.DataSource = myDataTable
            excel.DataBind()
            excel.RenderControl(New HtmlTextWriter(Response.Output))

            Response.Flush()
            Response.End()

        Finally
            If MyConnection.State <> ConnectionState.Closed Then MyConnection.Close()
            MyConnection.Dispose()
            MyConnection = Nothing
            myDataTable.Dispose()
            myDataTable = Nothing
        End Try

    End Sub

    Protected Sub GridView1_OnRowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            'This section hides or shows the View link next to each saved review record
            'An empty Url value contains 18 characters "ReviewAttachments/" so any value greater than 18 has an associated
            'attachment so we need to display it

            'View Attachment Link
            Dim hypView As HyperLink = e.Row.FindControl("hypViewAttachment")
            If hypView.NavigateUrl.Length > 18 Then
                hypView.Visible = True
            Else
                hypView.Visible = False
            End If

            'Delete Attachment Link
            'Only members of the IBRReviews_Admins group have access to the delete function
            Dim hypDelete As HyperLink = e.Row.FindControl("hypDeleteAttachment")
            If Roles.IsUserInRole("IBRReviews_Admins") = True Then
                hypDelete.Visible = True
            Else
                hypDelete.Visible = False
            End If

        End If
    End Sub

    Sub btnDeleteSavedReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        For Each row As GridViewRow In GridView1.Rows
            Dim checkbox As CheckBox = CType(row.FindControl("cbRows"), CheckBox)

            'Check if the checkbox is checked. 
            If checkbox.Checked Then
                'Retreive the ReviewID
                Dim ReviewID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected Review ID to the Delete command.
                dsPreviousReviews.DeleteParameters("ReviewID").DefaultValue = ReviewID.ToString()
                dsPreviousReviews.Delete()
            End If
        Next row

        GridView1.DataBind()

    End Sub

    Private Function lblScore_CorrectID_Errors() As Object
        Throw New NotImplementedException
    End Function

    Protected Sub btnFinalReport_Click(sener As Object, e As EventArgs)
        Dim strPCA As String = Server.UrlEncode(ddlPCAID.SelectedItem.Text)
        Dim strReportQuarter = ddlReportQuarter.SelectedValue
        Dim strReportYear = ddlReportYear.SelectedValue
        Dim strPCAID = ddlPCAID.SelectedValue

        Response.Redirect("ReportFinal/Report_Final.aspx?ReportQuarter=" & strReportQuarter & "&ReportYear=" & strReportYear & "&PCA=" & strPCA & "&PCAID=" & strPCAID)

    End Sub


End Class
