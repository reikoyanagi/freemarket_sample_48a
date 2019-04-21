Rails.application.routes.draw do
  devise_for :users, controllers: {
    :registrations      => "users/registrations"
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
  end

  resources :items
  resources :users
  resources :credit_cards
  resources :transactions
end
