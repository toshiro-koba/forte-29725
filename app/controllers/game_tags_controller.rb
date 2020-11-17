class GameTagsController < ApplicationController
  before_action :check_if_user_signed_in

  def tag_search
    game_tag = params[:id].to_i
    rooms = Room.preload(:likes, :game_tags, messages: :user).all.order('created_at DESC')
    @questions = []
    rooms.each do |room|
      if room.game_tags[0]
        @questions << room if room.game_tags[0].id == game_tag
      end
    end
  end

  private

  def check_if_user_signed_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
