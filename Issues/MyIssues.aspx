<%@ Page Title="My Issues" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="true" CodeFile="MyIssues.aspx.vb" Inherits="Issues_MyIssues" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        /* increase modal size*/
        .modal-dialog   {
            width: 650px;
        }
    </style>
    <script type="text/javascript">
        // this updates the active tab on the navbar
        $(document).ready(function () {
            //Dashboard
            $('#navA0').removeClass("active");
            //Add Issue
            $('#navA1').removeClass("active");
            //My Issues
            $('#navA2').addClass("active");
            //Search Issues
            $('#navA3').removeClass("active");
            //Reports
            $('#navA4').removeClass("active");
            //Administration
            $('#navA5').removeClass("active");
        });     
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<h3>My Issues</h3>

<!--Datasource for all of the Source Org Names-->
<asp:SqlDataSource ID="dsSourceOrg" runat="server" SelectCommand="p_AllSourceOrg"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />

<!--Datasource for all of the Categories-->
<asp:SqlDataSource ID="dsCategories" runat="server" SelectCommand="p_AllCategories"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" />    
    
    <div class="formBorder">
    <h4>Filter My Results</h4>
    <div class="row form-inline">
        <div class="form-group col-md-1">
            
            <label for="txtIssueID">Issue #</label>
                <div>
                    <asp:TextBox ID="txtIssueID" runat="server" AutoPostBack="true" CssClass="form-control" />
                </div>
        </div>
        <div class="form-group col-md-2">
            <label for="ddlIssueType">Issue Type</label>
            <div>
                 <asp:DropDownList ID="ddlIssueType" runat="server" CssClass="inputBox" AutoPostBack="true">
                    <asp:ListItem Text="" Value="" Selected="True" />
                    <asp:ListItem Text="PCA Complaints" Value="PCA" />
                    <asp:ListItem Text="Liaisons" Value="Liaisons" />
                    <asp:ListItem Text="Call Center" Value="Call Center" />
                    <asp:ListItem Text="Escalated" Value="Escalated" />
                    <asp:ListItem Text="All Types" Value="All Types" />
                </asp:DropDownList>
            </div>
        </div>    
        <div class="form-group col-md-2">
            <label for="ddlIssueStatus">Issue Status</label>
            <div>
                 <asp:ListBox ID="ddlIssueStatus" runat="server" CssClass="inputBox" SelectionMode="Multiple" AutoPostBack="true">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="Open" Value="Open" Selected="True" />
                    <asp:ListItem Text="Closed" Value="Closed" />
                    <asp:ListItem Text="Deferred" Value="Deferred" />
                    <asp:ListItem Text="Opened In Error" Value="Opened In Error" />
                    <asp:ListItem Text="Agenda" Value="Agenda" />
                </asp:ListBox>
            </div>
        </div>  
        <div class="form-group col-md-3">
            <label for="ddlAffectedOrgID">Affected Org</label>
            <div>
                  <asp:ListBox ID="ddlAffectedOrgID" runat="server" CssClass="inputBox" DataSourceID="dsSourceOrg" AutoPostBack="true"
                    DataTextField="SourceOrg" DataValueField="SourceOrgID" AppendDataBoundItems="true"
                    SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" Selected="True" />
                </asp:ListBox>
            </div>
        </div> 
        <div class="form-group col-md-3">
            <label for="ddlCategoryID">Category</label>
            <div>
                  <asp:ListBox ID="ddlCategoryID" runat="server" DataSourceID="dsCategories" AppendDataBoundItems="true" AutoPostBack="true"
                    CssClass="inputBox" DataTextField="Category" DataValueField="CategoryID" SelectionMode="Multiple">
                    <asp:ListItem Text="" Value="" Selected="True" />
                </asp:ListBox>
            </div>
        </div>  
    </div>
    
    </div>
    
    
    <!--Row Count Label and Export To Excel-->
    <div class="row">
        <div class="col-lg-offset-5">
            <br />
            <asp:Label ID="lblRowCount" runat="server" CssClass="alert-info" />
            <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger"
                Style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click"
                Visible="false" />
        </div>
    </div>
    <br />
<asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
<ContentTemplate>
 <asp:GridView ID="GridView1" runat="server" AllowSorting="true" OnSorting="GridView1_Sorting" OnRowCommand="GridView1_RowCommand"
        AutoGenerateColumns="false" CssClass="table table-hover table-striped table-bordered table-condensed GridView" DataKeyNames="IssueID">
        <EmptyDataTemplate>
            No records found
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Issue # Detail" ItemStyle-Width="75px" SortExpression="IssueID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:ButtonField CommandName="detail" ItemStyle-Width="75px" ButtonType="Image" ControlStyle-Width="15px" ImageUrl="~/Images/icons/pencil.png" HeaderText="Quick Update" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="IssueID" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" />
            <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="IssueType" HeaderText="Issue Type" SortExpression="IssueType" HeaderStyle-HorizontalAlign="Center" />           
            <asp:BoundField DataField="IssueStatus" HeaderText="Issue Status" SortExpression="IssueStatus" HeaderStyle-HorizontalAlign="Center" />              
		     <asp:BoundField DataField="AffectedOrg" HeaderText="Affected Org" SortExpression="AffectedOrg" HeaderStyle-HorizontalAlign="Center" />
             <asp:TemplateField HeaderText="Description"> 
             <ItemTemplate>
	            <%# If(Eval("IssueDescription") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("IssueDescription")))%> 
             </ItemTemplate> 
             </asp:TemplateField>
             <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" HeaderStyle-HorizontalAlign="Center" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" />
            <asp:TemplateField HeaderText="Comments" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden"> 
             <ItemTemplate>
	            <%# If(Eval("Comments") Is DBNull.Value, "", FormatParagraph.FormatParagraphHTML(Eval("Comments")))%> 
             </ItemTemplate>
             </asp:TemplateField>                 
        </Columns>
</asp:GridView>
</ContentTemplate>
</asp:UpdatePanel>

<asp:Label ID="lblUserID" runat="server" Visible="false" />
<asp:Label ID="lblSortExpression" runat="server" Visible="false" />


 <!-- Modal -->

 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">Update Issue</h4>
                  </div>
                  <div class="modal-body">
                      <asp:UpdatePanel ID="UpdatePanel2" runat="server"> 
                            <ContentTemplate>
                            <%--<asp:Repeater id="Repeater1" runat="server">
                            <ItemTemplate>--%>
                                <div class="container-fluid">                                   
                                <table width="95%" cellpadding="3" cellspacing="3">                                    
                                    <tr>
                                        <td align="right"><label for="lblIssueID">Issue ID</label></td>
                                        <td align="left" valign="top"><asp:Label ID="lblIssueID" runat="server" Text='<%# Eval("IssueID")%>' /> </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="ddlIssueStatus">Status</label></td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlIssueStatusModal" runat="server" CssClass="inputBox" SelectedValue='<%# Eval("IssueStatus")%>' OnSelectedIndexChanged="ddlIssueStatusModal_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="Open" Value="Open" />
                                                <asp:ListItem Text="Closed" Value="Closed" />
                                                <asp:ListItem Text="Deferred" Value="Deferred" />
                                                <asp:ListItem Text="Opened In Error" Value="Opened In Error" />
                                                <asp:ListItem Text="Agenda" Value="Agenda" />
                                            </asp:DropDownList></td>
                                    </tr> 
                                    <tr>
                                        <td align="right"><label for="txtDateResolved">Date Resolved</label></td>
                                        <td align="left"><asp:TextBox ID="txtDateResolved" runat="server" CssClass="datepicker calendar" Text='<%# Eval("DateResolved")%>' /></td>

                                    </tr>                                 
                                    <tr>
                                        <td align="right"><label for="txtComments">Comments</label></td>
                                        <td align="left"><asp:TextBox ID="txtComments" runat="server" Rows="15" Columns="60" CssClass="inputBox" TextMode="MultiLine" Text='<%# Eval("Comments")%>' OnTextChanged="txtComments_TextChanged" AutoPostBack="true" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><label for="txtResolution">Resolution</label></td>
                                        <td align="left"><asp:TextBox ID="txtResolution" runat="server" TextMode="MultiLine" Rows="5" Columns="60" Text='<%# Eval("Resolution")%>' OnTextChanged="txtResolution_TextChanged" AutoPostBack="true" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center"><asp:Label ID="lblUpdateConfirm" runat="server" CssClass="alert-danger" Visible="false" /></td>
                                    </tr>
                                </table>
                                </div>
                            <%--</ItemTemplate>
                            </asp:Repeater>--%>
                            </ContentTemplate>
                            
                      <Triggers> 
                          <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="RowCommand" />
                       </Triggers> 
                      </asp:UpdatePanel>
                  </div>
                  <div class="modal-footer">
                    <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                    <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server"> 
                            <ContentTemplate>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" class="btn btn-primary" OnClick="btnSaveChanges_Click" />
                            </ContentTemplate>
                        
                    </asp:UpdatePanel> 
                  </div>
                </div>
              </div>
            </div>

 <!-- End Modal -->
</asp:Content>

