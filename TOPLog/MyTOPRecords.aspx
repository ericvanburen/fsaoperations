<%@ Page Title="My TOP Records" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyTOPRecords.aspx.vb" Inherits="TOPLog_MyTOPRecords" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/print.css" media="print" rel="stylesheet" />    
    <script type="text/javascript">
        $(document).ready(function () {
            $('#myModal').style.height = document.documentElement.clientHeight * 0.9 + "px";
        });
   </script>

    <script type="text/javascript">
         $(document).ready(function () {
             $('#NavigationMenu').addClass('active');
        });
      </script>

    <style type="text/css">
        /* increase modal size*/
        .modal-dialog   {
            width: 750px;
        }

        .modal .modal-body {
            max-height: 600px;
            overflow-y: auto;
        }

        .chkErrors tr td label {
            font-size:12px;
            font-weight: normal;            
            margin-right:10px;
            padding-right:10px;          
        }       
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
   <!--Begin Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown active">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="MyTOPRecords.aspx">My TOP Reviews</a></li>
        <li><a href="Assign.aspx">Assign Myself New Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="Search.aspx">TOP Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Report_LACount.aspx">LA Review Counts</a></li>
        <li><a href="Report_PICLogErrors.aspx">PIC Log Errors</a></li>        
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A4" class="dropdown-toggle" data-toggle="dropdown">Administrator <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Upload.aspx">Upload New PIC Log</a></li>
        <li><a href="Reassign.aspx">Reassign Logs</a></li>
    </ul>
  </li>  
 </ul>
 </div><br />
<!--End Navigation Menu-->

<br />


<asp:UpdatePanel ID="UpdatePanel1" runat="server">     
<ContentTemplate>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">My TOP Records</span>
  </div>
        <div class="panel-body">
            
    Show TOP Records in Status: 
    <asp:DropDownList ID="ddlApprovalStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlApprovalStatus_SelectedIndexChanged">
       <asp:ListItem Text="All" Value="All" />
       <asp:ListItem Text="Completed" Value="Completed" />
       <asp:ListItem Text="Pending" Value="Pending" />
       <asp:ListItem Text="Received" Value="Received" Selected="True" />
       <asp:ListItem Text="Rejected" Value="Rejected" />
       <asp:ListItem Text="Revised" Value="Revised" /> 
    </asp:DropDownList>
<br /><br />
<asp:Label ID="lblRowCount" runat="server" CssClass="text-info" />
 <asp:GridView ID="GridView1" runat="server" AllowSorting="true" OnSorting="GridView1_Sorting" OnRowCommand="GridView1_RowCommand"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView" DataKeyNames="TOPLogID">
        <EmptyDataTemplate>
            No records found
        </EmptyDataTemplate>
        <Columns>
            <asp:ButtonField CommandName="detail" ItemStyle-Width="75px" ButtonType="Image" ControlStyle-Width="15px" ImageUrl="images/pencil.gif" HeaderText="Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="TOPLogID" HeaderText="TOP Log ID" SortExpression="TOPLogID"  />
            <asp:BoundField DataField="LogDate" HeaderText="Log Date" SortExpression="Log Date" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower Number" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Center" />           
            <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" HeaderStyle-HorizontalAlign="Center" />              
		    <asp:BoundField DataField="NewOffsetAmount" HeaderText="New Offset Amount" SortExpression="NewOffsetAmount" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:c}" HtmlEncode="false" />
            <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval Status" SortExpression="ApprovalStatus" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateApproved" HeaderText="Date Approved" SortExpression="DateApproved" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />
        </Columns>
</asp:GridView>
</div></div>
</ContentTemplate>
</asp:UpdatePanel>


<asp:Label ID="lblUserID" runat="server" Visible="false" />
<asp:Label ID="lblSortExpression" runat="server" Visible="false" />

 <!-- Modal -->

 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Update TOP Record</h4>
                  </div>
                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
                            <ContentTemplate>                      
                                <div class="container-fluid">                                   
                                <table width="95%" cellpadding="3" cellspacing="3">                                    
                                    <tr>
                                        <td colspan="2" align="center"><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-danger" Visible="false" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="lblIssueID">TOP Log ID</label></td>
                                        <td align="left" valign="top"><asp:Label ID="lblTOPLogID" runat="server" Text='<%# Eval("TOPLogID")%>' /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="lblDateAdded">Log Date</label></td>
                                        <td align="left" valign="top"><asp:Label ID="lblLogDate" runat="server" Text='<%# Eval("LogDate")%>' /></td>
                                    </tr>
                                     <tr>
                                        <td align="right"><label for="txtBorrowerNumber">Borrower Number</label></td>
                                        <td align="left"><asp:Label ID="lblBorrowerNumber" runat="server" Text='<%# Eval("BorrowerNumber")%>' /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlAction">Action</label></td>
                                        <td align="left"><asp:Label ID="lblActionModal" runat="server" Text='<%# Eval("Action")%>' /></td>
                                    </tr> 
                                    <tr>
                                        <td align="right" valign="top"><label for="cblErrors">Errors</label></td>
                                        <td align="left"><asp:CheckBoxList ID="cblErrors" runat="server" CssClass="chkErrors" RepeatColumns="1" CellPadding="2" CellSpacing="2" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlApprovalStatus">Approval Status</label></td>
                                        <td align="left"><asp:Label ID="lblApprovalStatusBeforeUpdate" runat="server" Visible="false" Text='<%# Eval("ApprovalStatus")%>' />
                                            <asp:DropDownList ID="ddlApprovalStatusModal" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("ApprovalStatus")%>' AutoPostBack="true">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="Completed" Value="Completed" />
                                                <asp:ListItem Text="Pending" Value="Pending" />
                                                <asp:ListItem Text="Received" Value="Received" />
                                                <asp:ListItem Text="Rejected" Value="Rejected" /> 
                                                <asp:ListItem Text="Revised" Value="Revised" />                                                                                             
                                            </asp:DropDownList></td>
                                    </tr>                                                                    
                                    <tr>
                                        <td align="right"><label for="txtNewOffsetAmount">New Offset Amount</label></td>
                                        <td align="left"><asp:Label ID="lblNewOffsetAmount" runat="server" CssClass="inputBox" Text='<%# Eval("NewOffsetAmount")%>' /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtFSAComments">FSA Comments</label></td>
                                        <td align="left"><asp:TextBox ID="txtFSAComments" runat="server" CssClass="inputBox" Text='<%# Eval("FSAComments")%>' TextMode="MultiLine" Rows="5" Columns="35" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtPICComments">PIC Comments</label></td>
                                        <td align="left"><asp:TextBox ID="txtPICComments" runat="server" CssClass="inputBox" Text='<%# Eval("PICComments")%>' TextMode="MultiLine" Rows="5" Columns="35" /></td>
                                    </tr>   
                                     <tr>
                                        <td colspan="2" align="left"><asp:Label ID="lblDateApproved" runat="server" Visible="false" Text='<%# Eval("DateApproved")%>' /></td>
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
</asp:Content>

