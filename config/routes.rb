Rails.application.routes.draw do
  root "rocket#index"

  get "/rocket", to: "rocket#index"
end