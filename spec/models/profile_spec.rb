require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe '#create' do
    before do
      @profile = FactoryBot.build(:profile)
    end

    it 'userが紐づいていれば保存できること' do
      expect(@profile).to be_valid
    end

    it 'userが紐付いていないと保存できないこと' do
      @profile.user = nil
      @profile.valid?
      expect(@profile.errors.full_messages).to include('User must exist')
    end
  end
end
