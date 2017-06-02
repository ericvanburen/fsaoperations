Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class Unconsolidation_AddRequest
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name

            ddlQA_Analyst.DataSource = Roles.GetUsersInRole("Forgiveness")
            ddlQA_Analyst.DataBind()

            ddlUserID.DataSource = Roles.GetUsersInRole("Forgiveness")
            ddlUserID.DataBind()

            ddlSubmittedBy.DataSource = Roles.GetUsersInRole("Forgiveness")
            ddlSubmittedBy.DataBind()

        End If
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        If GridView1.Rows.Count > 0 Then
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub
    
    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnSearchClaim_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ForgivenessConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtClaimID.Text <> "" Then
            cmd.Parameters.Add("@ClaimID", SqlDbType.Int).Value = Convert.ToInt32(txtClaimID.Text)
        End If

        If txtBorrower_Name.Text <> "" Then
            cmd.Parameters.AddWithValue("@Borrower_Name", SqlDbType.VarChar).Value = txtBorrower_Name.Text
        End If

        If txtAccount.Text <> "" Then
            cmd.Parameters.AddWithValue("@Account", SqlDbType.VarChar).Value = txtAccount.Text
        End If

        'This one passes a comma-delimited string for @ServicerId which is used in the split function
        If ddlServicerID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlServicerID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@ServicerID", SqlDbType.VarChar).Value = strSearchValue
        End If

        'This one passes a comma-delimited string for @SubmittedBy which is used in the split function
        If ddlSubmittedBy.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlSubmittedBy.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@SubmittedBy", SqlDbType.VarChar).Value = strSearchValue
        End If

        'This one passes a comma-delimited string for @UserID which is used in the split function
        If ddlUserID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlUserID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
        End If

        If txtDate_ReceivedBegin.Text <> "" Then
            cmd.Parameters.AddWithValue("@Date_ReceivedBegin", SqlDbType.SmallDateTime).Value = txtDate_ReceivedBegin.Text
        End If

        If txtDate_ReceivedEnd.Text <> "" Then
            cmd.Parameters.AddWithValue("@Date_ReceivedEnd", SqlDbType.SmallDateTime).Value = txtDate_ReceivedEnd.Text
        End If

        If ddlFSA_Approved.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@FSA_Approved", SqlDbType.VarChar).Value = ddlFSA_Approved.SelectedValue
        End If

        If txtDecision_DateBegin.Text <> "" Then
            cmd.Parameters.AddWithValue("@Decision_DateBegin", SqlDbType.SmallDateTime).Value = txtDecision_DateBegin.Text
        End If

        If txtDecision_DateEnd.Text <> "" Then
            cmd.Parameters.AddWithValue("@Decision_DateEnd", SqlDbType.SmallDateTime).Value = txtDecision_DateEnd.Text
        End If

        'This one passes a comma-delimited string 
        If ddlClaim_Type.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlClaim_Type.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Claim_Type", SqlDbType.VarChar).Value = strSearchValue
        End If

        'This one passes a comma-delimited string 
        If ddlApproval_Type.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlApproval_Type.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Approval_Type", SqlDbType.VarChar).Value = strSearchValue
        End If

        'This one passes a comma-delimited string 
        If ddlCategory_Program_Type_IDR.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlCategory_Program_Type_IDR.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@Category_Program_Type_IDR", SqlDbType.VarChar).Value = strSearchValue
        End If

        If chkEscalated.Checked = True Then
            cmd.Parameters.AddWithValue("@Escalated", SqlDbType.Bit).Value = chkEscalated.Checked
        End If

        If chkQA_Account.Checked = True Then
            cmd.Parameters.AddWithValue("@QA_Account", SqlDbType.Bit).Value = chkQA_Account.Checked
        End If

        If ddlQA_Analyst.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@QA_Analyst", SqlDbType.VarChar).Value = ddlQA_Analyst.SelectedValue
        End If

        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Reviews")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            GridView1.DataSource = ds.Tables("Reviews").DefaultView
            GridView1.DataBind()

            'Make search again button visible
            btnSearchAgainClaim.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, e As EventArgs)
        Response.Redirect("Search.aspx")
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    'Private Sub btnExcelExport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
    Protected Sub ExportExcel()

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ForgivenessConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_Search", MyConnection)

        With cmd
            .CommandType = CommandType.StoredProcedure
            'p_Search uses dynamic SQL so we pass a value to it only when there is one
            If txtClaimID.Text <> "" Then
                cmd.Parameters.Add("@ClaimID", SqlDbType.Int).Value = Convert.ToInt32(txtClaimID.Text)
            End If

            If txtBorrower_Name.Text <> "" Then
                cmd.Parameters.AddWithValue("@Borrower_Name", SqlDbType.VarChar).Value = txtBorrower_Name.Text
            End If

            If txtAccount.Text <> "" Then
                cmd.Parameters.AddWithValue("@Account", SqlDbType.VarChar).Value = txtAccount.Text
            End If

            'This one passes a comma-delimited string for @ServicerId which is used in the split function
            If ddlServicerID.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlServicerID.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@ServicerID", SqlDbType.VarChar).Value = strSearchValue
            End If

            'This one passes a comma-delimited string for @SubmittedBy which is used in the split function
            If ddlSubmittedBy.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlSubmittedBy.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@SubmittedBy", SqlDbType.VarChar).Value = strSearchValue
            End If

            'This one passes a comma-delimited string for @UserID which is used in the split function
            If ddlUserID.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlUserID.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = strSearchValue
            End If

            If txtDate_ReceivedBegin.Text <> "" Then
                cmd.Parameters.AddWithValue("@Date_ReceivedBegin", SqlDbType.SmallDateTime).Value = txtDate_ReceivedBegin.Text
            End If

            If txtDate_ReceivedEnd.Text <> "" Then
                cmd.Parameters.AddWithValue("@Date_ReceivedEnd", SqlDbType.SmallDateTime).Value = txtDate_ReceivedEnd.Text
            End If

            If ddlFSA_Approved.SelectedValue <> "" Then
                cmd.Parameters.AddWithValue("@FSA_Approved", SqlDbType.VarChar).Value = ddlFSA_Approved.SelectedValue
            End If

            If txtDecision_DateBegin.Text <> "" Then
                cmd.Parameters.AddWithValue("@Decision_DateBegin", SqlDbType.SmallDateTime).Value = txtDecision_DateBegin.Text
            End If

            If txtDecision_DateEnd.Text <> "" Then
                cmd.Parameters.AddWithValue("@Decision_DateEnd", SqlDbType.SmallDateTime).Value = txtDecision_DateEnd.Text
            End If

            'This one passes a comma-delimited string 
            If ddlClaim_Type.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlClaim_Type.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@Claim_Type", SqlDbType.VarChar).Value = strSearchValue
            End If

            'This one passes a comma-delimited string 
            If ddlApproval_Type.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlApproval_Type.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@Approval_Type", SqlDbType.VarChar).Value = strSearchValue
            End If

            'This one passes a comma-delimited string 
            If ddlCategory_Program_Type_IDR.SelectedValue <> "" Then
                Dim strSearchValue As String = ""
                Dim li As ListItem
                For Each li In ddlCategory_Program_Type_IDR.Items
                    If li.Selected = True Then
                        strSearchValue = strSearchValue & li.Value & ","
                    End If
                Next
                strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
                strSearchValue = Replace(strSearchValue, ",", ",")
                cmd.Parameters.AddWithValue("@Category_Program_Type_IDR", SqlDbType.VarChar).Value = strSearchValue
            End If

            If chkEscalated.Checked = True Then
                cmd.Parameters.AddWithValue("@Escalated", SqlDbType.Bit).Value = chkEscalated.Checked
            End If

            If chkQA_Account.Checked = True Then
                cmd.Parameters.AddWithValue("@QA_Account", SqlDbType.Bit).Value = chkQA_Account.Checked
            End If

            If ddlQA_Analyst.SelectedValue <> "" Then
                cmd.Parameters.AddWithValue("@QA_Analyst", SqlDbType.VarChar).Value = ddlQA_Analyst.SelectedValue
            End If

        End With

        Dim da As New SqlDataAdapter(cmd)
        Dim myDataTable As DataTable = New DataTable()
        da.Fill(myDataTable)

        Try
            MyConnection.Open()
            Response.Clear()
            Response.ClearHeaders()
            Dim writer As New CsvWriter(Response.OutputStream, ","c, Encoding.Default)
            writer.WriteAll(myDataTable, True)
            writer.Close()

            Dim FileDate As String = Replace(FormatDateTime(Now(), DateFormat.ShortDate), "/", "")
            Response.AddHeader("Content-Disposition", "attachment;filename=Forgiveness_Processing_" & FileDate & ".csv")
            Response.ContentType = "application/vnd.ms-excel"
            Response.End()
        Finally
            If MyConnection.State <> ConnectionState.Closed Then MyConnection.Close()
            MyConnection.Dispose()
            MyConnection = Nothing
            myDataTable.Dispose()
            myDataTable = Nothing
        End Try
    End Sub


End Class
