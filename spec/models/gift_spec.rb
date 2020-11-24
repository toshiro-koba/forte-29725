require 'rails_helper'

RSpec.describe Gift, type: :model do
  describe 'ギフティング' do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
      @gift = FactoryBot.create(:gift, user: @user, giver: @other_user)
    end
    context 'ギフティングがうまくいくとき' do
      it 'tokenとpriceが存在すれば、購入できる' do
        expect(@gift).to be_valid
      end
    end
    context 'ギフティングがうまくいかないとき' do
      it 'tokenが空では、購入できない' do
        @gift.token = ''
        @gift.valid?
        expect(@gift.errors.full_messages).to include('カード情報を入力してください')
      end
      it 'priceが空では、ギフトできない' do
        @gift.price = ''
        @gift.valid?
        expect(@gift.errors.full_messages).to include('金額を入力してください')
      end

      it 'priceが300円未満では、ギフトできない' do
        @gift.price = 299
        @gift.valid?
        expect(@gift.errors.full_messages).to include('金額が範囲外です')
      end

      it 'priceが50,000円超過では、ギフトできない' do
        @gift.price = 50_001
        @gift.valid?
        expect(@gift.errors.full_messages).to include('金額が範囲外です')
      end

      it 'priceは全角数字では、ギフトできない' do
        @gift.price = '３００'
        @gift.valid?
        expect(@gift.errors.full_messages).to include('金額は半角数字で入力してください')
      end
      it 'priceは英字では、ギフトできない' do
        @gift.price = 'abc'
        @gift.valid?
        expect(@gift.errors.full_messages).to include('金額は半角数字で入力してください')
      end

      it 'giverが紐付いていないと保存できないこと' do
        @gift.giver = nil
        @gift.valid?
        expect(@gift.errors.full_messages).to include('ギフトを受け取る人を入力してください')
      end

      it 'userが紐付いていないと保存できないこと' do
        @gift.user = nil
        @gift.valid?
        expect(@gift.errors.full_messages).to include('ギフトを贈る人を入力してください')
      end
    end
  end
end
