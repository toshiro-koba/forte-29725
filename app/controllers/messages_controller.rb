class MessagesController < ApplicationController
  def new
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.valid?
      @message.save
      n = Room.order(updated_at: :desc).limit(1)
      n[0].create_notification_comment!(current_user, n[0].messages[0].id, n[0].entries[0].user_id)
      render json: {
                     message: @message.content,
                     user:    User.find(@message.user_id)
                    }
    else
      render json: { 
                     content_err: @message.errors[:content][0]
                    }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
