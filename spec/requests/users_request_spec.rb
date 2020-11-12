require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  before do
    @user = FactoryBot.create(:user)
    # post new_user_session_path, params: { session_form: { email: @user.email, password: @user.password } }
  end

  describe 'update' do
    example 'トップページへリダイレクトされること' do
      get user_path(@user)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'show' do
    example 'トップページへリダイレクトされること' do
      get user_path(@user)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'following' do
    example 'トップページへリダイレクトされること' do
      get following_user_path(@user)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'followers' do
    example 'トップページへリダイレクトされること' do
      get followers_user_path(@user)
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'gift_history' do
    example 'トップページへリダイレクトされること' do
      get gift_history_user_path(@user)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
