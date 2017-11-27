<%@ Page Title="Specialty Claims Tracking - Update Batch of Claims" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UpdateBatch.aspx.vb" Inherits="DMCSRefunds_MyRefunds" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>      
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />    
  
    <script type="text/javascript">
        $(document).ready(function () {
            $("#form1").addClass("form-horizontal");

            $('.datepicker').datepicker()
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ToolkitScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release">
 </asp:ToolkitScriptManager>

 <h3>Specialty Claims Tracking</h3>  

 <div>
 <ul class="nav nav-tabs">
  <li><a href="EnterNewClaim.aspx">Enter New Claim</a></li>
  <li><a href="Search.aspx">Search/Update By Account</a></li>
  <li class="active"><a href="UpdateBatch.aspx">Approve Batch</a></li>  
  <li><a href="Upload.aspx">Upload New Batch</a></li>
  <li class="dropdown">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="Reports.aspx">Servicer Files</a></li>
        <li><a href="ProductivityReport.aspx">LA Productivity</a></li>
        <li><a href="ServicerReceipts.aspx">Received By FSA</a></li>  
        <li><a href="ServicerReceiptsCountByMonth.aspx">Received By FSA By Month</a></li>
        <li><a href="AgingClaims.aspx">Aging Claims - Servicer</a></li> 
        <li><a href="AgingClaims_ClaimType.aspx">Aging Claims - Claim Type</a></li>        
    </ul>
  </li>
  <li><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />


<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Create Servicer Files</span>
  </div>
  <div class="panel-body">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>
        <td>
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List" CssClass="alert-danger" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Servicer Name is a required field *" Display="None" ControlToValidate="ddlServicer" />
        <asp:RequiredFieldValidator ID="rfdDischargeTpe" runat="server" ErrorMessage="* Discharge Type is a required field *" Display="None" ControlToValidate="ddlDischargeType" />
        <asp:RequiredFieldValidator ID="rfdDateReceived" runat="server" ErrorMessage="* Date Received is a required field *" Display="None" ControlToValidate="txtDateReceived" />
       </td>
    </tr>
    <tr>
        <td align="right">Servicer Name</td>
        <td align="left"><asp:DropDownList ID="ddlServicer" runat="server" CssClass="inputBox">
         <asp:ListItem Text="" Value="" />
         <asp:ListItem Text="Aspire" Value="aspire" />
         <asp:ListItem Text="Cornerstone" Value="cornerstone" />
         <asp:ListItem Text="COSTEP" Value="costep" />
         <asp:ListItem Text="EDGEucation" Value="edgeucation" />
         <asp:ListItem Text="EdFinancial" Value="edfinancial" />
         <asp:ListItem Text="EdManage" Value="edmanage" />
         <asp:ListItem Text="ECSI" Value="ecsi" />
         <asp:ListItem Text="Granite State" Value="granite state" />
         <asp:ListItem Text="Great Lakes" Value="great lakes" />
         <asp:ListItem Text="KSA" Value="ksa" />
         <asp:ListItem Text="MOHELA" Value="mohela" />
         <asp:ListItem Text="Nelnet" Value="nelnet" />
         <asp:ListItem Text="OSLA" Value="osla" />
         <asp:ListItem Text="PHEAA" Value="pheaa" />
         <asp:ListItem Text="SLMA" Value="slma" />
         <asp:ListItem Text="VSAC" Value="vsac" />
     </asp:DropDownList></td>   
              
    <td align="right">Claim Type</td>
    <td align="left">
     <asp:DropDownList ID="ddlDischargeType" runat="server" CssClass="inputBox">
         <asp:ListItem Text="" Value="" />        
         <asp:ListItem Text="Death" Value="death" />
         <asp:ListItem Text="TLF" Value="TLF" />                 
     </asp:DropDownList></td>                  

    <td align="right">Date Received</td>
    <td align="left"><asp:TextBox ID="txtDateReceived" runat="server" CssClass="datepicker" /></td>
   </tr>
   <tr>
    <td colspan="6" align="center"><br />
         <!--Search Button-->
        <asp:Button runat="server" ID="btnSearch" OnClick="btnSearch_Click" Text="Search" CssClass="btn btn-md btn-primary"
         CausesValidation="true" />
        
         <!--Approve Button-->
         <asp:Button runat="server" ID="btnApprove" OnClick="btnApprove_Click" Text="Complete" CssClass="btn btn-md btn-danger"
         CausesValidation="true" OnClientClick="return confirm('Are you sure that you want to approve the claims below?')" />
    </td>
   </tr>
   </table>  
   </div>
   </div>

     
    
    <!--SqlDataSource for GridView results-->
    <asp:SqlDataSource ID="dsSearchBatch" runat="server" SelectCommand="p_SearchBatch"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>">
        <SelectParameters>
            <asp:Parameter Name="Servicer" Type="String" />
            <asp:Parameter Name="DischargeType" Type="String" />
            <asp:Parameter Name="DateReceived" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

       
 <asp:UpdatePanel ID="UpdatePanel1" runat="server">                 
  <ContentTemplate>                 
                 
                      <asp:GridView ID="GridView1" runat="server" DataSourceID="dsSearchBatch"
                          AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ClaimID" AllowSorting="true">                          
                          <Columns>                               
                              <asp:BoundField DataField="ClaimID" HeaderText="Claim ID" SortExpression="ClaimID"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="AccountNumber" HeaderText="SSN" SortExpression="AccountNumber"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="DischargeType" HeaderText="Discharge Type" SortExpression="DischargeType"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived"
                                  DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
                              <asp:BoundField DataField="DateCompleted" HeaderText="Date Completed" SortExpression="DateCompleted"
                                  DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
                              <asp:TemplateField HeaderText="Approved?" SortExpression="Approve">
                                  <ItemTemplate>
                                      <%#IIf(Boolean.Parse(Eval("Approve").ToString()), "Yes", "No")%></ItemTemplate>
                              </asp:TemplateField>
                          </Columns>
                      </asp:GridView>    
   </ContentTemplate>
   </asp:UpdatePanel>

   <asp:Label ID="lblSearchResultsStatus" runat="server" CssClass="alert-danger" />
                     
</asp:Content>

