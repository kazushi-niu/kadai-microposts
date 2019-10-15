class UsersController < ApplicationController
  #ApplicationControllerのメソッドを使用（:index,:showアクションで事前使用）
  before_action :require_user_logged_in, only: [:index, :show]
  
  #ユーザ一覧表示
  def index
    #Userクラスからユーザ一覧を降順に25件取得
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  #ユーザ詳細ページ
  def show
    #Userクラスから特定idのユーザを取得
    @user = User.find(params[:id])
  end

  #ユーザ新規登録用フォーム
  def new
    #新規インスタンス（カラム）作成準備
    @user = User.new
  end

  def create
    #新規インスタンス作成
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  #private
  private
  #ユーザパラメータの設定
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
