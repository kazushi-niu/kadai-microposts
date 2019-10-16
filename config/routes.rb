Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get "/" => toppages#index
  root to: 'toppages#index'
  
  #ログイン機能
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  #/ユーザーの新規登録
  get 'signup', to: 'users#new'
  
  #ユーザー登録用のルーティング(index,show,new,createのみ)
  resources :users, only: [:index, :show, :new, :create]
  
  #コメント機能のルーティング(create,destroyのみ)
  resources :microposts, only: [:create, :destroy]
end
