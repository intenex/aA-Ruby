Rails.application.routes.draw do
  # Your routes here!
  
  namespace :api, defaults: { format: :json } do # ah amazing you can do it here nice right need the symbol json great
    resources :gifts, only: [ :show ]
    resources :guests, only: [ :index, :show ] do
      resources :gifts, only: [ :index ] # nice you got this right you can put the do after it brilliant
    end
    resources :parties, only: [ :index, :show ]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
