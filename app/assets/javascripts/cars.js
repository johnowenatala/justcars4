$(function(){

  /* esto se ejecutara en el index unicamente */
  if ( $('.cars').length ) {

    /* manejo de dialogo */

    var $dialog = $('#car-dialog');

    $('.cars .car').on('click', function(e){
      // allow more info link
      if ($(e.target).is('a')) {
        // nothing to do
        return;
      }
      e.preventDefault();
      var $car = $(this);

      var image_url = $car.data('imageUrl');
      var label = $car.data('label');
      var show_url = $car.data('showUrl');



      $dialog.find('.full-image').css('backgroundImage','url('+image_url+')');


      var $showLink = $('<a />', {
        href: show_url,
        text: label
      });

      var $label = $dialog.find('.label');

      // vaciamos el $label
      $label.text('');

      // y ponemos el link
      $label.append($showLink);


      // y mostramos
      $dialog.removeClass('hide');

    });

    // en clic, ocultamos
    $dialog.on('click', function(e){
      // salvo que el click haya sido dado sobre un link en el dialogo
      if (! $(e.target).is('a') ) {
        e.preventDefault();
        $dialog.addClass('hide');
      }
    });

  }






  /* esto se ejecutara en el new unicamente */
  if ( $('.cars-new').length ) {


    // Manejo del doble select marca - modelo

    var $brand_select = $('.car-brand');
    var $model_select = $('.car-model');

    $brand_select.on('change', function () {
      var $current_brand_option = $brand_select.find('option:selected');
      var options = $current_brand_option.data('modelsOptions');

      if (!options || options == "") {
        options = $model_select.data('noModels');
      }

      $model_select.html(options);

    });

    // Validaciones del formulario

    var $form =  $('form.new-car');

    $form.on('submit', function(ev){

      // validations
      // 1- required fields
      $form.find('section.required input, section.required select').each(function(){
        var $required_element = $(this);
        var $section = $required_element.closest('section');
        if ($required_element.val()) {
          // great. Has a value.
          // Lets clean if there is something marked as error
          $section.removeClass('error');
          // also remove required message
          $section.find('.message.required').remove();
        } else {
          // No value -> error!
          $section.addClass('error');
          // and add error message (only if there is no one yet
          if ($section.find('.required.message').length == 0) {
            $section.append("<span class='required message'>Es requerido</span>");
          }
        }
      });

      // 2 - specific fields (year)
      var $year_field = $form.find('.car-year');
      var year_value = $year_field.val();
      var $year_section = $year_field.closest('section');
      if ( ! $.isNumeric(year_value)) {
        $year_section.addClass('error');
        if ($year_section.find('.year.message').length == 0) {
          $year_section.append("<span class='year message'>Debe ser numérico</span>");
        }
      } else {
        var int_year = parseInt(year_value, 10);
        if (int_year < 2008 || int_year > 2018) {
          $year_section.addClass('error');
          if ($year_section.find('.year.message').length == 0) {
            $year_section.append("<span class='year message'>Debe estar entre 2008 y 2018</span>");
          }
        } else  {
          $year_section.removeClass('error');
          // also remove required message
          $year_section.find('.message.year').remove();
        }
      }


      // is there some field marked as error?
      if ($form.find('section.error').length) {
        ev.preventDefault();
      }

    });

    var send_with_file = function(fileReader, file) {

      var car_json = {
        model_id: $form.find('.car-model').val(),
        year: $form.find('.car-year').val(),
        currency: $form.find('.car-currency').val(),
        price: $form.find('.car-price').val(),
        quantity: $form.find('.car-quantity').val(),
        color: $form.find('.car-color').val(),
        fuel: $form.find('.car-fuel').val(),
        description: $form.find('.car-description').val()
      };

      if (fileReader && file) {
        car_json.image = {
          original_filename: file.name,
          base64_data: fileReader.result
        };
      }

      $.ajax({
        url: $btn_api.data('createUrl'),
        method: 'put',
        contentType:'application/json',
        data: JSON.stringify({ car: car_json }),
        dataType:'json',
        success: function(response){
          alert("Exito. Auto " + response.id + " guardado");
          window.location = "/cars/" + response.id;
        },
        error: function(jq) {
          console.log(jq.responseJSON);
        }

      });
    };

    var $btn_api = $form.find('.btn-api');
    $btn_api.on('click', function(){

      var file = $form.find('.car-image')[0].files[0];
      if (file) {

        var fileReader = new FileReader();
        fileReader.onload = function(rev){
          send_with_file(fileReader, file);
        };
        fileReader.readAsDataURL( file );
      } else {
        send_with_file(null, null);
      }

    });

  }
});

