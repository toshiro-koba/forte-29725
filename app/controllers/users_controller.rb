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
    @room = RoomMessage.new

    @rooms = Room.all.order('created_at DESC')
    @questions = []
    @questions_of_this_user_is_questioner = []
    @questions_related_to_current_user = Entry.where(user_id: @user.id).order('created_at DESC')
    @questions_related_to_current_user.each do |entry|
      @questions << entry.room if entry.room.messages.size == 2 && entry.room.messages[1].user == @user
      @questions_of_this_user_is_questioner << entry.room if entry.room.messages[0].user == @user
    end
    @questions = Kaminari.paginate_array(@questions).page(params[:page]).per(5)
    @questions_of_this_user_is_questioner = Kaminari.paginate_array(@questions_of_this_user_is_questioner).page(params[:page]).per(5)
  end

  def following
    @user = User.find(params[:id])
    @all_following = @user.followings
    @all_following = Kaminari.paginate_array(@all_following).page(params[:page]).per(10)
  end

  def followers
    @user = User.find(params[:id])
    @all_followers = @user.followers
    @all_followers= Kaminari.paginate_array(@all_followers).page(params[:page]).per(10)
  end

  def gift_history
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
    if user_signed_in?
      @giftings = Gift.where(giver_id: current_user.id).page(params[:page]).per(8).order('created_at DESC')
      @receivings = Gift.where(user_id: current_user.id).page(params[:page]).per(8).order('created_at DESC')
      # @receivings は右でも表せる！！→@user.gifts.order('created_at DESC')
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end
end
