<%@ Page Title="My Claims" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyClaims.aspx.vb" Inherits="Unconsolidation_AddRequest" %>

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

    <asp:sqldatasource id="dsMyClaims" runat="server" selectcommand="p_MyClaims"
        selectcommandtype="StoredProcedure" connectionstring="<%$ ConnectionStrings:ForgivenessConnectionString %>" OnSelected="dsMyClaims_Selected">
        <SelectParameters>
              <asp:Parameter Name="UserID" Type="String" />
        </SelectParameters>
    </asp:sqldatasource>

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
                               
                                 <div align="left" style="padding-top: 10px" id="tabs-1">
                                     <%--<asp:UpdatePanel id="pnlupdate1" runat="server">
                                        <ContentTemplate>--%>
                                          <div class="panel panel-primary">
                                            <div class="panel-heading">
                                                <span class="panel-title">FORGIVENESS PROCESSING - My Claims</span>
                                            </div>
                                              <!--Row Count Label and Export To Excel-->
                                                <div class="row">
                                                    <div class="col-md-12" align="center">
                                                        <br />
                                                        <asp:label id="lblRowCount" runat="server" cssclass="bold" />
                                                        <asp:button id="btnExportExcel" runat="server" cssclass="btn btn-sm btn-danger" style="padding-left: 10px;" text="Export Claims to Excel" onclick="btnExportExcel_Click" visible="false" />
                                                    </div>
                                                </div>
                                              <br />
                                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-hover table-striped" 
                                                    DataKeyNames="ClaimID" OnPreRender="GridView1_PreRender" DataSourceID="dsMyClaims">
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

                                                        <asp:BoundField DataField="Assigned To" HeaderText="Assigned To" SortExpression="Assigned To" 
                                                        HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Borrower_Name" HeaderText="Borrower Name" SortExpression="Borrower_Name" 
                                                        HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Account" HeaderText="Account" SortExpression="Account" 
                                                            HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="AwardID" HeaderText="Award ID" SortExpression="AwardID" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="SequenceNumber" HeaderText="Sequence Number" SortExpression="SequenceNumber" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                                                                                
                                                        <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer" 
                                                            HeaderStyle-HorizontalAlign="Center" />
                                                        
                                                        <asp:BoundField DataField="Date_Received" HeaderText="Date Received" DataFormatString="{0:d}" SortExpression="Date_Received"
                                                            HtmlEncode="false" />

                                                        <asp:BoundField DataField="FSA_Approved" HeaderText="FSA Approved?" SortExpression="FSA_Approved" 
                                                            HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Decision_Date" HeaderText="Decision Date" SortExpression="Decision_Date" DataFormatString="{0:d}" HtmlEncode="false"  
                                                        HeaderStyle-HorizontalAlign="Center" />

                                                        <asp:BoundField DataField="Qualifying_Payments" HeaderText="Qualifying_Payments" SortExpression="Qualifying_Payments" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Claim_Type" HeaderText="Claim Type" SortExpression="Claim_Type" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
                                                        
                                                        <asp:BoundField DataField="Approval_Type" HeaderText="PSLF/TEACH Decision Type" SortExpression="Approval_Type" 
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

                                                        <asp:BoundField DataField="IDR_Forgiveness_Date" HeaderText="IDR Forgiveness Date" SortExpression="IDR_Forgiveness_Date" 
                                                        HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />

                                                        <asp:BoundField DataField="Resolution" HeaderText="Resolution"  
                                                        ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 

                                                        <asp:BoundField DataField="Comments" HeaderText="Comments"  
                                                        ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />  
                                                       
                                                    </Columns>
                                                </asp:GridView> 
                                          </div>                                     
                                 </div>                                   
                                       <%--</ContentTemplate>
                                     </asp:UpdatePanel>--%>
                                    
                             
                                </div>
                            </div>                    
                    </td>
                </tr>
            </table>
        </div>
</fieldset>
<asp:Label ID="lblUserID" runat="server" Visible="false" />
</asp:Content>

