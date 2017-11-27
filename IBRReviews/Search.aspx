<%@ Page Title="Search IBR Reviews" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.vb" Inherits="IBRReviews_Search" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
     <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>  
    <script src="../Scripts/jquery.checkAvailabilityIBR.js" type="text/javascript"></script>  
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
  
       <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker()

            $("#MainContent_txtBorrowerNumber").checkAvailability();

            //Intializes the tooltips  
            $('[data-toggle="tooltip"]').tooltip({
                trigger: 'hover',
                'placement': 'top'
            });
            $('[data-toggle="popover"]').popover({
                trigger: 'hover',
                'placement': 'top'
            });  
        });
      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
 <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">My IBR Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="EnterNewReview.aspx">Enter New Review</a></li>
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyAssignments.aspx">My Assignments</a></li>       
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">Search Reviews</a></li>      
    </ul>
  </li> 

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="ErrorReport.aspx">Error Report</a></li> 
        <li><a href="MakeAssignments.aspx">Make Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>     
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />
<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>" /> 

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Search IBR Reviews</span>
  </div>
  <div class="panel-body">
     <table class="table" border="0">        
     <tr>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Review ID" data-content="The unique Review ID #">Review ID</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The borrower's DMCS borrower number">Borrower Number</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Date Submitted" data-content="The date the review was submitted by the Loan Analyst">Date Submitted</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Loan Analyst" data-content="The Loan Analyst Which Performed the Review">Loan Analyst</a></th>       
     </tr>
     <tr>
         <td valign="top" class="tableColumnCell" colspan="1"><asp:TextBox ID="txtIBRReviewID" runat="server" TabIndex="1" /></td>
         <td valign="top" class="tableColumnCell" colspan="1"><asp:TextBox ID="txtBorrowerNumber" runat="server" TabIndex="2" /></td>
         <td valign="top" class="tableColumnCell" colspan="1">
             From <asp:TextBox ID="txtDateSubmittedBegin" runat="server" CssClass="datepicker" TabIndex="3" /> 
             To <asp:TextBox ID="txtDateSubmittedEnd" runat="server" CssClass="datepicker" TabIndex="4" />
         </td>
         <td valign="top" class="tableColumnCell" colspan="1">
             <asp:ListBox ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSource='<%# GetRoleUsers() %>' TabIndex="5" SelectionMode="Multiple">
                 <asp:ListItem Text="" Value="" />
             </asp:ListBox>
         </td>
         <td valign="top" class="tableColumnCell" colspan="1"> </td>
     </tr>         
     <tr>        
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="PCA" data-content="The PCA the IBR review is for">PCA</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Quarter" data-content="The fiscal quarter of the review">Quarter</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Year" data-content="The fiscal year of the review">Year</a></th>
        <th class="tableColumnHead" colspan="1"><a href="#" data-toggle="popover" title="Month" data-content="The Month the IBR review is for">Month</a></th>
     </tr>
    <tr>        
        <td valign="top" class="tableColumnCell" colspan="1">                  
            <asp:ListBox ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="6" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="true" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />
            </asp:ListBox></td>
        <td valign="top" class="tableColumnCell" colspan="1">
            <asp:ListBox ID="ddlReportQuarter" runat="server" CssClass="inputBox" TabIndex="7" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="1 (Oct, Nov, Dec)" Value="1" />
                <asp:ListItem Text="2 (Jan, Feb, Mar)" Value="2" />
                <asp:ListItem Text="3 (Apr, May, Jun)" Value="3" />
                <asp:ListItem Text="4 (Jul, Aug, Sep)" Value="4" />                    
            </asp:ListBox></td>
        <td valign="top" class="tableColumnCell" colspan="1">               
                <asp:ListBox ID="ddlReportYear" runat="server" CssClass="inputBox" TabIndex="8" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="2018" Value="2018" />
                <asp:ListItem Text="2017" Value="2017" />
                <asp:ListItem Text="2016" Value="2016" />
                <asp:ListItem Text="2015" Value="2015" />                
        </asp:ListBox></td>
        <td valign="top" class="tableColumnCell" colspan="1">
           <asp:ListBox ID="ddlReportMonth" runat="server" CssClass="inputBox" TabIndex="9" SelectionMode="Multiple">
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
           </asp:ListBox>
        </td>
    </tr>    
    <tr>
        <td colspan="4" align="center"><br />
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" TabIndex="8" />
        <asp:Button ID="btnSearchAgain" runat="server" CssClass="btn btn-md btn-warning" Text="Search Again" Visible="false" OnClick="btnSearchAgain_Click" />            
        </td>
    </tr>
     </table>
  </div>
 <!--Row Count Label and Export To Excel-->
 <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Label ID="lblRowCount" runat="server" CssClass="bold" /> <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
        </div>            
</div>
<br />
 <asp:GridView ID="GridView1" runat="server" AllowSorting="true"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="IBRReviewID">
        <Columns>            
            <asp:TemplateField HeaderText="IBR Review ID" SortExpression="IBRReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("IBRReviewID", "IBRReviewDetail.aspx?IBRReviewID={0}")%>'
                        Text='<%# Eval("IBRReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>            
            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportMonth" HeaderText="Month" SortExpression="ReportMonth" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" SortExpression="DateSubmitted" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" DataFormatString="{0:d}" />
            <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" DataFormatString="{0:d}" />
            <asp:BoundField DataField="DueDate" HeaderText="Due Date" SortExpression="DueDate" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" DataFormatString="{0:d}" />
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Agreement_Letter_Signed" HeaderText="Agreement Letter Signed?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="Agreement_Letter_Signed_Date" HeaderText="Date Agreement Letter Was Signed" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Financial_Documentation" HeaderText="Appropriate Financial Documentation?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Dependents" HeaderText="Number of Dependents" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Income" HeaderText="Borrower Income" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Repayment_Amount" HeaderText="Repayment Amount Correct?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Tag" HeaderText="Tag?" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="Comments" HeaderText="FSA Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:BoundField DataField="PCA_Comments" HeaderText="PCA Comments" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="FSA_Conclusions" HeaderText="FSA Conclusions" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />          
        </Columns>
    </asp:GridView>
 </div>
</asp:Content>

