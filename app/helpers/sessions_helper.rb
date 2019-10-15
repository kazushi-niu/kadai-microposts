module SessionsHelper
  #ログインユーザを取得する
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #ユーザがログインしているか調べる
  def logged_in?
    !!current_user
  end
end
