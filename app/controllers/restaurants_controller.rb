class RestaurantsController < ApplicationController
  #before_action :authenticate_user!
  #before_action :authenticate_admin

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

end
