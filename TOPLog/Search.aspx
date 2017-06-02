<%@ Page Title="TOP Log Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.vb" Inherits="TOPLog_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
   <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script> 
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
         $(document).ready(function () {
             $('#NavigationMenu').addClass('active');
        });
      </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker()

            //Intializes the tooltips  
            $('[data-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                'placement': 'top'
            });
            $('[data-toggle="popover"]').popover({
                trigger: 'hover',
                'placement': 'top'
            });
        });
      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
   <!--Begin Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="MyTOPRecords.aspx">My TOP Reviews</a></li>
        <li><a href="Assign.aspx">Assign Myself New Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
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

  <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Search TOP Logs</span>
  </div>
        <div class="panel-body">
            <table class="table">
                <tr>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="TOP Log ID" data-content="The unique ID number of the TOP record">TOP Log ID</a></th>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Assigned To" data-content="The Loan Analyst the record has been assiged to">Assigned To</a></th>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Approval Status" data-content="The approval status">Approval Status</a></th>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Action" data-content="The action recommended by the PIC team">Action</a></th>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The DMCS Borrower Number of the record">Borrower Number</a></th>
                </tr>                
                <tr>                    
                    <td class="tableColumnCell"><asp:TextBox ID="txtTOPLogID" runat="server" CssClass="inputBox" /></td>
                    <td class="tableColumnCell"><asp:ListBox ID="ddlUserID" runat="server" CssClass="inputBox" SelectionMode="Multiple" AppendDataBoundItems="true">
                                                    <asp:ListItem Text="No One" Value="No One" />                                        
                                                </asp:ListBox></td>
                    <td class="tableColumnCell"><asp:ListBox ID="ddlApprovalStatus" runat="server" CssClass="inputBox" SelectionMode="Multiple"> 
                                        <asp:ListItem Text="" Value="" />
                                        <asp:ListItem Text="Completed" Value="Completed" />
                                        <asp:ListItem Text="Pending" Value="Pending" />
                                        <asp:ListItem Text="Received" Value="Received" />
                                        <asp:ListItem Text="Rejected" Value="Rejected" /> 
                                        <asp:ListItem Text="Revised" Value="Revised" />                                      
                                     </asp:ListBox></td>
                    <td class="tableColumnCell"><asp:ListBox ID="ddlAction" runat="server" CssClass="inputBox" SelectionMode="Multiple"> 
                        <asp:ListItem Text="" Value="" />
                        <asp:ListItem Text="Stop SSA Payment Stream" Value="Stop SSA Payment Stream" />
                        <asp:ListItem Text="Delete SSA Reduction " Value="Delete SSA Reduction" />
                        <asp:ListItem Text="Restart SSA Payment" Value="Restart SSA Payment" />
                        <asp:ListItem Text="Restart and Reduce SSA Payment" Value="Restart and Reduce SSA Payment" />
                        <asp:ListItem Text="Reduce SSA Payment Stream" Value="Reduce SSA Payment Stream" />
                    </asp:ListBox></td>
                    <td class="tableColumnCell"><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" /></td>
                </tr>
                <tr>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Log Date" data-content="The actual log date that PIC assigned to a log">Log Date</a></th>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Added" data-content="The date that the PIC Log was uploaded to this application">Date Added</a></th>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Assigned" data-content="The date(s) the TOP record was assigned to a Loan Analyst">Date Assigned</a></th>
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Approved" data-content="The date(s) the TOP record was approved by a Loan Anlyst">Date Approved</a></th>                    
                    <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Include TOP Borrowers?" data-content="Check 'Yes' if you want to include any review errors in the search results. This will result in duplicate records per borrower">Include Errors?</a></th>
                </tr>
                <tr>                   
                    <td class="tableColumnCell">from<br /><asp:TextBox ID="txtLogDateGreaterThan" runat="server" CssClass="datepicker" />            
                    <br />to<br /><asp:TextBox ID="txtLogDateLessThan" runat="server" CssClass="datepicker" /></td>
                    <td class="tableColumnCell">from<br /><asp:TextBox ID="txtDateAddedGreaterThan" runat="server" CssClass="datepicker" />            
                    <br />to<br /><asp:TextBox ID="txtDateAddedLessThan" runat="server" CssClass="datepicker" /></td>
                    <td class="tableColumnCell">from<br /><asp:TextBox ID="txtDateAssignedGreaterThan" runat="server" CssClass="datepicker" />            
                    <br />to<br /><asp:TextBox ID="txtDateAssignedLessThan" runat="server" CssClass="datepicker" /></td>
                    <td class="tableColumnCell">from<br /><asp:TextBox ID="txtDateApprovedGreaterThan" runat="server" CssClass="datepicker" />            
                    <br />to<br /><asp:TextBox ID="txtDateApprovedLessThan" runat="server" CssClass="datepicker" /></td>
                    <td class="tableColumnCell"><asp:DropDownList ID="ddlIncludeErrors" runat="server">
                                                    <asp:ListItem Text="No" Value="No" Selected="True" />
                                                    <asp:ListItem Text="Yes" Value="Yes" />
                                                </asp:DropDownList></td>
                </tr>
                <tr>
                    <td colspan="5" align="center"><br />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnSearchAgain" runat="server" CssClass="btn btn-md btn-warning" Text="Search Again" Visible="true" OnClick="btnSearchAgain_Click" />            
                    </td>
                </tr>
            </table>
        </div>
         <!--Row Count Label and Export To Excel-->
 <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Label ID="lblRowCount" runat="server" CssClass="text-info" /> <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
        </div>            
</div>
<br />
    <asp:GridView ID="GridView1" runat="server" Width="98%" HorizontalAlign="Center"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="TOPLogID">
        <Columns>                   
            <asp:BoundField DataField="TOPLogID" HeaderText="TOP Log ID" SortExpression="TOPLogID" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="LogDate" HeaderText="Log Date" SortExpression="Log Date" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="DateAdded" HeaderText="Date Added" SortExpression="DateAdded" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="DateApproved" HeaderText="Date Approved" SortExpression="DateApproved" HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval Status" SortExpression="Approval Status" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />
            
            <asp:BoundField DataField="Action" HeaderText="Action" SortExpression="Action" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="NewOffsetAmount" HeaderText="New Offset Amount" SortExpression="NewOffsetAmount" DataFormatString="{0:c}" HtmlEncode="false" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"
                HeaderStyle-HorizontalAlign="Center" />           

            <asp:BoundField DataField="FSAComments" HeaderText="FSA Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
 
            <asp:BoundField DataField="PICComments" HeaderText="PIC Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 

            </Columns>
    </asp:GridView>
  </div>
<br />
</asp:Content>

