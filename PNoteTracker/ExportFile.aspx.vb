Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.IO

Partial Class PNoteTracker_ExportFile
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("PNoteTrackerConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            
        End If
    End Sub

    Protected Sub gvDetails_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        gvdetails.PageIndex = e.NewPageIndex
    End Sub

    Sub ExportExcel()
        Dim strFileHolder As String = ddlFileHolder.SelectedValue
        gvdetails.ShowHeader = True
        gvdetails.GridLines = GridLines.Both
        gvdetails.AllowPaging = False
        gvdetails.AllowSorting = False
        gvdetails.DataBind()
        'gvdetails.HeaderRow.Cells.RemoveAt(0)

        For Each gvRow As GridViewRow In gvdetails.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))
            End If
        Next

        'ChangeControlsToValue(gvdetails)
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & strFileHolder & "_PNote_Requests_" & Today() & ".xls")
        Response.ContentType = "application/excel"
        Dim sWriter As New StringWriter()
        Dim hTextWriter As New HtmlTextWriter(sWriter)
        Dim hForm As New HtmlForm()
        gvdetails.Parent.Controls.Add(hForm)
        hForm.Attributes("runat") = "server"
        hForm.Controls.Add(gvdetails)
        hForm.RenderControl(hTextWriter)
        Response.Write(sWriter.ToString())

        'Update the status of the requests from Pending to Requested Docs
        UpdateStatus()

        Response.End()
    End Sub

    Sub ExportExcelAll(ByVal FileHolder As String)
        Dim strFileHolder As String = ddlFileHolder.SelectedValue
        gvdetails.ShowHeader = True
        gvdetails.GridLines = GridLines.Both
        gvdetails.AllowPaging = False
        gvdetails.AllowSorting = False

        'Rebind the GridView to show only the servicers
        gvdetails.DataBind()
        'gvdetails.HeaderRow.Cells.RemoveAt(0)

        For Each gvRow As GridViewRow In gvdetails.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))
            End If
        Next

        'ChangeControlsToValue(gvdetails)
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment; filename=" & strFileHolder & "_PNote_Requests_" & Today() & ".xls")
        Response.ContentType = "application/excel"
        Dim sWriter As New StringWriter()
        Dim hTextWriter As New HtmlTextWriter(sWriter)
        Dim hForm As New HtmlForm()
        gvdetails.Parent.Controls.Add(hForm)
        hForm.Attributes("runat") = "server"
        hForm.Controls.Add(gvdetails)
        hForm.RenderControl(hTextWriter)
        Response.Write(sWriter.ToString())

        'Update the status of the requests from Pending to Requested Docs
        UpdateStatus()

        Response.End()
    End Sub


    Protected Sub btnExportToExcel_Click(sender As Object, e As EventArgs)
        ExportExcel()
    End Sub


    Sub UpdateStatus()
        For Each gvRow As GridViewRow In gvdetails.Rows
            If gvRow.RowType = DataControlRowType.DataRow Then
                Dim rowIndex As String = Convert.ToString(gvdetails.DataKeys(gvRow.RowIndex)("RequestID"))
                dsPNoteRequests.UpdateParameters("RequestID").DefaultValue = rowIndex
                dsPNoteRequests.UpdateParameters("Status").DefaultValue = "Requested Docs"
                dsPNoteRequests.UpdateParameters("Date_Request_Sent").DefaultValue = Now.Date()
                dsPNoteRequests.Update()

                dsPNoteRequestsHistory.InsertParameters("RequestID").DefaultValue = rowIndex
                dsPNoteRequestsHistory.InsertParameters("Status").DefaultValue = "Requested Docs"
                dsPNoteRequestsHistory.InsertParameters("StatusChangeDate").DefaultValue = Date.Today
                dsPNoteRequestsHistory.Insert()
            End If
        Next
    End Sub

    Protected Sub btnExportAll_Click(sender As Object, e As System.EventArgs)
        For Each item As ListItem In ddlFileHolder.Items
            ExportExcelAll(item.ToString)
        Next
    End Sub
End Class
