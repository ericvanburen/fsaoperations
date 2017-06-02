Imports System.Data
Imports System.Data.SqlClient
Imports Csv


Partial Class CCM2_CheckSearch2
    Inherits System.Web.UI.Page


    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            If Not (User.IsInRole("CCM_Admins")) Then
                'Non-Admin user
                ddlUserID.Items.FindByValue(lblUserID.Text).Selected = True
            End If
        End If

    End Sub

    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("ChecksSearch.aspx")
    End Sub

    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ChecksSearch", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        'p_Search uses dynamic SQL so we pass a value to it only when there is one
        If txtCheckID.Text <> "" Then
            cmd.Parameters.Add("@CheckID", SqlDbType.Int).Value = Convert.ToInt32(txtCheckID.Text)
        End If

        'This one passes a comma-delimited string for @CallCenterID which is used in the split function
        If ddlCallCenterID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlCallCenterID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            cmd.Parameters.AddWithValue("@CallCenterID", SqlDbType.VarChar).Value = strSearchValue
        End If

        'This one passes a comma-delimited string for @UserID which is used in the split function
        'Only admins can search for other users
        If ddlUserID.SelectedValue <> "" Then
            If (User.IsInRole("CCM_Admins")) Then
                'Admin user
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
            Else
                'Non-admin
                cmd.Parameters.AddWithValue("@UserID", SqlDbType.VarChar).Value = lblUserID.Text
            End If
        End If

        If txtDateSubmittedBegin.Text <> "" Then
            cmd.Parameters.Add("@DateSubmittedBegin", SqlDbType.VarChar).Value = txtDateSubmittedBegin.Text
        End If

        If txtDateSubmittedEnd.Text <> "" Then
            cmd.Parameters.Add("@DateSubmittedEnd", SqlDbType.VarChar).Value = txtDateSubmittedEnd.Text
        End If

        If ddlCheckType.SelectedValue <> "" Then
            cmd.Parameters.Add("@CheckType", SqlDbType.VarChar).Value = ddlCheckType.SelectedValue
        End If

        If ddlEscalated.SelectedValue <> "" Then
            cmd.Parameters.Add("@Escalated", SqlDbType.VarChar).Value = ddlEscalated.SelectedValue
        End If


        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "Checks")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            'lblRowCount.Text = "Your search returned " & intRecordCount & " records"

            'ds.Tables(0).DefaultView.Sort = lblSortExpression.Text

            GridView1.DataSource = ds.Tables("Checks").DefaultView
            GridView1.DataBind()

            'Make search again button visible
            'btnSearchAgain.Visible = True
        Finally
            strSQLConn.Close()
        End Try
    End Sub


    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName.Equals("detail") Then
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            Dim intCheckID As Integer = GridView1.DataKeys(index).Value
            Dim sb As New System.Text.StringBuilder()
            sb.Append("<script type='text/javascript'>")
            sb.Append("$('#myModal').modal('show');")
            sb.Append("</script>")
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "ModalScript", sb.ToString(), False)

            'Populate the popup modal
            LoadModal(intCheckID)

        End If
    End Sub

    Protected Sub LoadModal(CheckID As Integer)

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        'Dim isPCAAdmin As String = lblPCAAdmin.Text.ToString()

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CheckIDDetail", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@CheckID", SqlDbType.Int).Value = CheckID
        lblCheckID.Text = CheckID

        ''Clear the form values from any previous calls
        ddl_mod_CallCenterID.SelectedValue = ""
        ddl_mod_CheckType.SelectedValue = ""
        txt_mod_BeginTime.Text = ""
        txt_mod_EndTime.Text = ""
        txt_mod_HoldTime.Text = ""
        ddl_mod_Escalated.SelectedValue = ""
        txt_mod_Comments.Text = ""

        'Clear the update confirm label
        lblUpdateConfirm.Text = ""

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    'CallCenterID is ordinal 0 in p_CheckIDDetail
                    If Not dr.IsDBNull(0) Then
                        ddl_mod_CallCenterID.SelectedValue = dr("CallCenterID")
                    End If

                    'CheckType is ordinal 1 in p_CheckIDDetail
                    If Not dr.IsDBNull(1) Then
                        ddl_mod_CheckType.SelectedValue = dr("CheckType")
                    End If

                    'BeginTime is ordinal 2 in p_CheckIDDetail
                    If Not dr.IsDBNull(2) Then
                        txt_mod_BeginTime.Text = dr("BeginTime")
                    End If

                    'EndTime is ordinal 3 in p_CheckIDDetail
                    If Not dr.IsDBNull(3) Then
                        txt_mod_EndTime.Text = dr("EndTime")
                    End If

                    'HoldTime is ordinal 4 in p_CheckIDDetail
                    If Not dr.IsDBNull(4) Then
                        txt_mod_HoldTime.Text = dr("HoldTime")
                    End If

                    'Escalated is ordinal 5 in p_CheckIDDetail
                    If Not dr.IsDBNull(5) Then
                        ddl_mod_Escalated.SelectedValue = dr("Escalated")
                    End If

                    'Comments is ordinal 6 in p_CheckIDDetail
                    If Not dr.IsDBNull(6) Then
                        txt_mod_Comments.Text = dr("Comments")
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

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CheckID_Update", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        If ddl_mod_CallCenterID.SelectedValue <> "" Then
            cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = ddl_mod_CallCenterID.SelectedValue
        Else
            cmd.Parameters.Add("@CallCenterID", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddl_mod_CheckType.SelectedValue <> "" Then
            cmd.Parameters.Add("@CheckType", SqlDbType.VarChar).Value = ddl_mod_CheckType.SelectedValue
        Else
            cmd.Parameters.Add("@CheckType", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If txt_mod_BeginTime.Text <> "" Then
            cmd.Parameters.Add("@BeginTime", SqlDbType.DateTime).Value = txt_mod_BeginTime.Text
        Else
            cmd.Parameters.Add("@BeginTime", SqlDbType.DateTime).Value = DBNull.Value
        End If

        If txt_mod_EndTime.Text <> "" Then
            cmd.Parameters.Add("@EndTime", SqlDbType.DateTime).Value = txt_mod_EndTime.Text
        Else
            cmd.Parameters.Add("@EndTime", SqlDbType.DateTime).Value = DBNull.Value
        End If

        If txt_mod_HoldTime.Text <> "" Then
            cmd.Parameters.Add("@HoldTime", SqlDbType.Int).Value = txt_mod_HoldTime.Text
        Else
            cmd.Parameters.Add("@HoldTime", SqlDbType.Int).Value = DBNull.Value
        End If

        If ddl_mod_Escalated.SelectedValue <> "" Then
            cmd.Parameters.Add("@Escalated", SqlDbType.VarChar).Value = ddl_mod_Escalated.SelectedValue
        Else
            cmd.Parameters.Add("@Escalated", SqlDbType.VarChar).Value = DBNull.Value
        End If

        If Len(txt_mod_Comments.Text) > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = txt_mod_Comments.Text
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        cmd.Parameters.Add("@CheckID", SqlDbType.Int).Value = lblCheckID.Text

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "Your data request was updated"
            lblUpdateConfirm.Visible = True
            'GridView1.DataBind()
            BindGridView()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Protected Sub btnDeleteCheck_Click(sender As Object, e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_ServicerCheck_Delete", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@CheckID", SqlDbType.Int).Value = lblCheckID.Text
        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateConfirm.Text = "This servicer check was deleted"
            lblUpdateConfirm.Visible = True
            'UpdatePanel2.DataBind()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        'dsDataRequests.SelectParameters("ReviewPeriod").DefaultValue = ViewState("Filter")
        'GridView1.DataBind()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Servicer_Checks_Report.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub


End Class
