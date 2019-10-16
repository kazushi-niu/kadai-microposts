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
end
