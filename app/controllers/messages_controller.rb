class MessagesController < ApplicationController
  def index
    @rooms = Room.all.order('created_at DESC')
  end
end
