<%@ Page Title="Specialty Claims Tracking - Power Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PowerSearch.aspx.vb" Inherits="SpecialtyClaims_PowerSearch" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>      
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" /> 
   
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker()
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Specialty Claims Tracking</h3>  

 <div>
 <ul class="nav nav-tabs">
  <li><a href="EnterNewClaim.aspx">Enter New Claim</a></li>
  <li><a href="Search.aspx">Search/Update By Account</a></li>
  <li><a href="UpdateBatch.aspx">Approve Batch</a></li>  
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
  <li class="active"><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />


<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Search Claims</span>
  </div>
  <div class="panel-body">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>        
        <td align="right">Account Number</td>
        <td align="left"><asp:TextBox ID="txtAccountNumber" runat="server" /></td>
        <td align="right">Borrower Name</td>
        <td align="left"><asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" /></td> 
    </tr>

    <tr>
        <td align="right">Claim Type</td>
        <td align="left">        
             <asp:ListBox ID="ddlDischargeType" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="ATB" Value="atb" />
                    <asp:ListItem Text="ATB Appeal" Value="atb appeal" />
                    <asp:ListItem Text="CLS" Value="cls" />
                    <asp:ListItem Text="CLS Appeal" Value="cls appeal" />
                    <asp:ListItem Text="Death" Value="death" />
                    <asp:ListItem Text="DQS" Value="dqs" />
                    <asp:ListItem Text="DQS Appeal" Value="dqs appeal" />
                    <asp:ListItem Text="Fraud" Value="fraud" />
                    <asp:ListItem Text="ID Theft" Value="id theft" />
                    <asp:ListItem Text="ID Theft Appeal" Value="id theft appeal" />
                    <asp:ListItem Text="Ineligible Borrower" Value="ineligible borrower" />
                    <asp:ListItem Text="Perkins Cancellation" Value="perkins cancellation" />
                    <asp:ListItem Text="TLF" Value="tlf" />
                    <asp:ListItem Text="Unenforceable" Value="unenforceable" />
                    <asp:ListItem Text="UNP" Value="unp" />
                    <asp:ListItem Text="UNP Appeal" Value="unp appeal" />
                    <asp:ListItem Text="UNS" Value="uns" />
                    <asp:ListItem Text="UNS Appeal" Value="uns appeal" />
                    <asp:ListItem Text="9-11" Value="9-11" />
             </asp:ListBox>
         </td>
         <td align="right">Servicer Name</td>
         <td align="left">
                        <asp:ListBox ID="ddlServicer" runat="server" CssClass="inputBox" SelectionMode="Multiple">
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
                        </asp:ListBox>
                   </td>         
         </tr>
         <tr>
            <td align="right">Date Received</td>
            <td align="left">
            <asp:TextBox ID="txtDateReceivedGreaterThan" runat="server" CssClass="datepicker" /> (>=)<br />
            <asp:TextBox ID="txtDateReceivedLessThan" runat="server" CssClass="datepicker" /> (<=)
            </td>
             <td align="right">Date Completed</td>
             <td align="left">
                 <asp:TextBox ID="txtDateCompletedGreaterThan" runat="server" CssClass="datepicker" />
                 (>=)<br />
                 <asp:TextBox ID="txtDateCompletedLessThan" runat="server" CssClass="datepicker" />
                 (<=)
             </td> 
         </tr>      
         <tr>
            <td align="right">Approved?</td>
            <td align="left">
                <asp:DropDownList ID="ddlApprove" runat="server" CssClass="inputBox">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>
            </td>
             <td align="right">Servicer Informed Date</td>
                <td align="left">
                        <asp:TextBox ID="txtServicerInformedDateGreaterThan" runat="server" CssClass="datepicker" /> (>=)<br />
                        <asp:TextBox ID="txtServicerInformedDateLessThan" runat="server" CssClass="datepicker" /> (<=)
                </td>
         </tr>
         <tr>
             <td align="right">Loan Analyst</td>
             <td align="left">
                 <asp:ListBox ID="ddlLoanAnalyst" runat="server" CssClass="inputBox" SelectionMode="Multiple"
                     AppendDataBoundItems="true">
                     <asp:ListItem Text="" Value="" />
                 </asp:ListBox>
             </td>
             <td align="right">Incomplete Claims?</td>
             <td align="left">
                 <asp:DropDownList ID="ddlIsNotComplete" runat="server" CssClass="inputBox">
                     <asp:ListItem Text="" Value="" />
                     <asp:ListItem Text="No" Value="No" />
                     <asp:ListItem Text="Yes" Value="Yes" />
                 </asp:DropDownList>
             </td>
         </tr>
         <tr>
            <td align="right">Date Loaded</td>
            <td align="left">
                <asp:TextBox ID="txtDateLoadedGreaterThan" runat="server" CssClass="datepicker" /> (>=)<br />
                <asp:TextBox ID="txtDateLoadedLessThan" runat="server" CssClass="datepicker" /> (<=)
            </td>
             <td align="right">Comments</td>
             <td align="left"><asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="204px" /></td>            
         </tr>  
         <tr>
            <td colspan="4" align="center"><asp:Button ID="btnSearch" runat="server" CssClass="btn btn-lg btn-primary" Text="Search" OnClick="btnSearch_Click" /></td>
         </tr>
         </table>
        </div>
    </div>
 
 <br />
 <!--Row Count Label and Export To Excel-->
 <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Label ID="lblRowCount" runat="server" CssClass="bold" /> <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
        </div>            
</div>
 
 <br />

    <asp:GridView ID="GridView1" runat="server" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ClaimID" OnSorting="GridView1_Sorting">
      <RowStyle Font-Size="Small" Font-Names="Calibri" />
      <HeaderStyle Font-Size="Small" Font-Names="Calibri" />
        <Columns>     
            <asp:TemplateField HeaderText="Account Number" SortExpression="AccountNumber" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Style="position: relative" Text='<%#HideNumber(Eval("AccountNumber").ToString())%>' />
                </ItemTemplate>
            </asp:TemplateField>  
            <asp:BoundField DataField="BorrowerName" HeaderText="Name" SortExpression="BorrowerName"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DischargeType" HeaderText="Discharge Type" SortExpression="DischargeType"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
            <asp:BoundField DataField="DateLoaded" HeaderText="Date Loaded" SortExpression="DateLoaded"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
            <asp:TemplateField HeaderText="Approved?" SortExpression="Approve">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Approve").ToString()), "Yes", "No")%></ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DateCompleted" HeaderText="Date Completed" SortExpression="DateCompleted"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
            <asp:BoundField DataField="ServicerInformedDate" HeaderText="Servicer Informed Date" SortExpression="ServicerInformedDate"
                DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
            <asp:BoundField DataField="LoanAnalyst" HeaderText="Loan Analyst" SortExpression="LoanAnalyst"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Comments" HeaderText="Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
        </Columns>
    </asp:GridView>
<asp:Label ID="lblSortExpression" runat="server" Visible="false" />
<asp:Label ID="lblUserID" runat="server" Visible="true" />
</asp:Content>

