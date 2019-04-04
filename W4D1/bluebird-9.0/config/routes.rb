Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/users', to: 'users#index' # the controller action awesome
  # get '/users/:id', to: 'users#show'
  # post '/users', to: 'users#create'

  resources :users, only: [:index, :show, :create] # make sure resources is plural
  # lucky to actually now this stuff and to have gotten it to start definitely do more work here though so much to do
  # let's fucking do it it all
  # awesome url helper methods --> these come from the prefixes, like 

  resources :users do
    resources :chirps, only: [:index, :new]
  end

  resources :chirps, only: [:show, :update, :create, :destroy]
end