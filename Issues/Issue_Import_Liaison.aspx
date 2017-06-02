<%@ Page Title="Import New Servicer Issue" Language="VB" MasterPageFile="~/Issues/Site.master" AutoEventWireup="false" CodeFile="Issue_Import_Liaison.aspx.vb" Inherits="Issues_Issue_Import_Liaison" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
   <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="scripts/scripts.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
   
    <script type="text/javascript">
        // this updates the active tab on the navbar
        $(document).ready(function () {
            //Dashboard
            $('#navA0').removeClass("active");
            //Add Issue
            $('#navA1').addClass("active");
            //My Issues
            $('#navA2').removeClass("active");
            //Search Issues
            $('#navA3').removeClass("active");
            //Reports
            $('#navA4').removeClass("active");
            //Administration
            $('#navA5').removeClass("active");

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
<br />
<asp:Panel ID="Panel1" runat="server">
   <p>Select the issue form to import and then click Upload.  You must use <a href="IssueTrackerSubmissionForm.xls">this template</a> to import an issue.</p>
    <asp:FileUpload ID="FileUpload1" runat="server" />  
    <asp:Label ID="lblMessage" runat="server" Text="" /><br />
    <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
    <asp:Label ID="lblFileName" runat="server" Text="" Visible="false" />   
 </asp:Panel>
</asp:Content>

