class LikesController < ApplicationController
  before_action :set_like

  def create
    user = current_user
    room = Room.find(params[:room_id])
    like = Like.create(user_id: user.id, room_id: room.id)
  end

  def destroy
    user = current_user
    room = Room.find(params[:room_id])
    like = Like.find_by(user_id: user.id, room_id: room.id)
    like.delete
  end

  private

  def set_like
    @like_room = Room.find(params[:room_id])
  end
end
