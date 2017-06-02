<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not IsPostBack Then
            'ED and VA page - Call Check Login Status
            CheckEDLogin()
            
            If Not IsNothing(Request.Cookies("IMF")("EDUserID")) Then
                'ED employee is looking at the discharge app
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
            End If
            
            'VA discharge app Request ID
            Dim intID As Integer = Request("ID")
            lblID.Text = intID
            
            'Look up SSN based on ID
            SSNLookup(intID)
            
            'Give the Effective Date textbox a default value of today's date
            txtEffectiveDate.Text = DateTime.Today
            
            'Bind the user info for this user
            BindUserID()
        End If
    End Sub
    
    Sub SSNLookup(ByVal ID As Integer)
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_VAAPP_SSNLookup"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                If IsDBNull(dr("SSN")) = False Then
                    lblSSN.Text = dr("SSN")
                End If
            End While
        Finally
            strConnection.Close()
        End Try
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'This inserts a new approval status record into Requests_VA_Approval_Status
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        
        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_Requests_VA_Approval_Status_Insert"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ID", lblID.Text)
        cmd.Parameters.AddWithValue("@ApprovalStatus", rdAccountStatus.SelectedValue)
        cmd.Parameters.AddWithValue("@EffectiveDate", txtEffectiveDate.Text)
        cmd.Parameters.AddWithValue("@Refund_Amount", txtRefund_Amount.Text)
        cmd.Parameters.AddWithValue("@UserID", lblEDUserID.Text)

        Try
            strConnection.Open()
            cmd.Connection = strConnection
            cmd.ExecuteNonQuery()
            lblStatus.Text = "This VA Discharge App has been updated"
        Finally
            strConnection.Close()
        End Try
    End Sub
    
    Sub BindUserID()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@UserID", lblEDUserID.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                If IsDBNull(dr("IsAdmin")) = False Then
                    'This is the Refund Approved status which is available only to Admins
                    If dr("IsAdmin") = True Then
                        rdAccountStatus.Items(5).Enabled = True
                    Else
                        rdAccountStatus.Items(5).Enabled = False
                    End If
                End If
            End While
            
            Page.DataBind()
        
        Finally
            dr.Close()
            strConnection.Close()
        End Try
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>VA Checklist</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">    
    .displayNone {
        display: none;        
    }
    
    .displayShow {
        display: block;
    }
    
    </style>
    <script language="javascript" type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
    <script language="javascript" type="text/javascript">
//        $(document).ready(function() {
//            $("input:radio[@name=rdAccountStatus]").click(function() {
//                getAccountStatus();
//            }); // Account Status radio buttons 

//            function getAccountStatus() {
//                var AccountStatusvalue = $("input[name='rdAccountStatus']:checked").val();

//                if (AccountStatusvalue == "Pending Refund Due") {
//                    // Account status is approved 
//                    $("#divApproved").removeClass("displayNone").addClass("displayShow");
//                } else if (AccountStatusvalue == "Approved - No Refund Due" || AccountStatusvalue == "Pending VA Approval" || AccountStatusvalue == "Pending Refund Posting" || AccountStatusvalue == "Denied" || AccountStatusvalue == "Refund Approved") {
//                    $("#divApproved").removeClass("displayShow").addClass("displayNone");
//                }

//            } // getAccountStatus()
//        });             // .ready function
</script>

</head>
<body>
    <form id="form1" runat="server">     
    <span class="fieldsetLegend">SSN: </span><asp:Label ID="lblSSN" runat="server" CssClass="fieldsetLegend" /><br /> <br />
   
   <div id="divAccountStatus">
    <b>Approval Status:</b>
    <asp:RadioButtonList ID="rdAccountStatus" runat="server" RepeatDirection="Vertical">
        <asp:ListItem  Text="Approved - No Refund Due" Value="Approved - No Refund Due" />       
        <asp:ListItem  Text="Pending VA Approval" Value="Pending VA Approval" />
        <asp:ListItem  Text="Pending Refund Due" Value="Pending Refund Due" />
        <asp:ListItem  Text="Pending Refund Posting" Value="Pending Refund Posting" />
         <asp:ListItem  Text="Denied" Value="Denied" />
         <asp:ListItem  Text="Refund Approved" Value="Refund Approved" Enabled="false" />
    </asp:RadioButtonList>   
    <asp:RequiredFieldValidator ID="rfAccountStatus" runat="server" ControlToValidate="rdAccountStatus" CssClass="warningMessage" Display="Dynamic" ErrorMessage="* Please select a value for Approval Status" />
    <br />
    <div id="divApproved">
        <span id="spnEffectiveDate">Effective Date:</span><asp:TextBox ID="txtEffectiveDate" runat="server" />
        <span id="spnRefund_Amount">Refund Amount:</span> $<asp:TextBox ID="txtRefund_Amount" runat="server" />
        <asp:RequiredFieldValidator ID="rfEffectiveDate" runat="server" ControlToValidate="txtEffectiveDate" CssClass="warningMessage" Display="Dynamic" ErrorMessage="* Effective Date is a required field" />
    </div>
    <br /><br />
    <asp:Button ID="btnSubmit" runat="server" CssClass="button" onclick="btnSubmit_Click" Text="Submit" />
</div>

<asp:Label ID="lblStatus" runat="server" CssClass="warningMessage" />
<asp:Label ID="lblID" runat="server" Visible="false" />
<asp:Label ID="lblEDUserID" runat="server" Visible="false" />

</form>
</body>
</html>
