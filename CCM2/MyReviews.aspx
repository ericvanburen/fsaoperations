<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyReviews.aspx.vb" Inherits="CCM_New_MyReviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
     <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
     <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
     <script src="Scripts/menu.js" type="text/javascript"></script>
       
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
         
    <div align="center">
            <table border="0" width="900px">
              <tr>
                    <td align="left">
		               <h2>Call Center Monitoring - My Call Reviews</h2>
		                                    
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
                            <br /><br />                                
                                <div align="center">
                                    <asp:Panel ID="pnlGridViewStats" runat="server" Visible="false" Width="900px" HorizontalAlign="Center">
                                        <table border="0" width="100%">
                                            <tr>
                                                <td width="33%">&nbsp;</td>
                                                <td align="center" width="33%">
                                                    <asp:Label ID="lblRowCount" runat="server" CssClass="warning" />
                                                </td>
                                                <td align="right" width="33%">
                                                    <asp:ImageButton ID="btnExportExcel" runat="server" CausesValidation="false" ImageUrl="images/btnExportExcel.gif"
                                                        OnClick="btnExportExcel_Click" CssClass="btnExportExcel" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </div>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>             

               <div id="dvGrid" class="grid" align="center">               
               <asp:GridView ID="GridView1" runat="server" 
                        AutoGenerateColumns="false" 
                        AllowSorting="true" 
                        AllowPaging="true" 
                        PageSize="30"  
                        PagerSettings-Mode="NextPreviousFirstLast"
                        OnSorting="GridView1_Sorting" 
                        OnPageIndexChanging="GridView1_PageIndexChanging"
                        CssClass="datatable" 
			            BorderWidth="1px" 
			            DataKeyNames="ReviewID"
			            BackColor="White" 
			            GridLines="Horizontal"
                        CellPadding="3" 
                        BorderColor="#E7E7FF"
			            Width="875px" 
			            BorderStyle="None" 
			            ShowFooter="false">
			            <EmptyDataTemplate>
			                No records matched your search
			            </EmptyDataTemplate>
                        <Columns>
                            <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                                <ItemTemplate>                    
                                   <asp:hyperlink id="HyperLink2" runat="server" navigateurl='<%# Eval("ReviewID", "FormBDetail.aspx?ReviewID={0}") %>'
                                    text='<%# Eval("ReviewID") %>' />
                                </ItemTemplate>                            
                            </asp:TemplateField>                                                       
                            <asp:BoundField DataField="CallCenter" HeaderText="Call Center" SortExpression="CallCenter" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="UserID" HeaderText="Evaluator" SortExpression="UserID" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="DateofReview" HeaderText="Date of Review" SortExpression="DateofReview" DataFormatString="{0:d}" HtmlEncode="false" />
                            <asp:BoundField DataField="AgentID" HeaderText="Agent ID" SortExpression="AgentID" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="BorrowerAccountNumber" HeaderText="Acct #" SortExpression="BorrowerAccountNumber" ItemStyle-HorizontalAlign="Left" />                      
                            <asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" />     
                           
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
        </ContentTemplate>
        </asp:UpdatePanel>
                    </div>                    
            </td>
                </tr>
            </table>
             </div>
    
    <br />
    
          
    </fieldset>
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" />
</asp:Content>

