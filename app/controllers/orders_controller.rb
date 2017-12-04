class OrdersController < ApplicationController
  def new
    @order = Order.new(car_id: params[:car])
  end

  def create

    @order = Order.new(order_params)
    @order.status = 'created'

    if @order.save
      redirect_to order_url(@order)
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private


  def order_params
    params.require(:order).permit(:car_id, :name, :phone, :email)
  end
end
