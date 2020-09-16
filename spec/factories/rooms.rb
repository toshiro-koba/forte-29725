FactoryBot.define do
  factory :room do
    question_title { Faker::Team.name}
  end
end
