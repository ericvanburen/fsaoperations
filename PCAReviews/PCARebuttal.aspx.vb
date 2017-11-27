Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class PCAReviews_Report_Summary
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

        End If
    End Sub

    Sub btnSearch_Click(sender As Object, e As EventArgs)
        dsReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
        dsReviews.SelectParameters("ReviewPeriodMonth").DefaultValue = ddlReviewPeriodMonth.SelectedValue
        dsReviews.SelectParameters("ReviewPeriodYear").DefaultValue = ddlReviewPeriodYear.SelectedValue
        btnExportExcel.Visible = True
    End Sub

    Protected Sub ddlPCAID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlPCAID.SelectedIndexChanged
        'dsPreviousReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
        'dsPreviousReviews.DataBind()
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExcelExport_Click(sender As Object, e As EventArgs)
        dsReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
        dsReviews.SelectParameters("ReviewPeriodMonth").DefaultValue = ddlReviewPeriodMonth.SelectedValue
        dsReviews.SelectParameters("ReviewPeriodYear").DefaultValue = ddlReviewPeriodYear.SelectedValue
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        GridView1.Columns(12).Visible = False
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCA_Rebuttal_Report.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then

            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = GridView1.Rows(index)
            Dim strErrorType As String = row.Cells(10).Text

            Dim myHyp As HyperLink = DirectCast(row.Cells(0).FindControl("HyperLink2"), HyperLink)
            Dim ReviewID As String = myHyp.Text

            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(ReviewID, strErrorType)

        End If
    End Sub

    Protected Sub LoadModal(ReviewID As Integer, ErrorType As String)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        'Dim isPCAAdmin As String = lblPCAAdmin.Text.ToString()

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCARebuttalID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = ReviewID
        cmd.Parameters.Add("@Error_Type", SqlDbType.VarChar).Value = ErrorType

        lblReviewID.Text = ReviewID
        lblError_Type.Text = ErrorType

        'Clear the form values from any previous calls
        ddlPCAAgree.SelectedValue = ""
        txtPCAResponseToError.Text = ""
        ddlPCAAddtlRecordingProvided.SelectedValue = ""
        ddlPCACorrectiveTaken.SelectedValue = ""
        txtPCACorrectiveDate.Text = ""
        ddlFSAFinalDecision.SelectedValue = ""
        txtFSACorrectiveAnalysis.Text = ""
        txtFSAFinalComments.Text = ""
        txtDateFinalUpdates.Text = ""
        txtFSACorrectiveActions.Text = ""

        ''Clear the update confirm label
        lblUpdateConfirm.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    'PCAAgree is ordinal 1 in p_PCARebuttalUpdate
                    If Not dr.IsDBNull(1) Then
                        ddlPCAAgree.SelectedValue = dr("PCAAgree")
                    End If

                    'PCAResponseToError is ordinal 2 in p_PCARebuttalUpdate
                    If Not dr.IsDBNull(2) Then
                        txtPCAResponseToError.Text = dr("PCAResponseToError")
                    End If

                    'PCAAddtlRecordingProvided is ordinal 3 in p_PCARebuttalUpdate
                    If Not dr.IsDBNull(3) Then
                        ddlPCAAddtlRecordingProvided.SelectedValue = dr("PCAAddtlRecordingProvided")
                    End If

                    'PCACorrectiveTaken is ordinal 4 in p_PCARebuttalUpdate
                    If Not dr.IsDBNull(4) Then
                        ddlPCACorrectiveTaken.SelectedValue = dr("PCACorrectiveTaken")
                    End If

                    'PCACorrectiveDate is ordinal 5 in p_PCARebuttalUpdate
                    If Not dr.IsDBNull(5) Then
                        txtPCACorrectiveDate.Text = dr("PCACorrectiveDate")
                    End If

                    'FSAFinalDecision - 6
                    If Not dr.IsDBNull(6) Then
                        ddlFSAFinalDecision.SelectedValue = dr("FSAFinalDecision")
                    End If

                    'FSACorrectiveAnalysis - 7
                    If Not dr.IsDBNull(7) Then
                        txtFSACorrectiveAnalysis.Text = dr("FSACorrectiveAnalysis")
                    End If

                    'FSAFinalComments - 8
                    If Not dr.IsDBNull(8) Then
                        txtFSAFinalComments.Text = dr("FSAFinalComments")
                    End If

                    'DateFinalUpdates - 10
                    If Not dr.IsDBNull(10) Then
                        txtDateFinalUpdates.Text = dr("DateFinalUpdates")
                    End If

                    'FSACorrectiveActions 11
                    If Not dr.IsDBNull(11) Then
                        txtFSACorrectiveActions.Text = dr("FSACorrectiveActions")
                    End If


                End While
            End Using
        Finally
            con.Close()
        End Try
    End Sub
    
    Protected Sub btnSaveChanges_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_PCARebuttalUpdate", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Value = lblReviewID.Text
        cmd.Parameters.Add("@Error_Type", SqlDbType.VarChar).Value = lblError_Type.Text

        If Len(ddlPCAAgree.SelectedValue) > 0 Then
            cmd.Parameters.Add("@PCAAgree", SqlDbType.VarChar).Value = ddlPCAAgree.SelectedValue
        Else
            cmd.Parameters.Add("@PCAAgree", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txtPCAResponseToError.Text) > 0 Then
            cmd.Parameters.Add("@PCAResponseToError", SqlDbType.VarChar).Value = txtPCAResponseToError.Text
        Else
            cmd.Parameters.Add("@PCAResponseToError", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ddlPCAAddtlRecordingProvided.SelectedValue) > 0 Then
            cmd.Parameters.Add("@PCAAddtlRecordingProvided", SqlDbType.VarChar).Value = ddlPCAAddtlRecordingProvided.SelectedValue
        Else
            cmd.Parameters.Add("@PCAAddtlRecordingProvided", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(ddlPCACorrectiveTaken.SelectedValue) > 0 Then
            cmd.Parameters.Add("@PCACorrectiveTaken", SqlDbType.VarChar).Value = ddlPCACorrectiveTaken.SelectedValue
        Else
            cmd.Parameters.Add("@PCACorrectiveTaken", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txtPCACorrectiveDate.Text) > 0 Then
            cmd.Parameters.Add("@PCACorrectiveDate", SqlDbType.SmallDateTime).Value = txtPCACorrectiveDate.Text
        Else
            cmd.Parameters.Add("@PCACorrectiveDate", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(ddlFSAFinalDecision.SelectedValue) > 0 Then
            cmd.Parameters.Add("@FSAFinalDecision", SqlDbType.VarChar).Value = ddlFSAFinalDecision.SelectedValue
        Else
            cmd.Parameters.Add("@FSAFinalDecision", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txtFSACorrectiveAnalysis.Text) > 0 Then
            cmd.Parameters.Add("@FSACorrectiveAnalysis", SqlDbType.VarChar).Value = txtFSACorrectiveAnalysis.Text
        Else
            cmd.Parameters.Add("@FSACorrectiveAnalysis", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txtFSAFinalComments.Text) > 0 Then
            cmd.Parameters.Add("@FSAFinalComments", SqlDbType.VarChar).Value = txtFSAFinalComments.Text
        Else
            cmd.Parameters.Add("@FSAFinalComments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txtDateFinalUpdates.Text) > 0 Then
            cmd.Parameters.Add("@DateFinalUpdates", SqlDbType.SmallDateTime).Value = txtDateFinalUpdates.Text
        Else
            cmd.Parameters.Add("@DateFinalUpdates", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        If Len(txtFSACorrectiveActions.Text) > 0 Then
            cmd.Parameters.Add("@FSACorrectiveActions", SqlDbType.VarChar).Value = txtFSACorrectiveActions.Text
        Else
            cmd.Parameters.Add("@FSACorrectiveActions", SqlDbType.VarChar).Value = DBNull.Value
        End If


        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "Your review was updated"
            lblUpdateConfirm.Visible = True
            GridView1.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    

End Class
