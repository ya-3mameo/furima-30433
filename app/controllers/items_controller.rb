class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
    @item = Item.new
  end


end