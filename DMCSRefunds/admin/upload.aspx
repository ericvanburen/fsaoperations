<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="upload.aspx.vb" Inherits="DMCSRefunds_admin_upload" %>
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
    <td class="formLabelHeader">Upload New Refund Requests</td>
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

    <asp:SqlDataSource ID="dsRefunds" runat="server" ConnectionString="<%$ ConnectionStrings:DMCSRefundsConnectionString %>"
        SelectCommand="p_RefundQueue" SelectCommandType="StoredProcedure" UpdateCommand="p_RefundAssign"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="RefundID" />
        </UpdateParameters>
    </asp:SqlDataSource>

        <table cellpadding="2" cellspacing="1" border="0" style="border-collapse: collapse;" width="100%">
            <tr align="center">
                 <td align="left">Upload New File: 
                     <asp:FileUpload ID="fileuploadExcel" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;<span
                         onclick="return confirm('Are you sure to import the selected Excel file?')">
                    <asp:Button  ID="btnUploadExcelFile" runat="Server" Text="Import" OnClick="UploadFile_Click"/></span>
                         <asp:Button ID="btnDeleteDuplicates" runat="server" Text="Delete Duplicates" OnClick="btnDeleteDuplicates_Click" />                                                                                              </span> 
                  </td> 
              </tr>
              <tr> 
                 <td align="left">
                     <asp:Label ID="lblMessage" runat="Server" EnableViewState="False" ForeColor="Blue"> 
                     </asp:Label> 
                  </td> 
              </tr>              
              </table>

              

              <p><asp:Label ID="lblRowCount" runat="server" /></p>
              <asp:GridView ID="grdRefunds" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="There are no pending refunds in the queue" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="RefundID" HorizontalAlign="Center"
                         OnPageIndexChanging="grdRefunds_PageIndexChanging" EmptyDataRowStyle-Font-Size="Medium" AllowSorting="true" AllowPaging="true" PageSize="50" Width="95%"
                         OnRowDataBound="grdRefunds_RowDataBound"> 
                         <AlternatingRowStyle BackColor="#F7F7F7"  />
                         <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C"  />
                         <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7"  />
                         <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right"  />
                         <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C"  />
                         <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7"  />
                         <SortedAscendingCellStyle BackColor="#F4F4FD"  />
                         <SortedAscendingHeaderStyle BackColor="#5A4C9D"  />
                         <SortedDescendingCellStyle BackColor="#D8D8F0"  />
                         <SortedDescendingHeaderStyle BackColor="#3E3277" />
                         <Columns>
                             <asp:TemplateField>
                                 <ItemTemplate>
                                     <asp:CheckBox ID="chkSelect" runat="server" />
                                 </ItemTemplate>
                             </asp:TemplateField>
                             <asp:TemplateField HeaderText="Refund ID" SortExpression="RefundID">
                              <ItemTemplate>                    
                                   <asp:hyperlink id="HyperLink1" runat="server" navigateurl='<%# Eval("RefundID", "RefundDetail.aspx?RefundID={0}") %>'
                                    text='<%# Eval("RefundID") %>' />
                                </ItemTemplate>                            
                            </asp:TemplateField>                           
                            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" />                            
                            <asp:BoundField DataField="TagDate" HeaderText="Tag Date" SortExpression="TagDate" DataFormatString="{0:d}" />                           
                         </Columns>
                     </asp:GridView>
                     <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
</asp:Content>

