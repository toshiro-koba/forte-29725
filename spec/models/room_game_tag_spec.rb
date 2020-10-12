require 'rails_helper'

RSpec.describe RoomGameTag, type: :model do
  describe '#create' do
    before do
      @room_game_tag = FactoryBot.build(:room_game_tag)
    end

    it 'roomとgame_tagが紐づいていれば保存できること' do
      expect(@room_game_tag).to be_valid
    end

    it 'roomが紐付いていないと保存できないこと' do
      @room_game_tag.room = nil
      @room_game_tag.valid?
      expect(@room_game_tag.errors.full_messages).to include('Room must exist')
    end

    it 'game_tagが紐付いていないと保存できないこと' do
      @room_game_tag.game_tag = nil
      @room_game_tag.valid?
      expect(@room_game_tag.errors.full_messages).to include('Game tag must exist')
    end
  end
end
