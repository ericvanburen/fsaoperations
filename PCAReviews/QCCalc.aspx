<%@ Page Title="QC Calculator" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="QCCalc.aspx.vb" Inherits="PCAReviews_QCCalc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="../Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="../bootstrap/dist/js/bootstrap.js" type="text/javascript"></script>
    <script src="../bootstrap/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../bootstrap/js/tooltip.js" type="text/javascript"></script>
    <link href="../bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
   body {
     font-family: Arial, Helvetica, sans-serif
   }
   .footnote {
     font-size: small;
}
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <!--Navigation Menu-->
    <div>
 <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
  <li class="dropdown">
    <a href="#" id="A2" class="dropdown-toggle" data-toggle="dropdown">My Reviews <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop2">
        <li><a href="MyReviews.aspx">My Reviews</a></li>
        <li><a href="MyNewAssignments.aspx">My Assignments</a></li>
    </ul>
  </li>

  <li class="dropdown">
    <a href="#" id="A3" class="dropdown-toggle" data-toggle="dropdown">Search <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop3">
        <li><a href="Search.aspx">PCA Reviews</a></li>
    </ul>
  </li>

  <li class="dropdown active">
    <a href="#" id="myTabDrop1" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
    <ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop4">
        <li><a href="Reports.aspx">Save New PCA Review Old</a></li>
        <li><a href="Reports2.aspx">Save New PCA Review</a></li>
        <li><a href="Reports_SavedReports.aspx">Search PCA Reviews</a></li>       
        <li><a href="LAAssignments.aspx">LA Assignments</a></li>
        <li><a href="MakeAssignments.aspx">Make New LA Assignments</a></li>
        <li><a href="DataRequests.aspx">Data Requests</a></li>
        <li><a href="ReportsPCACallErrors.aspx">PCA Reviews - LA Errors</a></li>
        <li><a href="LetterReviews.aspx">Final Review Letter</a></li>
        <li><a href="Reports_PCA_Performance.aspx">PCA Performance</a></li>
        <li><a href="Reports_Incorrect_Actions_ByGroup.aspx">PCA Incorrect Actions Summary</a></li>
        <li><a href="Reports_Incorrect_Actions.aspx">PCA Incorrect Actions Detail</a></li>
        <li><a href="QCCalc.aspx">QC Calculator</a></li>
    </ul>
  </li>
 </ul>
 </div>
 <br />
<!--End Navigation Menu-->
    <div class="panel panel-primary">
  <div class="panel-heading">
    <span class="panel-title">QC Calculator</span>
  </div>
  <div class="panel-body"> 
                
     <div> 
   <h3>PCA Review Quality Control Account Selection Calculator</h3>    

 <table>
 <tr>
	<td align="right"><label>Total Accounts:</label></td><td colspan="3"><input type="text" id="txtTotalAccounts" name="txtTotalAccounts"></td>
 </tr>
 <tr>
	<td align="right"><label>Accounts With Errors:</label></td><td colspan="3"><input type="text" id="txtAccountsErrors" name="txtAccountsErrors"></td>
 </tr>
 <tr>
	<td align="right"><label>Accounts Without Errors:</label></td><td colspan="3"><input type="text" id="txtAccountsWithoutErrors" name="txtAccountsWithoutErrors" disabled></td>
 </tr>
 <tr>
    <td></td>
	<td colspan="3" align="left"><asp:Button ID="btnCalc" runat="server" Text="Get Sample Sizes" CssClass="btn btn-md btn-primary" OnClientClick="myFunction(); return false;" /><br /></td>
 </tr> 
 <tr>
	<td align="right"><label>* QC Sample Size With Errors:</label></td> <td><strong><span id="QCErrors" class="alert-danger"> </span></strong> </td>
    <td align="right"><label> * QC Sample Size No Errors:</label> <strong><span id="QCNoErrors" class="alert-danger"></span></strong><br /></td>
 </tr>
     
</table>

 <h3>Buckets for Selection of Calls</h3>
  <ul>
	<li>Bucket 1 – Call Duration 7:00 – 15:00 Minutes</li>
        <li>Bucket 2 – Call Duration 15:01 – 30:00 Minutes</li>
        <li>Bucket 3 – Call Duration 30:01 – 45:00 Minutes</li>
  </ul>

<p id="footnote">* Samples are 10% of the accounts for call monitoring quality control from each Bucket (Telephone calls with errors and without errors).</p>
</div>

    <script type="text/javascript">
      function myFunction() {
        var y = parseInt(document.getElementById("txtTotalAccounts").value);
        var z = parseInt(document.getElementById("txtAccountsErrors").value);
	
	var we = document.getElementById("txtAccountsWithoutErrors");
	we.value = y-z;

	var qcErrors = (z * 0.1)
	if (qcErrors < 1) {
	    document.getElementById("QCErrors").innerHTML = "1"
	    } else {
	        document.getElementById("QCErrors").innerHTML = Math.ceil(qcErrors);
	    }
		
	var qcNoErrors = (y - z) * 0.1
	    if (qcNoErrors < 1) {
	        document.getElementById("QCNoErrors").innerHTML = "1"
	    } else {
	        document.getElementById("QCNoErrors").innerHTML = Math.ceil(qcNoErrors);
	    }
    }

    </script>    

   </div>        
  </div>
</asp:Content>

