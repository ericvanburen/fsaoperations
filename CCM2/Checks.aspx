<%@ Page Title="Call Center Monitoring Monitoring Serivcer Check" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Checks.aspx.vb" Inherits="CCM_New_FormB" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="ASPNetSpell" Namespace="ASPNetSpell" TagPrefix="ASPNetSpell" %>

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

        
   <script type="text/javascript">
    $(function () {
        $(".datepicker").datepicker();
    });
   </script>

   <script type="text/javascript">
        $(function () {
            $("#btnBeginTime").on('click', function () {
                var d = new Date();
                h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
                m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                $("#MainContent_txtBeginTime").val(h + ':' + m);               
            });
        });

        $(function () {
            $("#btnEndTime").on('click', function () {
                var d = new Date();
                h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
                m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
                $("#MainContent_txtEndTime").val(h + ':' + m);
                var BeginTime = $("#MainContent_txtBeginTime").val();
                var EndTime = $("#MainContent_txtEndTime").val();

                $("#MainContent_txtHoldTime").val(parseTime(EndTime) - parseTime(BeginTime));
            });
        });

        function parseTime(s) {
            var c = s.split(':');
            return parseInt(c[0]) * 60 + parseInt(c[1]);
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="pnlupdate1" runat="server">
    <ContentTemplate>    
    <fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                         <h2 style="color: black; font-size: 25px; font-family: Calibri;">Call Center Monitoring - Enter New Servicer Check</h2>
                        <div id="tabs">
                           
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
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Call Centers-->
                                <asp:SqlDataSource ID="dsCallCenters" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
                                    SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />
                               
                                 <div align="left" style="padding-top: 10px" id="tabs-1">
                                 
                                            <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                            <tr>                                            
                                                <td width="25%"><strong>Call Center Location:</strong><br />
                                                    <asp:DropDownList ID="ddlCallCenterID" runat="server" TabIndex="1" 
                                                        DataSourceID="dsCallCenters" Height="25px"
                                                        AppendDataBoundItems="true" DataTextField="CallCenter" 
                                                        DataValueField="CallCenterID">
                                                        <asp:ListItem Text="" Value="" />
                                                    </asp:DropDownList><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please select a  Call Center Location * " ControlToValidate="ddlCallCenterID" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Check Type:</strong><br />
                                                    <asp:Dropdownlist ID="ddlCheckType" runat="server" TabIndex="2" Height="25px">
                                                        <asp:ListItem Text="Phone" Value="Phone" />
                                                        <asp:ListItem Text="Web" Value="Web" />
                                                    </asp:Dropdownlist><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Check Type * " ControlToValidate="ddlCheckType" />
                                                </td>
                                                <td width="25%">
                                                    <strong>Begin Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtBeginTime" runat="server" Width="175px" TabIndex="3" Height="25px" />
                                                    <button type="button" class="btn btn-default btn-sm" Height="20" Width="20" name="btnBeginTime" id="btnBeginTime"><span class="glyphicon glyphicon-time"></span></button>
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the Beginning Time of Review  * " ControlToValidate="txtBeginTime" />
                                                </td>
                                                <td width="25%">
                                                    <strong>End Time of Review:</strong><br />
                                                    <asp:TextBox ID="txtEndTime" runat="server" Width="175px" TabIndex="4" Height="25px" />
                                                    <button type="button" class="btn btn-default btn-sm" Height="20" Width="20" name="btnEndTime" id="btnEndTime"><span class="glyphicon glyphicon-time"></span></button>
                                                    <br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="warning" Display="Dynamic" 
                                                    ErrorMessage="* Please enter the End Time of Review  * " ControlToValidate="txtEndTime" />
                                                </td>                                                
                                            </tr>
                                            
                                            <tr>
                                                <td width="25%" valign="top"><strong><asp:Label ID="lblHoldTime" runat="server" Text="Hold Time (in minutes):" /></strong><br />
                                                    <asp:TextBox ID="txtHoldTime" runat="server" TabIndex="5" /></td> 
                                                <td width="25%" valign="top"><strong><asp:Label ID="lblEscalated" runat="server" Text="Escalate This Call?" TabIndex="6" /></strong> <br />
                                                    <asp:DropDownList ID="ddlEscalated" runat="server" Height="25px">
                                                        <asp:ListItem Text="No" Value="No" Selected ="True" />
                                                        <asp:ListItem Text="Yes" Value="Yes" />
                                                    </asp:DropDownList>
                                                </td>
                                                <td width="25%" valign="top"> </td>
                                                <td width="25%" valign="top"> </td>                                                  
                                            </tr>
                                            </table>                                        
                                          
                                            <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                                <tr>
                                                    <td><strong>Comments:</strong> 
                                                    <br />                                                        
                                                    <asp:RequiredFieldValidator ID="rfdComments" runat="server" ControlToValidate="txtComments" CssClass="warning" ErrorMessage="Comments are required when the call fails" Display="Dynamic" Enabled="false" />
                                                  
                                                    <ASPNetSpell:SpellTextBox ID="txtComments" runat="server" TextMode="MultiLine" 
                                                            Width="750" Height="100" TabIndex="7" />
                                                    <ASPNetSpell:SpellButton ID="SpellButton1" runat="server" CheckGrammar="true" FieldsToSpellCheck="txtComments" />
                                                    </td>
                                                </tr>                                                
                                                
                                                <tr>
                                                     <td align="center"><asp:Label ID="lblRecordStatus" runat="server" CssClass="warning" /></td>
                                                </tr>
                                                    <tr>
                                                    <td colspan="3" align="center">
                                                      <asp:Button ID="btnAddCheck" runat="server" CssClass="button" Text="Add Check" 
                                                            OnClick="btnAddCheck_Click" TabIndex="8" />                                                        
                                                        <asp:Button ID="btnAddAnotherCheck" runat="server" CssClass="button" Text="Add Another Check" OnClick="btnAddAnotherCheck_Click" CausesValidation="false" Visible="false" />
                                                    </td>
                                                </tr>
                                                </table>
                                                                                             
                                                       
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
    
   </ContentTemplate>
   </asp:UpdatePanel>
    
   <asp:Label ID="lblUserID" runat="server" Visible="false" /><br />
   <input id="lblPassFailHidden" name="lblPassFailHidden" type="Hidden" runat="server" visible="true" />
   <asp:Literal ID="lblPassFailServerSide" runat="server" Visible="false" Text="PASS" />
   <asp:Label ID="lblCallCenterID" runat="server" />
   <asp:Label ID="lblCallCenterFunction" runat="server" Visible="false" />
</asp:Content>

