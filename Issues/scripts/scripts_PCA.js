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

         });
      
    
         $(document).ready(function () {
             // initialize the datepicker object
             $('.datepicker').datepicker() 
             
             $('#MainContent_lblIssueType').text("PCA Issue");
                     
             //Set the due date to 20 days from current date
             var dueDate = new Date();
             dueDate.setDate(dueDate.getDate() + 20);
             var newDueDate = (dueDate.getMonth() + 1) + "/" + (dueDate.getDate()) + "/" + dueDate.getFullYear();
             $('#MainContent_txtDueDate').val(newDueDate);

             //set the default value for category
             $('#MainContent_ddlCategoryID').val("106");

             //Disable the category and subcategory dropdowns
             //$('#MainContent_ddlCategoryID').prop('disabled', true);
             // $('#MainContent_ddlSubCategoryID').prop('disabled', true);
                    
             //set the default value for source org type
             $('#MainContent_ddlSourceOrgType').val("Borrower");
                    
             //Disable Source Org Name, Source Name, Owner, Root Cause and Source Contact Info
             //$('#MainContent_ddlSourceOrgID').prop('disabled', true);
             //$('#MainContent_txtSourceName').prop('disabled', true);                     
             //$('#MainContent_txtOwner').prop('disabled', true);
             //$('#MainContent_ddlRootCause').prop('disabled', true);
             //$('#MainContent_txtSourceContactInfo').prop('disabled', true);          
             $('#MainContent_btnSubmit').show();
         });


        // This function changes the validity to Pending when a complaint is checked
         $(function () {
             $("#MainContent_chkComplaintTypeA").click(function () {                 
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeA_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeA_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeB").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeB_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeB_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeC").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeC_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeC_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeD").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeD_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeD_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeE").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeE_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeE_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeF").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeF_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeF_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeG").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeG_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeG_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeH").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeH_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeH_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeI").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeI_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeI_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeJ").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeJ_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeJ_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeK").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeK_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeK_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeL").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeL_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeL_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeM").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeM_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeM_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeN").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeN_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeN_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeO").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeO_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeO_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeP").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeP_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeP_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeQ").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeQ_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeQ_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeR").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeR_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeR_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeS").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeS_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeS_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeT").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeT_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeT_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeU").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeU_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeU_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeV").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeV_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeV_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeW").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeW_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeW_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeX").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeX_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeX_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeY").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeY_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeY_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeZ").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeZ_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeZ_Validity").val("");
                 }
             });

             $("#MainContent_chkComplaintTypeZZ").click(function () {
                 if (this.checked) {
                     $("#MainContent_ddlComplaintTypeZZ_Validity").val("Pending");
                 } else {
                     $("#MainContent_ddlComplaintTypeZZ_Validity").val("");
                 }
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



       