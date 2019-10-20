class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    #ログインしていないときtrue
    unless logged_in?
     redirect_to login_url
    end
  end
  
  def counts(user)
    #micropostsの数をカウント
    @count_microposts = user.microposts.count
    #フォローユーザ数をカウント
    @count_followings = user.followings.count
    #フォロワー数をカウント
    @count_followers = user.followers.count
  end
end
