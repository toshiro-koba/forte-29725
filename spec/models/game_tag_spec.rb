require 'rails_helper'

RSpec.describe GameTag, type: :model do
  describe '#create' do
    before do
      @game_tag = FactoryBot.build(:game_tag)
    end

    it 'game_titleの値が存在すれば登録できること' do
      expect(@game_tag).to be_valid
    end

    it 'game_titleが空では登録できないこと' do
      @game_tag.game_title = nil
      @game_tag.valid?
      expect(@game_tag.errors.full_messages).to include("Game title can't be blank")
    end
  end
end
