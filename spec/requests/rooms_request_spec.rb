require 'rails_helper'

RSpec.describe 'RoomsController', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @game_tag = FactoryBot.create(:game_tag)
    @room = FactoryBot.create(:room)
    @entry = FactoryBot.create(:entry)
    @message = FactoryBot.create(:message)
    @other_message = FactoryBot.create(:message)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get root_path
      expect(response.status).to eq 200
    end
  end

  describe 'new' do
    example 'トップページへリダイレクトされること' do
      get new_room_path
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'destroy' do
    example 'トップページへリダイレクトされること' do
      delete room_path(@room)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
