class Room < ApplicationRecord
  has_many :entries
  has_many :users, through: :entries
  has_many :messages

  validates :question_title, presence: true

  def self.search(search)
    if search != ""
      Room.where('question_title LIKE(?)', "%#{search}%")
    else
      Room.all
    end
  end
end
