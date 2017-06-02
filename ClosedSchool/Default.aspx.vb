Imports System.Data
Imports System.Data.SqlClient

Partial Class _Default
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Sub BindGridView()
        Dim ds As DataSet
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ClosedSchoolConnectionString").ConnectionString)
        strSQL = "p_SchoolSearch"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con

        If txtOPEID.Text <> "" Then
            cmd.Parameters.AddWithValue("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        End If

        If txtClosedDate.Text <> "" Then
            cmd.Parameters.AddWithValue("@ClosedDate", SqlDbType.SmallDateTime).Value = txtClosedDate.Text
        End If

        If txtSchoolName.Text <> "" Then
            cmd.Parameters.AddWithValue("@SchoolName", SqlDbType.VarChar).Value = txtSchoolName.Text
        End If

        If txtLocation.Text <> "" Then
            cmd.Parameters.AddWithValue("@Location", SqlDbType.NVarChar).Value = txtLocation.Text
        End If

        If txtAddress.Text <> "" Then
            cmd.Parameters.AddWithValue("@Address", SqlDbType.NVarChar).Value = txtAddress.Text
        End If

        If txtCity.Text <> "" Then
            cmd.Parameters.AddWithValue("@City", SqlDbType.NVarChar).Value = txtCity.Text
        End If

        If ddlState.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@State", SqlDbType.VarChar).Value = ddlState.SelectedValue
        End If

        If txtZipCode.Text <> "" Then
            cmd.Parameters.AddWithValue("@ZipCode", SqlDbType.Float).Value = txtZipCode.Text
        End If

        If ddlCountryForeign.SelectedValue <> "" Then
            cmd.Parameters.AddWithValue("@CountryForeign", SqlDbType.Float).Value = ddlCountryForeign.SelectedValue
        End If


        Try
            con.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)

            ds = New DataSet()
            MyAdapter.Fill(ds, "SearchResults")

            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            lblRecordCount.Text = "Your search returned " & intRecordCount & " records"
            If intRecordCount > 0 Then
                btnExportExcel.Visible = True
            Else
                btnExportExcel.Visible = False
            End If

            GridView1.DataSource = ds.Tables("SearchResults").DefaultView
            GridView1.DataBind()
            GridView1.Visible = True
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        BindGridView()
    End Sub

    Sub btnExportExcel_Click(ByVal sender As Object, e As EventArgs)
        ExportGridToExcel()
    End Sub

    Private Sub ExportGridToExcel()
        GridView1.AllowSorting = False
        GridView1.AllowPaging = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=ClosedSchoolResults.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

    Protected Sub btnClearForm_Click(sender As Object, e As EventArgs)
        Response.Redirect("default.aspx")
    End Sub

End Class
