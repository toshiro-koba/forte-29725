class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order('created_at DESC')
    @another_questions = []
    if user_signed_in?
      @entries = Entry.all.order('created_at DESC')
      @questions = []
      @question_ids = []
      @rooms.each do |room|
        @entries.each do |entry|
          next unless entry.room_id == room.id
          if entry.user_id == current_user.id
            @questions << room
            @question_ids << room.id
          end
        end
      end
      @another_question_ids = @rooms.ids - @question_ids
      @rooms.each do |room|
        @another_question_ids.each do |another_question_id|
          @another_questions << room if room.id == another_question_id
        end
      end
    else
      @another_questions = @rooms
    end
  end

  def new
    redirect_to root_path unless user_signed_in?
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_messages_path(@room)
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:question_title, user_ids: [])
  end
end
