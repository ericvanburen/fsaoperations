Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing

Partial Class Issues_Report_All_CountByCategory
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        ChartCategories()
    End Sub

    'Chart - Categories
    Sub ChartCategories()
        Using myConnection As New SqlConnection
            myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString

            Dim cmd As New SqlCommand
            cmd.Connection = myConnection
            cmd.CommandText = "p_Report_All_CountByCategory"
            cmd.CommandType = Data.CommandType.StoredProcedure
            myConnection.Open()
            Dim myReader As SqlDataReader = cmd.ExecuteReader()

            'Use this one as a default for each value/series in the table - remove any series value in the chart

            chtCategories.DataBindTable(myReader, "Category")
            chtCategories.Series(0).IsValueShownAsLabel = True
            chtCategories.Series(0).Color = Color.IndianRed

            myReader.Close()
            myConnection.Close()

        End Using
    End Sub

End Class
