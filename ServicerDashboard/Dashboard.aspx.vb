
Partial Class ServicerDashboard_Dashboard
    Inherits System.Web.UI.Page

    Sub GridView1_RowDataBound(Sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            If e.Row.Cells(2).Text = "Green" Then
                e.Row.Cells(1).BackColor = System.Drawing.Color.LightGreen
                'e.Row.Cells(2).ForeColor = System.Drawing.Color.LightGreen
            ElseIf e.Row.Cells(2).Text = "Yellow" Then
                e.Row.Cells(1).BackColor = System.Drawing.Color.LemonChiffon
                'e.Row.Cells(2).ForeColor = System.Drawing.Color.LemonChiffon
            ElseIf e.Row.Cells(2).Text = "Red" Then
                e.Row.Cells(1).BackColor = System.Drawing.Color.Tomato
                'e.Row.Cells(2).ForeColor = System.Drawing.Color.Tomato
            Else
                e.Row.Cells(1).BackColor = System.Drawing.Color.LightGreen
                'e.Row.Cells(2).ForeColor = System.Drawing.Color.LightGreen
            End If
        End If
    End Sub

End Class
