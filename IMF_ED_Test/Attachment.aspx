<%@ Page Language="VB" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        
        Dim strFileName = Request.QueryString("FileName")
        Dim strFileLocation = Request.QueryString("FileLocation")
        strFileLocation = GetFilePath(strFileLocation)
               
        Dim strUploadPath As String = System.Configuration.ConfigurationManager.AppSettings("UploadPath").ToString
               
        'Get just the file extension
        Dim strFileExtension As String = strFileName.Substring(strFileName.IndexOf(".") + 1)
                
        'Dim s As New FileStream("\\Dcdofesa116\sitfs\TitaniumFS\EFT\FILES\EIMF\IMF_ED\x49g\" & strFileLocation & strFileName & "", FileMode.Open)
        Dim s As New FileStream(strUploadPath & strFileLocation & strFileName, FileMode.Open)
        
        Dim bytes() As Byte
        ReDim bytes(s.Length)
        s.Read(bytes, 0, s.Length)

        'output file to the browser
        Response.Clear()
        Response.ContentType = GetFileExtension(strFileExtension) & "; " & strFileName
        Response.AddHeader("content-transfer-encoding", "binary")
        Response.ContentEncoding = System.Text.Encoding.GetEncoding(1251)
        Response.BinaryWrite(bytes)
        Response.End()
        s.Close()
        s = Nothing
    End Sub
    
    Function GetFilePath(ByVal FilePath As String) As String
        Dim strFilePath As String = ""
        Select Case FilePath
            Case "dmcs"
                strFilePath = "pca\employees\dmcs_access\"
            Case "dmcsrob"
                strFilePath = "pca\employees\dmcs_rob\"
            Case "ffel"
                strFilePath = "pca\employees\ffel\"
            Case "irt"
                strFilePath = "pca\employees\irt\"
            Case "lvc"
                strFilePath = "pca\employees\lvc\"
            Case "pat"
                strFilePath = "pca\employees\pat\"
            Case "rob"
                strFilePath = "pca\employees\rob\"
            Case "sat"
                strFilePath = "pca\employees\sat\"
            Case Else
                strFilePath = ""
        End Select
        Return strFilePath
    End Function
    
    Function GetFileExtension(ByVal FileExtension As String) As String
        Dim strFileType As String = ""
        Select Case FileExtension
            Case "xls"
                strFileType = "application/vnd.ms-excel"
            Case "xlsx"
                strFileType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            Case "doc"
                strFileType = "application/msword"
            Case "docx"
                strFileType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            Case "pdf"
                strFileType = "application/pdf"
            Case "jpg"
                strFileType = "image/jpeg"
            Case "jpeg"
                strFileType = "image/jpeg"""
            Case "gif"
                strFileType = "image/gif"
            Case "zip"
                strFileType = "application/x-zip-compressed"
            Case "txt"
                strFileType = "text/plain"
        End Select
        Return strFileType
    End Function
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
