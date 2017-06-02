Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class CheckLogin

    Function CheckLogin() As String
        Dim strUsername As String = ""

        If Not HttpContext.Current.Request.Cookies("Dashboard") Is Nothing Then
            strUsername = HttpContext.Current.Request.Cookies("Dashboard")("Username").ToString()
        Else
            strUsername = "invaliduser@ed.gov"
        End If

        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("DashboardConnectionString").ConnectionString)
        cmd = New SqlCommand("p_CheckLogin", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Username", strUsername)

        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()

                If dr.HasRows() Then
                    'Valid user - return the userID
                    While dr.Read()
                        Return dr("UserID").ToString()
                    End While
                Else
                    'Invalid user
                    Return "0"
                    HttpContext.Current.Response.Redirect("default.aspx")
                End If
            End Using
        Finally
            dr.Close()
            con.Close()
        End Try

    End Function
End Class
