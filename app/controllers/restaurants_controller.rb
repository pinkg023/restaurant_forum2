class RestaurantsController < ApplicationController
  #before_action :authenticate_user!
  #before_action :authenticate_admin

  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end
  
  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end

  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end

  # POST /restaurants/:id/favorite
  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    @restaurant.favorites_count = @restaurant.favorites_count + 1
    @restaurant.save
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  # POST /restaurants/:id/unfavorite
  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all
    @restaurant.favorites_count = @restaurant.favorites_count - 1
    @restaurant.save
    redirect_back(fallback_location: root_path)
  end

  #GET /restaurants/favorites
  def favorites
    @greatest_restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end

end
