class GameTag < ApplicationRecord
  has_many :room_game_tags
  has_many :rooms, through: :room_game_tags

  validates :game_title, presence: true
end
