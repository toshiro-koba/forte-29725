class ProfilesController < ApplicationController
  before_action :check_if_user_signed_in

  def new
    @user = User.find(params[:user_id])
    user = User.find(params[:user_id])
    redirect_to root_path unless current_user == user
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @profile = Profile.find_by(user: current_user)
    @user = User.find(params[:id])
    redirect_to root_path unless current_user == @user
  end

  def update
    @profile = Profile.find_by(user: current_user)
    if @profile.update(edit_profile_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.permit(:link_to_sns, :link_to_webcast, :self_introduction, :image).merge(user_id: current_user.id)
  end

  def edit_profile_params
    params.require(:profile).permit(:link_to_sns, :link_to_webcast, :self_introduction, :image).merge(user_id: current_user.id)
  end

  def check_if_user_signed_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
