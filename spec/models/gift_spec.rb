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
        expect(@gift.errors.full_messages).to include("Token can't be blank")
      end
      it 'priceが空では、ギフトできない' do
        @gift.price = ''
        @gift.valid?
        expect(@gift.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが300円未満では、ギフトできない' do
        @gift.price = 299
        @gift.valid?
        expect(@gift.errors.full_messages).to include('Price Out of setting range')
      end

      it 'priceが50,000円超過では、ギフトできない' do
        @gift.price = 50_001
        @gift.valid?
        expect(@gift.errors.full_messages).to include('Price Out of setting range')
      end

      it 'priceは全角数字では、ギフトできない' do
        @gift.price = '３００'
        @gift.valid?
        expect(@gift.errors.full_messages).to include('Price Half-width number')
      end
      it 'priceは英字では、ギフトできない' do
        @gift.price = 'abc'
        @gift.valid?
        expect(@gift.errors.full_messages).to include('Price Half-width number')
      end

      it 'giverが紐付いていないと保存できないこと' do
        @gift.giver = nil
        @gift.valid?
        expect(@gift.errors.full_messages).to include('Giver must exist', "Giver can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @gift.user = nil
        @gift.valid?
        expect(@gift.errors.full_messages).to include('User must exist', "User can't be blank")
      end
    end
  end
end
