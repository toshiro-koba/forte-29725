class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_many :entries
  has_many :rooms, through: :entries
  has_many :messages
  has_many :gifts
  has_many :receivers, through: :gifts, source: :giver
  has_many :reverse_of_gifts, class_name: 'Gift', foreign_key: 'giver_id'
  has_many :giftings, through: :reverse_of_gifts, source: :user
  has_many :bookmarks
  has_many :game_tags, through: :bookmarks
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_one  :profile

  def follow(other_user) # フォローする！！
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user # フォローしようとしているユーザーが自分自身か！
  end

  def following?(other_user) # そのユーザーは既にフォローしてる？かを確認する！
    followings.include?(other_user)
  end
end
