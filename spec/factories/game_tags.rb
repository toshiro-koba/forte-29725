FactoryBot.define do
  factory :game_tag do
    game_title { Faker::Team.name }
  end
end
