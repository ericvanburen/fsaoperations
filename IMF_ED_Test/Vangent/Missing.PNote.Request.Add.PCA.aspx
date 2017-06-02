<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"  Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and PCA page - Call Check Login Status
            CheckPCALogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString())
            End If
                       
        End If
    End Sub
    
           
    Sub btnSubmitIMF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim strInsert As String
        Dim cmdInsert As SqlCommand
        Dim con As SqlConnection
        Dim intReturnIMF_ID As Integer

        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strInsert = "p_InsertMissingPNote_Request"
        cmdInsert = New SqlCommand(strInsert)
        cmdInsert.CommandType = CommandType.StoredProcedure
        cmdInsert.Connection = con

        cmdInsert.Parameters.AddWithValue("@AG", SqlDbType.VarChar).Value = lblAgency.Text
        cmdInsert.Parameters.AddWithValue("@Borrower_FName", SqlDbType.VarChar).Value = ReplaceIllegalChars(txtBorrower_FName.Text)
        cmdInsert.Parameters.AddWithValue("@Borrower_LName", SqlDbType.SmallDateTime).Value = ReplaceIllegalChars(txtBorrower_LName.Text)
        cmdInsert.Parameters.AddWithValue("@PNote_Reason", SqlDbType.SmallDateTime).Value = rblPnoteReason.SelectedValue
        cmdInsert.Parameters.AddWithValue("@DebtID", SqlDbType.VarChar).Value = ReplaceIllegalChars(txtDebtID.Text)
        cmdInsert.Parameters.AddWithValue("@Debts", SqlDbType.VarChar).Value = ReplaceIllegalChars(txtDebts.Text)
        cmdInsert.Parameters.AddWithValue("@Checked_Images", SqlDbType.VarChar).Value = rblCheckedImages.SelectedValue
        cmdInsert.Parameters.AddWithValue("@Checked_DImages", SqlDbType.VarChar).Value = rblCheckedDImages.SelectedValue
        cmdInsert.Parameters.AddWithValue("@Checked_Microfiche", SqlDbType.VarChar).Value = rblMicrofiche.SelectedValue
        cmdInsert.Parameters.AddWithValue("@DesiredAction", SqlDbType.VarChar).Value = rblDesiredAction.SelectedValue
        cmdInsert.Parameters.AddWithValue("@Employee", SqlDbType.VarChar).Value = ReplaceIllegalChars(txtEmployee.Text)
        cmdInsert.Parameters.AddWithValue("@Comments", SqlDbType.VarChar).Value = ReplaceIllegalChars(txtComments.Text)

        Try
            con.Open()
            intReturnIMF_ID = cmdInsert.ExecuteScalar()
            lblStatus.Text = "Your Missing PNote request has been received by ED. Your request number is " & intReturnIMF_ID
            
            'Finally disable Submit button
            btnSubmit.Visible = False

            'Make the Submit Another button visible
            btnSubmitAnother.Visible = True

        Finally
            con.Close()
        End Try
    End Sub
    
    Sub btnSubmitAnother_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Clear all of the label values in case they submit another IMF
        txtBorrower_FName.Text = ""
        txtBorrower_LName.Text = ""
        rblPnoteReason.ClearSelection()
        txtDebtID.Text = ""
        txtDebts.Text = ""
        rblCheckedImages.ClearSelection()
        rblCheckedDImages.ClearSelection()
        rblMicrofiche.ClearSelection()
        rblDesiredAction.ClearSelection()
        txtEmployee.Text = ""
        txtComments.Text = ""

        'Hide the SubmitAnother Button
        btnSubmitAnother.Visible = False

        'Show the regular submit IMF button
        btnSubmit.Visible = True
        
    End Sub
    
    Private Function ReplaceIllegalChars(ByVal NewFileName As String) As String
        NewFileName = Replace(NewFileName, "#", "")
        NewFileName = Replace(NewFileName, "%", "")
        NewFileName = Replace(NewFileName, "%", "")
        NewFileName = Replace(NewFileName, "&", "")
        NewFileName = Replace(NewFileName, "*", "")
        NewFileName = Replace(NewFileName, "{", "")
        NewFileName = Replace(NewFileName, "}", "")
        NewFileName = Replace(NewFileName, "\", "")
        NewFileName = Replace(NewFileName, ":", "")
        NewFileName = Replace(NewFileName, "<", "")
        NewFileName = Replace(NewFileName, ">", "")
        NewFileName = Replace(NewFileName, "?", "")
        NewFileName = Replace(NewFileName, "/", "")
        NewFileName = Replace(NewFileName, " ", "")
        Return NewFileName
    End Function
    
  </script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add Missing PNote Request - PCA</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <script src="../js/missing.pnote.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">  

            <fieldset style="width:800px;">
            <legend class="fieldsetLegend">Submit a Missing PNote Request</legend>
            <table cellspacing="2" cellpadding="3" width="100%" style="border-collapse: collapse; border-style: solid; border-width: 0px;">                   
                <tr>
                    <td align="right"><asp:Label ID="lblBorrower_LName" Text="Borrower Last Name:" Runat="Server" CssClass="formLabelPNote" /></td>
                    <td align="left"><asp:TextBox ID="txtBorrower_LName" runat="server" /><br />
                    <asp:RequiredFieldValidator ID="warningMessageValidator2" runat="server" ErrorMessage="Please enter a borrower last name" CssClass="warningMessage" ControlToValidate="txtBorrower_LName" Display="Dynamic" /></td>
                   
                    <td align="right" nowrap><asp:Label ID="lblBorrower_FName" Text="First Name:" Runat="Server" CssClass="formLabelPNote" /></td>
                    <td align="left"><asp:TextBox ID="txtBorrower_FName" runat="server" /><br />
                    <asp:RequiredFieldValidator ID="warningMessageValidator3" runat="server" ErrorMessage="Please enter a borrower first name" CssClass="warningMessage" ControlToValidate="txtBorrower_FName" Display="Dynamic" /></td>
               </tr>                
                
                <tr>
                   <td align="right" valign="middle">
                   <asp:Label ID="lblPnote_Reason" Text="Reason for Pnote Request:" Runat="Server" CssClass="formLabelPNote"/></td>
                    
                    <td align="left"  colspan="3" valign="middle">
                    <asp:RadioButtonList ID="rblPnoteReason" CssClass="formLabel" runat="server">
                        <asp:ListItem Value="Borrower Request" Text="Borrower Request" />
                        <asp:ListItem Value="Administrative Need" Text="Administrative Need (e.g. submit to rehab lender)" />
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="warningMessageValidator4" runat="server" ErrorMessage="Reason for Pnote Request is required" CssClass="warningMessage" ControlToValidate="rblPnoteReason" Display="Dynamic" />                     
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="instructionText" valign="top">Note: if you select “Borrower Request” and the PNote cannot be located, the account will most likely be recalled and returned to the agency that assigned the loan to ED.</td>
               </tr>
                <tr>
                    <td align="right"><asp:Label ID="lblDebtID" Text="Complete Debt ID:" Runat="Server" CssClass="formLabelPNote" /></td>
                    <td align="left" colspan="3"><asp:TextBox ID="txtDebtID" runat="server" MaxLength="16" />
                    <asp:RequiredFieldValidator ID="rf_Account_Number" runat="server" ControlToValidate="txtDebtID" Display="Dynamic" ErrorMessage="A Debt ID is Required" SetFocusOnError="true" CssClass="warningMessage" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ControlToValidate="txtDebtID" ErrorMessage="A debt ID is a letter followed by 15 digits" CssClass="warningMessage" ValidationExpression="([a-z]|[A-Z])[0-9]{15}" /></td>
                </tr> 
               <tr>
                    <td align="right" valign="middle"><asp:Label ID="lblPnote" Text="Debts for which a PNote is needed:" Runat="Server" CssClass="formLabelPNote"/></td>
                    <td colspan="3" class="formLabel">Additional Partial Debt IDs:<br />
                    <input type="text" name="txtDebt" maxlength="5" />
                    <input type="button" value="Add to list" class="button" onClick="passText(this.form.txtDebt.value);">
                    <br />
                    <br />
                    Debts added to your list:<br>
                    <asp:TextBox ID="txtDebts" runat="server" Rows="5" Columns="40" TextMode="MultiLine" /><br />
                    </td>
               </tr>                 
                    
              <tr>
                    <td colspan="4" class="instructionText" valign="top"> (Notes: Debt IDs beginning with a “P” are grant overpayments and do not have PNotes; do not include	these.
                    You only need to record the first letter and the last four digits of the debt ID, not the entire 16 characters (e.g., for debt ID G200304101020601 write G-0601))</td>
               </tr>
               
               <tr>
                        <td colspan="4" class="formLabelPNote"><u>Pre-Request Checklist</u></td>
               </tr>               
               <tr>
               <td colspan="4" class="instructionText" valign="top">
                    This section must be completed before you submit a request for PNote search.  Next to each action outlined below, check either “yes” to certify that you have completed the step, or “N/A” (not applicable) if the step is not required for any of the debts included in this request.</td>
               </tr>
               
               <tr>
                   <td align="right" valign="top"><asp:Label ID="Label1" Text="Checked all images in Common Retrieval:" Runat="Server" CssClass="formLabelPNote"/></td>
                    <td align="left"  colspan="3" valign="middle">
                    <asp:RadioButtonList ID="rblCheckedImages" CssClass="formLabel" runat="server">
                        <asp:ListItem Value="Yes" Text="Yes" />
                        <asp:ListItem Value="N/A" Text="N/A" />
                    </asp:RadioButtonList><br />
                    <asp:RequiredFieldValidator ID="warningMessageValidator6" runat="server" ErrorMessage="Please verify that you have checked all images in common retrieval" CssClass="warningMessage" ControlToValidate="rblCheckedImages" Display="Dynamic" />                     
                    </td>
                </tr>
               
               <tr>
                   <td align="right" valign="top"><asp:Label ID="Label2" Text="Checked Direct Loan website for D Loan images not in Panagon:" Runat="Server" CssClass="formLabelPNote"/></td>
                    <td align="left"  colspan="3" valign="middle">
                    <asp:RadioButtonList ID="rblCheckedDImages" CssClass="rbstyle" runat="server">
                        <asp:ListItem Value="Yes" Text="Yes"  />
                        <asp:ListItem Value="N/A" Text="N/A" />
                    </asp:RadioButtonList>                                         
                    </td>
                </tr> 
               
               <tr>
                   <td align="right" valign="top"><asp:Label ID="Label3" Text="Completed a microfiche search for non-imaged documents:" Runat="Server" CssClass="formLabelPNote"/></td>
                    <td align="left"  colspan="3" valign="middle">
                    <asp:RadioButtonList ID="rblMicrofiche" CssClass="rbstyle" runat="server">                        
                        <asp:ListItem Value="Yes" Text="Yes" />
                        <asp:ListItem Value="N/A" Text="N/A" />
                    </asp:RadioButtonList><br />
                    <asp:RequiredFieldValidator ID="warningMessageValidator8" runat="server" ErrorMessage="Please verify that you have completed a microfiche search for non-imaged documents" CssClass="warningMessage" ControlToValidate="rblMicrofiche" Display="Dynamic" />                   
                    </td>
                </tr>  
               
               <tr>
                        <td colspan="4" class="formLabelPNote" valign="top">Note: Failure to complete the required pre-request actions may result in recall of the account!</td>
               </tr>
               
               <tr>
                   <td align="right" valign="top"><asp:Label ID="Label4" Text="Select desired action:" Runat="Server" CssClass="formLabelPNote"/></td>
                    <td align="left"  colspan="3" valign="middle">
                    <asp:RadioButtonList ID="rblDesiredAction" CssClass="formLabel" runat="server">
                        <asp:ListItem Value="Send PNote(s) to borrower/representative" Text="Send PNote(s) to borrower/representative" />
                        <asp:ListItem Value="Send Pnote(s) back to PCA" Text="Send Pnote(s) back to PCA" />
                    </asp:RadioButtonList><br />
                    <asp:RequiredFieldValidator ID="warningMessageValidator9" runat="server" ErrorMessage="Please indicate your desired action on this request" CssClass="warningMessage" ControlToValidate="rblDesiredAction" Display="Dynamic" />                     
                    </td>
                </tr> 
               
               <tr>
                   <td align="right" valign="middle"><asp:Label ID="Label5" Text="Comments/Additional Instructions:" Runat="Server" CssClass="formLabelPNote"/></td>
                    <td align="left"  colspan="3" valign="middle">
                    <asp:TextBox ID="txtComments" runat="server" Columns="40" Rows="10" TextMode="MultiLine" Font-Size="9pt"  />
                    <br />                     
                    </td>
                </tr>
               
               <tr>
                    <th align="right"><asp:Label ID="lblEmployee" Text="Employee Name:" Runat="Server" CssClass="formLabelPNote" /></th>
                    <td align="left" colspan="3"><asp:TextBox ID="txtEmployee" Font-Size="8pt" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="warningMessageValidator10" runat="server" ControlToValidate="txtEmployee" Display="Dynamic" ErrorMessage="* Employee name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                </tr>  
                <tr>
                    <td colspan="4" align="center"><asp:Button ID="btnSubmit" runat="server" CausesValidation="True" Text="Submit Request" CssClass="button" OnClick="btnSubmitIMF_Click" OnClientClick="openWinPNoteConfirmation();" /> 
                    <asp:Button ID="btnSubmitAnother" runat="server" CausesValidation="False" Text="Submit Another Missing PNote Request" Visible="false" CssClass="button" OnClick="btnSubmitAnother_Click" /><br /><br />
                    <asp:Label id="lblStatus" CssClass="warningMessage" Runat="Server"/> </td>
                </tr>
                </table>
   </fieldset>       
                 
<asp:Label ID="lblAgency" runat="server" Visible="false" />

 </form>
</body>
</html>
