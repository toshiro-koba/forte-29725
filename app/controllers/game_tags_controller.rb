class GameTagsController < ApplicationController
  def tag_search
    game_tag = params[:id].to_i
    rooms = Room.preload(:likes, :game_tags, messages: :user).all.order('created_at DESC')
    @questions = []
    rooms.each do |room|
      unless room.game_tags[0] == nil
        @questions << room if room.game_tags[0].id == game_tag
      end
    end
  end
end
