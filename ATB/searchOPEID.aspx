<%@ Page Title="Ability to Benefit Search OPE ID" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="searchOPEID.aspx.vb" Inherits="ATB_New_searchOPEID" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        a.selected.static
        {
            border:2px solid red !important;           
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h2>Ability to Benefit Research</h2>
    
<!--Navigation Menu-->
<div>
 <ul id="Ul1" class="nav nav-tabs" data-tabs="tabs">
  <li><a href="searchATB.aspx">Search ATB Findings</a></li>
  <li class="active"><a href="searchOPEID.aspx">Search For OPE IDs</a></li>

  <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Administration <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="admin/AddSchool.aspx">Add ATB Findings</a></li>
        <li><a href="admin/AddNewSchool.aspx">Add New School</a></li>
    </ul>
  </li>   
 </ul>
 </div>
<!--End Navigation Menu-->    
 <br />   
    <table width="100%" cellpadding="4" cellspacing="5" border="0">
        <tr>
            <td valign="top">
                <strong>School Name: </strong>
                <br />
                <asp:TextBox ID="txtSchoolName" runat="server" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-md btn-primary" /><br />
                <asp:RequiredFieldValidator ID="rfdbtnSearch" runat="server" Text="Please enter a school name"
                    ControlToValidate="txtSchoolName" CssClass="warning" />
            </td>
        </tr>
    </table>
    <!--GridView1-->
    <asp:SqlDataSource ID="dsSearchOPEID" runat="server" ConnectionString="<%$ ConnectionStrings:ATBConnectionString %>"
        SelectCommand="p_SearchOPEID" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="SchoolName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <!--GridView1 here-->
    <div id="dvGrid" align="center">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="true"
            DataSourceID="dsSearchOPEID" AllowPaging="true" PageSize="25" CssClass="table table-striped table-bordered table-condensed"
            BorderWidth="1px" DataKeyNames="OPEID" BackColor="White" GridLines="Horizontal"
            CellPadding="3" BorderColor="#E7E7FF" Width="875px" BorderStyle="None" ShowFooter="false">
            <EmptyDataTemplate>
                No school names match your search
            </EmptyDataTemplate>
            <Columns>
                <asp:TemplateField HeaderText="OPE ID" SortExpression="OPEID">
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkOPEID" runat="server" NavigateUrl='<%# Eval("OPEID", "searchATB.aspx?OPEID={0}") %>'
                            Text='<%# Eval("OPEID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="SchoolName" HeaderText="School Name" SortExpression="SchoolName"
                    ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
            </Columns>
            
        </asp:GridView>
    </div>
      
   <asp:Label ID="lblUserID" runat="server" Visible="false" />
   <asp:Label ID="lblUserAdmin" runat="server" Visible="false" />
   <asp:Label ID="lblSortExpression" runat="server" Visible="false" />
</asp:Content>

