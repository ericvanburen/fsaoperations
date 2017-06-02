<%@ Page Title="My PCA Complaints" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyPCAComplaints.aspx.vb" Inherits="Issues_MyPCAComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<h3>Operations Issues</h3>

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Enter New Issue <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="PCAComplaint_Add.aspx">PCA Complaint</a></li>       
    </ul>
  </li>  
  <li class="dropdown active">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Issues <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="MyPCAComplaints.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search Issues <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="PCAComplaintSearch.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

<asp:SqlDataSource ID="dsMyPCAComplaints" runat="server" SelectCommand="p_MyPCAComplaints"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="UserID" Type="String" />
        <asp:Parameter Name="DateResolved" Type="Int32" />
    </SelectParameters>
 </asp:SqlDataSource>

 <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">My PCA Complaints</span>
  </div>
  <div class="panel-body">
 
 <div class="pull-right">
     Completion Status: 
     <asp:DropDownList ID="ddlDateResolved" runat="server" AutoPostBack="true">
        <asp:ListItem Text="Pending" Value="0" Selected="True" />
        <asp:ListItem Text="Completed" Value="1" />        
     </asp:DropDownList>
 </div>
 <br />
 <asp:GridView ID="GridView1" runat="server" DataSourceID="dsMyPCAComplaints" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ComplaintID">
        <Columns>            
            <asp:TemplateField HeaderText="Complaint ID" SortExpression="ComplaintID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ComplaintID", "PCAComplaintDetail.aspx?ComplaintID={0}") %>'
                        Text='<%# Eval("ComplaintID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
             <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />
             <asp:BoundField DataField="BorrowerName" HeaderText="Borrower Name" 
                HeaderStyle-HorizontalAlign="Center" SortExpression="BorrowerName" />               
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />           
            <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" /> 
            <asp:BoundField DataField="DateResolved" HeaderText="Date Resolved" SortExpression="DateResolved"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />         
        </Columns>
    </asp:GridView>

  </div>
</div>
</asp:Content>

