Imports System.Data.SqlClient
Imports System.Data
Imports System.IO
Imports SelectPdf

Partial Class PCAReviews_Report_Final
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Request.QueryString("ReviewPeriodMonth") Is Nothing Then
            Dim strReviewPeriodMonth As String = Request.QueryString("ReviewPeriodMonth")
            Dim strReviewPeriodYear As String = Request.QueryString("ReviewPeriodYear")
            Dim strPCA As String = Server.UrlDecode(Request.QueryString("PCA"))
            Dim strPCAID As String = Server.UrlDecode(Request.QueryString("PCAID"))
            Dim strMonth As String = ""

            lblTodayDate.Text = Date.Today
            lblPCAName.Text = strPCA

            Select Case strReviewPeriodMonth
                Case "01"
                    strMonth = "January"
                Case "02"
                    strMonth = "February"
                Case "03"
                    strMonth = "March"
                Case "04"
                    strMonth = "April"
                Case "05"
                    strMonth = "May"
                Case "06"
                    strMonth = "June"
                Case "07"
                    strMonth = "July"
                Case "08"
                    strMonth = "August"
                Case "09"
                    strMonth = "September"
                Case "10"
                    strMonth = "October"
                Case "11"
                    strMonth = "November"
                Case "12"
                    strMonth = "December"
            End Select

            lblReviewPeriod.Text = strMonth & ", " & strReviewPeriodYear
            lblReviewPeriod2.Text = strMonth & ", " & strReviewPeriodYear

            lblPDFUrl.Text = "http://localhost:55389/PCAReviews/ReportFinal/Report_Final.aspx?ReviewPeriodMonth=" & strReviewPeriodMonth & "&ReviewPeriodYear=" & strReviewPeriodYear & "&PCA=" & strPCA & "&PCAID=" & strPCAID
            'ChartGeneralCallReview(strPCAID, strReviewPeriodMonth, strReviewPeriodYear)
            ErrorData(strPCAID, strReviewPeriodMonth, strReviewPeriodYear)
        End If
    End Sub

    Sub ChartGeneralCallReview(ByVal PCAID As Integer, ByVal ReportPeriodMonth As String, ByVal ReportPeriodYear As String)
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_ReportCountCorrectIncorrectPerSection"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = PCAID
            cmd.Parameters.Add("@ReportPeriodMonth", SqlDbType.VarChar).Value = ReportPeriodMonth
            cmd.Parameters.Add("@ReportPeriodYear", SqlDbType.VarChar).Value = ReportPeriodYear
            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtGeneralCallReview0.DataBindTable(myReader, "General_Review_Total_Incorrect")
            chtGeneralCallReview0.Series(0).IsValueShownAsLabel = True

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

    Sub ErrorData(ByVal PCAID As String, ByVal ReportPeriodMonth As String, ByVal ReportPeriodYear As String)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReportSummaryForPCA", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@PCAID", SqlDbType.Int).Value = PCAID
        cmd.Parameters.Add("@ReviewPeriodMonth", SqlDbType.VarChar).Value = ReportPeriodMonth
        cmd.Parameters.Add("@ReviewPeriodYear", SqlDbType.VarChar).Value = ReportPeriodYear

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()

                    'Number of Reviews
                    If Not dr("PopulationSize") Is DBNull.Value Then
                        lblPopulationSize4.Text = dr("PopulationSize").ToString()
                    End If

                    'Correct ID
                    If Not dr("Score_CorrectID_Total") Is DBNull.Value Then
                        lblScore_CorrectID_Total.Text = dr("Score_CorrectID_Total").ToString()
                    End If
                    If Not dr("Score_CorrectID_Incorrect") Is DBNull.Value Then
                        lblScore_CorrectID_Incorrect.Text = dr("Score_CorrectID_Incorrect").ToString()
                    End If
                    If Not dr("Score_CorrectID_Percent") Is DBNull.Value Then
                        lblScore_CorrectID_Percent.Text = dr("Score_CorrectID_Percent").ToString() & "%"
                    End If

                    'Properly Identified
                    If Not dr("Score_ProperlyIdentified_Total") Is DBNull.Value Then
                        lblScore_ProperlyIdentified_Total.Text = dr("Score_ProperlyIdentified_Total").ToString()
                    End If
                    If Not dr("Score_ProperlyIdentified_Incorrect") Is DBNull.Value Then
                        lblScore_ProperlyIdentified_Incorrect.Text = dr("Score_ProperlyIdentified_Incorrect").ToString()
                    End If
                    If Not dr("Score_ProperlyIdentified_Percent") Is DBNull.Value Then
                        lblScore_ProperlyIdentified_Percent.Text = dr("Score_ProperlyIdentified_Percent").ToString() & "%"
                    End If

                    'MiniMiranda
                    If Not dr("Score_MiniMiranda_Total") Is DBNull.Value Then
                        lblScore_MiniMiranda_Total.Text = dr("Score_MiniMiranda_Total").ToString()
                    End If
                    If Not dr("Score_MiniMiranda_Incorrect") Is DBNull.Value Then
                        lblScore_MiniMiranda_Incorrect.Text = dr("Score_MiniMiranda_Incorrect").ToString()
                    End If
                    If Not dr("Score_MiniMiranda_Percent") Is DBNull.Value Then
                        lblScore_MiniMiranda_Percent.Text = dr("Score_MiniMiranda_Percent").ToString() & "%"
                    End If

                    'CallRecording
                    If Not dr("Score_CallRecording_Total") Is DBNull.Value Then
                        lblScore_CallRecording_Total.Text = dr("Score_CallRecording_Total").ToString()
                    End If
                    If Not dr("Score_CallRecording_Incorrect") Is DBNull.Value Then
                        lblScore_CallRecording_Incorrect.Text = dr("Score_CallRecording_Incorrect").ToString()
                    End If
                    If Not dr("Score_CallRecording_Percent") Is DBNull.Value Then
                        lblScore_CallRecording_Percent.Text = dr("Score_CallRecording_Percent").ToString() & "%"
                    End If

                    'Score_Tone
                    If Not dr("Score_Tone_Total") Is DBNull.Value Then
                        lblScore_Tone_Total.Text = dr("Score_Tone_Total").ToString()
                    End If
                    If Not dr("Score_Tone_Incorrect") Is DBNull.Value Then
                        lblScore_Tone_Incorrect.Text = dr("Score_Tone_Incorrect").ToString()
                    End If
                    If Not dr("Score_Tone_Percent") Is DBNull.Value Then
                        lblScore_Tone_Percent.Text = dr("Score_Tone_Percent").ToString() & "%"
                    End If

                    'Score_Accuracy
                    If Not dr("Score_Accuracy_Total") Is DBNull.Value Then
                        lblScore_Accuracy_Total.Text = dr("Score_Accuracy_Total").ToString()
                    End If
                    If Not dr("Score_Accuracy_Incorrect") Is DBNull.Value Then
                        lblScore_Accuracy_Incorrect.Text = dr("Score_Accuracy_Incorrect").ToString()
                    End If
                    If Not dr("Score_Accuracy_Percent") Is DBNull.Value Then
                        lblScore_Accuracy_Percent.Text = dr("Score_Accuracy_Percent").ToString() & "%"
                    End If

                    'Score_Notepad
                    If Not dr("Score_Notepad_Total") Is DBNull.Value Then
                        lblScore_Notepad_Total.Text = dr("Score_Notepad_Total").ToString()
                    End If
                    If Not dr("Score_Notepad_Incorrect") Is DBNull.Value Then
                        lblScore_Notepad_Incorrect.Text = dr("Score_Notepad_Incorrect").ToString()
                    End If
                    If Not dr("Score_Notepad_Percent") Is DBNull.Value Then
                        lblScore_Notepad_Percent.Text = dr("Score_Notepad_Percent").ToString() & "%"
                    End If

                    'Score_PCAResponsive
                    If Not dr("Score_PCAResponsive_Total") Is DBNull.Value Then
                        lblScore_PCAResponsive_Total.Text = dr("Score_PCAResponsive_Total").ToString()
                    End If
                    If Not dr("Score_PCAResponsive_Incorrect") Is DBNull.Value Then
                        lblScore_PCAResponsive_Incorrect.Text = dr("Score_PCAResponsive_Incorrect").ToString()
                    End If
                    If Not dr("Score_PCAResponsive_Percent") Is DBNull.Value Then
                        lblScore_PCAResponsive_Percent.Text = dr("Score_PCAResponsive_Percent").ToString() & "%"
                    End If

                    'Score_AWGInfo
                    If Not dr("Score_AWGInfo_Total") Is DBNull.Value Then
                        lblScore_AWGInfo_Total.Text = dr("Score_AWGInfo_Total").ToString()
                    End If
                    If Not dr("Score_AWGInfo_Incorrect") Is DBNull.Value Then
                        lblScore_AWGInfo_Incorrect.Text = dr("Score_AWGInfo_Incorrect").ToString()
                    End If
                    If Not dr("Score_AWGInfo_Percent") Is DBNull.Value Then
                        lblScore_AWGInfo_Percent.Text = dr("Score_AWGInfo_Percent").ToString() & "%"
                    End If

                    'Score_Complaint
                    If Not dr("Score_Complaint_Total") Is DBNull.Value Then
                        lblScore_Complaint_Total.Text = dr("Score_Complaint_Total").ToString()
                    End If
                    If Not dr("Score_Complaint_Incorrect") Is DBNull.Value Then
                        lblScore_Complaint_Incorrect.Text = dr("Score_Complaint_Incorrect").ToString()
                    End If
                    If Not dr("Score_Complaint_Percent") Is DBNull.Value Then
                        lblScore_Complaint_Percent.Text = dr("Score_Complaint_Percent").ToString() & "%"
                    End If

                    'Score_ExceededHoldTime
                    If Not dr("Score_ExceededHoldTime_Total") Is DBNull.Value Then
                        lblScore_ExceededHoldTime_Total.Text = dr("Score_ExceededHoldTime_Total").ToString()
                    End If
                    If Not dr("Score_ExceededHoldTime_Incorrect") Is DBNull.Value Then
                        lblScore_ExceededHoldTime_Incorrect.Text = dr("Score_ExceededHoldTime_Incorrect").ToString()
                    End If
                    If Not dr("Score_ExceededHoldTime_Percent") Is DBNull.Value Then
                        lblScore_ExceededHoldTime_Percent.Text = dr("Score_ExceededHoldTime_Percent").ToString() & "%"
                    End If

                    'Score_Disconnect_Borrower
                    'We aren't counting correct actions for PCA Disconnected Borrower
                    'If Not dr("Score_Disconnect_Borrower_Total") Is DBNull.Value Then
                    'lblScore_Disconnect_Borrower_Total.Text = dr("Score_Disconnect_Borrower_Total").ToString()
                    'End If
                    If Not dr("Score_Disconnect_Borrower_Incorrect") Is DBNull.Value Then
                        lblScore_Disconnect_Borrower_Incorrect.Text = dr("Score_Disconnect_Borrower_Incorrect").ToString()
                    End If
                    'If Not dr("Score_Disconnect_Borrower_Percent") Is DBNull.Value Then
                    'lblScore_Disconnect_Borrower_Percent.Text = dr("Score_Disconnect_Borrower_Percent").ToString() & "%"
                    'End If                    

                    'Score_Rehab_Once
                    If Not dr("Score_Rehab_Once_Total") Is DBNull.Value Then
                        lblScore_Rehab_Once_Total.Text = dr("Score_Rehab_Once_Total").ToString()
                    End If
                    If Not dr("Score_Rehab_Once_Incorrect") Is DBNull.Value Then
                        lblScore_Rehab_Once_Incorrect.Text = dr("Score_Rehab_Once_Incorrect").ToString()
                    End If
                    If Not dr("Score_Rehab_Once_Percent") Is DBNull.Value Then
                        lblScore_Rehab_Once_Percent.Text = dr("Score_Rehab_Once_Percent").ToString() & "%"
                    End If

                    'Score_Nine_Payments
                    If Not dr("Score_Nine_Payments_Total") Is DBNull.Value Then
                        lblScore_Nine_Payments_Total.Text = dr("Score_Nine_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Nine_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Nine_Payments_Incorrect.Text = dr("Score_Nine_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Nine_Payments_Percent") Is DBNull.Value Then
                        lblScore_Nine_Payments_Percent.Text = dr("Score_Nine_Payments_Percent").ToString() & "%"
                    End If

                    'Score_TitleIV
                    If Not dr("Score_TitleIV_Total") Is DBNull.Value Then
                        lblScore_TitleIV_Total.Text = dr("Score_TitleIV_Total").ToString()
                    End If
                    If Not dr("Score_TitleIV_Incorrect") Is DBNull.Value Then
                        lblScore_TitleIV_Incorrect.Text = dr("Score_TitleIV_Incorrect").ToString()
                    End If
                    If Not dr("Score_TitleIV_Percent") Is DBNull.Value Then
                        lblScore_TitleIV_Percent.Text = dr("Score_TitleIV_Percent").ToString() & "%"
                    End If

                    'Score_Credit_Reporting
                    If Not dr("Score_Credit_Reporting_Total") Is DBNull.Value Then
                        lblScore_Credit_Reporting_Total.Text = dr("Score_Credit_Reporting_Total").ToString()
                    End If
                    If Not dr("Score_Credit_Reporting_Incorrect") Is DBNull.Value Then
                        lblScore_Credit_Reporting_Incorrect.Text = dr("Score_Credit_Reporting_Incorrect").ToString()
                    End If
                    If Not dr("Score_Credit_Reporting_Percent") Is DBNull.Value Then
                        lblScore_Credit_Reporting_Percent.Text = dr("Score_Credit_Reporting_Percent").ToString() & "%"
                    End If

                    'Score_TOP
                    If Not dr("Score_TOP_Total") Is DBNull.Value Then
                        lblScore_TOP_Total.Text = dr("Score_TOP_Total").ToString()
                    End If
                    If Not dr("Score_TOP_Incorrect") Is DBNull.Value Then
                        lblScore_TOP_Incorrect.Text = dr("Score_TOP_Incorrect").ToString()
                    End If
                    If Not dr("Score_TOP_Percent") Is DBNull.Value Then
                        lblScore_TOP_Percent.Text = dr("Score_TOP_Percent").ToString() & "%"
                    End If

                    'Score_AWG
                    If Not dr("Score_AWG_Total") Is DBNull.Value Then
                        lblScore_AWG_Total.Text = dr("Score_AWG_Total").ToString()
                    End If
                    If Not dr("Score_AWG_Incorrect") Is DBNull.Value Then
                        lblScore_AWG_Incorrect.Text = dr("Score_AWG_Incorrect").ToString()
                    End If
                    If Not dr("Score_AWG_Percent") Is DBNull.Value Then
                        lblScore_AWG_Percent.Text = dr("Score_AWG_Percent").ToString() & "%"
                    End If

                    'Score_Continue_Payments
                    If Not dr("Score_Continue_Payments_Total") Is DBNull.Value Then
                        lblScore_Continue_Payments_Total.Text = dr("Score_Continue_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Continue_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Continue_Payments_Incorrect.Text = dr("Score_Continue_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Continue_Payments_Percent") Is DBNull.Value Then
                        lblScore_Continue_Payments_Percent.Text = dr("Score_Continue_Payments_Percent").ToString() & "%"
                    End If

                    'Score_Collection_Charges_Waived
                    If Not dr("Score_Collection_Charges_Waived_Total") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived_Total.Text = dr("Score_Collection_Charges_Waived_Total").ToString()
                    End If
                    If Not dr("Score_Collection_Charges_Waived_Incorrect") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived_Incorrect.Text = dr("Score_Collection_Charges_Waived_Incorrect").ToString()
                    End If
                    If Not dr("Score_Collection_Charges_Waived_Percent") Is DBNull.Value Then
                        lblScore_Collection_Charges_Waived_Percent.Text = dr("Score_Collection_Charges_Waived_Percent").ToString() & "%"
                    End If

                    'Score_Financial_Documents
                    If Not dr("Score_Financial_Documents_Total") Is DBNull.Value Then
                        lblScore_Financial_Documents_Total.Text = dr("Score_Financial_Documents_Total").ToString()
                    End If
                    If Not dr("Score_Financial_Documents_Incorrect") Is DBNull.Value Then
                        lblScore_Financial_Documents_Incorrect.Text = dr("Score_Financial_Documents_Incorrect").ToString()
                    End If
                    If Not dr("Score_Financial_Documents_Percent") Is DBNull.Value Then
                        lblScore_Financial_Documents_Percent.Text = dr("Score_Financial_Documents_Percent").ToString() & "%"
                    End If

                    'Score_Rehab_Agreement_Letter
                    If Not dr("Score_Rehab_Agreement_Letter_Total") Is DBNull.Value Then
                        lblScore_Rehab_Agreement_Letter_Total.Text = dr("Score_Rehab_Agreement_Letter_Total").ToString()
                    End If
                    If Not dr("Score_Rehab_Agreement_Letter_Incorrect") Is DBNull.Value Then
                        lblScore_Rehab_Agreement_Letter_Incorrect.Text = dr("Score_Rehab_Agreement_Letter_Incorrect").ToString()
                    End If
                    If Not dr("Score_Rehab_Agreement_Letter_Percent") Is DBNull.Value Then
                        lblScore_Rehab_Agreement_Letter_Percent.Text = dr("Score_Rehab_Agreement_Letter_Percent").ToString() & "%"
                    End If

                    'Score_Contact_Us
                    If Not dr("Score_Contact_Us_Total") Is DBNull.Value Then
                        lblScore_Contact_Us_Total.Text = dr("Score_Contact_Us_Total").ToString()
                    End If
                    If Not dr("Score_Contact_Us_Incorrect") Is DBNull.Value Then
                        lblScore_Contact_Us_Incorrect.Text = dr("Score_Contact_Us_Incorrect").ToString()
                    End If
                    If Not dr("Score_Contact_Us_Percent") Is DBNull.Value Then
                        lblScore_Contact_Us_Percent.Text = dr("Score_Contact_Us_Percent").ToString() & "%"
                    End If

                    'Score_Eligible_Payment_Plans
                    If Not dr("Score_Eligible_Payment_Plans_Total") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans_Total.Text = dr("Score_Eligible_Payment_Plans_Total").ToString()
                    End If
                    If Not dr("Score_Eligible_Payment_Plans_Incorrect") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans_Incorrect.Text = dr("Score_Eligible_Payment_Plans_Incorrect").ToString()
                    End If
                    If Not dr("Score_Eligible_Payment_Plans_Percent") Is DBNull.Value Then
                        lblScore_Eligible_Payment_Plans_Percent.Text = dr("Score_Eligible_Payment_Plans_Percent").ToString() & "%"
                    End If

                    'Score_Deferment_Forb
                    If Not dr("Score_Deferment_Forb_Total") Is DBNull.Value Then
                        lblScore_Deferment_Forb_Total.Text = dr("Score_Deferment_Forb_Total").ToString()
                    End If
                    If Not dr("Score_Deferment_Forb_Incorrect") Is DBNull.Value Then
                        lblScore_Deferment_Forb_Incorrect.Text = dr("Score_Deferment_Forb_Incorrect").ToString()
                    End If
                    If Not dr("Score_Deferment_Forb_Percent") Is DBNull.Value Then
                        lblScore_Deferment_Forb_Percent.Text = dr("Score_Deferment_Forb_Percent").ToString() & "%"
                    End If

                    'Score_New_Payment_Schedule
                    If Not dr("Score_New_Payment_Schedule_Total") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule_Total.Text = dr("Score_New_Payment_Schedule_Total").ToString()
                    End If
                    If Not dr("Score_New_Payment_Schedule_Incorrect") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule_Incorrect.Text = dr("Score_New_Payment_Schedule_Incorrect").ToString()
                    End If
                    If Not dr("Score_New_Payment_Schedule_Percent") Is DBNull.Value Then
                        lblScore_New_Payment_Schedule_Percent.Text = dr("Score_New_Payment_Schedule_Percent").ToString() & "%"
                    End If

                    'Score_Reversed_Payments
                    If Not dr("Score_Reversed_Payments_Total") Is DBNull.Value Then
                        lblScore_Reversed_Payments_Total.Text = dr("Score_Reversed_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Reversed_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Reversed_Payments_Incorrect.Text = dr("Score_Reversed_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Reversed_Payments_Percent") Is DBNull.Value Then
                        lblScore_Reversed_Payments_Percent.Text = dr("Score_Reversed_Payments_Percent").ToString() & "%"
                    End If

                    'Score_Loans_Transferred_After_60_Days
                    If Not dr("Score_Loans_Transferred_After_60_Days_Total") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days_Total.Text = dr("Score_Loans_Transferred_After_60_Days_Total").ToString()
                    End If
                    If Not dr("Score_Loans_Transferred_After_60_Days_Incorrect") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days_Incorrect.Text = dr("Score_Loans_Transferred_After_60_Days_Incorrect").ToString()
                    End If
                    If Not dr("Score_Loans_Transferred_After_60_Days_Percent") Is DBNull.Value Then
                        lblScore_Loans_Transferred_After_60_Days_Percent.Text = dr("Score_Loans_Transferred_After_60_Days_Percent").ToString() & "%"
                    End If

                    'Score_Electronic_Payments
                    If Not dr("Score_Electronic_Payments_Total") Is DBNull.Value Then
                        lblScore_Electronic_Payments_Total.Text = dr("Score_Electronic_Payments_Total").ToString()
                    End If
                    If Not dr("Score_Electronic_Payments_Incorrect") Is DBNull.Value Then
                        lblScore_Electronic_Payments_Incorrect.Text = dr("Score_Electronic_Payments_Incorrect").ToString()
                    End If
                    If Not dr("Score_Electronic_Payments_Percent") Is DBNull.Value Then
                        lblScore_Electronic_Payments_Percent.Text = dr("Score_Electronic_Payments_Percent").ToString() & "%"
                    End If

                    'Score_Consol_New_Loan
                    If Not dr("Score_Consol_New_Loan_Total") Is DBNull.Value Then
                        lblScore_Consol_New_Loan_Total.Text = dr("Score_Consol_New_Loan_Total").ToString()
                    End If
                    If Not dr("Score_Consol_New_Loan_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_New_Loan_Incorrect.Text = dr("Score_Consol_New_Loan_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_New_Loan_Percent") Is DBNull.Value Then
                        lblScore_Consol_New_Loan_Percent.Text = dr("Score_Consol_New_Loan_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Credit_Reporting
                    If Not dr("Score_Consol_Credit_Reporting_Total") Is DBNull.Value Then
                        lblScore_Consol_Credit_Reporting_Total.Text = dr("Score_Consol_Credit_Reporting_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Credit_Reporting_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Credit_Reporting_Incorrect.Text = dr("Score_Consol_Credit_Reporting_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Credit_Reporting_Percent") Is DBNull.Value Then
                        lblScore_Consol_Credit_Reporting_Percent.Text = dr("Score_Consol_Credit_Reporting_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Interest_Rates
                    If Not dr("Score_Consol_Interest_Rates_Total") Is DBNull.Value Then
                        lblScore_Consol_Interest_Rates_Total.Text = dr("Score_Consol_Interest_Rates_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Interest_Rates_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Interest_Rates_Incorrect.Text = dr("Score_Consol_Interest_Rates_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Interest_Rates_Percent") Is DBNull.Value Then
                        lblScore_Consol_Interest_Rates_Percent.Text = dr("Score_Consol_Interest_Rates_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Capitalization
                    If Not dr("Score_Consol_Capitalization_Total") Is DBNull.Value Then
                        lblScore_Consol_Capitalization_Total.Text = dr("Score_Consol_Capitalization_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Capitalization_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Capitalization_Incorrect.Text = dr("Score_Consol_Capitalization_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Capitalization_Percent") Is DBNull.Value Then
                        lblScore_Consol_Capitalization_Percent.Text = dr("Score_Consol_Capitalization_Percent").ToString() & "%"
                    End If

                    'Score_Consol_TitleIV
                    If Not dr("Score_Consol_TitleIV_Total") Is DBNull.Value Then
                        lblScore_Consol_TitleIV_Total.Text = dr("Score_Consol_TitleIV_Total").ToString()
                    End If
                    If Not dr("Score_Consol_TitleIV_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_TitleIV_Incorrect.Text = dr("Score_Consol_TitleIV_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_TitleIV_Percent") Is DBNull.Value Then
                        lblScore_Consol_TitleIV_Percent.Text = dr("Score_Consol_TitleIV_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Repayment_Options
                    If Not dr("Score_Consol_Repayment_Options_Total") Is DBNull.Value Then
                        lblScore_Consol_Repayment_Options_Total.Text = dr("Score_Consol_Repayment_Options_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Repayment_Options_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Repayment_Options_Incorrect.Text = dr("Score_Consol_Repayment_Options_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Repayment_Options_Percent") Is DBNull.Value Then
                        lblScore_Consol_Repayment_Options_Percent.Text = dr("Score_Consol_Repayment_Options_Percent").ToString() & "%"
                    End If

                    'Score_Consol_Default
                    If Not dr("Score_Consol_Default_Total") Is DBNull.Value Then
                        lblScore_Consol_Default_Total.Text = dr("Score_Consol_Default_Total").ToString()
                    End If
                    If Not dr("Score_Consol_Default_Incorrect") Is DBNull.Value Then
                        lblScore_Consol_Default_Incorrect.Text = dr("Score_Consol_Default_Incorrect").ToString()
                    End If
                    If Not dr("Score_Consol_Default_Percent") Is DBNull.Value Then
                        lblScore_Consol_Default_Percent.Text = dr("Score_Consol_Default_Percent").ToString() & "%"
                    End If


                End While
            End Using

            Page.DataBind()

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub btnExportPDF_Click(sender As Object, e As ImageClickEventArgs)

        ' instantiate a html to pdf converter object
        Dim converter As New HtmlToPdf()

        ' create a new pdf document converting an url
        Dim doc As PdfDocument = converter.ConvertUrl(lblPDFUrl.Text)

        ' save pdf document
        doc.Save(Response, False, lblPCAName.Text & ".pdf")
        'doc.Save(Response, False, "FinalReport.pdf")

        ' close pdf document
        doc.Close()
    End Sub
End Class
