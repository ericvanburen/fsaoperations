
Partial Class ServicerDashboard_ServicerHistory
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim ServicerID As Integer
            If Not Request.QueryString("ServicerID") Is Nothing Then
                ServicerID = Request.QueryString("ServicerID")
            Else
                ServicerID = 0
            End If
            dsServicerHistory.SelectParameters("ServicerID").DefaultValue = ServicerID
            'Set the value for the dropdown list if there is one
            If ServicerID > 0 Then
                ddlServicer.SelectedValue = ServicerID
            End If
        End If
    End Sub

    Sub GridView1_RowDataBound(Sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            If e.Row.Cells(1).Text = "Green" Then
                e.Row.Cells(1).BackColor = System.Drawing.Color.LightGreen
            ElseIf e.Row.Cells(1).Text = "Yellow" Then
                e.Row.Cells(1).BackColor = System.Drawing.Color.LemonChiffon
            ElseIf e.Row.Cells(1).Text = "Red" Then
                e.Row.Cells(1).BackColor = System.Drawing.Color.Tomato
            Else
                e.Row.Cells(1).BackColor = System.Drawing.Color.White
            End If
        End If
    End Sub

    Protected Sub ddlServicer_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlServicer.SelectedIndexChanged
        dsServicerHistory.SelectParameters("ServicerID").DefaultValue = ddlServicer.SelectedValue
    End Sub
End Class
