Imports System.Data
Imports System.Data.SqlClient

Partial Class CCM_New_admin_CallCenters
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
        End If
    End Sub

    Protected Sub grdCallCenters_OnRowCommand1(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandArgument = "Insert" Then
            Dim txtCallCenter As TextBox = grdCallCenters.FooterRow.FindControl("txtCallCenter")
            Dim ddlContract As DropDownList = grdCallCenters.FooterRow.FindControl("ddlContract")
            Dim ddlCallCenterFunction As DropDownList = grdCallCenters.FooterRow.FindControl("ddlCallCenterFunction")
            Dim ddlReportGroup As DropDownList = grdCallCenters.FooterRow.FindControl("ddlReportGroup")

            dsCallCenterID.InsertParameters("CallCenter").DefaultValue = txtCallCenter.Text
            dsCallCenterID.InsertParameters("Contract").DefaultValue = ddlContract.SelectedValue
            dsCallCenterID.InsertParameters("CallCenterFunction").DefaultValue = ddlCallCenterFunction.SelectedValue
            dsCallCenterID.InsertParameters("ReportGroup").DefaultValue = ddlReportGroup.SelectedValue

            dsCallCenterID.Insert()

        End If
    End Sub

End Class
