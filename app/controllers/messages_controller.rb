class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)

    @user_ids = []
    @entries = Entry.all
    @entries.each do |entry|
      if entry.room_id == @room.id
        @user_ids << entry.user_id
      end
    end
    check = 0
    @user_ids.each do |user|
      if user == current_user.id
        check += 1
      end
    end
    binding.pry
    redirect_to root_path unless check == 1 && @room.messages.size == 1  #現在のユーザーが質問に関連してかつ、未回答の場合のみ回答ページに飛ぶ
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to root_path
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end


