<%@ Page Title="Call Center Monitoring - Call Concerns" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Concerns.aspx.vb" Inherits="CCM_New_admin_Concerns" %>

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
                         <h2>Call Center Monitoring - Concerns</h2>
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
                                <asp:SqlDataSource ID="dsConcernID" runat="server" ConnectionString="<%$ ConnectionStrings:CCMConnectionString %>"
                                    SelectCommand="p_ConcernsAll" SelectCommandType="StoredProcedure" InsertCommand="INSERT INTO Concerns (Concern) VALUES (@Concern)"
                                    UpdateCommand="UPDATE Concerns SET Concern = @Concern WHERE ConcernID=@ConcernID">
                                    <InsertParameters>
                                        <asp:Parameter Name="Concern" Type="String" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="Concern" Type="String" />
                                        <asp:Parameter Name="ConcernID" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                    <contenttemplate> 

                                    <div align="left" style="padding-top: 10px" id="tabs-1">                                        
                                        <div id="divConcerns" class="grid" align="center">
                                         <asp:GridView ID="grdConcerns" runat="server" 
                                                AutoGenerateColumns="false" 
                                                DataKeyNames="ConcernID"  
                                                DataSourceID="dsConcernID"
                                                OnRowCommand="grdConcerns_OnRowCommand1"
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
                                                   <asp:CommandField ButtonType="Image" ShowDeleteButton="False"  CancelImageUrl="~/images/cancel.gif" EditImageUrl="~/images/pencil.gif"
                                                    ShowEditButton="True" UpdateImageUrl="~/images/save.gif" CausesValidation="false" HeaderText=" " ItemStyle-HorizontalAlign="Left" />                                                                    
                                                   
                                                   <asp:TemplateField HeaderText="Concern" SortExpression="Concern" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-CssClass="first">
                                                   <ItemTemplate>
                                                       <asp:Label ID="lblConcern" runat="server" Text='<%#Eval("Concern") %>' />
                                                 </ItemTemplate>
                                                <EditItemTemplate>
                                                 <asp:TextBox ID="txtConcern" runat="server" Text='<%#Bind("Concern") %>' Width="250px" Font-Size="Small" />  
                                                </EditItemTemplate>
                                                <FooterTemplate>                                                    
                                                    <asp:Button ID="btnInsert" runat="Server" Text="Add New Call Concern" CommandName="Insert" CommandArgument="Insert" UseSubmitBehavior="False" />  
                                                    Call Concern: <asp:TextBox ID="txtConcern" runat="Server"  /><br />
                                                    <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="txtConcern" ErrorMessage="* Please enter a new Call Concern" CssClass="warning" Display="Dynamic" />                                                    
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

