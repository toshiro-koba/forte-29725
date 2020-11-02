require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe '#create' do
    before do
      @bookmark = FactoryBot.build(:bookmark)
    end

    it 'game_tagとuserが紐づいていれば保存できること' do
      expect(@bookmark).to be_valid
    end

    it 'game_tagが紐付いていないと保存できないこと' do
      @bookmark.game_tag = nil
      @bookmark.valid?
      expect(@bookmark.errors.full_messages).to include('ゲームタグを入力してください')
    end

    it 'userが紐付いていないと保存できないこと' do
      @bookmark.user = nil
      @bookmark.valid?
      expect(@bookmark.errors.full_messages).to include('ユーザーを入力してください')
    end
  end
end
