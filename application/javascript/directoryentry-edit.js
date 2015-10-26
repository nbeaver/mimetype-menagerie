$(document).ready(function() {
    if ($('#acceptedAt').val() !== "") {
        ($('#accept').prop('checked', true));
    } else if ($('#rejectedAt').val() !== "") {
        ($('#reject').prop('checked', true));
    }
    
    // get the original status before setting up the change handler as this can change the value
    comparison=calli.copyResourceData('#form');
    
    $('input:radio[name="status"]').change(function(event) {
        if ($('#accept').is(':checked')) {
            $('#acceptedAt').val(new Date().toISOString());
            $('#rejectedAt').val("");
        } else if ($('#reject').is(':checked')) {
            $('#rejectedAt').val(new Date().toISOString());
            $('#acceptedAt').val("");
        } else if ($('#pending').is(':checked')) {
            $('#acceptedAt').val("");
            $('#rejectedAt').val("");
        }
        $('#acceptedAt').change();
        $('#rejectedAt').change();
    });
});
