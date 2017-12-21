Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"        #首頁指向 RestaurantsController 的 index action

  namespace :admin do
    resources :restaurants
    resources :categories   # 加入Categories資料表相關用route
    root "restaurants#index"
  end


end
