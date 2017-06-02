$(function () {
    var UserID = document.getElementById('MainContent_ddlUserID');
    var FSAGroup = document.getElementById('MainContent_ddlFSAGroup');

    $('select[id$=UserID]').change(function () {
        //if (this.value == 'eric.vanburen' || this.value == 'carolyn.toomer') {
        if (this.value == 'brenda.wallace' || this.value == 'debbe.johnson' || this.value == 'demetrias.fogle'
            || this.value == 'destre.holloway' || this.value == 'helena.myers-wright' || this.value == 'janet.dragoo' || this.value == 'jason.vann'
            || this.value == 'karen.william' || this.value == 'katherine.coates' || this.value == 'larry.porter' || this.value == 'lauren.honemann'
            || this.value == 'lisa.oldre' || this.value == 'mark.walsh' || this.value == 'michael.wood' || this.value == 'sally.young'
            || this.value == 'sherika.roberts' || this.value == 'taisha.winters-ragland' || this.value == 'eric.vanburen') {
            FSAGroup.value = 'Bus Ops';
        } else if (this.value == 'douglas.laine' || this.value == 'bora.kim' || this.value == 'bryan.carmody' || this.value == 'fran.colantonio'
            || this.value == 'katharine.leavitt' || this.value == 'katrina.mcdonald' || this.value == 'kim.meadows' || this.value == 'melissa.butts'
            || this.value == 'nikcola.yorkshire' || this.value == 'shayla.mitchell' || this.value == 'stephanie.lowery' || this.value == 'tracey.stewart') {
            FSAGroup.value = 'FMB Group';
        } else {
            FSAGroup.value = '';
        }
    });
});

$(function () {
    var UserID = document.getElementById('MainContent_ddlUserID');
    var FSAGroup = document.getElementById('MainContent_ddlFSAGroup');
    var IssueType = document.getElementById('MainContent_ddlIssueType');

    $('select[id$=IssueType]').change(function () {
        if (UserID.value == 'brenda.wallace' || UserID.value == 'debbe.johnson' || UserID.value == 'demetrias.fogle'
            || UserID.value == 'destre.holloway' || UserID.value == 'helena.myers-wright' || UserID.value == 'janet.dragoo' || UserID.value == 'jason.vann'
            || UserID.value == 'karen.william' || UserID.value == 'katherine.coates' || UserID.value == 'larry.porter' || UserID.value == 'lauren.honemann'
            || UserID.value == 'lisa.oldre' || UserID.value == 'mark.walsh' || UserID.value == 'michael.wood' || UserID.value == 'sally.young'
            || UserID.value == 'sherika.roberts' || UserID.value == 'taisha.winters-ragland' || UserID.value == 'eric.vanburen') {
            FSAGroup.value = 'Bus Ops';
        } else if (UserID.value == 'douglas.laine' || UserID.value == 'bora.kim' || UserID.value == 'bryan.carmody' || UserID.value == 'fran.colantonio'
            || UserID.value == 'katharine.leavitt' || UserID.value == 'katrina.mcdonald' || UserID.value == 'kim.meadows' || UserID.value == 'melissa.butts'
            || UserID.value == 'nikcola.yorkshire' || UserID.value == 'shayla.mitchell' || UserID.value == 'stephanie.lowery' || UserID.value == 'tracey.stewart') {
            FSAGroup.value = 'FMB Group';
        } else {
            FSAGroup.value = '';
        }
    });
});