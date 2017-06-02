<%@ Page Language="VB" Inherits="MyBaseClass" src="classes/MyBaseClass.vb"   %>
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
            
            lblApprovedForHire.Text = GetEmployeesApprovedForHire().ToString
            lblNoDecision.Text = GetEmployeesNoDecision().ToString()
            lblFormsRejected.Text = GetFormsRejected().ToString()
        End If
    End Sub
    
    'Counts the number of employees in Approved For Hire status(3) for the agency
    Private Function GetEmployeesApprovedForHire() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetEmployeesStatus", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@StatusID", SqlDbType.Int).Value = 3
        cmd.Parameters.Add("@AG", SqlDbType.VarChar).Value = lblAgency.Text
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    'Counts the number of employees in No Decision status(1) for the agency
    Private Function GetEmployeesNoDecision() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetEmployeesStatus", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@StatusID", SqlDbType.Int).Value = 1
        cmd.Parameters.Add("@AG", SqlDbType.VarChar).Value = lblAgency.Text
        cmd.Parameters.Add("@ReturnVal", SqlDbType.Int).Direction = ParameterDirection.Output
        Using con
            con.Open()
            cmd.ExecuteNonQuery()
            result = CType(cmd.Parameters("@ReturnVal").Value, Integer)
        End Using
        Return result
    End Function
    
    'Counts the number of employees with rejected PAT, SAT, IRT or ROB forms
    Private Function GetFormsRejected() As Integer
        Dim result As Integer = 0
        Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("ConnectionString_IMF_SQL").ConnectionString)
        Dim cmd As New SqlCommand("GetFormsRejected", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add("@AG", SqlDbType.VarChar).Value = lblAgency.Text
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
        <fieldset>
            <legend class="fieldsetLegend">IMF Administration</legend>
            <p><a href="IMFs.Add.PCA.aspx">Submit New IMF</a></p>
            ED           
            <ul>
                <li><a href="MyIMFs.PCA.aspx">My IMFs</a></li>
                <li><a href="search.PCA.aspx">Advanced Search</a></li>
               
                <li><a href="MyIMFs.Archived.PCA.aspx">Archived IMFs</a></li> 
                <li><a href="Add.Feedback.aspx">Tell us how this is working for you</a></li>           
            </ul>
            DRG           
            <ul>
                <li><a href="Vangent/MyIMFs.PCA.aspx">My IMFs</a></li>
                <li><a href="Vangent/PCA.Errors.aspx">IMFs Submitted In Error</a></li>
                <li><a href="Vangent/MyIMFs.Archived.PCA.aspx">Archived IMFs</a></li>                
                <li><a href="Vangent/search.PCA.aspx">Advanced Search</a></li>                        
            </ul>          
        <br /><br />        
        </fieldset>
        <br />
        <fieldset>
            <legend class="fieldsetLegend">My Employees</legend>
            <ul>
                 <li><asp:HyperLink runat="server" ID="lnkPCAEmployeeAdd" NavigateUrl="PCAEmployees/Add.Employee.PCA.aspx">Add New Employee</asp:HyperLink></li>
                 <li><asp:HyperLink runat="server" ID="lnkApprovedForHire" NavigateUrl="PCAEmployees/MyEmployees.PCA.aspx?StatusID=3">Approved For Hire</asp:HyperLink> (<asp:Label ID="lblApprovedForHire" runat="server" />)</li>                 
                 <li><asp:HyperLink runat="server" ID="lnkFFELEligible" NavigateUrl="PCAEmployees/MyEmployees.PCA.FFEL.Eligible.aspx">Approved to Submit FFEL Form</asp:HyperLink> (<asp:Label ID="lblFFELEligible" runat="server" />)</li>                 
                 <li><asp:HyperLink runat="server" ID="lnkNoDecision" NavigateUrl="PCAEmployees/MyEmployees.PCA.aspx?StatusID=1">No Decision</asp:HyperLink> (<asp:Label ID="lblNoDecision" runat="server" />)</li>
                 <li><asp:HyperLink runat="server" ID="lnkPCAEmployeeAll" NavigateUrl="PCAEmployees/MyEmployees.PCA.aspx?StatusID=All">All</asp:HyperLink></li>            
                 <li><asp:HyperLink runat="server" ID="lnkFormsRejected" NavigateUrl="PCAEmployees/MyEmployees.PCA.Forms.Not.Approved.aspx">Rejected Forms</asp:HyperLink> (<asp:Label ID="lblFormsRejected" runat="server" />) </li>
                 <li><asp:HyperLink runat="server" ID="lnkPCAEmployeeSearch" NavigateUrl="PCAEmployees/search.PCA.basic.aspx">Search Employees</asp:HyperLink></li>                      
            </ul>     
        </fieldset> 
        <br />
        
        <!--Log out link-->
        <br />
        <a href="logout.aspx" target="_top">Log out</a>    
         
                  
                
    </div>
    <asp:Label ID="lblAgency" runat="server" Visible="false" />
    </form>
</body>
</html>
