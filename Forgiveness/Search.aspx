<%@ Page Title="Search Claims" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.vb" Inherits="Unconsolidation_AddRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
        <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
        <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
        <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>      
        <script src="Scripts/menu.js" type="text/javascript"></script>       
        <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
        <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />

         <style type="text/css">
    .resolutionBox {
        display: none;
        margin-bottom: 10px;
    }  
    
    .resolutionBox a:link {
        color: #555555; 
    }  

    .resolutionBox a:visited {
        color: #555555; 
    }

    .resolutionDDL {
        margin-bottom: 3px;
    }

    .fieldTitle 
    {
        font-size: 11pt; 
        text-align:left; 
        font-family: Calibri;      
    }

    .fieldTitle  a:link
    {
        color: #555555; 
    }

    .fieldTitle  a:visited
    {
        color: #555555; 
    }
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

<fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                         
                        <div id="tabs">
                           
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
                                <ul id="nav">
                                     <li><a href="MyClaims.aspx">My Claims</a></li>                                   
                                     <li><a href="Search.aspx">Search Claims</a></li>
                                     <li><a href="AddClaim.aspx">Add New Claim</a></li>
                                </ul>
                            </div>
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Servicers-->
                                <asp:SqlDataSource ID="dsServicers" runat="server" ConnectionString="<%$ ConnectionStrings:ForgivenessConnectionString %>"
                                    SelectCommand="p_ServicersAll" SelectCommandType="StoredProcedure" />
                               
                                 <div align="left" style="padding-top: 10px" id="tabs-1">
                                     <%--<asp:UpdatePanel id="pnlupdate1" runat="server">
                                        <ContentTemplate>--%>
                                          <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <span class="panel-title">FORGIVENESS PROCESSING - Search Claims</span>
                                            </div>
                                            <div class="panel-body">    
                                            <table width="100%" cellpadding="2" cellspacing="2" border="0" class="table">                                            
                                                <tr>                                                    
                                                <td width="25%"><strong>Claim ID:</strong><br />
                                                    <asp:TextBox id="txtClaimID" runat="server" TabIndex="1" /></td>                                                
                                                
                                                <td width="25%"><strong>Borrower Name:</strong><br />
                                                    <asp:Textbox ID="txtBorrower_Name" runat="server" TabIndex="2" />                                                   
                                                </td>
                                                <td width="25%">
                                                    <strong>Last 4 of Account:</strong><br />
                                                    <asp:TextBox ID="txtAccount" runat="server" TabIndex="3" />                                                    
                                                </td>
                                                <td width="25%">
                                                    <strong>Loan Servicer:</strong><br />
                                                    <asp:ListBox ID="ddlServicerID" runat="server" TabIndex="4" DataSourceID="dsServicers" SelectionMode="multiple" 
                                                        AppendDataBoundItems="true" DataTextField="Servicer" 
                                                        DataValueField="ServicerID">
                                                        <asp:ListItem Text="" Value="" />
                                                     </asp:ListBox>
                                                </td>                                               
                                            </tr>
                                            <tr>
                                                 <td width="25%" valign="top"><strong>Submitted By</strong><br />
                                                    <asp:ListBox ID="ddlSubmittedBy" runat="server" TabIndex="16" AppendDataBoundItems="true" SelectionMode="multiple">  
                                                        <asp:ListItem Text="" Value="" />                                                     
                                                    </asp:ListBox></td>
                                                
                                                <td width="25%" valign="top"><strong>Assigned To</strong><br />
                                                    <asp:ListBox ID="ddlUserID" runat="server" TabIndex="16" AppendDataBoundItems="true" SelectionMode="multiple">  
                                                        <asp:ListItem Text="" Value="" />                                                     
                                                    </asp:ListBox></td>

                                                 <td width="25%">
                                                    <strong>Date Received By FSA:</strong><br />
                                                    <asp:TextBox ID="txtDate_ReceivedBegin" runat="server" TabIndex="5" placeholder="mm/dd/yyyy"  /> (from) <br />
                                                    <asp:TextBox ID="txtDate_ReceivedEnd" runat="server" TabIndex="6" placeholder="mm/dd/yyyy"  /> (to)
                                                </td>

                                                  <td width="25%" valign="top"><strong>Status:</strong> <br />
                                                    <asp:DropDownList ID="ddlFSA_Approved" runat="server" Height="25px" TabIndex="7">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="Approved" Value="Approved" />
                                                        <asp:ListItem Text="Denied" Value="Denied" />
                                                        <asp:ListItem Text="Pending" Value="Pending" />
                                                        <asp:ListItem Text="Pre-Forgiveness Reporting" Value="Pre-Forgiveness Reporting" />
                                                    </asp:DropDownList>
                                                </td>                                                                                                
                                            </tr>

                                            <tr>
                                                <td width="25%" valign="top"><strong>Decision Date:</strong><br />
                                                    <asp:TextBox ID="txtDecision_DateBegin" runat="server" TabIndex="8" placeholder="mm/dd/yyyy" /> (from) <br/ />
                                                    <asp:TextBox ID="txtDecision_DateEnd" runat="server" TabIndex="9" placeholder="mm/dd/yyyy" /> (to)
                                                </td>
                                                
                                              <td width="25%" valign="top"><strong>Claim Type:</strong><br />
                                                    <asp:ListBox ID="ddlClaim_Type" runat="server" TabIndex="11" SelectionMode="multiple">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="IDR" Value="IDR" />
                                                        <asp:ListItem Text="PSLF" Value="PSLF" />                                                        
                                                        <asp:ListItem Text="TEACH" Value="TEACH" />
                                                    </asp:ListBox>
                                                </td>
                                                <td width="25%" valign="top"><strong>PSLF/TEACH Decision Type:</strong><br />
                                                    <asp:ListBox ID="ddlApproval_Type" runat="server" TabIndex="12" SelectionMode="multiple">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="PSLF - Forgiveness" Value="PSLF - Forgiveness" />
                                                        <asp:ListItem Text="PSLF - Qualifying Payment Counts" Value="PSLF - Qualifying Payment Counts" />
                                                        <asp:ListItem Text="PSLF - Qualifying Employment" value="PSLF - Qualifying Employment" />
                                                        <asp:ListItem Text="TEACH - Service Credit" value="TEACH - Service Credit" />
                                                        <asp:ListItem Text="TEACH - Reinstate" value="TEACH - Reinstate" />
                                                    </asp:ListBox>
                                                </td>
                                                <td width="25%" valign="top"><strong>Category Type For IDR:</strong><br />
                                                    <asp:ListBox ID="ddlCategory_Program_Type_IDR" runat="server" TabIndex="13" SelectionMode="multiple">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="IBR" Value="IBR" />  
                                                        <asp:ListItem Text="IDR" Value="IDR" />                                                                                                              
                                                        <asp:ListItem Text="PAYE" Value="PAYE" />
                                                        <asp:ListItem Text="REPAYE" Value="REPAYE" />
                                                    </asp:ListBox>
                                                </td>
                                             </tr>
                                            <tr>
                                                 
                                                <td width="25%" valign="top"><strong>Escalated?</strong><br />
                                                    <asp:CheckBox ID="chkEscalated" runat="server" TabIndex="14" />
                                                
                                                <td width="25%" valign="top"><strong>Selected For QA?</strong><br />
                                                    <asp:CheckBox ID="chkQA_Account" runat="server" TabIndex="15" /></td>
                                                <td width="25%" valign="top"><strong>QA Analyst</strong><br />
                                                    <asp:DropDownList ID="ddlQA_Analyst" runat="server" Height="25px" TabIndex="16" AppendDataBoundItems="true">  
                                                        <asp:ListItem Text="" Value="" />                                                     
                                                    </asp:DropDownList></td>
                                                <td width="25%" valign="top"> </td>
                                            </tr>
                                            <tr>
                                                    <td colspan="4" align="center">
                                                        <button type="button" id="btnSearchClaim" class="btn btn-info" runat="server" OnServerClick="btnSearchClaim_Click" TabIndex="17">
                                                            <span class="glyphicon glyphicon-search"></span> Search
                                                        </button> 
                                                        <button type="button" id="btnSearchAgainClaim" class="btn btn-default" runat="server" visible="False" OnServerClick="btnSearchAgain_Click" TabIndex="18">
                                                            <span class="glyphicon glyphicon-arrow-up"></span> Search Again
                                                        </button>                                                       
                                                   </td>
                                            </tr>
                                           
                                         </table>
                                            </div>
                                          </div>                                     
                                         </div>                                   
                                       <%-- </ContentTemplate>
                                     </asp:UpdatePanel>  --%> 
                                    
                                   <!--Row Count Label and Export To Excel-->
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <br />
                                        <asp:label id="lblRowCount" runat="server" cssclass="bold" />
                                        <asp:button id="btnExportExcel" runat="server" cssclass="btn btn-sm btn-danger" style="padding-left: 10px;" text="Export Results to Excel" onclick="btnExportExcel_Click" visible="false" />
                                    </div>
                                </div>
                                <br />

                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="false" CssClass="table table-hover table-striped" 
                                                    DataKeyNames="ClaimID" OnPreRender="GridView1_PreRender">
                                                    <Columns>                   
                                                        <asp:TemplateField HeaderText="Claim ID" SortExpression="ClaimID">
                                                            <ItemTemplate>
                                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("ClaimID", "UpdateClaim.aspx?ClaimID={0}")%>'
                                                                Text='<%# Eval("ClaimID")%>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField> 
                                                        <asp:BoundField DataField="Date_Submitted" HeaderText="Date Submitted" DataFormatString="{0:d}" 
                                                            HtmlEncode="false" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="SubmittedBy" HeaderText="Submitted By" SortExpression="SubmittedBy" 
                                                        HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="UserID" HeaderText="Assigned To" SortExpression="UserID" 
                                                        HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Borrower_Name" HeaderText="Borrower Name" SortExpression="Borrower_Name" 
                                                        HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" 
                                                            HeaderStyle-HorizontalAlign="Center" />
                                                                                                                
                                                        <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer" 
                                                            HeaderStyle-HorizontalAlign="Center" />
                                                        
                                                        <asp:BoundField DataField="Date_Received" HeaderText="Date Received" DataFormatString="{0:d}" SortExpression="Date_Received"
                                                            HtmlEncode="false" />

                                                        <asp:BoundField DataField="FSA_Approved" HeaderText="Status" SortExpression="FSA_Approved" 
                                                            HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Decision_Date" HeaderText="Decision Date" SortExpression="Decision_Date" DataFormatString="{0:d}" HtmlEncode="false"  
                                                        HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Qualifying_Payments" HeaderText="Qualifying_Payments" SortExpression="Qualifying_Payments" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Claim_Type" HeaderText="Claim Type" SortExpression="Claim_Type" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        
                                                        <asp:BoundField DataField="Approval_Type" HeaderText="Approval Type" SortExpression="Approval_Type" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Category_Program_Type_IDR" HeaderText="Category Type For IDR" SortExpression="Category_Program_Type_IDR" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Outstanding_Principal" HeaderText="Outstanding Principal" SortExpression="Outstanding_Principal" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Outstanding_Interest" HeaderText="Outstanding Interest" SortExpression="Outstanding_Interest" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="QA_Account" HeaderText="Selected For QA?" SortExpression="QA_Account" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="QA_Analyst" HeaderText="QA Analyst" SortExpression="QA_Analyst" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Escalated" HeaderText="Escalated" SortExpression="Escalated" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="IDR_Forgiveness_Date" HeaderText="IDR/PSLF Forgiveness Date" SortExpression="IDR_Forgiveness_Date" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Resolution" HeaderText="Resolution"  
                                                        ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 

                                                        <asp:BoundField DataField="Comments" HeaderText="Comments"  
                                                        ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />  
                                                       
                                                    </Columns>
                                                </asp:GridView>   
                                </div>
                            </div>

                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
<asp:Label ID="lblUserID" runat="server" Visible="false" />
</asp:Content>

