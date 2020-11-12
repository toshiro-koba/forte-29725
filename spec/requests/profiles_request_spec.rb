require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user.profile = FactoryBot.create(:profile)
  end

  describe 'new' do
    example 'トップページへリダイレクトされること' do
      get new_user_profile_path(@user)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
