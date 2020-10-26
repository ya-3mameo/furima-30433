class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:index, :create]
  before_action :move_to_root1, only: [:index, :create]
  before_action :move_to_root2, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:order_address, :postal_number, :prefecture_id, :city, :house_number, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(order_params[:item_id]).price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root1
    redirect_to root_path if user_signed_in? && current_user.id == @item.user_id
  end

  def move_to_root2
    redirect_to root_path if @item.order.present?
  end

  def set_order
    @item = Item.find(params[:item_id])
  end
end
