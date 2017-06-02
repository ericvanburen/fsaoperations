Imports System.Data
Imports System.Data.SqlClient
Imports Csv

Partial Class Unconsolidation_AddRequest
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            lblUserID.Text = HttpContext.Current.User.Identity.Name
            dsMyClaims.SelectParameters("UserID").DefaultValue = HttpContext.Current.User.Identity.Name
        End If
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        If GridView1.Rows.Count > 0 Then
            GridView1.UseAccessibleHeader = True
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader
        End If
    End Sub

    Protected Sub dsMyClaims_Selected(ByVal sender As Object, ByVal e As SqlDataSourceStatusEventArgs)
        lblRowCount.Text = "You have " & e.AffectedRows & " claims assigned to you"

        If e.AffectedRows > 0 Then
            btnExportExcel.Visible = True
        Else
            btnExportExcel.Visible = False
        End If
    End Sub
    
    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub

    'Private Sub btnExcelExport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
    Protected Sub ExportExcel()

        Dim MyConnection As SqlConnection
        MyConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ForgivenessConnectionString").ConnectionString)
        Dim cmd As New SqlCommand("p_MyClaims", MyConnection)

        With cmd
            .CommandType = CommandType.StoredProcedure
            cmd.Parameters.Add("@UserID", SqlDbType.VarChar).Value = lblUserID.Text

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
