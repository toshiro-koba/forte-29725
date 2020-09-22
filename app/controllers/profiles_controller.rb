class ProfilesController < ApplicationController
  def new; end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def profile_params
    params.permit(:link_to_sns, :link_to_webcast, :self_introduction).merge(user_id: current_user.id)
  end
end
