class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
    unless @room.messages.size == 0 # 質問がroomsテーブルに既に存在していて、質問文がmessagesテーブルにある時、entriesテーブルから回答者の情報をインスタンス変数に代入している
      @entries = Entry.where(room_id: @room).where.not(user_id: @room.messages[0].user)
    end
    if @room.messages.size == 0 # 質問する前(正常系)
    elsif @room.messages.size == 1 && @entries[0].user == current_user # 質問が存在し、まだ回答する前かつ、質問者にお願いされた回答者が現在のユーザーと一致する(正常系)
    else # 不適合なユーザーが直接リンクを踏んだ場合、トップページに遷移させる(異常系)
      redirect_to root_path
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to root_path
    else
      @messages = @room.messages.includes(:user)
      redirect_to room_messages_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
