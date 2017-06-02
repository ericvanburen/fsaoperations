<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="toast_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.toastmessage.js" type="text/javascript"></script>
    <link href="../Styles/jquery.toastmessage.css" rel="stylesheet" type="text/css" />
   
    <script type="text/javascript">

        function showSuccessToast() {
            alert("Success!");
            $().toastmessage('showSuccessToast', "Success Dialog which is fading away ...");
        }

        function showStickySuccessToast() {
            $().toastmessage('showToast', {
                text: 'Success Dialog which is sticky',
                sticky: true,
                position: 'top-right',
                type: 'success',
                closeText: '',
                close: function () {
                    console.log("toast is closed ...");
                }
            });
        }

        function showNoticeToast() {
            $().toastmessage('showNoticeToast', "Notice  Dialog which is fading away ...");
        }

        function showStickyNoticeToast() {
            $().toastmessage('showToast', {
                text: 'Notice Dialog which is sticky',
                sticky: true,
                position: 'top-left',
                type: 'notice',
                closeText: '',
                close: function () { console.log("toast is closed ..."); }
            });
        }

        function showWarningToast() {
            $().toastmessage('showWarningToast', "Warning Dialog which is fading away ...");
        }

        function showStickyWarningToast() {
            $().toastmessage('showToast', {
                text: 'Warning Dialog which is sticky',
                sticky: true,
                position: 'middle-right',
                type: 'warning',
                closeText: '',
                close: function () {
                    console.log("toast is closed ...");
                }
            });
        }

        function showErrorToast() {
            $().toastmessage('showErrorToast', "Error Dialog which is fading away ...");
        }

        function showStickyErrorToast() {
            $().toastmessage('showToast', {
                text: 'Error Dialog which is sticky',
                sticky: true,
                position: 'center',
                type: 'error',
                closeText: '',
                close: function () {
                    console.log("toast is closed ...");
                }
            });
        }
  
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div>
    
 <p>
 <asp:Button ID="Button1" runat="server" Text="Button Server" /></p>
   
    <input id="Button2" type="button" value="button client" onclick="showSuccessToast();"/>
    <p>
            <span class="description">Show a success toast</span> <a href="javascript:showSuccessToast();">not
            sticky</a>|<a href="javascript:showStickySuccessToast();">sticky</a>
        </p>
  
        <p>
            <span class="description">Show a notice toast</span> <a href="javascript:showNoticeToast();">not sticky</a>|<a
                href="javascript:showStickyNoticeToast();">sticky</a>
        </p>
  
        <p>
            <span class="description">Show a warning toast</span> <a href="javascript:showWarningToast();">not
            sticky</a>|<a href="javascript:showStickyWarningToast();">sticky</a>
        </p>
  
        <p>
            <span class="description">Show a error toast</span> <a href="javascript:showErrorToast();">not sticky</a>|<a
                href="javascript:showStickyErrorToast();">sticky</a>
        </p>
  
    </div>

</asp:Content>

