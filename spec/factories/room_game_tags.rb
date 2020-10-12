FactoryBot.define do
  factory :room_game_tag do
    association :room
    association :game_tag
  end
end
