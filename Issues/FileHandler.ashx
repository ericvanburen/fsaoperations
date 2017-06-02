﻿<%@ WebHandler Language="VB" Class="FileHandler" %>

Imports System
Imports System.Web
Imports System.Web.UI.Page
Imports System.Data

Public Class FileHandler : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        If HttpContext.Current.User.Identity.IsAuthenticated Then
            Dim fileName As String = context.Request.QueryString("fileName")
            fileName = HttpContext.Current.Server.UrlDecode(fileName)
            
            context.Response.Buffer = True
            context.Response.Clear()
            context.Response.AddHeader("content-disposition", "attachment; fileName=" & """" & fileName & """")
            context.Response.ContentType = "application/octet-stream"
            context.Response.WriteFile("https://fsaoperations.ed.gov/Issues/Attachments/" & fileName)
        End If
    End Sub
 
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class

