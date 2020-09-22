FactoryBot.define do
  factory :profile do
    link_to_sns { Faker::Lorem.sentence}
    link_to_webcast {Faker::Lorem.sentence}
    self_introduction {Faker::Lorem.sentence}
    association :user
  end
end
