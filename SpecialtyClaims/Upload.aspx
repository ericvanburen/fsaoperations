<%@ Page Title="Specialty Claims - Upload New Claims" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Upload.aspx.vb" Inherits="SpecialtyClaims_Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<meta http-equiv="X-UA-Compatible" content="IE=9" />
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>    
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Specialty Claims Tracking</h3> 
 <div>
 <ul class="nav nav-tabs">
  <li><a href="EnterNewClaim.aspx">Enter New Claim</a></li>
  <li><a href="Search.aspx">Search/Update By Account</a></li>
  <li><a href="UpdateBatch.aspx">Approve Batch</a></li>  
  <li class="active"><a href="Upload.aspx">Upload New Batch</a></li>
  <li class="dropdown">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
        <li><a href="Reports.aspx">Servicer Files</a></li>
        <li><a href="ProductivityReport.aspx">LA Productivity</a></li>
        <li><a href="ServicerReceipts.aspx">Received By FSA</a></li>  
        <li><a href="ServicerReceiptsCountByMonth.aspx">Received By FSA By Month</a></li>
        <li><a href="AgingClaims.aspx">Aging Claims - Servicer</a></li> 
        <li><a href="AgingClaims_ClaimType.aspx">Aging Claims - Claim Type</a></li>        
    </ul>
  </li>
  <li><a href="PowerSearch.aspx">Search</a></li>
 </ul>
 </div>
<br />
<br />
 
 <p>Select an Excel file containing the claims that you want to upload.</p>  
 <fieldset style="border: 1px solid black; background-color: #eeeeee; padding-left: 10px;"> 
     <div align="center">
         <table cellpadding="2" cellspacing="1" border="0" style="border-collapse: collapse;"
             width="100%">
            <tr align="center">
                 <td align="left">Upload New File: 
                     <asp:FileUpload ID="fileuploadExcel" runat="server" />
                     <asp:RequiredFieldValidator
                         ID="RequiredFieldValidator1" runat="server" ErrorMessage="* You must select a file to upload *" ControlToValidate="fileUploadExcel" CssClass="alert-danger" Display="Dynamic" />&nbsp;&nbsp;&nbsp;<span
                         onclick="return confirm('Are you sure to import the selected Excel file?')"><br />
                    <asp:Button  ID="btnUploadExcelFile" runat="Server" Text="Import" OnClick="UploadFile_Click" CssClass="btn btn-md btn-primary"/> </span> 
                  </td> 
              </tr>
              <tr> 
                 <td align="left">
                     <asp:Label ID="lblMessage" runat="Server" EnableViewState="False" ForeColor="Blue"> 
                     </asp:Label> 
                  </td> 
              </tr>
           </table>
      </div> 
 </fieldset>
</asp:Content>

