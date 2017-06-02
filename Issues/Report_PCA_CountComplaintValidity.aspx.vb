Imports System.Data
Imports System.Data.SqlClient

Partial Class Issues_Report_PCA_CountComplaintValidity
    Inherits System.Web.UI.Page

    Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            txtDateReceivedEnd.Value = DateTime.Now.Date
        End If
    End Sub

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Sub btnSearch_Click(sender As Object, e As EventArgs)
        'ChartPCAComplaints()
        'GridView1.DataBind()
        
        dsPCAComplaints.SelectParameters(0).DefaultValue = txtDateReceivedBegin.Value
        dsPCAComplaints.SelectParameters(1).DefaultValue = txtDateReceivedEnd.Value
        GridView1.DataBind()
        GridView1.Visible = True
        btnExportExcel.Visible = True
    End Sub

    'Chart - PCA Complaints
    Sub ChartPCAComplaints()
        'Using myConnection As New SqlConnection
        '    myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

        '    Dim cmd As New SqlCommand
        '    cmd.Connection = myConnection
        '    cmd.CommandText = "p_Report_PCA_CountComplaintValidity"
        '    cmd.CommandType = Data.CommandType.StoredProcedure
        '    cmd.Parameters.Add("@DateReceivedBegin", SqlDbType.SmallDateTime).Value = txtDateReceivedBegin.Value
        '    cmd.Parameters.Add("@DateReceivedEnd", SqlDbType.SmallDateTime).Value = txtDateReceivedEnd.Value

        '    myConnection.Open()
        '    Dim myReader As SqlDataReader = cmd.ExecuteReader()

        '    'Use this one as a default for each value/series in the table - remove any series value in the chart
        '    chtPCAComplaints.DataBindTable(myReader, "PCA")
        '    chtPCAComplaints.Series(0).IsValueShownAsLabel = True
        '    chtPCAComplaints.Series(0).Color = System.Drawing.Color.Gold

        '    myReader.Close()
        '    myConnection.Close()

        'End Using
    End Sub

    Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        GridView1.AllowPaging = False
        GridView1.AllowSorting = False
        ExportExcel()
    End Sub

    Protected Sub ExportExcel()
        GridView1.AllowSorting = False
        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=PCAComplaintCounts.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Dim stringWrite As System.IO.StringWriter = New System.IO.StringWriter()
        Dim htmlWrite As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(stringWrite)
        GridView1.RenderControl(htmlWrite)
        Response.Write(stringWrite.ToString())
        Response.End()
    End Sub

End Class
