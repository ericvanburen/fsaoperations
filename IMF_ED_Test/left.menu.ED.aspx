<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<script runat="server">

    Dim blnIsAdmin As Boolean
    Dim blnIsPCAUser As Boolean
    Dim blnIsSecurityOfficer As Boolean
    Dim blnProcessVAApps As Boolean
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'ED Only page - Call Check ED Login Status
            CheckEDLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblEDUserID.Text = (Request.Cookies("IMF")("EDUserID").ToString())
            End If
           
            'Bind the user info for this user
            BindUserID()
            
            lblOpenIMFs.Text = GetOpenIMFs().ToString()
            lblOpenVAApps.Text = GetOpenVAApps().ToString()
            lblAttachmentApprovalPAT.Text = GetUnApprovedIRTAttachments("PAT").ToString()
            lblAttachmentApprovalSAT.Text = GetUnApprovedIRTAttachments("SAT").ToString()
            lblAttachmentApprovalROB.Text = GetUnApprovedIRTAttachments("ROB").ToString()
            lblAttachmentApprovalIRT.Text = GetUnApprovedIRTAttachments("IRT").ToString()
            
        End If
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
                    blnIsAdmin = dr("IsAdmin")
                    lblIsAdmin.Text = blnIsAdmin
                End If
                If IsDBNull(dr("IsSecurityOfficer")) = False Then
                    blnIsSecurityOfficer = dr("IsSecurityOfficer")
                    lblIsSecurityOfficer.Text = blnIsSecurityOfficer
                End If
                If IsDBNull(dr("IsPCAUser")) = False Then
                    blnIsPCAUser = dr("IsPCAUser")
                    lblIsPCAUser.Text = blnIsPCAUser
                End If
                If IsDBNull(dr("ProcessVAApps")) = False Then
                    blnProcessVAApps = dr("ProcessVAApps")
                    lblProcessVAApps.Text = blnProcessVAApps
                End If
            End While
            
            'Admin panel is only enabled for Admins            
            If blnIsAdmin = True Then
                pnlAdministration.Visible = True
                pnlAdministration.Enabled = True
                lnkAdvancedIMFSearch.Enabled = True
                lnkEDUsers.Enabled = True
                lnkTeamAgencyAssignments.Enabled = True
                lnkTeamMemberAssignments.Enabled = True
                lnkUsersAssignedIMFType.Enabled = True
                lnkUpdatePCAs.Enabled = True
                lnkUpdateIMFType.Enabled = True
                lnkReassign.Enabled = True
                lnkSummaryReport.Enabled = True
                lnkSummaryReport_VA.Enabled = True
                lnkAllIMFs.Enabled = True
                lnkAdvancedVASearch.Enabled = True
                lnkUpdateGAs.Enabled = True
                lnkViewFeedback.Enabled = True
                lnkAllVAApps.Enabled = True
                lnkIMFsUnassigned.Enabled = True
                lnkAdminQueue.Enabled = True
                lnkGAContacts.Enabled = True
                lnkFFELRequests.Enabled = True
                lnkDMCSRequests.Enabled = True
            Else
                pnlAdministration.Visible = False
                pnlAdministration.Enabled = False
                lnkAdvancedIMFSearch.Enabled = False
                lnkEDUsers.Enabled = False
                lnkTeamAgencyAssignments.Enabled = False
                lnkTeamMemberAssignments.Enabled = False
                lnkUsersAssignedIMFType.Enabled = False
                lnkUpdatePCAs.Enabled = False
                lnkReassign.Enabled = False
                lnkUpdateIMFType.Enabled = False
                lnkSummaryReport.Enabled = False
                lnkSummaryReport_VA.Enabled = True
                lnkAllIMFs.Enabled = False
                lnkAdvancedVASearch.Enabled = False
                lnkUpdateGAs.Enabled = False
                lnkViewFeedback.Enabled = False
                lnkAllVAApps.Enabled = False
                lnkIMFsUnassigned.Enabled = False
                lnkAdminQueue.Enabled = False
                lnkGAContacts.Enabled = False
                lnkFFELRequests.Enabled = False
                lnkDMCSRequests.Enabled = False
            End If
            
            'PCA Users/Employees section should be visible only to those where IsPCAUser = 1
            If blnIsPCAUser = True Then
                pnlPCAEmployees.Visible = True
            Else
                pnlPCAEmployees.Visible = False
                pnlComplaints.Visible = False
            End If
            
            'If Security Officer logs in, then s/he should see only the Security Officer panel - all other panels should be invisible
            If blnIsSecurityOfficer = True Then
                pnlSecurityOfficer.Visible = True
                pnlIMFAdministration.Visible = False
                pnlVAApps.Visible = False
                pnlOther.Visible = False
            Else
                pnlSecurityOfficer.Visible = False
            End If
            
            'ProcessVAApps section should be visible only to those with access
            If blnProcessVAApps = True Then
                pnlVAAppsNonAdmin.Visible = True
            Else
                pnlVAAppsNonAdmin.Visible = False
            End If
				
            'Page.DataBind()
        
        Finally
            dr.Close()
            strConnection.Close()
        End Try
    End Sub
    
    'Counts the number of uncompleted IMFs for the user
    Private Function GetOpenIMFs() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("p_IMFs_ED_NoCompleted_Count_UserID", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = lblEDUserID.Text
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
   
    'Counts the number of uncompleted VA apps for the user
    Private Function GetOpenVAApps() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("p_VAApps_ED_NoCompleted_Count_UserID", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = lblEDUserID.Text
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    'Counts the number of unapproved IRT Attachments
    Private Function GetUnApprovedIRTAttachments(ByVal AttachmentType As String) As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("p_CountNumberofUnApprovedAttachments", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = lblEDUserID.Text
        cmd.Parameters.Add("@AttachmentType", SqlDbType.VarChar).Value = AttachmentType.ToString()
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <base target="main" />
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
   
        <asp:Panel id="pnlIMFAdministration" runat="server">
        <fieldset>
            <legend class="fieldsetLegend">IMFs</legend>
            <ul>
                <li><a href="MyIMFs.ED.aspx">My IMFs (<asp:Label ID="lblOpenIMFs" runat="server" />)</a></li>
                <li><a href="search.ED.basic.aspx">Basic IMF Search</a></li>        
            </ul>     
        </fieldset> 
        </asp:Panel>               
        <br />
        <asp:Panel id="pnlVAApps" runat="server">
        <fieldset>
            <legend class="fieldsetLegend">VA Apps</legend>
            <ul>
                <li><a href="MyVAApps.ED.aspx">My VA Apps (<asp:Label ID="lblOpenVAApps" runat="server" />)</a></li>
                <li><a href="search.VAApps.ED.basic.aspx">Search</a></li>        
                <asp:Panel id="pnlVAAppsNonAdmin" runat="server">              
                    <li><asp:HyperLink runat="server" ID="HyperLink6" NavigateUrl="VA.Apps.ED.aspx">All</asp:HyperLink></li>
                    <li><asp:HyperLink runat="server" ID="HyperLink7" NavigateUrl="VA.Apps.Admin.Queue.aspx">Apps Awaiting Approval</asp:HyperLink></li>
                    <li><asp:HyperLink runat="server" ID="HyperLink8" NavigateUrl="report.ED.VA.aspx">Summary Report</asp:HyperLink></li>
                    <li><asp:HyperLink runat="server" ID="HyperLink10" NavigateUrl="MyVAApps.Dupes.ED.aspx">Duplicate VA Apps</asp:HyperLink></li>                
                </asp:Panel>
         </ul>    
        </fieldset> 
        </asp:Panel>               
        
        <asp:Panel id="pnlPCAEmployees" runat="server">
        <br />
        <fieldset>
            <legend class="fieldsetLegend">PCA Employees</legend>
            <ul>
                 <li><asp:HyperLink runat="server" ID="HyperLink1" NavigateUrl="PCAEmployees/MyEmployees.ED.aspx">All</asp:HyperLink></li>
                 <li><asp:HyperLink runat="server" ID="HyperLink2" NavigateUrl="PCAEmployees/search.ED.basic.aspx">Search</asp:HyperLink></li>
                 <li><asp:HyperLink runat="server" ID="HyperLink3" NavigateUrl="PCAEmployees/FFEL.Requests.ED.All.aspx">FFEL Requests</asp:HyperLink></li>
           </ul>
           Attachments Awaiting Approval:
           <ul>                 
                  <li><asp:HyperLink runat="server" ID="lnkAttachmentApprovalPAT" NavigateUrl="PCAEmployees/Attachment.Approval.ED.aspx?AttachmentType=PAT">PAT (<asp:Label ID="lblAttachmentApprovalPAT" runat="server" />)</asp:HyperLink></li> 
                  <li><asp:HyperLink runat="server" ID="lnkAttachmentApprovalSAT" NavigateUrl="PCAEmployees/Attachment.Approval.ED.aspx?AttachmentType=SAT">SAT (<asp:Label ID="lblAttachmentApprovalSAT" runat="server" />)</asp:HyperLink></li>
                  <li><asp:HyperLink runat="server" ID="lnkAttachmentApprovalIRT" NavigateUrl="PCAEmployees/Attachment.Approval.ED.aspx?AttachmentType=IRT">IRT (<asp:Label ID="lblAttachmentApprovalIRT" runat="server" />)</asp:HyperLink></li>                                      
                  <li><asp:HyperLink runat="server" ID="lnkAttachmentApprovalROB" NavigateUrl="PCAEmployees/Attachment.Approval.ED.aspx?AttachmentType=ROB">ROB (<asp:Label ID="lblAttachmentApprovalROB" runat="server" />)</asp:HyperLink></li>               
            </ul>          
        </fieldset> 
        <br />
        </asp:Panel>
        
        <asp:Panel id="pnlComplaints" runat="server">
        <fieldset>
            <legend class="fieldsetLegend">Borrower Complaints</legend>
            <ul>
                 <li><asp:HyperLink runat="server" ID="lnkAddComplaint" NavigateUrl="complaints/Add.Complaint.aspx">Add Complaint</asp:HyperLink> (not ready)</li>
                 <li><asp:HyperLink runat="server" ID="lnkMyComplaints" NavigateUrl="complaints/MyComplaints.ED.aspx">My Complaints</asp:HyperLink> (not ready)</li>             
           </ul>     
        </fieldset> 
        <br />
        </asp:Panel>  
        
        <asp:Panel id="pnlOther" runat="server">
        <fieldset>
            <legend class="fieldsetLegend">Other</legend>
            <ul>
                <li><a href="Add.Feedback.aspx">Submit a Product Bug or Feedback</a></li>
            </ul>     
        </fieldset> 
        </asp:Panel>               
        <br />  
                                   

        
        <asp:Panel id="pnlAdministration" runat="server">
        <fieldset>
            <legend class="fieldsetLegend">Administration</legend>
            <ul>
                <li><asp:HyperLink runat="server" ID="lnkEDUsers" NavigateUrl="Maintenance.ED.Users.aspx?UserID=1">ED Users</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkViewFeedback" NavigateUrl="View.Feedback.aspx">View Feedback</asp:HyperLink></li>
            </ul>
            IMFs
            <ul>               
                <li><asp:HyperLink runat="server" ID="lnkAdvancedIMFSearch" NavigateUrl="search.ED.aspx">Advanced Search</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkIMFsUnassigned" NavigateUrl="IMFs.Unassigned.aspx">Unassigned</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkTeamAgencyAssignments" NavigateUrl="ED.team.admin.aspx">Team Agency Assignments</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkTeamMemberAssignments" NavigateUrl="ED.teams.aspx">Team Member Assignments</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkUsersAssignedIMFType" NavigateUrl="EDUsers_IMFTypes_ByType.aspx">Users Assigned to Work Each IMF Type</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkUpdatePCAs" NavigateUrl="ED.pca.admin.aspx">Update PCAs</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkUpdateIMFType" NavigateUrl="ED.IMF.admin.aspx">Update/ADD IMF Type</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkReassign" NavigateUrl="IMFs.Reassign.aspx">Reassign (batches)</asp:HyperLink></li>               
                <li><asp:HyperLink runat="server" ID="lnkAllIMFs" NavigateUrl="IMFs.ED.aspx">All</asp:HyperLink></li>
            </ul>  
            Reports
            <ul>
                <li><asp:HyperLink runat="server" ID="lnkSummaryReport" NavigateUrl="report.ED.aspx">Summary Report</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkPerformanceReport" NavigateUrl="report.ED.Performance.Metrics.aspx">Performance Report</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnk" NavigateUrl="report.ED.Submitted.By.PCA.aspx">IMFs Submitted by PCA Report</asp:HyperLink></li>
            </ul>   
         
         VA Apps   
            <br />
            <ul>
                <li><asp:HyperLink runat="server" ID="lnkAdvancedVASearch" NavigateUrl="search.ED.VA.aspx">Advanced Search</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkUpdateGAs" NavigateUrl="ED.ga.admin.aspx">Update Users</asp:HyperLink></li>                   
                <li><asp:HyperLink runat="server" ID="lnkAllVAApps" NavigateUrl="VA.Apps.ED.aspx">All</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkAdminQueue" NavigateUrl="VA.Apps.Admin.Queue.aspx">Apps Awaiting Approval</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkSummaryReport_VA" NavigateUrl="report.ED.VA.aspx">Summary Report</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkGAContacts" NavigateUrl="GA.Contacts.aspx">VA App Contacts</asp:HyperLink></li>
                 <li><asp:HyperLink runat="server" ID="lnkVAAppsDupes" NavigateUrl="MyVAApps.Dupes.ED.aspx">Duplicate VA Apps</asp:HyperLink></li>
         </ul> 
         
         PCA Employees
        <br />
         <ul>
                 <li><asp:HyperLink runat="server" ID="lnkPCAEmployeeAll" NavigateUrl="PCAEmployees/MyEmployees.ED.All.aspx">All</asp:HyperLink></li>                 
                 <li><asp:HyperLink runat="server" ID="lnkPCAEmployeeSearch" NavigateUrl="PCAEmployees/search.ED.aspx">Advanced Search</asp:HyperLink></li>
                 <li><asp:HyperLink runat="server" ID="lnkFFELRequests" NavigateUrl="PCAEmployees/FFEL.Requests.ED.All.aspx">FFEL Requests</asp:HyperLink></li>
                  <li><asp:HyperLink runat="server" ID="lnkDMCSRequests" NavigateUrl="PCAEmployees/DMCS.Requests.ED.All.aspx">DMCS Access Requests</asp:HyperLink></li> 
           </ul>
           
              
        </fieldset>
        </asp:Panel>

        <asp:Panel id="pnlSecurityOfficer" runat="server" Visible="false">
        <fieldset>
            <legend class="fieldsetLegend">Security Officer</legend>
            <ul>
                <li><asp:HyperLink runat="server" ID="lnkFFELRequsts2" NavigateUrl="PCAEmployees/FFEL.Requests.ED.All.aspx">FFEL Requests</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkDMCSRequests2" NavigateUrl="PCAEmployees/DMCS.Requests.ED.All.aspx">DMCS Access Requests</asp:HyperLink></li> 
            </ul>
            </fieldset>
         </asp:Panel>

        <br /><br />
        
         <!--Log out link-->
        <a href="logout.aspx" target="_top">Log out</a>              
                
    </div>
    <asp:Label ID="lblEDUserID" runat="server" Visible="false" />
    <asp:Label ID="lblIsAdmin" runat="server" Visible="false" />
    <asp:Label ID="lblIsSecurityOfficer" runat="server" Visible="false" />
    <asp:Label ID="lblIsPCAUser" runat="server" Visible="false" />
    <asp:Label ID="lblProcessVAApps" runat="server" Visible="false" />
    </form>
</body>
</html>
