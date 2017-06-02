<%@ Page Language="VB" Inherits="MyBaseClass" src="../classes/MyBaseClass.vb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Dim blnIsAdmin As Boolean
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If Not Page.IsPostBack Then
            'Vangent Only page - Call Check Vangent Login Status
            CheckVangentLogin()
            
            If Not IsNothing(Request.Cookies("IMF")) Then
                lblVangent.Text = (Request.Cookies("IMF")("Vangent").ToString())
            End If
            
            BindUserID()
            
        End If
    End Sub
    
    Sub BindUserID()
        Dim strConnection As SqlConnection
        Dim strSql As String
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader

        strConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        strSql = "p_UserDetail_Vangent_Email"
        cmd = New SqlCommand(strSql)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Username", lblVangent.Text)
        Try
            strConnection.Open()
            cmd.Connection = strConnection
            dr = cmd.ExecuteReader()
            
            While dr.Read()
                If IsDBNull(dr("IsAdmin")) = False Then
                    lblIsAdmin.Text = dr("IsAdmin")
                    lblQueueID.Text = dr("QueueID")
                End If
            End While
            
            Page.DataBind()
            
            'pnlAdmin is visible only to admins
            If lblIsAdmin.Text.ToString() = "True" Then
                pnlAdmin.Visible = True
            Else
                pnlAdmin.Visible = False
            End If
            
            'Set the My Queue hyperlink value
            hypMyQueue.NavigateUrl = "IMF.Detail.Queue.aspx?Lock=Lock&QueueID=" & lblQueueID.Text
            
            'Set Pendng link
            hypPending.NavigateUrl = "My.IMFs.Pending.aspx?QueueID=" & lblQueueID.Text
            
            'Set Search link
            hypSearch.NavigateUrl = "search.Vangent.basic.aspx?QueueID=" & lblQueueID.Text
            
        Finally
            'dr.Close()
            strConnection.Close()
        End Try
    End Sub
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <base target="main" />
    <link href="../style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
   
        
        <ul>
            <li><asp:Hyperlink ID="hypMyQueue" runat="server" Text="My Queue" /></li>
            <li><asp:Hyperlink ID="hypPending" runat="server" Text="Pending" /></li>
            <li><asp:Hyperlink ID="hypSearch" runat="server" Text="Basic Search" /></li>
            <li><a href="../logout.aspx" target="_top">Log out</a></li>
        </ul>

       <asp:Panel ID="pnlAdmin" runat="server">
        <fieldset>       
            
            <legend class="fieldsetLegend">IMF Administration</legend>
            <ul>                               
                <li><asp:HyperLink runat="server" ID="lnkAllIMFs" NavigateUrl="IMFs.Vangent.aspx">All</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkAdvancedIMFSearch" NavigateUrl="search.Vangent.aspx">Advanced Search</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkReassign" NavigateUrl="IMFs.Reassign.aspx">Reassign IMFs</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkQueue" NavigateUrl="Queue.aspx?QueueID=1">Queues</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnkIMFAdmin" NavigateUrl="Vangent.IMF.admin.aspx">Add/Update IMF Type</asp:HyperLink></li>
                <li><a href="IMFs.Unassigned.aspx">Unassigned IMFs</a></li>
                
            </ul>     
            <!--
            Reports
            <ul>               
                <li><asp:HyperLink runat="server" ID="lnkPerformanceReport" NavigateUrl="report.Vangent.Performance.Metrics.aspx">Performance Report</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="lnk" NavigateUrl="report.Vangent.Submitted.By.PCA.aspx">IMFs Submitted by PCA Report</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="HyperLink1" NavigateUrl="report.Vangent.Requests.Status.aspx">PCA Requests by Status</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="HyperLink4" NavigateUrl="report.Vangent.Errors.aspx">PCA Requests Submitted In Error</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="HyperLink5" NavigateUrl="report.Vangent.Daily.Summary.aspx">Daily IMF Report by PCA</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="HyperLink6" NavigateUrl="report.Vangent.Aging.aspx">WIP Aging Report</asp:HyperLink></li>
                 
            </ul>
            -->
            DRG Users
            <ul>
                <li><asp:HyperLink runat="server" ID="HyperLink2" NavigateUrl="Vangent.user.admin.aspx?UserID=2">User Administration</asp:HyperLink></li> 
                <li><asp:HyperLink runat="server" ID="HyperLink3" NavigateUrl="Vangent.Queue.IMF.Assignments.aspx?QueueID=1">Queue/IMF Assignments</asp:HyperLink></li>
                <li><asp:HyperLink runat="server" ID="HyperLink7" NavigateUrl="Vangent.Add.Queue.aspx">Add New User Queue</asp:HyperLink></li>
            </ul>         
         </fieldset>
        <br /><br />
        </asp:Panel>
         
                
    </div>
    <asp:Label ID="lblVangent" runat="server" Visible="false" />
    <asp:Label ID="lblIsAdmin" runat="server" Visible="false" />
    <asp:Label ID="lblQueueID" runat="server" Visible="false" />
    
    </form>
</body>
</html>
