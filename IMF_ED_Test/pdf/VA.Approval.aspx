<%@ Page Language="VB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Request.QueryString("ID") Is Nothing AndAlso Request.QueryString("ID").Trim.Length > 0 Then
            Dim intID As String = Request.QueryString("ID")
            lblID.Text = intID
        Else
            lblID.Text = "1"
        End If
    End Sub
    
    Function GetDate() As String
        Dim TodaysDate As Date
        TodaysDate = Now()
        
        Dim ReturnDate As String
        ReturnDate = TodaysDate.ToShortDateString()
        Return ReturnDate
    End Function
    
    Function PCase(ByVal strInput As String) As String
        Dim I As Integer
        Dim CurrentChar, PrevChar As String
        Dim strOutput As String

        PrevChar = ""
        strOutput = ""

        For I = 1 To Len(strInput)
            CurrentChar = Mid(strInput, I, 1)

            Select Case PrevChar
                Case "", " ", ".", "-", ",", """", "'"
                    strOutput = strOutput & UCase(CurrentChar)
                Case Else
                    strOutput = strOutput & LCase(CurrentChar)
            End Select

            PrevChar = CurrentChar
        Next I

        PCase = strOutput
    End Function

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Notification of Eligibility for Loan Discharge</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
     <!--This one populates the page header-->
        <asp:SqlDataSource ID="dsVA_Discharge_Approval_Letter" runat="server" 
              ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>" 
              SelectCommand="p_VA_Discharge_Approval_Letter" SelectCommandType="StoredProcedure">
         <SelectParameters>
                <asp:ControlParameter ControlID="lblID" Name="ID" />
         </SelectParameters>
        </asp:SqlDataSource>

    <div>
    <asp:Repeater ID="rptVA_Discharge_Approval_Letter" runat="server" DataSourceID="dsVA_Discharge_Approval_Letter">
        <HeaderTemplate>
            <table width="100%">            
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td align="center" valign="bottom"><asp:Label id="lblPrintDateStamp" Text='<%# GetDate() %>'  runat="server" CssClass="highlight" /></td>               
            </tr>
            <tr>
                <td><p>&nbsp;</p></td>
            </tr>
             <tr>
                <td align="center" valign="bottom" class="highlight"><p>Notification of Eligibility for Loan Discharge</p></td>               
            </tr>
            <tr>
                <td><p>&nbsp;</p></td>
            </tr>
            <tr>
                <td align="left">Dear <asp:Label ID="lblGA_Name" runat="server" Text='<%# Eval("GA_Name") %>' />:</td>
            </tr>
            <tr>
                <td><p>&nbsp;</p></td>
            </tr>  
            <tr>
                <td align="left">Federal Student Aid’s Business Operations office has reviewed an application for Veterans Disability Discharge for <asp:Label ID="lblBorrower_FName" runat="server" Text='<%# PCase(Eval("Borrower_FName")) %>' /> <asp:Label ID="lblBorrower_LName" runat="server" Text='<%# PCase(Eval("Borrower_LName")) %>' />, 
                SSN xxxxx<asp:Label ID="lblSSN" runat="server" Text='<%# Eval("SSN") %>' />, application ID number <asp:Label ID="lblVAID" runat="server" Text='<%# Eval("ID") %>' />.  Federal Student Aid has completed its review of the application and has determined that the 
                applicant meets the criteria for discharge of his or her Federal Student Loan obligations, which includes any FFEL or Direct Loan, Perkins Loan, 
                or TEACH Grant (for any TEACH Grant recipient who has applied for loan discharge.) The effective date of the condition entitling the 
                borrower for loan discharge is <asp:Label ID="lblDisability_Effective_Date" runat="server" Text='<%# Eval("Disability_Effective_Date") %>' />.
                <p>Please keep this notice for your records.</p>
                </td>
            </tr>       
            <tr>
            <td align="left"><br /><br />Sincerely,<br /><br />
            Douglas Laine<br />
            Branch Chief<br />
            Atlanta Processing Division
            </td>
            </tr>   

        </ItemTemplate>            
        <FooterTemplate>
            </table>
        </FooterTemplate>
        </asp:Repeater>        
        </div>
               
    <asp:Label ID="lblID" runat="server" Visible="false" />
    </form>
</body>
</html>
