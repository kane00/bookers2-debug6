Rails.application.routes.draw do
  # device_forの位置を上にもってくる
  # GET "/users/sign_in" にアクセスしようとした時に、GET "/users/:id" が一番
  # 上になかったために引っかからず、正しいルーティングを選択できた
  devise_for :users
  resources :users,only: [:show, :index, :edit, :update]
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  end
    root 'home#top'
    get 'home/about'
end