<%@ Page Title="PCA Monitoring - Saved Reports" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Reports_SavedReports.aspx.vb" Inherits="PCA_Reports_SavedReports" %>

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

    <style type="text/css">
    .cb label
    {
        margin-left: 9px;
    }    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>PCA Reviews</h3>

<!--Navigation Menu-->
<div>
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
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
 <br />
 <p>Use this form to search for saved reports for each PCA. Enter a date range for when the review was entered (optional) and then select the PCA(s) you want.</p>
 <table class="table" style="background-color:#eeeeee;">
                
        <tr>
            <td valign="top" colspan="2">
            <!--PCA--> 
            <label class="form-label">PCA:</label>
            <asp:CheckBoxList runat="server" AutoPostBack="true" ID="chkPCAID" TabIndex="1" RepeatColumns="4" CellPadding="4" CssClass="cb">
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
              </asp:CheckBoxList>              
            </td>            
           
        </tr>       
</table>

<asp:Label ID="lblRowCount" runat="server" CssClass="alert-danger" />

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table table-hover table-striped" 
DataKeyNames="SavedReviewID" OnRowDataBound="GridView1_OnRowDataBound">
<EmptyDataTemplate>
    No Saved Reviews For This PCA
</EmptyDataTemplate>
<RowStyle Font-Size="X-Small" />
<HeaderStyle Font-Size="Small" BackColor="#EEEEEE" Font-Names="Calibri" />
        <Columns>          
             <asp:TemplateField HeaderText="Attachment">   
                <ItemTemplate>
                    <asp:HyperLink id="hypViewAttachment" runat="server" NavigateUrl='<%# String.Format("ReviewAttachments/{0}", Eval("Attachment")) %>' Text='View' Target="_blank" /><br />
                    <asp:HyperLink ID="hypUploadAttachment" runat="server" NavigateUrl='<%# Eval("SavedReviewID", "AttachmentManager.aspx?SavedReviewID={0}&Action=Upload") %>' Text='Upload' Target="_blank" /><br />
                    <asp:HyperLink ID="hypDeleteAttachment" runat="server" NavigateUrl='<%# Eval("SavedReviewID", "AttachmentManager.aspx?SavedReviewID={0}&Action=Delete") %>' Text='Delete' Target="_blank" />               
                </ItemTemplate>
            </asp:TemplateField>
           
            <asp:BoundField DataField="DateEntered" HeaderText="Review Date" SortExpression="DateEntered" DataFormatString="{0:d}" HtmlEncode="false" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Total_AnyErrors" HeaderText="Accounts With One Error or More" SortExpression="Total_AnyErrors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_CorrectID_Errors" HeaderText="Improper or Incorrect Indentification" SortExpression="Score_CorrectID_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_MiniMiranda_Errors" HeaderText="Mini-Miranda Not Provided" SortExpression="Score_MiniMiranda_Errors" HeaderStyle-HorizontalAlign="Center" />
		    <asp:BoundField DataField="Score_Accuracy_Errors" HeaderText="Accurate Information Not Provided" SortExpression="Score_Accuracy_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_Notepad_Errors" HeaderText="Incomplete or Inaccurate Notepad" SortExpression="Score_Notepad_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_PCAResponsive_Errors" HeaderText="PCA Was Not Responsive" SortExpression="Score_PCAResponsive_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Score_AWGInfo_Errors" HeaderText="PCA Provided Inaccurate AWG Info" SortExpression="Score_AWGInfo_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Complaint_Errors" HeaderText="PCA Received Complaint" SortExpression="Complaint_Errors" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="IMF_Timely_Errors" HeaderText="Complaint Not Submitted to FSA" SortExpression="IMF_Timely_Errors" HeaderStyle-HorizontalAlign="Center" />            
		</Columns>        
</asp:GridView>

</asp:Content>

