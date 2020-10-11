require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
  end

  # describe "create" do
  #   example "トップページへリダイレクトされること" do
  #     post room_add_path(@room)
  #     expect(response.status).to eq 200
  #   end
  # end

  # describe "destroy" do
  #   example "トップページへリダイレクトされること" do
  #     delete room_add_path(@room)
  #     expect(response.status).to eq 200
  #   end
  # end
end
