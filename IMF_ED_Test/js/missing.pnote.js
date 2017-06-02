
function changePage(url) {
    window.location = url;
}

oldvalue = "";
function passText(passedvalue) {
    if (passedvalue != "") {
        var totalvalue = passedvalue + "\n" + oldvalue;
        document.form1.txtDebts.value = totalvalue;
        oldvalue = document.form1.txtDebts.value;
    }

    var searchford = 'd';
    var searchforp = 'p';

    oldvalue = oldvalue.toLowerCase();
    if (oldvalue.search(searchford) > -1) {
        document.getElementById('form1').rblCheckedDImages_0.disabled = false;
        document.getElementById('form1').rblCheckedDImages_1.disabled = false;
    }
    else {
        document.getElementById('form1').rblCheckedDImages_0.disabled = true;
        document.getElementById('form1').rblCheckedDImages_1.disabled = true;
    }

    if (passedvalue.search(searchforp) > -1) {
        alert('This debt type will not have a PNote');
    }
}




function displayCalendar() {
    varDatePicker = document.getElementById('datePicker');
    datePicker.style.display = 'block';
}

function openWinPNoteConfirmation() {
    msgWindow = window.open('pnote.confirmation.aspx', 'PNote_Confirmation', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=0,width=400,height=500');
}

