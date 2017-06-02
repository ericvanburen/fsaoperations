<%@ Page Title="My New Assignments" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyNewAssignments.aspx.vb" Inherits="PCAReviews_MyNewAssignments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        /* increase modal size*/
        .modal-dialog   {
            width: 650px;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<!--Navigation Menu-->
    <div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown active">
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

  <li class="dropdown">
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
<br />

 <asp:SqlDataSource ID="dsMyNewAssignments" runat="server" SelectCommand="p_MyNewAssignments" 
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="UserID" Type="String" />
    </SelectParameters>    
 </asp:SqlDataSource>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
        <ContentTemplate>

            <div class="panel panel-primary">
              <div class="panel-heading">
                <span class="panel-title">PCA Assignments Assigned to Me</span>
              </div>
                <div class="panel-body">
                 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMyNewAssignments" AllowSorting="true" 
                        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="NewAssignmentID" OnRowCommand="GridView1_RowCommand">
                        <Columns>                
            
                            <asp:TemplateField HeaderText=" ">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink1" runat="server" />
                                </ItemTemplate> 
                            </asp:TemplateField> 
                            <asp:TemplateField HeaderText=" ">
                                <ItemTemplate>
                                    <asp:HyperLink ID="HyperLink2" runat="server" />
                                </ItemTemplate> 
                            </asp:TemplateField>                                
                            <asp:BoundField DataField="ReviewPeriod" HeaderText="Review Period" SortExpression="ReviewPeriod"
                                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="PCA" HeaderText="PCA" 
                                HeaderStyle-HorizontalAlign="Center" SortExpression="PCA" ReadOnly="true" />
                            <asp:BoundField DataField="PCAID" HeaderText="PCA" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
                            <asp:BoundField DataField="RecordingDeliveryDate" HeaderText="Recording Delivery Date" SortExpression="RecordingDeliveryDate"
                                 DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true"  ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="NewAssignmentID" HeaderText="" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />  
                            <asp:BoundField DataField="WorksheetPCADate" HeaderText="Date Worksheet Completed By LA" SortExpression="WorksheetPCADate"
                                 DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false"  ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="QCWorksheetDate" HeaderText="Date Worksheet Approved" SortExpression="QCWorksheetDate"
                                 DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false"  ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="FinalPCADate" HeaderText="Date Final Report Completed By LA" SortExpression="FinalPCADate"
                                 DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false"  ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="QCFinalDate" HeaderText="Date Final Report Approved" SortExpression="QCFinalDate"
                                 DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false"  ItemStyle-HorizontalAlign="Center" />            
                            <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info" ButtonType="Button" Text="Update" HeaderText="Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server"> 
        <ProgressTemplate> <br /> 
            <img src="loading.gif" alt="Loading.. Please wait!"/> 
        </ProgressTemplate>
    </asp:UpdateProgress>

<!-- Button trigger modal -->
<%--<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">Launch demo modal</button>--%>

            <!-- Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Update Review</h4>
                  </div>
                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
                            <ContentTemplate>
                                <div class="container-fluid">
                                 <asp:Label ID="lblNewAssignmentID" runat="server" Visible="false" />   
                                <table width="100%" cellpadding="3" cellspacing="3">
                                    <tr>
                                        <td colspan="2"><h4><asp:Label ID="lblPCA" runat="server" /></h4></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtWorksheetPCADate">Date Worksheet Completed By LA</label></td>
                                        <td align="left"><asp:TextBox ID="txtWorksheetPCADate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtQCQorksheetDate">Date Worksheet Approved</label></td>
                                        <td align="left"><asp:TextBox ID="txtQCWorksheetDate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtFinalPCADate">Date Final Report Completed By LA</label> </td>
                                        <td align="left"><asp:TextBox ID="txtFinalPCADate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtQCFinalDate">Date Final Report Approved</label></td>
                                        <td align="left"><asp:TextBox ID="txtQCFinalDate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtComments">Comments</label></td>
                                        <td align="left"><asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="5" Columns="40" /></td>
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
                    <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                    <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server"> 
                            <ContentTemplate>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" class="btn btn-primary" OnClick="btnSaveChanges_Click" />
                            </ContentTemplate>
                    </asp:UpdatePanel> 
                  </div>
                </div>
              </div>
            </div>
            <!-- End Modal -->
    <asp:Label ID="lblPCAAdmin" runat="server" Visible="false" />
</asp:Content>

