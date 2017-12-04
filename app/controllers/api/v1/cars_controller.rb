class Api::V1::CarsController < ApplicationController

  before_filter :set_default_response_format

  def index
    @cars = Car.all
    render json: @cars.as_json(
      only: [:id, :car_model_name, :brand_name, :year, :quantity],
      methods: [:car_model_name, :brand_name]
    )
  end

  def show
    @car = Car.find(params[:id])
    render json: @car.as_json(methods: [:car_model_name, :brand_name])
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      render json: {:success => true, id: @car.id}
    else
      render json: {:errors => @car.errors.as_json }, status: :unprocessable_entity
    end
  end


  private

  def set_default_response_format
    request.format = :json
  end

  def car_params
    params.require(:car).permit(:model_id, :year, :price, :color, :fuel, :currency, :description, :quantity, image: [
      :original_filename, :base64_data
    ])
  end

end
