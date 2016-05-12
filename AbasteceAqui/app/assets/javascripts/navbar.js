function main() {

  (function () {
     'use strict';


      /*====================================
      Show Menu on Book
      ======================================*/

      $(document).ready(function() {
      var welcome = document.getElementById('tf-home');
      if (welcome  == null)
      {
        $('.navbar-default').addClass('on');
      }
      else
      {
        if($(window).width()<768 || $(window).height()<580) {

        }
        else {
          $('.navbar-default').removeClass('on');
        

          $(window).bind('scroll', function() {
            var navHeight = $(window).height() - 580;
            if ($(window).scrollTop() > navHeight) {
              $('.navbar-default').addClass('on');
            }
            else {
              $('.navbar-default').removeClass('on');
            }
          });
        }

      }
      });

      $('body').scrollspy({ 
          target: '.navbar-default',
          offset: 80
      })

  }());

  }
  main();