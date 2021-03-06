require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#create' do
    before do
      @like = FactoryBot.build(:like)
    end

    it 'roomが紐付いていないと保存できないこと' do
      @like.room = nil
      @like.valid?
      expect(@like.errors.full_messages).to include('質問を入力してください')
    end

    it 'userが紐付いていないと保存できないこと' do
      @like.user = nil
      @like.valid?
      expect(@like.errors.full_messages).to include('いいねした人を入力してください')
    end
  end
end
