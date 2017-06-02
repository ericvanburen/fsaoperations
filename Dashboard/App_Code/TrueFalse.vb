Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.HttpContext

Public Class TrueFalse
    Inherits System.Web.UI.Page

    Public Shared Function TrueFalse(ByVal MyValue As Boolean) As String
        Dim result As String = String.Empty
        If MyValue = True Then
            Return "Yes"
        Else
            Return "No"
        End If
        Return result
    End Function

End Class
