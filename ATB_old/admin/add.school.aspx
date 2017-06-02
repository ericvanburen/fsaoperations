<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" Debug="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        
        If Not Page.IsPostBack Then
            
            'First check for a valid, logged in user
            Dim chkLogin As New CheckLogin
            lblUserID.Text = chkLogin.CheckLogin()
             
            If Not Request.Cookies("ATB") Is Nothing Then
                lblUserAdmin.Text = Request.Cookies("ATB")("Admin").ToString()
            End If
        
                    
            'Hide the Administrator links if the user is not an administrator
            If lblUserAdmin.Text = "True" Then
                hypAddSchool.Enabled = True
                hypUserManager.Enabled = True
            Else
                hypAddSchool.Enabled = False
                hypUserManager.Enabled = False
            End If
            
            If Not Request.QueryString("OPEID") Is Nothing Then
                txtOPEID.Text = Request.QueryString("OPEID").ToString()
                PopulateForm()
                btnAddRecord.Visible = False
                btnUpdateRecord.Visible = True
            Else
                btnAddRecord.Visible = True
                btnUpdateRecord.Visible = False
            End If
        End If
    End Sub
    
    Sub btnAddRecord_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim strRecordStatus As Boolean
               
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_AddSchool", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        cmd.Parameters.Add("@SchoolName_Summary", SqlDbType.VarChar).Value = txtSchoolName_Summary.Text
        cmd.Parameters.Add("@ViolationDescription_Summary", SqlDbType.VarChar).Value = txtViolationDescription_Summary.Text
        cmd.Parameters.Add("@ViolationSources_Summary", SqlDbType.VarChar).Value = ddlViolationSources_Summary.SelectedValue
        cmd.Parameters.Add("@Recommendation_Summary", SqlDbType.VarChar).Value = ddlRecommendation_Summary.SelectedValue
        cmd.Parameters.Add("@Comments_Summary", SqlDbType.VarChar).Value = txtComments_Summary.Text
        cmd.Parameters.Add("@RecordStatus", SqlDbType.Bit).Direction = ParameterDirection.Output

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            strRecordStatus = cmd.Parameters("@RecordStatus").Value

            If strRecordStatus = True Then
                lblUpdateStatus.Text = "Your school was successfully added to the database"
            Else
                lblUpdateStatus.Text = "Your school was not added because this school already exists in the database"
            End If
        Finally
            strSQLConn.Close()
        End Try
    End Sub
    
        
    Sub PopulateForm()
        'Clear the previous form values
        txtSchoolName_Summary.Text = ""
        txtViolationDescription_Summary.Text = ""
        txtViolationSources_Summary.Text = ""
        txtRecommendation_Summary.Text = ""
        txtComments_Summary.Text = ""
        
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
               
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_EditATBFinding", con)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        
        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                While dr.Read()
                    If Not IsDBNull(dr("SchoolName_Summary")) Then
                        txtSchoolName_Summary.Text = dr("SchoolName_Summary")
                    End If
                    
                    If Not IsDBNull(dr("ViolationDescription_Summary")) Then
                        txtViolationDescription_Summary.Text = dr("ViolationDescription_Summary")
                    End If
                    
                    If Not IsDBNull(dr("ViolationSources_Summary")) Then
                        txtViolationSources_Summary.Text = dr("ViolationSources_Summary")
                    End If
                    
                    If Not IsDBNull(dr("Recommendation_Summary")) Then
                        txtRecommendation_Summary.Text = dr("Recommendation_Summary")
                    End If
                    
                    If Not IsDBNull(dr("Comments_Summary")) Then
                        txtComments_Summary.Text = dr("Comments_Summary")
                    End If
                End While
            End Using
            
            ddlViolationSources_Summary.Visible = False
            ddlRecommendation_Summary.Visible = False
            txtViolationSources_Summary.Visible = True
            txtRecommendation_Summary.Visible = True
            
        Finally
            con.Close()
        End Try
    End Sub
    
    Sub btnUpdateRecord_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
                      
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_UpdateATBFinding", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        cmd.Parameters.Add("@SchoolName_Summary", SqlDbType.VarChar).Value = txtSchoolName_Summary.Text
        cmd.Parameters.Add("@ViolationDescription_Summary", SqlDbType.VarChar).Value = txtViolationDescription_Summary.Text
        cmd.Parameters.Add("@ViolationSources_Summary", SqlDbType.VarChar).Value = txtViolationSources_Summary.Text
        cmd.Parameters.Add("@Recommendation_Summary", SqlDbType.VarChar).Value = txtRecommendation_Summary.Text
        cmd.Parameters.Add("@Comments_Summary", SqlDbType.VarChar).Value = txtComments_Summary.Text

        Try
            strSQLConn.Open()
            cmd.Connection = strSQLConn
            cmd.ExecuteNonQuery()
            lblUpdateStatus.Text = "Your ATB findings were successfully updated"
        Finally
            'strSQLConn.Close()
        End Try
    End Sub
   
       
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ability to Benefit - Add ATB Findings</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

     <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
     <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
     <script src="../Scripts/menu.js" type="text/javascript"></script>

     
         
     <script type="text/javascript">
            $(function () {
                $("#tabs").tabs();
            });
	</script>
    
    <script type="text/JavaScript">
        $(document).ready(function () {
            $.ajaxSetup({
                cache: false
            });

            $("#hypValidateOPEID").click(function () {
                var OPEID = $("#txtOPEID").val();
                var loadUrl = "OPEID.Lookup.aspx?OPEID=" + OPEID;
                var reLink = '<a href="add.school.aspx?OPEID=' + OPEID + '">Populate This Form</a>';
                //$("#result").html(ajax_load).load(loadUrl);
                $("#result").load(loadUrl);
                //$("#reLink").html(reLink);
                //$("#result").load(loadUrl);
                //var resultsText = $("#result").val();
                //alert(resultsText);
            });
        });

</script>	
        
    <style type="text/css">
        .style1
        {
            width: 32%;
        }
    </style>
        
</head>
<body>
    <form id="form1" runat="server">
    <fieldset class="fieldset">         
        
        <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                 <img src="../images/fSA_logo.gif" alt="Federal Student Aid - Ability to Benefit (ATB)" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Add School ATB Findings</a></li>                                
                            </ul>
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="../logout.aspx">Log Out</a></li>
                                    <li><a href="#">Administration</a>
                                <ul>
                                    <li><asp:HyperLink ID="hypAddSchool" runat="server" Text="Add School ATB Findings" NavigateUrl="add.school.aspx" /></li>
                                    <li><asp:HyperLink ID="hypUserManager" runat="server" Text="User Manager" NavigateUrl="user.manager.aspx" /></li>
                                </ul></li>                       
                                    <li><a href="../search.OPEID.aspx">Search For OPE IDs</a></li>
                                    <li><a href="../search.ATB.aspx">Search ATB Findings</a></li>  
                          </ul>
                            </div>
                            <br /><br />
                            
                            <div id="Div1">   

                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        <table width="100%" cellpadding="4" cellspacing="5" border="0">
                                                                                   
                                            <tr>
                                                <td valign="top" align="right" width="25%"><strong>OPE ID</strong>:</td>
                                                <td valign="top" class="style1"><asp:TextBox ID="txtOPEID" runat="server" MaxLength="8" /> <asp:HyperLink ID="hypValidateOPEID" runat="server" NavigateUrl="#">Check OPE ID</asp:HyperLink><br />
                                                <span id="result" class="warning"></span> <span id="reLink" runat="server" class="hideColumn"></span><br />
                                                <asp:RequiredFieldValidator ID="rfdOPEID" runat="server" Text="Please enter a OPE ID" ControlToValidate="txtOPEID" CssClass="warning" />
                                                <br />                                     
                                                <asp:RegularExpressionValidator ID="regexOPEID" runat="server" ValidationExpression="^\d{8}$" Text="The OPE ID must be 8 digits ending in 00" ControlToValidate="txtOPEID" CssClass="warning" />
                                                </td>
                                                
                                                <td valign="top" align="right" width="25%">   
                                                <strong>School Name: </strong></td>
                                                <td valign="top" width="25%"><asp:TextBox ID="txtSchoolName_Summary" runat="server" Width="273px" /><br />
                                                <asp:RequiredFieldValidator ID="rfdbtnSearch" runat="server" Text="Please enter a school name" ControlToValidate="txtSchoolName_Summary" CssClass="warning" />                                      
                                                </td>
                                            </tr> 
                                            <tr>
                                               <td valign="top" colspan="4"><strong>ATB Findings:</strong><br />
                                                   <asp:TextBox ID="txtViolationDescription_Summary" runat="server" Height="195px" 
                                                       TextMode="MultiLine" Columns="131" Rows="8" />
                                               </td>
                                            </tr>
                                            <tr>
                                               <td valign="top" colspan="4"><strong>Source of ATB Findings:</strong><br />
                                                   <asp:DropDownList ID="ddlViolationSources_Summary" runat="server" Width="340px">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="Accreditor/Oversight/Guarantor Data" Value="Accreditor/Oversight/Guarantor Data" />                                                        
                                                        <asp:ListItem Text="OIG or ED Audit" Value="OIG or ED Audit" />
                                                        <asp:ListItem Text="Other" Value="Other" />
                                                        <asp:ListItem Text="Press or Investigative Report" Value="Press or Investigative Report" />
                                                        <asp:ListItem Text="Program Review" Value="Program Review" />                                                        
                                                   </asp:DropDownList>
                                                   <asp:TextBox ID="txtViolationSources_Summary" runat="server" Visible="false" Height="95px" 
                                                       TextMode="MultiLine" Columns="131" Rows="5" />
                                               </td>
                                            </tr>
                                            
                                            <tr>
                                            
                                               <td valign="top" colspan="4"><strong>Recommendation:</strong><br />
                                                   <asp:DropDownList ID="ddlRecommendation_Summary" runat="server">                                                        
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="Recommend Discharge All" Value="Recommend Discharge All" />                                                        
                                                        <asp:ListItem Text="No Corroboration Found" Value="No Corroboration Found" />
                                                        <asp:ListItem Text="Recommend Discharge For Certain Time Periods Only" Value="Recommend Discharge For Certain Time Periods Only" />
                                                        <asp:ListItem Text="Recommend Discharge For Certain Campuses Only" Value="Recommend Discharge For Certain Campuses Only" />
                                                        <asp:ListItem Text="Other--See Comments" Value="Other--See Comments" />                                                        
                                                   </asp:DropDownList>
                                                   <asp:TextBox ID="txtRecommendation_Summary" runat="server" Visible="false" Height="95px" 
                                                       TextMode="MultiLine" Columns="131" Rows="5" />
                                               </td>
                                            </tr>
                                            <tr>
                                               <td valign="top" colspan="4"><strong>Comments:</strong><br />
                                                   <asp:TextBox ID="txtComments_Summary" runat="server" Height="95px" 
                                                       TextMode="MultiLine" Columns="131" Rows="5" />
                                               </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center"><asp:Button ID="btnAddRecord" runat="server" Text="Add ATB Findings" OnClick="btnAddRecord_Click" CssClass="button" />
                                                <asp:Button ID="btnUpdateRecord" runat="server" Text="Update ATB Findings" OnClick="btnUpdateRecord_Click" CssClass="button" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4" align="center"><asp:Label ID="lblUpdateStatus" runat="server" CssClass="warning" /></td>
                                            </tr>
                                        </table>

                                        </div>
                            </div>
                    
      </div>
                    
                         </td>
                </tr>
            </table>
             </div>
    
    <br />
    
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblUserAdmin" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
    </form>
</body>
</html>
