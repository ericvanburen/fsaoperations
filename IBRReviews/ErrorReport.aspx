<%@ Page Title="IBR Error Report" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="ErrorReport.aspx.vb" Inherits="IBRReviews_ErrorReport" %>

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

  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">Search Reviews</a></li>      
    </ul>
  </li>
   <li class="dropdown active">
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
<p> </p>

<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>" /> 

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">IBR Error Report</span>
  </div>

  <div class="panel-body">
      <div class="row">
      <fieldset>          
            <label for="ddlPCAID"  class="control-label" style="margin-left:5px;">PCA</label>
           <asp:DropDownList ID="ddlPCAID" runat="server" DataSourceID="dsPCAs" DataValueField="PCAID" DataTextField="PCA" TabIndex="1" AppendDataBoundItems="true" AutoPostBack="true">
                <asp:ListItem Text="" Value="" />
             </asp:DropDownList>
             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPCAID" ErrorMessage="* Select a PCA *" CssClass="alert-danger" Display="Dynamic" />
       
        <!--Report Quarter--> 
            <label for="ddlReportQuarter"  class="control-label">Quarter</label>
            <asp:DropDownList ID="ddlReportQuarter" runat="server">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="1 (Oct, Nov, Dec)" Value="1" />
                <asp:ListItem Text="2 (Jan, Feb, Mar)" Value="2" />
                <asp:ListItem Text="3 (Apr, May, Jun)" Value="3" />
                <asp:ListItem Text="4 (Jul, Aug, Sep)" Value="4" />                    
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlReportQuarter" ErrorMessage="* Enter a Call Date *" CssClass="alert-danger" Display="Dynamic" />
       
        
         <!--Report Year-->
            <label for="ddlReportYear"  class="control-label">Year</label>
             <asp:DropDownList ID="ddlReportYear" runat="server">
                <asp:ListItem Text="" Value="" />
                <asp:ListItem Text="2017" Value="2017" />
                <asp:ListItem Text="2016" Value="2016" />
                <asp:ListItem Text="2015" Value="2015" /> 
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Specify a report year *" Display="Dynamic" ControlToValidate="ddlReportYear" CssClass="alert-danger" />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-sm btn-primary" OnClick="btnSearch_Click" /> 
            <asp:Button ID="btnSaveReview" runat="server" Text="Save Report" OnClientClick="if ( !confirm('Are you sure you want to save this as a final report?')) return false" CssClass="btn btn-sm btn-danger" OnClick="btnSaveReview_Click" Visible="false" />
            <asp:Button id="btnFinalReport" runat="server" CssClass="btn btn-sm btn-default" Text="Final Report" OnClick="btnFinalReport_Click" Visible="false" OnClientClick="confirm('Click the ED logo on the report window to create a final PDF report')" /><br />  
            <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
      </fieldset>      
      </div>
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
    <td>Agreement Letter Errors</td>
    <td class="text-right"><asp:Label ID="lblScore_Agreement_Letter_Signed_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Agreement_Letter_Signed_Errors_Percent" runat="server" /></td>    
</tr>
<tr>
    <td>Documentation Errors</td>
    <td class="text-right"><asp:Label ID="lblScore_Financial_Documentation_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Financial_Documentation_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>Repayment Amount Errors</td>
    <td class="text-right"><asp:Label ID="lblScore_Repayment_Amount_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Repayment_Amount_Errors_Percent" runat="server" /></td>
</tr>
<tr>
    <td>Tag Errors</td>
    <td class="text-right"><asp:Label ID="lblScore_Tag_Errors" runat="server" /></td>
    <td class="text-right"><asp:Label ID="lblScore_Tag_Errors_Percent" runat="server" /></td>
</tr>
</table>

<br />
<asp:SqlDataSource ID="dsPreviousReviews" runat="server" SelectCommand="p_SavedReviews"
 SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IBRReviewsConnectionString %>" DeleteCommand="DELETE FROM Reviews WHERE ReviewID=@ReviewID">
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
            <asp:BoundField DataField="Score_Agreement_Letter_Signed_Errors" HeaderText="Agreement Letter" SortExpression="Score_Agreement_Letter_Signed_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_Financial_Documentation_Errors" HeaderText="Financial Documentation" SortExpression="Score_Financial_Documentation_Errors" HeaderStyle-HorizontalAlign="Center" />
		    <asp:BoundField DataField="Score_Repayment_Amount_Errors" HeaderText="Repayment Amount" SortExpression="Score_Repayment_Amount_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_Tag_Errors" HeaderText="DMCS Tag" SortExpression="Score_Tag_Errors" HeaderStyle-HorizontalAlign="Center" />
		</Columns>        
</asp:GridView>
    <br />

    <asp:Button ID="btnDeleteSavedReport" OnClick="btnDeleteSavedReport_Click" runat="server" Text="Delete Checked Saved Reports" 
    CssClass="btn btn-sm btn-danger" OnClientClick="if ( !confirm('Are you sure you want to delete this saved report?')) return false" CausesValidation="false" />

</asp:Content>

