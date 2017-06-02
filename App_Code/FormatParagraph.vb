Imports Microsoft.VisualBasic

Public Class FormatParagraph
    Public Shared Function FormatParagraphHTML(sText As String) As String
        Dim strReturn As String
        Try
            'If sText = String.Empty OrElse sText.Equals(DBNull.Value) Then
            If String.IsNullOrEmpty(sText) Then
                Return ""
            Else
                strReturn = Replace(sText, vbCrLf & vbCrLf, "<P>")
                strReturn = Replace(strReturn, vbCrLf, "<br />")
                strReturn = Replace(strReturn, Environment.NewLine, "<br />")
                strReturn = Replace(strReturn, Chr(10), "<br />")
                strReturn = Replace(strReturn, Chr(198), "'")
                strReturn = Replace(strReturn, Chr(242), "")
                strReturn = Replace(strReturn, Chr(244), "")
                strReturn = Replace(strReturn, Chr(246), "")
                strReturn = Replace(strReturn, Chr(249), "--")
                strReturn = Replace(strReturn, Chr(151), "--")
                strReturn = Replace(strReturn, Chr(145), "")
                strReturn = Replace(strReturn, Chr(213), "'")
                strReturn = Replace(strReturn, Chr(210), "")
                strReturn = Replace(strReturn, Chr(211), "")
                strReturn = Replace(strReturn, "’", "'")
                strReturn = Replace(strReturn, "â€™", "'")
                strReturn = Replace(strReturn, "â€", "")
                strReturn = Replace(strReturn, "Æ", "'")
                strReturn = Replace(strReturn, "ô", "")
                strReturn = Replace(strReturn, "ö", "")
                strReturn = Replace(strReturn, "ò", "")
                Return strReturn
            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Function
End Class




