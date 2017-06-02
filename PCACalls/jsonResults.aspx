<%@ Page Language="VB" %>

<%@ Import Namespace="System.IO" %>

<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            'Dim test As String = SelectMethod()
            Dim PCAID As String = Trim(Request.QueryString("PCAID"))
            SelectMethod(PCAID)
        End If
    End Sub

    'Public Shared Function SelectMethod(ByVal PCAID As String) As String
    '    Dim constr As String = ConfigurationManager.ConnectionStrings("PCACallsConnectionString").ConnectionString
    '    Using con As New SqlConnection(constr)
    '        Using cmd As New SqlCommand("SELECT DISTINCT TOP 25 UserID, PCAID FROM Calls")
    '            Using sda As New SqlDataAdapter()
    '                cmd.Connection = con
    '                sda.SelectCommand = cmd
    '                Using dt As New DataTable()
    '                    sda.Fill(dt)

    '                    Dim serializer As New JavaScriptSerializer()

    '                    Dim rows As New List(Of Dictionary(Of String, Object))()
    '                    Dim row As Dictionary(Of String, Object)
    '                    For Each dr As DataRow In dt.Rows
    '                        row = New Dictionary(Of String, Object)()
    '                        For Each col As DataColumn In dt.Columns
    '                            row.Add(col.ColumnName, dr(col))
    '                        Next
    '                        rows.Add(row)
    '                    Next

    '                    Dim json As String = serializer.Serialize(rows)
   
    '                    Return json
    '                End Using
    '            End Using
    '        End Using
    '    End Using
    'End Function
    
    Sub SelectMethod(ByVal PCAID As String)
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

                        Dim json As String = serializer.Serialize(rows)
   
                        Response.Write(json)
                        
                        ' Set a variable to the My Documents path.
                        'Dim mydocpath As String = Directory.GetCurrentDirectory()

                        '' Write the string array to a new file named "WriteLines.txt".
                        'Using outputFile As New StreamWriter(mydocpath & Convert.ToString("jsonResults.txt"))
                        '    outputFile.WriteLine(json)
                        'End Using

                    End Using
                End Using
            End Using
        End Using
    End Sub
</script>
