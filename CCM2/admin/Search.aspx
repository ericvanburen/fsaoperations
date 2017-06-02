<%@ Page Title="Call Center Monitoring Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.vb" Inherits="CCM_New_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
     <script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <link href="../Scripts/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/menu.js" type="text/javascript"></script>
     <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                        <h2>Call Center Monitoring - Power Search</h2>
                        <div id="tabs">
                            <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
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
                            <br />
                            <br />
                            <div id="Div1">
                                <!--Call Centers-->
                                <asp:SqlDataSource ID="dsCallCenters" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
                                    SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" />
                                <!--Call Reason / Issues-->
                                <asp:SqlDataSource ID="dsReasonCode" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
                                    SelectCommand="p_CallReasons" SelectCommandType="StoredProcedure" />
                                <!--Concerns-->
                                <asp:SqlDataSource ID="dsConcerns" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
                                    SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" />
                                <!--Users/Evaluators-->
                                <asp:SqlDataSource ID="dsUserID" runat="server" ConnectionString="<%$ ConnectionStrings:CCM2ConnectionString %>"
                                    SelectCommand="p_UsersAll" SelectCommandType="StoredProcedure" />
                                <div align="left" style="padding-top: 10px" id="tabs-1">
                                    <table width="100%" cellpadding="4" cellspacing="5" border="0">
                                        <tr>
                                            <td width="33%" valign="top">
                                                <strong>Review ID: </strong>
                                                <br />
                                                <asp:TextBox ID="txtReviewID" runat="server" />
                                            </td>
                                            <td width="33%" valign="top">
                                                <strong>Call Center Location:</strong><br />
                                                <asp:ListBox ID="ddlCallCenterID" runat="server" DataSourceID="dsCallCenters" Rows="4"
                                                    AppendDataBoundItems="true" DataTextField="CallCenter" DataValueField="CallCenterID"
                                                    SelectionMode="Multiple">
                                                    <asp:ListItem Text="" Value="" />
                                                </asp:ListBox>
                                            </td>
                                            <td width="33%" valign="top">
                                                <strong>Date of Review:</strong><br />
                                                <asp:TextBox ID="txtDateofReview" runat="server" /> (greater than)                                                            
                                                      
                                                <br />
                                                <br />
                                                <strong>Date of Review:</strong><br />                                                                                                
                                                 <asp:TextBox ID="txtDateofReviewLessThan" runat="server" /> (less than)                                                    
                                                       
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="33%" valign="top">
                                                <strong>Agent ID: </strong>
                                                <br />
                                                <asp:TextBox ID="txtAgentID" runat="server" />
                                            </td>
                                            <td width="33%" valign="top">
                                                <strong>Account No/NSLDS ID:</strong><br />
                                                <asp:TextBox ID="txtBorrowerAccountNumber" runat="server" />
                                            </td>
                                            <td width="33%" valign="top">
                                                <strong>Evaluator:</strong><br />
                                                <asp:ListBox ID="ddlUserID" runat="server" Rows="4" AppendDataBoundItems="true" SelectionMode="Multiple">
                                                    <asp:ListItem Text="" Value="" />
                                                </asp:ListBox>
                                            </td>
                                        </tr> 
                                        <tr>
                                            <td width="33%" valign="top">
                                                <strong>Call ID: </strong>
                                                <br />
                                                <asp:TextBox ID="txtCallID" runat="server" /></td>
                                            <td width="33%" valign="top"><strong><asp:Label ID="lblEscalated" runat="server" Text="Escalated Call?" /></strong> <br />
                                                    <asp:DropDownList ID="ddlEscalated" runat="server" Height="25px">
                                                        <asp:ListItem Text="" Value="" Selected ="True" />
                                                        <asp:ListItem Text="No" Value="No" />
                                                        <asp:ListItem Text="Yes" Value="Yes" />
                                                    </asp:DropDownList></td>
                                            <td width="33%" valign="top"><strong><asp:Label ID="lblSpecialtyLine" runat="server" Text="Specialty Line" /></strong> <br />
                                                <asp:ListBox ID="ddlSpecialtyLine" runat="server" Rows="4"
                                                    AppendDataBoundItems="true" SelectionMode="Multiple">
                                                        <asp:ListItem Text="" Value="" Selected="True" />
                                                        <asp:ListItem Text="Accessibility Requests" Value="Accessibility Requests" />
                                                        <asp:ListItem Text="Borrower Defense" Value="Borrower Defense" />
                                                        <asp:ListItem Text="Consolidation" Value="Consolidation" />
                                                        <asp:ListItem Text="Default Aversion" Value="Default Aversion" />
                                                        <asp:ListItem Text="IDR Campaign Calls" Value="IDR Campaign Calls" />
                                                        <asp:ListItem Text="Military" Value="Military" />
                                                        <asp:ListItem Text="PSLF" Value="PSLF" />
                                                        <asp:ListItem Text="School" Value="School" />
                                                        <asp:ListItem Text="TEACH" Value="TEACH" />
                                                        <asp:ListItem Text="Visually Impaired" Value="Visually Impaired" />
                                                        <asp:ListItem Text="WC/Scheduled Callbacks" Value="WC/Scheduled Callbacks" />        
                                                </asp:ListBox>
                                            </td>
                                                
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <strong>Comments:</strong>
                                                <br />
                                                <asp:TextBox ID="txtComments" runat="server" TextMode="SingleLine" Width="500" />
                                            </td>
                                        </tr>                                      
                                      
                                    </table>
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">                                        
                                        <tr>
                                            <td colspan="3" align="center">
                                                <asp:Button ID="btnSearch" runat="server" CssClass="button" Text="Search" OnClick="btnSearch_Click" />
                                                <asp:Button ID="btnSearchAgain" runat="server" CssClass="button" Text="Search Again"
                                                    OnClick="btnSearchAgain_Click" Visible="false" />
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
        <br />
        <div align="center">
            <table border="0" width="100%">
                <tr>
                    <td align="center" width="50%">
                        <asp:Label ID="lblRowCount" runat="server" CssClass="warning" />
                    </td>
                    <td align="right" width="50%">
                        <asp:ImageButton ID="btnExportExcel" runat="server" CausesValidation="false" ImageUrl="../images/btnExportExcel.gif"
                            OnClick="btnExportExcel_Click" CssClass="btnExportExcel" AlternateText="Export to Excel" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="dvGrid" class="grid" align="center">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="true"
                OnSorting="GridView1_Sorting" AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging"
                PageSize="50" CssClass="datatable" BorderWidth="1px" DataKeyNames="ReviewID"
                BackColor="White" OnPreRender="GridView1_PreRender" GridLines="Horizontal" CellPadding="3"
                BorderColor="#E7E7FF" Width="90%" BorderStyle="None" ShowFooter="false">
                <EmptyDataTemplate>
                    No records matched your search
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ReviewID", "../FormBDetail.aspx?ReviewID={0}") %>'
                                Text='<%# Eval("ReviewID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CallCenter" HeaderText="Call Center" SortExpression="CallCenter"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="UserID" HeaderText="Evaluator" SortExpression="UserID"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="DateofReview" HeaderText="Date of Review" SortExpression="DateofReview"
                        DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="AgentID" HeaderText="Agent ID" SortExpression="AgentID"
                        ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="BorrowerAccountNumber" HeaderText="Acct #" SortExpression="BorrowerAccountNumber"
                        ItemStyle-HorizontalAlign="Left" />                    
                    <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="Escalated" HeaderText="Escalated?" SortExpression="Escalated"
                        ItemStyle-HorizontalAlign="Left" /> 
                </Columns>
                <RowStyle CssClass="row" />
                <AlternatingRowStyle CssClass="rowalternate" />
                <FooterStyle CssClass="gridcolumnheader" />
                <PagerStyle HorizontalAlign="Left" CssClass="gridpager" />
                <HeaderStyle CssClass="gridcolumnheader" />
                <EditRowStyle CssClass="gridEditRow" />
            </asp:GridView>
            <br />
        </div>
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
    
</asp:Content>

