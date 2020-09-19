FactoryBot.define do
  factory :bookmark do
    association :user
    association :game_tag
  end
end
