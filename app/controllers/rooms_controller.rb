class RoomsController < ApplicationController
  def new
    redirect_to root_path unless user_signed_in?
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:question_title, user_ids: [])
  end
end
