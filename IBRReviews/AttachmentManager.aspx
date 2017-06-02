<%@ Page Title="IBR Reviews - Attachment Manager" Language="VB" AutoEventWireup="true" CodeFile="AttachmentManager.aspx.vb" Inherits="IBRReviews_AttachmentManager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>IBR Reviews - Attachment Manager</title>

    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function closeWin() {
            myWindow.close();
        }    
    </script>

</head>
<body>

<form id="form1" runat="server">
<h3>IBR Reviews</h3>


<asp:Panel ID="pnlUploadAttachment" runat="server" Visible="false">
<table style="background-color:#eeeeee;" width="600px" cellpadding="3" cellspacing="2">
  <tr>
    <td align="left">Click the Browse... button to select the attachment from your computer that you want to associate with this review.</td>
  </tr>
  <tr>
    <td align="left"><asp:FileUpload ID="Image1Upload" runat="server" />           
        <br />
    <asp:Button ID="btnImage1Upload" runat="Server" Text="Upload Attachment" OnClick="btnUploadAttachment_Click" CssClass="btn btn-md btn-danger" />
     <asp:Button ID="btnCloseWindow" runat="server" Text="Close Window" OnClientClick="self.close();" CssClass="btn btn-md btn-primary" />
    
    <br /><br /><br /></td>
   </tr>
   <tr>
    <td align="left"><asp:Label ID="lblUploadMessage1" runat="server" CssClass="alert-danger" /></td>
   </tr>
</table>
</asp:Panel>

<asp:Panel ID="pnlDeleteAttachment" runat="server" Visible="false">
<table class="table" style="background-color:#eeeeee;" width="600px">
  <tr>
    <td align="left">Are you sure that you want to delete the attachment associated with this review?</td>
  </tr>
  <tr>    
    <td align="left"><asp:Button ID="btnDeleteAttachment" runat="server" Text="Delete Attachment" OnClick="btnDeleteAttachment_Click" CssClass="btn btn-md btn-danger" />  
    <asp:Button ID="btnDeleteAttachmentCancel" runat="server" Text="Cancel" OnClick="btnDeleteAttachmentCancel_Click" CssClass="btn btn-md btn-primary" /></td>
  </tr>
  <tr>
     <td align="left"><asp:Label ID="lblDeleteConfirm" runat="server" CssClass="alert-danger" /></td>
  </tr>
</table>
</asp:Panel>

<asp:Label ID="lblReviewID" runat="server" Visible="false" />
</form>
</body>
</html>

