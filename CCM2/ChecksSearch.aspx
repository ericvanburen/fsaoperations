<%@ Page Title="Servicer Check Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ChecksSearch.aspx.vb" Inherits="CCM2_CheckSearch2" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
 <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/print.css" media="print" rel="stylesheet" />
    
    <style type="text/css">
        /* increase modal size*/
        .modal-dialog   {
            width: 650px;
        }
    </style>

   <script type="text/javascript">
        $(function () {
            $("#btnBeginTime").on('click', function () {
                var d = new Date();
                h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
                m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                $("#MainContent_txt_mod_BeginTime").val(h + ':' + m);               
            });
        });

        $(function () {
            $("#btnEndTime").on('click', function () {
                var d = new Date();
                h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
                m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                $("#MainContent_txt_mod_EndTime").val(h + ':' + m);
                var BeginTime = $("#MainContent_txt_mod_BeginTime").val();
                var EndTime = $("#MainContent_txt_mod_EndTime").val();
                $("#MainContent_txt_mod_HoldTime").val(parseTime(EndTime) - parseTime(BeginTime));
            });
        });

        function parseTime(s) {
            var c = s.split(':');
            return parseInt(c[0]) * 60 + parseInt(c[1]);
        }      
    </script>
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<!--Navigation Menu-->
<div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
font-size: small">
<ul id="nav">
        <li><a href="Help.aspx">Help</a></li>
        <li><a href="#">Reports</a>
        <ul>
            <li><a href="MyProductivityReport.aspx">My Productivity</a></li>
        </ul>
                                         
    </li>
    <li><a href="Search.aspx">Search</a></li>
    <li><a href="#">Administration</a>
        <ul>                                           
            <li><a href="admin/ReportCallsMonitored.aspx">Call Center Count</a></li>
            <li><a href="admin/ReportFailedCalls.aspx">Failed Calls</a></li>
            <li><a href="admin/ReportAccuracy.aspx">Accuracy Report</a></li>
            <li><a href="admin/ReportIndividualProductivity.aspx">Productivity</a></li>
            <li><a href="admin/ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
            <li><a href="admin/Search.aspx">Search</a></li>
            <li><a href="ChecksSearch.aspx">Servicer Check Report</a></li>
        </ul>
    </li>
    <li><a href="#">Monitoring</a>
        <ul>
            <li><a href="FormB.aspx">Enter Call</a></li>
            <li><a href="MyReviews.aspx">My Reviews</a></li>
            <li><a href="Checks.aspx">Add Servicer Check</a></li>
        </ul>
    </li>
</ul>
</div>
<!--End Navigation Menu-->
<br /><br />

<!--Call Centers-->
<asp:SqlDataSource ID="dsCallCenters" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
    SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />

<!--UserID-->
<asp:SqlDataSource ID="dsUserID" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
    SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />


<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>

<div align="center" style="padding-top: 10px" id="tabs-1">                               
   <table width="800" cellpadding="4" cellspacing="2" border="0">
    <tr>                                            
        <td width="33%" valign="top">
            <strong>Check ID: </strong><br />
            <asp:TextBox ID="txtCheckID" runat="server" TabIndex="1" />
        </td>
                                                
        <td width="33%"><strong>Call Center Location:</strong><br />
            <asp:ListBox ID="ddlCallCenterID" runat="server" TabIndex="2" 
                DataSourceID="dsCallCenters" 
                AppendDataBoundItems="true" DataTextField="CallCenter" 
                DataValueField="CallCenterID" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />
            </asp:ListBox>
        </td>
        <td width="33%"><strong>Analyst:</strong><br />
            <asp:ListBox ID="ddlUserID" runat="server" TabIndex="3" 
                DataSourceID="dsUserID" 
                AppendDataBoundItems="true" DataTextField="UserID" 
                DataValueField="UserID" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />
            </asp:ListBox>
        </td>                        
    </tr>
                                            
    <tr>
        <td width="33%" valign="top">
            <strong>Date Submitted:</strong><br />
            <asp:TextBox ID="txtDateSubmittedBegin" runat="server" Width="175px" TabIndex="3" Height="25px" /> (from)
            <br />
            <asp:TextBox ID="txtDateSubmittedEnd" runat="server" Width="175px" TabIndex="4" Height="25px" /> (to)
        </td> 
        <td width="33%" valign="top">
            <strong>Check Type:</strong><br />
            <asp:Dropdownlist ID="ddlCheckType" runat="server" TabIndex="2" Height="25px">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="Phone" Value="Phone" />
                <asp:ListItem Text="Web" Value="Web" />
            </asp:Dropdownlist>
        </td>
        <td width="33%" valign="top"><strong><asp:Label ID="lblEscalated" runat="server" Text="Escalate This Call?" TabIndex="6" /></strong> <br />
            <asp:DropDownList ID="ddlEscalated" runat="server" Height="25px">
                <asp:ListItem Text="" Value="" Selected="True" />
                <asp:ListItem Text="No" Value="No" />
                <asp:ListItem Text="Yes" Value="Yes" />
            </asp:DropDownList>
        </td>                                          
        </tr>
        <tr>
            <td colspan="3" align="center">
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-info btn-sm" Text="Search" Onclick="btnSearch_Click" /> 
                <asp:Button ID="btnSearchAgain" runat="server" CssClass="btn btn-default" Text="Search Again" Onclick="btnSearchAgain_Click" /> 
                
            </td>
        </tr>
    </table>                                        
</div>
    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Serivcer Check Search</span>
  </div>
  <div class="panel-body"> 
                
      <asp:GridView ID="GridView1" runat="server" OnRowCommand="GridView1_RowCommand"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="CheckID">
     <EmptyDataTemplate>
         <span>No matches found. Try revising your search criteria.</span>
     </EmptyDataTemplate>
         <Columns>
                            
        <asp:BoundField DataField="CheckID" HeaderText="Check ID" SortExpression="CheckID" />
                    
        <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" SortExpression="DateSubmitted"
            DataFormatString="{0:d}" HtmlEncode="false" />

        <asp:BoundField DataField="UserID" HeaderText="FSA Agent" SortExpression="UserID"
            ItemStyle-HorizontalAlign="Left" />

        <asp:BoundField DataField="CallCenter" HeaderText="Call Center" SortExpression="CallCenter"
            ItemStyle-HorizontalAlign="Left" /> 

       <asp:BoundField DataField="CheckType" HeaderText="Check Type" SortExpression="CheckType"
            ItemStyle-HorizontalAlign="Left" /> 
                    
        <asp:BoundField DataField="BeginTime" HeaderText="Begin Time" SortExpression="BeginTime" HtmlEncode="false" />
                    
        <asp:BoundField DataField="EndTime" HeaderText="End Time" SortExpression="EndTime" HtmlEncode="false" />

            <asp:BoundField DataField="HoldTime" HeaderText="Hold Time" SortExpression="HoldTime" ItemStyle-HorizontalAlign="Left" />

        <asp:BoundField DataField="Escalated" HeaderText="Escalated?" SortExpression="Escalated"
            ItemStyle-HorizontalAlign="Left" />

        <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />
                    
        <asp:ButtonField CommandName="detail" ControlStyle-CssClass="btn btn-info hidePrint" HeaderStyle-CssClass="hidePrint" ButtonType="Button" Text="Update" HeaderText="Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
       
     </Columns>
    </asp:GridView>
         

   </div>
  </div>
</ContentTemplate>
</asp:UpdatePanel>
<p />
<asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-danger" Text="Export to Excel" Onclick="btnExportExcel_Click" />
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
                    <h4 class="modal-title" id="myModalLabel">Update Servicer Check</h4>
                  </div>

                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always"> 
                            <ContentTemplate>
                                <div class="container-fluid">
                                 <asp:Label ID="lblCheckID" runat="server" Visible="false" />   
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>                                            
                                                <td width="33%"><strong>Call Center Location:</strong><br />
                                                    <asp:DropDownList ID="ddl_mod_CallCenterID" runat="server" 
                                                        DataSourceID="dsCallCenters" Height="25px"
                                                        AppendDataBoundItems="true" DataTextField="CallCenter" 
                                                        DataValueField="CallCenterID">
                                                     <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="33%">
                                                    <strong>Check Type:</strong><br />
                                                    <asp:Dropdownlist ID="ddl_mod_CheckType" runat="server" Height="25px">
                                                        <asp:ListItem Text="Phone" Value="Phone" />
                                                        <asp:ListItem Text="Web" Value="Web" />
                                                    </asp:Dropdownlist>
                                                </td>
                                                <td width="33%">
                                                    <strong>Begin Time of Review:</strong><br />
                                                    <asp:TextBox ID="txt_mod_BeginTime" runat="server" />                                                    
                                                </td>                                                                                             
                                            </tr>
                                            
                                            <tr>
                                                 <td width="33%">
                                                    <strong>End Time of Review:</strong><br />
                                                    <asp:TextBox ID="txt_mod_EndTime" runat="server" />                                                    
                                                </td>  
                                                <td width="33%" valign="top"><strong><asp:Label ID="lblHoldTime" runat="server" Text="Hold Time (in minutes):" /></strong><br />
                                                    <asp:TextBox ID="txt_mod_HoldTime" runat="server" /></td> 
                                                <td width="33%" valign="top"><strong><asp:Label ID="Label1" runat="server" Text="Escalate This Call?" /></strong> <br />
                                                    <asp:DropDownList ID="ddl_mod_Escalated" runat="server">
                                                        <asp:ListItem Text="" Value="" />
                                                        <asp:ListItem Text="No" Value="No" />
                                                        <asp:ListItem Text="Yes" Value="Yes" />
                                                    </asp:DropDownList>
                                                </td>                                              
                                            </tr>
                                            <tr>
                                                 <td colspan="3" valign="top"><strong>Comments:</strong> 
                                                 <br />                                                        
                                                 <asp:TextBox ID="txt_mod_Comments" runat="server" TextMode="MultiLine" Width="400" Height="100" /></td>
                                            </tr>
                                        <tr>
                                            <td colspan="4" align="center">
                                                <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-danger" Visible="false" /></td>
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
                                <asp:Button ID="btnDeleteCheck" runat="server" Text="Delete Check" CssClass="btn btn-warning" OnClick="btnDeleteCheck_Click" OnClientClick="return confirm('Are you sure that you want to delete this servicer check?')" />
                            </ContentTemplate>                        
                    </asp:UpdatePanel> 
                  </div>
                </div>
              </div>
            </div>
            <!-- End Update Modal -->

    <asp:Label ID="lblUserID" runat="server" Visible="false" />
     
</asp:Content>

