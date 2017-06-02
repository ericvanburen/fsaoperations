<%@ WebHandler Language="VB" Class="UploadHandler" %>

Imports System
Imports System.Web
Imports System.Web.UI.Page
Imports System.Data
Imports System.IO

Public Class UploadHandler : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim files As HttpFileCollection = context.Request.Files
        Dim strRandomNumber As String = context.Request.QueryString("RandomNumber")
        
        For Each key As String In files
            Dim file As HttpPostedFile = files(key)
            Dim fileName As String = file.FileName
            fileName = context.Server.MapPath(Convert.ToString("Attachments/") & strRandomNumber & "_" & fileName)
            file.SaveAs(fileName)
        Next
        
        context.Response.ContentType = "text/plain"
        Dim Generator As System.Random = New System.Random()
        context.Response.Write("File Uploaded Successfully")
    End Sub
        
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class