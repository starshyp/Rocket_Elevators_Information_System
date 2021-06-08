Rails.application.routes.draw do
  resources :employees
  get 'home/index'
  get 'home_controller/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #For User Setup
  root to: "home#index"         
end
