<%@ Page Title="QC Tier Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="QCTierReport.aspx.vb" Inherits="PCAReviews_QCTierReport" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
     <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" media="print" href="print.css" />
    <style type="text/css">
        .inputBox {
            height: 25px;
        }

    </style>
    <script type="text/javascript">
         $(document).ready(function () {
             $('.datepicker').datepicker()             
         });
    </script> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<!--Navigation Menu-->
<div class="hidden-print">
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">Save New PCA Review Old</a></li>
        <li><a href="Reports2.aspx">Save New PCA Review</a></li>
        <li><a href="Reports_SavedReports.aspx">Search PCA Reviews</a></li>       
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
        <li><a href="QCCalc.aspx">QC Calculator</a></li>
        <li><a href="QCTierReport.aspx">QC Tier Report</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<p><br /></p>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">QC Tier1 and Tier 2 Report</span>
  </div>
  <div class="panel-body">
   
    <label class="form-label">QC Start Date:</label>
    <asp:TextBox ID="txtBeginDate" runat="server" CssClass="inputBox datepicker" TabIndex="1" />

    <label class="form-label">QC End Date:</label>
    <asp:TextBox ID="txtEndDate" runat="server" CssClass="inputBox datepicker" TabIndex="2" />

    <label class="form-label">Review Period:</label>
    <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" CssClass="inputBox" TabIndex="3">
        <asp:ListItem Text="" Value="" />        
        <asp:ListItem Text="01" Value="01" />
        <asp:ListItem Text="02" Value="02" />
        <asp:ListItem Text="03" Value="03" />
        <asp:ListItem Text="04" Value="04" />
        <asp:ListItem Text="05" Value="05" />
        <asp:ListItem Text="06" Value="06" />
        <asp:ListItem Text="07" Value="07" />
        <asp:ListItem Text="08" Value="08" />
        <asp:ListItem Text="09" Value="09" />
        <asp:ListItem Text="10" Value="10" />
        <asp:ListItem Text="11" Value="11" />
        <asp:ListItem Text="12" Value="12" />
    </asp:DropDownList>
           
      <asp:dropdownlist id="ddlReviewPeriodYear" runat="server" cssclass="inputBox" tabindex="4">
        <asp:ListItem Text="" Value="" />    
        <asp:ListItem Text="2016" Value="2016" />
        <asp:ListItem Text="2017" Value="2017" />
      </asp:dropdownlist>
      <br /><br />
    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" /> 
    <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-md btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
    <asp:Button ID="btnSearchAgain" runat="server" Text="Search Again" CssClass="btn btn-md btn-info" OnClick="btnSearchAgain_Click" Visible="false" />

    <br /><br />
    <table class="table-bordered progress-striped " width="95%" cellpadding="4" cellspacing="4">
    <tr>
        <th class="alert-info" colspan="14">QC Tier Data</th>
    </tr>
    <tr>
        <td>
             <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-striped" Font-Size="Small" Font-Names="Calibri">
            <Columns>
                <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ReviewID", "ReviewDetail.aspx?ReviewID={0}")%>'
                        Text='<%# Eval("ReviewID")%>' />
                </ItemTemplate>
                </asp:TemplateField> 

                <asp:BoundField DataField="Loan Analyst" HeaderText="Loan Analyst" SortExpression="Loan Analyst" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="BorrowerNumber" HeaderText="BorrowerNumber" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="Review Period" HeaderText="Review Period" SortExpression="ReviewPeriod" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="QC Tier 1 Person" HeaderText="QC Tier 1 Person" SortExpression="QC Tier 1 Person" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="QC Tier 1 Submit Date" HeaderText="QC Tier 1 Submit Date" SortExpression="QC Tier 1 Submit Date" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:d}" />
                <asp:BoundField DataField="QC Tier 1 Comments" HeaderText="QC Tier 1 Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                <asp:BoundField DataField="QC Tier 2 Person" HeaderText="QC Tier 2 Person" SortExpression="QC Tier 2 Person" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="QC Tier 2 Submit Date" HeaderText="QC Tier 2 Submit Date" SortExpression="QC Tier 2 Submit Date" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:d}" />
                <asp:BoundField DataField="QC Tier 2 Comments" HeaderText="QC Tier 2 Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            </Columns>
            </asp:GridView>
        </td>
    </tr>
    </table> 
  </div>
</div>
</asp:Content>

