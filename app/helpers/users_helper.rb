module UsersHelper
  #Gravatarの実装メソッド
  def gravatar_url(user, options = { size: 80 })
    #埋め込み変数
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    #Gravatarの画像URL
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
