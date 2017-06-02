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

             //QC
             $("#pnlQCHeading").click(function () {
                 $("#pnlQCBody").slideToggle();
                 if ($("#expanderSignQC").text() == "+") {
                     $("#expanderSignQC").html("−")
                 }
                 else {
                     $("#expanderSignQC").text("+")
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

             //History             
             $("#pnlHistoryHeading").click(function () {
                 $("#pnlHistoryBody").slideToggle();
                 if ($("#expanderSignHistory").text() == "+") {
                     $("#expanderSignHistory").html("−")
                 }
                 else {
                     $("#expanderSignHistory").text("+")
                 }
             });

         });


         $(document).ready(function () {
             // initialize the datepicker object
             $('.datepicker').datepicker()

             var strIssueType = $('#MainContent_Repeater1_ddlIssueType_0').val();
             
             if (strIssueType == 'PCA') {                
                 $('#MainContent_Repeater1_lblIssueType_0').text("Update PCA Issue");
                 $('div[id$=pnlMainDiv]').show();
                 $('div[id$=pnlIssueSource]').show();
                 $('div[id$=pnlPCAComplaints]').show();
                 $('div[id$=pnlLiaisonIssues]').hide();
                 $('div[id$=pnlBorrowerDetails]').show();
                 $('div[id$=pnlAttachments]').show();
                 $('div[id$=pnlHistory]').show();

                 //set the default value for category
                 $('#MainContent_Repeater1_ddlCategoryID_0').val("108");

                 //Disable the category and subcategory dropdowns
                 $('#MainContent_Repeater1_ddlCategoryID_0').prop('disabled', true);
                 $('#MainContent_Repeater1_ddlSubCategoryID_0').prop('disabled', true);

                 //set the default value for source org type and disable it
                 //$('#MainContent_Repeater1_ddlSourceOrgType_0').val("Borrower");
                
                 //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                 $('#MainContent_Repeater1_ddlCategoryID_0').prop('disabled', true);
                 $('#MainContent_Repeater1_ddlSubCategoryID_0').prop('disabled', true);
                 $('#MainContent_Repeater1_ddlSourceOrgID_0').prop('disabled', true);
                 $('#MainContent_Repeater1_txtSourceName_0').prop('disabled', true);
                 $('#MainContent_Repeater1_txtOwner_0').prop('disabled', true);
                 $('#MainContent_Repeater1_ddlRootCause_0').prop('disabled', true);
                 $('#MainContent_Repeater1_txtSourceContactInfo_0').prop('disabled', true);

             } else if (strIssueType == 'Liaisons') {
                 $('#MainContent_Repeater1_lblIssueType_0').text("Update Liaison Issue");
                 $('div[id$=pnlMainDiv]').show();
                 $('div[id$=pnlIssueSource]').show();
                 $('div[id$=pnlPCAComplaints]').hide();
                 $('div[id$=pnlLiaisonIssues]').show();
                 $('div[id$=pnlBorrowerDetails]').hide();
                 $('div[id$=pnlAttachments]').show();
                 $('div[id$=pnlHistory]').show();

                 //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                 $('#MainContent_Repeater1_ddlCategoryID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlSubCategoryID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlSourceOrgID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtSourceName_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtOwner_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlRootCause_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtSourceContactInfo_0').prop('disabled', false);

             } else if (strIssueType == 'Call Center') {
                 $('#MainContent_Repeater1_lblIssueType_0').text("Update Center Branch Issue");
                 $('div[id$=pnlMainDiv]').show();
                 $('div[id$=pnlIssueSource]').show();
                 $('div[id$=pnlPCAComplaints]').hide();
                 $('div[id$=pnlLiaisonIssues]').hide();
                 $('div[id$=pnlBorrowerDetails]').show();
                 $('div[id$=pnlAttachments]').hide();
                 $('div[id$=pnlHistory]').show();

                 //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                 $('#MainContent_Repeater1_ddlCategoryID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlSubCategoryID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlSourceOrgID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtSourceName_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtOwner_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlRootCause_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtSourceContactInfo_0').prop('disabled', false);

             } else if (strIssueType == 'Escalated') {
                 $('#MainContent_Repeater1_lblIssueType_0').text("Update Escalated Issue");
                 $('div[id$=pnlMainDiv]').show();
                 $('div[id$=pnlIssueSource]').show();
                 $('div[id$=pnlPCAComplaints]').hide();
                 $('div[id$=pnlLiaisonIssues]').hide();
                 $('div[id$=pnlBorrowerDetails]').show();
                 $('div[id$=pnlAttachments]').hide();
                 $('div[id$=pnlHistory]').show();

                 //Enable category, subcategory, Source org type, source org name, source name, owner, root cause, source contact info
                 $('#MainContent_Repeater1_ddlCategoryID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlSubCategoryID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlSourceOrgID_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtSourceName_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtOwner_0').prop('disabled', false);
                 $('#MainContent_Repeater1_ddlRootCause_0').prop('disabled', false);
                 $('#MainContent_Repeater1_txtSourceContactInfo_0').prop('disabled', false);
             }
             $('#MainContent_btnSubmit').show();
         });

      // This function changes the validity to Pending when a complaint is checked
         $(function () {
             $("#MainContent_Repeater1_chkComplaintTypeA_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeA_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeA_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeB_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeB_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeB_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeC_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeC_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeC_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeD_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeD_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeD_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeE_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeE_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeE_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeF_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeF_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeF_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeG_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeG_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeG_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeH_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeH_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeH_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeI_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeI_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeI_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeJ_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeJ_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeJ_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeK_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeK_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeK_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeL_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeL_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeL_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeM_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeM_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeM_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeN_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeN_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeN_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeO_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeO_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeO_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeP_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeP_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeP_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeQ_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeQ_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeQ_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeR_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeR_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeR_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeS_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeS_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeS_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeT_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeT_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeT_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeU_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeU_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeU_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeV_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeV_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeV_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeW_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeW_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeW_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeX_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeX_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeX_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeY_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeY_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeY_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeZ_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeZ_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeZ_Validity_0").val("");
                 }
             });

             $("#MainContent_Repeater1_chkComplaintTypeZZ_0").click(function () {
                 if (this.checked) {
                     $("#MainContent_Repeater1_ddlComplaintTypeZZ_Validity_0").val("Pending");
                 } else {
                     $("#MainContent_Repeater1_ddlComplaintTypeZZ_Validity_0").val("");
                 }
             });
         });

         $(function () {
             $('select[id$=MainContent_Repeater1_ddlIssueStatus_0]').change(function () {
                 if (this.value == 'Closed') {
                     var resolveDate = new Date();
                     resolveDate.setDate(resolveDate.getDate());
                     var newresolveDate = (resolveDate.getMonth() + 1) + "/" + (resolveDate.getDate()) + "/" + resolveDate.getFullYear();
                     $('#MainContent_Repeater1_txtDateResolved_0').val(newresolveDate);
                     alert("Please ensure that the Date Resolved value is accurate");
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
         $(document).ready(function () {
             $(".defaultText").focus(function (srcc) {
                 if ($(this).val() == $(this)[0].title) {
                     $(this).removeClass("defaultTextActive");
                     $(this).val("");
                 }
             });

             $(".defaultText").blur(function () {
                 if ($(this).val() == "") {
                     $(this).addClass("defaultTextActive");
                     $(this).val($(this)[0].title);
                 }
             });

             $(".defaultText").blur();
         });

        
             
         
