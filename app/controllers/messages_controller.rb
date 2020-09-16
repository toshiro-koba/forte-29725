class MessagesController < ApplicationController
  def index
    @rooms = Room.all.order('created_at DESC')
    @another_questions = []
    if user_signed_in?
      @entries = Entry.all.order('created_at DESC')
      @questions = []
      @question_ids = []
      @rooms.each do |room|
        @entries.each do |entry|
          if entry.room_id == room.id
            if entry.user_id == current_user.id
                @questions << room
                @question_ids << room.id
            end
          end
        end
      end
      @another_question_ids = @rooms.ids - @question_ids
      @rooms.each do |room|
        @another_question_ids.each do |another_question_id|
          if room.id == another_question_id
            @another_questions << room
          end
        end
      end
    else
      @another_questions = @rooms
    end
  end
end
