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

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and room_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        room_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分自身の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
