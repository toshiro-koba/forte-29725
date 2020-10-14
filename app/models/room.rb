class Room < ApplicationRecord
  has_many :entries
  has_many :users, through: :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :room_game_tags
  has_many :game_tags, through: :room_game_tags, dependent: :destroy
  has_many :likes
  has_many :likers, through: :likes, source: :user, dependent: :destroy
  #通知に関するアソシエーション
  has_many :notifications, dependent: :destroy

  validates :question_title, presence: true

  def self.search(search)
    if search != ''
      Room.where('question_title LIKE(?)', "%#{search}%")
    else
      Room.all
    end
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
