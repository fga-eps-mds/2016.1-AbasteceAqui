//= require dinamic_selection.js
$(document ).ready(function ( ) {

    var select_b = document.getElementById('select_button');
    if (select_b) {
      select_b.style.display = "none";
    }
    else {
    	//nothing to do
    }

    $('#select_tag').change(function() {
    $(this).closest('form').trigger('submit');


    });
    $('#select_tag1').change(function() {
    $(this).closest('form').trigger('submit');


    });

});
