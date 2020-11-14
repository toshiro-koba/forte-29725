require 'rails_helper'

RSpec.describe Profile, type: :model do
  include CarrierWave::Test::Matchers
  describe '#create' do
    before do
      @profile = FactoryBot.build(:profile)
    end

    it 'userが紐づいていれば保存できること' do
      expect(@profile).to be_valid
    end

    it '\'link_to_sns\'が空でも保存できること' do
      link_to_sns = nil
      expect(@profile).to be_valid
    end

    it '\'link_to_webcast\'が空でも保存できること' do
      link_to_webcast = nil
      expect(@profile).to be_valid
    end

    it '\'self_introduction\'が空でも保存できること' do
      self_introduction = nil
      expect(@profile).to be_valid
    end

    it 'imageの形式がjpg, jpeg, gif, pngであれば、保存できる' do
      formats = %w[jpg jpeg gif png]
      formats.each do |format|
        image_path = File.join(Rails.root, "spec/fixtures/sample.#{format}")
        @profile = FactoryBot.build(:profile, image: File.open(image_path))
        expect(@profile).to be_valid
      end
    end

    it 'userが紐付いていないと保存できないこと' do
      @profile.user = nil
      @profile.valid?
      expect(@profile.errors.full_messages).to include('ユーザーを入力してください')
    end
  end

  it 'imageの形式がrbだと、保存できない' do
    image_path = File.join(Rails.root, 'spec/fixtures/sample.rb')
    @profile = FactoryBot.build(:profile, image: File.open(image_path))
    expect(@profile).not_to be_valid
  end
end
