class Micropost < ApplicationRecord
  #Userとの関連付け
  belongs_to :user
  
  #検証(content => 空文字禁止、255文字以内)
  validates :content, presence: true, length: { maximum: 255 }
end
