Imports System.Data
Imports System.Data.SqlClient
Imports CallHistory

Partial Class CCM_New_FormB
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            lblUserID.Text = HttpContext.Current.User.Identity.Name

            txtDateofReview.Text = Today()
            lblRecordStatus.Text = ""

            'Grab the previously submitted CallCenterID, if any
            If Not Request.QueryString("CallCenterID") Is Nothing Then
                Dim strCallCenterID As String = Request.QueryString("CallCenterID")
                ddlCallCenterID.SelectedValue = strCallCenterID.ToString()
                CallCenterFunction_Lookup(CInt(strCallCenterID))
            End If

            'Set the form focus to Call Center Location to get ready for the first call
            ddlCallCenterID.Focus()
        End If

    End Sub
   

    Sub btnAddCall_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddCall", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@UserID", lblUserID.Text)
        cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        cmd.Parameters.AddWithValue("@AgentID", txtAgentID.Text)
        cmd.Parameters.AddWithValue("@CallID", txtCallID.Text)
        cmd.Parameters.AddWithValue("@DateofReview", txtDateofReview.Text)
        cmd.Parameters.AddWithValue("@BeginTimeofReview", Today() & " " & txtBeginTimeofReview.Text)
        cmd.Parameters.AddWithValue("@EndTimeofReview", Today() & " " & txtEndTimeofReview.Text)
        cmd.Parameters.AddWithValue("@BorrowerAccountNumber", txtBorrowerAccountNumber.Text)
        cmd.Parameters.AddWithValue("@InboundOutbound", ddlInboundOutbound.SelectedValue)
        If ddlSpecialtyLine.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@SpecialtyLine", ddlSpecialtyLine.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@SpecialtyLine", DBNull.Value)
        End If
        cmd.Parameters.AddWithValue("@Escalated", ddlEscalated.SelectedValue)
        cmd.Parameters.AddWithValue("@intro_identified_self", chkintro_identified_self.Checked)
        cmd.Parameters.AddWithValue("@intro_identified_agency", chkintro_identified_agency.Checked)
        cmd.Parameters.AddWithValue("@intro_calls_recorded", chkintro_calls_recorded.Checked)
        cmd.Parameters.AddWithValue("@auth_borrower_name", chkauth_borrower_name.Checked)
        cmd.Parameters.AddWithValue("@auth_id_procedures", chkauth_id_procedures.Checked)
        cmd.Parameters.AddWithValue("@auth_address", chkauth_address.Checked)
        cmd.Parameters.AddWithValue("@auth_phone_number", chkauth_phone_number.Checked)
        cmd.Parameters.AddWithValue("@auth_email", chkauth_email.Checked)
        cmd.Parameters.AddWithValue("@accuracy_polite", chkaccuracy_polite.Checked)
        cmd.Parameters.AddWithValue("@accuracy_enunciating_words", chkaccuracy_enunciating_words.Checked)
        cmd.Parameters.AddWithValue("@accuracy_mainted_control", chkaccuracy_mainted_control.Checked)
        cmd.Parameters.AddWithValue("@accuracy_accurate_info", chkaccuracy_accurate_info.Checked)
        cmd.Parameters.AddWithValue("@accuracy_expedient_correspondence", chkaccuracy_expedient_correspondence.Checked)

        If ddldelinquency_days_delinquent.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@delinquency_days_delinquent", ddldelinquency_days_delinquent.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@delinquency_days_delinquent", DBNull.Value)
        End If

        If ddldelinquency_past_due_amount.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@delinquency_past_due_amount", ddldelinquency_past_due_amount.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@delinquency_past_due_amount", DBNull.Value)
        End If

        If ddldelinquency_forbearance.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@delinquency_forbearance", ddldelinquency_forbearance.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@delinquency_forbearance", DBNull.Value)
        End If

        If ddldelinquency_lower_payment_option.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@delinquency_lower_payment_option", ddldelinquency_lower_payment_option.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@delinquency_lower_payment_option", DBNull.Value)
        End If

        If ddldelinquency_deferment_option.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@delinquency_deferment_option", ddldelinquency_deferment_option.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@delinquency_deferment_option", DBNull.Value)
        End If

        If ddlmilitary_programs.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@military_programs", ddlmilitary_programs.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@military_programs", DBNull.Value)
        End If

        If ddlscra_eligibility_requirements.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@scra_eligibility_requirements", ddlscra_eligibility_requirements.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@scra_eligibility_requirements", DBNull.Value)
        End If

        If ddlscra_borrower_eligibility.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@scra_borrower_eligibility", ddlscra_borrower_eligibility.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@scra_borrower_eligibility", DBNull.Value)
        End If

        If ddlscra_loan_eligibility.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@scra_loan_eligibility", ddlscra_loan_eligibility.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@scra_loan_eligibility", DBNull.Value)
        End If

        If ddlscra_benefits.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@scra_benefits", ddlscra_benefits.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@scra_benefits", DBNull.Value)
        End If

        If ddlhostility_no_interest_payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@hostility_no_interest_payments", ddlhostility_no_interest_payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@hostility_no_interest_payments", DBNull.Value)
        End If

        If ddlhostility_zero_interest.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@hostility_zero_interest", ddlhostility_zero_interest.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@hostility_zero_interest", DBNull.Value)
        End If

        If ddlmilitary_deferment1.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@military_deferment1", ddlmilitary_deferment1.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@military_deferment1", DBNull.Value)
        End If

        If ddlmilitary_deferment2.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@military_deferment2", ddlmilitary_deferment2.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@military_deferment2", DBNull.Value)
        End If

        If ddlnational_guard_forbearance.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@national_guard_forbearance", ddlnational_guard_forbearance.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@national_guard_forbearance", DBNull.Value)
        End If

        If ddlnational_guard_activated_6_months.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@national_guard_activated_6_months", ddlnational_guard_activated_6_months.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@national_guard_activated_6_months", DBNull.Value)
        End If

        If ddlnational_guard_fed_loans_eligible.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@national_guard_fed_loans_eligible", ddlnational_guard_fed_loans_eligible.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@national_guard_fed_loans_eligible", DBNull.Value)
        End If

        If ddldod_forbearance.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@dod_forbearance", ddldod_forbearance.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@dod_forbearance", DBNull.Value)
        End If

        If ddldod_forbearance_fed_loans_eligible.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@dod_forbearance_fed_loans_eligible", ddldod_forbearance_fed_loans_eligible.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@dod_forbearance_fed_loans_eligible", DBNull.Value)
        End If

        If ddldod_postpone_payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@dod_postpone_payments", ddldod_postpone_payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@dod_postpone_payments", DBNull.Value)
        End If

        If ddlpslf_eligibility.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_eligibility", ddlpslf_eligibility.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_eligibility", DBNull.Value)
        End If

        If ddlpslf_loan_types.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_loan_types", ddlpslf_loan_types.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_loan_types", DBNull.Value)
        End If

        If ddlpslf_other_options.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_other_options", ddlpslf_other_options.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_other_options", DBNull.Value)
        End If

        If ddlpslf_120_payments.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_120_payments", ddlpslf_120_payments.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_120_payments", DBNull.Value)
        End If

        If ddlpslf_eligible_payment_plan.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_eligible_payment_plan", ddlpslf_eligible_payment_plan.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_eligible_payment_plan", DBNull.Value)
        End If

        If ddlpslf_fulltime_employment.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_fulltime_employment", ddlpslf_fulltime_employment.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_fulltime_employment", DBNull.Value)
        End If

        If ddlpslf_work_for_pso.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_work_for_pso", ddlpslf_work_for_pso.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_work_for_pso", DBNull.Value)
        End If

        If ddlpslf_consolidating.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@pslf_consolidating", ddlpslf_consolidating.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@pslf_consolidating", DBNull.Value)
        End If

        If ddlteacher_forgiveness_described_eligibility.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teacher_forgiveness_described_eligibility", ddlteacher_forgiveness_described_eligibility.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teacher_forgiveness_described_eligibility", DBNull.Value)
        End If

        If ddlteacher_forgiveness_how_to_apply.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teacher_forgiveness_how_to_apply", ddlteacher_forgiveness_how_to_apply.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teacher_forgiveness_how_to_apply", DBNull.Value)
        End If

        If ddlteacher_forgiveness_explained_benefit.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teacher_forgiveness_explained_benefit", ddlteacher_forgiveness_explained_benefit.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teacher_forgiveness_explained_benefit", DBNull.Value)
        End If

        If ddlteach_advised_conditions.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teach_advised_conditions", ddlteach_advised_conditions.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teach_advised_conditions", DBNull.Value)
        End If

        If ddlteach_advised_borrower.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teach_advised_borrower", ddlteach_advised_borrower.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teach_advised_borrower", DBNull.Value)
        End If

        If ddlteach_advised_service_must_be_completed.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teach_advised_service_must_be_completed", ddlteach_advised_service_must_be_completed.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teach_advised_service_must_be_completed", DBNull.Value)
        End If

        If ddlteach_must_teach_needed_capacity.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teach_must_teach_needed_capacity", ddlteach_must_teach_needed_capacity.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teach_must_teach_needed_capacity", DBNull.Value)
        End If

        If ddlteach_may_request_suspension.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@teach_may_request_suspension", ddlteach_may_request_suspension.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@teach_may_request_suspension", DBNull.Value)
        End If

        If ddltpd_how_to_apply_for_TPD.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_how_to_apply_for_TPD", ddltpd_how_to_apply_for_TPD.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_how_to_apply_for_TPD", DBNull.Value)
        End If

        If ddltpd_collection_will_suspend_120_days.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_collection_will_suspend_120_days", ddltpd_collection_will_suspend_120_days.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_collection_will_suspend_120_days", DBNull.Value)
        End If

        If ddltpd_document_disability.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_document_disability", ddltpd_document_disability.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_document_disability", DBNull.Value)
        End If

        If ddltpd_advised_TPD_application.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_advised_TPD_application", ddltpd_advised_TPD_application.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_advised_TPD_application", DBNull.Value)
        End If

        If ddltpd_procedures_approves_TPD_discharge.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_procedures_approves_TPD_discharge", ddltpd_procedures_approves_TPD_discharge.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_procedures_approves_TPD_discharge", DBNull.Value)
        End If

        If ddltpd_TPD_monitoring_period.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_TPD_monitoring_period", ddltpd_TPD_monitoring_period.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_TPD_monitoring_period", DBNull.Value)
        End If

        If ddltpd_advised_reinstatements.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_advised_reinstatements", ddltpd_advised_reinstatements.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_advised_reinstatements", DBNull.Value)
        End If

        If ddltpd_new_loans_teach_grants.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_new_loans_teach_grants", ddltpd_new_loans_teach_grants.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_new_loans_teach_grants", DBNull.Value)
        End If

        If ddltpd_advised_TPD_refund_procedures.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_advised_TPD_refund_procedures", ddltpd_advised_TPD_refund_procedures.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_advised_TPD_refund_procedures", DBNull.Value)
        End If

        If ddltpd_1099_sent.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@tpd_1099_sent", ddltpd_1099_sent.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@tpd_1099_sent", DBNull.Value)
        End If

        If ddlidr_eligibility.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@idr_eligibility", ddlidr_eligibility.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@idr_eligibility", DBNull.Value)
        End If

        If ddlidr_how_payments_calculated.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@idr_how_payments_calculated", ddlidr_how_payments_calculated.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@idr_how_payments_calculated", DBNull.Value)
        End If

        If ddlidr_qualifying_loans.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@idr_qualifying_loans", ddlidr_qualifying_loans.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@idr_qualifying_loans", DBNull.Value)
        End If

        If ddlidr_how_to_apply.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@idr_how_to_apply", ddlidr_how_to_apply.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@idr_how_to_apply", DBNull.Value)
        End If

        If ddldeferment_meaning_deferment.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@deferment_meaning_deferment", ddldeferment_meaning_deferment.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@deferment_meaning_deferment", DBNull.Value)
        End If

        If ddldeferment_qualifying_deferment.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@deferment_qualifying_deferment", ddldeferment_qualifying_deferment.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@deferment_qualifying_deferment", DBNull.Value)
        End If

        If ddldeferment_how_to_apply.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@deferment_how_to_apply", ddldeferment_how_to_apply.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@deferment_how_to_apply", DBNull.Value)
        End If

        If ddldeferment_length.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@deferment_length", ddldeferment_length.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@deferment_length", DBNull.Value)
        End If

        If ddlforbearance_not_qualified_for_deferment.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@forbearance_not_qualified_for_deferment", ddlforbearance_not_qualified_for_deferment.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@forbearance_not_qualified_for_deferment", DBNull.Value)
        End If

        If ddlforbearance_explained_meaning.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@forbearance_explained_meaning", ddlforbearance_explained_meaning.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@forbearance_explained_meaning", DBNull.Value)
        End If

        If ddlforbearance_provided_documentation.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@forbearance_provided_documentation", ddlforbearance_provided_documentation.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@forbearance_provided_documentation", DBNull.Value)
        End If

        If ddlforbearance_explained_different_types.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@forbearance_explained_different_types", ddlforbearance_explained_different_types.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@forbearance_explained_different_types", DBNull.Value)
        End If

        If ddlforbearance_read_script.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@forbearance_read_script", ddlforbearance_read_script.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@forbearance_read_script", DBNull.Value)
        End If

        If ddlamortization_loan_amount_growing.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@amortization_loan_amount_growing", ddlamortization_loan_amount_growing.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@amortization_loan_amount_growing", DBNull.Value)
        End If

        If ddlamortization_which_payment_plan.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@amortization_which_payment_plan", ddlamortization_which_payment_plan.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@amortization_which_payment_plan", DBNull.Value)
        End If

        If ddlamortization_interest_capitalization.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@amortization_interest_capitalization", ddlamortization_interest_capitalization.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@amortization_interest_capitalization", DBNull.Value)
        End If

        If ddlclosed_school_criteria.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@closed_school_criteria", ddlclosed_school_criteria.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@closed_school_criteria", DBNull.Value)
        End If

        If ddlclosed_school_process.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@closed_school_process", ddlclosed_school_process.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@closed_school_process", DBNull.Value)
        End If

        If ddlclosed_school_approve_deny.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@closed_school_approve_deny", ddlclosed_school_approve_deny.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@closed_school_approve_deny", DBNull.Value)
        End If

        If ddlbankruptcy_bankruptcy_filed.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@bankruptcy_bankruptcy_filed", ddlbankruptcy_bankruptcy_filed.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@bankruptcy_bankruptcy_filed", DBNull.Value)
        End If

        If ddlbankruptcy_additional_information.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@bankruptcy_additional_information", ddlbankruptcy_additional_information.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@bankruptcy_additional_information", DBNull.Value)
        End If

        If ddlbankruptcy_mailing_address.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@bankruptcy_mailing_address", ddlbankruptcy_mailing_address.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@bankruptcy_mailing_address", DBNull.Value)
        End If

        If ddlbankruptcy_notified_internal_parties.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@bankruptcy_notified_internal_parties", ddlbankruptcy_notified_internal_parties.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@bankruptcy_notified_internal_parties", DBNull.Value)
        End If

        If ddldeath_deceased_borrower.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@death_deceased_borrower", ddldeath_deceased_borrower.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@death_deceased_borrower", DBNull.Value)
        End If

        If ddldeath_collected_info_third_party.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@death_collected_info_third_party", ddldeath_collected_info_third_party.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@death_collected_info_third_party", DBNull.Value)
        End If

        If ddldeath_send_documentation.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@death_send_documentation", ddldeath_send_documentation.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@death_send_documentation", DBNull.Value)
        End If

        If ddldeath_death_cert_mailing_address.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@death_death_cert_mailing_address", ddldeath_death_cert_mailing_address.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@death_death_cert_mailing_address", DBNull.Value)
        End If

        If ddldeath_identified_circumstances.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@death_identified_circumstances", ddldeath_identified_circumstances.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@death_identified_circumstances", DBNull.Value)
        End If

        If ddlatb_eligibility_requirements.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@atb_eligibility_requirements", ddlatb_eligibility_requirements.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@atb_eligibility_requirements", DBNull.Value)
        End If

        If ddlatb_take_test.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@atb_take_test", ddlatb_take_test.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@atb_take_test", DBNull.Value)
        End If

        If ddlatb_advised_loans_may_be_discharged.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@atb_advised_loans_may_be_discharged", ddlatb_advised_loans_may_be_discharged.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@atb_advised_loans_may_be_discharged", DBNull.Value)
        End If

        If ddlatb_how_to_send_application.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@atb_how_to_send_application", ddlatb_how_to_send_application.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@atb_how_to_send_application", DBNull.Value)
        End If

        If ddlatb_how_to_complete.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@atb_how_to_complete", ddlatb_how_to_complete.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@atb_how_to_complete", DBNull.Value)
        End If

        If ddlfalsecert_eligibility_requirements.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@falsecert_eligibility_requirements", ddlfalsecert_eligibility_requirements.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@falsecert_eligibility_requirements", DBNull.Value)
        End If

        If ddlfalsecert_how_to_send_application.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@falsecert_how_to_send_application", ddlfalsecert_how_to_send_application.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@falsecert_how_to_send_application", DBNull.Value)
        End If

        If ddlfalsecert_how_to_complete.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@falsecert_how_to_complete", ddlfalsecert_how_to_complete.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@falsecert_how_to_complete", DBNull.Value)
        End If

        If ddlfalsecert_refund_unpaid_refund.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@falsecert_refund_unpaid_refund", ddlfalsecert_refund_unpaid_refund.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@falsecert_refund_unpaid_refund", DBNull.Value)
        End If

        If ddlfalsecert_refund_how_to_send_application.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@falsecert_refund_how_to_send_application", ddlfalsecert_refund_how_to_send_application.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@falsecert_refund_how_to_send_application", DBNull.Value)
        End If

        If ddlfalsecert_refund_how_to_complete.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@falsecert_refund_how_to_complete", ddlfalsecert_refund_how_to_complete.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@falsecert_refund_how_to_complete", DBNull.Value)
        End If

        If ddldocumentation_accuracy.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@documentation_accuracy", ddldocumentation_accuracy.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@documentation_accuracy", DBNull.Value)
        End If

        If ddldocumentation_logged_complaint.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@documentation_logged_complaint", ddldocumentation_logged_complaint.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@documentation_logged_complaint", DBNull.Value)
        End If

        If ddlpayment_accessing_web_account.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@payment_accessing_web_account", ddlpayment_accessing_web_account.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@payment_accessing_web_account", DBNull.Value)
        End If

        If ddlpayment_direct_debit.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@payment_direct_debit", ddlpayment_direct_debit.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@payment_direct_debit", DBNull.Value)
        End If

        If ddlpayment_phone_payment.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@payment_phone_payment", ddlpayment_phone_payment.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@payment_phone_payment", DBNull.Value)
        End If

        If ddlpayment_creditcards_not_accepted.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@payment_creditcards_not_accepted", ddlpayment_creditcards_not_accepted.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@payment_creditcards_not_accepted", DBNull.Value)
        End If

        If ddlpayment_creditcards_emergency.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@payment_creditcards_emergency", ddlpayment_creditcards_emergency.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@payment_creditcards_emergency", DBNull.Value)
        End If

        If ddlconsolidation_explained_benefits.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@consolidation_explained_benefits", ddlconsolidation_explained_benefits.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@consolidation_explained_benefits", DBNull.Value)
        End If

        If ddlconsolidation_program_requirements.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@consolidation_program_requirements", ddlconsolidation_program_requirements.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@consolidation_program_requirements", DBNull.Value)
        End If

        If ddlconsolidation_loan_types.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@consolidation_loan_types", ddlconsolidation_loan_types.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@consolidation_loan_types", DBNull.Value)
        End If

        If ddlconsolidation_explained_app_process.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@consolidation_explained_app_process", ddlconsolidation_explained_app_process.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@consolidation_explained_app_process", DBNull.Value)
        End If

        If ddlresolution_other.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@resolution_other", ddlresolution_other.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@resolution_other", DBNull.Value)
        End If

        If txtComments.Text <> "" Then
            cmd.Parameters.AddWithValue("@comments", txtComments.Text)
        Else
            cmd.Parameters.AddWithValue("@comments", DBNull.Value)
        End If

        cmd.Parameters.AddWithValue("@RecordAdded", DateTime.Now())

        cmd.Parameters.Add("@ReviewID", SqlDbType.Int).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            Dim ReviewID As String = cmd.Parameters("@ReviewID").Value.ToString()
            lblRecordStatus.Text = "Your record was successfully added.  Your Review ID is " & ReviewID.ToString()
            btnAddCall.Visible = False
            btnAddAnotherCall.Visible = True

            'Add the call to the CallHistory table
            Dim newCallHistory As New CallHistory
            newCallHistory.ReviewID = ReviewID
            newCallHistory.UserID = lblUserID.Text
            newCallHistory.EventName = "Call Added"

            'Add new record to CallHistory table
            newCallHistory.AddCallHistory(ReviewID, lblUserID.Text, "Call Added")

            'Now update the general score
            GeneralScore(ReviewID)

            'Now update the method of resolution score
            ResolutionScore(ReviewID)

            'Now get the final score
            TotalScore(ReviewID)

        Finally
            strSQLConn.Close()
        End Try

        'Rebind the page
        Page.DataBind()

    End Sub

    Sub GeneralScore(ReviewID As Integer)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_GeneralScore", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ReviewID", ReviewID)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Catch ex As Exception

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub ResolutionScore(ReviewID As Integer)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ResolutionScore", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ReviewID", ReviewID)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Catch ex As Exception

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub TotalScore(ReviewID As Integer)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_TotalScore", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ReviewID", ReviewID)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Catch ex As Exception

        Finally
            strSQLConn.Close()
        End Try
    End Sub


    Sub btnAddanotherCall_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("FormB.aspx?CallCenterID=" & ddlCallCenterID.SelectedValue)
    End Sub

    Protected Sub CallCenterFunction_Lookup(Optional ByVal CallCenterID As Integer = 0)
        'This looks up the CallCenterFunction value from the CallCenters table based on the selected CallCenterID value
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        Dim strCallCenterFunction As String = ""

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CallCenterFunction_Lookup", con)
        cmd.CommandType = CommandType.StoredProcedure
        If CallCenterID > 0 Then
            cmd.Parameters.AddWithValue("@CallCenterID", CallCenterID)
        Else
            cmd.Parameters.AddWithValue("@CallCenterID", ddlCallCenterID.SelectedValue)
        End If

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()

                While dr.Read()
                    strCallCenterFunction = dr("CallCenterFunction").ToString()
                    lblCallCenterFunction.Text = strCallCenterFunction
                End While
            End Using

            'Change the Account No/NSLDS value
            If strCallCenterFunction = "NSLDS" Then
                lblAcctNSLDS.Text = "NSLDS ID:"
            Else
                lblAcctNSLDS.Text = "Account No:"
            End If

            'set the form focus to Begin Time of Review
            txtBeginTimeofReview.Focus()
        Finally
            dr.Close()
            con.Close()
        End Try
    End Sub

End Class
