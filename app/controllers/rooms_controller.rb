class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order('created_at DESC')
    @users = User.all
    @another_questions = []
    if user_signed_in?
      @questions = []
      @questions_related_to_current_user = Entry.where(user_id: current_user.id).order('created_at DESC')
      @questions_related_to_current_user.each do |entry|
        @questions << entry.room
      end
      @another_questions_pro = @rooms - @questions
      @another_questions_pro.each do |room|
        @another_questions << room if room.messages.size == 2
      end
    else
      @rooms.each do |room|
        @another_questions << room if room.messages.size == 2
      end
    end
    @room = RoomMessage.new
    @message = Message.new
  end

  def new
    redirect_to root_path unless user_signed_in?
    if Gift.where(giver_id: current_user.id).size == 0 # 一度でもギフトしたことがあれば、質問できる！！このアプリの肝！！！
      redirect_to lets_gift_rooms_path
    end
    @room = RoomMessage.new
  end

  def create
    @room = RoomMessage.new(room_params)
    if @room.valid?
      @room.save
      render json: { room: @room, tag: GameTag.find(@room.game_tag_ids[0]), user: User.find(@room.user_id), content: @room.content }
    else
      render json: { title_error: @room.errors.messages[:question_title][0], user_error: @room.errors.messages[:user_ids][0], tag_error: @room.errors.messages[:game_tag_ids][0], content_error: @room.errors.messages[:content][0] }
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  def search
    @rooms = Room.search(params[:keyword])
    @another_questions = []
    if user_signed_in?
      @questions = []
      @rooms.each do |room|
        @questions << room if room.user_ids.include?(current_user.id)
      end
      @another_questions_pro = @rooms - @questions
      @another_questions_pro.each do |room|
        @another_questions << room if room.messages.size == 2
      end
    else
      @rooms.each do |room|
        @another_questions << room if room.messages.size == 2
      end
    end
  end

  def lets_gift; end

  private

  def room_params
    params.require(:room_message).permit(:question_title, :content).merge(user_ids: params[:room][:user_ids], game_tag_ids: params[:room][:game_tag_ids], user_id: current_user.id)
  end
end
