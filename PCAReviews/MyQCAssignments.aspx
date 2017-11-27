<%@ Page Title="My QC Assignments" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyQCAssignments.aspx.vb" Inherits="PCAReviews_LAAssignments" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/print.css" media="print" rel="stylesheet" />
    
    <style type="text/css">
        /* increase modal size*/
        .modal-dialog   {
            width: 650px;
        }
    </style>
     <script type="text/javascript">
         $(document).ready(function () {
             $('#NavigationMenu').addClass('active');
         });
      </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown active">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Work <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Review Assignments</a></li>
        <li><a href="MyQCAssignments.aspx">My QC Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports2.aspx">Save New PCA Review</a></li>  
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="ReportCompletionCount.aspx">Completion Count</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="QCCalc.aspx">QC Calculator</a></li>
        <li><a href="QCTierReport.aspx">QC Tier Report</a></li>
        <li><a href="QCUserManager.aspx">QC User Manager</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

 <asp:SqlDataSource ID="dsMyQCAssignments" runat="server" SelectCommand="p_MyQCAssignments" OnSelected="OnSelectedHandlerQCReviews"   
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
     <SelectParameters>
         <asp:Parameter Name="UserID" />
         <asp:Parameter Name="ReviewPeriodMonth" />
         <asp:Parameter Name="ReviewPeriodYear" />
     </SelectParameters>      
</asp:SqlDataSource>

<asp:SqlDataSource ID="dsGS12Users" runat="server" SelectCommand="p_GS12Users"    
  SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />
    
<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>
    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">My QC Assignments</span>
  </div>
  <div class="panel-body"> 
  
   <div id="divSelectionCriteria" style="margin: 10px;">
   
       <label class="form-label">Loan Analyst:</label> 
       <asp:DropDownList ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSourceID="dsGS12Users" DataTextField="UserID" DataValueField="UserID" Enabled="false">
        <asp:ListItem Text="All" Value="All" />
       </asp:DropDownList>
      
      <label class="form-label">Review Period Month:</label>
                <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" CssClass="inputBox">
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
      
                <label class="form-label">Review Period Year:</label>
                <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" CssClass="inputBox">
                            <asp:ListItem Text="" Value="" />    
                            <asp:ListItem Text="2017" Value="2017" />
                            <asp:ListItem Text="2018" Value="2018" />
                           </asp:DropDownList>   
   <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-sm btn-primary" OnClick="btnsearch_Click" /></p>
   </div>

<!--Reassignment Section-->
<asp:Panel ID="pnlReassignmentSection" runat="server" Visible="true" style="padding: 12px; border: 1px solid black; margin: 10px">
    <h5>Reassign QC Assignments</h5>    
    <asp:DropDownList ID="ddlUserIDAssign" runat="server" CssClass="inputBox" AppendDataBoundItems="true" DataSourceID="dsGS12Users" DataTextField="UserID" DataValueField="UserID" ValidationGroup="Reassign">
        <asp:ListItem Text="" Value="" />
    </asp:DropDownList>
    <asp:Button ID="btnReassignQC" runat="server" Text="Assign Checked Refunds to Loan Analyst" ValidationGroup="Reassign"
        OnClick="btnReassignQC_Click" OnClientClick="return confirm('Are you sure that you want to reassign the checked QC assignments to the selected LA?')" CssClass="btn btn-sm btn-danger" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Please select a Loan Analyst" ValidationGroup="Reassign"
        ControlToValidate="ddlUserIDAssign" CssClass="text-info" /> 
</asp:Panel>

   <p><asp:Label ID="lblQCCount" runat="server" CssClass="text-info" />

                        
    <asp:GridView ID="GridView1" runat="server" AllowSorting="true" DataSourceID="dsMyQCAssignments" AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ReviewID">
     <EmptyDataTemplate>
         <span>Oops! <a href="MyQCAssignments.aspx">Try again</a> by selecting another Report Period</span>
     </EmptyDataTemplate>
        <Columns>
             <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" runat="server" />
                </ItemTemplate>
             </asp:TemplateField>
               
              <asp:TemplateField HeaderText="Review ID" SortExpression="ReviewID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ReviewID", "ReviewDetail.aspx?ReviewID={0}#QCTier1")%>'
                        Text='<%# Eval("ReviewID")%>' />
                </ItemTemplate>
            </asp:TemplateField>
       
            <asp:BoundField DataField="GS-11 Reviewer" HeaderText="GS-11 Loan Analyst" SortExpression="GS-11 Reviewer"
             HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="UserID" HeaderText="GS-12 Loan Analyst" SortExpression="UserID"
             HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" />            
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower Number" SortExpression="BorrowerNumber"
             HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="CallLengthActual" HeaderText="Call Length" SortExpression="CallLengthActual"
             HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" />
            <asp:BoundField DataField="ReviewPeriod" HeaderText="Review Period" SortExpression="ReviewPeriod"
             HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateAssigned" HeaderText="Date Assigned" SortExpression="DateAssigned"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="DateCompleted" HeaderText="Date Completed" SortExpression="DateCompleted"
             DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" />               
        
     </Columns>
    </asp:GridView>

   </div>        
  </div>
</ContentTemplate>
</asp:UpdatePanel>

      
    
</asp:Content>

