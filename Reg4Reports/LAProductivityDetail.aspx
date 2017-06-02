<%@ Page Title="Region 4 Reports - Loan Analyst Produtivity Detail" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="LAProductivityDetail.aspx.vb" Inherits="Reg4Reports_LAProductivityDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .rowCount {
            padding-left: 35px;
            font-family: Verdana, sans-serif;
            font-weight: bold;
            font-size: medium;
        }

        /*.gridView-wrapper-div {           
            overflow-y: scroll; overflow-x:hidden;
            height: 200px;
        }*/
}
    </style>
     <script type="text/javascript">
         $(document).ready(function () {
             $('.datepicker').datepicker()
         });
    </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
<!--LA Summary-->
<asp:SqlDataSource ID="dsProductivityReportDetail" runat="server" SelectCommand="p_Report_LACompletionsDetail"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:Region4ReportsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="UserID" />
        <asp:Parameter Name="BeginDate" />
        <asp:Parameter Name="EndDate" />
    </SelectParameters>    
</asp:SqlDataSource>

<!--All Completions-->
<asp:SqlDataSource ID="dsCompletions" runat="server" SelectCommand="p_ReportAllCompletionsByLA" OnSelected="dsCompletions_Selected"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:Region4ReportsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="UserID" />
        <asp:Parameter Name="BeginDate" />
        <asp:Parameter Name="EndDate" />
    </SelectParameters>    
</asp:SqlDataSource>

  

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Productivity Report For <asp:Label ID="lblUserID" runat="server" /> From <asp:Label ID="lblBeginDate" runat="server" /> To <asp:Label ID="lblEndDate" runat="server" /></span>
  </div>
  <div class="panel-body">
    <span class="rowCount">Productivity Summary</span>      
      <asp:GridView ID="GridView1" runat="server" DataSourceID="dsProductivityReportDetail" AllowSorting="true" AutoGenerateColumns="false" 
                 CssClass="table table-hover table-striped" DataKeyNames="UserID" Width="95%" HorizontalAlign="Center">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" />

                <asp:TemplateField HeaderText="TOP Completions" HeaderStyle-HorizontalAlign="Center"> 
                 <ItemTemplate>                 
                     <%# If(Eval("TOP Completions") Is DBNull.Value, "0", Eval("TOP Completions"))%> 
                 </ItemTemplate> 
                </asp:TemplateField>

                 <asp:TemplateField HeaderText="Issue Completions" HeaderStyle-HorizontalAlign="Center"> 
                 <ItemTemplate>                 
                     <%# If(Eval("Issue Completions") Is DBNull.Value, "0", Eval("Issue Completions"))%> 
                 </ItemTemplate> 
                </asp:TemplateField>

               <asp:TemplateField HeaderText="PCA Review Completions" HeaderStyle-HorizontalAlign="Center"> 
                 <ItemTemplate>                 
                     <%# If(Eval("PCA Review Completions") Is DBNull.Value, "0", Eval("PCA Review Completions"))%> 
                 </ItemTemplate> 
                </asp:TemplateField>

                <asp:TemplateField HeaderText="DMCS Refund Completions" HeaderStyle-HorizontalAlign="Center"> 
                 <ItemTemplate>                 
                     <%# If(Eval("DMCS Refund Completions") Is DBNull.Value, "0", Eval("DMCS Refund Completions"))%> 
                 </ItemTemplate> 
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="IBR Completions" HeaderStyle-HorizontalAlign="Center"> 
                 <ItemTemplate>                 
                     <%# If(Eval("IBR Completions") Is DBNull.Value, "0", Eval("IBR Completions"))%> 
                 </ItemTemplate> 
                </asp:TemplateField>           
         </Columns>
        </asp:GridView>

      <span class="rowCount">All Completions - <asp:Label ID="lblCompletionRowCount" runat="server" /> total records <asp:ImageButton ID="btnExportCompletions" runat="server" ImageUrl="images/excel-export.gif" height="50" width="60" CausesValidation="false" ImageAlign="Bottom" OnClick="btnExportCompletions_Click" /></span>      
      <div class="gridView-wrapper-div">        
        <asp:GridView ID="GridView_Completions" runat="server" AllowSorting="true" DataSourceID="dsCompletions" Width="95%" HorizontalAlign="Center" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView">
        <EmptyDataTemplate>
            No records found
        </EmptyDataTemplate>
        <Columns>
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID"  />
            <asp:BoundField DataField="Review Type" HeaderText="Review Type" SortExpression="Review Type"  />
            <asp:BoundField DataField="Account Number" HeaderText="Account Number" SortExpression="Account Number"  />
            <asp:BoundField DataField="Date Assigned" HeaderText="Date Assigned" SortExpression="Date Assigned" HtmlEncode="false" DataFormatString="{0:d}"  />
            <asp:BoundField DataField="Date Completed" HeaderText="Date Completed" SortExpression="Date Completed" HtmlEncode="false" DataFormatString="{0:d}"  /> 
            <asp:BoundField DataField="Time Completed" HeaderText="Time Completed" SortExpression="Time Completed" /> 
            <asp:BoundField DataField="Call Length" HeaderText="Call Length" SortExpression="Call Length" />  
            <asp:BoundField DataField="QC Results" HeaderText="QC Results" SortExpression="QC Results" />        
        </Columns>
        </asp:GridView>
      </div>
  
 </div>
</div>
</asp:Content>

