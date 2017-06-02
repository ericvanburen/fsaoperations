Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration
Imports System.Web.HttpContext

Public Class MyBaseClass
    Inherits System.Web.UI.Page

    Public Sub CheckEDLogin()
        Dim strEDUser As String = ""
        If Not IsNothing(Context.Request.Cookies("IMF")) Then
            'IMF Cookie has a value. See if it's a ED cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("EDUserID")) Then
                strEDUser = Request.Cookies("IMF")("EDUserID")
            End If
        End If

        'If this value is NULL, the the user is not a ED user. Send them to login page
        If strEDUser = "" Then
            Response.Redirect("/secure/imf_ed/not.logged.in.aspx")
        End If
    End Sub

    Public Sub CheckPCALogin()
        'PCA pages should be accessible by both ED and PCA users
        Dim strEDUser As String = ""
        Dim strPCAUser As String = ""
        If Not IsNothing(Context.Request.Cookies("IMF")) Then
            'IMF Cookie has a value. See if it's a ED cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("EDUserID")) Then
                strEDUser = Request.Cookies("IMF")("EDUserID")
            End If
            'IMF Cookie has a value. See if it's a PCA cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("AG")) Then
                strPCAUser = Request.Cookies("IMF")("AG")
            End If
        End If

        'If this value is NULL, the the user is not a ED pr PCA user. Send them to login page
        If strEDUser = "" And strPCAUser = "" Then
            Response.Redirect("not.logged.in.aspx")
        End If
    End Sub

    Public Sub CheckVALogin()
        'VA pages should be accessible by both ED and VA users
        Dim strEDUser As String = ""
        Dim strVAUser As String = ""
        If Not IsNothing(Context.Request.Cookies("IMF")) Then
            'IMF Cookie has a value. See if it's a ED cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("EDUserID")) Then
                strEDUser = Request.Cookies("IMF")("EDUserID")
            End If
            'IMF Cookie has a value. See if it's a VA cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("GA_ID")) Then
                strVAUser = Request.Cookies("IMF")("GA_ID")
            End If
        End If

        'If this value is NULL, the the user is not a ED or VA user. Send them to login page
        If strEDUser = "" And strVAUser = "" Then
            Response.Redirect("not.logged.in.aspx")
        End If
    End Sub

    Public Sub CheckVangentLogin()
        Dim strVangentUser As String = ""
        If Not IsNothing(Context.Request.Cookies("IMF")) Then
            'IMF Cookie has a value. See if it's a Vangent cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("Vangent")) Then
                strVangentUser = Request.Cookies("IMF")("Vangent")
            End If
        End If

        'If this value is NULL, then the user is not a Vangent user. Send them to login page
        If strVangentUser = "" Then
            Response.Redirect("not.logged.in.aspx")
        End If
    End Sub

    Public Sub CheckVangentPCALogin()
        Dim strVangentUser As String = ""
        Dim strPCAUser As String = ""
        If Not IsNothing(Context.Request.Cookies("IMF")) Then
            'IMF Cookie has a value. See if it's a Vangent cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("Vangent")) Then
                strVangentUser = Request.Cookies("IMF")("Vangent")
            End If

            'IMF Cookie has a value. See if it's a PCA cookie
            If Not IsNothing(Context.Request.Cookies("IMF")("AG")) Then
                strPCAUser = Request.Cookies("IMF")("AG")
            End If

        End If

        'If this value is NULL, the the user is not a Vangent or PCA user. Send them to login page
        If strVangentUser = "" And strPCAUser = "" Then
            Response.Redirect("not.logged.in.aspx")
        End If
    End Sub

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
