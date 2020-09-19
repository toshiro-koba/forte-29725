class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :game_tag
end
