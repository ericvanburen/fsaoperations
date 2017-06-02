Imports System.Data
Imports System.Data.SqlClient

Partial Class ATB_New_AllSchoolsOPEID
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        If Not Request.QueryString("OPEID") Is Nothing Then
            lblOPEID.Text = Request.QueryString("OPEID").ToString()
            BindGridView()
        End If

    End Sub

    Sub BindGridView()
        dsSearchOPEID.SelectParameters.Item("OPEID").DefaultValue = lblOPEID.Text
        GridView1.DataBind()
    End Sub
End Class
