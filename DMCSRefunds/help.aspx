<%@ Page Title="DMCS Refunds Help" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="help.aspx.vb" Inherits="DMCSRefunds_help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 757px;
            height: 215px;
        }
        .style2
        {
            width: 795px;
            height: 302px;
        }
        .style3
        {
            width: 850px;
            height: 321px;
        }
        .style4
        {
            width: 834px;
            height: 235px;
        }
        .style5
        {
            width: 879px;
            height: 450px;
        }
        .style6
        {
            width: 870px;
            height: 596px;
        }
        .style7
        {
            width: 916px;
            height: 361px;
        }
        .style8
        {
            width: 930px;
            height: 649px;
        }
        .style9
        {
            width: 720px;
            height: 766px;
        }
        .style10
        {
            font-size: large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h2>DMCS Refunds help</h2>
    <p class="style10">Help Topics</p>
    <ul>
        <li><a href="#Reviewing_Refunds_LA">Reviewing Refunds Assigned to a Loan Analyst</a></li>
        <li><a href="#Uploading_new_refunds">Uploading New Refunds</a></li>
        <li><a href="#assigning_new_refunds">Assigning New Refunds</a></li>
        <li><a href="#searching_refunds">Searching For Refunds</a></li>
        <li><a href="#assigning_myself">Assigning New Refunds to Myself</a></li>
    </ul>
    <hr />
    <a name="Reviewing_Refunds_LA"></a><h2>Reviewing Refunds Assigned to a Loan Analyst</h2>
    <p>Loan Analysts can review refunds assigned to him/her by clicking on Refunds &gt; My 
        Refunds as shown below</p>
    <p>
        <img alt="My Refunds" class="style1" src="images/help/1.1.jpg" /></p>
    <p>
        The list of uncompleted refunds (in &#39;Received&#39; status) assigned to the Loan 
        Analyst appears in the table below.&nbsp; You&#39;ll notice several important 
        features available on this page which are indicated by red arrows.</p>
    <ul>
        <li>Show Refunds in Status: Loan Analysts can view refunds in any status - Received 
            (the default), Approved, Denied and Pending - by clicking on this dropdown list</li>
        <li>My Totals - Loan Analysts can see at a glance how many refunds they have in each 
            status</li>
        <li>Edit - Clicking on the pencil next to each refund allows the Loan Analyst to 
            review and update the status of each refund (details below)</li>
        <li>Export Checked Rows to Excel - Loan Analysts may export their refund list to 
            Excel by checking the records they want to export and clicking this button</li>
    </ul>
    <p>
        <img alt="My Refunds" class="style8" src="images/help/myrefunds.jpg" /></p>
    <p>
        After clicking the pencil next to a refund, the Loan Analyst can see the refund 
        details where she can update the status.&nbsp; Loan Analysts should complete the 
        Refund Amount, # of Payments and First Line Approval status fields.&nbsp; Only 
        Second Line Reviewers reviewing refunds over $4,999 should complete the Second 
        Line Approval Status field.&nbsp; Comments is an optional field which may be 
        completed if necessary.&nbsp; Complete the update by clicking the &quot;Update&quot; 
        button at the bottom.</p>
    <p>
        <img alt="Refund Details" class="style9" src="images/help/refund_details.jpg" /></p>
    <hr />
    <a name="Uploading_new_refunds"></a><h2>Uploading new refunds</h2>
    <p>Administrators may access the Adminstration menu to upload new refunds into the 
        DMCS Refunds application.&nbsp; To upload new refunds, click on the &quot;Browse&quot; 
        button next to the Upload New File box, browse to the refunds upload template 
        file, and click the Import button. </p>
    <p>NOTE: To upload a new list of refunds to the DMCS Refunds application, you must 
        use <a href="images/help/refunds.xls">this template</a>.&nbsp; The Excel file 
        must be named refunds.xls and in Excel 1997-2003 format.</p>
    <p>
        <img alt="Upload Refunds Menu" class="style4" 
            src="images/help/upload_refunds_menu.jpg" /></p>
    <hr />
    <a name="assigning_new_refunds"></a><h2>assigning new refunds</h2>
    <p>Administrators may access the Adminstration menu to assign new refunds to staff 
        members.&nbsp; By default, this function allows Administrators to assign refunds 
        which have not already been assigned to another Loan Analyst. In other words, 
        only refunds where the Assigned To status is null and First Line Approval Status 
        = &#39;Received&#39; are available to be reassigned using this page.</p>
    <p>Click on Administration &gt; Assign as shown below.<img alt="Assign Refunds Menu" 
            class="style2" src="images/help/assign_refunds_menu.jpg" /></p>
    <p>You may click on individual refunds by clicking the checkboxes next to each 
        refund or select all of them on the page in batches of 50 at a time by clicking 
        on the &quot;Click All Refunds&quot; button.&nbsp; Select the Loan Analyst you wish to 
        assign the refunds to from the Loan Analyst dropdown menu and then click the 
        &quot;Assign Checked Refunds to Loan Analyst&quot; button.&nbsp;&nbsp; The selected 
        refunds are then assigned to selected Loan Analyst. </p>
    <p>
        <img alt="Assign Refunds" class="style3" 
            src="images/help/assigning_refunds.jpg" /></p>
    <hr />
    <a name="searching_refunds"></a><h2>Searching for refunds</h2>
    <p>All users may search for refunds using the Search Refunds feature.&nbsp; To 
        access the Search page, click on Search &gt; Search Refunds.&nbsp; Users can search 
        for refunds using multiple search criteria by filling in the form and clicking 
        on the Search button. </p>
    <p>
        <img alt="Search Refunds" class="style5" src="images/help/search_refunds.jpg" /></p>
    <p>The search results appear in the grid below. You may click on individual refunds 
        by clicking the checkboxes next to each refund or select all of them on the page 
        by clicking on the &quot;Click All Refunds&quot; button. After selecting the refunds, all 
        users, may export the results to Excel by clicking on the &quot;Export Checked Rows 
        to Excel&quot; button. Adminstrators may reassign checked refunds by clicking on the 
        &quot;Assign Checked Refunds to Loan Analyst&quot; and selecting a Loan Analyst from the 
        Loan Analyst dropdown list.&nbsp;&nbsp;&nbsp; </p>
    <p>
        <img alt="Search Results" class="style6" src="images/help/search_results.jpg" /></p>
    <hr />
    <a name="assigning_myself"></a><h2>Assigning new refunds to myself</h2>
    <p>Loan Analysts may assign themselves new refunds by clicking on Refunds &gt; Get New 
        Refunds.&nbsp; The refunds on this page have not been assigned to another Loan 
        Analyst and still in a First Line Approval Status of &#39;Received&#39;.&nbsp; Loan 
        Analysts may assign themselves just a few refunds by clicking on them one at a 
        time by checking the checkbox next to each refund or by checking all of the 
        refunds on the page in batches of 20 by clicking on the &quot;Check All Refunds&quot; 
        button.&nbsp; The Loan Analyst must then click on the &quot;Assign Checked Refunds to 
        Me&quot; button. The seclted refunds are then assigned to the Loan Analyst logged in. 
    </p>
    <p>
        <img alt="Get Refunds" class="style7" src="images/help/get_refunds.jpg" /></p>

</asp:Content>

