class BookmarksController < ApplicationController
  def index
    return redirect_to root_path unless user_signed_in?
    @user = User.find(params[:user_id])
    @profile = Profile.find_by(user: current_user) unless @user.profile.nil?
    redirect_to root_path unless @user == current_user
    @bookmarked_games = Bookmark.games(current_user)
  end

  def new; end

  def create
    @user = User.find(params[:user_id])
    if params[:bookmark].nil?
      redirect_to controller: :bookmarks, action: :index
    else
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.save
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to user_path(@user)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:game_tag_id).merge(user_id: current_user.id)
  end
end
