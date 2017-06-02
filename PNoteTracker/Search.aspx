<%@ Page Title="PNote Request Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Search.aspx.vb" Inherits="PNoteTracker_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!--FileHolders-->
    <asp:SqlDataSource ID="dsFileHolders" runat="server" 
    ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>" 
    SelectCommand="p_FileHolders" SelectCommandType="StoredProcedure" />

<h2>PNote Request Tracking Search</h2>
<p><a href="Default.aspx">Home</a> | <a href="search.aspx">Search</a> | <a href="ExportFile.aspx">Export Files Utility</a></p>
<div align="center" class="bg_white">

         <table cellpadding="2" cellspacing="1" border="0" style="border-collapse: collapse;"
             width="100%">
            <tr>
                <td class="searchFormLabel">Request ID:</td>
                <td class="searchFormControl" colspan="3"><asp:TextBox ID="txtRequestID" runat="server" /></td>
            </tr>
            <tr>
                <td class="searchFormLabel">Import Date (Greater Than)</td>
                <td class="searchFormControl"><asp:TextBox ID="txtReportDate" runat="server" /></td>
                <td class="searchFormLabel">Import Date (Less Than)</td>
                <td class="searchFormControl"><asp:TextBox ID="txtReportDateLessThan" runat="server" /></td>
            </tr>
            <tr>
                <td class="searchFormLabel">Borrower Number:</td>
                <td class="searchFormControl"><asp:TextBox ID="txtBorrowerNumber" runat="server" /></td>
                <td class="searchFormLabel">Account ID:</td>
                <td class="searchFormControl"><asp:TextBox ID="txtAccountID" runat="server" /></td>
            </tr>
            <tr>
                <td class="searchFormLabel">File Holder:</td>
                <td class="searchFormControl">
                    <asp:DropDownList ID="ddlFileHolder" runat="server" DataSourceID="dsFileHolders"
                        AppendDataBoundItems="true" DataTextField="FileHolder" DataValueField="FileHolder">
                        <asp:ListItem Text="" Value="" />                        
                    </asp:DropDownList>
                </td>
                <td class="searchFormLabel">Status:</td>
                <td class="searchFormControl"><asp:DropDownList ID="ddlStatus" runat="server">
                            <asp:ListItem Text="" Value="" Selected="True" />
                            <asp:ListItem Text="Prom Note Uploaded" Value="Prom Note Uploaded"></asp:ListItem>
                            <asp:ListItem Text="Complete - No Docs" Value="Complete - No Docs"></asp:ListItem>
                            <asp:ListItem Text="Pending" Value="Pending" ></asp:ListItem>
                            <asp:ListItem Text="Requested Docs" Value="Requested Docs" ></asp:ListItem>
                            <asp:ListItem Text="Discharge App Complete" Value="Discharge App Complete" ></asp:ListItem>                            
                        </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="searchFormLabel">Date Request Sent (Greater Than):</td>
                <td class="searchFormControl"><asp:TextBox ID="txtDate_Request_Sent" runat="server" /></td>
                <td class="searchFormLabel">Date Request Sent (Less Than):</td>
                <td class="searchFormControl"><asp:TextBox ID="txtDate_Request_Sent_LessThan" runat="server" /></td>
            </tr>
            <tr>
                <td colspan="4" align="center"><br /><asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                <asp:Button ID="btnSearchAgain" runat="server" Text="New Search" OnClick="btnSearchAgain_Click" /></td>
            </tr>
            <tr> 
                 <td align="left" colspan="4">
                     <asp:Label ID="lblRowCount" runat="Server" EnableViewState="False" ForeColor="Blue" /> 
                  </td> 
             </tr> 
          </table>
          <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
          
          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="Your search returned no results" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="RequestID" 
                         EmptyDataRowStyle-Font-Size="Medium" OnSorting="GridView1_Sorting" OnPageIndexChanging="GridView1_PageIndexChanging" AllowSorting="true" AllowPaging="true" PageSize="25" Width="95%"> 
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
                            <asp:BoundField DataField="ReportDate" HeaderText="Import Date" SortExpression="ReportDate" DataFormatString="{0:d}" />     
                            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" />
                            <asp:BoundField DataField="AccountID" HeaderText="Acct ID" SortExpression="AccountID" />
                            <asp:BoundField DataField="FileHolder" HeaderText="File Holder" SortExpression="FileHolder" />
                            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                            <asp:BoundField DataField="Tag" HeaderText="Type" SortExpression="Tag" />
                            <asp:BoundField DataField="Date_Request_Sent" HeaderText="Date Request Sent" SortExpression="Date_Request_Sent" DataFormatString="{0:d}" />                           
                         </Columns>
                     </asp:GridView> 
      </div> 
</asp:Content>

