class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.permit(:postal_number, :prefecture_id, :city, :house_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
