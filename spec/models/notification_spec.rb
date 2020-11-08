require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe '通知' do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
      @notification = FactoryBot.create(:notification, visitor_id: @user.id, visited_id: @other_user.id)
    end
    context '通知(message)がうまくいくとき' do
      it 'visitor_id, visited_id, room_id, message_id, action, checkedが存在して且、actionがmessageであれば、通知できる' do
        expect(@notification).to be_valid
      end
    end

    context '通知(like)がうまくいくとき' do
      it 'visitor_id, visited_id, room_id, action, checkedが存在して且、actionがlikeであれば、通知できる' do
        message_id = nil
        action = 'like'
        expect(@notification).to be_valid
      end
    end

    context '通知(follow)がうまくいくとき' do
      it 'visitor_id, visited_id, action, checkedが存在して且、actionがfollowであれば、通知できる' do
        room_id = nil
        message_id = nil
        action = 'follow'
        expect(@notification).to be_valid
      end
    end

    context '通知(gift)がうまくいくとき' do
      it 'visitor_id, visited_id, action, checkedが存在して且、actionがgiftであれば、通知できる' do
        room_id = nil
        message_id = nil
        action = 'gift'
        expect(@notification).to be_valid
      end
    end
  end
end
