<%@ Page Title="PCA Rebuttal Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PCARebuttal.aspx.vb" Inherits="PCAReviews_Report_Summary" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" media="print" href="print.css" />
     <script type="text/javascript">
         $(document).ready(function () {
             $('.datepicker').datepicker()
         });
    </script>      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<!--Navigation Menu-->
<div class="hidden-print">
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">Save New PCA Review Old</a></li>
        <li><a href="Reports2.aspx">Save New PCA Review</a></li>
        <li><a href="Reports_SavedReports.aspx">Search PCA Reviews</a></li>       
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
        <li><a href="QCCalc.aspx">QC Calculator</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p><br /></p>

<asp:SqlDataSource ID="dsReviews" runat="server" SelectCommand="p_Report_PCARebuttal"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
        <asp:Parameter Name="ReviewPeriodMonth" />
        <asp:Parameter Name="ReviewPeriodYear" />
    </SelectParameters>    
</asp:SqlDataSource>

<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Rebuttal Report</span>
  </div>
  <div class="panel-body">
  <table class="table">
        <tr>
            <td valign="top">
            <!--PCA--> 
            <label class="form-label">PCA:</label>       
             <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="1">
                 <asp:ListItem Text="" Value="" />
                 <asp:ListItem Value="1" Text="Account Control Technology"></asp:ListItem>
                 <asp:ListItem Value="26" Text="Action Financial Services"></asp:ListItem>
                 <asp:ListItem Value="2" Text="Allied Interstate"></asp:ListItem>
                 <asp:ListItem Value="27" Text="Bass and Associates"></asp:ListItem>
                 <asp:ListItem Value="3" Text="CBE Group"></asp:ListItem>
                 <asp:ListItem Value="25" Text="Central Credit Adjustments"></asp:ListItem>
                 <asp:ListItem Value="24" Text="Central Research"></asp:ListItem>
                 <asp:ListItem Value="4" Text="Coast Professional"></asp:ListItem>
                 <asp:ListItem Value="5" Text="Collection Technology"></asp:ListItem>
                 <asp:ListItem Value="6" Text="ConServe"></asp:ListItem>
                 <asp:ListItem Value="7" Text="Delta Management Associates"></asp:ListItem>
                 <asp:ListItem Value="8" Text="Performant (DCS)"></asp:ListItem>
                 <asp:ListItem Value="9" Text="Enterprise Recovery Systems"></asp:ListItem>
                 <asp:ListItem Value="10" Text="EOS-Collecto"></asp:ListItem>
                 <asp:ListItem Value="11" Text="FAMS"></asp:ListItem>
                 <asp:ListItem Value="28" Text="FH Cann"></asp:ListItem>
                 <asp:ListItem Value="12" Text="FMS"></asp:ListItem>
                 <asp:ListItem Value="13" Text="GC Services"></asp:ListItem>
                 <asp:ListItem Value="21" Text="GRSI (West)"></asp:ListItem>
                 <asp:ListItem Value="14" Text="Immediate Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="29" Text="National Credit Services"></asp:ListItem>
                 <asp:ListItem Value="15" Text="National Recoveries"></asp:ListItem>
                 <asp:ListItem Value="16" Text="Transworld Systems (NCO)"></asp:ListItem>
                 <asp:ListItem Value="17" Text="Pioneer Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="18" Text="Premiere Credit of North America"></asp:ListItem>
                 <asp:ListItem Value="30" Text="Professional Bur of Coll MD"></asp:ListItem>
                 <asp:ListItem Value="19" Text="Progressive Financial Services"></asp:ListItem>
                 <asp:ListItem Value="31" Text="Reliant Capital Solutions"></asp:ListItem>
                 <asp:ListItem Value="23" Text="Treasury"></asp:ListItem>
                 <asp:ListItem Value="20" Text="Van Ru Credit Corp"></asp:ListItem>                 
                 <asp:ListItem Value="22" Text="Windham Professionals"></asp:ListItem>                                 
             </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPCAID" ErrorMessage="* Select a PCA *" CssClass="alert-danger" Display="Dynamic" />
            </td>
            <td valign="top">
            <label class="form-label">Review Period Month:</label>
            <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" TabIndex="4" CssClass="inputBox">
                            <asp:ListItem Text="" Value="" />        
                            <asp:ListItem Text="01" Value="01" />
                            <asp:ListItem Text="02" Value="02" />
                            <asp:ListItem Text="03" Value="03" />
                            <asp:ListItem Text="04" Value="04" />
                            <asp:ListItem Text="05" Value="05" />
                            <asp:ListItem Text="06" Value="06" />
                            <asp:ListItem Text="07" Value="07" />
                            <asp:ListItem Text="08" Value="08" />
                            <asp:ListItem Text="09" Value="09" />
                            <asp:ListItem Text="10" Value="10" />
                            <asp:ListItem Text="11" Value="11" />
                            <asp:ListItem Text="12" Value="12" />
                       </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlReviewPeriodMonth" ErrorMessage="* Select a Review Period Month *" CssClass="alert-danger" Display="Dynamic" /></td>
            <td valign="top">
            <label class="form-label">Review Period Year:</label>
            <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" TabIndex="5" CssClass="inputBox">
                        <asp:ListItem Text="" Value="" />    
                        <asp:ListItem Text="2015" Value="2015" />
                        <asp:ListItem Text="2016" Value="2016" />
                        <asp:ListItem Text="2017" Value="2017" />
                       </asp:DropDownList><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlReviewPeriodYear" ErrorMessage="* Select a Review Period Year *" CssClass="alert-danger" Display="Dynamic" /></td>
          </tr>     
        
</table>

  <asp:GridView ID="GridView1" runat="server" DataSourceID="dsReviews" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ReviewID" OnRowCommand="GridView1_RowCommand">
        <Columns>            
            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ReviewID", "ReviewDetail.aspx?ReviewID={0}")%>'
                        Text='<%# Eval("ReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Review Period" HeaderText="Review Period" SortExpression="Review Period" HeaderStyle-HorizontalAlign="Center" />           
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="CallDate" HeaderText="Call Date" SortExpression="CallDate" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" DataFormatString="{0:d}" />
            <asp:BoundField DataField="CallLengthActual" HeaderText="Call Length" SortExpression="CallLengthActual" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />            
            <asp:BoundField DataField="BorrowerLastName" HeaderText="Borrower Last Name" HeaderStyle-HorizontalAlign="Center" SortExpression="BorrowerLastName" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="InOutbound" HeaderText="In/Outbound" SortExpression="InOutbound" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="CallType" HeaderText="Call Type" SortExpression="CallType" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Error Type" HeaderText="Error Type" SortExpression="Error Type" HeaderStyle-HorizontalAlign="Center" />  
            <asp:BoundField DataField="FSA_Comments" HeaderText="FSA Comments" SortExpression="FSA_Comments" HeaderStyle-HorizontalAlign="Center" />
            <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info hidePrint" HeaderStyle-CssClass="hidePrint" ButtonType="Button" Text="Update" HeaderText="Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" /> 
            <asp:BoundField DataField="PCAAgree" HeaderText="PCA Agrees With Error" SortExpression="PCAAgree" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />  
            <asp:BoundField DataField="PCAResponseToError" HeaderText="PCA Response To Error" SortExpression="PCAResponseToError" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />  
            <asp:BoundField DataField="PCAAddtlRecordingProvided" HeaderText="PCA Provided Addtl Recording" SortExpression="PCAAddtlRecordingProvided" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />            
            <asp:BoundField DataField="PCACorrectiveTaken" HeaderText="Date PCA Took Corrective Action" SortExpression="PCACorrectiveTaken" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />            
            <asp:BoundField DataField="PCACorrectiveDate" HeaderText="PCA Took Corrective Action" SortExpression="PCACorrectiveDate" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" DataFormatString="{0:d}" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />            
            <asp:BoundField DataField="FSAFinalDecision" HeaderText="FSA Final Decision to Rescind/Uphold" SortExpression="FSAFinalDecision" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="FSA_Conclusions" HeaderText="FSA Conclusions" SortExpression="FSA_Conclusions" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="FSACorrectiveAnalysis" HeaderText="FSA Analysis of Corrective Action" SortExpression="FSACorrectiveAnalysis" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="FSAFinalComments" HeaderText="FSA Final Comments" SortExpression="FSAFinalComments" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="DateFinalUpdates" HeaderText="Date Final Updates made to FSA Bus Ops" SortExpression="DateFinalUpdates" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" DataFormatString="{0:d}" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />            
            <asp:BoundField DataField="FSACorrectiveActions" HeaderText="Corrective actions taken by FSA" SortExpression="FSACorrectiveActions" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
    </Columns>
    </asp:GridView>
</div>

</div>
</ContentTemplate>
</asp:UpdatePanel>

<div>
    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" /> 
    <asp:Button ID="btnExportExcel" runat="server" Text="Export Records to Excel" CssClass="btn btn-md btn-info" OnClick="btnExcelExport_Click" Visible="false" />
</div>
<p />
     <asp:UpdateProgress ID="UpdateProgress1" runat="server"> 
        <ProgressTemplate> <br /> 
            <img src="loading.gif" alt="Loading.. Please wait!"/> 
        </ProgressTemplate>
    </asp:UpdateProgress>

    <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Update PCA Rebuttal</h4>
                  </div>
                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
                            <ContentTemplate>
                                <div class="container-fluid">
                                 <strong>Review ID:</strong> <asp:Label ID="lblReviewID" runat="server" /><br />
                                 <strong>Error Type:</strong> <asp:Label ID="lblError_Type" runat="server" /><br /><br />     
                                 <table width="95%" cellpadding="3" cellspacing="3">
                                    <tr>
                                        <td align="right"><label for="ddlPCAAgree">PCA Agrees With Error?</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlPCAAgree" runat="server" CssClass="inputBox">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="No" Value="No" />
                                                <asp:ListItem Text="Yes" Value="Yes" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtPCAResponseToError">PCA Response To Error</label></td>
                                        <td align="left"><asp:TextBox ID="txtPCAResponseToError" runat="server" TextMode="MultiLine" Rows="5" Columns="40" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="ddlPCAAddtlRecordingProvided">PCA Provided Addtnl Recording?</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlPCAAddtlRecordingProvided" runat="server" CssClass="inputBox">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="No" Value="No" />
                                                <asp:ListItem Text="Yes" Value="Yes" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="ddlPCACorrectiveTaken">PCA Took Corrective Action?</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlPCACorrectiveTaken" runat="server" CssClass="inputBox">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="No" Value="No" />
                                                <asp:ListItem Text="Yes" Value="Yes" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtPCACorrectiveDate">PCA Date of Corrective Action</label></td>
                                        <td align="left"><asp:TextBox ID="txtPCACorrectiveDate" runat="server" Placeholder="mm/dd/yyyy" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtFSAFinalDecision">FSA Final Decision</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlFSAFinalDecision" runat="server" CssClass="inputBox">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="Rescind" Value="Rescind" />
                                                <asp:ListItem Text="Uphold" Value="Uphold" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtFSACorrectiveAnalysis">FSA Analysis of Corrective Action</label></td>
                                        <td align="left"><asp:TextBox ID="txtFSACorrectiveAnalysis" runat="server" TextMode="MultiLine" Rows="5" Columns="40" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtFSAFinalComments">FSA Final Comments</label></td>
                                        <td align="left"><asp:TextBox ID="txtFSAFinalComments" runat="server" TextMode="MultiLine" Rows="5" Columns="40" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtDateFinalUpdates">Date Final Updates made to FSA Bus Ops</label></td>
                                        <td align="left"><asp:TextBox ID="txtDateFinalUpdates" runat="server" Placeholder="mm/dd/yyyy" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtFSACorrectiveActions">FSA Corrective Actions</label></td>
                                        <td align="left"><asp:TextBox ID="txtFSACorrectiveActions" runat="server" TextMode="MultiLine" Rows="5" Columns="40" /></td>
                                    </tr>
                                   
                                    <tr>
                                        <td colspan="2" align="center"><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-danger" Visible="false" /></td>
                                    </tr>

                                </table>
                                </div>
                            </ContentTemplate>
                      <Triggers> 
                          <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />                           
                       </Triggers> 
                      </asp:UpdatePanel>
                  </div>
                  <div class="modal-footer">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server"> 
                            <ContentTemplate>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSaveChanges_Click" />
                            </ContentTemplate>
                    </asp:UpdatePanel> 
                  </div>
                </div>
              </div>
            </div>
     <!-- End Modal -->
    <asp:Label ID="lblTest" runat="server" />
</asp:Content>