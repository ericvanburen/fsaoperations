<%@ Page Title="PCA Call Monitoring - Report Summary" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Reports.aspx.vb" Inherits="PCACalls_Report_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
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

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <%--<li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Enter New Review <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="NewReview.aspx">PCA Review</a></li>
        <li><a href="NewRehabReview.aspx">Rehab Review</a></li>
    </ul>
  </li>--%>

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">PCA Phone Reviews</a></li>
        <li><a href="MyRehabReviews.aspx">Rehab Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
        <li><a href="SearchRehab.aspx">Rehab Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">PCA Reviews - One PCA</a></li>
        <li><a href="Reports_MultiPCA.aspx">PCA Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsRehab.aspx">Rehab Reviews - One PCA</a></li>
        <li><a href="ReportsRehab_MultiPCA.aspx">Rehab Reviews - Multiple PCAs</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="ReportsRehabCallErrors.aspx">Rehab Reviews - LA Errors</a></li>
        <li><a href="MakeAssignments.aspx">Make New Assignments</a></li>
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->

<p> </p>

<asp:SqlDataSource ID="dsCallDates" runat="server" SelectCommand="p_ReportCallDates"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
    </SelectParameters>    
</asp:SqlDataSource>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">PCA Review Report - One PCA</span>
  </div>
  <div class="panel-body">
  <table class="table">
        <tr>
            <td valign="top">
            <!--PCA--> 
            <label class="form-label">PCA:</label>       
             <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="1" AutoPostBack="true">
                 <asp:ListItem Text="" Value="" />
                 <asp:ListItem Value="1" Text="Account Control Technology"></asp:ListItem>
                 <asp:ListItem Value="2" Text="Allied Interstate"></asp:ListItem>
                 <asp:ListItem Value="3" Text="CBE Group"></asp:ListItem>
                 <asp:ListItem Value="4" Text="Coast Professional"></asp:ListItem>
                 <asp:ListItem Value="5" Text="Collection Technology"></asp:ListItem>
                 <asp:ListItem Value="6" Text="ConServe"></asp:ListItem>
                 <asp:ListItem Value="7" Text="Delta Management Associates"></asp:ListItem>
                 <asp:ListItem Value="8" Text="Diversified Collection Systems"></asp:ListItem>
                 <asp:ListItem Value="9" Text="Enterprise Recovery Systems"></asp:ListItem>
                 <asp:ListItem Value="10" Text="EOS-Collecto"></asp:ListItem>
                 <asp:ListItem Value="11" Text="FAMS"></asp:ListItem>
                 <asp:ListItem Value="12" Text="FMS"></asp:ListItem>
                 <asp:ListItem Value="13" Text="GC Services"></asp:ListItem>
                 <asp:ListItem Value="14" Text="Immediate Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="15" Text="National Recoveries"></asp:ListItem>
                 <asp:ListItem Value="16" Text="NCO Financial Systems"></asp:ListItem>
                 <asp:ListItem Value="17" Text="Pioneer Credit Recovery"></asp:ListItem>
                 <asp:ListItem Value="18" Text="Premiere Credit of North America"></asp:ListItem>
                 <asp:ListItem Value="19" Text="Progressive Financial Services"></asp:ListItem>
                 <asp:ListItem Value="20" Text="Van Ru Credit Corp"></asp:ListItem>
                 <asp:ListItem Value="21" Text="West Asset Management"></asp:ListItem>
                 <asp:ListItem Value="22" Text="Windham Professionals"></asp:ListItem>
             </asp:DropDownList><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPCAID" ErrorMessage="* Select a PCA *" CssClass="alert-danger" Display="Dynamic" />
            </td>
            <td valign="top">
            <!--Call Date Greater Than-->
            <label class="form-label">Call Date:</label>
            <asp:DropDownList ID="ddlCallDate" runat="server" TabIndex="2" DataSourceID="dsCallDates" DataTextField="CallDate" DataValueField="CallDate" /> <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlCallDate" ErrorMessage="* Enter a Begin Call Date *" CssClass="alert-danger" Display="Dynamic" /></td>

             <td valign="top">
            <!--Call Date Less Than-->
            <label class="form-label">Call Date:</label>
            <asp:TextBox ID="txtCallDateEnd" runat="server" CssClass="datepicker" TabIndex="3" /> <br />(less than)<br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCallDateEnd" ErrorMessage="* Enter a End Call Date *" CssClass="alert-danger" Display="Dynamic" /></td>
            
        </tr>
        
        <tr>
            <td colspan="3" align="center">
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" /> 
            <asp:Button ID="btnSaveReview" runat="server" Text="Save Report" OnClientClick="if ( !confirm('Are you sure you want to save this as a final report?')) return false" CssClass="btn btn-md btn-danger" OnClick="btnSaveReview_Click" Visible="false" /><br />
            <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" /></td>
        </tr>
</table>
</div>
</div>

<br />
<span class="h4">Population Size: <asp:Label ID="lblPopulationSize" runat="server" /></span>

<table class="table-bordered" width="95%" cellpadding="4">
<thead>
    <tr>
        <th>Metric</th>
        <th class="text-right">Total</th>
        <th class="text-right">% of Total</th>
    </tr>
</thead>
<tr>
    <td>Accounts With One Error or More</td>
    <td class="text-right"><asp:Label ID="lblTotal_AnyErrors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblTotal_AnyErrors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Improper or Incorrect Identification of Borrower or Third Party</td>
    <td class="text-right"><asp:Label ID="lblScore_CorrectID_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_CorrectID_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>Mini-Miranda Not Provided</td>
    <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_MiniMiranda_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>Accurate Information Not Provided</td>
    <td class="text-right"><asp:Label ID="lblScore_Accuracy_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Accuracy_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>Incomplete or Inaccurate Notepad</td>
    <td class="text-right"><asp:Label ID="lblScore_Notepad_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Notepad_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>PCA Did Not Use Professional Tone</td>
    <td class="text-right"><asp:Label ID="lblScore_Tone_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Tone_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>PCA Was Not Responsive to the Borrower</td>
    <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_PCAResponsive_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>PCA Received a Complaint</td>
    <td class="text-right"><asp:Label ID="lblComplaint_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblComplaint_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>Complaint Not Submitted to FSA</td>
    <td class="text-right"><asp:Label ID="lblIMF_Timely_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblIMF_Timely_Errors_Percent" runat="server" /></td>
</tr>
</table>
<br />
<asp:SqlDataSource ID="dsPreviousReviews" runat="server" SelectCommand="p_SavedReviews"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>" DeleteCommand="DELETE FROM Reviews WHERE ReviewID=@ReviewID">
    <SelectParameters>
        <asp:Parameter Name="PCAID" />
    </SelectParameters>
    <DeleteParameters>
       <asp:Parameter Name="ReviewID" />
   </DeleteParameters>
</asp:SqlDataSource>

<asp:Button ID="btnExportExcel" runat="server" Text="Export Records to Excel" CssClass="btn btn-md btn-danger" OnClick="btnExcelExport_Click" Visible="false" />

<h3>Saved Reports</h3>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" 
DataKeyNames="ReviewID" DataSourceID="dsPreviousReviews" OnRowDataBound="GridView1_OnRowDataBound">
<EmptyDataTemplate>
    No Saved Reviews For This PCA
</EmptyDataTemplate>
<RowStyle Font-Size="X-Small" />
<HeaderStyle Font-Size="Small" BackColor="#EEEEEE" Font-Names="Calibri" />
        <Columns>          
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="cbRows" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Report">   
                <ItemTemplate>
                    <asp:HyperLink id="hypViewAttachment" runat="server" NavigateUrl='<%# String.Format("ReviewAttachments/{0}", Eval("Attachment")) %>' Text='View' Target="_blank" /><br />
                    <asp:HyperLink ID="hypUploadAttachment" runat="server" NavigateUrl='<%# Eval("ReviewID", "AttachmentManager.aspx?ReviewID={0}&Action=Upload") %>' Text='Upload' Target="_blank" /><br />
                    <asp:HyperLink ID="hypDeleteAttachment" runat="server" NavigateUrl='<%# Eval("ReviewID", "AttachmentManager.aspx?ReviewID={0}&Action=Delete") %>' Text='Delete' Target="_blank" />               
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="DateEntered" HeaderText="Date Entered" SortExpression="DateEntered" DataFormatString="{0:d}" HtmlEncode="false" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportQuarter" HeaderText="Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ReportYear" HeaderText="Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Total_AnyErrors" HeaderText="Accounts With One Error or More" SortExpression="Total_AnyErrors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_CorrectID_Errors" HeaderText="Improper or Incorrect Identification" SortExpression="Score_CorrectID_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_MiniMiranda_Errors" HeaderText="Mini-Miranda Not Provided" SortExpression="Score_MiniMiranda_Errors" HeaderStyle-HorizontalAlign="Center" />
		    <asp:BoundField DataField="Score_Accuracy_Errors" HeaderText="Accurate Information Not Provided" SortExpression="Score_Accuracy_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_Notepad_Errors" HeaderText="Incomplete or Inaccurate Notepad" SortExpression="Score_Notepad_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_PCAResponsive_Errors" HeaderText="PCA Was Not Responsive" SortExpression="Score_PCAResponsive_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Complaint_Errors" HeaderText="PCA Received Complaint" SortExpression="Complaint_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="IMF_Timely_Errors" HeaderText="Complaint Not Submitted to FSA" SortExpression="IMF_Timely_Errors" HeaderStyle-HorizontalAlign="Center" />            
		</Columns>        
</asp:GridView>
    <br />

    <asp:Button ID="btnDeleteSavedReport" OnClick="btnDeleteSavedReport_Click" runat="server" Text="Delete Checked Saved Reports" 
    CssClass="btn btn-sm btn-danger" OnClientClick="if ( !confirm('Are you sure you want to delete this saved report?')) return false" CausesValidation="false" />

</asp:Content>