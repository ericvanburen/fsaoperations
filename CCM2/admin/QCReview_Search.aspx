<%@ Page Title="QC Review Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="QCReview_Search.aspx.vb" Inherits="CCM2_admin_QCReview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>
    <script src="../../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue; font-size: small">
        <ul id="nav">
            <li><a href="../Help.aspx">Help</a></li>
            <li><a href="#">Reports</a>
                <ul>
                    <li><a href="../MyProductivityReport.aspx">My Productivity</a></li>
                </ul>
            </li>
            <li><a href="../Search.aspx">Search</a></li>
            <li><a href="#">Administration</a>
                <ul>
                    <li><a href="ReportCallsMonitored.aspx">Call Center Count</a></li>
                    <li><a href="ReportFailedCalls.aspx">Failed Calls</a></li>
                    <li><a href="ReportAccuracy.aspx">Accuracy Report</a></li>
                    <li><a href="ReportIndividualProductivity.aspx">Productivity</a></li>
                    <li><a href="ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
                    <li><a href="Search.aspx">Search</a></li>
                    <li><a href="../ChecksSearch.aspx">Servicer Check Report</a></li>
                    <li><a href="QCReview_New.aspx">QC Review - Add</a></li>
                    <li><a href="QCReview_Search.aspx">QC Review - Search</a></li>
                </ul>
            </li>
            <li><a href="#">Monitoring</a>
                <ul>
                    <li><a href="../FormB.aspx">Enter Call</a></li>
                    <li><a href="../MyReviews.aspx">My Reviews</a></li>
                    <li><a href="../Checks.aspx">Add Servicer Check</a></li>
                </ul>
            </li>
        </ul>
    </div>


    <!--Users/Evaluators-->
    <asp:SqlDataSource ID="dsUserID" runat="server"
        ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
        SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />

    <!--Call Centers-->
    <asp:SqlDataSource ID="dsCallCenters" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
        SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />

    <div style="padding-top: 40px;">
  <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Quality Reviews Search</span>
  </div>  
    <div class="panel-body">
        <div align="left" style="padding-top: 10px">
            <table width="100%" cellpadding="4" cellspacing="5" border="0">
                <tr>        
                    <th class="tableColumnHead" colspan="1">Review ID</th>
                    <th class="tableColumnHead" colspan="1">Call Review Date</th>
                    <th class="tableColumnHead" colspan="1">QC Review Date</th>
                </tr>
                <tr>
                    <td width="33%" valign="top" class="text-center"><asp:TextBox ID="txtReviewID" runat="server" /></td>
                    <td width="33%" valign="top" class="text-center">
                       <asp:TextBox ID="txtDateofReview" runat="server" /> (>=)                                                            
                       <br /><br />
                       <asp:TextBox ID="txtDateofReviewLessThan" runat="server" /> (<=)                                                    
                     </td>
                    <td width="33%" valign="top" class="text-center">
                       <asp:TextBox ID="txtDateAdded" runat="server" /> (>=)                                                            
                       <br /><br />
                       <asp:TextBox ID="txtDateAddedLessThan" runat="server" /> (<=)                                                    
                     </td>
                </tr>
                <tr>        
                    <th class="tableColumnHead" colspan="1">Call Center</th>
                    <th class="tableColumnHead" colspan="1">Call Monitor</th>
                    <th class="tableColumnHead" colspan="1">QC Score</th>

                </tr>
                <tr>
                    <td width="33%" valign="top" class="text-center">
                        <asp:ListBox ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters" Rows="4"
                            AppendDataBoundItems="true" DataTextField="CallCenter" DataValueField="CallCenterID"
                            SelectionMode="Multiple">
                            <asp:ListItem Text="" Value="" />
                        </asp:ListBox>
                    </td>
                    <td width="33%" valign="top" class="text-center">
                        <asp:ListBox ID="ddlUserID" runat="server" Rows="4" AppendDataBoundItems="true" SelectionMode="Multiple">
                            <asp:ListItem Text="" Value="" />
                        </asp:ListBox></td>
                    <td width="33%" valign="top" class="text-center">
                       <asp:TextBox ID="txtQCScoreStart" runat="server" /> (>=)                                                            
                       <br /><br />
                       <asp:TextBox ID="txtQCScoreEnd" runat="server" /> (<=)
                    </td>
                    <td width="33%" valign="top" class="text-center"> </td>
                </tr>
                <tr>
                    <td colspan="3" align="center"><br />
                        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnSearchAgain" runat="server" CssClass="btn btn-warning" Text="New Search" OnClick="btnSearchAgain_Click" Visible="false" />
                        <asp:Button ID="btnExportExcel" runat="server" CausesValidation="false" OnClick="btnExportExcel_Click" CssClass="btn btn-success" Text="Export to Excel" Visible="false" />
                    </td>
                </tr>
            </table>
        </div>
     
        <hr />

        <asp:GridView ID="grdReviews" runat="server" AllowSorting="true" OnSorting="GridView1_Sorting"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="QCID">
         <Columns>            
            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ReviewID", "QCReview_Update.aspx?ReviewID={0}")%>'
                        Text='<%# Eval("ReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>                       
            
             <asp:BoundField DataField="Review Date" HeaderText="Review Date" SortExpression="Review Date"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />

             <asp:BoundField DataField="QC Review Date" HeaderText="QC Review Date" SortExpression="QC Review Date"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
             
             <asp:BoundField DataField="Call Monitor" HeaderText="Call Monitor" SortExpression="Call Monitor"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="QC Reviewer" HeaderText="QC Reviewer" SortExpression="QC Reviewer"
                HeaderStyle-HorizontalAlign="Center" />
                        
             <asp:BoundField DataField="Call Center" HeaderText="Call Center" SortExpression="Call Center"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Call Type" HeaderText="Specialty Line" SortExpression="Call Type"
                HeaderStyle-HorizontalAlign="Center" />
            
             <asp:BoundField DataField="Total QC Score" HeaderText="Total QC Score" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="Total QC Score" />             

             <asp:BoundField DataField="Score All Required QC Elements" HeaderText="Score All Required QC Elements" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score All Required QC Elements Comments" HeaderText="Score All Required QC Elements Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score  Identification/Greeting" HeaderText="Score  Identification/Greeting" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score  Identification/Greeting Comments" HeaderText="Score  Identification/Greeting Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score  Authentication/Demographics" HeaderText="Score  Authentication/Demographics" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score  Authentication/Demographics Comments" HeaderText="Score  Authentication/Demographics Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score Professionalism/Accuracy/Urgency" HeaderText="Score Professionalism/Accuracy/Urgency" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score Professionalism/Accuracy/Urgency Comments" HeaderText="Score Professionalism/Accuracy/Urgency Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score Method Resolution" HeaderText="Score Method Resolution" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score Method Resolution Comments" HeaderText="Score Method Resolution Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score Escalated" HeaderText="Score Escalated" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />          

             <asp:BoundField DataField="Score Escalated Comments" HeaderText="Score Escalated Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score Grammar" HeaderText="Score Grammar" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Score Grammar Comments" HeaderText="Score Grammar Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" 
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="Supervisor Comments" HeaderText="Supervisor Comments" 
                HeaderStyle-HorizontalAlign="Center" />
                  
        </Columns>
    </asp:GridView>
                                         
    </div>
  </div>
</div>
<asp:Label ID="lblSortExpression" runat="server" Visible="false" />
</asp:Content>

