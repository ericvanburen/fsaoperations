         $(document).ready(function () {
             $("#pnlMainDivHeading").click(function () {
                 $("#pnlMainDivBody").slideToggle();
                 if ($("#expanderSignMainDiv").text() == "+") {
                     $("#expanderSignMainDiv").html("−")
                 }
                 else {
                     $("#expanderSignMainDiv").text("+")
                 }
             });

             //Issue Source
             $("#pnlIssueSourceHeading").click(function () {
                 $("#pnlIssueSourceBody").slideToggle();
                 if ($("#expanderSignIssueSource").text() == "+") {
                     $("#expanderSignIssueSource").html("−")
                 }
                 else {
                     $("#expanderSignIssueSource").text("+")
                 }
             });

             //PCA Complaints
             $("#pnlPCAComplaintsHeading").click(function () {
                 $("#pnlPCAComplaintsBody").slideToggle();
                 if ($("#expanderSignPCAComplaints").text() == "+") {
                     $("#expanderSignPCAComplaints").html("−")
                 }
                 else {
                     $("#expanderSignPCAComplaints").text("+")
                 }
             });

             //Liaison Issues
             $("#pnlLiaisonIssuesHeading").click(function () {
                 $("#pnlLiaisonIssuesBody").slideToggle();
                 if ($("#expanderSignLiaisonIssues").text() == "+") {
                     $("#expanderSignLiaisonIssues").html("−")
                 }
                 else {
                     $("#expanderSignLiaisonIssues").text("+")
                 }
             });

             //Borrower Details
             $("#pnlBorrowerDetailsHeading").click(function () {
                 $("#pnlBorrowerDetailsBody").slideToggle();
                 if ($("#expanderSignBorrowerDetails").text() == "+") {
                     $("#expanderSignBorrowerDetails").html("−")
                 }
                 else {
                     $("#expanderSignBorrowerDetails").text("+")
                 }
             });

             //Attachments
             $("#pnlAttachmentsHeading").click(function () {
                 $("#pnlAttachmentsBody").slideToggle();
                 if ($("#expanderSignAttachments").text() == "+") {
                     $("#expanderSignAttachments").html("−")
                 }
                 else {
                     $("#expanderSignAttachments").text("+")
                 }
             });

         });
      
    
         $(document).ready(function () {
             // initialize the datepicker object
             $('.datepicker').datepicker()
             
             //hide all of the issue panels
             $('div[id$=pnlMainDiv]').show();
             $('div[id$=pnlIssueSource]').show();
             $('div[id$=pnlPCAComplaints]').show();
             $('div[id$=pnlLiaisonIssues]').show();
             $('div[id$=pnlBorrowerDetails]').show();
             $('div[id$=pnlAttachments]').hide();
             $('#MainContent_btnSubmit').show();
             $('#MainContent_lblIssueType').text("All Issues");           
         });

         $(function () {
             $('select[id$=MainContent_ddlIssueType]').change(function () {
                 if (this.value == 'PCA') {
                     $('#MainContent_lblIssueType').text("PCA Issue");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').show();
                     $('div[id$=pnlLiaisonIssues]').hide();
                     $('div[id$=pnlBorrowerDetails]').show();
                     $('div[id$=pnlAttachments]').show();                     
                 } else if (this.value == 'Liaisons') {
                     $('#MainContent_lblIssueType').text("Liaison Issue");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').hide();
                     $('div[id$=pnlLiaisonIssues]').show();
                     $('div[id$=pnlBorrowerDetails]').hide();
                     $('div[id$=pnlAttachments]').show();
                 } else if (this.value == 'Call Center') {
                     $('#MainContent_lblIssueType').text("Call Center Branch Issue");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').hide();
                     $('div[id$=pnlLiaisonIssues]').hide();
                     $('div[id$=pnlBorrowerDetails]').show();
                     $('div[id$=pnlAttachments]').hide();
                 } else if (this.value == 'Escalated') {
                     $('#MainContent_lblIssueType').text("Escalated Issue");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').hide();
                     $('div[id$=pnlLiaisonIssues]').hide();
                     $('div[id$=pnlBorrowerDetails]').show();
                     $('div[id$=pnlAttachments]').hide();
                 } else if (this.value == 'All Types') {
                     $('#MainContent_lblIssueType').text("All Issues");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').show();
                     $('div[id$=pnlLiaisonIssues]').show();
                     $('div[id$=pnlBorrowerDetails]').show();
                     $('div[id$=pnlAttachments]').hide();
                 }
                 $('#MainContent_btnSubmit').show();
             });
         });  
