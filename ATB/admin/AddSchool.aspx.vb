Imports System.Data
Imports System.Data.SqlClient

Partial Class ATB_New_admin_AddSchool
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        If Not Page.IsPostBack Then

            If Not Request.QueryString("OPEID") Is Nothing Then
                txtOPEID.Text = Request.QueryString("OPEID").ToString()
                PopulateForm()
                btnAddRecord.Visible = False
                btnUpdateRecord.Visible = True
            Else
                btnAddRecord.Visible = True
                btnUpdateRecord.Visible = False
            End If
        End If
    End Sub

    Sub btnAddRecord_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim strRecordStatus As Boolean

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddSchool", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        cmd.Parameters.Add("@SchoolName_Summary", SqlDbType.VarChar).Value = txtSchoolName_Summary.Text
        cmd.Parameters.Add("@ViolationDescription_Summary", SqlDbType.VarChar).Value = txtViolationDescription_Summary.Text
        cmd.Parameters.Add("@ViolationSources_Summary", SqlDbType.VarChar).Value = ddlViolationSources_Summary.SelectedValue
        cmd.Parameters.Add("@Recommendation_Summary", SqlDbType.VarChar).Value = ddlRecommendation_Summary.SelectedValue
        cmd.Parameters.Add("@Comments_Summary", SqlDbType.VarChar).Value = txtComments_Summary.Text
        cmd.Parameters.Add("@RecordStatus", SqlDbType.Bit).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            strRecordStatus = cmd.Parameters("@RecordStatus").Value

            If strRecordStatus = True Then
                lblUpdateStatus.Text = "Your school was successfully added to the database"
            Else
                lblUpdateStatus.Text = "Your school was not added because this school already exists in the database"
            End If
        Finally
            strSQLConn.Close()
        End Try
    End Sub


    Sub PopulateForm()
        'Clear the previous form values
        txtSchoolName_Summary.Text = ""
        txtViolationDescription_Summary.Text = ""
        txtViolationSources_Summary.Text = ""
        txtRecommendation_Summary.Text = ""
        txtComments_Summary.Text = ""

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_EditATBFinding", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    If Not IsDBNull(dr("SchoolName_Summary")) Then
                        txtSchoolName_Summary.Text = dr("SchoolName_Summary")
                    End If

                    If Not IsDBNull(dr("ViolationDescription_Summary")) Then
                        txtViolationDescription_Summary.Text = dr("ViolationDescription_Summary")
                    End If

                    If Not IsDBNull(dr("ViolationSources_Summary")) Then
                        txtViolationSources_Summary.Text = dr("ViolationSources_Summary")
                    End If

                    If Not IsDBNull(dr("Recommendation_Summary")) Then
                        txtRecommendation_Summary.Text = dr("Recommendation_Summary")
                    End If

                    If Not IsDBNull(dr("Comments_Summary")) Then
                        txtComments_Summary.Text = dr("Comments_Summary")
                    End If
                End While
            End Using

            ddlViolationSources_Summary.Visible = False
            ddlRecommendation_Summary.Visible = False
            txtViolationSources_Summary.Visible = True
            txtRecommendation_Summary.Visible = True

        Finally
            con.Close()
        End Try
    End Sub

    Sub btnUpdateRecord_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateATBFinding", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        cmd.Parameters.Add("@SchoolName_Summary", SqlDbType.VarChar).Value = txtSchoolName_Summary.Text
        cmd.Parameters.Add("@ViolationDescription_Summary", SqlDbType.VarChar).Value = txtViolationDescription_Summary.Text
        cmd.Parameters.Add("@ViolationSources_Summary", SqlDbType.VarChar).Value = txtViolationSources_Summary.Text
        cmd.Parameters.Add("@Recommendation_Summary", SqlDbType.VarChar).Value = txtRecommendation_Summary.Text
        cmd.Parameters.Add("@Comments_Summary", SqlDbType.VarChar).Value = txtComments_Summary.Text

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateStatus.Text = "Your ATB findings were successfully updated"
        Finally
            'strSQLConn.Close()
        End Try
    End Sub
End Class
