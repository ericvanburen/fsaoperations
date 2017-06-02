<%@ Page Title="PCA Data and Sample Requests" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DataRequestsPCA.aspx.vb" Inherits="PCACalls_DataRequestsPCA" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/print.css" media="print" rel="stylesheet" />
    <script type="text/javascript">
         $(document).ready(function () {
             $('#NavigationMenu').addClass('active');            
         });
      </script>
  </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!--Navigation Menu-->

<!--End Navigation Menu-->

 <asp:SqlDataSource ID="dsDataRequests" runat="server" SelectCommand="p_DataRequestsPCA"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="PCA" />
     </SelectParameters>      
</asp:SqlDataSource>

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">      
</asp:SqlDataSource>
<br />
<h4>Data Requests For PCA <asp:Label ID="lblPCALabel" runat="server" /></h4>
<asp:GridView ID="GridView1" runat="server" DataSourceID="dsDataRequests" AllowSorting="true" AllowPaging="true" PageSize="25" OnRowDataBound="GridView1_RowDataBound"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="DataRequestID">
     <EmptyDataTemplate>
         <span>Oops! <a href="DataRequests.aspx">Try again</a> by selecting another PCA</span>
     </EmptyDataTemplate>
         <Columns>
             
         <asp:BoundField DataField="DataRequestID" HeaderText="Data Request ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" ReadOnly="true" />
         <asp:TemplateField SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" >
             <HeaderTemplate>
                 PCA: 
                 <asp:DropDownList ID="ddlPCA" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCA" 
                     AutoPostBack="true" OnSelectedIndexChanged="ddlPCA_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value="All" />
                 </asp:DropDownList>
             </HeaderTemplate>
             <ItemTemplate>
                 <%#Eval("PCA")%>
             </ItemTemplate>
         </asp:TemplateField>

         <asp:BoundField DataField="ReviewPeriod" HeaderText="Review Period" SortExpression="ReviewPeriod"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="Completed" HeaderText="Completed?" SortExpression="Completed"
              HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
          
             <asp:BoundField DataField="DataReceiptDate" HeaderText="Data Receipt Date" SortExpression="DataReceiptDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="SampleReceiptDate" HeaderText="Sample Receipt Date" SortExpression="SampleReceiptDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
         <asp:BoundField DataField="CDReceiptDate" HeaderText="CD Receipt Date" SortExpression="CDReceiptDate"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
                  
         <asp:BoundField DataField="c_CallLength" HeaderText="Wrong Call Length" HeaderStyle-HorizontalAlign="Center" SortExpression="c_CallLength" />
         <asp:BoundField DataField="c_AccountType" HeaderText="Not ED Accounts" HeaderStyle-HorizontalAlign="Center" SortExpression="c_AccountType" />
         <asp:BoundField DataField="c_MissingCalls" HeaderText="Calls Missing from CD" HeaderStyle-HorizontalAlign="Center" SortExpression="c_MissingCalls" />
         <asp:BoundField DataField="c_CallDueDate" HeaderText="Missing Call Due Date" HeaderStyle-HorizontalAlign="Center" SortExpression="c_CallDueDate" />
         <asp:BoundField DataField="c_NotepadMatch" HeaderText="Recording Notepad Mismatch" HeaderStyle-HorizontalAlign="Center" SortExpression="c_NotepadMatch" />
         <asp:BoundField DataField="c_BadRecording" HeaderText="Corrupted Recording" HeaderStyle-HorizontalAlign="Center" SortExpression="c_BadRecording" />
         <asp:BoundField DataField="Comments" HeaderText="Comments" HeaderStyle-HorizontalAlign="Center" />         
     </Columns>
    </asp:GridView>

    <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" Text="Export Results to Excel" OnClick="btnExportExcel_Click" />
</asp:Content>

