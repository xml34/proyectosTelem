Rails.application.routes.draw do
  devise_for :users
  resources :geolocalisations
  get 'principal/login'
  get 'principal/menu'
  root to: 'principal#login'
  resources :locations



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #HTTP
  # => Vervos
  # =>  GET,POST,PATCH,PUT,DELETE.
end
