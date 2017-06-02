Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI

Partial Class DMCSRefunds_MyRefunds
    Inherits System.Web.UI.Page
    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

        End If
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Dim strAccountNumber As String = txtAccountNo.Text.ToString
        dsSearchAccountNumber.SelectParameters("AccountNumber").DefaultValue = strAccountNumber

        Dim dv As System.Data.DataView = DirectCast(dsSearchAccountNumber.[Select](DataSourceSelectArguments.Empty), DataView)
        If dv.Count < 1 Then
            lblSearchResultsStatus.Text = "No claims were found for this account number. <a href='EnterNewClaim.aspx'>Enter new claim</a>"
        Else
            lblSearchResultsStatus.Text = ""
        End If
    End Sub

    Sub btnDeleteClaim_Click(sender As Object, e As EventArgs)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_DeleteClaimID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ClaimID", SqlDbType.Int).Value = lblClaimID.Text

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
            End Using

            GridView1.DataBind()
        Finally
            con.Close()
        End Try
    End Sub

    Sub ServerValidation(source As Object, arguments As ServerValidateEventArgs)
        If Len(arguments.Value) < 1 And chkApprove.Checked = False Then
            arguments.IsValid = False
            Me.ModalPopupExtender1.Show()
        Else
            arguments.IsValid = True
        End If
    End Sub

    Sub btnUpdate_Click(sender As Object, e As EventArgs)
        If Page.IsValid Then

            Dim con As SqlConnection
            Dim cmd As SqlCommand
            Dim dr As SqlDataReader

            con = New SqlConnection(ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString)
            cmd = New SqlCommand("p_UpdateClaimID", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.Add("@ClaimID", SqlDbType.Int).Value = lblClaimID.Text

            If txtAccountNo.Text <> "" Then
                cmd.Parameters.Add("@AccountNumber", SqlDbType.VarChar).Value = txtAccountNumber.Text
            Else
                cmd.Parameters.Add("@AccountNumber", SqlDbType.VarChar).Value = DBNull.Value
            End If

            If txtBorrowerName.Text <> "" Then
                cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = txtBorrowerName.Text
            Else
                cmd.Parameters.Add("@BorrowerName", SqlDbType.VarChar).Value = DBNull.Value
            End If

            If ddlDischargeType.SelectedValue <> "" Then
                cmd.Parameters.Add("@DischargeType", SqlDbType.VarChar).Value = ddlDischargeType.SelectedValue.ToUpper()
            Else
                cmd.Parameters.Add("@DischargeType", SqlDbType.VarChar).Value = DBNull.Value
            End If

            If ddlServicer.SelectedValue <> "" Then
                cmd.Parameters.Add("@Servicer", SqlDbType.VarChar).Value = ddlServicer.SelectedValue.ToUpper()
            Else
                cmd.Parameters.Add("@Servicer", SqlDbType.VarChar).Value = DBNull.Value
            End If

            If txtDateReceived.Text <> "" Then
                cmd.Parameters.Add("@DateReceived", SqlDbType.SmallDateTime).Value = txtDateReceived.Text
            Else
                cmd.Parameters.Add("@DateReceived", SqlDbType.SmallDateTime).Value = DBNull.Value
            End If

            cmd.Parameters.Add("@LoanAnalyst", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name
            cmd.Parameters.Add("@Approve", SqlDbType.Bit).Value = chkApprove.Checked

            If txtDateCompleted.Text <> "" Then
                cmd.Parameters.Add("@DateCompleted", SqlDbType.SmallDateTime).Value = txtDateCompleted.Text
            Else
                cmd.Parameters.Add("@DateCompleted", SqlDbType.SmallDateTime).Value = DBNull.Value
            End If

            If txtComments.Text <> "" Then
                cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txtComments.Text
            Else
                cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
            End If

            Try
                cmd.Connection = con
                Using con
                    con.Open()
                    dr = cmd.ExecuteReader()
                End Using

                GridView1.DataBind()
            Finally
                con.Close()
            End Try
        End If
    End Sub

    Sub imgbtn_Click(sender As Object, e As ImageClickEventArgs)
        Dim btndetails As ImageButton = TryCast(sender, ImageButton)
        Dim gvrow As GridViewRow = DirectCast(btndetails.NamingContainer, GridViewRow)
        Dim ClaimID As Integer
        ClaimID = GridView1.DataKeys(gvrow.RowIndex).Value

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ClaimID", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@ClaimID", SqlDbType.Int).Value = ClaimID
        'cmd.Parameters.Add("@ClaimID", SqlDbType.VarChar).Value = gvrow.Cells(3).Text

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    If Not dr("ClaimID") Is DBNull.Value Then
                        lblClaimID.Text = dr("ClaimID").ToString()
                    End If

                    If Not dr("AccountNumber") Is DBNull.Value Then
                        txtAccountNumber.Text = dr("AccountNumber").ToString()
                    End If

                    If Not dr("Servicer") Is DBNull.Value Then
                        ddlServicer.SelectedValue = dr("Servicer").ToLower()
                    End If

                    If Not dr("BorrowerName") Is DBNull.Value Then
                        txtBorrowerName.Text = dr("BorrowerName").ToString()
                    End If

                    If Not dr("DischargeType") Is DBNull.Value Then
                        ddlDischargeType.SelectedValue = dr("DischargeType").ToLower()
                    End If

                    If Not dr("DateReceived") Is DBNull.Value Then
                        txtDateReceived.Text = dr("DateReceived").ToString()
                    End If

                    If Not dr("DateCompleted") Is DBNull.Value Then
                        txtDateCompleted.Text = dr("DateCompleted").ToString()
                    Else
                        txtDateCompleted.Text = Date.Now()
                    End If

                    chkApprove.Checked = dr("Approve")

                    If Not dr("Comments") Is DBNull.Value Then
                        txtComments.Text = dr("Comments").ToString()
                    End If

                End While
            End Using

        Finally
            con.Close()
        End Try
        Me.ModalPopupExtender1.Show()

    End Sub

   

End Class
