require 'rails_helper'

RSpec.describe Gift, type: :model do
  describe 'ギフティング' do
    before do
      @gift = FactoryBot.build(:gift)
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
      it 'priceが空では、購入できない' do
        @gift.price = ''
        @gift.valid?
        expect(@gift.errors.full_messages).to include("Price can't be blank")
      end
      it 'giverが紐付いていないと保存できないこと' do
        @gift.giver = nil
        @gift.valid?
        expect(@gift.errors.full_messages).to include('Giver muast exist')
      end
  
      it 'userが紐付いていないと保存できないこと' do
        @gift.user = nil
        @gift.valid?
        expect(@gift.errors.full_messages).to include('User muast exist')
      end
    end
  end
end
