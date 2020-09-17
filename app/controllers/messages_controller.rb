class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)

    @user_ids = []
    @entries = Entry.all
    @entries.each do |entry|
      @user_ids << entry.user_id if entry.room_id == @room.id
    end
    check = 0
    @user_ids.each do |user|
      check += 1 if user == current_user.id
    end
    unless @room.messages.size == 0  # 現在のユーザーが質問に関連してかつ、未回答の場合のみ回答ページに飛ぶ
      if check == 1 && @room.messages.size == 1
        redirect_to root_path if @room.messages[0].user.id == current_user.id
      end
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
