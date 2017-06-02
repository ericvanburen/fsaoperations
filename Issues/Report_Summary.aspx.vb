Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Web.UI.DataVisualization.Charting

Partial Class Issues_Report_Summary
    Inherits System.Web.UI.Page

    Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            txtDateReceivedEnd.Value = DateTime.Now.Date
            'pnlMainDiv.Visible = False
        End If
    End Sub

    Sub btnSearch_Click(sender As Object, e As EventArgs)
        ChartIssueTypeOpen()
        ChartIssueStatus()
        ChartAssignedTo()
        ChartCategory()
        ChartAffectedOrg()
    End Sub

    'Chart - Issue Type
    Sub ChartIssueTypeOpen()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Chart_Issue_Type_Open"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@DateReceivedBegin", SqlDbType.SmallDateTime).Value = txtDateReceivedBegin.Value
            cmd.Parameters.Add("@DateReceivedEnd", SqlDbType.SmallDateTime).Value = txtDateReceivedEnd.Value

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtOpenIssues.DataBindTable(myReader, "IssueType")
            chtOpenIssues.Series(0).IsValueShownAsLabel = True
            chtOpenIssues.Series(0).Color = Color.Gold

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

    'Chart Issue Status
    Sub ChartIssueStatus()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Chart_Issue_Status"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@DateReceivedBegin", SqlDbType.SmallDateTime).Value = txtDateReceivedBegin.Value
            cmd.Parameters.Add("@DateReceivedEnd", SqlDbType.SmallDateTime).Value = txtDateReceivedEnd.Value
            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtIssueStatus.DataBindTable(myReader, "IssueStatus")
            chtIssueStatus.Series(0).IsValueShownAsLabel = True

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

    'Chart - Assigned To
    Sub ChartAssignedTo()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Chart_AssignedTo"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@DateReceivedBegin", SqlDbType.SmallDateTime).Value = txtDateReceivedBegin.Value
            cmd.Parameters.Add("@DateReceivedEnd", SqlDbType.SmallDateTime).Value = txtDateReceivedEnd.Value
            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtAssignedTo.DataBindTable(myReader, "UserID")
            chtAssignedTo.Series(0).IsValueShownAsLabel = True
            chtAssignedTo.Series(0).Color = Color.DarkRed

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

    'Chart - Category
    Sub ChartCategory()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Chart_Category"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@DateReceivedBegin", SqlDbType.SmallDateTime).Value = txtDateReceivedBegin.Value
            cmd.Parameters.Add("@DateReceivedEnd", SqlDbType.SmallDateTime).Value = txtDateReceivedEnd.Value
            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtCategory.DataBindTable(myReader, "Category")
            chtCategory.Series(0).IsValueShownAsLabel = True
            chtCategory.Series(0).Color = Color.Violet

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

    'Chart - Affected Org
    Sub ChartAffectedOrg()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Chart_AffectedOrg"
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.Add("@DateReceivedBegin", SqlDbType.SmallDateTime).Value = txtDateReceivedBegin.Value
            cmd.Parameters.Add("@DateReceivedEnd", SqlDbType.SmallDateTime).Value = txtDateReceivedEnd.Value

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtAffectedOrg.DataBindTable(myReader, "AffectedOrg")
            chtAffectedOrg.Series(0).IsValueShownAsLabel = True

            myReader.Close()
            myConnection.Close()

        End Using


    End Sub


End Class
