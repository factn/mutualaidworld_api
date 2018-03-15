Rails.application.routes.draw do
  resources :missions
  devise_for :users
  root to: "missions#index"

  resources :nouns
  resources :verbs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
