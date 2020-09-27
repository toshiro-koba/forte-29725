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
      expect(@profile.errors.full_messages).to include('User must exist')
    end
  end

  it 'imageの形式がrbだと、保存できない' do
    image_path = File.join(Rails.root, 'spec/fixtures/sample.rb')
    @profile = FactoryBot.build(:profile, image: File.open(image_path))
    expect(@profile).not_to be_valid
  end

  it 'resize to small size' do
    image_path = File.join(Rails.root, 'spec/fixtures/sample.jpg')
    @profile = FactoryBot.create(:profile, image: File.open(image_path))
    expect(@profile.image).to be_no_larger_than(7000, 7000)
    expect(@profile.image.thumb).to be_no_larger_than(200, 200)
    expect(@profile.image.thumb100).to be_no_larger_than(100, 100)
    expect(@profile.image.thumb50).to be_no_larger_than(50, 50)
  end
end
