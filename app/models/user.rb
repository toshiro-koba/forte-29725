class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  # 質問に関するアソシエーション
  has_many :entries
  has_many :rooms, through: :entries
  has_many :messages
  # ギフトに関するアソシエーション
  has_many :gifts
  has_many :receivers, through: :gifts, source: :giver
  has_many :reverse_of_gifts, class_name: 'Gift', foreign_key: 'giver_id'
  has_many :giftings, through: :reverse_of_gifts, source: :user
  # ゲームお気に入り登録に関するアソシエーション
  has_many :bookmarks
  has_many :game_tags, through: :bookmarks
  # フォローに関するアソシエーション
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  # プロフィールに関するアソシエーション
  has_one  :profile
  # いいねに関するアソシエーション
  has_many :likes, dependent: :destroy
  has_many :like_rooms, through: :likes, source: :room
  # 通知に関するアソシエーション
  has_many :active_notifications,  class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def follow(other_user) # フォローする！！
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user # フォローしようとしているユーザーが自分自身か！
  end

  def following?(other_user) # そのユーザーは既にフォローしてる？かを確認する！
    followings.include?(other_user)
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def create_notification_gift!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'gift'])
    notification = current_user.active_notifications.new(
      visited_id: id,
      action: 'gift'
    )
    notification.save if notification.valid?
  end
end
