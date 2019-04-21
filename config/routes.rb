Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items
  get 'listings/list' => 'listings#list'
  get 'listings/in_progress' => 'listings#in_progress'
  get 'listings/completed' => 'listings#completed'
  resources :users
    resources :credit_cards
    resources :transactions
end
