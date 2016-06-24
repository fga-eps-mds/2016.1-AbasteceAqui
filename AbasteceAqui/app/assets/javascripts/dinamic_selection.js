//= require dinamic_selection.js
$(document ).ready(function ( ) {

    var select_button = document.getElementById('select_button');
    var state_tag = document.getElementById('state_tag');
    var county_tag = document.getElementById('county_tag');
    var year_tag = document.getElementById('year_tag');

    var state_county_graph_monthly_select_tag = document.getElementById('state_county_graph_monthly_select_tag');
    var county_county_graph_monthly_select_tag = document.getElementById('county_county_graph_monthly_select_tag');
    var year_county_graph_monthly_select_tag = document.getElementById('year_county_graph_monthly_select_tag');
    const string_state_county_graph_monthly = "Selecione um Estado";
    const string_county_county_graph_monthly = "Selecione um Município";
    const string_year_county_graph_monthly = "Selecione um ano";

    $("select").selectBoxIt({
      showFirstOption: false,

      showEffect: "fadeIn",
	    showEffectSpeed: 600,

	    hideEffect: "fadeOut",
	    hideEffectSpeed: 400
	  });

    if (select_button) {
      select_button.style.display = "none";
    }
    else {
    	//nothing to do
    }
    $(state_tag).change(function() {
      $(this).closest('form').trigger('submit');
    });

    $(county_tag).change(function() {
      $(this).closest('form').trigger('submit');
    });

    $(year_tag).change(function() {
      $(this).closest('form').trigger('submit');
    });

    $(state_county_graph_monthly_select_tag).change(function() {
      if($(state_county_graph_monthly_select_tag).val() !== string_state_county_graph_monthly) {
        $(location).attr('href', window.location.origin + '/statistics/county_monthly?utf8=%E2%9C%93&state_searched=' + $(this).val());}
    });

    $(county_county_graph_monthly_select_tag).change(function() {
      if($(state_county_graph_monthly_select_tag).val() != string_state_county_graph_monthly && $(county_county_graph_monthly_select_tag).val() != string_county_county_graph_monthly) {
        if(!year_county_graph_monthly_select_tag || $(year_county_graph_monthly_select_tag).val() != string_year_county_graph_monthly) {
          $(this).closest('form').trigger('submit');
        } else {
          /* do nothing */
        }
      } else {
        /* do nothing */
      }
    });

    $(year_county_graph_monthly_select_tag).change(function() {
      if($(state_county_graph_monthly_select_tag).val() != string_state_county_graph_monthly && $(county_county_graph_monthly_select_tag).val() != string_county_county_graph_monthly) {
        if(!year_county_graph_monthly_select_tag || $(year_county_graph_monthly_select_tag).val() != string_year_county_graph_monthly) {
          $(this).closest('form').trigger('submit');
        } else {
          /* do nothing */
        }
      } else {
        /* do nothing */
      }
    });
});
