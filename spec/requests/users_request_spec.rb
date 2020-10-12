require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'update' do
    example 'リクエストが成功すること' do
      get user_path(@user)
      expect(response.status).to eq 200
    end
  end

  describe 'show' do
    example 'リクエストが成功すること' do
      get user_path(@user)
      expect(response.status).to eq 200
    end
  end

  describe 'following' do
    example 'リクエストが成功すること' do
      get following_user_path(@user)
      expect(response.status).to eq 200
    end
  end

  describe 'followers' do
    example 'リクエストが成功すること' do
      get followers_user_path(@user)
      expect(response.status).to eq 200
    end
  end

  describe 'gift_history' do
    example 'トップページへリダイレクトされること' do
      get gift_history_user_path(@user)
      expect(response).to redirect_to root_path
    end
  end
end
