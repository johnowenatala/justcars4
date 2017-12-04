class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    find_more_info
    @related = @car.related(3)
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to car_url(@car)
    else
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:model_id, :year, :price, :image, :color, :fuel, :currency, :description, :quantity)
  end

  def find_more_info
    @more_info = nil
    return nil # ESTA LINEA DESHABILITA EL USAR EL SERVICIO
    if @car.make_id.present?

      ## Cambiar URL por la dirección real del servicio
      response = RestClient.get 'URL', {
        accept: :json,
        params: {
          cmd: 'getTrims',
          # Completar estos campos:
          # el "make_id" del auto
          make: '',
          # el año del auto
          year: '',
          # el nombre de la marca del auto
          keyword: ''
        }
      }
      json_response = JSON.parse(response.body)
      trim = json_response['Trims'].first
      if trim.present?
        @more_info = {
          # Agregar 3 valores más a leer
          'Modelo exacto' => trim['model_trim']
        }
      end
    end
  end
end
