// Form submit click
// The 'must say' rehab fields must be populated
$(function () {
    $("#MainContent_btnSubmit").click(function (e) {
        var s = document.getElementById('MainContent_ddlRehabTalkOff');
        var item1 = s.options[s.selectedIndex].value;
        if (item1 == 'Yes') {

            if ($('#MainContent_ddlScore_Rehab_Once').val() == '') {
                alert("You must select a value for MUST Say - Rehab Once");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_Nine_Payments').val() == '') {
                alert("You must select a value for MUST Say - 9 Payments");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_TitleIV').val() == '') {
                alert("You must select a value for MUST Say - Title IV Eligibility");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_Credit_Reporting').val() == '') {
                alert("You must select a value for MUST Say - CBR removes the record of default");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_TOP').val() == '') {
                alert("You must select a value for MUST Say - TOP");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_AWG').val() == '') {
                alert("You must select a value for MUST Say - AWG");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_Continue_Payments').val() == '') {
                alert("You must select a value for MUST Say - Continue Payments");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_Collection_Charges_Waived').val() == '') {
                alert("You must select a value for MUST Say - Collection Charges Waived");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_Financial_Documents').val() == '') {
                alert("You must select a value for MUST Say - Financial Documents");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_Rehab_Agreement_Letter').val() == '') {
                alert("You must select a value for MUST Say - Rehab Agreement Letter");
                e.preventDefault();
            }

            if ($('#MainContent_ddlScore_Contact_Us').val() == '') {
                alert("You must select a value for MUST Say - Contact Us");
                e.preventDefault();
            }
        }
    });
});