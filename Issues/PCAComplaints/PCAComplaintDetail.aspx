<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="PCAComplaintDetail.aspx.vb" Inherits="Issues_PCAComplaintDetail" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#form1").addClass("form-horizontal");

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
  <li class="dropdown active">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Issues <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="MyPCAComplaints.aspx">PCA Complaints</a></li>        
    </ul>
  </li> 
  <li class="dropdown">
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
    <span class="panel-title">PCA Complaint Detail</span>
  </div>
  <div class="panel-body">
   <table style="padding: 5px 5px 5px 15px;" width="100%" cellpadding="5" cellspacing="5">
    <tr>        
        <td align="right">
        <!--Received Date-->
        Date Received </td>
        <td align="left">
        <asp:TextBox ID="txtDateReceived" runat="server" CssClass="datepicker" /><br />       
               
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Date Received is a required field *"
        ControlToValidate="txtDateReceived" Display="Dynamic" CssClass="alert-danger" ValidationGroup="2" />
        </td>
        <td align="right">
        <!--Source-->
        Source </td>
        <td align="left"><asp:DropDownList ID="ddlSource" runat="server" CssClass="inputBox">
            <asp:ListItem Text="Complaint" Value="Value" Selected="True" />
            <asp:ListItem Text="Monitoring Review" Value="Monitoring Review" />
        </asp:DropDownList>         
        </td>
    </tr>
    <tr>    
    <td align="right"><!--PCA-->PCA </td>     
             <td><asp:DropDownList ID="ddlPCAID" runat="server" CssClass="inputBox" TabIndex="2" DataSourceID="dsPCAs" DataTextField="PCA" DataValueField="PCAID">
             </asp:DropDownList></td>
    <td align="right"><!--ReceivedBy-->
        Received By </td>       
             <td><asp:DropDownList ID="ddlReceivedBy" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="PCA" Value="PCA" Selected="True" />
                 <asp:ListItem Text="PIC/Vangent" Value="PIC/Vangent" />
                 <asp:ListItem Text="Web" Value="Web" />
                 <asp:ListItem Text="ED" Value="ED" />
             </asp:DropDownList>       
        </td>
    </tr>
    <tr>
        <td align="right"><!--BorrowerNumber-->Borrower Number </td>           
                <td><asp:TextBox ID="txtBorrowerNumber" runat="server" CssClass="inputbox" TabIndex="4" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Borrower Number is a required field *"
                    ControlToValidate="txtBorrowerNumber" Display="Dynamic" CssClass="alert-danger" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Borrower Number must be 10 digits" ControlToValidate="txtBorrowerNumber" CssClass="alert-danger" ValidationExpression="\d{10}" Display="Dynamic"   />
    </td>
     <td align="right"><!--BorrowerName-->       
            Borrower Name </td>           
                <td><asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" TabIndex="3" />
            </td>
    </tr>
    <tr>
    <td align="right"><!--ComplaintSource-->       
            Complaint Source </td>
            <td><asp:DropDownList ID="ddlComplaintSource" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="B" Value="B" />
                 <asp:ListItem Text="O" Value="O" />
                 <asp:ListItem Text="A" Value="A" />                 
             </asp:DropDownList></td>
        <td align="right"><!--WrittenVerbal-->       
            Written/Verbal </td>
            <td><asp:DropDownList ID="ddlWrittenVerbal" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="Written" Value="Written" Selected="True" />
                 <asp:ListItem Text="Verbal" Value="Verbal" />                                 
             </asp:DropDownList>           
        </td> 
    </tr>
    <tr>
         <td align="right"><!--Severity-->       
            Severity </td>
            <td><asp:DropDownList ID="ddlSeverity" runat="server" CssClass="inputBox">
                 <asp:ListItem Text="TBD" Value="TBD" Selected="True" />
                 <asp:ListItem Text="Insignificant" Value="Insignificant" />
                 <asp:ListItem Text="Significant" Value="Significant" />
                 <asp:ListItem Text="Severe" Value="Severe" />                 
             </asp:DropDownList></td>
             <td align="right"><!--CollectorName-->       
            Collector Name </td>
            <td><asp:TextBox ID="txtCollectorName" runat="server" CssClass="inputBox" /></td>
                 
    </tr>
    <tr>
        <td align="right">
        <!--UserID-->
        Assigned To </td>
        <td><asp:Dropdownlist ID="ddlUserID" runat="server" CssClass="inputBox" /></td>
        <td align="right">
        <!--Validity-->
        Validity </td>
        <td><asp:DropDownList ID="ddlValidity" runat="server" CssClass="inputBox" AppendDataBoundItems="true">
            <asp:ListItem Text="P" Value="P" />
            <asp:ListItem Text="I" Value="I" />
            <asp:ListItem Text="U" Value="U" />
            <asp:ListItem Text="V" Value="V" />                                
        </asp:DropDownList></td>
        
    </tr>
    <tr>
        <td style="text-align: right">
        <!--DueDate-->
        Due Date </td>
        <td align="left"><asp:Label ID="lblDueDate" runat="server" /></td>
        <td align="right">
        <!--DateResolved-->
        Date Resolved </td>
        <td align="left"><asp:TextBox ID="txtDateResolved" runat="server" CssClass="datepicker" />        
        </td>
    </tr>
</table>
  </div>
</div>


<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">DCS Violation Code</span>
  </div>
  <div class="panel-body">
        <asp:CheckBox ID="chkDCSViolationCode1" runat="server" /> Failure to offer reasonable and affordable payments<br />
        <asp:CheckBox ID="chkDCSViolationCode2" runat="server" /> Failure to offer rehab or consolidation<br />
        <asp:CheckBox ID="chkDCSViolationCode3" runat="server" /> Failure to be responsive to a reinstatement request<br />
        <asp:CheckBox ID="chkDCSViolationCode4" runat="server" /> Unprofessional behavior<br />
        <asp:CheckBox ID="chkDCSViolationCode5" runat="server" /> Failure to respond to closed school issues<br />
        <asp:CheckBox ID="chkDCSViolationCode6" runat="server" /> Other<br />
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">FDCPA Violation Code</span>
  </div>
  <div class="panel-body">
    <asp:CheckBox ID="chkFDCPAViolationCodeA" runat="server" /> A - Skip-tracing violation <br />
    <asp:CheckBox ID="chkFDCPAViolationCodeB" runat="server" /> B - Communication violation<br />
    <asp:CheckBox ID="chkFDCPAViolationCodeC" runat="server" /> C - Harrassment or abuse<br />
    <asp:CheckBox ID="chkFDCPAViolationCodeD" runat="server" /> D - False or misleading representation<br />
    <asp:CheckBox ID="chkFDCPAViolationCodeE" runat="server" /> E - Unfair practice<br />
    <asp:CheckBox ID="chkFDCPAViolationCodeF" runat="server" /> F - Failure to validate debt<br />
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Complaint Type</span>
  </div>
  <div class="panel-body">
    <asp:CheckBox ID="chkComplaintTypeA" runat="server" /> Required a down payment to rehab a loan<br />
    <asp:CheckBox ID="chkComplaintTypeB" runat="server" /> Required electronic payments<br />
    <asp:CheckBox ID="chkComplaintTypeC" runat="server" /> Stated the payment amount cannot be negotiated<br />
    <asp:CheckBox ID="chkComplaintTypeD" runat="server" /> Stated taxes will not be offset during rehab<br />
    <asp:CheckBox ID="chkComplaintTypeE" runat="server" /> Stated if account falls out of rehab it goes to AWG<br />
    <asp:CheckBox ID="chkComplaintTypeF" runat="server" /> Misstatement of ED policy<br />
    <asp:CheckBox ID="chkComplaintTypeG" runat="server" /> Stated that borrower can set whatever payment amt after rehab<br />
    <asp:CheckBox ID="chkComplaintTypeH" runat="server" /> Advised borrower to delay a filing a tax return to avoid offset<br />
    <asp:CheckBox ID="chkComplaintTypeI" runat="server" /> Negotiated a lower payment if the borrower is willing to pay a higher amount<br />
    <asp:CheckBox ID="chkComplaintTypeJ" runat="server" /> Talked the borrower out of wanting to PIF or SIF<br />
    <asp:CheckBox ID="chkComplaintTypeK" runat="server" /> Entered into rehab agreement with a borrower who is not eligible<br />
    <asp:CheckBox ID="chkComplaintTypeL" runat="server" /> Ignored signs that the borrower may qualify for discharge<br />
    <asp:CheckBox ID="chkComplaintTypeM" runat="server" /> Unauthorized payment made by the PCA<br />
    <asp:CheckBox ID="chkComplaintTypeN" runat="server" /> Special assistance unit not helpful or available<br />
    <asp:CheckBox ID="chkComplaintTypeO" runat="server" /> Disclosure of info to a third party<br />
    <asp:CheckBox ID="chkComplaintTypeP" runat="server" /> Unprofessional behavior - unresponsive to borrowers needs<br />
    <asp:CheckBox ID="chkComplaintTypeQ" runat="server" /> Unprofessional behavior - rude, argumentative<br />
    <asp:CheckBox ID="chkComplaintTypeR" runat="server" /> PCA did not represent itself as collection agency<br />
    <asp:CheckBox ID="chkComplaintTypeS" runat="server" /> PCA contacted wrong party<br />
    <asp:CheckBox ID="chkComplaintTypeT" runat="server" /> PCA contacted employer after being told not to<br />
    <asp:CheckBox ID="chkComplaintTypeU" runat="server" /> Other<br />   
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Comments</span>
  </div>
  <div class="panel-body">
      <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Height="49px" Width="829px"></asp:TextBox>
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">Attachments</span>
  </div>
  <div class="panel-body">
  <table>
  <tr>
    <td>
    <asp:HyperLink ID="hypAttachment1" runat="server" Target="_blank"  /></td>
  </tr>
  <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload1" runat="server" /><br /></td>
   </tr>  
   <tr>
    <td>
    <asp:HyperLink ID="hypAttachment2" runat="server" Target="_blank"  /></td>
  </tr>
  <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload2" runat="server" /><br /></td>
   </tr>
   <tr>
    <td>
    <asp:HyperLink ID="hypAttachment3" runat="server" Target="_blank"  /></td>
  </tr>
  <tr>
    <td align="left"><asp:FileUpload ID="ImageUpload3" runat="server" /></td>
  </tr>  
</table>
      
  </div>
</div>

<div align="center">
    <asp:Button runat="server" ID="btnUpdate" CssClass="btn btn-lg btn-primary" Text="Update" OnClick="btnUpdate_Click" /><br />
    <asp:Label runat="server" ID="lblUpdateConfirm" CssClass="alert-success" />
</div>

<asp:Label ID="lblComplaintID" runat="server" Visible="false" />
</asp:Content>

