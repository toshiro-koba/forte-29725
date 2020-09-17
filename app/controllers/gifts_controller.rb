class GiftsController < ApplicationController
  def index
    @reciver = User.find(params[:user_id])
    @gift = Gift.new
  end
end
