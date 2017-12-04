$(function() {

  /* esto se ejecutara en la creacion de una orden */
  if ($('.orders-new').length) {

    $('form').on('submit', function (ev) {

      if ( ! $('.order-name input').val()) {
        // marcamos con error
        $('.order-name').addClass('error');
        // y cancelamos el envio
        ev.preventDefault();
      } else {
        // quitamos el error
        $('.order-name').removeClass('error');
      }


      if ( ! $('.order-email input').val()) {
        // marcamos con error
        $('.order-email').addClass('error');
        // y cancelamos el envio
        ev.preventDefault();
      } else {
        // quitamos el error
        $('.order-email').removeClass('error');
      }


    });

  }

});
