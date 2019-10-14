Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get "/" => toppages#index
  root to: 'toppages#index'
  
  #/ユーザーの新規登録
  get 'signup', to: 'users#new'
  
  #7つの基本ルーティングの省略形(実装は、index,show,new,createのみ)
  resources :users, only: [:index, :show, :new, :create]
end
