class User < ApplicationRecord
  #大文字をすべて小文字に変換
  before_save { self.email.downcase! }
  #nameは空文字禁止かつ50文字以内
  validates :name, presence: true, length: { maximum: 50 }
  #emailは空文字禁止、255文字以内、正規表現かつ重複禁止
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  #パスワード機能の提供
  has_secure_password
  
  #micropostとの関連付け
  has_many :microposts
  #フォロー関係の関連付け
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  #フォロー関係の保存
  def follow(other_user)
    #userが自分自身でないか
    unless self == other_user
      #followしていればreturn、していなければcreate
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  #フォロー関係の解除
  def unfollow(other_user)
    #フォロー関係を検索
    relationship = self.relationships.find_by(follow_id: other_user.id)
    #relationshipが存在するときdestroy
    relationship.destroy if relationship
  end
  
  #フォローしているユーザーの取得
  def following?(other_user)
    #フォローしている中に存在しているか
    self.followings.include?(other_user)
  end
  
  #タイムライン用のmicropostを取得
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  #お気に入り機能用の関連付け
  has_many :favorites
  has_many :favposts, through: :favorites, source: :micropost
  
  #お気に入り登録のメソッド
  def favorite(micropost)
    favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  #お気に入り削除のメソッド
  def unfavorite(micropost)
    favorite = favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end
  
  #お気に入り登録判別
  def favpost?(micropost)
    self.favposts.include?(micropost)
  end
  
end