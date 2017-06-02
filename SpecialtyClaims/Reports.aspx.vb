Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Csv

Partial Class SpecialtyClaims_Reports
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Protected Sub cblAllAgencies_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cblAllAgencies.SelectedIndexChanged
        'Each time a servicer is selected this method is executed
        Dim strServicer As String = cblAllAgencies.SelectedValue.ToString()
        dsReportByAgency.SelectParameters("Servicer").DefaultValue = strServicer
        dsReportByAgency.DataBind()
    End Sub

    Sub dsReportByAgency_Selected(ByVal sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows > 0 Then
            btnExportExcel.Visible = "true"
            lblSearchResultsStatus.Text = "Your search returned " & e.AffectedRows & " records"
        Else
            btnExportExcel.Visible = "false"
            lblSearchResultsStatus.Text = "Your search returned 0 records"
        End If
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        UpdateServicerInformedDate()
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        Dim Servicer As String = cblAllAgencies.SelectedValue.ToString()
        Dim FileDate As String = Replace(FormatDateTime(Now(), DateFormat.ShortDate), "/", "")

        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=Completed_Claims_" & Servicer & "_" & FileDate & ".xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
        btnExportExcel.Visible = False
    End Sub

    Sub UpdateServicerInformedDate()
        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("SpecialtyClaimsConnectionString").ConnectionString)

        Dim cmd As New SqlCommand("p_UpdateServicerInformedDate_Report", MyConnection)
        With cmd
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add("@ServicerInformedDate", SqlDbType.SmallDateTime)
            .Parameters("@ServicerInformedDate").Value = txtServicerInformedDate.Text

            .Parameters.Add("@Servicer", SqlDbType.VarChar, 100)
            .Parameters("@Servicer").Value = cblAllAgencies.SelectedValue
        End With

        Try
            MyConnection.Open()
            cmd.Connection = MyConnection
            cmd.ExecuteNonQuery()
        Finally
            MyConnection.Close()
        End Try
    End Sub

    
End Class
