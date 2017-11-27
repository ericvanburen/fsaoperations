<%@ Page Title="Refunds User Manager" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UserManager.aspx.vb" Inherits="DMCSRefunds_admin_AddRefund" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
 <link href="../StyleSheet.css" rel="stylesheet" type="text/css" />
 <script src="../../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
 <script src="../../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
 <script src="../../bootstrap/js/tooltip.js" type="text/javascript"></script>
 <link href="../../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
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
            <td align="right">
                <telerik:radajaxloadingpanel runat="server" id="RadAjaxLoadingPanel1" />
                <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
                    <telerik:radmenu id="RadMenu1" runat="server" enableroundedcorners="true" enableshadows="true" />
                </div>
            </td>
        </tr>
    </table>
    <br />
        
    <asp:SqlDataSource ID="dsUsers" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>"
        SelectCommand="p_RefundsUsers" SelectCommandType="StoredProcedure"
        UpdateCommand="p_RefundsUsersUpdate" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="UserID" Type="String" />
        </UpdateParameters>
        </asp:SqlDataSource>

 <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">DMCS Refunds User Manager</span>
  </div>
        <div class="panel-body">
    
    <table>
        <tr>
            <td>
                <p>This form allows administrators to enable or disable users from receiving new refund assignments</p>
            </td>
        </tr>        
     </table>
    <p />
    <asp:Label ID="lblRowCount" runat="server" CssClass="text-info" />
    <asp:GridView ID="grdUserManager" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="UserID" HorizontalAlign="Center" AllowSorting="True" Width="95%"
        DataSourceID="dsUsers" CssClass="table table-hover table-striped table-bordered table-condensed GridView">        
        <Columns>
            <asp:CommandField ShowEditButton="True" HeaderStyle-Width="50px" />
            <asp:TemplateField HeaderText="Active?" HeaderStyle-Width="50px" SortExpression="Active">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" runat="server" Checked='<%# Bind("Active")%>' />                    
                </ItemTemplate>
            <HeaderStyle Width="75px"></HeaderStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true">
                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left"></ItemStyle>
            </asp:BoundField>
        </Columns>
    </asp:GridView>

 </div></div>
    <asp:Label ID="lblUserID" runat="server" Visible="false" />
    
</asp:Content>

