Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class PCACalls_ReportsRehab
    Inherits System.Web.UI.Page

    Sub btnSearch_Click(sender As Object, e As EventArgs)
        'First we need to clear the form of any previous search results
        lblTotal_AnyErrors.Text = "0"
        lblTotal_AnyErrors_Percent.Text = "0%"
        lblScore_Rehab_Program.Text = "0"
        lblScore_Rehab_Program_Errors_Percent.Text = "0%"
        lblScore_Rehab_Once.Text = "0"
        lblScore_Rehab_Once_Errors_Percent.Text = "0%"
        lblScore_Nine_Payments.Text = "0"
        lblScore_Nine_Payments_Errors_Percent.Text = "0%"
        lblScore_Loans_Transferred_After_60_Days.Text = "0"
        lblScore_Loans_Transferred_After_60_Days_Errors_Percent.Text = "0%"
        lblScore_Reversed_Payments.Text = "0"
        lblScore_Reversed_Payments_Errors_Percent.Text = "0%"
        lblScore_TOP.Text = "0"
        lblScore_TOP_Errors_Percent.Text = "0%"
        lblScore_AWG.Text = "0"
        lblScore_AWG_Errors_Percent.Text = "0%"
        lblScore_Continue_Payments.Text = "0"
        lblScore_Continue_Payments_Errors_Percent.Text = "0%"
        lblScore_New_Payment_Schedule.Text = "0"
        lblScore_New_Payment_Schedule_Errors_Percent.Text = "0%"
        lblScore_TPD.Text = "0"
        lblScore_TPD_Errors_Percent.Text = "0%"
        lblScore_Eligible_Payment_Plans.Text = "0"
        lblScore_Eligible_Payment_Plans_Errors_Percent.Text = "0%"
        lblScore_Deferment_Forb.Text = "0"
        lblScore_Deferment_Forb_Errors_Percent.Text = "0%"
        lblScore_TitleIV.Text = "0"
        lblScore_TitleIV_Errors_Percent.Text = "0%"
        lblScore_Collection_Charges_Waived.Text = "0"
        lblScore_Collection_Charges_Waived_Errors_Percent.Text = "0%"
        lblScore_TOP_Payment_PIFs_Account.Text = "0"
        lblScore_TOP_Payment_PIFs_Account_Errors_Percent.Text = "0%"
        lblScore_Delay_Tax_Reform.Text = "0"
        lblScore_Delay_Tax_Reform_Errors_Percent.Text = "0%"
        lblScore_More_Aid.Text = "0"
        lblScore_More_Aid_Errors_Percent.Text = "0%"
        lblScore_Collection_Costs_Waived.Text = "0"
        lblScore_Collection_Costs_Waived_Errors_Percent.Text = "0%"
        lblScore_False_Requirements.Text = "0"
        lblScore_False_Requirements_Errors_Percent.Text = "0%"
        lblScore_Not_Factual.Text = "0"
        lblScore_Not_Factual_Errors_Percent.Text = "0%"
        lblScore_Unaffordable_Payments.Text = "0"
        lblScore_Unaffordable_Payments_Errors_Percent.Text = "0%"
        lblScore_Avoid_PIF.Text = "0"
        lblScore_Avoid_PIF_Errors_Percent.Text = "0%"
        lblScore_Rehab_Then_TPD.Text = "0"
        lblScore_Rehab_Then_TPD_Errors_Percent.Text = "0%"
        lblScore_Ineligible_Borrower.Text = "0"
        lblScore_Ineligible_Borrower_Errors_Percent.Text = "0%"
        lblScore_Payments_Are_Final.Text = "0"
        lblScore_Payments_Are_Final_Errors_Percent.Text = "0%"
        lblScore_Credit_All_Negative_Data_Removed.Text = "0"
        lblScore_Credit_All_Negative_Data_Removed_Percent.Text = "0%"
        lblScore_Credit_Never_Defaulted.Text = "0"
        lblScore_Credit_Never_Defaulted_Percent.Text = "0%"
        lblScore_Credit_Score_Will_Improve.Text = "0"
        lblScore_Credit_Score_Will_Improve_Percent.Text = "0%"
        lblPopulationSize.Text = ""

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_RehabReportSummary", con)
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

                    'Total Any Errors
                    If Not dr("Total_AnyErrors") Is DBNull.Value Then
                        lblTotal_AnyErrors.Text = dr("Total_AnyErrors").ToString()
                    End If
                    If Not dr("Total_AnyErrors_Percent") Is DBNull.Value Then
                        lblTotal_AnyErrors_Percent.Text = dr("Total_AnyErrors_Percent").ToString() & "%"
                    End If
      
                    'Score_Rehab_Program
                    If Not dr("Score_Rehab_Program") Is DBNull.Value Then
                        lblScore_Rehab_Program.Text = dr("Score_Rehab_Program").ToString()
                    End If
                    If Not dr("Score_Rehab_Program_Errors_Percent") Is DBNull.Value Then
                        lblScore_Rehab_Program_Errors_Percent.Text = dr("Score_Rehab_Program_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Rehab_Once
                    If Not dr("Score_Rehab_Once") Is DBNull.Value Then
                        lblScore_Rehab_Once.Text = dr("Score_Rehab_Once").ToString()
                    End If
                    If Not dr("Score_Rehab_Once_Errors_Percent") Is DBNull.Value Then
                        lblScore_Rehab_Once_Errors_Percent.Text = dr("Score_Rehab_Once_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Nine_Payments
                    If Not dr("Score_Nine_Payments") Is DBNull.Value Then
                        lblScore_Nine_Payments.Text = dr("Score_Nine_Payments").ToString()
                    End If
                    If Not dr("Score_Nine_Payments_Errors_Percent") Is DBNull.Value Then
                        lblScore_Nine_Payments_Errors_Percent.Text = dr("Score_Nine_Payments_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Loans_Transferred_After_60_Days
                    If Not dr("Score_Loans_Transferred_After_60_Days") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days.Text = dr("Score_Loans_Transferred_After_60_Days").ToString()
                    End If
                    If Not dr("Score_Loans_Transferred_After_60_Days_Errors_Percent") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days_Errors_Percent.Text = dr("Score_Loans_Transferred_After_60_Days_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Reversed_Payments
                    If Not dr("Score_Reversed_Payments") Is DBNull.Value Then
                        lblScore_Reversed_Payments.Text = dr("Score_Reversed_Payments").ToString()
                    End If
                    If Not dr("Score_Reversed_Payments_Errors_Percent") Is DBNull.Value Then
                        lblScore_Reversed_Payments_Errors_Percent.Text = dr("Score_Reversed_Payments_Errors_Percent").ToString() & "%"
                    End If
                    'Score_TOP
                    If Not dr("Score_TOP") Is DBNull.Value Then
                        lblScore_TOP.Text = dr("Score_TOP").ToString()
                    End If
                    If Not dr("Score_TOP_Errors_Percent") Is DBNull.Value Then
                        lblScore_TOP_Errors_Percent.Text = dr("Score_TOP_Errors_Percent").ToString() & "%"
                    End If
                    'Score_AWG
                    If Not dr("Score_AWG") Is DBNull.Value Then
                        lblScore_AWG.Text = dr("Score_AWG").ToString()
                    End If
                    If Not dr("Score_AWG_Errors_Percent") Is DBNull.Value Then
                        lblScore_AWG_Errors_Percent.Text = dr("Score_AWG_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Continue_Payments
                    If Not dr("Score_Continue_Payments") Is DBNull.Value Then
                        lblScore_Continue_Payments.Text = dr("Score_Continue_Payments").ToString()
                    End If
                    If Not dr("Score_Continue_Payments_Errors_Percent") Is DBNull.Value Then
                        lblScore_Continue_Payments_Errors_Percent.Text = dr("Score_Continue_Payments_Errors_Percent").ToString() & "%"
                    End If
                    'Score_New_Payment_Schedule
                    If Not dr("Score_New_Payment_Schedule") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule.Text = dr("Score_New_Payment_Schedule").ToString()
                    End If
                    If Not dr("Score_New_Payment_Schedule_Errors_Percent") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule_Errors_Percent.Text = dr("Score_New_Payment_Schedule_Errors_Percent").ToString() & "%"
                    End If
                    'Score_TPD
                    If Not dr("Score_TPD") Is DBNull.Value Then
                        lblScore_TPD.Text = dr("Score_TPD").ToString()
                    End If
                    If Not dr("Score_TPD_Errors_Percent") Is DBNull.Value Then
                        lblScore_TPD_Errors_Percent.Text = dr("Score_TPD_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Eligible_Payment_Plans
                    If Not dr("Score_Eligible_Payment_Plans") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans.Text = dr("Score_Eligible_Payment_Plans").ToString()
                    End If
                    If Not dr("Score_Eligible_Payment_Plans_Errors_Percent") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans_Errors_Percent.Text = dr("Score_Eligible_Payment_Plans_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Deferment_Forb
                    If Not dr("Score_Deferment_Forb") Is DBNull.Value Then
                        lblScore_Deferment_Forb.Text = dr("Score_Deferment_Forb").ToString()
                    End If
                    If Not dr("Score_Deferment_Forb_Errors_Percent") Is DBNull.Value Then
                        lblScore_Deferment_Forb_Errors_Percent.Text = dr("Score_Deferment_Forb_Errors_Percent").ToString() & "%"
                    End If
                    'Score_TitleIV
                    If Not dr("Score_TitleIV") Is DBNull.Value Then
                        lblScore_TitleIV.Text = dr("Score_TitleIV").ToString()
                    End If
                    If Not dr("Score_TitleIV_Errors_Percent") Is DBNull.Value Then
                        lblScore_TitleIV_Errors_Percent.Text = dr("Score_TitleIV_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Collection_Charges_Waived
                    If Not dr("Score_Collection_Charges_Waived") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived.Text = dr("Score_Collection_Charges_Waived").ToString()
                    End If
                    If Not dr("Score_Collection_Charges_Waived_Errors_Percent") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived_Errors_Percent.Text = dr("Score_Collection_Charges_Waived_Errors_Percent").ToString() & "%"
                    End If
                    'Score_TOP_Payment_PIFs_Account
                    If Not dr("Score_TOP_Payment_PIFs_Account") Is DBNull.Value Then
                        lblScore_TOP_Payment_PIFs_Account.Text = dr("Score_TOP_Payment_PIFs_Account").ToString()
                    End If
                    If Not dr("Score_TOP_Payment_PIFs_Account_Errors_Percent") Is DBNull.Value Then
                        lblScore_TOP_Payment_PIFs_Account_Errors_Percent.Text = dr("Score_TOP_Payment_PIFs_Account_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Delay_Tax_Reform
                    If Not dr("Score_Delay_Tax_Reform") Is DBNull.Value Then
                        lblScore_Delay_Tax_Reform.Text = dr("Score_Delay_Tax_Reform").ToString()
                    End If
                    If Not dr("Score_Delay_Tax_Reform_Errors_Percent") Is DBNull.Value Then
                        lblScore_Delay_Tax_Reform_Errors_Percent.Text = dr("Score_Delay_Tax_Reform_Errors_Percent").ToString() & "%"
                    End If
                    'Score_More_Aid
                    If Not dr("Score_More_Aid") Is DBNull.Value Then
                        lblScore_More_Aid.Text = dr("Score_More_Aid").ToString()
                    End If
                    If Not dr("Score_More_Aid_Errors_Percent") Is DBNull.Value Then
                        lblScore_More_Aid_Errors_Percent.Text = dr("Score_More_Aid_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Collection_Costs_Waived
                    If Not dr("Score_Collection_Costs_Waived") Is DBNull.Value Then
                        lblScore_Collection_Costs_Waived.Text = dr("Score_Collection_Costs_Waived").ToString()
                    End If
                    If Not dr("Score_Collection_Costs_Waived_Errors_Percent") Is DBNull.Value Then
                        lblScore_Collection_Costs_Waived_Errors_Percent.Text = dr("Score_Collection_Costs_Waived_Errors_Percent").ToString() & "%"
                    End If
                    'Score_False_Requirements
                    If Not dr("Score_False_Requirements") Is DBNull.Value Then
                        lblScore_False_Requirements.Text = dr("Score_False_Requirements").ToString()
                    End If
                    If Not dr("Score_False_Requirements_Errors_Percent") Is DBNull.Value Then
                        lblScore_False_Requirements_Errors_Percent.Text = dr("Score_False_Requirements_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Not_Factual
                    If Not dr("Score_Not_Factual") Is DBNull.Value Then
                        lblScore_Not_Factual.Text = dr("Score_Not_Factual").ToString()
                    End If
                    If Not dr("Score_Not_Factual_Errors_Percent") Is DBNull.Value Then
                        lblScore_Not_Factual_Errors_Percent.Text = dr("Score_Not_Factual_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Unaffordable_Payments
                    If Not dr("Score_Unaffordable_Payments") Is DBNull.Value Then
                        lblScore_Unaffordable_Payments.Text = dr("Score_Unaffordable_Payments").ToString()
                    End If
                    If Not dr("Score_Unaffordable_Payments_Errors_Percent") Is DBNull.Value Then
                        lblScore_Unaffordable_Payments_Errors_Percent.Text = dr("Score_Unaffordable_Payments_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Avoid_PIF
                    If Not dr("Score_Avoid_PIF") Is DBNull.Value Then
                        lblScore_Avoid_PIF.Text = dr("Score_Avoid_PIF").ToString()
                    End If
                    If Not dr("Score_Avoid_PIF_Errors_Percent") Is DBNull.Value Then
                        lblScore_Avoid_PIF_Errors_Percent.Text = dr("Score_Avoid_PIF_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Rehab_Then_TPD
                    If Not dr("Score_Rehab_Then_TPD") Is DBNull.Value Then
                        lblScore_Rehab_Then_TPD.Text = dr("Score_Rehab_Then_TPD").ToString()
                    End If
                    If Not dr("Score_Rehab_Then_TPD_Errors_Percent") Is DBNull.Value Then
                        lblScore_Rehab_Then_TPD_Errors_Percent.Text = dr("Score_Rehab_Then_TPD_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Ineligible_Borrower
                    If Not dr("Score_Ineligible_Borrower") Is DBNull.Value Then
                        lblScore_Ineligible_Borrower.Text = dr("Score_Ineligible_Borrower").ToString()
                    End If
                    If Not dr("Score_Ineligible_Borrower_Errors_Percent") Is DBNull.Value Then
                        lblScore_Ineligible_Borrower_Errors_Percent.Text = dr("Score_Ineligible_Borrower_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Payments_Are_Final
                    If Not dr("Score_Payments_Are_Final") Is DBNull.Value Then
                        lblScore_Payments_Are_Final.Text = dr("Score_Payments_Are_Final").ToString()
                    End If
                    If Not dr("Score_Payments_Are_Final_Errors_Percent") Is DBNull.Value Then
                        lblScore_Payments_Are_Final_Errors_Percent.Text = dr("Score_Payments_Are_Final_Errors_Percent").ToString() & "%"
                    End If
                    'Score_Credit_All_Negative_Data_Removed
                    If Not dr("Score_Credit_All_Negative_Data_Removed") Is DBNull.Value Then
                        lblScore_Credit_All_Negative_Data_Removed.Text = dr("Score_Credit_All_Negative_Data_Removed").ToString()
                    End If
                    If Not dr("Score_Credit_All_Negative_Data_Removed_Percent") Is DBNull.Value Then
                        lblScore_Credit_All_Negative_Data_Removed_Percent.Text = dr("Score_Credit_All_Negative_Data_Removed_Percent").ToString() & "%"
                    End If

                    'Score_Credit_Never_Defaulted
                    If Not dr("Score_Credit_Never_Defaulted") Is DBNull.Value Then
                        lblScore_Credit_Never_Defaulted.Text = dr("Score_Credit_Never_Defaulted").ToString()
                    End If
                    If Not dr("Score_Credit_Never_Defaulted_Percent") Is DBNull.Value Then
                        lblScore_Credit_Never_Defaulted_Percent.Text = dr("Score_Credit_Never_Defaulted_Percent").ToString() & "%"
                    End If

                    'Score_Credit_Score_Will_Improve
                    If Not dr("Score_Credit_Score_Will_Improve") Is DBNull.Value Then
                        lblScore_Credit_Score_Will_Improve.Text = dr("Score_Credit_Score_Will_Improve").ToString()
                    End If
                    If Not dr("Score_Credit_Score_Will_Improve_Percent") Is DBNull.Value Then
                        lblScore_Credit_Score_Will_Improve_Percent.Text = dr("Score_Credit_Score_Will_Improve_Percent").ToString() & "%"
                    End If

                    'Population Size
                    If Not dr("PopulationSize") Is DBNull.Value Then
                        lblPopulationSize.Text = dr("PopulationSize").ToString()
                    End If
                End While
            End Using

            Page.DataBind()
            btnSaveRehabReview.Visible = True
            btnExportExcel.Visible = True
            lblUpdateConfirm.Text = ""

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnSaveRehabReview_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertRehabReview", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@DateEntered", SqlDbType.SmallDateTime).Value = Date.Now()
        cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name
        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = ddlPCAID.SelectedValue
        cmd.Parameters.Add("@ReportQuarter", SqlDbType.Int).Value = ddlReportQuarter.SelectedValue
        cmd.Parameters.Add("@ReportYear", SqlDbType.Int).Value = ddlReportYear.SelectedValue
        cmd.Parameters.Add("@Score_Rehab_Program", SqlDbType.Int).Value = lblScore_Rehab_Program.Text
        cmd.Parameters.Add("@Score_Rehab_Once", SqlDbType.Int).Value = lblScore_Rehab_Once.Text
        cmd.Parameters.Add("@Score_Nine_Payments", SqlDbType.Int).Value = lblScore_Nine_Payments.Text
        cmd.Parameters.Add("@Score_Loans_Transferred_After_60_Days", SqlDbType.Int).Value = lblScore_Loans_Transferred_After_60_Days.Text
        cmd.Parameters.Add("@Score_Reversed_Payments", SqlDbType.Int).Value = lblScore_Reversed_Payments.Text
        cmd.Parameters.Add("@Score_TOP", SqlDbType.Int).Value = lblScore_TOP.Text
        cmd.Parameters.Add("@Score_AWG", SqlDbType.Int).Value = lblScore_AWG.Text
        cmd.Parameters.Add("@Score_Continue_Payments", SqlDbType.Int).Value = lblScore_Continue_Payments.Text
        cmd.Parameters.Add("@Score_New_Payment_Schedule", SqlDbType.Int).Value = lblScore_New_Payment_Schedule.Text
        cmd.Parameters.Add("@Score_TPD", SqlDbType.Int).Value = lblScore_TPD.Text
        cmd.Parameters.Add("@Score_Eligible_Payment_Plans", SqlDbType.Int).Value = lblScore_Eligible_Payment_Plans.Text
        cmd.Parameters.Add("@Score_Deferment_Forb", SqlDbType.Int).Value = lblScore_Deferment_Forb.Text
        cmd.Parameters.Add("@Score_TitleIV", SqlDbType.Int).Value = lblScore_TitleIV.Text
        cmd.Parameters.Add("@Score_Collection_Charges_Waived", SqlDbType.Int).Value = lblScore_Collection_Charges_Waived.Text
        cmd.Parameters.Add("@Score_TOP_Payment_PIFs_Account", SqlDbType.Int).Value = lblScore_TOP_Payment_PIFs_Account.Text
        cmd.Parameters.Add("@Score_Delay_Tax_Reform", SqlDbType.Int).Value = lblScore_Delay_Tax_Reform.Text
        cmd.Parameters.Add("@Score_More_Aid", SqlDbType.Int).Value = lblScore_More_Aid.Text
        cmd.Parameters.Add("@Score_Collection_Costs_Waived", SqlDbType.Int).Value = lblScore_Collection_Costs_Waived.Text
        cmd.Parameters.Add("@Score_False_Requirements", SqlDbType.Int).Value = lblScore_False_Requirements.Text
        cmd.Parameters.Add("@Score_Not_Factual", SqlDbType.Int).Value = lblScore_Not_Factual.Text
        cmd.Parameters.Add("@Score_Unaffordable_Payments", SqlDbType.Int).Value = lblScore_Unaffordable_Payments.Text
        cmd.Parameters.Add("@Score_Avoid_PIF", SqlDbType.Int).Value = lblScore_Avoid_PIF.Text
        cmd.Parameters.Add("@Score_Rehab_Then_TPD", SqlDbType.Int).Value = lblScore_Rehab_Then_TPD.Text
        cmd.Parameters.Add("@Score_Ineligible_Borrower", SqlDbType.Int).Value = lblScore_Ineligible_Borrower.Text
        cmd.Parameters.Add("@Score_Payments_Are_Final", SqlDbType.Int).Value = lblScore_Payments_Are_Final.Text
        cmd.Parameters.Add("@Score_Credit_All_Negative_Data_Removed", SqlDbType.Int).Value = lblScore_Credit_All_Negative_Data_Removed.Text
        cmd.Parameters.Add("@Score_Credit_Never_Defaulted", SqlDbType.Int).Value = lblScore_Credit_Never_Defaulted.Text
        cmd.Parameters.Add("@Score_Credit_Score_Will_Improve", SqlDbType.Int).Value = lblScore_Credit_Score_Will_Improve.Text
        cmd.Parameters.Add("@Total_AnyErrors", SqlDbType.Int).Value = lblTotal_AnyErrors.Text

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
        dsPreviousRehabReviews.SelectParameters("PCAID").DefaultValue = ddlPCAID.SelectedValue
        dsPreviousRehabReviews.DataBind()
    End Sub

    Sub btnExcelExport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("p_RehabReport_AllAccounts", MyConnection)
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

            'MyConnection.Open()
            'Response.Clear()
            'Response.ClearHeaders()
            'Dim writer As New CsvWriter(Response.OutputStream, ","c, Encoding.Default)
            'writer.WriteAll(myDataTable, True)
            'writer.Close()

            'Dim FileDate As String = Replace(FormatDateTime(Now(), DateFormat.ShortDate), "/", "")
            'Response.AddHeader("Content-Disposition", "attachment;filename=PCA_Rehab_Call_Review" & FileDate & ".csv")
            'Response.ContentType = "application/vnd.ms-excel"
            'Response.End()

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
            Response.AddHeader("Content-Disposition", "attachment; filename=PCA_Rehab_Call_Review_" & FileDate & ".xls")

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
            'Only members of the PCACalls_Admins group have access to the delete function
            Dim hypDelete As HyperLink = e.Row.FindControl("hypDeleteAttachment")
            If Roles.IsUserInRole("PCACalls_Admins") = True Then
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
                Dim RehabReviewID As Integer = Convert.ToInt32(GridView1.DataKeys(row.RowIndex).Value)
                'Pass the value of the selected Rehab Review ID to the Delete command.
                dsPreviousRehabReviews.DeleteParameters("RehabReviewID").DefaultValue = RehabReviewID.ToString()
                dsPreviousRehabReviews.Delete()
            End If
        Next row

        GridView1.DataBind()

    End Sub

End Class
