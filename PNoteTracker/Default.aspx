<%@ Page Title="PNote Request Tracker" Debug="true" EnableEventValidation="false" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="PNoteTracker_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>PNote Request Tracking</h2>
    <p>Home| <a href="search.aspx">Search</a> | <a href="ExportFile.aspx">Export Files Utility</a></p>
     <div align="center" class="bg_white">
         <table cellpadding="2" cellspacing="1" border="0" style="border-collapse: collapse;"
             width="100%">
            <tr align="center">
                 <td align="left">Upload New File: 
                     <asp:FileUpload ID="fileuploadExcel" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;<span
                         onclick="return confirm('Are you sure to import the selected Excel file?')">
                    <asp:Button  ID="btnUploadExcelFile" runat="Server" Text="Import" OnClick="UploadFile_Click"/> </span> 
                  </td> 
              </tr>
              <tr> 
                 <td align="left">
                     <asp:Label ID="lblMessage" runat="Server" EnableViewState="False" ForeColor="Blue"> 
                     </asp:Label> 
                  </td> 
              </tr>
                           
             <tr> 
                 <td align="center">

                 <asp:SqlDataSource ID="dsPNoteRequests" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>" 
                    SelectCommand="p_DefaultList" SelectCommandType="StoredProcedure" 
                    UpdateCommand="p_UpdatePNoteStatus" UpdateCommandType="StoredProcedure" DeleteCommand="p_DeleteRequest" DeleteCommandType="StoredProcedure">
                    <UpdateParameters>
                        <asp:Parameter Name="RequestID" />
                        <asp:ControlParameter Name="Status" ControlID="ddlStatus" Type="String" PropertyName="SelectedValue" />
                    </UpdateParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="RequestID" />
                    </DeleteParameters>
                  </asp:SqlDataSource>

                  <asp:SqlDataSource ID="dsPNoteRequestsHistory" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>"
                   InsertCommand="p_Insert_PNote_Request_History" InsertCommandType="StoredProcedure">
                    <InsertParameters>
                        <asp:Parameter Name="RequestID" />
                        <asp:ControlParameter Name="Status" ControlID="ddlStatus" Type="String" PropertyName="SelectedValue" />
                        <asp:Parameter Name="StatusChangeDate" />
                    </InsertParameters>
                  </asp:SqlDataSource>

                  <asp:GridView ID="gvdetails" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="No requests have been made" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="RequestID" 
                         OnPageIndexChanging="gvdetails_PageIndexChanging" EmptyDataRowStyle-Font-Size="Medium" AllowSorting="true" AllowPaging="true" PageSize="50" Width="95%"
                         OnRowDataBound="gvdetails_RowDataBound" DataSourceID="dsPNoteRequests"> 
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
                         <asp:TemplateField HeaderText="Request ID" SortExpression="RequestID">
                              <ItemTemplate>                    
                                   <asp:hyperlink id="HyperLink1" runat="server" navigateurl='<%# Eval("RequestID", "RequestDetail.aspx?RequestID={0}") %>'
                                    text='<%# Eval("RequestID") %>' />
                                </ItemTemplate>                            
                            </asp:TemplateField>     
                            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" />
                            <asp:BoundField DataField="AccountID" HeaderText="Acct ID" SortExpression="AccountID" />
                            <asp:BoundField DataField="FileHolder" HeaderText="File Holder" SortExpression="FileHolder" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="Tag" HeaderText="Type" SortExpression="Tag" />
                            <asp:BoundField DataField="Tag_Date" HeaderText="Tag Date" SortExpression="Tag_Date" DataFormatString="{0:d}" />                           
                         </Columns>
                     </asp:GridView> <br />
                     <asp:Button ID="btnExportToExcel" runat="server" Text="Export Checked Rows To Excel" onclick="btnExportToExcel_Click" />
                     <asp:Button ID="btnUpdateStatus" runat="server" Text="Update Status on Checked Rows" onclick="btnUpdateStatus_Click" OnClientClick="return confirm('Are you sure you want to update the status of the selected rows?')" /> to
                     <asp:DropDownList ID="ddlStatus" runat="server">
                            <asp:ListItem Text="Prom Note Uploaded" Value="Prom Note Uploaded"></asp:ListItem>
                            <asp:ListItem Text="Complete - No Docs" Value="Complete - No Docs"></asp:ListItem>
                            <asp:ListItem Text="Pending" Value="Pending" ></asp:ListItem>
                            <asp:ListItem Text="Requested Docs" Value="Requested Docs" ></asp:ListItem>
                            <asp:ListItem Text="Discharge App Complete" Value="Discharge App Complete" ></asp:ListItem>                            
                        </asp:DropDownList><br /><br />                        
                    <asp:Button ID="btnDeleteRequest" runat="server" Text="Delete Checked Rows" onclick="btnDeleteRequest_Click" OnClientClick="return confirm('Are you sure you want to delete the selected row(s)? This operation cannot be undone')" />
                  </td> 
              </tr> 
               
          </table> 
      </div> 
</asp:Content>

