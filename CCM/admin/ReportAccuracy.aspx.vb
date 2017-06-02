Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Csv

Partial Class CCM_New_ReportAccuracy
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            txtDateofReviewEnd.Text = Now.ToShortDateString()
            pnlCharts.Visible = False
        End If

    End Sub

    Sub btnAccuracyReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        CallCount()
    End Sub


    Sub CallCount()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim da As SqlDataAdapter
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ReportCallCount", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = ddlCallCenterID.SelectedValue
        cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
        cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text
        da = New SqlDataAdapter(cmd)
        Try
            strSQLConn.Open()
            ds = New DataSet()
            da.Fill(ds)

            rptCenterProfile.DataSource = ds
            rptCenterProfile.DataBind()

            'Create charts
            Chart_CallCount_OneCallCenter()
            Chart_CallCount_AllCenters()
            pnlCharts.Visible = True

            'Create all centers accuracy report
            BindAccuracyReport()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub Chart_CallCount_OneCallCenter()

        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_ChartCallCount_ByCallCenter"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = ddlCallCenterID.SelectedValue
            cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
            cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            ChtCallCount.DataBindTable(myReader, "CallCenter")

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

    Sub Chart_CallCount_AllCenters()

        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_ChartCallCount_AllCallCenter"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@BeginDateofReview", SqlDbType.VarChar).Value = txtDateofReviewBegin.Text
            cmd.Parameters.Add("@EndDateofReview", SqlDbType.VarChar).Value = txtDateofReviewEnd.Text

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            ChtCallCount_AllCenters.DataBindTable(myReader, "CallCenter")

            ChtCallCount_AllCenters.Series(0).IsValueShownAsLabel = False
            ChtCallCount_AllCenters.Series(1).IsValueShownAsLabel = False


            myReader.Close()
            myConnection.Close()

        End Using
    End Sub


    Sub BindAccuracyReport()
        BindAccuracyReport("p_AccuracyReport_G_Name")
        BindAccuracyReport("p_AccuracyReport_G_Clear")
        BindAccuracyReport("p_AccuracyReport_G_Tone")
        BindAccuracyReport("p_AccuracyReport_G_Prompt")
        BindAccuracyReport("p_AccuracyReport_V_Name")
        BindAccuracyReport("p_AccuracyReport_V_SSN")
        BindAccuracyReport("p_AccuracyReport_V_Adrs")
        BindAccuracyReport("p_AccuracyReport_V_Phon1")
        BindAccuracyReport("p_AccuracyReport_V_Phon2")
        BindAccuracyReport("p_AccuracyReport_V_Email")
        BindAccuracyReport("p_AccuracyReport_V_DOB")
        BindAccuracyReport("p_AccuracyReport_L_Interrupt")
        BindAccuracyReport("p_AccuracyReport_L_NoRepeat")
        BindAccuracyReport("p_AccuracyReport_BC_Counseling")
        BindAccuracyReport("p_AccuracyReport_S_Accuracy")
        BindAccuracyReport("p_AccuracyReport_Issue1")
        BindAccuracyReport("p_AccuracyReport_Issue2")
        BindAccuracyReport("p_AccuracyReport_Issue3")
        BindAccuracyReport("p_AccuracyReport_E_Pleasant")
        BindAccuracyReport("p_AccuracyReport_E_NonConfrontational")
        BindAccuracyReport("p_AccuracyReport_E_Timeliness")
        BindAccuracyReport("p_AccuracyReport_C_AllQuestions")
        BindAccuracyReport("p_AccuracyReport_C_Recapped")

    End Sub

    Sub BindAccuracyReport(ByVal sproc As String)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
        cmd = New SqlCommand(sproc, con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        cmd.Parameters.AddWithValue("@BeginDateofReview", txtDateofReviewBegin.Text)
        cmd.Parameters.AddWithValue("@EndDateofReview", txtDateofReviewEnd.Text)

        Try
            con.Open()
            dr = cmd.ExecuteReader(CommandBehavior.CloseConnection)

            'Report Title
            lblReportCallCenter.Text = ddlCallCenterID.SelectedItem.ToString()

            With dr
                If dr.HasRows Then
                    While dr.Read
                        Select Case sproc
                            Case "p_AccuracyReport_G_Name"
                                lblG_Name.Text = dr("G_NamePassed").ToString()
                                lblG_NameCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_NamePctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_G_Clear"
                                lblG_Clear.Text = dr("G_ClearPassed").ToString()
                                lblG_ClearCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_ClearPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_G_Tone"
                                lblG_Tone.Text = dr("G_TonePassed").ToString()
                                lblG_ToneCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_TonePctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_G_Prompt"
                                lblG_Prompt.Text = dr("G_PromptPassed").ToString()
                                lblG_PromptCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblG_PromptPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Name"
                                lblV_Name.Text = dr("V_NamePassed").ToString()
                                lblV_NameCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_NamePctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_SSN"
                                lblV_SSN.Text = dr("V_SSNPassed").ToString()
                                lblV_SSNCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_SSNPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Adrs"
                                lblV_Adrs.Text = dr("V_AdrsPassed").ToString()
                                lblV_AdrsCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_AdrsPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Phon1"
                                lblV_Phon1.Text = dr("V_Phon1Passed").ToString()
                                lblV_Phon1CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_Phon1PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Phon2"
                                lblV_Phon2.Text = dr("V_Phon2Passed").ToString()
                                lblV_Phon2CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_Phon2PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_Email"
                                lblV_Email.Text = dr("V_EmailPassed").ToString()
                                lblV_EmailCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_EmailPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_V_DOB"
                                lblV_DOB.Text = dr("V_DOBPassed").ToString()
                                lblV_DOBCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblV_DOBPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_L_Interrupt"
                                lblL_Interrupt.Text = dr("L_InterruptPassed").ToString()
                                lblL_InterruptCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblL_InterruptPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_L_NoRepeat"
                                lblL_NoRepeat.Text = dr("L_NoRepeatPassed").ToString()
                                lblL_NoRepeatCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblL_NoRepeatPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_BC_Counseling"
                                lblBC_Counseling.Text = dr("BC_CounselingPassed").ToString()
                                lblBC_CounselingCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblBC_CounselingPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_S_Accuracy"
                                lblS_Accuracy.Text = dr("S_AccuracyPassed").ToString()
                                lblS_AccuracyCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblS_AccuracyPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_Issue1"
                                lblIssue1.Text = dr("Issue1Passed").ToString()
                                lblIssue1CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblIssue1PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_Issue2"
                                lblIssue2.Text = dr("Issue2Passed").ToString()
                                lblIssue2CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblIssue2PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_Issue3"
                                lblIssue3.Text = dr("Issue3Passed").ToString()
                                lblIssue3CallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblIssue3PctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_E_Pleasant"
                                lblE_Pleasant.Text = dr("E_PleasantPassed").ToString()
                                lblE_PleasantCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblE_PleasantPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_E_NonConfrontational"
                                lblE_NonConfrontational.Text = dr("E_NonConfrontationalPassed").ToString()
                                lblE_NonConfrontationalCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblE_NonConfrontationalPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_E_Timeliness"
                                lblE_Timeliness.Text = dr("E_TimelinessPassed").ToString()
                                lblE_TimelinessCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblE_TimelinessPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_C_AllQuestions"
                                lblC_AllQuestions.Text = dr("C_AllQuestionsPassed").ToString()
                                lblC_AllQuestionsCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblC_AllQuestionsPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                            Case "p_AccuracyReport_C_Recapped"
                                lblC_Recapped.Text = dr("C_RecappedPassed").ToString()
                                lblC_RecappedCallsReviewed.Text = dr("CallsReviewed").ToString()
                                lblC_RecappedPctngPassed.Text = dr("PctngPassed").ToString() & "%"
                        End Select

                    End While

                    grdVariablePeriod.Visible = False
                    btnExportExcel_VariablePeriod.Visible = False
                    pnlAccuracyReport.Visible = True

                End If
            End With

            'Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub chkCallCount_AllCenters_CheckedChanged(sender As Object, e As System.EventArgs)
        CallCount()
        If chkCallCount_AllCenters.Checked = True Then
            ChtCallCount_AllCenters.Series(0).IsValueShownAsLabel = True
            ChtCallCount_AllCenters.Series(1).IsValueShownAsLabel = True
        Else
            ChtCallCount_AllCenters.Series(0).IsValueShownAsLabel = False
            ChtCallCount_AllCenters.Series(1).IsValueShownAsLabel = False
        End If
    End Sub
End Class
