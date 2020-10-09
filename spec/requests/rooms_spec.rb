require 'rails_helper'

RSpec.describe "RoomsController", type: :request do
  before do
    
    
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    @game_tag = FactoryBot.create(:game_tag)
    @room = FactoryBot.create(:room)
    @entry = FactoryBot.create(:entry)
    @message = FactoryBot.create(:message)
    @another_message = FactoryBot.create(:message)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get root_path
      # binding.pry
      expect(response.status).to eq 200
    end

    it "indexアクションにリクエストするとレスポンスに登録済みの質問のタイトルが存在する" do 
      get root_path
      expect(response.body).to include @room.question_title
    end

    it "indexアクションにリクエストするとレスポンスに質問検索フォームが存在する" do 
      get root_path
      expect(response.body).to include "🔍"
    end
  end
end
