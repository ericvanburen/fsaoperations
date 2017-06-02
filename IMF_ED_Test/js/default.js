
$(document).ready(function() {
    // hides the slickbox as soon as the DOM is ready
    $('#divAgencyLogin').hide();
    $('#divEDLogin').hide();
    $('#rdPCA').click(
                function() {
                    if ($("#rdPCA").is(":checked")) {
                        $('#divAgencyLogin').show('slow');;
                        $('#divEDLogin').hide('slow');
                    } else {
                        $('#divAgencyLogin').hide('slow');
                        $('#divEDLogin').show('slow');
                    }
                });
            });

            function SelectAllCheckboxes(spanChk) {

                // Added as ASPX uses SPAN for checkbox
                var oItem = spanChk.children;
                var theBox = (spanChk.type == "checkbox") ?
            spanChk : spanChk.children.item[0];
                xState = theBox.checked;
                elm = theBox.form.elements;

                for (i = 0; i < elm.length; i++)
                    if (elm[i].type == "checkbox" &&
                  elm[i].id != theBox.id) {
                    if (elm[i].checked != xState)
                        elm[i].click();
                }
            }

$(function()
{
	$("#triggerDescription").click(function(event) {
		event.preventDefault();
		$("#searchForm").slideToggle();
	});
				
	$("#searchForm a").click(function(event) {
		event.preventDefault();
		$("#searchForm").slideUp();
	});
});

$(function() {
    $("#triggerMyStatus").click(function(event) {
    event.preventDefault();    
        $("#myStatus").slideToggle();
    });

    $("#myStatus a").click(function(event) {
        event.preventDefault();
        $("#myStatus").slideUp();
    });
});      
