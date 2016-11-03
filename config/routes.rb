Rails.application.routes.draw do

  #resources :songs
  #resources :albums
  #resources :artists

  root :to => 'songs#search'
  get "/list", to: "songs#list", as: "list"

end
