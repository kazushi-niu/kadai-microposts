class SessionsController < ApplicationController
  def new
  end

  #ログイン処理
  def create
    #変数emailはパラメータ:session,:emaiを持つ(すべて小文字に変換された)
    email = params[:session][:email].downcase
    #変数passwordは変数:session,:passwordを持つ
    password = params[:session][:password]
    
    if login(email, password)
      flash[:success] = 'ログインに成功しました'
      #@userのルーティングに強制転送
      redirect_to @user
    else
      flash.now[:danger] = 'ログインに失敗しました'
      #session/new.html.erbを再表示
      render 'new'
    end
  end

  #ログアウト処理
  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    #トップページにリダイレクト
    redirect_to root_url
  end
  
  #以下のメソッドはこのファイルでのみ使用
  private
  #login(email, password)の定義
  def login(email, password)
    #インスタンス変数@userに入力emailが存在するUserクラス(レコード)を代入
    @user = User.find_by(email: email)
    #条件:email,passwordの組み合わせが一致するか
    if @user && @user.authenticate(password)
      #ログイン成功
      session[:user_id] = @user.id
      return true
    else
      #ログイン失敗
      return false
    end
  end
end
