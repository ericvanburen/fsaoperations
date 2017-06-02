Imports System.Data
Imports System.Data.SqlClient

Partial Class ATB_New_searchOPEID
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        Dim navMenu As Menu
        navMenu = CType(Master.FindControl("NavigationMenu"), Menu)

        'navMenu.Items(1) = True

        If Not Request.Cookies("ATB") Is Nothing Then
            lblUserAdmin.Text = Request.Cookies("ATB")("Admin").ToString()
        End If

    End Sub


    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub

    Sub BindGridView()
        dsSearchOPEID.SelectParameters.Item("SchoolName").DefaultValue = txtSchoolName.Text
        GridView1.DataBind()
    End Sub

    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("searchOPEID.aspx")
    End Sub
End Class
