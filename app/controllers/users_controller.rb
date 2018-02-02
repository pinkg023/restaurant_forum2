class UsersController < ApplicationController
  before_action :set_user, :check_userself, :only => [:show, :edit, :update, :both_followed, ]
  before_action :check_userself, :only => [:edit, :update]

  def index
    @users = User.all
    @restaurants = Restaurant.all
    @categories = Category.all
  end

  def update

      if @user.update(user_params)
        flash[:notice] = "資料已更新！"
        redirect_to restaurants_path      
      else
        render :edit
        flash[:alert] = "資料更新失敗！"
      end

  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :intro, :role, :image, :name)
    end

    def check_userself
      if current_user!=@user
      redirect_to restaurants_path
      flash[:alert] = "您無編輯權限！"
      end
    end
    
end