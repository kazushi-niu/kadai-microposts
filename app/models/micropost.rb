class Micropost < ApplicationRecord
  #Userとの関連付け
  belongs_to :user
  
  #検証(content => 空文字禁止、255文字以内)
  validates :content, presence: true, length: { maximum: 255 }
  
  #お気に入り機能用の関連付け
  has_many :favorites
  has_many :users, through: :favorites

end