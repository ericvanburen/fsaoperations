Imports Microsoft.VisualBasic
Imports Microsoft.Office.Interop.Access
Imports System.Data.OleDb
Imports Module2
Imports Module3
Imports Module4

Partial Class Macros_Default
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        get_brwr_num()
    End Sub

End Class
