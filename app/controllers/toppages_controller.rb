class ToppagesController < ApplicationController
  def index
    if logged_in?
      # form_with 用
      @micropost = current_user.microposts.build
      #コメント一覧表示
      @microposts = current_user.feed_microposts.order(id: :desc).page(params[:page])
    end
  end
end
