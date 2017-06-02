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
            
            If Not IsNothing(Request.Cookies("IMF")("AG")) Then
                'PCA is looking at the employee
                lblAgency.Text = (Request.Cookies("IMF")("AG").ToString()) 'This contains their agency number code
            End If

        End If
    End Sub
    
    Private Function CheckDuplicateEmployee() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("p_CheckDuplicateEmployee", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@SSN", SqlDbType.VarChar).Value = txtSSN.Text
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
   
    Sub btnSubmitEmployee_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            'Make sure that there are not any other requests for this same employee - based on SSN and StatusID
            'Employees in StatusID 1 = No decision, 2 Not approved, 3 Approved cannot be submitted twice
            Dim intEmployeeCount As Integer
            intEmployeeCount = CInt(CheckDuplicateEmployee())
                    
            If intEmployeeCount > 0 Then
                lblStatus.Text = "This employee already exists in our database in a status that prevents the employee from being submitted again."
            Else
                'Employee can be assigned to someone since s/he is not in a status that prevents a new request
                GetRandom_EDUser()
            End If
            
        Finally
           
        End Try
    End Sub
    
    Sub GetRandom_EDUser()
        'This sub gets called only if the SSN being submitted isn't already assigned to another ED analyst
        'Run p_LookupEDUser_PCAEmployee to get available ED users assigned to this SSN
        Dim strSQL As String
        Dim cmd As SqlCommand
        Dim con As SqlConnection
        Dim dr As SqlDataReader
        Dim myList As New ArrayList
        Dim count As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSQL = "p_LookupEDUser_PCAEmployee"
        cmd = New SqlCommand(strSQL)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
                
        Try
            con.Open()
            cmd.Connection = con
            dr = cmd.ExecuteReader()
            
            'Sometimes there may not be an ED Analyst assigned to work PCA employee requests
            'If there isn't one, we cannot assign an pca employee request at random or else this section will fail
            With dr
                If .HasRows Then
                    While .Read
                        myList.Add(dr("UserId"))
                        count += 1
                    End While
                    
                    Dim r As Random = New Random()
                    Dim cnt As Integer
                    For cnt = 0 To myList.Count - 1 Step cnt + 1
                        Dim tmp As Object = myList(cnt)
                        Dim idx As Integer = r.Next(myList.Count - cnt) + cnt
                        myList(cnt) = myList(idx)
                        myList(idx) = tmp
                    Next
                    
                    'We found a user to assign this new PCA employee request to the UserID to this label
                    lblRandomUserID.Text = myList(0)
                
                Else
                    'We did not find a user to assign this request to so we'll just assign it to Doug Laine (UserID 2)
                    lblRandomUserID.Text = "2"
                End If
            End With
            
            'Now inert the new request
            InsertNewEmployee()
            
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub InsertNewEmployee()
        
        'Clear any old values in the status label
        lblStatus.Text = ""
        
        Dim strInsert As String
        Dim cmdInsert As SqlCommand
        Dim con As SqlConnection
        Dim intReturn_ID As Integer
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strInsert = "p_PCAEmployee_Insert_Employee"
        cmdInsert = New SqlCommand(strInsert)
        cmdInsert.CommandType = CommandType.StoredProcedure
        cmdInsert.Connection = con
        
        cmdInsert.Parameters.AddWithValue("@AG", SqlDbType.VarChar).Value = lblAgency.Text
        cmdInsert.Parameters.AddWithValue("@SSN", SqlDbType.VarChar).Value = txtSSN.Text
        cmdInsert.Parameters.AddWithValue("@Last_Name", SqlDbType.VarChar).Value = txtLast_Name.Text
        cmdInsert.Parameters.AddWithValue("@First_Name", SqlDbType.VarChar).Value = txtFirst_Name.Text
        cmdInsert.Parameters.AddWithValue("@Email", SqlDbType.VarChar).Value = txtEmail.Text
        'StatusID 1 is 'No decision'
        cmdInsert.Parameters.AddWithValue("@StatusID", SqlDbType.Int).Value = 1
        cmdInsert.Parameters.AddWithValue("@UserID", SqlDbType.Int).Value = lblRandomUserID.Text
        cmdInsert.Parameters.AddWithValue("@EmployeeFunction", SqlDbType.VarChar).Value = ddlEmployeeFunction.SelectedValue
        cmdInsert.Parameters.AddWithValue("@Title", SqlDbType.VarChar).Value = ddlTitle.SelectedValue
        cmdInsert.Parameters.AddWithValue("@SixC", SqlDbType.Bit).Value = chkSixC.Checked
        cmdInsert.Parameters.AddWithValue("@LVCCoordinator", SqlDbType.Bit).Value = chkLVCCoordinator.Checked
        cmdInsert.Parameters.AddWithValue("@AG_Employee_Name", SqlDbType.VarChar).Value = txtAG_Employee_Name.Text
        cmdInsert.Parameters.AddWithValue("@Comments_PCA", SqlDbType.VarChar).Value = txtComments_PCA.Text
        cmdInsert.Parameters.AddWithValue("@IsSubcontractor", SqlDbType.Bit).Value = chkIsSubContractor.Checked
        cmdInsert.Parameters.AddWithValue("@SubContractorID", SqlDbType.Int).Value = ddlSubcontractor.SelectedValue
               
        Try
            con.Open()
            intReturn_ID = cmdInsert.ExecuteScalar()
            lblStatus.Text = "Your new employee request has been received. Your request number is " & intReturn_ID
            
            'Clear all of the label values in case they submit another IMF
            txtSSN.Text = ""
            txtFirst_Name.Text = ""
            txtLast_Name.Text = ""
            ddlEmployeeFunction.SelectedValue = ""
            ddlTitle.SelectedValue = ""
            chkSixC.Checked = False
            txtAG_Employee_Name.Text = ""
            
            'Finally disable to Submit Employee button
            btnSubmitEmployee.Visible = False
            
            'Make the Submit Another Employee button visible
            btnSubmitAnotherEmployee.Visible = True
            
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub btnSubmitAnotherEmployee_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Clear user entered values
        lblStatus.Text = ""
        txtSSN.Text = ""
        txtFirst_Name.Text = ""
        txtLast_Name.Text = ""
        txtEmail.Text = ""
        ddlEmployeeFunction.SelectedValue = ""
        ddlTitle.ClearSelection()
        chkSixC.Checked = False
        txtAG_Employee_Name.Text = ""
        txtComments_PCA.Text = ""
        
        'Hide the SubmitAnotherIMF Button
        btnSubmitAnotherEmployee.Visible = False
        
        'Show the regular submit IMF button
        btnSubmitEmployee.Visible = True
        
    End Sub
   
    Protected Sub chkIsSubContractor_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If chkIsSubContractor.Checked Then
            pnlSubContractor.Visible = True
        Else
            pnlSubContractor.Visible = False
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add PCA Employee - PCA</title>
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 10px;
            height: 12px;
        }
    </style>
    <script type="text/javascript">
        function WinEmployeeFunctions() {
            testwindow = window.open("employee.functions.htm", "mywindow", "location=1,status=1,scrollbars=1,width=400,height=350");
            testwindow.moveTo(0, 0);
         }  

</script> 

</head>
<body>
    <form id="form1" runat="server">
    <!--This one populates the Status dropdown-->
    
    <asp:SqlDataSource ID="dsSubContractors" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString_IMF_SQL %>"
    SelectCommand="p_SubContractors" SelectCommandType="StoredProcedure" />
         
                                                    
                  <div align="left">
                   <asp:Panel ID="pnlNewEmployeeIMFEntry" runat="server">
                        <fieldset>
                        <legend class="fieldsetLegend">Submit a New Employee Request</legend>
                        <table border="0" width="700">
                            
                            <tr>
                                <td align="right" width="50%" class="formLabel">SSN:</td>
                                <td align="left" width="50%">
                                <asp:TextBox ID="txtSSN" runat="server" MaxLength="16" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="rf_SSN" runat="server" ControlToValidate="txtSSN" Display="Dynamic" ErrorMessage="* A SSN is Required *" SetFocusOnError="true" CssClass="warningMessage" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ControlToValidate="txtSSN" ErrorMessage="* Please enter a valid SSN ######### (no formatting) *" CssClass="warningMessage" ValidationExpression="\d{9}" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee First Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtFirst_Name" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtFirst_Name" Display="Dynamic" ErrorMessage="* An Employee First Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee Last Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtLast_Name" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtLast_Name" Display="Dynamic" ErrorMessage="* An Employee Last Name is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">
                                    <img alt="Info" class="style1" src="../images/Info.gif" onclick="javascript: WinEmployeeFunctions();" />
                                    Employee Function:</td>
                                <td align="left" width="50%">
                                <asp:Dropdownlist ID="ddlEmployeeFunction" runat="server" CssClass="formLabel">
                                    <asp:ListItem Text="" Value="" />
                                    <asp:ListItem Text="Clerk" Value="Clerk" />
                                    <asp:ListItem Text="PCA IT" Value="PCA IT" />
                                    <asp:ListItem Text="PCA Manager" Value="PCA Manager" />
                                    <asp:ListItem Text="PCA Rep" Value="PCA Rep" />
                                </asp:Dropdownlist>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlEmployeeFunction" Display="Dynamic" ErrorMessage="* An Employee Function is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr> 
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee Title:</td>
                                <td align="left" width="50%">
                                <asp:Dropdownlist ID="ddlTitle" runat="server" CssClass="formLabel">
                                    <asp:ListItem Text="" Value="" /> 
                                    <asp:ListItem Text="AWG Coordinator" Value="AWG Coordinator" />
                                    <asp:ListItem Text="Contract Administrator" Value="Contract Administrator" />
                                    <asp:ListItem Text="Deputy Contract Administrator" Value="Deputy Contract Administrator" />
                                    <asp:ListItem Text="President or CEO" Value="President or CEO" />
                                    <asp:ListItem Text="Vice President" Value="Vice President" />
                                    <asp:ListItem Text="Other" Value="Other" />                                   
                                </asp:Dropdownlist>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlEmployeeFunction" Display="Dynamic" ErrorMessage="* An Employee Function is Required *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"><span class="smallText">(Enter email address only if you want the employee to receive email from the Atlanta Processing Division)</span></td>
                            </tr>  
                            <tr>
                                <td align="right" width="50%" class="formLabel">Employee Email:</td>
                                <td align="left" width="50%"> <asp:Textbox ID="txtEmail" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2"><span class="smallText">Check the boxes if yes, leave blank if no</span></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">6C Employee?</td>
                                <td align="left" width="50%"><asp:Checkbox ID="chkSixC" runat="server" CssClass="formLabel" /></td>
                            </tr> 
                            <tr>
                                <td align="right" width="50%" class="formLabel">LVC Coordinator?</td>
                                <td align="left" width="50%"><asp:Checkbox ID="chkLVCCoordinator" runat="server" CssClass="formLabel" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">This employee is a subcontractor?</td>
                                <td align="left" width="50%"><asp:Checkbox ID="chkIsSubContractor" runat="server" 
                                        CssClass="formLabel" oncheckedchanged="chkIsSubContractor_CheckedChanged" AutoPostBack="true" /></td>
                            </tr>
                            <asp:Panel ID="pnlSubContractor" runat="server" Visible="false">
                            <tr>
                                <td align="right" width="50%" class="formLabel">Name of Subcontractor:</td>
                                <td align="left" width="50%">                               
                                <asp:DropDownList ID="ddlSubcontractor" runat="server" CssClass="formLabel"
                                        DataSourceID="dsSubContractors" 
                                        DataTextField="SubContractorName"
                                        DataValueField="SubContractorID" 
                                        AppendDataBoundItems="true">
                                          <asp:ListItem Text="" Value="" />                             
                                    </asp:DropDownList></td>
                            </tr>
                            </asp:Panel>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Your Name:</td>
                                <td align="left" width="50%">
                                <asp:Textbox ID="txtAG_Employee_Name" runat="server" CssClass="formLabel" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAG_Employee_Name" Display="Dynamic" ErrorMessage="* Please enter your name *" SetFocusOnError="true" CssClass="warningMessage" /></td>
                            </tr>
                            <tr>
                                <td align="right" width="50%" class="formLabel">Comments:</td>
                                <td align="left" width="50%"><asp:Textbox ID="txtComments_PCA" runat="server" CssClass="formLabel" Columns="25" TextMode="MultiLine" Rows="5" /></td>
                            </tr>                                     
                            
                             <tr>
                                <td align="center" colspan="2"><br />
                                    <asp:Button ID="btnSubmitEmployee" runat="server" Text="Submit Employee" OnClick="btnSubmitEmployee_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" />
                                    <asp:Button ID="btnSubmitAnotherEmployee" runat="server" Text="Submit Another Employee" OnClick="btnSubmitAnotherEmployee_Click" CssClass="button" onmouseover="this.className='button buttonhover'" onmouseout="this.className='button'" Visible="false" CausesValidation="false" /></td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center"><asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" /></td>
                            </tr>                        
                        </table>
                        </fieldset>                    
                   </asp:Panel>
                   </div>
                  
<asp:Label ID="lblAgency" runat="server" Visible="false" />
<asp:Label ID="lblRandomUserID" runat="server" Visible="false" />
</form>
</body>
</html>
