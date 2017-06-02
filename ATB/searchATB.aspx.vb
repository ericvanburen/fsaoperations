Imports System
Imports System.Data
Imports System.Data.SqlClient

Partial Class ATB_New_searchATB
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            If Not Request.QueryString("OPEID") Is Nothing Then
                txtOPEID.Text = Request.QueryString("OPEID").ToString()
                hypOPEID.NavigateUrl = "AllSchoolsOPEID.aspx?OPEID=" & txtOPEID.Text

                'Enable Update button only for admins
                If Roles.IsUserInRole("ATB_Admins") = True Then
                    btnUpdateTotalAppsProcessed.Enabled = True
                Else
                    btnUpdateTotalAppsProcessed.Enabled = False
                End If

                BindGridView()
            End If
            End If
    End Sub


    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Response.Redirect("search.ATB.aspx")
        'Dim strOPEID As String
        'strOPEID = txtOPEID.Text
        lblUpdateStatus.Text = ""
        BindGridView()
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("searchATB.aspx")
    End Sub


    Sub BindGridView()
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", con)
        cmd.CommandType = CommandType.StoredProcedure

        If txtOPEID.Text <> "" Then
            cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        End If

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                If dr.HasRows() Then
                    While dr.Read()
                        lblOPEID.Text = dr("OPEID")
                        hypOPEID.NavigateUrl = "AllSchoolsOPEID.aspx?OPEID=" & dr("OPEID").ToString()
                        lblSchoolName.Text = dr("SchoolName")
                        chkAccreditor_Contacted.Text = TrueFalse(dr("Accreditor_Contacted"))
                        lblTotalAppsProcessed.Text = dr("TotalAppsProcessed")
                        'Recommendations Section
                        If Not dr("Recommendation_Summary") Is DBNull.Value Then
                            lblRecommendation_Summary.Text = "<li><p>ATB Violations Summary: " & dr("Recommendation_Summary")
                        End If

                        If Not dr("ViolationSources_Summary") Is DBNull.Value Then
                            lblViolationSources_Summary.Text = "Source(s): " & dr("ViolationSources_Summary") & "</p></li>"
                        End If

                        If Not dr("Recommendation_EDAudits") Is DBNull.Value Then
                            lblRecommendation_EDAudits.Text = "<li><p>ED Audits: " & dr("Recommendation_EDAudits")
                        End If

                        If Not dr("YearsATBFindings_EDAudits") Is DBNull.Value Then
                            lblYearsATBFindings_EDAudits.Text = "Discharge For Year(s): " & dr("YearsATBFindings_EDAudits") & "</p></li>"
                        End If

                        If Not dr("Recommendation_ProgramReviews") Is DBNull.Value Then
                            lblRecommendation_ProgramReviews.Text = "<li><p>ED Program Reviews: " & dr("Recommendation_ProgramReviews")
                        End If

                        If Not dr("YearsATBFindings_ProgramReviews") Is DBNull.Value Then
                            lblYearsATBFindings_ProgramReviews.Text = "Discharge For Year(s): " & dr("YearsATBFindings_ProgramReviews") & "</p></li>"
                        End If

                        If Not dr("Recommendation_OIGAudits") Is DBNull.Value Then
                            lblRecommendation_OIGAudits.Text = "<li><p>OIG Audits: " & dr("Recommendation_OIGAudits")
                        End If

                        If Not dr("YearsAudited_OIGAudits") Is DBNull.Value Then
                            lblYearsAudited_OIGAudits.Text = "Discharge For Year(s): " & dr("YearsAudited_OIGAudits") & "</p></li>"
                        End If

                        If Not dr("Recommendation_PEPS") Is DBNull.Value Then
                            lblRecommendation_PEPS.Text = "<li><p>Pre-PEPS Data: " & dr("Recommendation_PEPS")
                        End If

                        If Not dr("YearsATBFindings_PEPS") Is DBNull.Value Then
                            lblYearsATBFindings_PEPS.Text = "Discharge For Year(s): " & dr("YearsATBFindings_PEPS") & "</p></li>"
                        End If

                        If Not dr("Recommendation_GA_ED") Is DBNull.Value Then
                            lblRecommendation_GA_ED.Text = "<li><p>ED/GA Data Sharing: " & dr("Recommendation_GA_ED")
                        End If

                        If Not dr("Recommendation_GA_ED") Is DBNull.Value Then
                            lblYearsATBFindings_GA_ED.Text = "If no other info, check with FSA first before possible Discharge for Year(s):"
                            txtField2.Text = dr("Field2")
                            txtField3.Text = dr("Field3")
                            txtField4.Text = dr("Field4")
                            txtField5.Text = dr("Field5")
                            txtField6.Text = dr("Field6")
                            txtField7.Text = dr("Field7")
                            txtField8.Text = dr("Field8")
                            txtField9.Text = dr("Field9")
                            txtField10.Text = dr("Field10")
                            txtField11.Text = dr("Field11")
                            txtField12.Text = dr("Field12")
                            txtField13.Text = dr("Field13")
                            txtField14.Text = dr("Field14")
                            txtField15.Text = dr("Field15")
                        End If

                        If Not dr("ViolationDescription_Summary") Is DBNull.Value Then
                            lblViolationDescription_Summary.Text = "<strong><u>Description</u></strong><br /><br />" & dr("ViolationDescription_Summary")
                        End If

                        If Not dr("Comments_Summary") Is DBNull.Value Then
                            lblComments_Summary.Text = "<strong><u>Comments</u></strong><br /><br />" & dr("Comments_Summary")
                        End If
                    End While
                Else
                    'Clear all of the labels from the previous search
                    EmptyTextBoxValues(Me)
                End If
            End Using
        Finally
            con.Close()
        End Try
    End Sub

    Private Sub EmptyTextBoxValues(ByVal parent As Control)
        For Each c As Control In parent.Controls
            If (c.Controls.Count > 0) Then
                EmptyTextBoxValues(c)
            Else
                If TypeOf c Is TextBox Then
                    CType(c, TextBox).Text = ""
                End If

                If TypeOf c Is Label Then
                    CType(c, Label).Text = ""
                End If
            End If
        Next
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

    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs)

        UpdateTotalApps()
        UpdateRecommendation()
       
    End Sub

    Protected Sub UpdateTotalApps()

        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateTotalApps", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        cmd.Parameters.Add("@TotalAppsProcessed", SqlDbType.Int).Value = lblTotalAppsProcessed.Text

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub UpdateRecommendation()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateRecommendationYears", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text

        If txtField2.Text <> "" Then
            cmd.Parameters.Add("@Field2", SqlDbType.VarChar).Value = txtField2.Text
        Else
            cmd.Parameters.Add("@Field2", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField3.Text <> "" Then
            cmd.Parameters.Add("@Field3", SqlDbType.VarChar).Value = txtField3.Text
        Else
            cmd.Parameters.Add("@Field3", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField4.Text <> "" Then
            cmd.Parameters.Add("@Field4", SqlDbType.VarChar).Value = txtField4.Text
        Else
            cmd.Parameters.Add("@Field4", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField5.Text <> "" Then
            cmd.Parameters.Add("@Field5", SqlDbType.VarChar).Value = txtField5.Text
        Else
            cmd.Parameters.Add("@Field5", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField6.Text <> "" Then
            cmd.Parameters.Add("@Field6", SqlDbType.VarChar).Value = txtField6.Text
        Else
            cmd.Parameters.Add("@Field6", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField7.Text <> "" Then
            cmd.Parameters.Add("@Field7", SqlDbType.VarChar).Value = txtField7.Text
        Else
            cmd.Parameters.Add("@Field7", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField8.Text <> "" Then
            cmd.Parameters.Add("@Field8", SqlDbType.VarChar).Value = txtField8.Text
        Else
            cmd.Parameters.Add("@Field8", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField9.Text <> "" Then
            cmd.Parameters.Add("@Field9", SqlDbType.VarChar).Value = txtField9.Text
        Else
            cmd.Parameters.Add("@Field9", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField10.Text <> "" Then
            cmd.Parameters.Add("@Field10", SqlDbType.VarChar).Value = txtField10.Text
        Else
            cmd.Parameters.Add("@Field10", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField11.Text <> "" Then
            cmd.Parameters.Add("@Field11", SqlDbType.VarChar).Value = txtField11.Text
        Else
            cmd.Parameters.Add("@Field11", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField12.Text <> "" Then
            cmd.Parameters.Add("@Field12", SqlDbType.VarChar).Value = txtField12.Text
        Else
            cmd.Parameters.Add("@Field12", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField13.Text <> "" Then
            cmd.Parameters.Add("@Field13", SqlDbType.VarChar).Value = txtField13.Text
        Else
            cmd.Parameters.Add("@Field13", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField14.Text <> "" Then
            cmd.Parameters.Add("@Field14", SqlDbType.VarChar).Value = txtField14.Text
        Else
            cmd.Parameters.Add("@Field14", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField15.Text <> "" Then
            cmd.Parameters.Add("@Field15", SqlDbType.VarChar).Value = txtField15.Text
        Else
            cmd.Parameters.Add("@Field15", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField16.Text <> "" Then
            cmd.Parameters.Add("@Field16", SqlDbType.VarChar).Value = txtField16.Text
        Else
            cmd.Parameters.Add("@Field16", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtField17.Text <> "" Then
            cmd.Parameters.Add("@Field17", SqlDbType.VarChar).Value = txtField17.Text
        Else
            cmd.Parameters.Add("@Field17", SqlDbType.VarChar).Value = DBNull.Value
        End If

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()

            lblUpdateStatus.Text = "Your school was successfully updated"

        Finally
            strSQLConn.Close()
        End Try
    End Sub
End Class
