Rails.application.routes.draw do
  devise_for :users, controllers: {
    :registrations      => "users/registrations",
    :omniauth_callbacks => "users/omniauth_callbacks",
    :sessions           => "users/sessions"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'

  as :user do

    get "/sign_up/registration" => "users/registrations#registration"#会員情報入力
    post "/sign_up/tel" => 'users/registrations#tel'#電話番号登録
    post "/sign_up/address" => 'users/registrations#address'#住所確認
    post "/sign_up/credit" => 'users/registrations#credit'#クレジットカード
    post "/sign_up/create" => 'users/registrations#create'#DBに保存
    get "/sign_up/done" => 'users/registrations#done'#完了ページ
    get "/users/:id/profile" => 'users#profile', as: :user_profile
    patch "/users/:id/profile" => 'users#profile_update' , as: :update_user_profile
  end

  resources :items do
    resources :transactions
  end
  get 'listings/list' => 'listings#list'
  get 'listings/in_progress' => 'listings#in_progress'
  get 'listings/completed' => 'listings#completed'

  resources :users do
    resources :credit_cards
  end
end
