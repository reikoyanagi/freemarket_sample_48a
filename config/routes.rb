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
    get "/users/:id/profile" => 'users#profile', as: :user_profile
    patch "/users/:id/profile" => 'users#profile_update' , as: :update_user_profile
  end

  resources :items do
    get "/transactions/new" => 'transactions#new', as: :new_transaction
    post "/transactions/create" => 'transactions#create', as: :transaction
  end
  get 'listings/list' => 'listings#list'
  get 'listings/in_progress' => 'listings#in_progress'
  get 'listings/completed' => 'listings#completed'

  resources :users do
  get "/credit_cards/new" => 'credit_cards#new', as: :new_credit_card #新規クレジット画面
  post "/credit_cards/create" => 'credit_cards#create', as: :credit_card#クレジット情報登録
  get "/credit_cards/show" => 'credit_cards#show', as: :show_credit_card#クレジット情報画面
  delete "/credit_cars/delete" => 'credit_cards#delete', as: :delete_credit_card #クレジット削除画面
  get "/credit_cards/index" => 'credit_cards#index', as: :index_credit_card #クレジットトップページ
  end
end
