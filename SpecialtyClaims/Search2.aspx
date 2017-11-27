<%@ Page Title="Specialty Claims - Account Search" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search2.aspx.vb" Inherits="DMCSRefunds_MyRefunds" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>      
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" /> 
    <script type="text/javascript">
        $(document).ready(function () {
            $get('<%= pnlpopup.ClientID %>').style.height = document.documentElement.clientHeight * 0.9 + "px";            
        });
   </script>
   <style type="text/css">
        .modalBackground
        {
            background-color: Gray;
            z-index: 10000;
            overflow: auto;
        }
                
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#form1").addClass("form-horizontal");

            $('.datepicker').datepicker()            
        });
    </script>
    
    <script type="text/javascript">
    $(function () {
            //$("#datepicker").datepicker();

            $("#MainContent_pnlpopup").dialog({
                autoOpen: false
            });

            $(".btnModalOpen").click(function () {
                $("#MainContent_pnlpopup").dialog('open');
            });
        });
   </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:ToolkitScriptManager ID="ScriptManager1" runat="server" ScriptMode="Release">
 </asp:ToolkitScriptManager>

  <h3>Specialty Claims Tracking</h3>  

 <div>
 <ul class="nav nav-tabs">
  <li><a href="EnterNewClaim.aspx">Enter New Claim</a></li>
  <li class="active"><a href="Search.aspx">Search/Update By SSN</a></li>
  <li><a href="UpdateBatch.aspx">Approve Batch</a></li>  
  <li><a href="Upload.aspx">Upload New Batch</a></li>
  <li><a href="Reports.aspx">Servicer Files</a></li>
  <li><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />
 <div class="col-md-12-backgroundcolor">
    <asp:TextBox ID="txtAccountNo" runat="server" CssClass="inputBox" ValidationGroup="1" />
    <asp:Button runat="server" ID="btnSearch" OnClick="btnSearch_Click" Text="Find SSN" CssClass="btn btn-primary" ValidationGroup="1" /><br />
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* SSN is a required field *" Display="Dynamic" ControlToValidate="txtAccountNo" CssClass="alert-danger" ValidationGroup="1" />
</div>
<br />
   
    <asp:SqlDataSource ID="dsSearchAccountNumber" runat="server" SelectCommand="p_SearchAccountNumber"
        SelectCommandType="StoredProcedure" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>">
        <SelectParameters>
            <asp:Parameter Name="AccountNumber" Type="String" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsClaimDetails" runat="server" SelectCommand="p_SearchAccountNumber"
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="true" ConnectionString="<%$ ConnectionStrings:SpecialtyClaimsConnectionString %>">
        <SelectParameters>
            <asp:Parameter Name="ClaimID" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>
   
                  
                  <asp:UpdatePanel ID="UpdatePanel1" runat="server">                 
                  <ContentTemplate>
                      <asp:GridView ID="GridView1" runat="server" DataSourceID="dsSearchAccountNumber"
                          AutoGenerateColumns="false" CssClass="table table-hover table-striped" DataKeyNames="ClaimID">                          
                          <Columns>
                              <asp:TemplateField HeaderText="Edit">
                                  <ItemTemplate>
                                      <asp:ImageButton ID="imgbtn" ImageUrl="../images/pencil.gif" runat="server" Width="25"
                                          Height="25" OnClick="imgbtn_Click" CssClass="btnModalOpen" />
                                  </ItemTemplate>
                              </asp:TemplateField>
                              <asp:BoundField DataField="ClaimID" HeaderText="Claim ID" SortExpression="ClaimID"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="AccountNumber" HeaderText="SSN" SortExpression="AccountNumber"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="BorrowerName" HeaderText="Name" SortExpression="BorrowerName"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="DischargeType" HeaderText="Discharge Type" SortExpression="DischargeType"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="Servicer" HeaderText="Servicer" SortExpression="Servicer"
                                  HeaderStyle-HorizontalAlign="Center" />
                              <asp:BoundField DataField="DateReceived" HeaderText="Date Received" SortExpression="DateReceived"
                                  DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
                              <asp:TemplateField HeaderText="Approved?" SortExpression="Approve">
                                  <ItemTemplate>
                                      <%#IIf(Boolean.Parse(Eval("Approve").ToString()), "Yes", "No")%></ItemTemplate>
                              </asp:TemplateField>
                              <asp:BoundField DataField="DateCompleted" HeaderText="Date Completed" SortExpression="DateCompleted"
                                  DataFormatString="{0:d}" HeaderStyle-HorizontalAlign="Center" HtmlEncode="false" />
                          </Columns>
                      </asp:GridView>
                     <asp:Label ID="lblSearchResultsStatus" runat="server" />

    <!--This is the modal popup table-->
    <asp:Label ID="lblresult" runat="server" />
    <asp:Button ID="btnShowPopup" runat="server" Style="display: none" />
    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btnShowPopup"
        PopupControlID="pnlpopup" CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
    <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Width="800px" Style="display: none; border: 2px solid black; padding: 5px 5px 5px 5px">
    <div class="row">
        <div class="col-md-11" align="center"> 
            <h2>Claim ID: <asp:Label ID="lblClaimID" runat="server" /></h2>
        </div>
    </div>

    <table style="padding: 5px 5px 5px 15px;" cellpadding="2" cellspacing="2" width="100%">
        <tr>
            <td>&nbsp;&nbsp;</td>            
            <td>
                <!--Account Number-->
                <label class="control-label" for="MainContent_txtSSN">
                Account Number</label><br />
                <asp:TextBox ID="txtAccountNumber" runat="server" ValidationGroup="2" /><br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Account Number is a required field *" ControlToValidate="txtAccountNumber" Display="Dynamic" CssClass="alert-danger" ValidationGroup="2" />
            </td>
            
            <td>
            <!--Borrower Name-->
             <label class="control-label" for="MainContent_txtBorrowerName">Borrower Name</label><br />
            <asp:TextBox ID="txtBorrowerName" runat="server" CssClass="inputBox" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Borrower Name is a required field *" ControlToValidate="txtBorrowerName" Display="Dynamic" CssClass="alert-danger" ValidationGroup="2" />      
            </td>
        </tr>
        <tr>
            <td>&nbsp;&nbsp;</td>
            
            <td>
                <!--Claim/Discharge Type-->
                <label class="control-label" for="MainContent_txtClaimType">
                Claim Type</label><br />
                <asp:DropDownList ID="ddlDischargeType" runat="server" CssClass="inputBox">
                    <asp:ListItem Text="" Value="" />
                    <asp:ListItem Text="ATB" Value="atb" />
                    <asp:ListItem Text="CLS" Value="cls" />
                    <asp:ListItem Text="Death" Value="death" />
                    <asp:ListItem Text="DQS" Value="dqs" />
                    <asp:ListItem Text="Fraud" Value="fraud" />
                    <asp:ListItem Text="ID Theft" Value="id theft" />
                    <asp:ListItem Text="ID Theft Appeal" Value="id theft appeal" />
                    <asp:ListItem Text="Ineligible Borrower" Value="ineligible borrower" />
                    <asp:ListItem Text="Perkins Cancellation" Value="perkins cancellation" />
                    <asp:ListItem Text="TLF" Value="tlf" />
                    <asp:ListItem Text="Unenforceable" Value="unenforceable" />
                    <asp:ListItem Text="UNP" Value="unp" />
                    <asp:ListItem Text="UNS" Value="uns" />
                    <asp:ListItem Text="9-11" Value="9-11" />
                </asp:DropDownList> <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Claim Type is a required field *"
                ControlToValidate="ddlDischargeType" Display="Dynamic" CssClass="alert-danger" ValidationGroup="2" />
            </td>
            
            <td>
             <!--Servicer Name-->
            <label class="control-label" for="MainContent_ddlServicer">Servicer Name</label><br />
            <asp:DropDownList ID="ddlServicer" runat="server" CssClass="inputBox">
                            <asp:ListItem Text="" Value="" />
                            <asp:ListItem Text="Aspire" Value="aspire" />
                            <asp:ListItem Text="Cornerstone" Value="cornerstone" />
                            <asp:ListItem Text="COSTEP" Value="costep" />
                            <asp:ListItem Text="EDGEucation" Value="edgeucation" />
                            <asp:ListItem Text="EdFinancial" Value="edfinancial" />
                            <asp:ListItem Text="EdManage" Value="edmanage" />
                            <asp:ListItem Text="ECSI" Value="ecsi" />
                            <asp:ListItem Text="Granite State" Value="granite state" />
                            <asp:ListItem Text="Great Lakes" Value="great lakes" />
                            <asp:ListItem Text="KSA" Value="ksa" />
                            <asp:ListItem Text="MOHELA" Value="mohela" />
                            <asp:ListItem Text="Nelnet" Value="nelnet" />
                            <asp:ListItem Text="OSLA" Value="osla" />
                            <asp:ListItem Text="PHEAA" Value="pheaa" />
                            <asp:ListItem Text="SLMA" Value="slma" />
                            <asp:ListItem Text="VSAC" Value="vsac" />                                                                                                           
                        </asp:DropDownList><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Servicer Name is a required field *"
                ControlToValidate="ddlServicer" Display="Dynamic" CssClass="alert-danger" ValidationGroup="2" />
            </td>
           </tr>
           
          <tr> 
            <td>&nbsp;</td>
              <td>
                  <!--Date Received-->
                  <label class="control-label" for="MainContent_txtDateReceived">
                  Date Received</label><br />
                  <asp:TextBox ID="txtDateReceived" runat="server" CssClass="datepicker" />
                  
                <br />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Date Received is a required field *"
                ControlToValidate="txtDateReceived" Display="Dynamic" CssClass="alert-danger" ValidationGroup="2" />
              </td>
            <td>
            <!--DateCompleted-->
            <label class="control-label" for="MainContent_txtDateCompleted">Date Completed</label><br />
            <asp:TextBox ID="txtDateCompleted" runat="server" CssClass="datepicker" /><br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Date Completed is a required field *"
                ControlToValidate="txtDateCompleted" Display="Dynamic" CssClass="alert-danger" ValidationGroup="2" /></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td colspan="2">
                <!--Approve-->
                <label class="control-label" for="MainContent_chkApprove">
                Approve?</label><br />
                <asp:CheckBox ID="chkApprove" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                 &nbsp;&nbsp;</td>
            <td colspan="2">
                <label class="control-label" for="MainContent_txtComments">
                Comments</label><br />
                <asp:TextBox ID="txtComments" runat="server" Columns="75" Rows="9" 
                    TextMode="MultiLine" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
            <td colspan="2" align="center">
                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-lg btn-primary" 
                    OnClick="btnUpdate_Click" Text="Complete Claim" ValidationGroup="2" />
                    <asp:CustomValidator id="CustomValidator1"
                        ControlToValidate="txtComments"
                        OnServerValidate="ServerValidation" ClientValidationFunction="validate"
                        Display="Dynamic"
                        ErrorMessage="You must enter comments if the claim is not approved"
                        CssClass="alert-danger" 
                        ValidationGroup="2"
                        runat="server" />
                <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-lg btn-warning" 
                    Text="Cancel" />
                <asp:Button ID="btnDeleteClaim" runat="server" CssClass="btn btn-lg btn-danger" Text="Delete Claim" 
                OnClick="btnDeleteClaim_Click" OnClientClick="if ( !confirm('Are you sure you want to delete this claim?')) return false" />
                <br />
                <asp:Label ID="lblUpdateConfirm" runat="server" CssClass="warning" />
            </td>
        </tr>
    </table>
   
    </asp:Panel>
    <!--End modal popup table-->
   </ContentTemplate>
   </asp:UpdatePanel> 
                     
</asp:Content>

