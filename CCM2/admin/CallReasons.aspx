<%@ Page Title="Call Center Monitoring - Call Reasons" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="CallReasons.aspx.vb" Inherits="CCM_New_admin_CallReasons" %>

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
                        <h2>Call Center Monitoring - Call Reasons</h2>
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
                                
                                <!--Call Reason / Issues-->
                                <asp:SqlDataSource ID="dsReasonCode" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_CallReasons" SelectCommandType="StoredProcedure" InsertCommand="INSERT INTO CallReasons (ReasonForCall, ReasonGroup) VALUES(@ReasonForCall, @ReasonGroup)"
                                    UpdateCommand="UPDATE CallReasons SET ReasonForCall = @ReasonForCall, ReasonGroup = @ReasonGroup WHERE ReasonCode = @ReasonCode">
                                    <InsertParameters>
                                        <asp:Parameter Name="ReasonForCall" Type="String" />
                                        <asp:Parameter Name="ReasonGroup" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="ReasonForCall" Type="String" />
                                        <asp:Parameter Name="ReasonGroup" Type="String" />
                                        <asp:Parameter Name="ReasonCode" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <!--ReasonGroup-->
                                <asp:SqlDataSource ID="dsReasonGroup" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_ReasonGroup" SelectCommandType="StoredProcedure" />
                                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                    <contenttemplate> 

                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        <div id="divCallReasons" class="grid" align="center">
                                         <asp:GridView ID="grdCallReasons" runat="server" 
                                                AutoGenerateColumns="false" 
                                                DataKeyNames="ReasonCode"  
                                                DataSourceID="dsReasonCode"
                                                OnRowCommand="grdCallReasons_OnRowCommand1"
                                                AllowSorting="true"                         
                                                CssClass="datatable" 
			                                    BorderWidth="1px" 
			                                    BackColor="White" 
			                                    GridLines="Horizontal"
                                                CellPadding="3" 
                                                BorderColor="#E7E7FF"
			                                    Width="98%" 
			                                    BorderStyle="None" 
			                                    ShowFooter="true">
			                                    <EmptyDataTemplate>
			                                        No records matched your search
			                                    </EmptyDataTemplate>
                                                <Columns>                                                     
                                                   <asp:CommandField ButtonType="Image" ShowDeleteButton="False"  CancelImageUrl="~/CCM_New/images/cancel.gif" EditImageUrl="~/images/pencil.gif"
                                                    ShowEditButton="True" UpdateImageUrl="~/CCM_New/images/save.gif" CausesValidation="false" HeaderText=" " ItemStyle-HorizontalAlign="Left" />                                                                    
                                                   
                                                   <asp:TemplateField HeaderText="Call Reason" SortExpression="ReasonForCall" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-CssClass="first">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblReasonForCall" runat="server" Text='<%#Eval("ReasonForCall") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:TextBox ID="txtReasonForCall" runat="server" Text='<%#Bind("ReasonForCall") %>' Width="250px" Font-Size="Small">
                                                </asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>                                                    
                                                    <asp:Button ID="btnInsert" runat="Server" Text="Add New Call Reason" CommandName="Insert" CommandArgument="Insert" UseSubmitBehavior="False" />  
                                                    Call Reason: <asp:TextBox ID="txtReasonForCall" runat="Server"  /><br />
                                                    <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtReasonForCall" ErrorMessage="* Please enter a new Call Reason" CssClass="warning" Display="Dynamic" />                                                    
                                                </FooterTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Reason Group" SortExpression="ReasonGroup" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblReasonGroup" runat="server" Text='<%#Eval("ReasonGroup") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                <asp:DropDownList ID="ddlReasonGroup" runat="server" SelectedValue='<%#Bind("ReasonGroup")%>' Font-Size="Small" 
                                                DataSourceID="dsReasonGroup" DataTextField="ReasonGroup" DataValueField="ReasonGroup">                                         
                                                </asp:DropDownList>                                                
                                                </EditItemTemplate>
                                                 <FooterTemplate>
                                                    Reason Group: <asp:DropDownList ID="ddlReasonGroup" runat="server" Font-Size="Small"
                                                DataSourceID="dsReasonGroup" DataTextField="ReasonGroup" DataValueField="ReasonGroup">  
                                                </asp:DropDownList>  <br />
                                                      <asp:RequiredFieldValidator ID="rf2" runat="server" ControlToValidate="ddlReasonGroup" ErrorMessage="* Please select a new Reason Group" CssClass="warning" Display="Dynamic" />
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

