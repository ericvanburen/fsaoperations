
Partial Class PCAReviews_Report_Errors
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim ErrorType As String = ""
            Dim ErrorDataType As String = ""
            Dim ReviewPeriodMonth As String = ""
            Dim ReviewPeriodYear As String = ""
            Dim PCAID As String = ""

            If Not Request.QueryString("ErrorType") Is Nothing Then
                ErrorType = Request.QueryString("ErrorType")
                ErrorDataType = Request.QueryString("ErrorDataType")
                ReviewPeriodMonth = Request.QueryString("ReviewPeriodMonth")
                ReviewPeriodYear = Request.QueryString("ReviewPeriodYear")
                PCAID = Request.QueryString("PCAID")
            End If

            lblErrorType.Text = ErrorType
            Dim number As Integer = 8

            Select Case ErrorType
                Case "Score_CorrectID"
                    lblErrorType.Text = "General Review Section: Correct ID: Right Party Authentication"
                Case "Score_ProperlyIdentified"
                    lblErrorType.Text = "General Review Section: PCA Properly Identified Itself"
                Case "Score_MiniMiranda"
                    lblErrorType.Text = "General Review Section: Mini-Miranda Provided"
                Case "Score_CallRecording"
                    lblErrorType.Text = "General Review Section: Call Recording"
                Case "Score_Tone"
                    lblErrorType.Text = "General Review Section: PCA Used Professional Tone"
                Case "Score_Accuracy"
                    lblErrorType.Text = "General Review Section: Accurate Information Provided"
                Case "Score_Notepad"
                    lblErrorType.Text = "General Review Section: Accurate Notepad"
                Case "Score_PCAResponsive"
                    lblErrorType.Text = "General Review Section: PCA Was Responsive to the Borrower"
                Case "Score_AWGInfo"
                    lblErrorType.Text = "General Review Section: PCA Provided Accurate AWG Info"
                Case "Score_Disconnect_Borrower"
                    lblErrorType.Text = "General Review Section: PCA Disconnected Borrower"
                Case "Complaint"
                    lblErrorType.Text = "General Review Section: PCA Received a Complaint"
                Case "Score_ExceededHoldTime"
                    lblErrorType.Text = "General Review Section: PCA Exceeed Hold Time"
                
                Case "Score_Rehab_Once"
                    lblErrorType.Text = "Rehab MUST Say: Borrower can rehab only once"
                Case "Score_Nine_Payments"
                    lblErrorType.Text = "Rehab MUST Say: Requires 9 payments over 10 months"
                Case "Score_TitleIV"
                    lblErrorType.Text = "Rehab MUST Say: After 6th payment borr may regain Title IV eligibility"
                Case "Score_Credit_Reporting"
                    lblErrorType.Text = "Rehab MUST Say: Rehab clears bad credit data"
                Case "Score_TOP"
                    lblErrorType.Text = "Rehab MUST Say: TOP stops only after loans are transferred"
                Case "Score_AWG"
                    lblErrorType.Text = "Rehab MUST Say: Can prevent AWG but cannot stop current garnishment"
                Case "Score_Continue_Payments"
                    lblErrorType.Text = "Rehab MUST Say: Must continue payments until transferred"
                Case "Score_TOP_Payment_PIFs_Account"
                    lblErrorType.Text = "Rehab MUST Say: If TOP payment PIFs acount but rehab is complete, credit not cleared"
                Case "Score_Collection_Charges_Waived"
                    lblErrorType.Text = "Rehab MUST Say: At transfer remaining collection charges are waived"
                Case "Score_Financial_Documents"
                    lblErrorType.Text = "Rehab MUST Say: borrower must supply financial documents"
                Case "Score_Rehab_Agreement_Letter"
                    lblErrorType.Text = "Rehab MUST Say: borrower must sign rehab agreement letter (RAL)"
                Case "Score_Contact_Us"
                    lblErrorType.Text = "Rehab MUST Say: contact us"
                Case "Score_Eligible_Payment_Plans"
                    lblErrorType.Text = "Rehab MAY Say: After transfer eligible for pre-default payment plans"
                Case "Score_Deferment_Forb"
                    lblErrorType.Text = "Rehab MAY Say: After transfer borrower may qualify for defer or forb"
                Case "Score_New_Payment_Schedule"
                    lblErrorType.Text = "Rehab MAY Say: Must work out new payment schedule with servicer"
                Case "Score_Reversed_Payments"
                    lblErrorType.Text = "Rehab MAY Say: Reversed or NSF payments can jeopardize rehab"
                Case "Score_Loans_Transferred_After_60_Days"
                    lblErrorType.Text = "Rehab MAY Say: Loan will be transferred to servicer 60 days after rehab"
                Case "Score_Electronic_Payments"
                    lblErrorType.Text = "Rehab MAY Say: Encourage electronic payemnts"
                Case "Score_Rehab_Program"
                    lblErrorType.Text = "Rehab MAY Say: It is a loan rehab program"
                Case "Score_Delay_Tax_Reform"
                    lblErrorType.Text = "Rehab MUST NOT Say: Advised borrower to delay filing tax return"
                Case "Score_More_Aid"
                    lblErrorType.Text = "Rehab MUST NOT Say: Tell the borrower the she will be eligible for Title IV, defer, forb"
                Case "Score_Collection_Costs_Waived"
                    lblErrorType.Text = "Rehab MUST NOT Say: Quote an exact amount of collection costs that will be waived"
                Case "Score_False_Requirements"
                    lblErrorType.Text = "Rehab MUST NOT Say: Impose false requirements"
                Case "Score_Avoid_PIF"
                    lblErrorType.Text = "Rehab MUST NOT Say: Talk the borrower out of PIF or SIF"
                Case "Score_Rehab_Then_TPD"
                    lblErrorType.Text = "Rehab MUST NOT Say: Tell disabled borrower to rehab first then TPD"
                Case "Score_Payments_Are_Final"
                    lblErrorType.Text = "Rehab MUST NOT Say: Tell borrower payment amounts and dates are final"
                Case "Score_Not_Factual"
                    lblErrorType.Text = "Rehab MUST NOT Say: State anything not factual related to ED policy"
                Case "Score_Consol_New_Loan"
                    lblErrorType.Text = "Consol MAY Say: This is a new loan"
                Case "Score_Consol_Credit_Reporting"
                    lblErrorType.Text = "Consol MAY Say: Credit reporting"
                Case "Score_Consol_Interest_Rates"
                    lblErrorType.Text = "Consol MAY Say: Fixed interest rates"
                Case "Score_Consol_Capitalization"
                    lblErrorType.Text = "Consol MAY Say: Capitalization"
                Case "Score_Consol_TitleIV"
                    lblErrorType.Text = "Consol MAY Say: Title IV eligibility"
                Case "Score_Consol_Repayment_Options"
                    lblErrorType.Text = "Consol MAY Say: Repayment options"
                Case "Score_Consol_Default"
                    lblErrorType.Text = "Consol MAY Say: Default"
                Case Else
                    lblErrorType.Text = "Unknown Error Type"
            End Select

            lblReviewPeriodMonth.Text = ReviewPeriodMonth
            lblReviewPeriodYear.Text = ReviewPeriodYear

            dsReportErrors.SelectParameters("ErrorType").DefaultValue = ErrorType
            dsReportErrors.SelectParameters("ErrorDataType").DefaultValue = ErrorDataType
            dsReportErrors.SelectParameters("ReviewPeriodMonth").DefaultValue = ReviewPeriodMonth
            dsReportErrors.SelectParameters("ReviewPeriodYear").DefaultValue = ReviewPeriodYear
            dsReportErrors.SelectParameters("PCAID").DefaultValue = PCAID

            'GridView1.DataBind()
        End If
    End Sub

End Class
