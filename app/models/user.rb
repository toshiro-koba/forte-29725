class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_many :entries
  has_many :rooms, through: :entries
  has_many :messages
  has_many :gifts
  has_many :giftings, through: :gifts, source: :giver
  has_many :reverse_of_gifts, class_name: 'Gift', foreign_key: 'giver_id'
  has_many :receivings, through: :reverse_of_gifts, source: :user
  has_many :bookmarks
  has_many :game_tags, through: :bookmarks
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user) #フォローする！！
    unless self == other_user #フォローしようとしているユーザーが自分自身か！
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def following?(other_user) #そのユーザーは既にフォローしてる？かを確認する！
    self.followings.include?(other_user)
  end
end
