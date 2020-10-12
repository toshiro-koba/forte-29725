FactoryBot.define do
  factory :like do
    association :user
    association :room
  end
end
