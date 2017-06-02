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
             $('div[id$=pnlMainDiv]').hide();
             $('div[id$=pnlIssueSource]').hide();
             $('div[id$=pnlLiaisonIssues]').hide();
             $('div[id$=pnlBorrowerDetails]').hide();
             $('div[id$=pnlAttachments]').hide();
             $('#MainContent_btnSubmit').hide();           
         });
        
         $(function () {
             $('select[id$=MainContent_ddlIssueType]').change(function () {
                 if (this.value == 'Liaisons') {
                    
                     $('#MainContent_lblIssueType').text("Liaison Issue");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').hide();
                     $('div[id$=pnlLiaisonIssues]').show();
                     $('div[id$=pnlBorrowerDetails]').hide();
                     $('div[id$=pnlAttachments]').show();

                     //set the default value for category
                     //$('#MainContent_ddlCategoryID').val("");

                     //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                     $('#MainContent_ddlCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSubCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSourceOrgID').prop('disabled', false);
                     $('#MainContent_txtSourceName').prop('disabled', false);
                     $('#MainContent_txtOwner').prop('disabled', false);
                     $('#MainContent_ddlRootCause').prop('disabled', false);
                     $('#MainContent_txtSourceContactInfo').prop('disabled', false);

                 } else if (this.value == 'Call Center') {
                     $('#MainContent_lblIssueType').text("Call Center Branch Issue");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').hide();
                     $('div[id$=pnlLiaisonIssues]').hide();
                     $('div[id$=pnlBorrowerDetails]').show();
                     $('div[id$=pnlAttachments]').hide();

                     //set the default value for category
                     //$('#MainContent_ddlCategoryID').val("");

                     //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                     $('#MainContent_ddlCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSubCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSourceOrgID').prop('disabled', false);
                     $('#MainContent_txtSourceName').prop('disabled', false);
                     $('#MainContent_txtOwner').prop('disabled', false);
                     $('#MainContent_ddlRootCause').prop('disabled', false);
                     $('#MainContent_txtSourceContactInfo').prop('disabled', false);

                 } else if (this.value == 'Escalated') {
                     $('#MainContent_lblIssueType').text("Escalated Issue");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').hide();
                     $('div[id$=pnlLiaisonIssues]').hide();
                     $('div[id$=pnlBorrowerDetails]').show();
                     $('div[id$=pnlAttachments]').hide();

                     //set the default value for category
                     //$('#MainContent_ddlCategoryID').val("");

                     //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                     $('#MainContent_ddlCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSubCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSourceOrgID').prop('disabled', false);
                     $('#MainContent_txtSourceName').prop('disabled', false);
                     $('#MainContent_txtOwner').prop('disabled', false);
                     $('#MainContent_ddlRootCause').prop('disabled', false);
                     $('#MainContent_txtSourceContactInfo').prop('disabled', false);

                 } else if (this.value == 'All Types') {
                     $('#MainContent_lblIssueType').text("All Issues");
                     $('div[id$=pnlMainDiv]').show();
                     $('div[id$=pnlIssueSource]').show();
                     $('div[id$=pnlPCAComplaints]').show();
                     $('div[id$=pnlLiaisonIssues]').show();
                     $('div[id$=pnlBorrowerDetails]').show();
                     $('div[id$=pnlAttachments]').hide();

                     //set the default value for category
                     //$('#MainContent_ddlCategoryID').val("");

                     //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                     $('#MainContent_ddlCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSubCategoryID').prop('disabled', false);
                     $('#MainContent_ddlSourceOrgID').prop('disabled', false);
                     $('#MainContent_txtSourceName').prop('disabled', false);
                     $('#MainContent_txtOwner').prop('disabled', false);
                     $('#MainContent_ddlRootCause').prop('disabled', false);
                     $('#MainContent_txtSourceContactInfo').prop('disabled', false);
                 }
                 $('#MainContent_btnSubmit').show();
             });
         });

         $(function () {
             $('select[id$=MainContent_ddlIssueStatus]').change(function () {
                 if (this.value == 'Closed') {
                     var resolveDate = new Date();
                     resolveDate.setDate(resolveDate.getDate());
                     var newresolveDate = (resolveDate.getMonth() + 1) + "/" + (resolveDate.getDate()) + "/" + resolveDate.getFullYear();
                     $('#MainContent_txtDateResolved').val(newresolveDate);
                     alert("Please ensure that the Date Resolved value is accurate");
                     var div = document.getElementById('closeValidation');
                     div.style.display = div.style.display == 'none' ? 'block' : 'none';
                 }
             });
         });

         $(function () {
             $('select[id$=MainContent_ddlValidationRequired]').change(function () {
                 if (this.value == 'Yes') {                    
                     var div = document.getElementById('accountsValidation');
                     div.style.display = div.style.display == 'none' ? 'block' : 'none';
                 }
             });
         });

       //This is for the tooltips
       $(function () {
           //$("[rel='smartpopoverTop']").popover({ placement: 'top' });       
           $("[rel='smartpopover']").popover();
           $("[rel='smartpopover']").on('click', function (e) { e.preventDefault(); return true; });
       });

        
        // sets the default text values for certain textboxes
        $(document).ready(function()
        {
            $(".defaultText").focus(function(srcc)
            {
                if ($(this).val() == $(this)[0].title)
                {
                    $(this).removeClass("defaultTextActive");
                    $(this).val("");
                }
            });
    
            $(".defaultText").blur(function()
            {
                if ($(this).val() == "")
                {
                    $(this).addClass("defaultTextActive");
                    $(this).val($(this)[0].title);
                }
            });
    
            $(".defaultText").blur();        
        });



       