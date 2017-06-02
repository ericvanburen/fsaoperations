<%@ Page Title="FSA Operations Services" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Default.aspx.vb" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <link href="bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="bootstrap/dist/css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    
    
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
        .newStyle1 {
            font-family: "Open Sans", Arial, "Lucida Grande", sans-serif;
            font-size: x-large;
            font-weight: bold;
            font-style: normal;
            color: #3A87AD;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <span class="newStyle1">FSA Operations Services
    </span>
    </h2>
    <p style="padding-left:15px; padding-right:15px">Operations Services role is to assist Federal Loan Servicers (Loan Consolidation, Debt Management, and Temporary and Permanent Disability), Direct Loan Servicing Center, 
    the TIVAS and the NFP servicers in managing the federal loan portfolios they are contracted to service. 
    In that role we provide oversight of servicer activities through monitoring and review, to ensure that there is proper attention to customer service and adherence to applicable regulations.&nbsp;</p>
    
    <!--Bootstrap Carousel-->
    <%--<div id="opsCarousel" class="carousel slide" data-ride="carousel" data-interval="3000" align="center">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#opsCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#opsCarousel" data-slide-to="1"></li>
                        <li data-target="#opsCarousel" data-slide-to="2"></li>
                        <li data-target="#opsCarousel" data-slide-to="3"></li>
                    </ol>

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <img src="Images/bannerFSA_loans_grants.jpg" alt="...">
                            <%--<div class="carousel-caption">
                                <h3>Caption Text</h3>
                            </div>
                        </div>
                        <div class="item">
                            <img src="Images/bannerOfficeWorkers.jpg" alt="...">                           
                        </div>
                        <div class="item">
                            <img src="Images/bannerGlobal_Digital.jpg" alt="...">                            
                        </div>
                        <div class="item">
                            <img src="Images/bannerSpreadsheet.jpg" alt="...">                            
                        </div>
                    </div>

                    <!-- Controls -->
                    <a class="left carousel-control" href="#opsCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                    <a class="right carousel-control" href="#opsCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </a>
                </div> --%>
                <!-- End Carousel -->
    <br />
    
    <table align="center" class="style1">
        
        <tr>
            <td width="50%" valign="top">
                <a href="Issues/Issue_Add.aspx"><img alt="Complaints" class="style2" src="Images/icons/comments.png" /></a>
                <b>Operations Issues Tracking</b> <br /><br />
                Track borrower and servicer issues submitted from across the organization</td>
            <td width="50%" valign="top">
                <b>
                <a href="ATB/searchOPEID.aspx"><img alt="Business User" class="style2" src="Images/icons/business_user.png" /></a> Ability to 
                Benefit</b><br />
                <br />
                Our researchers make loan discharge decisions based on the borrower's ability to benefit from the 
                education received. This tool helps them make those decisions.
                </b>
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td width="50%" valign="top">
                <a href="PNoteTracker/Default.aspx"><img src="Images/icons/page_full.png" alt="Promissory Note" class="style2" /></a>
                <b>Promissory Note Requests</b><br />
                <br />
                We request promissory notes from many guaranty agencies 
                <br />
                and TIVAS.&nbsp; This 
                tool helps us track those requests.<br />
                
                </td>
            <td width="50%" valign="top">
                <a href="DMCSRefunds/Default.aspx"><img alt="DMCS Refunds" class="style2" 
                    src="Images/icons/dollar_currency_sign.png" /></a><b>DMCS Refunds<br />
                </b><br />
                A workflow tool used to track and review refund requests from DMCS Titanium.<br />
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td width="50%" valign="top">
                <a href="ClosedSchool/Default.aspx"><img alt="Apple" class="style2" src="Images/icons/apple.png" /></a>
                <b>Closed School Search</b> <br /><br />
                A search tool for finding closed school data</td>
            <td width="50%" valign="top">
                <a href="CCM/FormB.aspx">
                <img alt="Phone" class="style3" src="Images/icons/television.png" /></a><strong> Call Monitoring</strong><br />
                <br /> Call Center quality is a key component to providing borrowers with 
                quality customer service.
                <br /><br />
            </td>
        </tr>
<tr>
	<td width="50%" valign="top"><a href="PCACalls/NewReview.aspx"><img alt="Phone" class="style2" src="Images/icons/phone.png" /></a>
                <b>PCA Call Reviews</b> <br /><br />
                Our FSA Processing team reviews borrower calls to PCAs to monitor<br/ > performance and quality</td>
<td width="50%" valign="top"><a href="SpecialtyClaims/EnterNewClaim.aspx"><img alt="Claims" class="style2" src="Images/icons/exclamination_mark.png" /></a>
                <b>Specialty Claims</b> <br /><br />
                Our FSA Processing team processes and reviews claims for loan discharge made by the loan servicers<br />
    <br /><br /></td>
</tr>

<tr>
	<td width="50%" valign="top"><a href="IBRReviews/EnterNewReview.aspx"><img alt="Phone" class="style2" src="Images/icons/target.png" /></a>
                <b>IBR Reviews</b> <br /><br />
                We also monitor Income-Based Reviews for the PCAs to make sure they are hitting their targets</td>
<td width="50%" valign="top"><a href="TOPLog/"><img alt="Phone" class="style2" src="Images/icons/page.png" /></a>
                <b>TOP Logs</b> <br /><br />
                Our staff is using a streamlined workflow process to effectively review Treasury Offset Program decertification requests</td>
</tr>

 <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>

<script type="text/javascript">
    $('.carousel').carousel({
        interval: 6000
    })
</script>
    
</asp:Content>