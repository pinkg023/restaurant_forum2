class RestaurantsController < ApplicationController
  #before_action :authenticate_user!
  #before_action :authenticate_admin

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
  end

end
