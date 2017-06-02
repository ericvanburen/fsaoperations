Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class IssueHistory

    Private mIssueID As Integer
    Public Property IssueID() As Integer
        Get
            Return mIssueID
        End Get
        Set(ByVal value As Integer)
            mIssueID = value
        End Set
    End Property

    Private mComments As String
    Public Property Comments() As String
        Get
            Return mComments
        End Get
        Set(ByVal value As String)
            mComments = value
        End Set
    End Property

    Private mEventType As String
    Public Property EventType() As String
        Get
            Return mEventType
        End Get
        Set(ByVal value As String)
            mEventType = value
        End Set
    End Property

    Sub InsertIssueHistory(ByVal mIssueID As Integer, ByVal mComments As String, ByVal mEventType As String)

        Dim DateEntered As Date = DateTime.Now()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("IssuesConnectionString").ConnectionString)
        cmd = New SqlCommand("p_InsertIssueHistory", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@IssueID", mIssueID)
        cmd.Parameters.AddWithValue("@DateAdded", DateEntered)
        cmd.Parameters.AddWithValue("@EnteredBy", HttpContext.Current.User.Identity.Name)

        'Comments
        If mComments.Length > 0 Then
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = mComments
        Else
            cmd.Parameters.Add("@Comments", SqlDbType.VarChar).Value = DBNull.Value
        End If

        'Event Type
        cmd.Parameters.AddWithValue("@EventType", mEventType)

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
        Finally
            strSQLConn.Close()
        End Try
    End Sub

    Public Sub AddCallHistory(ByVal mReviewID As Integer, ByVal mUserID As String, ByVal mEventName As String)
        'Public Sub AddCallHistory()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand

        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("CCMConnectionString").ConnectionString)
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
