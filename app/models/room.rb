class Room < ApplicationRecord
  has_many :entries
  has_many :users, through: :entries
  has_many :messages

  validates :question_title, presence: true
end
