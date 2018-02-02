Rails.application.routes.draw do
  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update]  do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    member do
      get :both_followed
    end
  end
  root "restaurants#index"        #首頁指向 RestaurantsController 的 index action

  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
      get :favorites
    end

    # 瀏覽個別餐廳的 Dashboard
    member do
      get :dashboard
      post :favorite
      post :unfavorite      
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
