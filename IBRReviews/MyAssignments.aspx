<%@ Page Title="My IBR Assignments" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyAssignments.aspx.vb" Inherits="IBRReviews_MyAssignments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
     <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>  
    <script src="../Scripts/jquery.checkAvailabilityIBR.js" type="text/javascript"></script>  
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
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
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
 <li class="dropdown active">
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

  <li class="dropdown">
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
<asp:SqlDataSource ID="dsMyAssignments" runat="server" SelectCommand="p_MyAssignments"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>">
    <SelectParameters>        
        <asp:Parameter Name="UserID" Type="String" />
    </SelectParameters>
 </asp:SqlDataSource>

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
    SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>" />

 <asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
        <ContentTemplate>

            <div class="panel panel-primary">
              <div class="panel-heading">
                <span class="panel-title">IBR Reviews Assigned to Me</span>
              </div>
                <div class="panel-body">
                   <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMyAssignments" AllowSorting="true" 
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
                            
                            <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate"
                                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="PCA" HeaderText="PCA" 
                                HeaderStyle-HorizontalAlign="Center" SortExpression="PCA" ReadOnly="true" />
                            <asp:BoundField DataField="PCAID" HeaderText="PCA" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
                            <asp:BoundField DataField="ReportQuarter" HeaderText="ReportQuarter" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
                            <asp:BoundField DataField="ReportYear" HeaderText="ReportYear" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
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

