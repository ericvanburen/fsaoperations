Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class CallHistory

    Private mReviewID As Integer
    Public Property ReviewID() As Integer
        Get
            Return mReviewID
        End Get
        Set(ByVal value As Integer)
            mReviewID = value
        End Set
    End Property

    Private mUserID As String
    Public Property UserID() As String
        Get
            Return mUserID
        End Get
        Set(ByVal value As String)
            mUserID = value
        End Set
    End Property

    Private mEventName As String
    Public Property EventName() As String
        Get
            Return mEventName
        End Get
        Set(ByVal value As String)
            mEventName = value
        End Set
    End Property



    Public Sub AddCallHistory(ByVal mReviewID As Integer, ByVal mUserID As String, ByVal mEventName As String)
        'Public Sub AddCallHistory()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCM2ConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddCallHistory", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@ReviewID", mReviewID)
        cmd.Parameters.AddWithValue("@UserID", mUserID)
        cmd.Parameters.AddWithValue("@DateChanged", Now())
        cmd.Parameters.AddWithValue("@EventName", mEventName)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

End Class
