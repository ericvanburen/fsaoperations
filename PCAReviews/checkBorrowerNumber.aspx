<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim qsFn As String = Trim(Request.QueryString("fn"))
            'Dim type As String = Trim(Request.QueryString("type"))
            'Dim qsFn As String = "1021051044"
            LookupBorrowerNumber(qsFn)
        End If
    End Sub

    Sub LookupBorrowerNumber(ByVal strBorrowerNumber As String)
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("PCAReviewsConnectionString").ConnectionString)
        cmd = New SqlCommand("p_BorrowerNumberLookupCallsTable", con)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.Add("@BorrowerNumber", SqlDbType.VarChar).Value = strBorrowerNumber

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                      
                If dr.HasRows Then
                    Response.Write("Duplicate Borrower Number Found. Review Already In Process")
                Else
                    Response.Write("Borrower Number Not Found")
                End If

            End Using

        Finally
            con.Close()
        End Try
    End Sub

</script>


