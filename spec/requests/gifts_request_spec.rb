require 'rails_helper'

RSpec.describe 'Gifts', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    @gift = FactoryBot.create(:gift, user: @user, giver: @another_user)
  end

  # describe "index" do
  #   example "トップページへリダイレクトされること" do
  #     get user_gifts_path(@user)
  #     expect(response).to redirect_to root_path
  #   end
  # end

  # describe "test_gifting" do
  #   example "トップページへリダイレクトされること" do
  #     post testgifting_user_path(@gift)
  #     expect(response).to redirect_to root_path
  #   end
  # end
end
