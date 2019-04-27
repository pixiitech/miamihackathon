Rails.application.routes.draw do
  get 'events/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'home#index'
  post '/', to: 'images#index'
  get 'images', to: 'images#index'
  root to: 'home#index'
  get 'travel_tips', to: 'home#travel_tips'
end
