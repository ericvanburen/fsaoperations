Imports System.Data
Imports System.Data.SqlClient

Partial Class Unconsolidation_Requests
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal Sender As Object, ByVal e As EventArgs)

    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Dim FilterExpression As String = String.Concat(ddlSearchType.SelectedValue, " LIKE '%{0}%'")
        dsRequests.FilterParameters.Clear()
        dsRequests.FilterParameters.Add(New ControlParameter(ddlSearchType.SelectedValue, "txtSearchPhrase", "Text"))
        dsRequests.FilterExpression = FilterExpression
        btnShowAll.Visible = True
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim intRequestID As Integer = GridView1.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(intRequestID)

        End If
    End Sub

    Protected Sub btnShowAll_Click(sender As Object, e As EventArgs)
        Response.Redirect("Requests.aspx")
    End Sub

    Protected Sub btnSubmitAgain_Click(sender As Object, e As EventArgs)
        Response.Redirect("Requests.aspx")
    End Sub

    Protected Sub LoadModal(RequestID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("UnconsolidationConnectionString").ConnectionString)
        cmd = New SqlCommand("p_RequestID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@RequestID", SqlDbType.Int).Value = RequestID
        lblRequestID.Text = RequestID

        'Clear the form values from any previous calls
        txtBorrower_Name.Text = ""
        txtAccount.Text = ""
        txtUnderlying_Servicer.Text = ""
        ddlCurrent_ServicerID.SelectedValue = ""
        txtConsolidation_Date.Text = ""
        txtUnderlying_Loan_Type.Text = ""
        txtUnderlying_Loan_ID.Text = ""
        ddlRequestor.SelectedValue = ""
        ddlFSA_Approved.SelectedValue = ""
        txtDecision_Date.Text = ""
        txtReason_For_Unconsolidation_Request.Text = ""
        txtFSA_Response.Text = ""
        txtServicer_Response.Text = ""
        txtFSA_Decision_Criteria.Text = ""
        lblUpdateConfirm.Text = ""

        'Clear the update confirm label
        lblUpdateConfirm.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    'Borrower_Name is ordinal 0 in p_RequestID
                    If Not dr.IsDBNull(0) Then
                        txtBorrower_Name.Text = dr("Borrower_Name")
                    End If

                    'Account is ordinal 1 in p_RequestID
                    If Not dr.IsDBNull(1) Then
                        txtAccount.Text = dr("Account")
                    End If

                    'Underlying_Servicer is ordinal 2 in p_RequestID
                    If Not dr.IsDBNull(2) Then
                        txtUnderlying_Servicer.Text = dr("Underlying_Servicer")
                    End If

                    'Current_ServicerID is ordinal 3 in p_RequestID
                    If Not dr.IsDBNull(3) Then
                        ddlCurrent_ServicerID.SelectedValue = dr("Current_ServicerID")
                    End If

                    'Consolidation_Date is ordinal 4 in p_RequestID
                    If Not dr.IsDBNull(4) Then
                        txtConsolidation_Date.Text = dr("Consolidation_Date")
                    End If

                    'Underlying_Loan_Type is ordinal 5 in p_RequestID
                    If Not dr.IsDBNull(5) Then
                        txtUnderlying_Loan_Type.Text = dr("Underlying_Loan_Type")
                    End If

                    'Underlying_Loan_ID is ordinal 6 in p_RequestID
                    If Not dr.IsDBNull(6) Then
                        txtUnderlying_Loan_ID.Text = dr("Underlying_Loan_ID")
                    End If

                    'Requestor is ordinal 7 in p_RequestID
                    If Not dr.IsDBNull(7) Then
                        ddlRequestor.SelectedValue = dr("Requestor")
                    End If

                    'FSA_Approved is ordinal 8 in p_RequestID
                    If Not dr.IsDBNull(8) Then
                        ddlFSA_Approved.SelectedValue = dr("FSA_Approved")
                    End If

                    'Decision_Date is ordinal 9 in p_RequestID
                    If Not dr.IsDBNull(9) Then
                        txtDecision_Date.Text = dr("Decision_Date")
                    End If

                    'Reason_For_Unconsolidation_Request is ordinal 10 in p_RequestID
                    If Not dr.IsDBNull(10) Then
                        txtReason_For_Unconsolidation_Request.Text = dr("Reason_For_Unconsolidation_Request")
                    End If

                    'FSA_Response is ordinal 11 in p_RequestID
                    If Not dr.IsDBNull(11) Then
                        txtFSA_Response.Text = dr("FSA_Response")
                    End If

                    'Servicer_Response is ordinal 12 in p_RequestID
                    If Not dr.IsDBNull(12) Then
                        txtServicer_Response.Text = dr("Servicer_Response")
                    End If

                    'Servicer_Response is ordinal 13 in p_RequestID
                    If Not dr.IsDBNull(13) Then
                        txtFSA_Decision_Criteria.Text = dr("FSA_Decision_Criteria")
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

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("UnconsolidationConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Request_Update", strSQLConn)

        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Borrower_Name", txtBorrower_Name.Text)
        cmd.Parameters.AddWithValue("@Account", txtAccount.Text)
        cmd.Parameters.AddWithValue("@Underlying_Servicer", txtUnderlying_Servicer.Text)
        cmd.Parameters.AddWithValue("@Current_ServicerID", ddlCurrent_ServicerID.SelectedValue)
        cmd.Parameters.AddWithValue("@Consolidation_Date", txtConsolidation_Date.Text)
        cmd.Parameters.AddWithValue("@Underlying_Loan_Type", txtUnderlying_Loan_Type.Text)
        cmd.Parameters.AddWithValue("@Underlying_Loan_ID", txtUnderlying_Loan_ID.Text)
        cmd.Parameters.AddWithValue("@Reason_For_Unconsolidation_Request", txtReason_For_Unconsolidation_Request.Text)

        If ddlRequestor.SelectedValue <> "" Then
            cmd.Parameters.Add("@Requestor", SqlDbType.VarChar).Value = ddlRequestor.SelectedValue
        Else
            cmd.Parameters.Add("@Requestor", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtFSA_Response.Text <> "" Then
            cmd.Parameters.Add("@FSA_Response", SqlDbType.VarChar).Value = txtFSA_Response.Text
        Else
            cmd.Parameters.Add("@FSA_Response", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtServicer_Response.Text <> "" Then
            cmd.Parameters.Add("@Servicer_Response", SqlDbType.VarChar).Value = txtServicer_Response.Text
        Else
            cmd.Parameters.Add("@Servicer_Response", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@FSA_Approved", ddlFSA_Approved.SelectedValue)

        If txtFSA_Decision_Criteria.Text <> "" Then
            cmd.Parameters.Add("@FSA_Decision_Criteria", SqlDbType.VarChar).Value = txtFSA_Decision_Criteria.Text
        Else
            cmd.Parameters.Add("@FSA_Decision_Criteria", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txtDecision_Date.Text <> "" Then
            cmd.Parameters.Add("@Decision_Date", SqlDbType.SmallDateTime).Value = txtDecision_Date.Text
        Else
            cmd.Parameters.Add("@Decision_Date", SqlDbType.SmallDateTime).Value = DBNull.Value
        End If

        cmd.Parameters.AddWithValue("@RequestID", lblRequestID.Text)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "Your request was updated"
            lblUpdateConfirm.Visible = True
            GridView1.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnDeleteAssignment_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("UnconsolidationConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteRequest", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@RequestID", SqlDbType.Int).Value = lblRequestID.Text
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "This request was deleted"
            lblUpdateConfirm.Visible = True
            GridView1.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        Dim FilterExpression As String = String.Concat(ddlSearchType.SelectedValue, " LIKE '%{0}%'")
        dsRequests.FilterParameters.Clear()
        dsRequests.FilterParameters.Add(New ControlParameter(ddlSearchType.SelectedValue, "txtSearchPhrase", "Text"))
        dsRequests.FilterExpression = FilterExpression

        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        'Dim ddlUserID As DropDownList = DirectCast(GridView1.HeaderRow.FindControl("ddlUserID"), DropDownList)
        'ddlUserID.Visible = False

        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Unconsolidation_Requests.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub
End Class
