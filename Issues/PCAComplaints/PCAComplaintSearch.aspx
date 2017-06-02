<%@ Page Title="PCA Complaint Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PCAComplaintSearch.aspx.vb" Inherits="Issues_PCAComplaintSearch" %>

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
<h3>Operations Issues</h3>

<!--Navigation Menu-->
<div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A1" class="dropdown-toggle" data-toggle="dropdown">Enter New Issue <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="PCAComplaint_Add.aspx">PCA Complaint</a></li>       
    </ul>
  </li>  
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Issues <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="MyPCAComplaints.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
  <li class="dropdown active">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search Issues <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="PCAComplaintSearch.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
 </ul>
 </div>
<!--End Navigation Menu-->
<br />

<!--Datasource for all of the PCAs-->
<asp:SqlDataSource ID="dsPCAs" runat="server" SelectCommand="p_AllPCAs"
SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:IssuesConnectionString %>" /> 

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Search PCA Complaints</span>
  </div>
  <div class="panel-body">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>        
        <td align="right">
        <!--Received Date-->
        Date Received </td>
        <td align="left">
        <asp:TextBox ID="txtDateReceivedGreaterThan" runat="server" CssClass="datepicker" />&nbsp;(greater than)</td>
        <td align="right">
        <!--Source-->
        Date Received</td>
        <td align="left">
        <asp:TextBox ID="txtDateReceivedLessThan" runat="server" CssClass="datepicker" />&nbsp;(less than)</td>
    </tr>
    <tr>    
    <td align="right"><!--PCA-->PCA </td>     
             <td><asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID" AppendDataBoundItems="true">
             <asp:ListItem Text="" Value="" />
             </asp:DropDownList></td>
    <td align="right"><!--ReceivedBy-->
        Received By </td>       
             <td><asp:DropDownList ID="ddlReceivedBy" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value="" />
                 <asp:ListItem Text="PCA" Value="PCA" />
                 <asp:ListItem Text="PIC/Vangent" Value="PIC/Vangent" />
                 <asp:ListItem Text="Web" Value="Web" />
                 <asp:ListItem Text="ED" Value="ED" />
             </asp:DropDownList>       
        </td>
    </tr>
    <tr>
        <td align="right"><!--BorrowerNumber-->Borrower Number </td>           
                <td><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputbox" TabIndex="4" /></td>
        <td align="right"><!--BorrowerName-->       
            Borrower Name </td>           
                <td><asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" TabIndex="3" />
            </td>
    </tr>
    <tr>
    <td align="right"><!--ComplaintSource-->       
            Complaint Source </td>
            <td><asp:DropDownList ID="ddlComplaintSource" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value="" />
                 <asp:ListItem Text="B" Value="B" />
                 <asp:ListItem Text="O" Value="O" />
                 <asp:ListItem Text="A" Value="A" />                 
             </asp:DropDownList></td>
        <td align="right">Source</td>
            <td><asp:DropDownList ID="ddlSource" runat="server" CssClass="inputBox">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="Complaint" Value="Value" />
            <asp:ListItem Text="Monitoring Review" Value="Monitoring Review" />
        </asp:DropDownList>         
        </td> 
    </tr>
    <tr>
         <td align="right"><!--Severity-->       
            Severity </td>
            <td><asp:DropDownList ID="ddlSeverity" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="" Value="" />
                 <asp:ListItem Text="TBD" Value="TBD" />
                 <asp:ListItem Text="Insignificant" Value="Insignificant" />
                 <asp:ListItem Text="Significant" Value="Significant" />
                 <asp:ListItem Text="Severe" Value="Severe" />                 
             </asp:DropDownList></td>
             <td align="right">      
        Validity</td>
            <td><asp:DropDownList ID="ddlValidity" runat="server" CssClass="inputBox" AppendDataBoundItems="true">
            <asp:ListItem Text="" Value="" />
            <asp:ListItem Text="P" Value="P" />
            <asp:ListItem Text="I" Value="I" />
            <asp:ListItem Text="U" Value="U" />
            <asp:ListItem Text="V" Value="V" />                                
        </asp:DropDownList></td>
                 
    </tr>
    <tr>
        <td align="right">
        Date Resolved</td>
        <td><asp:TextBox ID="txtDateResolvedGreaterThan" runat="server" CssClass="datepicker" />&nbsp;(greater than)</td>
        <td align="right">
            Date Resolved</td>
        <td><asp:TextBox ID="txtDateResolvedLessThan" runat="server" CssClass="datepicker" />&nbsp;(less than)</td>
        
    </tr>
    <tr>
        <td align="right">
        <!--UserID-->
        Assigned To </td>
        <td colspan="3"><asp:DropDownList ID="ddlUserID" runat="server" CssClass="inputBox" AppendDataBoundItems="true">
            <asp:ListItem Text="" Value="" />                                
        </asp:DropDownList></td>     
    </tr>
    <tr>
        <td colspan="4" align="center"><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-md btn-primary" OnClick="btnSearch_Click" />
            <asp:Button ID="btnSearchAgain" runat="server" Text="Search Again" CssClass="btn btn-md btn-success" OnClick="btnSearchAgain_Click" Visible="false" />
         </td>
    </tr>
    </table>
  </div>
</div>

   <!--Row Count Label and Export To Excel-->
 <div class="row">       
        <div class="col-lg-offset-3"><br />
            <asp:Label ID="lblRowCount" runat="server" CssClass="bold" /> <asp:Button ID="btnExportExcel" runat="server" CssClass="btn btn-sm btn-danger" style="padding-left: 10px;" Text="Export Results to Excel" OnClick="btnExportExcel_Click" Visible="false" />
        </div>            
</div>
<br />
    <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ComplaintID">
        <Columns>          
            <asp:TemplateField HeaderText="Complaint ID" SortExpression="ComplaintID">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("ComplaintID", "PCAComplaintDetail.aspx?ComplaintID={0}") %>'
                        Text='<%# Eval("ComplaintID") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />            

            <asp:BoundField DataField="UserID" HeaderText="Loan Analyst" SortExpression="UserID"
                HeaderStyle-HorizontalAlign="Center" />            

             <asp:BoundField DataField="BorrowerNumber" HeaderText="Borrower #" SortExpression="BorrowerNumber"
                HeaderStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="BorrowerName" HeaderText="Borrower Name" SortExpression="BorrowerName"
                HeaderStyle-HorizontalAlign="Center" /> 
                
             <asp:BoundField DataField="PCA" HeaderText="PCA" SortExpression="PCA"
                HeaderStyle-HorizontalAlign="Center" />            

            <asp:BoundField DataField="Validity" HeaderText="Validity" SortExpression="Validity"
                HeaderStyle-HorizontalAlign="Center" />

             <asp:BoundField DataField="DateResolved" HeaderText="Date Resolved" SortExpression="DateResolved" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />            

           <%--These are the hidden fields which show up only the Excel export--%>
                
            <asp:BoundField DataField="Source" HeaderText="Source" SortExpression="Source"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />              

            <asp:BoundField DataField="Severity" HeaderText="Severity" SortExpression="Severity"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ReceivedBy" HeaderText="Received By" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
            
            <asp:BoundField DataField="CollectorName" HeaderText="Collector Name" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                
            <asp:BoundField DataField="WrittenVerbal" HeaderText="Written/Verbal" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />         
            
            <asp:BoundField DataField="ComplaintSource" HeaderText="Complaint Source" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                
            <asp:BoundField DataField="Comments" HeaderText="Comments" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                
            <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:d}" HtmlEncode="false"
                HeaderStyle-HorizontalAlign="Center" />            

            <asp:BoundField DataField="DCSViolationCode1" HeaderText="Failure to offer reasonable and affordable payments" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             
            <asp:BoundField DataField="DCSViolationCode2" HeaderText="Failure to offer rehab or consolidation"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />  
              
            <asp:BoundField DataField="DCSViolationCode3" HeaderText="Failure to be responsive to a reinstatement request"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="DCSViolationCode4" HeaderText="Unprofessional behavior"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="DCSViolationCode5" HeaderText="Failure to respond to closed school issues"
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="DCSViolationCode6" HeaderText="Other" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
           
           <asp:BoundField DataField="FDCPAViolationCodeA" HeaderText="A - Skip-tracing violation" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="FDCPAViolationCodeB" HeaderText="B - Communication violation" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="FDCPAViolationCodeC" HeaderText="C - Harrassment or abuse" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="FDCPAViolationCodeD" HeaderText="D - False or misleading representation" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="FDCPAViolationCodeE" HeaderText="E - Unfair practice" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="FDCPAViolationCodeF" HeaderText="F - Failure to validate debt" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeA" HeaderText="Required a down payment to rehab a loan" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeB" HeaderText="Required electronic payments" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeC" HeaderText="Stated the payment amount cannot be negotiated" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeD" HeaderText="Stated taxes will not be offset during rehab" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeE" HeaderText="Stated if account falls out of rehab it goes to AWG" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeF" HeaderText="Misstatement of ED policy" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeG" HeaderText="Stated that borrower can set whatever payment amt after rehab" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeH" HeaderText="Advised borrower to delay a filing a tax return to avoid offset" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeI" HeaderText="Negotiated a lower payment if the borrower is willing to pay a higher amount" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeJ" HeaderText="Talked the borrower out of wanting to PIF or SIF" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeK" HeaderText="Entered into rehab agreement with a borrower who is not eligible" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeL" HeaderText="Ignored signs that the borrower may qualify for discharge" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeM" HeaderText="Unauthorized payment made by the PCA" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeN" HeaderText="Special assistance unit not helpful or available" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeO" HeaderText="Disclosure of info to a third party" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeP" HeaderText="Unprofessional behavior - unresponsive to borrowers needs" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeQ" HeaderText="Unprofessional behavior - rude, argumentative" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />

            <asp:BoundField DataField="ComplaintTypeR" HeaderText="PCA did not represent itself as collection agency" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                
            <asp:BoundField DataField="ComplaintTypeS" HeaderText="PCA contacted wrong party" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
             
             <asp:BoundField DataField="ComplaintTypeT" HeaderText="PCA contacted employer after being told not to" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />
                
            <asp:BoundField DataField="ComplaintTypeU" HeaderText="Other" 
                HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" />                      
         
        </Columns>
    </asp:GridView>
</asp:Content>

