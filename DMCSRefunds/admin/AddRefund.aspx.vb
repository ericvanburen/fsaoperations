Imports Telerik.Web.UI

Partial Class DMCSRefunds_admin_AddRefund
    Inherits System.Web.UI.Page

    Private connStr As String = ConfigurationManager.ConnectionStrings("DMCSRefundsConnectionString").ConnectionString

    Public Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            'Bind the UserID dropdownlist with users in the DCMS Refunds role
            ddlUserID.DataSource = Roles.GetUsersInRole("DMCSRefunds")
            ddlUserID.DataBind()

            RadMenu1.LoadContentFile("~/DMCSRefunds/Menu.xml")
        End If
    End Sub

    Public Sub btnAddRefund_Click(ByVal sender As Object, ByVal e As EventArgs)
        dsAddRefund.UpdateParameters("BorrowerNumber").DefaultValue = txtBorrowerNumber.Text
        dsAddRefund.UpdateParameters("TagDate").DefaultValue = txtTagDate.Text
        dsAddRefund.UpdateParameters("UserID").DefaultValue = ddlUserID.SelectedValue
        dsAddRefund.UpdateParameters("DateAssigned").DefaultValue = DateTime.Now()
        dsAddRefund.UpdateParameters("Comments").DefaultValue = txtComments.Text
        dsAddRefund.Update()
        lblUpdateStatus.Text = "Your refund was successfully submitted"
        btnAddAnother.Visible = True
    End Sub

    Sub btnAddAnother_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("AddRefund.aspx")
    End Sub

End Class
