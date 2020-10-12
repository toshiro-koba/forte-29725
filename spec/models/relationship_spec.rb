require 'rails_helper'

RSpec.describe Relationship, type: :model do

  let(:user) { FactoryBot.create(:user) }
  let(:follow_user) { FactoryBot.create(:user) }
  let(:active) { user.relationships.build(follow_id: follow_user.id) }
  subject { active }

  # フォローが有効であること
  it { should be_valid }

  describe "create"
    it "follow_userがいれば、フォローができること" do
      expect(active.follow). to eq follow_user
    end

    it "followが紐付いていないとフォローできないこと" do
      active.follow = nil
      active.valid?
      expect(active.errors.full_messages).to include("Follow must exist")
    end
end