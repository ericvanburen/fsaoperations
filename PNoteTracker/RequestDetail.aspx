<%@ Page Title="Pnote Tracker Request Details" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RequestDetail.aspx.vb" Inherits="PNoteTracker_RequestDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
   
    <!--FileHolders-->
    <asp:SqlDataSource ID="dsFileHolders" runat="server" 
    ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>" 
    SelectCommand="p_FileHolders" SelectCommandType="StoredProcedure" />

    <!--Images-->
    <asp:SqlDataSource ID="dsImagesForRequestID" runat="server" 
    ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>" 
    SelectCommand="p_ViewImagesForRequestID" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter Name="RequestID" ControlID="lblRequestIDHolder" />
    </SelectParameters>
    </asp:SqlDataSource>

    <!--Update Pnote status-->
    <asp:SqlDataSource ID="dsPNoteRequests" runat="server" ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>"
        UpdateCommand="p_UpdatePNoteStatus" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="RequestID" />
            <asp:Parameter Name="Status" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <!--Request History-->
    <asp:SqlDataSource ID="dsRequestHistory" runat="server" ConnectionString="<%$ ConnectionStrings:PNoteTrackerConnectionString %>"
        SelectCommand="p_RequestHistory" SelectCommandType="StoredProcedure" InsertCommand="p_Insert_PNote_Request_History"
        InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="RequestID" ControlID="lblRequestIDHolder" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="RequestID" />
            <asp:Parameter Name="Status" />
            <asp:Parameter Name="StatusChangeDate" />
        </InsertParameters>
    </asp:SqlDataSource>

   
    <h2>PNote Request Tracking</h2>
    <p><a href="search.aspx">Search</a> | <a href="ExportFile.aspx">Export Files Utility</a></p>
    <div align="left" style="padding-top: 10px; padding-bottom:10px; padding-left:10px; padding-right:10px;">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
               
                <asp:UpdatePanel ID="pnlUpdate1" runat="server">
                    <contenttemplate>
               
                <table width="95%" class="tableStyle1">
                    <tr>
                        <td width="45%" valign="top"><strong>Request ID:</strong><br />
                        <asp:Label ID="lblRequestID" runat="server" Text='<%#Eval("RequestID") %>' /></td>
                            <td width="10%"><br /><br /><br /></td>
                            <td width="45%" valign="top">                            
                        <strong>Import Date:</strong><br />
                        <asp:Label ID="lblReportDate" runat="server" Text='<%#Eval("ReportDate", "{0:d}") %>' /></td>                                                    
                    </tr>
                                            
                    <tr>
                        <td width="45%" valign="top"><strong>Borrower Number:</strong><br />
                        <asp:Label ID="lblBorrowerNumber" runat="server" Text='<%#Eval("BorrowerNumber") %>' /></td>
                        <td width="10%"><br /><br /><br /></td>
                        <td width="45%" valign="top"><strong>Account ID:</strong><br />
                        <asp:Label ID="lblAccountID" runat="server" Text='<%#Eval("AccountID") %>' /></td>                                                
                    </tr>
                    <tr>
                        <td  width="45%" valign="top"><strong>File Holder:</strong><br />
                            <asp:DropDownList ID="ddlFileHolder" runat="server" DataSourceID="dsFileHolders"  
                            AppendDataBoundItems="true" DataTextField="FileHolder" DataValueField="FileHolder" SelectedValue='<%#Eval("FileHolder") %>'> 
                                <asp:ListItem Text="" Value="" />                                
                            </asp:DropDownList>   
                        </td>
                        <td width="10%"><br /><br /><br /></td>
                        <td  width="45%" valign="top"><strong>Request Type:</strong><br />
                        <asp:DropDownList ID="ddlRequest_Type" runat="server" SelectedValue='<%#Eval("Request_Type") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="File" Value="File" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Pnote Only" Value="PNote Only" ></asp:ListItem>                            
                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td width="45%" valign="top"><strong>Status:</strong><br />
                        <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%#Eval("Status") %>'>
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Prom Note Uploaded" Value="Prom Note Uploaded"></asp:ListItem>
                            <asp:ListItem Text="Complete - No Docs" Value="Complete - No Docs"></asp:ListItem>
                            <asp:ListItem Text="Pending" Value="Pending" ></asp:ListItem>
                            <asp:ListItem Text="Requested Docs" Value="Requested Docs" ></asp:ListItem>
                            <asp:ListItem Text="Discharge App Complete" Value="Discharge App Complete" ></asp:ListItem>                            
                        </asp:DropDownList>
                        </td>
                            <td width="10%"><br /><br /><br /></td>
                            <td width="45%" valign="top"><strong>Tag Date:</strong><br />
                        <asp:Label ID="lblTagDate" runat="server" Text='<%#Eval("Tag_Date", "{0:d}") %>' /></td>  
                        </td>
                    </tr>
                    <tr>
                        <td width="45%" valign="top">
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDate_Request_Sent" />
                        <strong>Date Request Sent To File Holder:</strong><br />
                        <asp:TextBox ID="txtDate_Request_Sent" runat="server" Text='<%#Eval("Date_Request_Sent", "{0:d}") %>' /></td>
                        <td width="10%"><br /><br /><br /></td>
                        <td width="45%" valign="top"><strong>Type:</strong><br />
                        <asp:Label ID="lblTag" runat="server" Text='<%#Eval("Tag") %>' /></td>                                                
                    </tr>
                    <tr>
                       <td colspan="3" valign="top"><strong>Comments:</strong><br />
                        <asp:TextBox ID="txtComments" runat="server" Text='<%#Eval("Comments") %>' TextMode="MultiLine" Columns="60" Rows="4" /></td>                                                
                    </tr>
                    <tr>
                        <td colspan="3" align="center"><br /><asp:Button runat="server" OnClick="btnUpdateRequest_Click" ID="btnUpdateRequest" Text="Update Request" /></td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center"><asp:Label runat="server" ID="lblRecordStatus" /></td>
                    </tr>
                                            
                    </table>
                                                       
                 </contenttemplate>
                </asp:UpdatePanel> 
                            
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <h2>Current Images</h2>
                        <asp:GridView ID="gvImages" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="No images are available for this account" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" DataKeyNames="ImageID" 
                         EmptyDataRowStyle-Font-Size="Medium" Width="95%" DataSourceID="dsImagesForRequestID"> 
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
                             <asp:TemplateField HeaderText=" " SortExpression="FileName">
                              <ItemTemplate>                                   
                                    <a href='/PNoteTracker/FileHandler.ashx?fileName=<%# Server.UrlEncode(Eval("FileName")) %>'><%# Eval("FileName") %></a>                                    
                                </ItemTemplate>                            
                            </asp:TemplateField>
                         </Columns>
                     </asp:GridView>

    <h2>Upload New Images</h2>
    <table class="tableStyle2">
        <tr>
            <td>Image 1</td>
            <td><asp:FileUpload ID="Image1Upload" runat="server" /></td>           
            <td><asp:Button ID="btnImage1Upload" runat="Server" Text="Import" OnClick="ImageUpload_Click"/>
            <span><asp:Label ID="lblUploadMessage1" runat="server" /></span></td>
        </tr>
       <tr>
            <td>Image 2</td>
            <td><asp:FileUpload ID="Image2Upload" runat="server" /></td>           
            <td><asp:Button ID="btnImage2Upload" runat="Server" Text="Import" OnClick="ImageUpload_Click"/>
            <span><asp:Label ID="lblUploadMessage2" runat="server" /></span></td>
        </tr>
        <tr>
            <td>Image 3</td>
            <td><asp:FileUpload ID="Image3Upload" runat="server" /></td>           
            <td><asp:Button ID="btnImage3Upload" runat="Server" Text="Import" OnClick="ImageUpload_Click"/>
            <span><asp:Label ID="lblUploadMessage3" runat="server" /></span></td>
        </tr>       
    </table>

         <h2>Request History</h2>
                        <asp:GridView ID="grdRequestHistory" runat="server" AutoGenerateColumns="false" BackColor="White" EmptyDataText="No history is available for this account" BorderColor="#E7E7FF" BorderStyle="None"       
                         BorderWidth="1px" CellPadding="3" GridLines="Horizontal" EmptyDataRowStyle-ForeColor="red" 
                         EmptyDataRowStyle-Font-Size="Medium" Width="95%" DataSourceID="dsRequestHistory"> 
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
                             <asp:BoundField DataField="Status" SortExpression="Status" HeaderText="Status" HeaderStyle-HorizontalAlign="Left" />
                             <asp:BoundField DataField="StatusChangeDate" SortExpression="StatusChangeDate" HeaderStyle-HorizontalAlign="Left" HeaderText="Status Change Date" DataFormatString="{0:d}" />
                         </Columns>
                     </asp:GridView>


<asp:Label ID="lblRequestIDHolder" runat="server" Visible="false" />
<asp:Label ID="lblPreviousStatusValue" runat="server" Visible="false" />

</asp:Content>

