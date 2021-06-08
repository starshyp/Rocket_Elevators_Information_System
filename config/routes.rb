Rails.application.routes.draw do
  root "rocket#index"

  get "/index.html", to: redirect("/index")
  get "/index", to: "rocket#index"
  get "/quote.html", to: redirect("/quote")
  get "/quote", to: "rocket#quote"
  get "/residential.html", to: redirect("/residential")
  get "/residential", to: "rocket#residential"
  get "/commercial.html", to: redirect("/commercial")
  get "/commercial", to: "rocket#commercial"
end