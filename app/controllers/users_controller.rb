class UsersController < ApplicationController
  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    if user_signed_in?
      @giftings = Gift.where(giver_id: current_user.id).order('created_at DESC')
      @receivings = Gift.where(user_id: current_user.id).order('created_at DESC')
      # @receivings は右でも表せる！！→@user.gifts.order('created_at DESC')
    end
    @room = RoomMessage.new

    @rooms = Room.all.order('created_at DESC')
    @questions = []
    @questions_related_to_current_user = Entry.where(user_id: @user.id).order('created_at DESC')
    @questions_related_to_current_user.each do |entry|
      @questions << entry.room if entry.room.messages.size == 2
    end
  end

  def following
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end

  def gift_history
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
    if user_signed_in?
      @giftings = Gift.where(giver_id: current_user.id).order('created_at DESC')
      @receivings = Gift.where(user_id: current_user.id).order('created_at DESC')
      # @receivings は右でも表せる！！→@user.gifts.order('created_at DESC')
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end
end
