Imports System.Data.SqlClient

Partial Class DMCSRefunds_RefundDetail
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim intRefundID As Integer = Request.QueryString("RefundID")

            'lblRefundID.Text = strRefundID.ToString()
            'dsRefundID.UpdateCommandType = SqlDataSourceCommandType.StoredProcedure
            dsRefundID.SelectParameters("RefundID").DefaultValue = intRefundID

            RadMenu1.LoadContentFile("~/DMCSRefunds/Menu.xml")
        End If
    End Sub

    Sub FormView1_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs)
        If dsRefundID.UpdateParameters("FirstLineApprovalStatus").DefaultValue = "Approved" Then
            dsRefundID.UpdateParameters("FirstLineDateApproved").DefaultValue = Date.Today()
        End If
        'FormView1.DataBind()
    End Sub

    Sub FormView1_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        lblUpdateStatus.Text = "Your refund was successfully updated"
    End Sub


    Sub dsRefundID_Updating(ByVal sender As Object, ByVal e As SqlDataSourceCommandEventArgs)
        'If e.Command.Parameters("FirstLineApprovalStatus").Value = "Approved" Then
        'If dsRefundID.UpdateParameters("FirstLineApprovalStatus").DefaultValue = "Approved" Then
        'e.Command.Parameters("FirstLineDateApproved").Value = Date.Today()
        'Response.Write("hello, approved")
    End Sub

    





End Class
