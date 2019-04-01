Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users', to: 'users#index' # the controller action awesome
  get '/users/:id', to: 'users#show'

  # resources :users only: [:index]
end