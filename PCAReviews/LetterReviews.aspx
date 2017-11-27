<%@ Page Title="Loan Analyst PCA Final Review Letters" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="LetterReviews.aspx.vb" Inherits="PCAReviews_Tracking_default" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
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

  <li class="dropdown active">
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
    </ul>
  </li>
 </ul>
 </div>
<!--End Navigation Menu-->
<br />
<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>" />

<asp:SqlDataSource ID="dsLALetters" runat="server" SelectCommand="p_LALetters" DeleteCommand="DELETE FROM LetterReviews WHERE LetterReviewID=@LetterReviewID"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:PCAReviewsConnectionString %>">
<DeleteParameters>
    <asp:Parameter Name="LetterReviewID" />
</DeleteParameters>
</asp:SqlDataSource>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <span class="panel-title">Loan Analyst PCA Final Review Letters</span>
        </div>
        <div class="panel-body">

            <table cellpadding="3" cellspacing="4" class="table">
                <tr>
                    <td align="right">PCA: </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="1" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="true">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlPCAID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a PCA *" />
                    </td>
                </tr>
                <tr>
                    <td align="right">Review Date: </td>
                    <td align="left">Month
                        <asp:DropDownList ID="ddlReviewPeriodMonth" runat="server" TabIndex="2" CssClass="inputBox">
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
                        &nbsp;Day
                        <asp:DropDownList ID="ddlReviewPeriodDay" runat="server" TabIndex="3" CssClass="inputBox">
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
                            <asp:ListItem Text="13" Value="13" />
                            <asp:ListItem Text="14" Value="14" />
                            <asp:ListItem Text="15" Value="15" />
                            <asp:ListItem Text="16" Value="16" />
                            <asp:ListItem Text="17" Value="17" />
                            <asp:ListItem Text="18" Value="18" />
                            <asp:ListItem Text="19" Value="19" />
                            <asp:ListItem Text="20" Value="20" />
                            <asp:ListItem Text="21" Value="21" />
                            <asp:ListItem Text="22" Value="22" />
                            <asp:ListItem Text="23" Value="23" />
                            <asp:ListItem Text="24" Value="24" />
                            <asp:ListItem Text="25" Value="25" />
                            <asp:ListItem Text="26" Value="26" />
                            <asp:ListItem Text="27" Value="27" />
                            <asp:ListItem Text="28" Value="28" />
                            <asp:ListItem Text="29" Value="29" />
                            <asp:ListItem Text="30" Value="30" />
                            <asp:ListItem Text="31" Value="31" />
                        </asp:DropDownList>
                        &nbsp;Year
                        <asp:DropDownList ID="ddlReviewPeriodYear" runat="server" TabIndex="4" CssClass="inputBox">
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="2014" Value="2014" />
                            <asp:ListItem Text="2015" Value="2015" Selected="True" />
                            <asp:ListItem Text="2016" Value="2016" />
                        </asp:DropDownList> 
                        &nbsp;EDPAS Period 
                        <asp:DropDownList ID="ddlEDPASPeriod" runat="server" TabIndex="5" CssClass="inputBox">
                            <asp:ListItem Text="10/1/2013-09/30/2014" Value="10/1/2013-09/30/2014" />
                            <asp:ListItem Text="10/1/2014-09/30/2015" Value="10/1/2014-09/30/2015" Selected="True" />
                            <asp:ListItem Text="10/1/2015-09/30/2016" Value="10/1/2015-09/30/2016" />
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlReviewPeriodMonth" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a review month *" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddlReviewPeriodDay" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a review day *" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlReviewPeriodYear" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a review year *" />
                    </td>
                </tr>
                <tr>
                    <td align="right">Loan Analyst: </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlUserID" runat="server" TabIndex="6" AppendDataBoundItems="true" CssClass="inputBox">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="rfd2" runat="server" ControlToValidate="ddlUserID" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a Loan Analyst *" /></td>
                </tr>
                <tr>
                    <td align="right">Supervisor Name:</td>
                    <td align="left">
                        <asp:DropDownList ID="ddlSupervisorName" runat="server" TabIndex="7" CssClass="inputBox">
                            <asp:ListItem Text="Carolyn Toomer" Value="carolyn.toomer" />
                            <asp:ListItem Text="Debra Ruffin" Value="debra.ruffin" />                            
                            <asp:ListItem Text="Irene Ford" Value="irene.ford" />
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlSupervisorName" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a supervisor name *" />
                    </td>
                </tr>
                <tr>
                    <td align="right">Assigned Team Leader:</td>
                    <td align="left">
                        <asp:DropDownList ID="ddlTeamLeader" runat="server" TabIndex="8" CssClass="inputBox">
                            <asp:ListItem Text="Doug Laine" Value="douglas.laine" />
                            <asp:ListItem Text="Jesse Hightower" Value="jesse.hightower" />                            
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddlTeamLeader" CssClass="alert-danger" Display="Dynamic" ErrorMessage="* please select a team leader *" />
                    </td>
                </tr>
                <tr>
                    <td align="right">Upload Letter: </td>
                    <td align="left">
                        <asp:FileUpload ID="ImageUpload1" runat="server" />
                        <asp:Label ID="lblAttachment1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-md btn-primary" /><asp:Button ID="btnSubmitAgain" runat="server"
                        Text="Submit Another" OnClick="btnSubmitAgain_Click" CssClass="btn btn-md btn-success" Visible="false" />
                        <br />
                        <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-success" />
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="panel panel-primary">
        <div class="panel-heading">
            <span class="panel-title">Loan Analyst PCA Final Review Letters</span>
        </div>
        <div class="panel-body">
            Search By: <asp:DropDownList ID="ddlSearchType" runat="server" CssClass="inputBox">
                        <asp:ListItem Text="PCA" Value="PCA" />
                        <asp:ListItem Text="Loan Analyst" Value="UserID" />
                        <asp:ListItem Text="Month" Value="ReviewPeriodMonth" />
                        <asp:ListItem Text="Year" Value="ReviewPeriodYear" />
                        <asp:ListItem Text="Supervisor" Value="Supervisor" />
                        <asp:ListItem Text="Team Leader" Value="TeamLeader" />
                    </asp:DropDownList>
                    For <asp:TextBox ID="txtSearchPhrase" runat="server" CssClass="inputBox" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn-sm btn-primary" CausesValidation="false" />
                <asp:Button ID="btnShowAll" runat="server" Text="Show All" OnClick="btnShowAll_Click" CssClass="btn-sm btn-danger" CausesValidation="false" Visible="false" />
            <br /><br />
            <asp:GridView ID="GridView1" runat="server" DataSourceID="dsLALetters" AutoGenerateColumns="false" AllowSorting="true" CssClass="table table-hover table-striped" DataKeyNames="LetterReviewID">
                <Columns>                   
                    <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="cbRows" runat="server" />
                    </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LetterReviewID" HeaderText="Draft ID" SortExpression="LetterReviewID" 
                    HeaderStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA" 
                    HeaderStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="ReviewPeriodDate" HeaderText="Review Date" SortExpression="ReviewPeriodDate" HtmlEncode="false" DataFormatString="{0:d}" 
                    HeaderStyle-HorizontalAlign="Center" />   
                    <asp:BoundField DataField="EDPASPeriod" HeaderText="EDPAS Period" SortExpression="EDPASPeriod"  
                    HeaderStyle-HorizontalAlign="Center" />                 
                    <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID" 
                    HeaderStyle-HorizontalAlign="Center" />                    
                     <asp:BoundField DataField="Supervisor" HeaderText="Supervisor" SortExpression="Supervisor" 
                    HeaderStyle-HorizontalAlign="Center" />
                     <asp:BoundField DataField="TeamLeader" HeaderText="Team Leader" SortExpression="TeamLeader" 
                    HeaderStyle-HorizontalAlign="Center" />
                    <asp:hyperlinkfield headertext="Letter" datatextfield="Attachment" DataNavigateUrlFields="Attachment" 
                    datanavigateurlformatstring="http://localhost:49542/PCAReviews/LetterReviewAttachments/{0}" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnDeleteSavedLetter" OnClick="btnDeleteSavedLetter_Click" runat="server" Text="Delete Checked Saved Letters" 
            CssClass="btn btn-sm btn-danger" OnClientClick="if ( !confirm('Are you sure you want to delete these letters?')) return false" CausesValidation="false" />
        </div>
    </div>
</asp:Content>

