//= require search.js
function get_random_color() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) {
        color += letters[Math.round(Math.random() * 15)];
    }
    return color;
}

$(function() {
    $(".card-color").each(function() {
        $(this).css("background-color", get_random_color());
    });
});

$(document ).ready(function ( ) {
  $("select").selectBoxIt({
    showFirstOption: false,

    showEffect: "fadeIn",
    showEffectSpeed: 600,

    hideEffect: "fadeOut",
    hideEffectSpeed: 400
  });
});
