Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"        #首頁指向 RestaurantsController 的 index action

  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
    end

    # 瀏覽個別餐廳的 Dashboard
    member do
      get :dashboard
    end
    
  end
  root "restaurants#index"

  resources :categories, only: :show
  root "categories#index"

  namespace :admin do
    resources :restaurants
    resources :categories   # 加入Categories資料表相關用route
    root "restaurants#index"
  end


end
