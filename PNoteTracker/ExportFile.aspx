<%@ Page Title="Pnote Tracking File Export" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ExportFile.aspx.vb" Inherits="PNoteTracker_ExportFile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <!--FileHolders-->
    <asp:SqlDataSource ID="dsFileHolders" runat="server" 
    ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>" 
    SelectCommand="p_FileHolders" SelectCommandType="StoredProcedure" />

    <!--Request History-->
    <asp:SqlDataSource ID="dsPNoteRequestsHistory" runat="server" ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>"
        InsertCommand="p_Insert_PNote_Request_History" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="RequestID" />
            <asp:Parameter Name="Status" />
            <asp:Parameter Name="StatusChangeDate" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <h2>PNote Request Tracking File Export Utility</h2>
    <p><a href="Default.aspx">Home</a> | <a href="search.aspx">Search</a> | Export Files Utility</p>
     <div align="center" class="bg_white">
         <table cellpadding="2" cellspacing="1" border="0" style="border-collapse: collapse;"
             width="100%">
                                      
             <tr>
                <td>                 
                Export Pending Records For
                    <asp:DropDownList ID="ddlFileHolder" runat="server" DataSourceID="dsFileHolders" AutoPostBack="true"
                        DataTextField="FileHolder" DataValueField="FileHolder" AppendDataBoundItems="true">
                        <asp:ListItem Text="" Value="" Selected="True" />               
                    </asp:DropDownList>
                    <asp:Button ID="btnExportToExcel" runat="server" Text="Export Records To Excel" onclick="btnExportToExcel_Click" />
                </td>
             </tr>
             <tr> 
                 <td align="center">

                 <asp:SqlDataSource ID="dsPNoteRequests" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>" 
                    SelectCommand="p_DefaultListExportFile" SelectCommandType="StoredProcedure" 
                    UpdateCommand="p_UpdatePNoteStatus" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlFileHolder" ConvertEmptyStringToNull="true" Name="FileHolder" PropertyName="SelectedValue" Type="String" />                   
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RequestID" />
                        <asp:Parameter Name="Status" />
                        <asp:Parameter Name="Date_Request_Sent" />
                    </UpdateParameters>
                  </asp:SqlDataSource>

                  
                  <asp:GridView ID="gvdetails" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="No requests match your criteria" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="RequestID" 
                         OnPageIndexChanging="gvdetails_PageIndexChanging" EmptyDataRowStyle-Font-Size="Medium" AllowSorting="true" AllowPaging="true" PageSize="25" Width="95%"
                         DataSourceID="dsPNoteRequests"> 
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
                     
                     
                  </td> 
              </tr> 
               
          </table> 
      </div> 
</asp:Content>

