class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # 通知に関するアソシエーション
  has_many :notifications, dependent: :destroy

  validates :content, presence: { message: '回答を入力してね！' }
end
