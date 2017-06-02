<%@ Page Language="VB" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim strOPEID As String
        strOPEID = Request.QueryString("OPEID")
        OPEID_Lookup(strOPEID)
    End Sub
    
    Sub OPEID_Lookup(ByVal OPEID As String)
       
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_OPEID_Lookup", con)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.AddWithValue("@OPEID", OPEID)
  	               
        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                If dr.HasRows() Then
                    'While dr.Read()
                    Response.Write("School already exists. <a href=""add.school.aspx?OPEID=" & OPEID & """>Populate This Form</a>")
                    'Response.Write("A record already exists for this school")
                    'End While
                Else
                    Response.Write("Clear to add new school")
                End If
            End Using
        Finally
            con.Close()
        End Try
                
        
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
