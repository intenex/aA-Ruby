Rails.application.routes.draw do
  # Your routes here!
  
  namespace :api, defaults: { format: json } do # ah amazing you can do it here nice
    resources 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
