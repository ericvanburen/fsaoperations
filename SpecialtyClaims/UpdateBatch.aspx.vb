Imports System.IO
Imports System.Data
Imports System.Data.SqlClient

Partial Class DMCSRefunds_MyRefunds
    Inherits System.Web.UI.Page
    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            btnApprove.Enabled = False
        End If
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Dim strServicer As String = ddlServicer.SelectedValue
        Dim strDischargeType As String = ddlDischargeType.SelectedValue
        Dim strDateReceived As String = txtDateReceived.Text

        If strServicer <> "" Then
            dsSearchBatch.SelectParameters("Servicer").DefaultValue = strServicer
        End If

        If strDischargeType <> "" Then
            dsSearchBatch.SelectParameters("DischargeType").DefaultValue = strDischargeType
        End If

        If strDateReceived <> "" Then
            dsSearchBatch.SelectParameters("DateReceived").DefaultValue = CDate(strDateReceived)
        End If

        'Get record count
        Dim dv As System.Data.DataView = DirectCast(dsSearchBatch.[Select](DataSourceSelectArguments.Empty), DataView)
        If dv.Count < 1 Then
            lblSearchResultsStatus.Text = "No claims were found using the above search criteria"
            btnApprove.Enabled = False
        Else
            lblSearchResultsStatus.Text = ""
            btnApprove.Enabled = True
        End If

    End Sub

    Protected Sub btnApprove_Click(sender As Object, e As EventArgs)
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        'BindGridView()

            For Each gvRow As GridViewRow In GridView1.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(GridView1.DataKeys(gvRow.RowIndex)("ClaimID"))
                'Pass the ClaimID value to update the approval status value
                UpdateClaimApproval(rowIndex)
            End If
        Next

        lblSearchResultsStatus.Text = "Your claims have been approved"

    End Sub

    Sub UpdateClaimApproval(ByVal ClaimID As Integer)

        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString)
        strSql = "p_UpdateClaimApproval"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ClaimID", SqlDbType.Int).Value = ClaimID
        cmd.Parameters.AddWithValue("@LoanAnalyst", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name.ToString

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
        Finally
            strConnection.Close()
        End Try
    End Sub

End Class
