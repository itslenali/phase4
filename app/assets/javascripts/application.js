//= require rails-ujs
//= require jquery
//= require materialize-sprockets
//= require_tree .

$('select').material_select();

$( document ).ready(function () { 
    $(".dropdown-button").dropdown(); 


    $('.datepicker').pickadate({
        format: 'mmmmdd,yyyy',
        formatSubmit: 'mmmmdd,yyyy',
        selectMonths: true, // Creates a dropdown to control month selectYears: 15, // Creates a dropdown of 15 years to control year, today: 'Today',
        clear: 'Clear',
        close: 'Ok',
        closeOnSelect: false // Close upon selecting a date,
});
        
})

