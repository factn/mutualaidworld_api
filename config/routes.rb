Rails.application.routes.draw do
  jsonapi_resources :proofs
  jsonapi_resources :scenarios
  #jsonapi_resources :users
  jsonapi_resources :nouns
  jsonapi_resources :verbs

  devise_for :users

  root to: "scenarios#index"

  get "/ad" => "scenarios#ad", as: "ad"


  resources :proofs
  resources :scenarios
  #jsonapi_resources :users
  resources :nouns
  resources :verbs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
