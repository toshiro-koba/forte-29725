class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:format])
    @messages = @room.messages.includes(:user)
    # 質問がroomsテーブルに既に存在していて、質問文がmessagesテーブルにある時、entriesテーブルから回答者の情報をインスタンス変数に代入している
    unless @room.messages.size == 0
      @entries = Entry.where(room_id: @room).where.not(user_id: @room.messages[0].user)
    end

    # 質問する前(正常系)
    if @room.messages.size == 0
    # 質問が存在し、まだ回答する前かつ、質問者にお願いされた回答者が現在のユーザーと一致する(正常系)
    elsif @room.messages.size == 1 && @entries[0].user == current_user
    # 不適合なユーザーが直接リンクを踏んだ場合、トップページに遷移させる(異常系)
    else
      redirect_to root_path
    end
  end

  def new
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.valid?
      @message.save
      notification_room = Room.order(updated_at: :desc).limit(1)
      notification_room[0].create_notification_comment!(current_user, notification_room[0].messages[0].id, notification_room[0].entries[0].user_id)
      render json: { message: @message.content, user: User.find(@message.user_id) }
    else
      render json: { content_error: @message.errors[:content][0] }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
