Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Script.Serialization

Partial Class PCACalls_json
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim test As String = SelectMethod()
            lblJsonOutput.Text = test
        End If
    End Sub

    Public Shared Function SelectMethod() As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("SELECT DISTINCT TOP 25 UserID, PCAID FROM Calls")
                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    Using dt As New DataTable()
                        sda.Fill(dt)

                        Dim serializer As New JavaScriptSerializer()

                        Dim rows As New List(Of Dictionary(Of String, Object))()
                        Dim row As Dictionary(Of String, Object)
                        For Each dr As DataRow In dt.Rows
                            row = New Dictionary(Of String, Object)()
                            For Each col As DataColumn In dt.Columns
                                row.Add(col.ColumnName, dr(col))
                            Next
                            rows.Add(row)
                        Next

                        Dim test As String = serializer.Serialize(rows)
   
                        Return test
                    End Using
                End Using
            End Using
        End Using
    End Function

End Class
