class UsersController < ApplicationController
  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    if user_signed_in?
      @giftings = Gift.where(giver_id: current_user.id).order('created_at DESC')
      @receivings = Gift.where(user_id: current_user.id).order('created_at DESC')
    end
    @profile = Profile.find_by(user: @user)
  end

  def bookmark
    redirect_to root_path unless user_signed_in?
    @user = User.find(params[:id])
    redirect_to root_path unless @user.id == current_user.id
    @bookmarked_games = Bookmark.where(user_id: current_user.id)
    @bookmarked_game_tags = [] # 現在のユーザーがすでにお気に入り登録した(bookmarkの)レコード一覧！！
    @bookmarked_games.each do |tag|
      @bookmarked_game_tags << tag.game_tag.id
    end

    @bookmark = Bookmark.new(bookmark_params)
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
