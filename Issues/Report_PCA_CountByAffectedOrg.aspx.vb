Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.Web.UI.DataVisualization.Charting

Partial Class Issues_Report_PCA_CountByAffectedOrg
    Inherits System.Web.UI.Page

    Sub Page_Load(sender As Object, e As EventArgs)
        'ChartPCAIssuesAssignedLoanAnalysts()
        'ChartMe()
        Chart2.ChartAreas("ChartArea1").AxisX.LabelStyle.Angle = -45

        Chart2.Legends(0).Position.Auto = False
        Chart2.Legends(0).Position = New ElementPosition(0, 4, 100, 25)
    End Sub




End Class
