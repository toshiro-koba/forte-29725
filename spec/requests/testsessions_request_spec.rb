require 'rails_helper'

RSpec.describe 'Testsessions', type: :request do
  before do
    @user = FactoryBot.create(:user, email: 'test_user@test.com')
  end

  describe "update" do
    example "トップページへリダイレクトされること" do
      post testsessions_path
      expect(response).to redirect_to root_path
    end
  end
end
