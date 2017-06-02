<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="InvalidBrowser.aspx.vb" Inherits="InvalidBrowser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 95%;
            border-collapse: collapse;
            border: 1px solid #FFFFFF; 
            padding: 5px 15px 5px 5px;
        }
        .style2
        {
            width: 32px;
            height: 32px; 
            border:0px;
        }
        .style3
        {
            border-width: 0px;
        width: 32px;
            height: 32px;
       
    }
        .auto-style1 {
            font-size: xx-large;
        }
        .auto-style2 {
            font-size: medium;
        }
       
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <span class="auto-style2">Internet Explorer is not a supported browser for this application.  We recommended using either Google Chrome of Firefox as your browser when working with FSA Operations.

    </span>

    <br />
    <br />

    <img src="Images/googlechrome.jpg" height="100" width="100" /> <span class="auto-style1">Google Chrome&nbsp;&nbsp;&nbsp;
    <img alt="Firefox" height="100" src="Images/firefox.jpg" width="100" /> Firefox<br />
    <br />
    <br />
    </span>&nbsp;

</asp:Content>

