Rails.application.routes.draw do
  resources :user_ad_interactions
  resources :ad_types
  resources :interaction_types
  resources :donations
  resources :events
  resources :vouches
  resources :scenarios
  # jsonapi_resources :users
  resources :nouns
  resources :verbs

  jsonapi_resources :vouches
  jsonapi_resources :scenarios
  jsonapi_resources :users
  jsonapi_resources :nouns
  jsonapi_resources :verbs

  devise_for :users

  root to: "scenarios#index"

  get "/ad" => "scenarios#ad", as: "ad"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
