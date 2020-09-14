class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname, presence: true
         validates :password, format: { with: /[a-z\d]{6,}/i, message: 'Half-width alphanumeric characters' }
         
  has_many :entries
  has_many :rooms, through: :entries
end
