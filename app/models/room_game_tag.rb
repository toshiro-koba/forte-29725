class RoomGameTag < ApplicationRecord
  belongs_to :room
  belongs_to :game_tag
end
