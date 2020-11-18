class RoomsController < ApplicationController
  before_action :check_if_user_signed_in,  only: [ :new, :create, :search, :destroy ]

  def index
    if user_signed_in?
      rooms =            Room.preload(:game_tags, messages: :user).all.order('created_at DESC')
      @users =           User.all
      @questions =       Room.questions(current_user, rooms)
      other_questions =  Room.other_questions
      @other_questions = Kaminari.paginate_array(other_questions).page(params[:page]).per(10)
    end

    # 質問フォーム用の変数
    @room = RoomMessage.new
    @message = Message.new
  end

  def new
    @room = RoomMessage.new
  end

  def create
    @room = RoomMessage.new(room_params)
    if @room.valid?
      @room.save
      n = Room.order(updated_at: :desc).limit(1)
      # 各引数の説明。質問者、質問本文、回答者
      n[0].create_notification_comment!(current_user, n[0].messages[0].id, n[0].entries[0].user_id)
      render json: {
                     room:    @room,
                     tag:     GameTag.find(@room.game_tag_ids[0]),
                     user:    User.find(@room.user_id),
                     content: @room.content
                    }
    else
      render json: {
                     title_err:   @room.errors.messages[:question_title][0], 
                     user_err:    @room.errors.messages[:user_ids][0],
                     tag_err:     @room.errors.messages[:game_tag_ids][0],
                     content_err: @room.errors.messages[:content][0]
                    }
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  def search
    @questions =       Room.search(current_user, params[:keyword])
    other_questions =  Room.search_other_questions
    @other_questions = Kaminari.paginate_array(other_questions).page(params[:page]).per(10)
  end

  private

  def room_params
    params.require(:room_message).permit(:question_title, :content).merge(user_ids: params[:room][:user_ids], game_tag_ids: params[:room][:game_tag_ids], user_id: current_user.id)
  end

  def check_if_user_signed_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end