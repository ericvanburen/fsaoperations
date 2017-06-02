Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing

Partial Class Issues_Dashboard
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        ChartIssueTypeOpen()
        ChartIssueStatus()
        ChartSourceOrgType()
    End Sub

    'Chart - Issue Type
    Sub ChartIssueTypeOpen()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Report_Issue_Type_Open"
            cmd.CommandType = Data.CommandType.StoredProcedure

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtOpenIssues.DataBindTable(myReader, "Issue Type")
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
            'cmd.Parameters.Add("@DateReceivedBegin", SqlDbType.SmallDateTime).Value = "1/1/2000"
            'cmd.Parameters.Add("@DateReceivedEnd", SqlDbType.SmallDateTime).Value = "1/1/2050"
            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtIssueStatus.DataBindTable(myReader, "General_Review_Total_Incorrect")
            chtIssueStatus.Series(0).IsValueShownAsLabel = True

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

    Protected Sub ddlDays_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlDays.SelectedIndexChanged
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_IssuesResolvedLastXDays", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@Days", SqlDbType.Int).Value = ddlDays.SelectedValue

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    lblCompletedIssueCount.Text = dr("IssueCount").ToString() & " Issues Closed Within Last " & ddlDays.SelectedValue & " Days"
                End While
            End Using
        Finally
            con.Close()
        End Try

        dsClosedIssuesXDays.SelectParameters("Days").DefaultValue = ddlDays.SelectedValue
        GridView1.DataBind()
        'lblCompletedIssueCount.DataBind()
    End Sub

    'Chart - Source Org Type
    Sub ChartSourceOrgType()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Chart_SourceOrgType"
            cmd.CommandType = Data.CommandType.StoredProcedure

            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart
            chtSourceOrgType.DataBindTable(myReader, "SourceOrgType")
            chtSourceOrgType.Series(0).IsValueShownAsLabel = True
            chtSourceOrgType.Series(0).Color = Color.Crimson

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

   
End Class
