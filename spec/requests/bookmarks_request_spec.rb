require 'rails_helper'

RSpec.describe 'Bookmarks', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @game_tag = FactoryBot.create(:game_tag)
    @bookmark = FactoryBot.create(:bookmark, user: @user, game_tag: @game_tag)
  end

  describe 'index' do
    example 'トップページへリダイレクトされること' do
      get user_bookmarks_path(@user)
      expect(response).to redirect_to root_path
    end
  end

  describe 'destroy' do
    example 'ユーザー詳細ページへリダイレクトされること' do
      delete user_bookmark_path(@user, @bookmark)
      expect(response).to redirect_to user_path(@user)
    end
  end
end
