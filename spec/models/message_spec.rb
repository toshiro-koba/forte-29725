require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do
    before do
      @message = FactoryBot.build(:message)
    end

    it 'contentが存在していれば保存できること' do
      expect(@message).to be_valid
    end

    it 'contentが存在していれば保存できること' do
      @message.content = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end

    it 'roomが紐付いていないと保存できないこと' do
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Room must exist")
    end

    it 'userが紐付いていないと保存できないこと' do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("User must exist")
    end
  end
end
