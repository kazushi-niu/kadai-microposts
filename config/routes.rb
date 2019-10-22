Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get "/" => toppages#index
  root to: 'toppages#index'
  
  #ログイン機能
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #/ユーザの新規登録
  get 'signup', to: 'users#new'
  
  #ユーザ情報
  resources :users, only: [:index, :show, :new, :create] do
    member do
      #フォローしているユーザ一覧
      get :followings
      #フォロワー一覧
      get :followers
      #お気に入り投稿一覧
      get :likes
    end
    collection do
      get :search
    end
  end

  
  #コメント機能のルーティング(create,destroyのみ)
  resources :microposts, only: [:create, :destroy]
  
  #フォロー機能のルーティング
  resources :relationships, only: [:create, :destroy]
  
  #お気に入り機能のルーティング
  resources :favorites, only: [:create, :destroy]
end
