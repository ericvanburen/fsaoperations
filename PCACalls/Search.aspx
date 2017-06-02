<%@ Page Title="PCA Call Monitoring - Call Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.vb" Inherits="PCACalls_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script> 
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />    
   
    <script type="text/javascript">
        $(document).ready(function () {
            $('.datepicker').datepicker()

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

  <li class="dropdown active">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
        <li><a href="SearchRehab.aspx">Rehab Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown">
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
<p></p>
 <asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCACallsConnectionString %>" />

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Search PCA Reviews</span>
  </div>
  <div class="panel-body">
  <table class="table">
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Call ID" data-content="The unique call ID # of the call">Call ID</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Call Date" data-content="The date the call was recorded">Call Date</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Call Date Range (Beginning and End Dates)" data-content="The date range the calls were recorded">Call Date Range</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Review Date" data-content="The date the call was reviewed">Review Date</a></th>
      </tr>        
      <tr>
            <td class="tableColumnCell"><asp:TextBox ID="txtCallID" runat="server" TabIndex="1" /></td>                             
            <td class="tableColumnCell"><asp:TextBox ID="txtCallDate" runat="server" CssClass="datepicker" /></td>
            <td class="tableColumnCell">from<br /><asp:TextBox ID="txtCallDateGreaterThan" runat="server" CssClass="datepicker" /><br />
             to<br /><asp:TextBox ID="txtCallDateLessThan" runat="server" CssClass="datepicker" /></td> 
            <td class="tableColumnCell">from<br /><asp:TextBox ID="txtReviewDateGreaterThan" runat="server" CssClass="datepicker" /><br />
             to<br /><asp:TextBox ID="txtReviewDateLessThan" runat="server" CssClass="datepicker" /></td>           
        </tr>
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Submitted" data-content="The date the call was submitted by the Loan Analyst">Date Submitted</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Date Submitted Range" data-content="The date the call was submitted by the Loan Analyst (Beginning and End Dates)">Date Submitted Range</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Reviewer/Loan Analyst" data-content="The name of the Loan Analyst which reviewed the call">Reviewer/Loan Analyst</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA" data-content="The name of the PCA the review came from">PCA</a></th>
      </tr>  
        <tr>
            <td class="tableColumnCell"><asp:TextBox ID="txtDateSubmitted" runat="server" CssClass="datepicker" /></td>
            <td class="tableColumnCell">from<br /><asp:TextBox ID="txtDateSubmittedGreaterThan" runat="server" CssClass="datepicker" />            
                <br />to<br /><asp:TextBox ID="txtDateSubmittedLessThan" runat="server" CssClass="datepicker" /></td>
            <td class="tableColumnCell">          
               <asp:ListBox ID="ddlUserID" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                <asp:ListItem Text="" Value="" />                
               </asp:ListBox></td>
            <td class="tableColumnCell"> 
                 <asp:ListBox ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" SelectionMode="Multiple" AppendDataBoundItems="true">
                    <asp:ListItem Text="" Value="" />
                 </asp:ListBox>
               </td>
        </tr> 
        <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Report Quarter" data-content="The fiscal quarter the review was performed">Report Quarter</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Report Year" data-content="The fiscal year the review was performed">Report Year</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Borrower Last Name" data-content="The last name of the borrower">Borrower Last Name</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Borrower Number" data-content="The DMCS borrower number">Borrower Number</a></th>
        </tr>

       <tr>
            <td class="tableColumnCell">
           <asp:ListBox ID="ddlReportQuarter" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="1 (Oct, Nov, Dec)" Value="1" />
                    <asp:ListItem Text="2 (Jan, Feb, Mar)" Value="2" />
                    <asp:ListItem Text="3 (Apr, May, Jun)" Value="3" />
                    <asp:ListItem Text="4 (Jul, Aug, Sep)" Value="4" />                     
            </asp:ListBox>
            </td>
            <td class="tableColumnCell">         
                 <asp:ListBox ID="ddlReportYear" runat="server" CssClass="inputBox" SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="2013" Value="2013" />
                    <asp:ListItem Text="2014" Value="2014" />
                    <asp:ListItem Text="2015" Value="2015" />
                    <asp:ListItem Text="2016" Value="2016" />
            </asp:ListBox>
            </td> 
            <td class="tableColumnCell"><asp:TextBox ID="txtBorrowerLastName" runat="server" TabIndex="3" CssClass="inputBox" /></td>
            <td class="tableColumnCell"><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputBox" TabIndex="4" /></td>    
        </tr>
      <tr>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Complaint" data-content="Did the borrower raise a complaint during the call?">Complaint</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Correct ID?" data-content="Did the collector call the borrower by the correct name?">Correct ID?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Mini-Miranda?" data-content="Did the collector mirandize the borrower when applicable?">Mini-Miranda?</a></th>
          <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Info?" data-content="Did the collector provide the borrower with accurate information?">Accurate Info?</a></th>
      </tr>
      <tr>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlComplaint" runat="server" CssClass="inputBox" TabIndex="7">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
            </asp:DropDownList></td>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_CorrectID" runat="server" CssClass="inputBox" TabIndex="8">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
                <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_MiniMiranda" runat="server" CssClass="inputBox" TabIndex="9">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
          <td class="tableColumnCell"><asp:DropDownList ID="ddlScore_Accuracy" runat="server" CssClass="inputBox" TabIndex="10">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList></td>
        </tr>
        <tr>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Accurate Notepad?" data-content="Did the collector update the DMCS notepad screen accurately?">Accurate Notepad?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="Professional Tone Used?" data-content="Did the collector use a professional tone of voice with the borrower?">Professional Tone Used?</a></th>
            <th class="tableColumnHead"><a href="#" data-toggle="popover" title="PCA Responsive?" data-content="Was the PCA responsive toward the borrower?">PCA Responsive?</a></th>
            <th class="tableColumnHead"> </th>
        </tr>
      <tr>
          <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_Notepad" runat="server" CssClass="inputBox" TabIndex="11">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>                           
            </td>
            <td class="tableColumnCell">           
                 <asp:DropDownList ID="ddlScore_Tone" runat="server" CssClass="inputBox" TabIndex="12">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>                
               </td>
                <td class="tableColumnCell">
                 <asp:DropDownList ID="ddlScore_PCAResponsive" runat="server" CssClass="inputBox" TabIndex="13">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Yes" Value="True" />
                    <asp:ListItem Text="No" Value="False" />
                </asp:DropDownList>          
            </td>
          <td class="tableColumnCell"> </td>
        </tr>             
        <tr>
            <td colspan="4" align="center"><br />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" />
            <asp:Button ID="btnSearchAgain" runat="server" CssClass="btn btn-md btn-warning" Text="Search Again" Visible="true" OnClick="btnSearchAgain_Click" />            
            </td>
        </tr>
    </table>
    </div>
    </div>

    <!--Row Count Label and Export To Excel-->
 <div class="row">       
        <div class="col-md-12" align="center"><br />
            <asp:Label ID="lblRowCount" runat="server" CssClass="bold" /> <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
        </div>            
</div>
<br />
    <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="CallID">
        <Columns>          
            <asp:TemplateField HeaderText="Call ID" SortExpression="CallID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("CallID", "CallReviewDetail.aspx?CallID={0}") %>'
                        Text='<%# Eval("CallID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            
            
            <asp:BoundField DataField="DateSubmitted" HeaderText="Date Submitted" SortExpression="DateSubmitted" 
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="CallDate" HeaderText="Call Date" SortExpression="CallDate" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" SortExpression="ReviewDate" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ReportQuarter" HeaderText="Report Quarter" SortExpression="ReportQuarter" HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="ReportYear" HeaderText="Report Year" SortExpression="ReportYear" HeaderStyle-HorizontalAlign="Center" />                    
            
            <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />   

            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="BorrowerLastName" HeaderText="Borrower Name" SortExpression="BorrowerLastName"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="RecordingDeliveryDate" HeaderText="Recording Delivery Date" SortExpression="RecordingDeliveryDate" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 

             <asp:TemplateField HeaderText="Complaint?" SortExpression="Complaint" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Complaint").ToString()), "Yes", "No")%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="IMF_Timely" HeaderText="Complaint Timely?" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

             <asp:TemplateField HeaderText="Correct ID?" SortExpression="Score_CorrectID" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Score_CorrectID").ToString()), "Yes", "No")%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Mini-Miranda?" SortExpression="Score_MiniMiranda" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Score_MiniMiranda").ToString()), "Yes", "No")%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Accurate Info?" SortExpression="Score_Accuracy" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Score_Accuracy").ToString()), "Yes", "No")%>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Accurate Notepad?" SortExpression="Score_Notepad" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Score_Notepad").ToString()), "Yes", "No")%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Prof Tone?" SortExpression="Score_Tone" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Score_Tone").ToString()), "Yes", "No")%>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Responsive?" SortExpression="Score_PCAResponsive" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                <ItemTemplate>
                    <%#IIf(Boolean.Parse(Eval("Score_PCAResponsive").ToString()), "Yes", "No")%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="FSA_Comments" HeaderText="FSA Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="PCA_Comments" HeaderText="PCA Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" /> 
            <asp:BoundField DataField="FSA_Conclusions" HeaderText="FSA Conclusions" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="FSASupervisor_Comments" HeaderText="FSA Supervisor Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="ReviewType" HeaderText="Review Type" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="RecordingDeliveryDate" HeaderText="Recording Delivery Date" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="WorksheetPCADate" HeaderText="Date Worksheet Completed By LA" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="FinalPCADate" HeaderText="Date Final Report Completed By LA" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="QCWorksheetDate" HeaderText="Date Worksheet Approved" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            <asp:BoundField DataField="QCFinalDate" HeaderText="Date Final Report Approved" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
         </Columns>
    </asp:GridView>
</asp:Content>

