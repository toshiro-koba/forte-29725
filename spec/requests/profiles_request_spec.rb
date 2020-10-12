require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @user.profile = FactoryBot.create(:profile)
  end

  describe 'new' do
    example 'トップページへリダイレクトされること' do
      get new_user_profile_path(@user)
      expect(response).to redirect_to root_path
    end
  end

  # describe "create" do
  #   example "トップページへリダイレクトされること" do
  #     post user_profiles_path(@user), params: {user_id: @user.id}
  #     expect(response.status).to eq 200
  #   end
  # end

  # describe "edit" do
  #   example "トップページへリダイレクトされること" do
  #     get edit_user_profile_path(@user, @user.profile)
  #     expect(response).to redirect_to root_path
  #   end
  # end
end
