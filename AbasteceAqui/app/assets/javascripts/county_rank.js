//= require county_rank.js
$(document ).ready(function ( ) {
  var gasoline = document.getElementsByClassName("rank-gasoline");
  var ethanol = document.getElementsByClassName("rank-ethanol");
  var diesel = document.getElementsByClassName("rank-diesel");

  var gasoline_btn = document.getElementById("gasoline-rank-btn");
  var ethanol_btn = document.getElementById("ethanol-rank-btn");
  var diesel_btn = document.getElementById("diesel-rank-btn");


  $(ethanol_btn).click(function () {

    $(diesel_btn).removeClass("active");
    $(gasoline_btn).removeClass("active");
    $(ethanol_btn).addClass('active');

    $(diesel).delay(100).fadeOut("slow");
    $(gasoline).delay(100).fadeOut("slow");
    $(ethanol).delay(600).fadeIn("slow");

  });

  $(gasoline_btn).on('click', function () {
    $(diesel_btn).removeClass("active");
    $(ethanol_btn).removeClass("active");
    $(gasoline_btn).addClass('active');

    $(diesel).delay(100).fadeOut("slow");
    $(ethanol).delay(100).fadeOut("slow");
    $(gasoline).delay(600).fadeIn("slow");
  });

  $(diesel_btn).click(function () {

    $(gasoline_btn).removeClass("active");
    $(ethanol_btn).removeClass('active');
    $(diesel_btn).addClass("active");

    $(gasoline).delay(100).fadeOut("slow");
    $(ethanol).delay(100).fadeOut("slow");
    $(diesel).delay(600).fadeIn("slow");

  });
});
