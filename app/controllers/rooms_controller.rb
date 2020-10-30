class RoomsController < ApplicationController
  def index
    @rooms = Room.preload(:likes, :game_tags, messages: :user).all.order('created_at DESC')
    @users = User.all
    @other_questions = []
    if user_signed_in?
      @questions = []
      @temporary_questions = Entry.where(user_id: current_user.id).order('created_at DESC')
      @temporary_questions.preload(room: [:likes, :game_tags, messages: :user]).each do |entry|
        @questions << entry.room
      end
      @temporary_other_questions = @rooms - @questions
      @temporary_other_questions.each do |room|
        @other_questions << room if room.messages.size == 2
      end
      @other_questions = Kaminari.paginate_array(@other_questions).page(params[:page]).per(10)
    end
    @room = RoomMessage.new
    @message = Message.new
  end

  def new
    redirect_to root_path unless user_signed_in?
    @room = RoomMessage.new
  end

  def create
    @room = RoomMessage.new(room_params)
    if @room.valid?
      @room.save
      notification_room = Room.order(updated_at: :desc).limit(1)
      # 各引数の説明。質問者、質問本文、回答者
      notification_room[0].create_notification_comment!(current_user, notification_room[0].messages[0].id, notification_room[0].entries[0].user_id)
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
    @other_questions = []
    if user_signed_in?
      @questions = []
      @rooms.each do |room|
        @questions << room if room.user_ids.include?(current_user.id)
      end
      @temporary_other_questions = @rooms - @questions
      @temporary_other_questions.each do |room|
        @other_questions << room if room.messages.size == 2
      end
    else
      @rooms.each do |room|
        @other_questions << room if room.messages.size == 2
      end
    end
  end

  private

  def room_params
    params.require(:room_message).permit(:question_title, :content).merge(user_ids: params[:room][:user_ids], game_tag_ids: params[:room][:game_tag_ids], user_id: current_user.id)
  end
end
