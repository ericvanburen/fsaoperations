<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="upload.aspx.vb" Inherits="DMCSRefunds_admin_upload" %>
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

 <asp:SqlDataSource ID="dsRefunds" runat="server" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>"
        SelectCommand="p_RefundQueue" SelectCommandType="StoredProcedure" UpdateCommand="p_RefundAssign"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="RefundID" />
        </UpdateParameters>
</asp:SqlDataSource>


<table border="0" width="100%">
<tr>
    <td class="formLabelHeader">DMCS New Refunds Manager</td>
    <td align="right">
     <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1" /> 

     <div class="qsf-demo-canvas qsf-demo-canvas-vertical">
          <telerik:RadMenu ID="RadMenu1" runat="server" EnableRoundedCorners="true" EnableShadows="true" />
     </div>
    </td>
</tr>
</table>
<br />
<br />
<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">DMCS Refunds - Upload New Refunds</span>
  </div>
        <div class="panel-body">
   

        <table cellpadding="2" cellspacing="1" border="0" style="border-collapse: collapse;" width="100%">

        <tr>
            <td>
                <p>This form allows administrators upload new refunds from DMCS to be assigned to staff. New uploads must use this <a href="../images/help/refunds.xls">template file</a> to work correctly.
                    The users checked 'Active' in the table below will be assigned the refunds that are uploaded.
                </p>
            </td>
        </tr>        
            <tr align="center">
                 <td align="left">Step 1: Select File to Upload: <asp:FileUpload ID="fileuploadExcel" runat="server" />
                     <span onclick="return confirm('Are you sure to import the selected Excel file?')"></span></td>
            </tr>
            <tr>
                <td>Step 2: Click Import Button: <asp:Button  ID="btnUploadExcelFile" runat="Server" Text="Import" OnClick="UploadFile_Click"/></td> 
            </tr>
              <tr> 
                 <td align="left">
                     <asp:Label ID="lblMessage" runat="Server" EnableViewState="False" ForeColor="Blue" /> 
                  </td> 
              </tr>              
              </table>
        </div>
</div>

<!--User Manager Portion-->
   
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
            <asp:BoundField DataField="Grade" HeaderText="Grade" SortExpression="Grade" ReadOnly="true" />
            <asp:BoundField DataField="Refunds_Pending" HeaderText="Refunds Pending" SortExpression="Refunds_Pending" ReadOnly="true" />
            <asp:BoundField DataField="Refunds_Approved_30Days" HeaderText="Refunds Completed Last 30 days" SortExpression="Refunds_Approved_30Days" ReadOnly="true" />
            <asp:BoundField DataField="Refunds_Approved_Total" HeaderText="Refunds Completed Total" SortExpression="Refunds_Approved_Total" ReadOnly="true" DataFormatString="{0:N0}" />
        </Columns>
    </asp:GridView>

 </div></div>
 
         
</asp:Content>

