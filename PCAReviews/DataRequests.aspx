<%@ Page Title="PCA Data and Sample Requests" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DataRequests.aspx.vb" Inherits="PCAReviews_DataRequests" EnableEventValidation="false" %>

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
    <script type="text/javascript">
        function OnSelectedChanged(sender, e) {
            if (sender.value == "All") {
                alert("All is not a valid value. Please select or enter a valid report period date");
            }
            else {
                $("#MainContent_txtReviewPeriodOther").addClass("hidden datepicker");
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<!--Navigation Menu-->
    <div>
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
<br />
    <asp:SqlDataSource ID="dsDataRequests" runat="server" SelectCommand="p_DataRequests"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="ReviewPeriod" />
     </SelectParameters>      
</asp:SqlDataSource>

 <asp:SqlDataSource ID="dsDataRequestsPending" runat="server" SelectCommand="p_DataRequestsPending"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">         
     <SelectParameters>
         <asp:Parameter Name="ReviewPeriod" />
     </SelectParameters>
</asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">      
</asp:SqlDataSource>

<asp:SqlDataSource ID="dsReviewPeriods" runat="server" SelectCommand="p_DataRequestsAllReportPeriods"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">      
</asp:SqlDataSource>

<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>
    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Data and Sample Requests</span>
  </div>
  <div class="panel-body"> 
                
     <h4>Data and Sample Requests In Progress</h4>
      <asp:GridView ID="GridView1" runat="server" DataSourceID="dsDataRequests" AllowSorting="true" AllowPaging="false" PageSize="22" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="DataRequestID">
     <EmptyDataTemplate>
         <span>Oops! <a href="DataRequests.aspx">Try again</a> by selecting another review period or select 'All' to see all review periods.</span>
     </EmptyDataTemplate>
         <Columns>
             
         <asp:BoundField DataField="DataRequestID" HeaderText="Data Request ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
             
         <asp:TemplateField SortExpression="ReviewPeriod" HeaderStyle-HorizontalAlign="Center" >
             <HeaderTemplate>
                 Report Period: 
                 <asp:DropDownList ID="ddlReviewPeriod" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSourceID="dsReviewPeriods" DataTextField="ReviewPeriod" DataValueField="ReviewPeriod" 
                     AutoPostBack="true" OnSelectedIndexChanged="ddlReviewPeriod_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value="All" />
                 </asp:DropDownList>
             </HeaderTemplate>
             <ItemTemplate>
                 <a href='DataRequestsPCA.aspx?PCA=<%# Server.UrlEncode(Eval("PCA"))%>'><%#Eval("PCA")%></a>
             </ItemTemplate>
         </asp:TemplateField>

         <asp:BoundField DataField="ReviewPeriod" HeaderText="Review Period" SortExpression="ReviewPeriod"
              HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="DataReceiptDate" HeaderText="Data Received Date" SortExpression="DataReceiptDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="SampleReceiptDate" HeaderText="Sample Request Date" SortExpression="SampleReceiptDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="CDReceiptDate" HeaderText="CD Receipt Date" SortExpression="CDReceiptDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
         
          <asp:BoundField DataField="Completed" HeaderText="Completed?" SortExpression="Completed"
              HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                         
         <asp:BoundField DataField="c_CallLength" HeaderText="Wrong Call Length" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="c_AccountType" HeaderText="Not ED Accounts" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="c_MissingCalls" HeaderText="Calls Missing from CD" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="c_CallDueDate" HeaderText="Missing Call Due Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="c_NotepadMatch" HeaderText="Recording Notepad Mismatch" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="c_BadRecording" HeaderText="Corrupted Recording" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:BoundField DataField="Comments" HeaderText="Comments" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info hidePrint" HeaderStyle-CssClass="hidePrint" ButtonType="Button" Text="Update" HeaderText="Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
     </Columns>
    </asp:GridView> 
      
     <h4>Data and Sample Requests Pending</h4>
      <asp:GridView ID="GridView2" runat="server" DataSourceID="dsDataRequestsPending" AllowSorting="true" AllowPaging="true" PageSize="22" OnRowCommand="GridView2_RowCommand"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="PCA">
     <EmptyDataTemplate>
         <span>No data requests are pending for the selected report period</span>
     </EmptyDataTemplate>
         <Columns>
              <asp:BoundField DataField="PCA" HeaderText="PCA" HeaderStyle-HorizontalAlign="Center" />
              <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info hidePrint" HeaderStyle-CssClass="hidePrint" ButtonType="Button" Text="New Request" HeaderText="" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="150px" />
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

            <!-- Update Modal -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Update Data Request</h4>
                  </div>

                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always"> 
                            <ContentTemplate>
                                <div class="container-fluid">
                                 <asp:Label ID="lblDataRequestID" runat="server" Visible="false" />   
                                <table width="95%" cellpadding="3" cellspacing="3">
                                    <tr>
                                        <td align="right"><label for="ddlPCAIDModal">PCA</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlPCAIDModal" runat="server" CssClass="inputBox" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCA" AppendDataBoundItems="true">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtReviewPeriod">Review Period</label></td>
                                        <td align="left"> <asp:DropDownList ID="ddlReviewPeriodModal" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSourceID="dsReviewPeriods" DataTextField="ReviewPeriod" DataValueField="ReviewPeriod">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtDataReceiptDate">Data Received Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtDataReceiptDate" runat="server" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtSampleReceiptDate">Sample Request Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtSampleReceiptDate" runat="server" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtCDReceiptDate">CD Receipt Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtCDReceiptDate" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="alert-caution">Please indicate how many calls on the CD matched the criteria below</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_CallLength">Wrong Call Length</label></td>
                                        <td><asp:DropDownList ID="ddlc_CallLength" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_AccountType">Not ED Accounts</label></td>
                                        <td><asp:DropDownList ID="ddlc_AccountType" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_MissingCalls">Missing Calls</label></td>
                                        <td><asp:DropDownList ID="ddlc_MissingCalls" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_CallDueDate">Missed Call Due Date</label></td>
                                        <td><asp:DropDownList ID="ddlc_CallDueDate" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_NotepadMatch">Recording Does Not Match Notepad</label></td>
                                        <td><asp:DropDownList ID="ddlc_NotepadMatch" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_BadRecording">Corrupted Recording</label></td>
                                        <td><asp:DropDownList ID="ddlc_BadRecording" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr> 
                                    <tr>
                                        <td align="right"><label for="ddlCompleted">Completed?</label></td>
                                        <td align="left"> 
                                            <asp:DropDownList ID="ddlCompleted" runat="server" CssClass="inputBox">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="No" Value="No" />
                                                <asp:ListItem Text="Yes" Value="Yes" />
                                            </asp:DropDownList></td>
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
                                <asp:Button ID="btnDeleteAssignment" runat="server" Text="Delete Data Request" CssClass="btn btn-warning" OnClick="btnDeleteAssignment_Click" OnClientClick="return confirm('Are you sure that you want to delete this data request?')" />
                            </ContentTemplate>                        
                    </asp:UpdatePanel> 
                  </div>
                </div>
              </div>
            </div>
            <!-- End Update Modal -->

            <!-- Insert New Modal -->
            <div class="modal fade" id="newRecordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel2">Add New Data Request</h4>
                  </div>

                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always"> 
                            <ContentTemplate>
                                <div class="container-fluid">
                                 <table width="95%" cellpadding="3" cellspacing="3">
                                    <tr>
                                        <td align="right"><label for="ddlPCAIDModal2">PCA</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlPCAIDModal2" runat="server" CssClass="inputBox" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCA" AppendDataBoundItems="true">
                                                <asp:ListItem Text="" Value="" />
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtReviewPeriod2">Review Period</label></td>
                                        <td align="left"> <asp:DropDownList ID="ddlReviewPeriodModal2" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSourceID="dsReviewPeriods" 
                                            DataTextField="ReviewPeriod" DataValueField="ReviewPeriod" onchange="javascript:OnSelectedChanged(this,event);">
                                                <asp:ListItem Text="" Value="" />                                                                                           
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtReviewPeriodOther" runat="server" CssClass="hidden datepicker" />

                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtDataReceiptDate2">Data Received Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtDataReceiptDate2" runat="server" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtSampleReceiptDate2">Sample Request Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtSampleReceiptDate2" runat="server" /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtCDReceiptDate2">CD Receipt Date</label></td>
                                        <td align="left"><asp:TextBox ID="txtCDReceiptDate2" runat="server" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="alert-caution">Please indicate how many calls on the CD matched the criteria below</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_CallLength2">Wrong Call Length</label></td>
                                        <td><asp:DropDownList ID="ddlc_CallLength2" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_AccountType2">Not ED Accounts</label></td>
                                        <td><asp:DropDownList ID="ddlc_AccountType2" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_MissingCalls2">Missing Calls</label></td>
                                        <td><asp:DropDownList ID="ddlc_MissingCalls2" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_CallDueDate2">Missed Call Due Date</label></td>
                                        <td><asp:DropDownList ID="ddlc_CallDueDate2" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_NotepadMatch2">Recording Does Not Match Notepad</label></td>
                                        <td><asp:DropDownList ID="ddlc_NotepadMatch2" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlc_BadRecording2">Corrupted Recording</label></td>
                                        <td><asp:DropDownList ID="ddlc_BadRecording2" runat="server" CssClass="inputBox">
                                            <asp:ListItem Text="" Value="" />
                                            <asp:ListItem Text="1" Value="1" />
                                            <asp:ListItem Text="2" Value="2" />
                                            <asp:ListItem Text="3" Value="3" />
                                            <asp:ListItem Text="4" Value="4" />
                                            <asp:ListItem Text="5" Value="5" />
                                            <asp:ListItem Text="6" Value="6" />
                                            <asp:ListItem Text="7" Value="7" />
                                            <asp:ListItem Text="8" Value="8" />
                                            <asp:ListItem Text="9" Value="9" />
                                            <asp:ListItem Text="10" Value="10" />
                                            <asp:ListItem Text="11" Value="11" />
                                            <asp:ListItem Text="12" Value="12" />
                                            <asp:ListItem Text="13" Value="13" />
                                            <asp:ListItem Text="14" Value="14" /> 
                                            <asp:ListItem Text="15" Value="15" />
                                            <asp:ListItem Text="16" Value="16" />
                                            <asp:ListItem Text="17" Value="17" />
                                            <asp:ListItem Text="18" Value="18" />
                                            <asp:ListItem Text="19" Value="19" />
                                            <asp:ListItem Text="20" Value="20" />
                                            <asp:ListItem Text="21" Value="21" />
                                            <asp:ListItem Text="22" Value="22" />
                                            <asp:ListItem Text="23" Value="23" />
                                            <asp:ListItem Text="24" Value="24" />
                                            <asp:ListItem Text="25" Value="25" />
                                            <asp:ListItem Text="26" Value="26" />
                                            <asp:ListItem Text="27" Value="27" />
                                            <asp:ListItem Text="28" Value="28" />
                                            <asp:ListItem Text="29" Value="29" />
                                            <asp:ListItem Text="30" Value="30" />
                                           </asp:DropDownList>                                      
                                        </td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="ddlCompleted2">Completed?</label></td>
                                        <td align="left"> 
                                            <asp:DropDownList ID="ddlCompleted2" runat="server" CssClass="inputBox">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="No" Value="No" Selected="True" />
                                                <asp:ListItem Text="Yes" Value="Yes" />
                                            </asp:DropDownList></td>
                                    </tr>
                                                                  
                                    <tr>
                                        <td align="right"><label for="txtComments2">Comments</label></td>
                                        <td align="left"><asp:TextBox ID="txtComments2" runat="server" TextMode="MultiLine" Rows="5" Columns="40" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center"><asp:Label ID="lblUpdateConfirm2" runat="server" CssClass="alert-danger" Visible="false" /></td>
                                    </tr>
                                </table>
                                </div>
                            </ContentTemplate>
                      <Triggers> 
                          <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" /> 
                          <asp:AsyncPostBackTrigger ControlID="GridView2" EventName="RowCommand" />                
                       </Triggers> 
                      </asp:UpdatePanel>
                  </div>
                  <div class="modal-footer">
                     <asp:UpdatePanel ID="UpdatePanel5" runat="server"> 
                            <ContentTemplate>                                
                                <asp:Button ID="btnSaveChanges2" runat="server" Text="Add New Request" CssClass="btn btn-primary" OnClick="btnAddRequest_Click" /> 
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>                               
                            </ContentTemplate>                          
                    </asp:UpdatePanel> 
                  </div>
                </div>
              </div>
            </div>
            <!-- End Add New Modal -->
    <asp:Label ID="lblPCAAdmin" runat="server" Visible="false" />   

     
</asp:Content>

