<%@ Page Title="Add New Refund" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="AddRefund.aspx.vb" Inherits="DMCSRefunds_admin_AddRefund" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
 <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
    <Scripts>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.Core.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.jQuery.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.jQueryInclude.js">
        </asp:ScriptReference>
    </Scripts>
</telerik:RadScriptManager>

    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" EnableAJAX="true">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="OrientationComboBox">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadMenu1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <table border="0" width="100%">
        <tr>
            <td class="formLabelHeader">Add New Refund</td>
            <td align="right">
                <telerik:radajaxloadingpanel runat="server" id="RadAjaxLoadingPanel1" />
                <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
                    <telerik:radmenu id="RadMenu1" runat="server" enableroundedcorners="true" enableshadows="true" />
                </div>
            </td>
        </tr>
    </table>
    <br />
    <asp:SqlDataSource ID="dsAddRefund" runat="server" SelectCommand="p_Add_Refund" SelectCommandType="StoredProcedure" 
UpdateCommand="p_Add_Refund" UpdateCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>">
<UpdateParameters>
    <asp:Parameter Name="BorrowerNumber" Type="String" />
    <asp:Parameter Name="TagDate" Type="DateTime" />
    <asp:Parameter Name="UserID" Type="String" />
    <asp:Parameter Name="DateAssigned" Type="DateTime" />
    <asp:Parameter Name="Comments" Type="String" />
</UpdateParameters>
</asp:SqlDataSource>
    

    <table width="100%" style="width: 100%; height: 100%; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 5px;" cellpadding="5" cellspacing="5">
                       
            <tr>
                <td>
                    <span class="formLabel">Borrower Number</span><br />
                    <asp:TextBox ID="txtBorrowerNumber" runat="server" />
                </td>
                <td>
                    <span class="formLabel">Assigned To</span><br />
                    <asp:DropDownList ID="ddlUserID" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="" Value="" />
                    </asp:DropDownList>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <span class="formLabel">Refund Tag Date</span><br />
                    <asp:TextBox ID="txtTagDate" runat="server" />
                </td>
                <td>
                    <span class="formLabel">Date Assigned</span><br />
                    <asp:TextBox ID="txtDateAssigned" runat="server" /><br />
                </td>
            </tr>
                      
            
            <tr>
                <td colspan="2">
                    <span class="formLabel" colspan="2">Comments</span><br />
                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="3" Columns="65" /><br /><br />
                    <asp:Button ID="btnAddRefund" runat="server" Text="Add Refund" OnClick="btnAddRefund_Click" />
                    <asp:Button ID="btnAddAnother" runat="server" Text="Add Another Refund" OnClick="btnAddAnother_Click" Visible="false" />
                                       
                </td>
            </tr>           
            <tr>
                <td colspan="2"><asp:Label ID="lblUpdateStatus" runat="server" CssClass="failureNotification" /></td>
            </tr>
        </table>
</asp:Content>

