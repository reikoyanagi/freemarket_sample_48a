Rails.application.routes.draw do
  devise_for :users, controllers: {
    :sessions           => "users/sessions",
    :registrations      => "users/registrations",
    :passwords          => "users/passwords",
  },
  skip: [:sessions,:registrations]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'

  as :user do
    get 'signin' => 'devise/sessions#new', as: :new_user_session
    post 'signin' => 'devise/sessions#create', as: :user_session
    match 'signout' => 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
    get 'signout' => 'devise/sessions#destroy'

    get 'signup' => 'users/registrations#signup'#新規会員登録
    get "/signup/registration" => "users/registrations#registration"#会員情報入力
    post "/signup/tel" => 'users/registrations#tel'#電話番号登録
    post "/signup/address" => 'users/registrations#address'#住所確認
    post "/signup/credit" => 'users/registrations#credit'#クレジットカード
    post "/signup/completed" => 'users/registrations#create'#DBに保存
    get "/signup/done" => 'users/registrations#done'#完了ページ
  end

  resources :items
  resources :users
    resources :credit_cards
end
