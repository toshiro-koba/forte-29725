class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order('created_at DESC')
    if user_signed_in?
      @questions = []
      @questions_related_to_current_user = Entry.where(user_id: current_user.id).order('created_at DESC')
      @questions_related_to_current_user.each do |entry|
        @questions << entry.room
      end
      @another_questions = @rooms - @questions
    else
      @another_questions = @rooms 
    end
  end

  def new
    redirect_to root_path unless user_signed_in?
    redirect_to lets_gift_rooms_path if Gift.where(giver_id: current_user.id).size == 0 #一度でもギフトしたことがあれば、質問できる！！このアプリの肝！！！
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

  def search
    @rooms = Room.search(params[:keyword])
    if user_signed_in?
      @questions = []  
      @rooms.each do |room|
        if  room.user_ids.include?(current_user.id)
          @questions << room
        end
      end
      @another_questions = @rooms - @questions
    else
      @another_questions = @rooms
    end
  end

  def lets_gift
  end

  private

  def room_params
    params.require(:room).permit(:question_title, user_ids: [], game_tag_ids: [])
  end
end
