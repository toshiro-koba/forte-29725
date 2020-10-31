class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :game_tag

  def self.games(user)
    games = Bookmark.where(user_id: user.id)
    game_tags = []
    games.each do |tag|
      game_tags << tag.game_tag.id
    end
    return game_tags
  end
end
