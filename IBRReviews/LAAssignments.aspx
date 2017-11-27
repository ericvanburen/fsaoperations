<%@ Page Title="Loan Analyst Assignments" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="LAAssignments.aspx.vb" Inherits="IBRReviews_LAAssignments" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/print.css" media="print" rel="stylesheet" />
    
    <style type="text/css">
        /* increase modal size*/
        .modal-dialog   {
            width: 650px;
        }
    </style>
     <script type="text/javascript">
         $(document).ready(function () {
             $('#NavigationMenu').addClass('active');
         });
      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
 <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">My IBR Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="EnterNewReview.aspx">Enter New Review</a></li>
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyAssignments.aspx">My Assignments</a></li>       
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">Search Reviews</a></li>      
    </ul>
  </li> 

  <li class="dropdown active">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="ErrorReport.aspx">Error Report</a></li>
        <li><a href="MakeAssignments.aspx">Make Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>      
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

 <asp:SqlDataSource ID="dsLAAssignments" runat="server" SelectCommand="p_LAAssignments"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="UserID" />
     </SelectParameters>      
</asp:SqlDataSource>

<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>
    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Loan Analyst IBR Assignments</span>
  </div>
  <div class="panel-body"> 
                
   <asp:GridView ID="GridView1" runat="server" DataSourceID="dsLAAssignments" AllowSorting="true" AllowPaging="true" PageSize="10" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="NewAssignmentID">     
              <Columns>
         <asp:TemplateField HeaderText=" ">
             <ItemTemplate>
                 <asp:HyperLink ID="HyperLink1" runat="server" CssClass="hidePrint" />
             </ItemTemplate>
         </asp:TemplateField>
         
         <asp:TemplateField SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" >
             <HeaderTemplate>
                 Analyst
                 <asp:DropDownList ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSource='<%# GetRoleUsers() %>' 
                     AutoPostBack="true" OnSelectedIndexChanged="ddlUserID_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value="All" />
                 </asp:DropDownList>
             </HeaderTemplate>
             <ItemTemplate>
                 <%#Eval("UserID")%>
             </ItemTemplate>
         </asp:TemplateField>

         <asp:BoundField DataField="UserID" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />         
         <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="PCA" HeaderText="PCA"
             HeaderStyle-HorizontalAlign="Center" SortExpression="PCA" ReadOnly="true" />
         <asp:BoundField DataField="PCAID" HeaderText="PCA" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="ReportQuarter" HeaderText="ReportQuarter" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="ReportYear" HeaderText="ReportYear" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="RecordingDeliveryDate" HeaderText="Recording Delivery Date" SortExpression="RecordingDeliveryDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />         
         <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />                           
         <asp:BoundField DataField="NewAssignmentID" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" HeaderText="AssignmentID" />
         <asp:BoundField DataField="WorksheetPCADate" HeaderText="Date Worksheet Completed By LA" SortExpression="WorksheetPCADate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="QCWorksheetDate" HeaderText="Date Worksheet Approved" SortExpression="QCWorksheetDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="FinalPCADate" HeaderText="Final Report Completed By LA" SortExpression="FinalPCADate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="QCFinalDate" HeaderText="Date Final Report Approved" SortExpression="QCFinalDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
         <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info hidePrint" HeaderStyle-CssClass="hidePrint" ButtonType="Button" Text="Update" HeaderText="Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
     </Columns>
    </asp:GridView>

   </div>
  </div>
</ContentTemplate>
</asp:UpdatePanel>

<asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" Text="Export Results to Excel" OnClick="btnExportExcel_Click" />
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
                    <h4 class="modal-title" id="myModalLabel">Update Review</h4>
                  </div>
                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
                            <ContentTemplate>
                                <div class="container-fluid">
                                 <asp:Label ID="lblNewAssignmentID" runat="server" Visible="false" />   
                                <table width="95%" cellpadding="3" cellspacing="3">
                                    <tr>
                                        <td colspan="2"><h4><asp:Label ID="lblPCA2" runat="server" /> Review</h4></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlUserIDModal">Loan Analyst</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlUserIDModal" runat="server" CssClass="inputBox" AppendDataBoundItems="true">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtReviewDate">Review Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtReviewDate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtRecordingDeliveryDate">Recording Delivery Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtRecordingDeliveryDate" runat="server" /></td>
                                    </tr>
                                    
                                    <tr>
                                        <td align="right"><label for="txtDateAssigned">Date Assigned</label></td>
                                        <td align="left"><asp:TextBox ID="txtDateAssigned" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtDueDate">Due Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtDueDate" runat="server" /></td>
                                    </tr>
                                    
                                    <tr>
                                        <td align="right"><label for="ddlReportQuarter">Review Quarter/Year</label></td>
                                        <td><asp:DropDownList ID="ddlReportQuarter" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1 (Oct, Nov, Dec)" Value="1" />
                                            <asp:ListItem Text="2 (Jan, Feb, Mar)" Value="2" />
                                            <asp:ListItem Text="3 (Apr, May, Jun)" Value="3" />
                                            <asp:ListItem Text="4 (Jul, Aug, Sep)" Value="4" />                    
                                           </asp:DropDownList>
                                        <asp:DropDownList ID="ddlReportYear" runat="server" CssClass="inputBox">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="2018" Value="2018" />  
                                                <asp:ListItem Text="2017" Value="2017" /> 
                                                <asp:ListItem Text="2016" Value="2016" /> 
                                                <asp:ListItem Text="2015" Value="2015" />
                                                <asp:ListItem Text="2014" Value="2014" />
                                        </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtWorksheetPCADate">Date Worksheet Completed By LA</label></td>
                                        <td align="left"><asp:TextBox ID="txtWorksheetPCADate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtQCWorksheetDate">Date Worksheet Approved</label></td>
                                        <td align="left"><asp:TextBox ID="txtQCWorksheetDate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtFinalPCADate">Final Report Completed By LA</label> </td>
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
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server"> 
                            <ContentTemplate>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSaveChanges_Click" />
                                <asp:Button ID="btnDeleteAssignment" runat="server" Text="Delete Assignment" CssClass="btn btn-warning" OnClick="btnDeleteAssignment_Click" OnClientClick="return confirm('Are you sure that you want to delete this assignment?')" />
                            </ContentTemplate>
                    </asp:UpdatePanel> 
                  </div>
                </div>
              </div>
            </div>
            <!-- End Modal -->
    <asp:Label ID="lblPCAAdmin" runat="server" Visible="false" />

<asp:SqlDataSource ID="dsIBRReviews" runat="server" SelectCommand="p_LAIBRReviewsAssigned" OnSelected="OnSelectedHandlerIBRReviews"
    SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>">
        <SelectParameters>
            <asp:Parameter Name="NewAssignmentID" Type="Int32" />
        </SelectParameters>
 </asp:SqlDataSource>  
       
<div class="panel panel-primary">
    <div class="panel-heading">
        <span class="panel-title"><asp:Label ID="lblUserID" runat="server" /><asp:Label ID="lblPCA" runat="server" /></span>
    </div>
  <div class="panel-body">
   <asp:Label ID="lblCallCountIBRReviews" runat="server" CssClass="text-info" />
    <asp:GridView ID="grdIBRReviews" runat="server" DataSourceID="dsIBRReviews" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="IBRReviewID">
        <EmptyDataTemplate>
            No IBR reviews have been submitted for this PCA
        </EmptyDataTemplate>
        <Columns>            
            <asp:TemplateField HeaderText="IBR Review ID" SortExpression="IBRReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("IBRReviewID", "IBRReviewDetail.aspx?IBRReviewID={0}")%>'
                        Text='<%# Eval("IBRReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>                       
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />                              
        </Columns>
    </asp:GridView> 
  </div>
</div>
</asp:Content>

