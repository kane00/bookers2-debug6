Rails.application.routes.draw do
  # device_forの位置を上にもってくる
  # GET "/users/sign_in" にアクセスしようとした時に、GET "/users/:id" が一番
  # 上になかったために引っかからず、正しいルーティングを選択できた
  devise_for :users
  
  resources :users,only: [:show, :index, :edit, :update] do
  # フォロー機能のルーティング doつけた
    member do
      get :following, :followers
    end
  end
  # フォロー機能のルーティング
   resources :relationships, only: [:create, :destroy]

  resources :books do
    # コメント機能の親子関係を結びつける
    resource :post_comments, only: [:create, :destroy]
    # いいね機能の親子関係を結びつける
  	resource :favorites, only: [:create, :destroy]
  end

    root 'home#top'
    get 'home/about'
end