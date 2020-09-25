class Room < ApplicationRecord
  has_many :entries
  has_many :users, through: :entries
  has_many :messages
  has_many :room_game_tags
  has_many :game_tags, through: :room_game_tags

  def self.search(search)
    if search != ''
      Room.where('question_title LIKE(?)', "%#{search}%")
    else
      Room.all
    end
  end
end
