<%@ Page Title="Closed School Search" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <style>
    .columnHide
    {
        display:none;    
    }
    </style>

     <script type="text/javascript">
         $(document).ready(function () {
             $('.datepicker').datepicker()
         });
    </script>  
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
  
    <asp:SqlDataSource ID="dsState" runat="server" ConnectionString="<%$ ConnectionStrings:ClosedSchoolConnectionString %>"
        SelectCommand="p_States" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource ID="dsCountryForeign" runat="server" ConnectionString="<%$ ConnectionStrings:ClosedSchoolConnectionString %>"
        SelectCommand="p_CountryForeign" SelectCommandType="StoredProcedure" />    
 <br />  
  
   <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Closed School Search</span>
  </div>
  <div class="panel-body">
  <table class="table">
       <tr>
            <td align="right"><label class="form-label">OPEID:</label></td>
            <td align="left"><asp:TextBox ID="txtOPEID" runat="server" /></td>
            <td align="right"><label class="form-label">Closed Date:</label></td>
            <td align="left"><asp:TextBox ID="txtClosedDate" runat="server" CssClass="datepicker" /> (greater than)</td>
        </tr>
        <tr>
            <td align="right"><label class="form-label">School Name:</label></td>
            <td align="left"><asp:TextBox ID="txtSchoolName" runat="server" /></td>
            <td align="right"><label class="form-label">Location:</label></td>
            <td align="left"><asp:TextBox ID="txtLocation" runat="server" /></td>
        </tr>
        <tr>
            <td align="right"><label class="form-label">Address:</label></td>
            <td align="left"><asp:TextBox ID="txtAddress" runat="server" /></td>
            <td align="right"><label class="form-label">City:</label></td>
            <td align="left"><asp:TextBox ID="txtCity" runat="server" /></td>
        </tr>
        <tr>
            <td align="right"><label class="form-label">State:</label></td>
            <td align="left">
            <asp:DropDownList ID="ddlState" runat="server" DataSourceID="dsState" DataTextField="State" DataValueField="State" AppendDataBoundItems="true">
                <asp:ListItem Text="" Value="" />
            </asp:DropDownList>
            </td>
            <td align="right"><label class="form-label">ZIP Code:</label></td>
            <td align="left"><asp:TextBox ID="txtZipCode" runat="server" /></td>
        </tr>
        <tr>
            <td align="right"><label class="form-label">Country:</label></td>
            <td align="left"><asp:DropDownList ID="ddlCountryForeign" runat="server" DataSourceID="dsCountryForeign" DataTextField="CountryForeign" DataValueField="CountryForeign" AppendDataBoundItems="true">
                <asp:ListItem Text="" Value="" />
            </asp:DropDownList></td>
            <td align="right"> </td>
            <td align="left"> </td>
        </tr>
        <tr>            
            <td colspan="4"><asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-md btn-primary" /> <asp:Button ID="btnClearForm" runat="server" Text="Clear Form" OnClick="btnClearForm_Click" CssClass="btn btn-md btn-alert" /><br />
            <asp:Label ID="lblRecordCount" runat="server" /></td>
        </tr>
    </table>
    </div>
    </div>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" ForeColor="#333333" GridLines="None" Width="98%" AllowSorting="false">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="OPEID" HeaderText="OPEID" SortExpression="OPEID" />
            <asp:BoundField DataField="SchoolName" HeaderText="School" SortExpression="SchoolName" />
            <asp:BoundField DataField="ClosedDate" DataFormatString="{0:d}" HeaderText="Closed Date" SortExpression="ClosedDate" />
            <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
            <asp:BoundField DataField="Address" HeaderText="Address" ItemStyle-CssClass="columnHide" HeaderStyle-CssClass="columnHide" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
            <asp:BoundField DataField="ZipCode" HeaderText="ZIP Code" ItemStyle-CssClass="columnHide" HeaderStyle-CssClass="columnHide" />
            <asp:BoundField DataField="CountryForeign" HeaderText="Country" ItemStyle-CssClass="columnHide" HeaderStyle-CssClass="columnHide" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <br />
    <div align="center">
        <asp:Button ID="btnExportExcel" runat="server" Text="Export to Excel" OnClick="btnExportExcel_Click" Visible="false" CssClass="btn btn-md btn-info" />
    </div>

    <div align="left">
        <p><i>Last Updated 01/10/14</i></p>
    </div>
</asp:Content>