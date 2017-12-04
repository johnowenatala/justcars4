module CarsHelper

  def car_label(car)
    "#{car.brand_name} #{car.car_model_name} - #{car.year}"
  end

  def car_full_image_label(car)
    "#{car_label(car)} - #{format_car_currency(car.price, car.currency)}"
  end

  def format_car_currency(price, currency = nil)

    puts "formatting for currency #{currency.inspect}"
    currency_options = case currency
    when :clf, 'clf'
      { delimiter: '.', separator: ',', precision: 2, unit: 'UF', format: '%u %n' }
    when :usd, 'usd'
      { delimiter: '.', separator: ',', precision: 2, unit: '$USD', format: '%u %n' }
    else
      { delimiter: '.', precision: 0, format: '%u %n' }
    end

    number_to_currency(price, currency_options)
  end

  def currencies_list
    Car.currencies.map do |value, _|
      name = case value
        when 'clf' then 'UF'
        when 'usd' then 'USD'
        else '$'
      end

      [
        name,
        value
      ]
    end
  end
end
