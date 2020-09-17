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
end
