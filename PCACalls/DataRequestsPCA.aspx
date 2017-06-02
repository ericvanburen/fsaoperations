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
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
 
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">PCA Phone Reviews</a></li>
        <li><a href="MyRehabReviews.aspx">Rehab Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
        <li><a href="SearchRehab.aspx">Rehab Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">PCA Reviews - One PCA</a></li>
        <li><a href="Reports_MultiPCA.aspx">PCA Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsRehab.aspx">Rehab Reviews - One PCA</a></li>
        <li><a href="ReportsRehab_MultiPCA.aspx">Rehab Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="ReportsRehabCallErrors.aspx">Rehab Reviews - LA Errors</a></li>
        <li><a href="MakeAssignments.aspx">Make New Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->

 <asp:SqlDataSource ID="dsDataRequests" runat="server" SelectCommand="p_DataRequestsPCA"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="PCA" />
     </SelectParameters>      
</asp:SqlDataSource>

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">      
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
         <asp:TemplateField SortExpression="ReportPeriod" HeaderStyle-HorizontalAlign="Center" >
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

         <asp:BoundField DataField="ReportPeriod" HeaderText="Report Period" SortExpression="ReportPeriod"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />

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
         <asp:BoundField DataField="c_InitialTalkoff" HeaderText="No Initial Talkoff" HeaderStyle-HorizontalAlign="Center" SortExpression="c_InitialTalkoff" />
         <asp:BoundField DataField="Comments" HeaderText="Comments" HeaderStyle-HorizontalAlign="Center" />         
     </Columns>
    </asp:GridView>

    <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" Text="Export Results to Excel" OnClick="btnExportExcel_Click" />
</asp:Content>

