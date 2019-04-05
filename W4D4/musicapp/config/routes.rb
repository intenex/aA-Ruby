Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :bands

  resources :bands do
    resources :albums, only: :new # cool can do either with or without brackets
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy]
end