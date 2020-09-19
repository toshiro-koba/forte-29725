class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    redirect_to root_path unless user_signed_in?
    @user = User.find(params[:id])
    redirect_to root_path unless @user.id == current_user.id
    @users = User.all

    @all_gifts_in_table = Gift.all

    @giftings = []
    @receivers = []

    @receivings = []
    @givers = []

    @all_gifts_in_table.each do |gift|
      if gift.giver_id == current_user.id
        @giftings << gift
        @receivers << User.find(gift.user_id)
      end
      if gift.user_id == current_user.id
        @receivings << gift
        @givers << User.find(gift.giver_id)
      end
    end
  end

  def bookmark
    redirect_to root_path unless user_signed_in?
    @user = User.find(params[:id])
    redirect_to root_path unless @user.id == current_user.id

    
   
    @bookmark = Bookmark.new(bookmark_params)
    binding.pry
    if @bookmark.save
      redirect_to root_path
    else
      render :bookmark
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def bookmark_params
    params.permit(:game_tag_id).merge(user_id: current_user.id)
  end
end
