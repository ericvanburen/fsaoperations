<%@ Page Title="Call Center Monitoring - Call Centers" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="CallCenters.aspx.vb" Inherits="CCM_New_admin_CallCenters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/menustyle.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/menu.js" type="text/javascript"></script>   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <fieldset class="fieldset">
        <div align="center">
            <table border="0" width="900px">
                <tr>
                    <td align="left">
                        <h2>Call Center Monitoring - Call Centers</h2>
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
                                    <li><a href="Search.aspx">Search</a></li>
                                    <li><a href="#">Administration</a>
                                        <ul>                                           
                                            <li><a href="ReportCallsMonitored.aspx">Call Center Count</a></li>
                                            <li><a href="ReportFailedCalls.aspx">Failed Calls</a></li>
                                            <li><a href="ReportAccuracy.aspx">Accuracy Report</a></li>
                                            <li><a href="ReportIndividualProductivity.aspx">Productivity</a></li>
                                            <li><a href="ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
                                            <li><a href="Search.aspx">Search</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Monitoring</a>
                                        <ul>
                                            <li><a href="../FormB.aspx">Enter Call</a></li>
                                            <li><a href="../MyReviews.aspx">My Reviews</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <br />
                            <br />
                            <div id="Div1">
                                
                                <!--Concerns-->
                                <asp:SqlDataSource ID="dsCallCenterID" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallCentersAll" SelectCommandType="StoredProcedure" InsertCommand="INSERT INTO CallCenters (CallCenter, Contract, CallCenterFunction, ReportGroup) VALUES (@CallCenter, @Contract, @CallCenterFunction, @ReportGroup)"
                                    UpdateCommand="UPDATE CallCenters SET CallCenter = @CallCenter, Contract = @Contract, CallCenterFunction = @CallCenterFunction, ReportGroup = @ReportGroup WHERE CallCenterID=@CallCenterID">
                                    <InsertParameters>
                                        <asp:Parameter Name="CallCenter" Type="String" />
                                        <asp:Parameter Name="Contract" Type="String" />
                                        <asp:Parameter Name="CallCenterFunction" Type="String" />
                                        <asp:Parameter Name="ReportGroup" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="CallCenter" Type="String" />
                                        <asp:Parameter Name="Contract" Type="String" />
                                        <asp:Parameter Name="CallCenterFunction" Type="String" />
                                        <asp:Parameter Name="ReportGroup" Type="String" />
                                        <asp:Parameter Name="CallCenterID" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <!--CallCenter Contract-->
                                <asp:SqlDataSource ID="dsCallCenterContract" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallCenterContracts" SelectCommandType="StoredProcedure" />
                                <!--Call Center Function-->
                                <asp:SqlDataSource ID="dsCallCenterFunction" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallCenterFunction" SelectCommandType="StoredProcedure" />
                                <!--Call Center Report Group-->
                                <asp:SqlDataSource ID="dsCallCenterReportGroup" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallCenterReportGroup" SelectCommandType="StoredProcedure" />
                                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                    <contenttemplate> 

                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        <div id="divCallCenters" class="grid" align="center">
                                         <asp:GridView ID="grdCallCenters" runat="server" 
                                                AutoGenerateColumns="false" 
                                                DataKeyNames="CallCenterID"  
                                                DataSourceID="dsCallCenterID"
                                                OnRowCommand="grdCallCenters_OnRowCommand1"
                                                AllowSorting="true"                         
                                                CssClass="datatable" 
			                                    BorderWidth="1px" 
			                                    BackColor="White" 
			                                    GridLines="Horizontal"
                                                CellPadding="3" 
                                                BorderColor="#E7E7FF"
			                                    Width="900px" 
			                                    BorderStyle="None" 
			                                    ShowFooter="true">
			                                    <EmptyDataTemplate>
			                                        No records matched your search
			                                    </EmptyDataTemplate>
                                                <Columns>                                                     
                                                   <asp:CommandField ButtonType="Image" ShowDeleteButton="False"  CancelImageUrl="~/CCM_New/images/cancel.gif" EditImageUrl="~/images/pencil.gif"
                                                    ShowEditButton="True" UpdateImageUrl="~/CCM_New/images/save.gif" CausesValidation="false" HeaderText=" " ItemStyle-HorizontalAlign="Left" />                                                                    
                                                   
                                                   <asp:TemplateField HeaderText="Call Center" SortExpression="CallCenter" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-CssClass="first">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblCallCenter" runat="server" Text='<%#Eval("CallCenter") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                 <asp:TextBox ID="txtCallCenter" runat="server" Text='<%#Bind("CallCenter") %>' Width="250px" Font-Size="Small" />  
                                                </EditItemTemplate>
                                                <FooterTemplate>  
                                                    Call Center: <asp:TextBox ID="txtCallCenter" runat="Server"  /><br />
                                                    <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtCallCenter" ErrorMessage="* Please enter a new Call Center" CssClass="warning" Display="Dynamic" />                                                    
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                 <asp:TemplateField HeaderText="Contract" SortExpression="Contract" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblContract" runat="server" Text='<%#Eval("Contract") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:DropDownList ID="ddlContract" runat="server" SelectedValue='<%#Bind("Contract")%>' Font-Size="Small" 
                                                DataSourceID="dsCallCenterContract" DataTextField="Contract" DataValueField="Contract">                                         
                                                </asp:DropDownList>                                                
                                                </EditItemTemplate>
                                                 <FooterTemplate>
                                                    Contract: <asp:DropDownList ID="ddlContract" runat="server" Font-Size="Small"
                                                DataSourceID="dsCallCenterContract" DataTextField="Contract" DataValueField="Contract">  
                                                </asp:DropDownList>  <br />
                                                      <asp:RequiredFieldValidator ID="rf2" runat="server" ControlToValidate="ddlContract" ErrorMessage="* Please select a new Contract" CssClass="warning" Display="Dynamic" />
                                                </FooterTemplate>
                                                </asp:TemplateField>
                                                
                                                 <asp:TemplateField HeaderText="Call Center Function" SortExpression="CallCenterFunction" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblCallCenterFunction" runat="server" Text='<%#Eval("CallCenterFunction") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:DropDownList ID="ddlCallCenterFunction" runat="server" SelectedValue='<%#Bind("CallCenterFunction")%>' Font-Size="Small" 
                                                DataSourceID="dsCallCenterFunction" DataTextField="CallCenterFunction" DataValueField="CallCenterFunction">                                         
                                                </asp:DropDownList>                                                
                                                </EditItemTemplate>
                                                 <FooterTemplate>
                                                    Call Center Function: <asp:DropDownList ID="ddlCallCenterFunction" runat="server" Font-Size="Small"
                                                DataSourceID="dsCallCenterFunction" DataTextField="CallCenterFunction" DataValueField="CallCenterFunction">  
                                                </asp:DropDownList>  <br />
                                                      <asp:RequiredFieldValidator ID="rf3" runat="server" ControlToValidate="ddlCallCenterFunction" ErrorMessage="* Please select a new Call Center Function" CssClass="warning" Display="Dynamic" />
                                                </FooterTemplate>
                                                </asp:TemplateField>
                                                         
                                                 <asp:TemplateField HeaderText="Report Group" SortExpression="ReportGroup" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblReportGroup" runat="server" Text='<%#Eval("ReportGroup") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:DropDownList ID="ddlReportGroup" runat="server" SelectedValue='<%#Bind("ReportGroup")%>' Font-Size="Small" 
                                                DataSourceID="dsCallCenterReportGroup" DataTextField="ReportGroup" DataValueField="ReportGroup">                                         
                                                </asp:DropDownList>                                                
                                                </EditItemTemplate>
                                                 <FooterTemplate>                                                    
                                                    Report Group: <asp:DropDownList ID="ddlReportGroup" runat="server" Font-Size="Small"
                                                DataSourceID="dsCallCenterReportGroup" DataTextField="ReportGroup" DataValueField="ReportGroup">  
                                                </asp:DropDownList>  <br />
                                                      <asp:RequiredFieldValidator ID="rf4" runat="server" ControlToValidate="ddlReportGroup" ErrorMessage="* Please select a new Report Group" CssClass="warning" Display="Dynamic" />
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="">
                                                <FooterTemplate>
                                                    <asp:Button ID="btnInsert" runat="Server" Text="Add Call Center" CommandName="Insert" CommandArgument="Insert" UseSubmitBehavior="False" />
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                </Columns>
                                                <RowStyle CssClass="row" />
                                                <AlternatingRowStyle CssClass="rowalternate" />
                                                
                                                <HeaderStyle CssClass="gridcolumnheader" />
                                                <EditRowStyle CssClass="gridEditRow" />       
                                            </asp:GridView><br />       
                                            </div>
                                         </div>

                                        </contenttemplate>
                                </asp:UpdatePanel>
                            </div>
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

