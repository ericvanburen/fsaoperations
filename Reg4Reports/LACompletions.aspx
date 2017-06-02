<%@ Page Title="Region 4 Reports - Loan Analyst Completions" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="LACompletions.aspx.vb" Inherits="Reg4Reports_LACompletions" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
     <script type="text/javascript">
         $(document).ready(function () {
             $('.datepicker').datepicker()
         });
    </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
 
    <asp:SqlDataSource ID="dsProductivityReport" runat="server" SelectCommand="p_Report_LACompletions"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:Region4ReportsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="BeginDate" />
        <asp:Parameter Name="EndDate" />
    </SelectParameters>    
</asp:SqlDataSource>

    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Loan Analyst Productivity Report</span>
  </div>
  <div class="panel-body">
  <table class="table">
      <tr>
          <td colspan="3"><label class="form-label">Enter the Date Completed Range</label></td>
      </tr>  
      <tr>
            <td valign="top">
            <!--Begin Date Greater Than-->
            <asp:TextBox ID="txtBeginDate" runat="server" class="form-control datepicker" type="text" placeholder="Enter Begin Date" /> <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtBeginDate" ErrorMessage="* Enter a Begin Date *" CssClass="alert-danger" Display="Dynamic" /></td>

             <td valign="top">
            <!--End Date Less Than-->
            <asp:TextBox ID="txtEndDate" runat="server" class="form-control datepicker" type="text" placeholder="Enter End Date"  /> <br /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEndDate" ErrorMessage="* Enter an End Date *" CssClass="alert-danger" Display="Dynamic" /></td>
  
            <td><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-warning" OnClick="btnSearch_Click" /> 
            <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-md btn-danger" style="padding-left: 10px;" Text="Export to Excel" OnClick="btnExportExcel_Click" Visible="false" /></td>
        </tr>
   </table>
    </div>
         <asp:GridView ID="GridView1" runat="server" DataSourceID="dsProductivityReport" AllowSorting="true" AutoGenerateColumns="false" 
             CssClass="table table-hover table-striped" DataKeyNames="UserID" Width="95%" HorizontalAlign="Center" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Loan Analyst" SortExpression="UserID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("UserID")%>' />
         
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="TOP Completions" SortExpression="TOP Completions" HeaderStyle-HorizontalAlign="Center"> 
             <ItemTemplate>                 
                 <%# If(Eval("TOP Completions") Is DBNull.Value, "0", Eval("TOP Completions"))%> 
             </ItemTemplate> 
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Issue Completions" SortExpression="Issue Completions" HeaderStyle-HorizontalAlign="Center"> 
             <ItemTemplate>                 
                 <%# If(Eval("Issue Completions") Is DBNull.Value, "0", Eval("Issue Completions"))%> 
             </ItemTemplate> 
            </asp:TemplateField>

             <asp:TemplateField HeaderText="PCA Review Completions" SortExpression="PCA Review Completions" HeaderStyle-HorizontalAlign="Center"> 
             <ItemTemplate>                 
                 <%# If(Eval("PCA Review Completions") Is DBNull.Value, "0", Eval("PCA Review Completions"))%> 
             </ItemTemplate> 
            </asp:TemplateField>

            <asp:TemplateField HeaderText="DMCS Refund Completions" SortExpression="DMCS Refund Completions" HeaderStyle-HorizontalAlign="Center"> 
             <ItemTemplate>                 
                 <%# If(Eval("DMCS Refund Completions") Is DBNull.Value, "0", Eval("DMCS Refund Completions"))%> 
             </ItemTemplate> 
            </asp:TemplateField>

            <asp:TemplateField HeaderText="IBR Completions" SortExpression="IBR Completions" HeaderStyle-HorizontalAlign="Center"> 
             <ItemTemplate>                 
                 <%# If(Eval("IBR Completions") Is DBNull.Value, "0", Eval("IBR Completions"))%> 
             </ItemTemplate> 
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Total" SortExpression="Total" HeaderStyle-HorizontalAlign="Center" Visible="false"> 
             <ItemTemplate>                 
             </ItemTemplate> 
            </asp:TemplateField>

           
     </Columns>
    </asp:GridView>
   </div>
</asp:Content>

