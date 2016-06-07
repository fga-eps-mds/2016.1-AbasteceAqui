/* 
* File: dinamic_selection.js
* Purpouse: Provides the script for the selection forms in the application
* License: GPL v3
* Group 10 Tecprog
* FGA - Universidade de Brasília - Campus Gama
*/

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
