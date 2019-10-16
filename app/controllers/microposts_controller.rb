class MicropostsController < ApplicationController
  #アクション実行前にログイン状態を確認(require_user_logged_in)
  before_action :require_user_logged_in
  #削除(:destroy)前にcorrent_user実行
  before_action :corrent_user, only: [:destroy]
  
  def create
    #コメント投稿機能
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      #投稿成功
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      #投稿失敗
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    #コメント削除
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def micropost_params
    #Micropostモデルのcontentキーのみを指定
    params.require(:micropost).permit(:content)
  end
  
  def corrent_user
    #micropostがログインユーザのものか確認
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
end
