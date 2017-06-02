Imports System.Data
Imports System.Data.SqlClient
Imports CallHistory

Partial Class CCM_New_FormBDetail
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

            Dim blnAdmin As Boolean

            'First check for a valid, logged in user
            lblUserID.Text = HttpContext.Current.User.Identity.Name

            'Delete call button is visible only to those in the CCM_Admin group
            'Date of Review is enabled only to those in the CCM_Admin group
            If Roles.IsUserInRole("CCM_Admins") = True Then
                btnDeleteCall.Visible = True
                blnAdmin = True
            Else
                btnDeleteCall.Visible = False
                blnAdmin = False
            End If

            Dim DateofReview As TextBox
            Dim CallCenterID As DropDownList
            Dim BeginTimeofReview As TextBox
            Dim EndTimeofReview As TextBox
            Dim dataItem As RepeaterItem
            For Each dataItem In Repeater1.Items
                DateofReview = CType(dataItem.FindControl("txtDateofReview"), TextBox)
                CallCenterID = CType(dataItem.FindControl("ddlCallCenterID"), DropDownList)
                BeginTimeofReview = CType(dataItem.FindControl("txtBeginTimeofReview"), TextBox)
                EndTimeofReview = CType(dataItem.FindControl("txtEndTimeofReview"), TextBox)
                If blnAdmin = True Then
                    DateofReview.Enabled = True
                    CallCenterID.Enabled = True
                    BeginTimeofReview.Enabled = True
                    EndTimeofReview.Enabled = True
                Else
                    DateofReview.Enabled = False
                    CallCenterID.Enabled = False
                    BeginTimeofReview.Enabled = False
                    EndTimeofReview.Enabled = False
                End If
            Next

            Dim intReviewID = Request.QueryString("ReviewID")
            lblReviewID2.Text = intReviewID.ToString()

            'Bind the form with all values
            BindForm(intReviewID)
            
        End If
    End Sub


    Sub BindForm(ByVal ReviewID As Integer)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim da As SqlDataAdapter
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_BindCall_FormB", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ReviewID", ReviewID)
        da = New SqlDataAdapter(cmd)
        strSQLConn.Open()
        ds = New DataSet()
        da.Fill(ds)

        Repeater1.DataSource = ds
        Repeater1.DataBind()

        'Set the form focus to Call Center Location to get ready for the first call
        'ddlCallCenterID.Focus()
    End Sub

    'Public Shared Function GetPassFail(ByVal ReviewID As Integer) As String
    '    Dim result As String = String.Empty
    '    Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)

    '    Dim cmd As New SqlCommand("p_getPassFail", con)
    '    cmd.CommandType = CommandType.StoredProcedure
    '    cmd.Parameters.AddWithValue("@ReviewID", ReviewID)
    '    Using con
    '        con.Open()
    '        Dim reader As SqlDataReader = cmd.ExecuteReader()
    '        If reader.Read() Then
    '            result = CType(reader("OverallScore"), String)
    '        End If
    '    End Using
    '    Return result
    'End Function

    Sub btnUpdateCall_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim CallCenterID As Integer
        Dim AgentID As String = ""
        Dim CallID As String = ""
        Dim DateofReview As String = ""
        Dim BeginTimeofReview As String = ""
        Dim EndTimeofReview As String = ""
        Dim BorrowerAccountNumber As String = ""
        Dim InboundOutbound As String = ""
        Dim Escalated As String = ""
        Dim SpecialtyLine As String = ""
        Dim intro_identified_self As String = ""
        Dim intro_identified_agency As String = ""
        Dim intro_calls_recorded As String = ""
        Dim auth_borrower_name As String = ""
        Dim auth_id_procedures As String = ""
        Dim auth_address As String = ""
        Dim auth_phone_number As String = ""
        Dim auth_email As String = ""
        Dim accuracy_polite As String = ""
        Dim accuracy_enunciating_words As String = ""
        Dim accuracy_mainted_control As String = ""
        Dim accuracy_accurate_info As String = ""
        Dim accuracy_expedient_correspondence As String = ""
        'Methods of Resolution
        Dim delinquency_days_delinquent As String = ""
        Dim delinquency_past_due_amount As String = ""
        Dim delinquency_forbearance As String = ""
        Dim delinquency_lower_payment_option As String = ""
        Dim delinquency_deferment_option As String = ""
        Dim military_programs As String = ""
        Dim scra_eligibility_requirements As String = ""
        Dim scra_borrower_eligibility As String = ""
        Dim scra_loan_eligibility As String = ""
        Dim scra_benefits As String = ""
        Dim hostility_no_interest_payments As String = ""
        Dim hostility_zero_interest As String = ""
        Dim military_deferment1 As String = ""
        Dim military_deferment2 As String = ""
        Dim national_guard_forbearance As String = ""
        Dim national_guard_activated_6_months As String = ""
        Dim national_guard_fed_loans_eligible As String = ""
        Dim dod_forbearance As String = ""
        Dim dod_forbearance_fed_loans_eligible As String = ""
        Dim dod_postpone_payments As String = ""
        Dim pslf_eligibility As String = ""
        Dim pslf_loan_types As String = ""
        Dim pslf_other_options As String = ""
        Dim pslf_120_payments As String = ""
        Dim pslf_eligible_payment_plan As String = ""
        Dim pslf_fulltime_employment As String = ""
        Dim pslf_work_for_pso As String = ""
        Dim pslf_consolidating As String = ""
        Dim teacher_forgiveness_described_eligibility As String = ""
        Dim teacher_forgiveness_how_to_apply As String = ""
        Dim teacher_forgiveness_explained_benefit As String = ""
        Dim teach_advised_conditions As String = ""
        Dim teach_advised_borrower As String = ""
        Dim teach_advised_service_must_be_completed As String = ""
        Dim teach_must_teach_needed_capacity As String = ""
        Dim teach_may_request_suspension As String = ""
        Dim tpd_how_to_apply_for_TPD As String = ""
        Dim tpd_collection_will_suspend_120_days As String = ""
        Dim tpd_document_disability As String = ""
        Dim tpd_advised_TPD_application As String = ""
        Dim tpd_procedures_approves_TPD_discharge As String = ""
        Dim tpd_TPD_monitoring_period As String = ""
        Dim tpd_advised_reinstatements As String = ""
        Dim tpd_new_loans_teach_grants As String = ""
        Dim tpd_advised_TPD_refund_procedures As String = ""
        Dim tpd_1099_sent As String = ""
        Dim idr_eligibility As String = ""
        Dim idr_how_payments_calculated As String = ""
        Dim idr_qualifying_loans As String = ""
        Dim idr_how_to_apply As String = ""
        Dim deferment_meaning_deferment As String = ""
        Dim deferment_qualifying_deferment As String = ""
        Dim deferment_how_to_apply As String = ""
        Dim deferment_length As String = ""
        Dim forbearance_not_qualified_for_deferment As String = ""
        Dim forbearance_explained_meaning As String = ""
        Dim forbearance_provided_documentation As String = ""
        Dim forbearance_explained_different_types As String = ""
        Dim forbearance_read_script As String = ""
        Dim amortization_loan_amount_growing As String = ""
        Dim amortization_which_payment_plan As String = ""
        Dim amortization_interest_capitalization As String = ""
        Dim closed_school_criteria As String = ""
        Dim closed_school_process As String = ""
        Dim closed_school_approve_deny As String = ""
        Dim bankruptcy_bankruptcy_filed As String = ""
        Dim bankruptcy_additional_information As String = ""
        Dim bankruptcy_mailing_address As String = ""
        Dim bankruptcy_notified_internal_parties As String = ""
        Dim death_deceased_borrower As String = ""
        Dim death_collected_info_third_party As String = ""
        Dim death_send_documentation As String = ""
        Dim death_death_cert_mailing_address As String = ""
        Dim death_identified_circumstances As String = ""
        Dim atb_eligibility_requirements As String = ""
        Dim atb_take_test As String = ""
        Dim atb_advised_loans_may_be_discharged As String = ""
        Dim atb_how_to_send_application As String = ""
        Dim atb_how_to_complete As String = ""
        Dim falsecert_eligibility_requirements As String = ""
        Dim falsecert_how_to_send_application As String = ""
        Dim falsecert_how_to_complete As String = ""
        Dim falsecert_refund_unpaid_refund As String = ""
        Dim falsecert_refund_how_to_send_application As String = ""
        Dim falsecert_refund_how_to_complete As String = ""
        Dim documentation_accuracy As String = ""
        Dim documentation_logged_complaint As String = ""
        Dim payment_accessing_web_account As String = ""
        Dim payment_direct_debit As String = ""
        Dim payment_phone_payment As String = ""
        Dim payment_creditcards_not_accepted As String = ""
        Dim payment_creditcards_emergency As String = ""
        Dim consolidation_explained_benefits As String = ""
        Dim consolidation_program_requirements As String = ""
        Dim consolidation_loan_types As String = ""
        Dim consolidation_explained_app_process As String = ""
        Dim resolution_other As String = ""
        Dim RecordStatus As String = ""
        Dim Comments As String = ""

        Dim dataItem As RepeaterItem
        For Each dataItem In Repeater1.Items
            CallCenterID = CType(dataItem.FindControl("ddlCallCenterID"), DropDownList).SelectedValue
            AgentID = CType(dataItem.FindControl("txtAgentID"), TextBox).Text
            CallID = CType(dataItem.FindControl("txtCallID"), TextBox).Text
            DateofReview = CType(dataItem.FindControl("txtDateofReview"), TextBox).Text
            BeginTimeofReview = CType(dataItem.FindControl("txtBeginTimeofReview"), TextBox).Text
            EndTimeofReview = CType(dataItem.FindControl("txtEndTimeofReview"), TextBox).Text
            BorrowerAccountNumber = CType(dataItem.FindControl("txtBorrowerAccountNumber"), TextBox).Text
            InboundOutbound = CType(dataItem.FindControl("ddlInboundOutbound"), DropDownList).SelectedValue
            Escalated = CType(dataItem.FindControl("ddlEscalated"), DropDownList).SelectedValue
            SpecialtyLine = CType(dataItem.FindControl("ddlSpecialtyLine"), DropDownList).SelectedValue
            intro_identified_self = CType(dataItem.FindControl("chkintro_identified_self"), CheckBox).Checked
            intro_identified_agency = CType(dataItem.FindControl("chkintro_identified_agency"), CheckBox).Checked
            intro_calls_recorded = CType(dataItem.FindControl("chkintro_calls_recorded"), CheckBox).Checked
            auth_borrower_name = CType(dataItem.FindControl("chkauth_borrower_name"), CheckBox).Checked
            auth_id_procedures = CType(dataItem.FindControl("chkauth_id_procedures"), CheckBox).Checked
            auth_address = CType(dataItem.FindControl("chkauth_address"), CheckBox).Checked
            auth_phone_number = CType(dataItem.FindControl("chkauth_phone_number"), CheckBox).Checked
            auth_email = CType(dataItem.FindControl("chkauth_email"), CheckBox).Checked
            accuracy_polite = CType(dataItem.FindControl("chkaccuracy_polite"), CheckBox).Checked
            accuracy_enunciating_words = CType(dataItem.FindControl("chkaccuracy_enunciating_words"), CheckBox).Checked
            accuracy_mainted_control = CType(dataItem.FindControl("chkaccuracy_mainted_control"), CheckBox).Checked
            accuracy_accurate_info = CType(dataItem.FindControl("chkaccuracy_accurate_info"), CheckBox).Checked
            accuracy_expedient_correspondence = CType(dataItem.FindControl("chkaccuracy_expedient_correspondence"), CheckBox).Checked

            'Methods of Resolution
            delinquency_days_delinquent = CType(dataItem.FindControl("ddldelinquency_days_delinquent"), DropDownList).SelectedValue
            delinquency_past_due_amount = CType(dataItem.FindControl("ddldelinquency_past_due_amount"), DropDownList).SelectedValue
            delinquency_forbearance = CType(dataItem.FindControl("ddldelinquency_forbearance"), DropDownList).SelectedValue
            delinquency_lower_payment_option = CType(dataItem.FindControl("ddldelinquency_lower_payment_option"), DropDownList).SelectedValue
            delinquency_deferment_option = CType(dataItem.FindControl("ddldelinquency_deferment_option"), DropDownList).SelectedValue
            military_programs = CType(dataItem.FindControl("ddlmilitary_programs"), DropDownList).SelectedValue
            scra_eligibility_requirements = CType(dataItem.FindControl("ddlscra_eligibility_requirements"), DropDownList).SelectedValue
            scra_borrower_eligibility = CType(dataItem.FindControl("ddlscra_borrower_eligibility"), DropDownList).SelectedValue
            scra_loan_eligibility = CType(dataItem.FindControl("ddlscra_loan_eligibility"), DropDownList).SelectedValue
            scra_benefits = CType(dataItem.FindControl("ddlscra_benefits"), DropDownList).SelectedValue
            hostility_no_interest_payments = CType(dataItem.FindControl("ddlhostility_no_interest_payments"), DropDownList).SelectedValue
            hostility_zero_interest = CType(dataItem.FindControl("ddlhostility_zero_interest"), DropDownList).SelectedValue
            military_deferment1 = CType(dataItem.FindControl("ddlmilitary_deferment1"), DropDownList).SelectedValue
            military_deferment2 = CType(dataItem.FindControl("ddlmilitary_deferment2"), DropDownList).SelectedValue
            national_guard_forbearance = CType(dataItem.FindControl("ddlnational_guard_forbearance"), DropDownList).SelectedValue
            national_guard_activated_6_months = CType(dataItem.FindControl("ddlnational_guard_activated_6_months"), DropDownList).SelectedValue
            national_guard_fed_loans_eligible = CType(dataItem.FindControl("ddlnational_guard_fed_loans_eligible"), DropDownList).SelectedValue
            dod_forbearance = CType(dataItem.FindControl("ddldod_forbearance"), DropDownList).SelectedValue
            dod_forbearance_fed_loans_eligible = CType(dataItem.FindControl("ddldod_forbearance_fed_loans_eligible"), DropDownList).SelectedValue
            dod_postpone_payments = CType(dataItem.FindControl("ddldod_postpone_payments"), DropDownList).SelectedValue
            pslf_eligibility = CType(dataItem.FindControl("ddlpslf_eligibility"), DropDownList).SelectedValue
            pslf_loan_types = CType(dataItem.FindControl("ddlpslf_loan_types"), DropDownList).SelectedValue
            pslf_other_options = CType(dataItem.FindControl("ddlpslf_other_options"), DropDownList).SelectedValue
            pslf_120_payments = CType(dataItem.FindControl("ddlpslf_120_payments"), DropDownList).SelectedValue
            pslf_eligible_payment_plan = CType(dataItem.FindControl("ddlpslf_eligible_payment_plan"), DropDownList).SelectedValue
            pslf_fulltime_employment = CType(dataItem.FindControl("ddlpslf_fulltime_employment"), DropDownList).SelectedValue
            pslf_work_for_pso = CType(dataItem.FindControl("ddlpslf_work_for_pso"), DropDownList).SelectedValue
            pslf_consolidating = CType(dataItem.FindControl("ddlpslf_consolidating"), DropDownList).SelectedValue
            teacher_forgiveness_described_eligibility = CType(dataItem.FindControl("ddlteacher_forgiveness_described_eligibility"), DropDownList).SelectedValue
            teacher_forgiveness_how_to_apply = CType(dataItem.FindControl("ddlteacher_forgiveness_how_to_apply"), DropDownList).SelectedValue
            teacher_forgiveness_explained_benefit = CType(dataItem.FindControl("ddlteacher_forgiveness_explained_benefit"), DropDownList).SelectedValue
            teach_advised_conditions = CType(dataItem.FindControl("ddlteach_advised_conditions"), DropDownList).SelectedValue
            teach_advised_borrower = CType(dataItem.FindControl("ddlteach_advised_borrower"), DropDownList).SelectedValue
            teach_advised_service_must_be_completed = CType(dataItem.FindControl("ddlteach_advised_service_must_be_completed"), DropDownList).SelectedValue
            teach_must_teach_needed_capacity = CType(dataItem.FindControl("ddlteach_must_teach_needed_capacity"), DropDownList).SelectedValue
            teach_may_request_suspension = CType(dataItem.FindControl("ddlteach_may_request_suspension"), DropDownList).SelectedValue
            tpd_how_to_apply_for_TPD = CType(dataItem.FindControl("ddltpd_how_to_apply_for_TPD"), DropDownList).SelectedValue
            tpd_collection_will_suspend_120_days = CType(dataItem.FindControl("ddltpd_collection_will_suspend_120_days"), DropDownList).SelectedValue
            tpd_document_disability = CType(dataItem.FindControl("ddltpd_document_disability"), DropDownList).SelectedValue
            tpd_advised_TPD_application = CType(dataItem.FindControl("ddltpd_advised_TPD_application"), DropDownList).SelectedValue
            tpd_procedures_approves_TPD_discharge = CType(dataItem.FindControl("ddltpd_procedures_approves_TPD_discharge"), DropDownList).SelectedValue
            tpd_TPD_monitoring_period = CType(dataItem.FindControl("ddltpd_TPD_monitoring_period"), DropDownList).SelectedValue
            tpd_advised_reinstatements = CType(dataItem.FindControl("ddltpd_advised_reinstatements"), DropDownList).SelectedValue
            tpd_new_loans_teach_grants = CType(dataItem.FindControl("ddltpd_new_loans_teach_grants"), DropDownList).SelectedValue
            tpd_advised_TPD_refund_procedures = CType(dataItem.FindControl("ddltpd_advised_TPD_refund_procedures"), DropDownList).SelectedValue
            tpd_1099_sent = CType(dataItem.FindControl("ddltpd_1099_sent"), DropDownList).SelectedValue
            idr_eligibility = CType(dataItem.FindControl("ddlidr_eligibility"), DropDownList).SelectedValue
            idr_how_payments_calculated = CType(dataItem.FindControl("ddlidr_how_payments_calculated"), DropDownList).SelectedValue
            idr_qualifying_loans = CType(dataItem.FindControl("ddlidr_qualifying_loans"), DropDownList).SelectedValue
            idr_how_to_apply = CType(dataItem.FindControl("ddlidr_how_to_apply"), DropDownList).SelectedValue
            deferment_meaning_deferment = CType(dataItem.FindControl("ddldeferment_meaning_deferment"), DropDownList).SelectedValue
            deferment_qualifying_deferment = CType(dataItem.FindControl("ddldeferment_qualifying_deferment"), DropDownList).SelectedValue
            deferment_how_to_apply = CType(dataItem.FindControl("ddldeferment_how_to_apply"), DropDownList).SelectedValue
            deferment_length = CType(dataItem.FindControl("ddldeferment_length"), DropDownList).SelectedValue
            forbearance_not_qualified_for_deferment = CType(dataItem.FindControl("ddlforbearance_not_qualified_for_deferment"), DropDownList).SelectedValue
            forbearance_explained_meaning = CType(dataItem.FindControl("ddlforbearance_explained_meaning"), DropDownList).SelectedValue
            forbearance_provided_documentation = CType(dataItem.FindControl("ddlforbearance_provided_documentation"), DropDownList).SelectedValue
            forbearance_explained_different_types = CType(dataItem.FindControl("ddlforbearance_explained_different_types"), DropDownList).SelectedValue
            forbearance_read_script = CType(dataItem.FindControl("ddlforbearance_read_script"), DropDownList).SelectedValue
            amortization_loan_amount_growing = CType(dataItem.FindControl("ddlamortization_loan_amount_growing"), DropDownList).SelectedValue
            amortization_which_payment_plan = CType(dataItem.FindControl("ddlamortization_which_payment_plan"), DropDownList).SelectedValue
            amortization_interest_capitalization = CType(dataItem.FindControl("ddlamortization_interest_capitalization"), DropDownList).SelectedValue
            closed_school_criteria = CType(dataItem.FindControl("ddlclosed_school_criteria"), DropDownList).SelectedValue
            closed_school_process = CType(dataItem.FindControl("ddlclosed_school_process"), DropDownList).SelectedValue
            closed_school_approve_deny = CType(dataItem.FindControl("ddlclosed_school_approve_deny"), DropDownList).SelectedValue
            bankruptcy_bankruptcy_filed = CType(dataItem.FindControl("ddlbankruptcy_bankruptcy_filed"), DropDownList).SelectedValue
            bankruptcy_additional_information = CType(dataItem.FindControl("ddlbankruptcy_additional_information"), DropDownList).SelectedValue
            bankruptcy_mailing_address = CType(dataItem.FindControl("ddlbankruptcy_mailing_address"), DropDownList).SelectedValue
            bankruptcy_notified_internal_parties = CType(dataItem.FindControl("ddlbankruptcy_notified_internal_parties"), DropDownList).SelectedValue
            death_deceased_borrower = CType(dataItem.FindControl("ddldeath_deceased_borrower"), DropDownList).SelectedValue
            death_collected_info_third_party = CType(dataItem.FindControl("ddldeath_collected_info_third_party"), DropDownList).SelectedValue
            death_send_documentation = CType(dataItem.FindControl("ddldeath_send_documentation"), DropDownList).SelectedValue
            death_death_cert_mailing_address = CType(dataItem.FindControl("ddldeath_death_cert_mailing_address"), DropDownList).SelectedValue
            death_identified_circumstances = CType(dataItem.FindControl("ddldeath_identified_circumstances"), DropDownList).SelectedValue
            atb_eligibility_requirements = CType(dataItem.FindControl("ddlatb_eligibility_requirements"), DropDownList).SelectedValue
            atb_take_test = CType(dataItem.FindControl("ddlatb_take_test"), DropDownList).SelectedValue
            atb_advised_loans_may_be_discharged = CType(dataItem.FindControl("ddlatb_advised_loans_may_be_discharged"), DropDownList).SelectedValue
            atb_how_to_send_application = CType(dataItem.FindControl("ddlatb_how_to_send_application"), DropDownList).SelectedValue
            atb_how_to_complete = CType(dataItem.FindControl("ddlatb_how_to_complete"), DropDownList).SelectedValue
            falsecert_eligibility_requirements = CType(dataItem.FindControl("ddlfalsecert_eligibility_requirements"), DropDownList).SelectedValue
            falsecert_how_to_send_application = CType(dataItem.FindControl("ddlfalsecert_how_to_send_application"), DropDownList).SelectedValue
            falsecert_how_to_complete = CType(dataItem.FindControl("ddlfalsecert_how_to_complete"), DropDownList).SelectedValue
            falsecert_refund_unpaid_refund = CType(dataItem.FindControl("ddlfalsecert_refund_unpaid_refund"), DropDownList).SelectedValue
            falsecert_refund_how_to_send_application = CType(dataItem.FindControl("ddlfalsecert_refund_how_to_send_application"), DropDownList).SelectedValue
            falsecert_refund_how_to_complete = CType(dataItem.FindControl("ddlfalsecert_refund_how_to_complete"), DropDownList).SelectedValue
            documentation_accuracy = CType(dataItem.FindControl("ddldocumentation_accuracy"), DropDownList).SelectedValue
            documentation_logged_complaint = CType(dataItem.FindControl("ddldocumentation_logged_complaint"), DropDownList).SelectedValue
            payment_accessing_web_account = CType(dataItem.FindControl("ddlpayment_accessing_web_account"), DropDownList).SelectedValue
            payment_direct_debit = CType(dataItem.FindControl("ddlpayment_direct_debit"), DropDownList).SelectedValue
            payment_phone_payment = CType(dataItem.FindControl("ddlpayment_phone_payment"), DropDownList).SelectedValue
            payment_creditcards_not_accepted = CType(dataItem.FindControl("ddlpayment_creditcards_not_accepted"), DropDownList).SelectedValue
            payment_creditcards_emergency = CType(dataItem.FindControl("ddlpayment_creditcards_emergency"), DropDownList).SelectedValue
            consolidation_explained_benefits = CType(dataItem.FindControl("ddlconsolidation_explained_benefits"), DropDownList).SelectedValue
            consolidation_program_requirements = CType(dataItem.FindControl("ddlconsolidation_program_requirements"), DropDownList).SelectedValue
            consolidation_loan_types = CType(dataItem.FindControl("ddlconsolidation_loan_types"), DropDownList).SelectedValue
            consolidation_explained_app_process = CType(dataItem.FindControl("ddlconsolidation_explained_app_process"), DropDownList).SelectedValue
            resolution_other = CType(dataItem.FindControl("ddlresolution_other"), DropDownList).SelectedValue
            Comments = CType(dataItem.FindControl("txtComments"), TextBox).Text
        Next

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateCall_FormB", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@CallCenterID", CallCenterID)
        cmd.Parameters.AddWithValue("@AgentID", AgentID)
        cmd.Parameters.AddWithValue("@CallID", CallID)
        cmd.Parameters.AddWithValue("@DateofReview", DateofReview)
        cmd.Parameters.AddWithValue("@BeginTimeofReview", BeginTimeofReview)
        cmd.Parameters.AddWithValue("@EndTimeofReview", EndTimeofReview)
        cmd.Parameters.AddWithValue("@BorrowerAccountNumber", BorrowerAccountNumber)
        cmd.Parameters.AddWithValue("@InboundOutbound", InboundOutbound)
        If ddlSpecialtyLine.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@SpecialtyLine", ddlSpecialtyLine.SelectedValue)
        Else
            cmd.Parameters.AddWithValue("@SpecialtyLine", DBNull.Value)
        End If
        cmd.Parameters.AddWithValue("@Escalated", Escalated)
        cmd.Parameters.AddWithValue("@intro_identified_self", intro_identified_self)
        cmd.Parameters.AddWithValue("@intro_identified_agency", intro_identified_agency)
        cmd.Parameters.AddWithValue("@intro_calls_recorded", intro_calls_recorded)
        cmd.Parameters.AddWithValue("@auth_borrower_name", auth_borrower_name)
        cmd.Parameters.AddWithValue("@auth_id_procedures", auth_id_procedures)
        cmd.Parameters.AddWithValue("@auth_address", auth_address)
        cmd.Parameters.AddWithValue("@auth_phone_number", auth_phone_number)
        cmd.Parameters.AddWithValue("@auth_email", auth_email)
        cmd.Parameters.AddWithValue("@accuracy_polite", accuracy_polite)
        cmd.Parameters.AddWithValue("@accuracy_enunciating_words", accuracy_enunciating_words)
        cmd.Parameters.AddWithValue("@accuracy_mainted_control", accuracy_mainted_control)
        cmd.Parameters.AddWithValue("@accuracy_accurate_info", accuracy_accurate_info)
        cmd.Parameters.AddWithValue("@accuracy_expedient_correspondence", accuracy_expedient_correspondence)

        If Len(delinquency_days_delinquent) > 0 Then
            cmd.Parameters.Add("@delinquency_days_delinquent", SqlDbType.VarChar).Value = delinquency_days_delinquent
        Else
            cmd.Parameters.Add("@delinquency_days_delinquent", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(delinquency_past_due_amount) > 0 Then
            cmd.Parameters.Add("@delinquency_past_due_amount", SqlDbType.VarChar).Value = delinquency_past_due_amount
        Else
            cmd.Parameters.Add("@delinquency_past_due_amount", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(delinquency_forbearance) > 0 Then
            cmd.Parameters.Add("@delinquency_forbearance", SqlDbType.VarChar).Value = delinquency_forbearance
        Else
            cmd.Parameters.Add("@delinquency_forbearance", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(delinquency_lower_payment_option) > 0 Then
            cmd.Parameters.Add("@delinquency_lower_payment_option", SqlDbType.VarChar).Value = delinquency_lower_payment_option
        Else
            cmd.Parameters.Add("@delinquency_lower_payment_option", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(delinquency_deferment_option) > 0 Then
            cmd.Parameters.Add("@delinquency_deferment_option", SqlDbType.VarChar).Value = delinquency_deferment_option
        Else
            cmd.Parameters.Add("@delinquency_deferment_option", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(military_programs) > 0 Then
            cmd.Parameters.Add("@military_programs", SqlDbType.VarChar).Value = military_programs
        Else
            cmd.Parameters.Add("@military_programs", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(scra_eligibility_requirements) > 0 Then
            cmd.Parameters.Add("@scra_eligibility_requirements", SqlDbType.VarChar).Value = scra_eligibility_requirements
        Else
            cmd.Parameters.Add("@scra_eligibility_requirements", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(scra_borrower_eligibility) > 0 Then
            cmd.Parameters.Add("@scra_borrower_eligibility", SqlDbType.VarChar).Value = scra_borrower_eligibility
        Else
            cmd.Parameters.Add("@scra_borrower_eligibility", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(scra_loan_eligibility) > 0 Then
            cmd.Parameters.Add("@scra_loan_eligibility", SqlDbType.VarChar).Value = scra_loan_eligibility
        Else
            cmd.Parameters.Add("@scra_loan_eligibility", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(scra_benefits) > 0 Then
            cmd.Parameters.Add("@scra_benefits", SqlDbType.VarChar).Value = scra_benefits
        Else
            cmd.Parameters.Add("@scra_benefits", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(hostility_no_interest_payments) > 0 Then
            cmd.Parameters.Add("@hostility_no_interest_payments", SqlDbType.VarChar).Value = hostility_no_interest_payments
        Else
            cmd.Parameters.Add("@hostility_no_interest_payments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(hostility_zero_interest) > 0 Then
            cmd.Parameters.Add("@hostility_zero_interest", SqlDbType.VarChar).Value = hostility_zero_interest
        Else
            cmd.Parameters.Add("@hostility_zero_interest", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(military_deferment1) > 0 Then
            cmd.Parameters.Add("@military_deferment1", SqlDbType.VarChar).Value = military_deferment1
        Else
            cmd.Parameters.Add("@military_deferment1", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(military_deferment2) > 0 Then
            cmd.Parameters.Add("@military_deferment2", SqlDbType.VarChar).Value = military_deferment2
        Else
            cmd.Parameters.Add("@military_deferment2", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(national_guard_forbearance) > 0 Then
            cmd.Parameters.Add("@national_guard_forbearance", SqlDbType.VarChar).Value = national_guard_forbearance
        Else
            cmd.Parameters.Add("@national_guard_forbearance", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(national_guard_activated_6_months) > 0 Then
            cmd.Parameters.Add("@national_guard_activated_6_months", SqlDbType.VarChar).Value = national_guard_activated_6_months
        Else
            cmd.Parameters.Add("@national_guard_activated_6_months", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(national_guard_fed_loans_eligible) > 0 Then
            cmd.Parameters.Add("@national_guard_fed_loans_eligible", SqlDbType.VarChar).Value = national_guard_fed_loans_eligible
        Else
            cmd.Parameters.Add("@national_guard_fed_loans_eligible", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(dod_forbearance) > 0 Then
            cmd.Parameters.Add("@dod_forbearance", SqlDbType.VarChar).Value = dod_forbearance
        Else
            cmd.Parameters.Add("@dod_forbearance", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(dod_forbearance_fed_loans_eligible) > 0 Then
            cmd.Parameters.Add("@dod_forbearance_fed_loans_eligible", SqlDbType.VarChar).Value = dod_forbearance_fed_loans_eligible
        Else
            cmd.Parameters.Add("@dod_forbearance_fed_loans_eligible", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(dod_postpone_payments) > 0 Then
            cmd.Parameters.Add("@dod_postpone_payments", SqlDbType.VarChar).Value = dod_postpone_payments
        Else
            cmd.Parameters.Add("@dod_postpone_payments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_eligibility) > 0 Then
            cmd.Parameters.Add("@pslf_eligibility", SqlDbType.VarChar).Value = pslf_eligibility
        Else
            cmd.Parameters.Add("@pslf_eligibility", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_loan_types) > 0 Then
            cmd.Parameters.Add("@pslf_loan_types", SqlDbType.VarChar).Value = pslf_loan_types
        Else
            cmd.Parameters.Add("@pslf_loan_types", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_other_options) > 0 Then
            cmd.Parameters.Add("@pslf_other_options", SqlDbType.VarChar).Value = pslf_other_options
        Else
            cmd.Parameters.Add("@pslf_other_options", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_120_payments) > 0 Then
            cmd.Parameters.Add("@pslf_120_payments", SqlDbType.VarChar).Value = pslf_120_payments
        Else
            cmd.Parameters.Add("@pslf_120_payments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_eligible_payment_plan) > 0 Then
            cmd.Parameters.Add("@pslf_eligible_payment_plan", SqlDbType.VarChar).Value = pslf_eligible_payment_plan
        Else
            cmd.Parameters.Add("@pslf_eligible_payment_plan", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_fulltime_employment) > 0 Then
            cmd.Parameters.Add("@pslf_fulltime_employment", SqlDbType.VarChar).Value = pslf_fulltime_employment
        Else
            cmd.Parameters.Add("@pslf_fulltime_employment", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_work_for_pso) > 0 Then
            cmd.Parameters.Add("@pslf_work_for_pso", SqlDbType.VarChar).Value = pslf_work_for_pso
        Else
            cmd.Parameters.Add("@pslf_work_for_pso", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(pslf_consolidating) > 0 Then
            cmd.Parameters.Add("@pslf_consolidating", SqlDbType.VarChar).Value = pslf_consolidating
        Else
            cmd.Parameters.Add("@pslf_consolidating", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teacher_forgiveness_described_eligibility) > 0 Then
            cmd.Parameters.AddWithValue("@teacher_forgiveness_described_eligibility", SqlDbType.VarChar).Value = teacher_forgiveness_described_eligibility
        Else
            cmd.Parameters.AddWithValue("@teacher_forgiveness_described_eligibility", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teacher_forgiveness_how_to_apply) > 0 Then
            cmd.Parameters.AddWithValue("@teacher_forgiveness_how_to_apply", SqlDbType.VarChar).Value = teacher_forgiveness_how_to_apply
        Else
            cmd.Parameters.AddWithValue("@teacher_forgiveness_how_to_apply", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teacher_forgiveness_explained_benefit) > 0 Then
            cmd.Parameters.AddWithValue("@teacher_forgiveness_explained_benefit", SqlDbType.VarChar).Value = teacher_forgiveness_explained_benefit
        Else
            cmd.Parameters.AddWithValue("@teacher_forgiveness_explained_benefit", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teach_advised_conditions) > 0 Then
            cmd.Parameters.Add("@teach_advised_conditions", SqlDbType.VarChar).Value = teach_advised_conditions
        Else
            cmd.Parameters.Add("@teach_advised_conditions", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teach_advised_borrower) > 0 Then
            cmd.Parameters.Add("@teach_advised_borrower", SqlDbType.VarChar).Value = teach_advised_borrower
        Else
            cmd.Parameters.Add("@teach_advised_borrower", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teach_advised_service_must_be_completed) > 0 Then
            cmd.Parameters.Add("@teach_advised_service_must_be_completed", SqlDbType.VarChar).Value = teach_advised_service_must_be_completed
        Else
            cmd.Parameters.Add("@teach_advised_service_must_be_completed", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teach_must_teach_needed_capacity) > 0 Then
            cmd.Parameters.Add("@teach_must_teach_needed_capacity", SqlDbType.VarChar).Value = teach_must_teach_needed_capacity
        Else
            cmd.Parameters.Add("@teach_must_teach_needed_capacity", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(teach_may_request_suspension) > 0 Then
            cmd.Parameters.Add("@teach_may_request_suspension", SqlDbType.VarChar).Value = teach_may_request_suspension
        Else
            cmd.Parameters.Add("@teach_may_request_suspension", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_how_to_apply_for_TPD) > 0 Then
            cmd.Parameters.Add("@tpd_how_to_apply_for_TPD", SqlDbType.VarChar).Value = tpd_how_to_apply_for_TPD
        Else
            cmd.Parameters.Add("@tpd_how_to_apply_for_TPD", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_collection_will_suspend_120_days) > 0 Then
            cmd.Parameters.Add("@tpd_collection_will_suspend_120_days", SqlDbType.VarChar).Value = tpd_collection_will_suspend_120_days
        Else
            cmd.Parameters.Add("@tpd_collection_will_suspend_120_days", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_document_disability) > 0 Then
            cmd.Parameters.Add("@tpd_document_disability", SqlDbType.VarChar).Value = tpd_document_disability
        Else
            cmd.Parameters.Add("@tpd_document_disability", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_advised_TPD_application) > 0 Then
            cmd.Parameters.Add("@tpd_advised_TPD_application", SqlDbType.VarChar).Value = tpd_advised_TPD_application
        Else
            cmd.Parameters.Add("@tpd_advised_TPD_application", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_procedures_approves_TPD_discharge) > 0 Then
            cmd.Parameters.Add("@tpd_procedures_approves_TPD_discharge", SqlDbType.VarChar).Value = tpd_procedures_approves_TPD_discharge
        Else
            cmd.Parameters.Add("@tpd_procedures_approves_TPD_discharge", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_TPD_monitoring_period) > 0 Then
            cmd.Parameters.Add("@tpd_TPD_monitoring_period", SqlDbType.VarChar).Value = tpd_TPD_monitoring_period
        Else
            cmd.Parameters.Add("@tpd_TPD_monitoring_period", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_advised_reinstatements) > 0 Then
            cmd.Parameters.Add("@tpd_advised_reinstatements", SqlDbType.VarChar).Value = tpd_advised_reinstatements
        Else
            cmd.Parameters.Add("@tpd_advised_reinstatements", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_new_loans_teach_grants) > 0 Then
            cmd.Parameters.Add("@tpd_new_loans_teach_grants", SqlDbType.VarChar).Value = tpd_new_loans_teach_grants
        Else
            cmd.Parameters.Add("@tpd_new_loans_teach_grants", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_advised_TPD_refund_procedures) > 0 Then
            cmd.Parameters.Add("@tpd_advised_TPD_refund_procedures", SqlDbType.VarChar).Value = tpd_advised_TPD_refund_procedures
        Else
            cmd.Parameters.Add("@tpd_advised_TPD_refund_procedures", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(tpd_1099_sent) > 0 Then
            cmd.Parameters.Add("@tpd_1099_sent", SqlDbType.VarChar).Value = tpd_1099_sent
        Else
            cmd.Parameters.Add("@tpd_1099_sent", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(idr_eligibility) > 0 Then
            cmd.Parameters.Add("@idr_eligibility", SqlDbType.VarChar).Value = idr_eligibility
        Else
            cmd.Parameters.Add("@idr_eligibility", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(idr_how_payments_calculated) > 0 Then
            cmd.Parameters.Add("@idr_how_payments_calculated", SqlDbType.VarChar).Value = idr_how_payments_calculated
        Else
            cmd.Parameters.Add("@idr_how_payments_calculated", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(idr_qualifying_loans) > 0 Then
            cmd.Parameters.Add("@idr_qualifying_loans", SqlDbType.VarChar).Value = idr_qualifying_loans
        Else
            cmd.Parameters.Add("@idr_qualifying_loans", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(idr_how_to_apply) > 0 Then
            cmd.Parameters.Add("@idr_how_to_apply", SqlDbType.VarChar).Value = idr_how_to_apply
        Else
            cmd.Parameters.Add("@idr_how_to_apply", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(deferment_meaning_deferment) > 0 Then
            cmd.Parameters.Add("@deferment_meaning_deferment", SqlDbType.VarChar).Value = deferment_meaning_deferment
        Else
            cmd.Parameters.Add("@deferment_meaning_deferment", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(deferment_qualifying_deferment) > 0 Then
            cmd.Parameters.Add("@deferment_qualifying_deferment", SqlDbType.VarChar).Value = deferment_qualifying_deferment
        Else
            cmd.Parameters.Add("@deferment_qualifying_deferment", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(deferment_how_to_apply) > 0 Then
            cmd.Parameters.Add("@deferment_how_to_apply", SqlDbType.VarChar).Value = deferment_how_to_apply
        Else
            cmd.Parameters.Add("@deferment_how_to_apply", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(deferment_length) > 0 Then
            cmd.Parameters.Add("@deferment_length", SqlDbType.VarChar).Value = deferment_length
        Else
            cmd.Parameters.Add("@deferment_length", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(forbearance_not_qualified_for_deferment) > 0 Then
            cmd.Parameters.Add("@forbearance_not_qualified_for_deferment", SqlDbType.VarChar).Value = forbearance_not_qualified_for_deferment
        Else
            cmd.Parameters.Add("@forbearance_not_qualified_for_deferment", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(forbearance_explained_meaning) > 0 Then
            cmd.Parameters.Add("@forbearance_explained_meaning", SqlDbType.VarChar).Value = forbearance_explained_meaning
        Else
            cmd.Parameters.Add("@forbearance_explained_meaning", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(forbearance_provided_documentation) > 0 Then
            cmd.Parameters.Add("@forbearance_provided_documentation", SqlDbType.VarChar).Value = forbearance_provided_documentation
        Else
            cmd.Parameters.Add("@forbearance_provided_documentation", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(forbearance_explained_different_types) > 0 Then
            cmd.Parameters.Add("@forbearance_explained_different_types", SqlDbType.VarChar).Value = forbearance_explained_different_types
        Else
            cmd.Parameters.Add("@forbearance_explained_different_types", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(forbearance_read_script) > 0 Then
            cmd.Parameters.Add("@forbearance_read_script", SqlDbType.VarChar).Value = forbearance_read_script
        Else
            cmd.Parameters.Add("@forbearance_read_script", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(amortization_loan_amount_growing) > 0 Then
            cmd.Parameters.Add("@amortization_loan_amount_growing", SqlDbType.VarChar).Value = amortization_loan_amount_growing
        Else
            cmd.Parameters.Add("@amortization_loan_amount_growing", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(amortization_which_payment_plan) > 0 Then
            cmd.Parameters.Add("@amortization_which_payment_plan", SqlDbType.VarChar).Value = amortization_which_payment_plan
        Else
            cmd.Parameters.Add("@amortization_which_payment_plan", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(amortization_interest_capitalization) > 0 Then
            cmd.Parameters.Add("@amortization_interest_capitalization", SqlDbType.VarChar).Value = amortization_interest_capitalization
        Else
            cmd.Parameters.Add("@amortization_interest_capitalization", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(closed_school_criteria) > 0 Then
            cmd.Parameters.Add("@closed_school_criteria", SqlDbType.VarChar).Value = closed_school_criteria
        Else
            cmd.Parameters.Add("@closed_school_criteria", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(closed_school_process) > 0 Then
            cmd.Parameters.Add("@closed_school_process", SqlDbType.VarChar).Value = closed_school_process
        Else
            cmd.Parameters.Add("@closed_school_process", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(closed_school_approve_deny) > 0 Then
            cmd.Parameters.Add("@closed_school_approve_deny", SqlDbType.VarChar).Value = closed_school_approve_deny
        Else
            cmd.Parameters.Add("@closed_school_approve_deny", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(bankruptcy_bankruptcy_filed) > 0 Then
            cmd.Parameters.Add("@bankruptcy_bankruptcy_filed", SqlDbType.VarChar).Value = bankruptcy_bankruptcy_filed
        Else
            cmd.Parameters.Add("@bankruptcy_bankruptcy_filed", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(bankruptcy_additional_information) > 0 Then
            cmd.Parameters.Add("@bankruptcy_additional_information", SqlDbType.VarChar).Value = bankruptcy_additional_information
        Else
            cmd.Parameters.Add("@bankruptcy_additional_information", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(bankruptcy_mailing_address) > 0 Then
            cmd.Parameters.Add("@bankruptcy_mailing_address", SqlDbType.VarChar).Value = bankruptcy_mailing_address
        Else
            cmd.Parameters.Add("@bankruptcy_mailing_address", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(bankruptcy_notified_internal_parties) > 0 Then
            cmd.Parameters.Add("@bankruptcy_notified_internal_parties", SqlDbType.VarChar).Value = bankruptcy_notified_internal_parties
        Else
            cmd.Parameters.Add("@bankruptcy_notified_internal_parties", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(death_deceased_borrower) > 0 Then
            cmd.Parameters.Add("@death_deceased_borrower", SqlDbType.VarChar).Value = death_deceased_borrower
        Else
            cmd.Parameters.Add("@death_deceased_borrower", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(death_collected_info_third_party) > 0 Then
            cmd.Parameters.Add("@death_collected_info_third_party", SqlDbType.VarChar).Value = death_collected_info_third_party
        Else
            cmd.Parameters.Add("@death_collected_info_third_party", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(death_send_documentation) > 0 Then
            cmd.Parameters.Add("@death_send_documentation", SqlDbType.VarChar).Value = death_send_documentation
        Else
            cmd.Parameters.Add("@death_send_documentation", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(death_death_cert_mailing_address) > 0 Then
            cmd.Parameters.Add("@death_death_cert_mailing_address", SqlDbType.VarChar).Value = death_death_cert_mailing_address
        Else
            cmd.Parameters.Add("@death_death_cert_mailing_address", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(death_identified_circumstances) > 0 Then
            cmd.Parameters.Add("@death_identified_circumstances", SqlDbType.VarChar).Value = death_identified_circumstances
        Else
            cmd.Parameters.Add("@death_identified_circumstances", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(atb_eligibility_requirements) > 0 Then
            cmd.Parameters.Add("@atb_eligibility_requirements", SqlDbType.VarChar).Value = atb_eligibility_requirements
        Else
            cmd.Parameters.Add("@atb_eligibility_requirements", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(atb_take_test) > 0 Then
            cmd.Parameters.Add("@atb_take_test", SqlDbType.VarChar).Value = atb_take_test
        Else
            cmd.Parameters.Add("@atb_take_test", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(atb_advised_loans_may_be_discharged) > 0 Then
            cmd.Parameters.Add("@atb_advised_loans_may_be_discharged", SqlDbType.VarChar).Value = atb_advised_loans_may_be_discharged
        Else
            cmd.Parameters.Add("@atb_advised_loans_may_be_discharged", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(atb_how_to_send_application) > 0 Then
            cmd.Parameters.Add("@atb_how_to_send_application", SqlDbType.VarChar).Value = atb_how_to_send_application
        Else
            cmd.Parameters.Add("@atb_how_to_send_application", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(atb_how_to_complete) > 0 Then
            cmd.Parameters.Add("@atb_how_to_complete", SqlDbType.VarChar).Value = atb_how_to_complete
        Else
            cmd.Parameters.Add("@atb_how_to_complete", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(falsecert_eligibility_requirements) > 0 Then
            cmd.Parameters.Add("@falsecert_eligibility_requirements", SqlDbType.VarChar).Value = falsecert_eligibility_requirements
        Else
            cmd.Parameters.Add("@falsecert_eligibility_requirements", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(falsecert_how_to_send_application) > 0 Then
            cmd.Parameters.Add("@falsecert_how_to_send_application", SqlDbType.VarChar).Value = falsecert_how_to_send_application
        Else
            cmd.Parameters.Add("@falsecert_how_to_send_application", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(falsecert_how_to_complete) > 0 Then
            cmd.Parameters.Add("@falsecert_how_to_complete", SqlDbType.VarChar).Value = falsecert_how_to_complete
        Else
            cmd.Parameters.Add("@falsecert_how_to_complete", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(falsecert_refund_unpaid_refund) > 0 Then
            cmd.Parameters.Add("@falsecert_refund_unpaid_refund", SqlDbType.VarChar).Value = falsecert_refund_unpaid_refund
        Else
            cmd.Parameters.Add("@falsecert_refund_unpaid_refund", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(falsecert_refund_how_to_send_application) > 0 Then
            cmd.Parameters.Add("@falsecert_refund_how_to_send_application", SqlDbType.VarChar).Value = falsecert_refund_how_to_send_application
        Else
            cmd.Parameters.Add("@falsecert_refund_how_to_send_application", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(falsecert_refund_how_to_complete) > 0 Then
            cmd.Parameters.Add("@falsecert_refund_how_to_complete", SqlDbType.VarChar).Value = falsecert_refund_how_to_complete
        Else
            cmd.Parameters.Add("@falsecert_refund_how_to_complete", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(documentation_accuracy) > 0 Then
            cmd.Parameters.Add("@documentation_accuracy", SqlDbType.VarChar).Value = documentation_accuracy
        Else
            cmd.Parameters.Add("@documentation_accuracy", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(documentation_logged_complaint) > 0 Then
            cmd.Parameters.Add("@documentation_logged_complaint", SqlDbType.VarChar).Value = documentation_logged_complaint
        Else
            cmd.Parameters.Add("@documentation_logged_complaint", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(payment_accessing_web_account) > 0 Then
            cmd.Parameters.Add("@payment_accessing_web_account", SqlDbType.VarChar).Value = payment_accessing_web_account
        Else
            cmd.Parameters.Add("@payment_accessing_web_account", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(payment_direct_debit) > 0 Then
            cmd.Parameters.Add("@payment_direct_debit", SqlDbType.VarChar).Value = payment_direct_debit
        Else
            cmd.Parameters.Add("@payment_direct_debit", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(payment_phone_payment) > 0 Then
            cmd.Parameters.Add("@payment_phone_payment", SqlDbType.VarChar).Value = payment_phone_payment
        Else
            cmd.Parameters.Add("@payment_phone_payment", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(payment_creditcards_not_accepted) > 0 Then
            cmd.Parameters.Add("@payment_creditcards_not_accepted", SqlDbType.VarChar).Value = payment_creditcards_not_accepted
        Else
            cmd.Parameters.Add("@payment_creditcards_not_accepted", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(payment_creditcards_emergency) > 0 Then
            cmd.Parameters.Add("@payment_creditcards_emergency", SqlDbType.VarChar).Value = payment_creditcards_emergency
        Else
            cmd.Parameters.Add("@payment_creditcards_emergency", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(consolidation_explained_benefits) > 0 Then
            cmd.Parameters.AddWithValue("@consolidation_explained_benefits", SqlDbType.VarChar).Value = consolidation_explained_benefits
        Else
            cmd.Parameters.AddWithValue("@consolidation_explained_benefits", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(consolidation_program_requirements) > 0 Then
            cmd.Parameters.AddWithValue("@consolidation_program_requirements", SqlDbType.VarChar).Value = consolidation_program_requirements
        Else
            cmd.Parameters.AddWithValue("@consolidation_program_requirements", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(consolidation_loan_types) > 0 Then
            cmd.Parameters.AddWithValue("@consolidation_loan_types", SqlDbType.VarChar).Value = consolidation_loan_types
        Else
            cmd.Parameters.AddWithValue("@consolidation_loan_types", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(consolidation_explained_app_process) > 0 Then
            cmd.Parameters.AddWithValue("@consolidation_explained_app_process", SqlDbType.VarChar).Value = consolidation_explained_app_process
        Else
            cmd.Parameters.AddWithValue("@consolidation_explained_app_process", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(resolution_other) > 0 Then
            cmd.Parameters.Add("@resolution_other", SqlDbType.VarChar).Value = resolution_other
        Else
            cmd.Parameters.Add("@resolution_other", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(Comments) > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = Comments
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@ReviewID", lblReviewID.Text)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your record was successfully updated"
            'Catch ex As Exception   

            'Now update the general score
            GeneralScore(lblReviewID.Text)

            'Now update the method of resolution score
            ResolutionScore(lblReviewID.Text)

            'Now get the final score
            TotalScore(lblReviewID.Text)

            'Add the call to the CallHistory table
            Dim newCallHistory As New CallHistory
            newCallHistory.AddCallHistory(lblReviewID.Text, lblUserID.Text, "Call Updated")

            'Update Call History table
            GridView1.DataBind()

            'Set the form focus to Begin Time of Review
            txtBeginTimeofReview.Focus()

        Finally
            strSQLConn.Close()
        End Try
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

        BindForm(ReviewID)
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

        BindForm(ReviewID)
    End Sub



    Sub btnDeleteCall_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteCall", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ReviewID", lblReviewID2.Text)
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblRecordStatus.Text = "Your record was successfully deleted"
        Catch ex As Exception
            lblRecordStatus.Text = "An error occurred while deleting this record"
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As EventArgs)
        lblRecordStatus.Text = ""
    End Sub

    Protected Sub Repeater1_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        Dim lblPassFail As Label = e.Item.FindControl("lblPassFail")
        If Not e.Item.FindControl("lblPassFail") Is Nothing Then
            'lblPassFail.Text = GetPassFail(lblReviewID2.Text)
        End If
    End Sub

    Protected Function CaseConvert(obj As Object) As String
        Return obj.ToString().ToLower()
    End Function

  
End Class
