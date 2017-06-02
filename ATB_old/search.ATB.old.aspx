<%@ Page Language="VB" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="CheckLogin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'First check for a valid, logged in user
        Dim chkLogin As New CheckLogin
        lblUserID.Text = chkLogin.CheckLogin()
                
        If Not Request.QueryString("OPEID") Is Nothing Then
            txtOPEID.Text = Request.QueryString("OPEID").ToString()
            BindGridView()
        End If
        
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
    End Sub
   
        
    Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
        BindGridView()
    End Sub
    
    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("search.ATB.aspx")
    End Sub
    
    Sub BindGridView()
        Dim strSQLConn As SqlConnection
        Dim cmd As SqlCommand
        Dim ds As DataSet
        
        strSQLConn = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", strSQLConn)
        cmd.CommandType = CommandType.StoredProcedure
        
        If txtOPEID.Text <> "" Then
            cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        End If
        
        
        Try
            strSQLConn.Open()
            Dim MyAdapter As New SqlDataAdapter(cmd)
            
            ds = New DataSet()
            MyAdapter.Fill(ds, "Requests")
            
            Dim intRecordCount As Integer = ds.Tables(0).Rows.Count()
            If intRecordCount = 0 Then
                pnlNoResults.Visible = True
            Else
                pnlNoResults.Visible = False
            End If
                     
            Repeater1.DataSource = ds.Tables("Requests").DefaultView
            Repeater1.DataBind()
            
        Finally
            strSQLConn.Close()
        End Try
    End Sub
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ability to Benefit Search ATB Findings</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

     <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
     <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
     <script src="Scripts/menu.js" type="text/javascript"></script>
         
     <script type="text/javascript">
            $(function () {
                $("#tabs").tabs();
            });
	</script>	
        
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
        
        <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		                 <img src="images/fSA_logo.gif" alt="Federal Student Aid - Ability to Benefit (ATB)" />                        
                            <div id="tabs">
                            <ul>
                                <li><a href="#tabs-1">Search ATB Findings</a></li>                                
                            </ul>
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
                                 <ul id="nav">
                                    <li><a href="logout.aspx">Log Out</a></li>
                                    <li><a href="#">Administration</a>
                                <ul>
                                    <li><asp:HyperLink ID="hypAddSchool" runat="server" Text="Add School ATB Findings" NavigateUrl="admin/add.school.aspx" /></li>
                                    <li><asp:HyperLink ID="hypUserManager" runat="server" Text="User Manager" NavigateUrl="admin/user.manager.aspx" /></li>                                    
                                </ul></li>                       
                                    <li><a href="search.OPEID.aspx">Search For OPE IDs</a></li>
                                    <li><a href="search.ATB.aspx">Search ATB Findings</a></li>  
                          </ul>
                            </div>
                            <br /><br />
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                    <div id="Div1">   

                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        <table width="100%" cellpadding="4" cellspacing="5" border="0">
                                                                                   
                                            <tr>
                                                <td valign="top">   
                                                <strong>OPE ID: </strong><br />
                                                <asp:TextBox ID="txtOPEID" runat="server" MaxLength="8" /> 
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" /><br />
                                                <asp:RequiredFieldValidator ID="rfdbtnSearch" runat="server" Text="Please enter an eight-digit OPE ID" ControlToValidate="txtOPEID" CssClass="warning" SetFocusOnError="true" />
                                                <br />                                     
                                                <asp:RegularExpressionValidator ID="regexOPEID" runat="server" ValidationExpression="^\d{8}$" Text="The OPE ID must be 8 digits ending in 00" ControlToValidate="txtOPEID" CssClass="warning" />
                                                </td>
                                            </tr> 
                                        </table>

                                        <asp:Panel ID="pnlNoResults" runat="server" Visible="false">
                                            No records matched your search
                                        </asp:Panel>

                                        <asp:Repeater ID="Repeater1" runat="server">
                                        <HeaderTemplate>
                                            <table border="0" width="100%" cellpadding="5" cellspacing="5">
                                        </HeaderTemplate>

                                        <ItemTemplate>
                                            <tr>
                                                <td colspan="2"><hr /></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"><strong>OPE ID:</strong> <br />
                                                 <asp:Label ID="lblOPEID" Text='<%# Eval("OPEID") %>' runat="server" /></td>

                                                 <td valign="top"><strong>School Name (including AKAs):</strong> <br />
                                                 <asp:Label ID="lblSchoolName" Text='<%# Eval("SchoolName") %>' runat="server" /></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"><strong>City, State (if known):</strong> <br />
                                                 <asp:Label ID="lblCity" Text='<%# Eval("City_EDAudits") %>' runat="server" /> <asp:Label ID="lblState" Text='<%# Eval("State_EDAudits") %>' runat="server" /> </td>

                                                 <td valign="top"><strong>Accreditor Contacted?</strong> <br />
                                                 <asp:Label ID="chkAccreditor_Contacted" Text='<%# CDbl(Eval("Accreditor_Contacted")).ToString("No;Yes")%>' runat="server" /></td>                                               
                                            </tr>
                                             <tr>
                                                <td valign="top"><strong># of apps GA/ED have received historically:</strong> 
                                                 <asp:Label ID="lblTotalAppsProcessed" Text='<%# Eval("TotalAppsProcessed") %>' runat="server" /></td>
                                             </tr>
                                             <tr>
                                                <td colspan="4"><hr /></td>
                                             </tr>
                                           
                                             <tr>
                                                <td valign="top" colspan="2"><strong><u>Recommendation</u></strong><br /><br />                                               
                                                <ul>
                                                <li><p><asp:Label ID="lblRecommendation" Text='ATB Violations Summary: <%# Eval("Recommendation_Summary") %>' runat="server" /><br />
                                                Source(s): <asp:Label ID="lblViolationSources_Summary" Text='<%# Eval("ViolationSources_Summary") %>' runat="server" /></p>
                                                
                                                <li><p>ED Audits: <asp:Label ID="lblRecommendation_EDAudits" Text='<%# Eval("Recommendation_EDAudits") %>' runat="server" />. Discharge For Year(s): <asp:Label ID="lblYearsATBFindings_EDAudits" Text='<%# Eval("YearsATBFindings_EDAudits") %>' runat="server" /></p>
		                                        
                                                <li><p>ED Program Reviews: <asp:Label ID="lblRecommendation_ProgramReviews" Text='<%# Eval("Recommendation_ProgramReviews") %>' runat="server" />. Discharge For Year(s): <asp:Label ID="lblYearsATBFindings_ProgramReviews" Text='<%# Eval("YearsATBFindings_ProgramReviews") %>' runat="server" /></p>
                                                
                                                <li><p>OIG Audits: <asp:Label ID="lblRecommendation_OIGAudits" Text='<%# Eval("Recommendation_OIGAudits") %>' runat="server" />. Discharge For Year(s): <asp:Label ID="lblYearsAudited_OIGAudits" Text='<%# Eval("YearsAudited_OIGAudits") %>' runat="server" /></p>
                                                <li><p>Pre-PEPS Data: <asp:Label ID="lblRecommendation_PEPS" Text='<%# Eval("Recommendation_PEPS") %>' runat="server" />. Discharge For Year(s): <asp:Label ID="lblYearsATBFindings_PEPS" Text='<%# Eval("YearsATBFindings_PEPS") %>' runat="server" /></p>
                                                <li><p>ED/GA Data Sharing: <asp:Label ID="lblRecommendation_GA_ED" Text='<%# Eval("Recommendation_GA_ED") %>' runat="server" />. Discharge For Year(s): 
                                                <asp:Label ID="lblField2" Text='<%# Eval("Field2") %>' runat="server" />
                                                <asp:Label ID="lblField3" Text='<%# Eval("Field3") %>' runat="server" />
                                                <asp:Label ID="lblField4" Text='<%# Eval("Field4") %>' runat="server" />
                                                <asp:Label ID="lblField5" Text='<%# Eval("Field5") %>' runat="server" />
                                                <asp:Label ID="lblField6" Text='<%# Eval("Field6") %>' runat="server" />
                                                <asp:Label ID="lblField7" Text='<%# Eval("Field7") %>' runat="server" /><br />
                                                <asp:Label ID="lblField8" Text='<%# Eval("Field8") %>' runat="server" />
                                                <asp:Label ID="lblField9" Text='<%# Eval("Field9") %>' runat="server" />
                                                <asp:Label ID="lblField10" Text='<%# Eval("Field10") %>' runat="server" />
                                                <asp:Label ID="lblField11" Text='<%# Eval("Field11") %>' runat="server" />
                                                <asp:Label ID="lblField12" Text='<%# Eval("Field12") %>' runat="server" />
                                                <asp:Label ID="lblField13" Text='<%# Eval("Field13") %>' runat="server" />
                                                <asp:Label ID="lblField14" Text='<%# Eval("Field14") %>' runat="server" /><br />
                                                <asp:Label ID="lblField15" Text='<%# Eval("Field15") %>' runat="server" />
                                                <asp:Label ID="lblField16" Text='<%# Eval("Field16") %>' runat="server" />
                                                <asp:Label ID="lblField17" Text='<%# Eval("Field17") %>' runat="server" />
                                                
                                                </p>
	                                            
                                                </ul>
                                                </td>
                                            </tr>  
                                            
                                            <tr>
                                                <td valign="top" colspan="2"><strong><u>Description</u></strong><br /><br />                                                
                                                <asp:Label ID="lblViolationDescription_Summary" Text='<%# Eval("ViolationDescription_Summary") %>' runat="server" /></td>
                                            </tr> 
                                            <tr>
                                                <td valign="top" colspan="2"><strong><u>Comments</u></strong><br /><br />                                                
                                                <asp:Label ID="lblTimeframeComments" Text='<%# Eval("Comments_Summary") %>' runat="server" /></td>
                                            </tr>                
                                             

                                            <tr>
                                                <td valign="top" colspan="2"><strong><u>Source(s)</u></strong><br /><br />                                                
                                                </td>
                                            </tr>                                             
                                            
                                        </ItemTemplate>
                                        
                                        <FooterTemplate>
                                        </table>
                                        </FooterTemplate>
                                        </asp:Repeater>

                                        </div>
                            </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            <p>&nbsp;</p>
                            <p>&nbsp;</p>
                            
                  
                    </div>
                     
                         </td>
                </tr>
            </table>
            </div>
        
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblUserAdmin" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
    </form>
</body>
</html>
