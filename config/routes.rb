Rails.application.routes.draw do
  # device_forの位置を上にもってくる
  # GET "/users/sign_in" にアクセスしようとした時に、GET "/users/:id" が一番
  # 上になかったために引っかからず、正しいルーティングを選択できた
  devise_for :users
  
  resources :users,only: [:show, :index, :edit, :update] do
  # フォロー機能のルーティング resources user:の下に書くことでルートがつづく
  resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :books do
    # コメント機能の親子関係を結びつける
    resource :book_comments, only: [:create, :destroy]
    # いいね機能の親子関係を結びつける
  	resource :favorites, only: [:create, :destroy]
  end

    root 'home#top'
    get 'home/about'
    # searchのルーティング,viewのsearchesのsearch.html.erbを表示
    get '/search', to: 'searches#search'
end