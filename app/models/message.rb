class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :content, presence: { message: '回答を入力してね！' }
end
