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
    @message = Message.new

    @rooms = Room.all.order('created_at DESC')
    @questions = []
    @other_questions = []
    @temporary_questions = Entry.where(user_id: @user.id).order('created_at DESC')
    @temporary_questions.each do |entry|
      @questions << entry.room if entry.room.messages.size == 2 && entry.room.messages[1].user == @user
      @other_questions << entry.room if entry.room.messages[0].user == @user
    end
    @questions = Kaminari.paginate_array(@questions).page(params[:page]).per(5)
    @other_questions = Kaminari.paginate_array(@other_questions).page(params[:page]).per(5)
  end

  def following
    @user = User.find(params[:id])
    @all_following = @user.followings
    @all_following = Kaminari.paginate_array(@all_following).page(params[:page]).per(10)
  end

  def followers
    @user = User.find(params[:id])
    @all_followers = @user.followers
    @all_followers = Kaminari.paginate_array(@all_followers).page(params[:page]).per(10)
  end

  def gift_history
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
    if user_signed_in?
      @giftings = Gift.where(giver_id: current_user.id).page(params[:page]).per(8).order('created_at DESC')
      @receivings = Gift.where(user_id: current_user.id).page(params[:page]).per(8).order('created_at DESC')
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end
end
