//= require rails-ujs
//= require materialize-sprockets
//= require_tree .

$('select').material_select();

$( document ).ready(function () { 
    $(".dropdown-button").dropdown({ hover: true, constrainWidth: false }); 



    $('.datepicker').pickadate({
        format: 'mmmmdd,yyyy',
        formatSubmit: 'mmmmdd,yyyy',
        selectMonths: true, // Creates a dropdown to control month 
        changeYear: true, // Creates a dropdown of 15 years to control year, today: 'Today',
        yearRange:"1980:2019",
        clear: 'Clear',
        close: 'Ok',
        closeOnSelect: false // Close upon selecting a date,
});
        
})

