Imports System.IO
Imports FormatParagraph

Partial Class Issues_Report_Liaison_Affecting_Org
    Inherits System.Web.UI.Page

    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)

    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs)

        'Get all of the AffectedOrg values
        'This one passes a comma-delimited string for @AffectedOrgID which is used in the split function
        If ddlAffectedOrgID.SelectedValue <> "" Then
            Dim strSearchValue As String = ""
            Dim li As ListItem
            For Each li In ddlAffectedOrgID.Items
                If li.Selected = True Then
                    strSearchValue = strSearchValue & li.Value & ","
                End If
            Next
            strSearchValue = Left(strSearchValue, (Len(strSearchValue) - 1))
            strSearchValue = Replace(strSearchValue, ",", ",")
            dsGridView.SelectParameters("AffectedOrgID").DefaultValue = strSearchValue
        End If

        GridView1.DataBind()

    End Sub

    Protected Sub dsGridView_Selected(sender As Object, e As SqlDataSourceStatusEventArgs)
        If e.AffectedRows > 0 Then
            btnExportExcel.Visible = True
            btnExportWord.Visible = True
        Else
            btnExportExcel.Visible = False
            btnExportWord.Visible = False
        End If
    End Sub

    Public Sub btnExportExcel_Click(sender As Object, e As EventArgs)
        Export("Liaison_Report_Affecting_Organization" & ".xls", GridView1)
    End Sub


    Public Shared Sub Export(ByVal fileName As String, ByVal gv As GridView)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As StringWriter = New StringWriter
        Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        '  Create a form to contain the grid
        Dim table As Table = New Table
        table.GridLines = gv.GridLines
        '  add the header row to the table
        If (Not (gv.HeaderRow) Is Nothing) Then
            PrepareControlForExport(gv.HeaderRow)
            table.Rows.Add(gv.HeaderRow)
        End If
        '  add each of the data rows to the table
        For Each row As GridViewRow In gv.Rows
            PrepareControlForExport(row)
            table.Rows.Add(row)
        Next
        '  add the footer row to the table
        If (Not (gv.FooterRow) Is Nothing) Then
            PrepareControlForExport(gv.FooterRow)
            table.Rows.Add(gv.FooterRow)
        End If

        '  render the table into the htmlwriter
        table.RenderControl(htw)
        '  render the htmlwriter into the response
        HttpContext.Current.Response.Write(sw.ToString)
        HttpContext.Current.Response.End()
    End Sub

    ' Replace any of the contained controls with literals
    Private Shared Sub PrepareControlForExport(ByVal control As Control)
        Dim i As Integer = 0
        Do While (i < control.Controls.Count)
            Dim current As Control = control.Controls(i)
            If (TypeOf current Is LinkButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, LinkButton).Text))
            ElseIf (TypeOf current Is ImageButton) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, ImageButton).AlternateText))
            ElseIf (TypeOf current Is HyperLink) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, HyperLink).Text))
            ElseIf (TypeOf current Is DropDownList) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, DropDownList).SelectedItem.Text))
            ElseIf (TypeOf current Is CheckBox) Then
                control.Controls.Remove(current)
                control.Controls.AddAt(i, New LiteralControl(CType(current, CheckBox).Checked))
                'TODO: Warning!!!, inline IF is not supported ?
            End If
            If current.HasControls Then
                PrepareControlForExport(current)
            End If
            i = (i + 1)
        Loop
    End Sub

    Protected Sub btnExportWord_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Response.Clear()
        'Response.Buffer = True
        'Response.AddHeader("content-disposition", "attachment;filename=Liaison_Report_Affecting_Organization.doc")
        'Response.Charset = ""
        'Response.ContentType = "application/vnd.ms-word"
        'Dim sw As New StringWriter()
        'Dim hw As New HtmlTextWriter(sw)
        'GridView1.AllowPaging = False
        'GridView1.DataBind()
        'GridView1.RenderControl(hw)
        'Response.Output.Write(sw.ToString())
        'Response.Flush()
        'Response.End()
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=Liaison_Report_Affecting_Organization.doc")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-word "
        Response.Write("<html>")
        Response.Write("<head>")
        Response.Write("<META HTTP-EQUIV='Content-Type' CONTENT='text/html; charset=UTF-8'>")
        Response.Write("<meta name=ProgId content=Word.Document>")
        Response.Write("<meta name=Generator content='Microsoft Word 9'>")
        Response.Write("<meta name=Originator content='Microsoft Word 9'>")
        Response.Write("<style>")
        Response.Write("@page Section1 {size:595.45pt 841.7pt; margin:1.0in 1.25in 1.0in 1.25in;mso-header-margin:.5in;mso-footer-margin:.5in;mso-paper-source:0;}")
        Response.Write("div.Section1 {page:Section1;}")
        Response.Write("@page Section2 {size:841.7pt 595.45pt;mso-page-orientation:landscape;margin:1.25in 1.0in 1.25in 1.0in;mso-header-margin:.5in;mso-footer-margin:.5in;mso-paper-source:0;}")
        Response.Write("div.Section2 {page:Section2;}")
        Response.Write("</style>")
        Response.Write("</head>")
        Response.Write("<body>")
        Response.Write("<div class=Section2>")
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        GridView1.AllowPaging = False
        GridView1.DataBind()
        GridView1.RenderControl(hw)
        Response.Write(sw.ToString())
        Response.Write("</div>")
        Response.Write("</body>")
        Response.Write("</html>")
        Response.Flush()
        Response.End()
    End Sub

End Class
