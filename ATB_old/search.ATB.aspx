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
            hypOPEID.NavigateUrl = "All.Schools.OPEID.aspx?OPEID=" & txtOPEID.Text
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
        'Response.Redirect("search.ATB.aspx")
        'Dim strOPEID As String
        'strOPEID = txtOPEID.Text
        BindGridView()
    End Sub
    
    Sub btnSearchAgain_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("search.ATB.aspx")
    End Sub
   
    
    Sub BindGridView()
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim dr As SqlDataReader
        
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("ATBConnectionString").ConnectionString)
        cmd = New SqlCommand("p_Search", con)
        cmd.CommandType = CommandType.StoredProcedure
        
        If txtOPEID.Text <> "" Then
            cmd.Parameters.Add("@OPEID", SqlDbType.VarChar).Value = txtOPEID.Text
        End If
        
        Try
            cmd.Connection = con
            Using con
                con.Open()
                dr = cmd.ExecuteReader()
                If dr.HasRows() Then
                    While dr.Read()
                        lblOPEID.Text = dr("OPEID")
                        hypOPEID.NavigateUrl = "All.Schools.OPEID.aspx?OPEID=" & dr("OPEID").ToString()
                        lblSchoolName.Text = dr("SchoolName")
                        chkAccreditor_Contacted.Text = TrueFalse(dr("Accreditor_Contacted"))
                        lblTotalAppsProcessed.Text = dr("TotalAppsProcessed")
                        'Recommendations Section
                        If Not dr("Recommendation_Summary") Is DBNull.Value Then
                            lblRecommendation_Summary.Text = "<li><p>ATB Violations Summary: " & dr("Recommendation_Summary")
                        End If
                    
                        If Not dr("ViolationSources_Summary") Is DBNull.Value Then
                            lblViolationSources_Summary.Text = "Source(s): " & dr("ViolationSources_Summary") & "</p></li>"
                        End If
                    
                        If Not dr("Recommendation_EDAudits") Is DBNull.Value Then
                            lblRecommendation_EDAudits.Text = "<li><p>ED Audits: " & dr("Recommendation_EDAudits")
                        End If
                                        
                        If Not dr("YearsATBFindings_EDAudits") Is DBNull.Value Then
                            lblYearsATBFindings_EDAudits.Text = "Discharge For Year(s): " & dr("YearsATBFindings_EDAudits") & "</p></li>"
                        End If
                                      
                        If Not dr("Recommendation_ProgramReviews") Is DBNull.Value Then
                            lblRecommendation_ProgramReviews.Text = "<li><p>ED Program Reviews: " & dr("Recommendation_ProgramReviews")
                        End If
                    
                        If Not dr("YearsATBFindings_ProgramReviews") Is DBNull.Value Then
                            lblYearsATBFindings_ProgramReviews.Text = "Discharge For Year(s): " & dr("YearsATBFindings_ProgramReviews") & "</p></li>"
                        End If
                    
                        If Not dr("Recommendation_OIGAudits") Is DBNull.Value Then
                            lblRecommendation_OIGAudits.Text = "<li><p>OIG Audits: " & dr("Recommendation_OIGAudits")
                        End If
                                       
                        If Not dr("YearsAudited_OIGAudits") Is DBNull.Value Then
                            lblYearsAudited_OIGAudits.Text = "Discharge For Year(s): " & dr("YearsAudited_OIGAudits") & "</p></li>"
                        End If
                    
                        If Not dr("Recommendation_PEPS") Is DBNull.Value Then
                            lblRecommendation_PEPS.Text = "<li><p>Pre-PEPS Data: " & dr("Recommendation_PEPS")
                        End If
                    
                        If Not dr("YearsATBFindings_PEPS") Is DBNull.Value Then
                            lblYearsATBFindings_PEPS.Text = "Discharge For Year(s): " & dr("YearsATBFindings_PEPS") & "</p></li>"
                        End If
                    
                        If Not dr("Recommendation_GA_ED") Is DBNull.Value Then
                            lblRecommendation_GA_ED.Text = "<li><p>ED/GA Data Sharing: " & dr("Recommendation_GA_ED")
                        End If
                    
                        If Not dr("Recommendation_GA_ED") Is DBNull.Value Then
                            lblYearsATBFindings_GA_ED.Text = "If no other info, check with FSA first before possible Discharge for Year(s):"
                            lblField2.Text = dr("Field2")
                            lblField3.Text = dr("Field3")
                            lblField4.Text = dr("Field4")
                            lblField5.Text = dr("Field5")
                            lblField6.Text = dr("Field6")
                            lblField7.Text = dr("Field7")
                            lblField8.Text = dr("Field8")
                            lblField9.Text = dr("Field9")
                            lblField10.Text = dr("Field10")
                            lblField11.Text = dr("Field11")
                            lblField12.Text = dr("Field12")
                            lblField13.Text = dr("Field13")
                            lblField14.Text = dr("Field14")
                            lblField15.Text = dr("Field15")
                        End If
                    
                        If Not dr("ViolationDescription_Summary") Is DBNull.Value Then
                            lblViolationDescription_Summary.Text = "<strong><u>Description</u></strong><br /><br />" & dr("ViolationDescription_Summary")
                        End If
                    
                        If Not dr("Comments_Summary") Is DBNull.Value Then
                            lblComments_Summary.Text = "<strong><u>Comments</u></strong><br /><br />" & dr("Comments_Summary")
                        End If
                    End While
                Else
                    'Clear all of the labels from the previous search
                    EmptyTextBoxValues(Me)
                End If
            End Using
        Finally
            con.Close()
        End Try
    End Sub
    
    Private Sub EmptyTextBoxValues(ByVal parent As Control)
        For Each c As Control In parent.Controls
            If (c.Controls.Count > 0) Then
                EmptyTextBoxValues(c)
            Else
                If TypeOf c Is TextBox Then
                    CType(c, TextBox).Text = ""
                End If
                
                If TypeOf c Is Label Then
                    CType(c, Label).Text = ""
                End If
            End If
        Next
    End Sub
    
    Public Shared Function TrueFalse(ByVal MyValue As Boolean) As String
        Dim result As String = String.Empty
        If MyValue = True Then
            Return "Yes"
        Else
            Return "No"
        End If
        Return result
    End Function
   
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                                <%--<asp:UpdatePanel runat="server">
                                    <ContentTemplate>--%>
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
                                                                               
                                            <table border="0" width="100%" cellpadding="5" cellspacing="5">
                                       
                                            <tr>
                                                <td colspan="2"><hr /></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"><strong>OPE ID:</strong> <br />
                                                 <asp:Label ID="lblOPEID" runat="server" /></td>

                                                 <td valign="top"><strong>School Name (including AKAs):</strong> <br />
                                                 <asp:Label ID="lblSchoolName" runat="server" /></td>
                                            </tr>
                                            <tr>
                                                <td valign="top"><strong># of apps GA/ED have received historically:</strong> <br />
                                                 <asp:Label ID="lblTotalAppsProcessed" runat="server" /></td>

                                                 <td valign="top"><strong>Accreditor Contacted?</strong> <br />
                                                 <asp:Label ID="chkAccreditor_Contacted" runat="server" /></td>                                               
                                            </tr>
                                            <tr>
                                                <td><asp:HyperLink ID="hypOPEID" runat="server">All Schools Under This OPE ID</asp:HyperLink></td>
                                            </tr>
                                             
                                             <tr>
                                                <td colspan="4"><hr /></td>
                                             </tr>
                                           
                                             <tr>
                                                <td valign="top" colspan="2"><strong><u>Recommendation</u></strong><br /><br />                                               
                                                <ul>
                                                
                                                    <asp:Label ID="lblRecommendation_Summary" runat="server" />
                                                    <asp:Label ID="lblViolationSources_Summary" runat="server" />
                                                
                                                    <asp:Label ID="lblRecommendation_EDAudits" runat="server" /> 
                                                    <asp:Label ID="lblYearsATBFindings_EDAudits" runat="server" />
		                                        
                                                    <asp:Label ID="lblRecommendation_ProgramReviews" runat="server" /> 
                                                    <asp:Label ID="lblYearsATBFindings_ProgramReviews" runat="server" />
                                                
                                                    <asp:Label ID="lblRecommendation_OIGAudits" runat="server" /> 
                                                    <asp:Label ID="lblYearsAudited_OIGAudits" runat="server" />
                                                
                                                    <asp:Label ID="lblRecommendation_PEPS" runat="server" /> 
                                                    <asp:Label ID="lblYearsATBFindings_PEPS" runat="server" />
                                                
                                                    <asp:Label ID="lblRecommendation_GA_ED" runat="server" />
                                                    <asp:Label ID="lblYearsATBFindings_GA_ED" runat="server" />
                                                                                                
                                                    <asp:Label ID="lblField2" runat="server" />
                                                    <asp:Label ID="lblField3" runat="server" />
                                                    <asp:Label ID="lblField4" runat="server" />
                                                    <asp:Label ID="lblField5" runat="server" />
                                                    <asp:Label ID="lblField6" runat="server" />
                                                    <asp:Label ID="lblField7" runat="server" />
                                                    <asp:Label ID="lblField8" runat="server" />
                                                    <asp:Label ID="lblField9" runat="server" />
                                                    <asp:Label ID="lblField10" runat="server" />
                                                    <asp:Label ID="lblField11" runat="server" />
                                                    <asp:Label ID="lblField12" runat="server" />
                                                    <asp:Label ID="lblField13" runat="server" />
                                                    <asp:Label ID="lblField14" runat="server" />
                                                    <asp:Label ID="lblField15" runat="server" />
                                                    <asp:Label ID="lblField16" runat="server" />
                                                    <asp:Label ID="lblField17" runat="server" />                                               
                                                   
	                                            
                                                </ul>
                                                </td>
                                            </tr>  
                                            
                                            <tr>
                                                <td valign="top" colspan="2"><asp:Label ID="lblViolationDescription_Summary" runat="server" /></td>
                                            </tr> 
                                            <tr>
                                                <td valign="top" colspan="2"><asp:Label ID="lblComments_Summary" runat="server" /></td>
                                            </tr> 
                                        </table>                                      

                                        </div>
                            </div>
                                   <%-- </ContentTemplate>
                                </asp:UpdatePanel>--%>
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
