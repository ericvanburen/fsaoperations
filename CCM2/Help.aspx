<%@ Page Title="Call Center Monitoring Help" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Help.aspx.vb" Inherits="CCM_Help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
<link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/menustyle.css" rel="stylesheet" type="text/css" />
     <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
        <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
        <script src="Scripts/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>       
       <script src="Scripts/menu.js" type="text/javascript"></script>
    <style type="text/css">
        .style1
        {
            width: 929px;
            height: 325px;
        }
        .style2
        {
            width: 927px;
            height: 455px;
        }
        .style4
        {
            width: 934px;
            height: 363px;
        }
        .style5
        {
            width: 460px;
            height: 290px;
        }
        .style6
        {
            width: 938px;
            height: 150px;
        }
        .style7
        {
            width: 918px;
            height: 588px;
        }
        .style8
        {
            width: 909px;
            height: 636px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
                         
                           <div id="menu" align="center" style="padding-right: 21px; padding-top: 5px; color: Blue;
                                font-size: small">
                                <ul id="nav">
                                     <li><a href="Help.aspx">Help</a></li>
                                     <li><a href="#">Reports</a>
                                        <ul>
                                            <li><a href="MyProductivityReport.aspx">My Productivity</a></li>                                    
                                        </ul>
                                         
                                    </li>
                                    <li><a href="Search.aspx">Search</a></li>
                                     <li><a href="#">Administration</a>
                                        <ul>                                           
                                            <li><a href="admin/ReportCallsMonitored.aspx">Call Center Count</a></li>
                                            <li><a href="admin/ReportFailedCalls.aspx">Failed Calls</a></li>
                                            <li><a href="admin/ReportAccuracy.aspx">Accuracy Report</a></li>
                                            <li><a href="admin/ReportIndividualProductivity.aspx">Productivity</a></li>
                                            <li><a href="admin/ReportIndividualProductivityCallCenter.aspx">Productivity-Call Center</a></li>
                                            <li><a href="admin/Search.aspx">Search</a></li>
                                            <li><a href="ChecksSearch.aspx">Servicer Check Report</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Monitoring</a>
                                        <ul>
                                            <li><a href="FormB.aspx">Enter Call</a></li>
                                            <li><a href="MyReviews.aspx">My Reviews</a></li>
                                            <li><a href="Checks.aspx">Add Servicer Check</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <p>&nbsp;</p>

    <p>The Call Center Monitoring application is used by the Call Center Branch to track and evaluate calls monitored by the team. Below are the topics covered in this document.</p>
   
    <ul>
        <li><a href="#Entering_New_Call">Entering a New Call</a></li>
        <li><a href="#Reviewing_Updating_Calls">Reviewing and Updating Your Calls</a> (My 
            Reviews)</li>
        <li><a href="#Spell_Checking_Calls">Spell-Checking Calls</a></li>
        <li><a href="#Update_History">Reviewing a Call's Update History</li>
        <li><a href="#Search">Searching Calls<a href="#"></li>

    </ul>
<a name="Entering_New_Call"></a><h2>Entering a New Call</h2>
        
<p>Analysts may enter a new call to review by clicking on &quot;Monitoring &gt; Enter Call&quot; on the navigation menu. 
    Analysts complete the form by completing the fields on the form and clicking the 
    &quot;Add Call&quot; button at the bottom of the form.</p>
&nbsp; 
    <img src="images/help/enter_new_call.jpg" alt="Enter New Call" /><br />
    <br />
    
    
    <a name="Reviewing_Updating_Calls"></a><h2>Reviewing and updating your calls</h2>
    <p>
        Analysts may review calls previously entered into the application by clicking on 
        &quot;Monitoring &gt; My Reviews&quot;. The table lists all of the calls reviewed by the 
        Analyst logged into the application.&nbsp; The calls can be exported to Excel 
        for further analysis by clicking on the Export to Excel button.</p>
    <p>
        An analyst may review the details of a specific call by clicking on the Review 
        ID of a given call.&nbsp;<img alt="My Reviews" class="style1" src="images/help/my_reviews.jpg" /></p>
    <p>
        Clicking on a Review ID brings the Analyst to the Update Call page. Here the 
        user may change and update any of the data of the call.
    </p>
    <p>
        <img alt="Update Call" class="style2" src="images/help/update_call.jpg" /></p>
&nbsp;
    <br />
    Clicking on the &#39;Update&#39; button at the bottom of the page saves the changes.
    <br />
    <br />
    <img alt="Save Changes" class="style4" src="images/help/update_call_save.jpg" /><br />
    <br />
    
    <h2>Spell Checking Calls</h2>
    <p>
        Any words that are potentially misspelled are underlined in red as they are 
        entered.&nbsp;
    </p>
    <br />
    <img alt="Spell Checking Calls " class="style4" 
        src="images/help/spell_check_call.jpg" /><br />
    <br />
    Analysts can spell-check the Comments field of the call details screen by 
    clicking on the &quot;ABC&quot; button next to the Comments box where spelling can be 
    updated.
    <br />
    <br />
    <img alt="Spell Check Popup" class="style5" 
        src="images/help/spell_check_popup.jpg" />
    <br />
    <br />
    <h2>
        <a name="Update_History"></a>Update History</h2>
    <p>
        Each time the call is updated, the transaction is recorded and shown in the 
        Update History section at the bottom of the page. The date of change, Event Type 
        (Call Updated, Call Added, Call Deleted) and who made the change are recorded.
        <br />
        <br />
        <img alt="Update History" class="style6" src="images/help/update_history.jpg" /></p>
     <a name="Search"></a><h2>Searching Calls</h2>
    <br />
    The application provides two search features: a Basic Search for Analysts and 
    another Power Search for application Administrators.&nbsp; The only difference 
    between the two is that search for Analysts allows the person logged in to 
    search for only their own calls (Evaluator value is their own) while the search 
    provided under the Administration menu allows the administrator to search the 
    entire database regardless of the value in the Evaluator field.&nbsp; Examples 
    of both search screens are below:<br />
    <br />
    Basic Search for Analysts. Notice the Evaluator field is disabled.<br />
    <br />
    <img alt="Basic Search" class="style7" src="images/help/basic_search.jpg" /><br />
    <br />
    Power Search For Administrators:<br />
    <img alt="Power Search" class="style8" src="images/help/power_search.jpg" /><br />
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>

