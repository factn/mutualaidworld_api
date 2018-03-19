Rails.application.routes.draw do
  resources :proofs
  resources :scenarios
  devise_for :users
  resources :users

  root to: "scenarios#index"

  resources :nouns
  resources :verbs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
